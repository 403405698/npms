// JavaScript Document
//p开头表示1级目录,c开头表示非1级
var p_close = "fa-caret-right";//[父节点关闭] 图标class
var p_open = "fa-caret-down";//[父节点打开] 图标class
var p_nochild = "fa-angle-right"//[没有子节点]
var c_close = "fa-caret-right";//[关闭子节点] 图标class
var c_open = "fa-caret-down";//[打开子节点] 图标class
var c_nochild = "fa-angle-right";//[不存在子节点] 图标class
var icon_bottom = "fa-list";//底部导航统一图标
var icon_diy = INDEX_NAV_ICON_DIY ? INDEX_NAV_ICON_DIY : "false";//是否开启自定义导航图标,只允许不存在子节点的导航自定义图标
//加载左侧导航
var leftMap = {};
function loadLeftNav(){
	var url = "{URL_PORTAL}portal/getMenu.action";
	jo.postAjax(url, {}, function(result){
		var topNavs = result.data;
		if(topNavs != null && topNavs.length > 0){//有数据
			var _topNavHtml = '';
			for(var i=0;i<topNavs.length;i++){
				if(i==0){
					_topNavHtml += '<li class="nav-left-checked" onclick="loadNavList(\''+topNavs[i].id+'\',\''+topNavs[i].name+'\''+',\''+(topNavs[i].level+1)+'\')"><i class="fa '+topNavs[i].icon+'"></i><span>'+topNavs[i].name+'</span></li>';
				}else{
					_topNavHtml += '<li onclick="loadNavList(\''+topNavs[i].id+'\',\''+topNavs[i].name+'\''+',\''+(topNavs[i].level+1)+'\')"><i class="fa '+topNavs[i].icon+'"></i><span>'+topNavs[i].name+'</span></li>';
				}
				//将一级菜单id和子菜单做映射
				leftMap[topNavs[i].id] = topNavs[i].children;
			}
			$("ul.nav-left-ul").html(_topNavHtml);
			//加载第一个节点的子菜单
			loadNavList(topNavs[0].id,topNavs[0].name,topNavs[0].level+1);
		}else{//无相关数据
			jo.showMsg("加载导航信息失败,请联系系统管理员!");
		}
	});
}
var bottomMap = {};//底部导航id与子菜单的映射
//加载树型导航节点
function loadNavList(parentId,parentName,level){
	//清除底部导航信息
	$("div.nav-bottom").html("");
	var _parenrId = jo.getDefVal(parentId,"");
	var _level = jo.getDefVal(level,1);
	var _parentName = jo.getDefVal(parentName,"");
	var _html = '';
	//更新当前根目录标题 .nav-title
	/*if(jo.isValid(_parenrId)){//parentId有效则 查询该头部导航的信息
		//var res = JY_Ajax(null,"navigate/getNavigateList.action?id="+_parenrId);
		var sUrl = "navigate/getNavigateList.action?id="+_parenrId;
		jo.postAjax(sUrl,{},function(res){
			var info = res.data[0];
			_html = '<i class="fa '+info["icon"]+'"></i> '+info["name"];
			$("div.nav-title").html(_html);
		});
	}else*/{//parentId无效则使用parentName
		_html = '<li class="active"><a href="javascript:" style="text-align:center;border-bottom:#508DEE solid 2px;"><i class="icon-list"></i><span class="menu-text"> '+_parentName+'</span></a></li>';
		_html = '<i class="icon-list"></i> '+_parentName;
		$("div.nav-title").html(_html);
	}
	/*
	 * 加载选中节点下的菜单列表
	 */
	_html = '';
	var _loadMenu = function(menu){
		if(menu != null && menu.length > 0){//有数据
			if(isHasChildAll(menu)){//全部存在子节点,开启底部导航模式
				var btm = '<ul>';
				for(var i=0;i<menu.length;i++){
					var menu1 = menu[i];
					if(i==0){
						btm += '<li class="nav-bottom-checked" onclick="bottomNavClick(\''+menu1.id+'\',3)">';
					}else{
						btm += '<li onclick="bottomNavClick(\''+menu1.id+'\',3)">';
					}
					btm += '<i class="fa '+(icon_diy=="true" ?　menu1.icon　: icon_bottom)+'"></i> ' + menu1.name;
					btm += '</li>';
					//将底部导航id与子菜单做映射,方便点击调用
					bottomMap[menu[i].id] = menu[i].children;
				}
				btm += '</ul>';
				//降低.nav-content区域高度,防止发生底部导航被顶下去
				$(".nav-content").css("height","35px");
				$("div.nav-bottom").html(btm);//插入底部导航html
				//初始化右侧导航(.nav-content区域)高度
				initNavContentHeight();
				//默认加载第一个底部节点子数据
				bottomNavClick(menu[0].id,3);
				return;
			}else{//加载右侧导航列表
				for(var i=0;i<menu.length;i++){
					var menu1 = menu[i];//一级节点
					var menu2 = menu1.children;//子节点
					if(jo.isValid(menu2)){//存在子节点,将子节点输出到该节点后面
						_html += '<li class="hasChild">';
						_html += '<div class="nav-icon"><i class="fa '+(false ?　menu1.icon　 : p_close)+'"></i></div>';
						_html += '<div class="nav-font" onclick="'+menu1.href+'">'+menu1.name+'</div>';
						_html += '</li>';
						//生成子节点导航
						_html += getChildNav(menu2);
					}else{//不存在子节点
						_html += '<li>';
						_html += '<div class="nav-icon"><i class="fa '+ (icon_diy=="true" ?　menu1.icon　: p_nochild) +'"></i></div>';
						_html += '<div class="nav-font" onclick="'+menu1.href+'">'+menu1.name+'</div>';
						_html += '</li>';
						continue;
					}
				}
			}
		}else{
			//没有相关子数据
		}
		initNavContentHeight();//初始化导航高度
		//输出菜单
		$("ul.nav-right-ul").html(_html);
	}
	//直接传入子菜单
	if(parentId){
		_loadMenu(leftMap[parentId]);
	}
	/*var url = "navigate/getMenu.action?navLevel=" + _level+"&parentId="+_parenrId;
	jo.postAjax(url,{},function(result){
		var menu = result.data;
		_loadMenu(menu);
	});*/
	
}
//底部导航点击
function bottomNavClick(parentId,level){
	var _parenrId = jo.getDefVal(parentId,"");
	var _level = jo.getDefVal(level,1);
	/*
	 * 加载选中节点下的菜单列表
	 */
	var _html = '';
	var url = "navigate/getMenu.action?navLevel=" + _level+"&parentId="+_parenrId;
	//实际的加载方法,提出来方便复用
	var _load = function(menu){
		if(menu != null && menu.length > 0){//有子数据
			for(var i=0;i<menu.length;i++){
				var menu1 = menu[i];//一级节点
				var menu2 = menu1.children;//子节点
				if(jo.isValid(menu2)){//存在子节点,将子节点输出到该节点后面
					_html += '<li class="hasChild">';
					_html += '<div class="nav-icon"><i class="fa '+(false ?　menu1.icon　 : p_close)+'"></i></div>';
					_html += '<div class="nav-font" onclick="'+menu1.href+'">'+menu1.name+'</div>';
					_html += '</li>';
					//生成子节点导航
					_html += getChildNav(menu2);
				}else{//不存在子节点
					_html += '<li>';
					_html += '<div class="nav-icon"><i class="fa '+ (icon_diy=="true" ?　menu1.icon　: p_nochild) +'"></i></div>';
					_html += '<div class="nav-font" onclick="'+menu1.href+'">'+menu1.name+'</div>';
					_html += '</li>';
					continue;
				}
			}
		}else{
			//没有相关子数据
		}
		//输出菜单
		initNavContentHeight();//初始化导航高度
		$("ul.nav-right-ul").html(_html);
	}

	if(parentId){
		_load(bottomMap[parentId]);
	}

	/*jo.postAjax(url,{},function(result){
		var menu = result.data;
		_load(menu);
	});*/
}
//判断一级节点(某次查询的一级节点,并非根目录)是否全部带有子节点,若带有,则开启底部导航模式
function isHasChildAll(navs){
	var flag = true;
	try{
		for(var i=0;i<navs.length;i++){
			if(jo.isValid(navs[i].children) && (navs[i].children.length > 0)){//存在子节点
				continue;
			}else{
				flag = false;
				break;
			}
		}
	}catch(err){
		flag = false;
	}
	return flag;
}
//生成子节点html
function getChildNav(navs){
	var _html = '<li class="nav-sub"><ul class="nav-sub-ul">';
	for(var i=0;i<navs.length;i++){
		var nav = navs[i];
		var navChild = nav.children;
		if(jo.isValid(navChild)){//存在子节点,将子节点输出到该节点后面
			_html += '<li class="hasChild">';
			_html += '<div class="nav-icon"><i class="fa '+ (false ?　nav.icon　: c_close)　+'"></i></div>';
			_html += '<div class="nav-font" onclick="'+nav.href+'">'+nav.name+'</div>';
			_html += '</li>';
			//生成子节点导航
			_html += getChildNav(navChild);
		}else{//不存在子节点
			_html += '<li>';
			_html += '<div class="nav-icon"><i class="fa '+ (icon_diy=="true" ?　nav.icon　: c_nochild) +'"></i></div>';
			_html += '<div class="nav-font" onclick="'+nav.href+'">'+nav.name+'</div>';
			_html += '</li>';
			continue;
		}
	}
	_html += '</li></ul>';
	return _html;
}
//导航点击
function navClick(sUrl){
	if(typeof(sUrl) == "string"){
		replaceUrlConstants();
		if(sUrl.indexOf("openPageOnMain(") > -1){
			eval(sUrl);
		}else if(sUrl.indexOf("newWindow(") > -1){
			eval(sUrl);
		}else if(sUrl != "javascript:"){//过滤掉旧版本中a标签无效内容
			//$("iframe[name=main]").css("border","#58AFF7 solid 1px");//iframe的边框D6D6D6
			$("iframe[name=main]").attr("src",sUrl);
		}
	}
}

//生成菜单栏高度
function initNavContentHeight(){
	//console.info($(".navigate-right").innerHeight() +"-"+ $(".nav-title").outerHeight() +"-"+ $(".nav-bottom").outerHeight());
	var h = $(".navigate-right").innerHeight() - $(".nav-title").outerHeight() - $(".nav-bottom").outerHeight();
	$(".nav-content").css("height",h+"px");
}
/*//生产导航节点html代码,只生成li,默认非一级节点,默认没有子节点,即默认图标为c_nochild
function getNavNodeHtml(sName,hasChild,level){
	var _html = '';
	var iconClass = "";//
	if(hasChild){
		iconClass = level == "1" ? p_close : c_close;
	}else{
		iconClass = level == "1" ? p_nochild : c_nochild;
	}
	if(hasChild){
		_html += '<li class="hasChild">';
		_html += '<div class="nav-icon"><i class="'+iconClass+'"></i></div>';
	}else{
		_html += '<li>';
		_html += '<div class="nav-icon"><i class="'+iconClass+'"></i></div>';
	}
	_html += '<div class="nav-font">'+jo.getDefVal(sName,"")+'</div>';
	_html += '</li>';
}*/
//面包屑处理
function initCrumbs(){
	var hash = location.hash;
	if(jo.isValid(hash) && hash.indexOf("#") != -1 && hash.length > 1){
		//TODO
	}
}

$(function(){
	//加载左侧导航
	loadLeftNav();

	//左侧菜单选中样式
	$(document).on("click", ".nav-left-ul li",function(){
		$(".nav-left-ul li").removeClass("nav-left-checked");							
		$(this).addClass("nav-left-checked");
	});
	//选中的导航样式
	$(document).on("click", ".nav-right-ul li:not(.nav-sub)",function(){
		$(".nav-right-ul li").removeClass("nav-checked");							
		$(this).addClass("nav-checked");
	});
	//底部菜单选中样式
	$(document).on("click", ".nav-bottom li",function(){
		$(".nav-bottom li").removeClass("nav-bottom-checked");							
		$(this).addClass("nav-bottom-checked");
	});
	//一级菜单包含字节点的点击事件
	$(document).on("click", ".nav-right-ul>li[class~=hasChild]",function(){
		//子节点显示/隐藏
		$(this).next("li.nav-sub").slideToggle(100);
		//图标切换
		$(this).find(".nav-icon>i").toggleClass(p_close);
		$(this).find(".nav-icon>i").toggleClass(p_open);
		
	});
	
	//非一级菜单包含字节点的点击事件
	$(document).on("click", ".nav-sub-ul>li[class~=hasChild]",function(){
		//子节点显示/隐藏
		$(this).next("li.nav-sub").slideToggle(100);
		//图标切换
		$(this).find(".nav-icon>i").toggleClass(c_close);
		$(this).find(".nav-icon>i").toggleClass(c_open);
	});
	
	//浏览器窗口变化事件
	window.onresize = function(){
		//降低.nav-content区域高度,防止发生底部导航被顶下去
		$(".nav-content").css("height","35px");
		initNavContentHeight();//菜单栏高度随浏览器窗口变化
		
	};
	

	
	//面包屑
	initCrumbs();
	/*
	var mFlag = false;//拖拽开关
	var iLeft = 0;//光标距左
	var iWidth = 0;
	var element = document.getElementById("nav-move-bar");
	var moveObj = document.getElementById("navigate-bar");
	//鼠标按下事件
	element.onmousedown = function(event){
		mFlag = true;//打开开关
		iLeft = event.clientX;
		iWidth = moveObj.clientWidth;
	};
	//鼠标松开停止拖拽
	document.onmouseup = function(event){
		mFlag = false;//关闭开关	
	};
	//鼠标移动时进行拖拽
	element.onmousemove = function(event){
		if(mFlag){//拖拽开关开启时进行拖拽操作,也就是鼠标左键按下不松手进行拖拽
			var newLeft = event.clientX;
			//新宽度=原宽度+变化距离
			iWidth = moveObj.clientWidth + (newLeft - iLeft);
			//更新参数
			iLeft = newLeft;
			//修改位置
			moveObj.style.width = iWidth + "px";
		}	
	};
	//鼠标移出元素,关闭拖拽
	element.onmouseout = function(event){
		mFlag = false;//关闭开关
	};*/
	
});

