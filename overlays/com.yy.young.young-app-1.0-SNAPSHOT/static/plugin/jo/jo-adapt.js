/**
 * jo-adapt.js
 * jo自适应处理
 * 在此处对jo的一些方法进行重写/补充,以适应最新的前端需求
 * 一定要放在jo后面进行加载
 * 改动:
 * 1.弹窗/层使用layer:
 * 	图标:icon,offset:坐标,
 * 	area:宽高,skin:样式,
 * 	content:内容,
 * 	title:标题,
 * 	time:显示时间,
 * 	btn:按钮,
 * 	type:层类型0-4,
 * 	btnAlign:按钮对齐方式l/r/c,
 * 	closeBtn:1/2,0表示不显示,
 * 	shade:遮罩,0表示没有遮罩,
 * 	anim:弹出动画,0-6,-1表示没有动画,
 * 	isOutAnim:关闭动画,默认true,
 * 	maxmin:最大化最小化,默认false,
 * 	fixed:固定,默认true,
 * 	resize:是否允许拉伸,默认true,
 * 	resizing:拉伸回调,
 * 	scrollbar:是否允许浏览器出现滚动条,默认true,
 * 	maxWidth:最大宽度,默认360,
 * 	zIndex:层叠顺序,默认19891014,
 * 	move:触发拖拽的元素,默认为标题,
 * 	tips:tips方向和颜色,1-4表示上右下左,定制颜色使用[方向,'颜色'],
 * 	tipsMore:是否允许多个tips,
 * 	success:弹出层后的成功回调,
 * 	yes:确定按钮回调,
 * 	cancel:关闭回调,不想关闭则return false
 *
 */
(function(){
	/**
	 * 弹出层
	 * @param dialogElement 可以是html,也可以是jq对象
	 * @param sWinName 弹层名字
	 * @param hasShade 是否有遮罩,true or false
	 */
	jo.showDialog = function(dialogElement,sWinName,hasShade,options){
		if(!jo.isValid(options)){
			options = {};
		}
		if(!jo.isValid(options.area)){
			options.area = ['400px','300px'];//默认宽高
		}
		if(typeof (options.maxmin) == "undefined"){//默认启用最大/小化
			options.maxmin = true;
		}
		options.type = 1;
		options.content = dialogElement;//这里content是一个DOM(也可以是html)，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响
		options.name = sWinName;
		if(typeof (hasShade) == "boolean" && !hasShade){
			options.shade = 0;
		}
		var index = layer.open(options);
		jo.WinMemory.set(index, sWinName);//记录
		return index;
	};
	//[Attr] 弹窗辅助对象
	jo.WinMemory = {
		wins : new Array()
		,set : function(iIndex,sName){
			console.info("记录弹窗记忆:index="+iIndex+",name="+sName);
			jo.WinMemory.wins.push({index:iIndex,name:sName});
		}
		,get : function(sName){
			if(jo.isValid(sName) && typeof (sName) == "string"){
				//倒序遍历弹窗记录,防止因为手动点击关闭造成的旧记录影响后来的同name窗口
				for(var i=jo.WinMemory.wins.length;i>0;i--){
					if(jo.isValid(jo.WinMemory.wins[i-1])){
						var item = jo.WinMemory.wins[i-1];
						if(sName == item.name){//匹配窗口名称
							console.info("通过窗口name="+sName+"取到弹窗索引,index="+item.index);
							return item.index;
						}
					}
				}
			}else{//默认取最后一个"有效"窗口的索引
				for(var i=jo.WinMemory.wins.length;i>0;i--){
					if(jo.isValid(jo.WinMemory.wins[i-1])){
						var item = jo.WinMemory.wins[i-1];
						console.info("通过取最新记忆取到弹窗索引,index="+item.index);
						return item.index;
					}
				}
			}
			return null;
		}
		,remove : function(iIndex){
			for(var i=0;i<jo.WinMemory.wins.length;i++){
				if(jo.isValid(jo.WinMemory.wins[i])){
					if(iIndex == jo.WinMemory.wins[i].index){//匹配弹窗索引
						console.info("移除索引为"+iIndex+"的弹窗记忆!");
						jo.WinMemory.wins[i] = null;//赋值为null
					}
				}
			}
		}
	};
	/**
	 * 弹窗(iframe)
	 * @param sUrl 页面url,当该参数为object类型时,表示layer.open的参数
	 * @param sWidth 宽
	 * @param sHeight 高
	 * @param sTitle 标题
	 * @param sWinName 弹窗名字
	 * @param isFull 是否最大化
	 * @param hasShade 有无遮罩,true or false
	 */
	jo.showWin = function(sUrl,sWidth,sHeight,sTitle,sWinName,isFull,hasShade){
		var index;
		if(typeof (sUrl) == "object"){
			if(typeof (sUrl.maxmin) == "undefined"){//默认启用最大/小化
				sUrl.maxmin = true;
			}
			sUrl.type = 2;
			if(jo.isValid(sUrl.content)){
				sUrl.content = jo.parseUrl(sUrl.content);
			}
			console.log("URLOBJ--" + JSON.stringify(sUrl));
			index = layer.open(sUrl);
			jo.WinMemory.set(index, sUrl.name);//记录
		}else{
			var options = {};
			if(typeof (options.maxmin) == "undefined"){//默认启用最大/小化
				options.maxmin = true;
			}
			options.type = 2;
			options.content = jo.parseUrl(sUrl);//这里content是一个URL，如果你不想让iframe出现滚动条，你还可以content: ['http://sentsin.com',
			options.name = sWinName;
			options.title = sTitle;
			if(typeof (hasShade) == "boolean" && !hasShade){
				options.shade = 0;
			}
			if(jo.isValid(sWidth) && jo.isValid(sHeight)){
				options.area = [sWidth,sHeight];
			}
			console.log("LAYOPT--" + JSON.stringify(options));
			index = layer.open(options);
			//最大化
			if(jo.isValid(isFull)){
				layer.full(index);
			}
			jo.WinMemory.set(index, sWinName);//记录
		}
		return index;
	};
	/**
	 * 获取layer弹窗的iframe对象
	 * @param index
	 */
	jo.getLayerIframe = function(index){
		return  window['layui-layer-iframe' + index];
	};
	/**
	 * [Func] confirm选择框,参数会自动向左合并,即当options为function时表示该参数为yesCall
	 * @param sMsg
	 * @param yesCall
	 * @param noCall
	 * @param options
	 * @returns {*}
	 */
	jo.confirm = function(sMsg, options, yesCall, noCall){
		if(typeof (options) == "function"){

		}else{
			if(!jo.isValid(options)){
				options = {};
			}
			if(!jo.isValid(options.icon)){
				options.icon = 3;//默认图标为问号
			}
		}
		return layer.confirm(sMsg, options, yesCall, noCall);
	};
	/**
	 * [Func] 消息提示,参数2为function时,表示为结束回调
	 * @param sMsg
	 * @param options
	 * @param endCall
	 * @returns {*}
	 */
	jo.showMsg = function(sMsg, options, endCall){
		return layer.msg(sMsg, options, endCall);
	};
	/**
	 * [Func] 加载提示
	 * @param msgOrClose
	 * @returns {*}
	 */
	jo.showLoading = function(msgOrClose){
		if(typeof (msgOrClose) == "boolean" && !msgOrClose){
			return jo.close(window.loadIndex);//关闭
		}
		window.loadIndex = layer.load(1);//记录加载索引,关闭时调用
		return window.loadIndex;
	};
	/**
	 * [Func] alert提示,回调带参数index
	 * @param sMsg
	 * @param options
	 * @param yesCall
	 * @returns {*}
	 */
	jo.alert = function(sMsg, options, yesCall){
		if(!jo.isValid(options)){
			options = {};
		}
		if(!jo.isValid(options.icon)){
			options.icon = 0;//默认图标为信息
		}
		return layer.alert(sMsg, options, yesCall);
	};
	/**
	 * [Func] tips提示
	 * @param sMsg 提示内容
	 * @param element 绑定元素,jq对象或者选择器都可以
	 * @param options 可选参数
	 * @returns {*}
	 */
	jo.tips = function(sMsg, element, options){
		return layer.tips(sMsg, element, options);
	};
	/**
	 * 输入层
	 * @param options
	 * @param yesCall 成功回调,包含3个参数value, index, elem
	 */
	jo.prompt = function(options, yesCall){
		layer.prompt(options, yesCall);
	};
	/**
	 * 相册层,图片查看器
	 * @param options json数据或者是图片的父容器选择器,json需要固定的格式,具体参考官方文档
	 * @param tabCall 切换图片的回调
	 */
	jo.photos = function(jsonOrSelector, tabCall){
		var options = {
			photos: jsonOrSelector //json或者是图片的父容器选择器
			,anim: 5 //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数）
			,tab: tabCall //tabCall(pic, layero)
		}
		layer.photos(options);
	};
	/**
	 * 关闭layer弹窗,默认关闭最新窗口
	 * @param index
	 */
	jo.close = function(index){
		if(jo.isValid(index) && typeof (index) == "number"){//参数为弹窗索引时,直接执行关闭
			layer.close(index);
		}else{//没有传入索引时,通过创建的jo.WinMemory工具来获取待关闭窗口
			index = jo.WinMemory.get(index);
			if(typeof (index) == "number"){//当成功取到时执行关闭
				layer.close(index);
			}else{//辅助工具都没有取到的话,使用layer.index来得到当前layer的最新窗口索引
				index = layer.index
				layer.close(index);
			}
		}
		jo.WinMemory.remove(index);//移除辅助工具中对应索引的记录
	};
	/**
	 * 在弹窗内部调用,关闭弹窗自身
	 * @param index 窗口索引或者弹窗name
	 */
	jo.closeSelf = function(index){
		/*if(typeof (index) == "string"){
			index = parent.layer.getFrameIndex(index); //先得到当前iframe层的索引
		}*/
		window.parent.jo.close(index); //再执行关闭
	};
	/**
	 * 关闭所有弹窗
	 * @param sType 弹窗类型,dialog:信息窗,page:页面层,iframe:iframe层,loading:加载层,tips:tips层
	 */
	jo.closeAll = function(sType){
		layer.closeAll(sType);
	};
	/**
	 * 重写joWin的关闭方法
	 * @param sWinName 弹窗名字或索引
	 */
	jo.Win.close = function(sWinName){
		if(typeof (sWinName) == "string"){
			sWinName = layer.getFrameIndex(sWinName); //先得到当前iframe层的索引
		}
		jo.close(sWinName);
	};


	/**
	 * 重写jo的url地址常量替换
	 * @param sUrl
	 * @returns {string|*}
	 */
	jo.parseUrl = function(sUrl){
		if(typeof (replaceUrlConstants) == "function"){
			return replaceUrlConstants(sUrl);
		}
		return jo.getCode(sUrl,jo.getDefVal(SYSURL, jo.address));
	};

	/**
	 * 文件上传
	 * 基于web uploader插件实现
	 * @param sUrl 文件上传地址
	 * @param callback 文件上传回调,参数1是boolean类型,代表是否上传成功,参数2是file对象,参数3是后台返回结果
	 * @param oParams 详细配置项,参考webuploader官方api
	 */
	jo.uploadFile = function(sUrl, callback, oParams){
		if(typeof (uploadFile) == "function"){
			uploadFile(sUrl, callback, oParams);
		}else{
			console.info("没有名为uploadFile的方法实现(该方法来自于uploadHead引用),请检查是否存在此方法或js加载顺序是否正常!");
		}
	};
	/**
	 * 关闭文件上传窗口
	 */
	jo.closeUploadDialog = function(){
		jo.close("uploadWin");
	};
})();