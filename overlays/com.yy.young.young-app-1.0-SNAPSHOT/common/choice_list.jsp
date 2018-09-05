<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%--常量--%>
	<%@ include file="/common/constHead.jsp"%>
	<%--jQuery--%>
	<script src="<%=URL_STATIC%>static/plugin/jquery/jquery-1.9.1.js"></script>
	<%--jo--%>
	<%@ include file="/common/joHead.jsp"%>
	<%--bootstrap和字体--%>
	<%@ include file="/common/bootstrapHead.jsp"%>
	<%--layer--%>
	<%@ include file="/common/layerHead.jsp"%>
	<%--日期选择--%>
	<%@ include file="/common/dateHead.jsp"%>
	<%--zTree树--%>
	<%@ include file="/common/zTreeHead.jsp"%>
	<%--公共--%>
	<%@ include file="/common/commonHead.jsp"%>
<title>选择</title>
<script type="text/javascript">
(function(){
	window.joList = {};
	joList.params = {
			"field_id" : "id",
			"field_text" : "text",
			"id" : "id",
			"text" : "text",
			"multiple" : true
	};
	joList.left = new Array();//左侧列表
	joList.right = {};//右侧列表
	joList.init = function(){
		//初始化按钮
		if(joList.params["multiple"]){//多选
			
		}else{//单选,全选按钮失效
			$("#btn_to_right").attr("disabled",true);
			$("#btn_to_right").css("cursor","default");
		}
		//查询数据,初始化左侧待选项
		var sUrl = joList.params["url"];
		if(jo.isValid(sUrl)){
			jo.postAjax(sUrl,{},function(json){
				if(json && json.code == "0"){
					var oList = json.data;
					//生成左侧待选项
					for(var i=0;i<oList.length;i++){
						var info = oList[i];
						joList.addLeft(info);
					}
				}else{
					jo.showMsg("获取列表失败!");
				}
			});
			
		}
		//初始化右侧已选项
		try{
			var ids = parent.$("#"+joList.params["id"]).val();
			var idArr = ids.split(",");
			for(var i=0;i<idArr.length;i++){
				var id = idArr[i];
				var idx = joList.searchItemIdx(id);
				if(idx != -1){//存在该项
					var item = joList.left[idx];
					joList.addRight(idx,item);
				}
			}
		}catch(err){
			jo.showMsg("已选项初始化异常!");	
		}
	};
	//在待选项中搜索某字段为某值的数据项,返回数据的索引
	joList.searchItemIdx = function(val,field){
		field = jo.getDefVal(field,joList.params["field_id"]);//默认搜索id字段
		for(var i=0;i<joList.left.length;i++){
			var item = joList.left[i];
			if(item[field] == val){
				return i;
			}else{
				continue;
			}
		}
		return -1;
	};
	//搜索事件
	joList.lastVal = "";//记录上次搜索事件的值
	joList.result = {};//搜索结果
	joList.searchModal = false;//搜索模式
	joList.search = function(){
		var val = $("#search_inp").val();
		if(jo.isValid(val) && val != joList.lastVal){//有效的搜索,防止发生重复搜索
			joList.lastVal = val;//记录,防止重复
			var field = joList.params["field_text"];//默认搜索显示字段的值
			for(var i=0;i<joList.left.length;i++){
				var item = joList.left[i];
				var tVal = item[field];
				if(tVal.indexOf(val) != -1){//模糊匹配
					joList.result[i] = item;//满足条件的结果存入result
				}else{
					continue;
				}
			}
			//显示查询结果
			$("#allChoiceList ul").html("");
			for(var m in joList.result){
				var t = joList.result[m];
				$("#allChoiceList ul").append("<li index='"+ m +"' onclick='joList.leftClick(this)'>"+t[joList.params["field_text"]]+"</li>");
			}
			//记录当前左侧列表显示模式,是否搜索模式
			joList.searchModal = true;
			joList.result = {};//清空结果表
		}else if(!jo.isValid(val) && joList.searchModal){//当搜索条件为空时,且是搜索模式,则重新生成左侧列表,并切换模式
			//生成左侧待选项
			$("#allChoiceList ul").html("");
			for(var i=0;i<joList.left.length;i++){
				var t = joList.left[i];
				$("#allChoiceList ul").append("<li index='"+ i +"' onclick='joList.leftClick(this)'>"+t[joList.params["field_text"]]+"</li>");
			}
			joList.searchModal = false;
		}else{
			//alert("xxxx"+"--"+val);
		}
	};
	//左侧添加选项
	joList.addLeft = function(oItem){
		var ids = joList.left.push(oItem);
		$("#allChoiceList ul").append("<li index='"+(ids-1)+"' onclick='joList.leftClick(this)'>"+oItem[joList.params["field_text"]]+"</li>");
	};
	//左侧列表点击
	joList.leftClick = function(obj){
		if(joList.params["multiple"] || joList.rightNum() == 0){//多选或当前没有已选项,执行
			var ids = $(obj).attr("index");
			joList.addRight(ids,joList.left[ids]);
		}else if(!joList.params["multiple"] && joList.rightNum() == 1){//单选且已有选项
			joList.backAll();//撤回已选项
			var ids = $(obj).attr("index");
			joList.addRight(ids,joList.left[ids]);
		}
	};
	//获取右侧选项个数
	joList.rightNum = function(){
		var i = 0;
		for(var k in joList.right){
			i++;
		}
		return i;
	};
	//右添加选项
	joList.addRight = function(ids,oItem){
		if(jo.isValid(joList.right[ids])){//存在该数据,不做处理
			
		}else{//不存在该条数据,存入right
			joList.right[ids] = oItem;
			$("#choiceList ul").append("<li index='"+ids+"' onclick='joList.rightClick(this)'>"+oItem[joList.params["field_text"]]+"</li>");
		}
		
	};
	//右侧列表点击
	joList.rightClick = function(obj){
		var ids = $(obj).attr("index");
		//页面去掉该元素,同时right中去掉该条数据
		joList.delRight(obj);
		delete joList.right[ids];//在right对象中删除该数据
	};
	//右侧删除选项
	joList.delRight = function(e){
		jo.remove(e);
	};
	//获取选中的数据某个字段的拼接,逗号链接
	joList.getSelectedVal = function(field){
		var h = "";
		for(var key in joList.right){
			var item = joList.right[key];
			h += "," + item[field];
		}
		return h.substring(1);
	};
	//全选
	joList.checkAll = function(){
		//循环放入右边
		for(var i=0;i<joList.left.length;i++){
			joList.addRight(i,joList.left[i]);
		}
	};
	//全撤回
	joList.backAll = function(){
		//清空右侧元素,清空joList.right对象
		$("#choiceList ul").html("");
		joList.right = {};
	};
	//点击确定
	joList.yes = function(){
		if(typeof(parent.jo.selectListCall) == "function"){
			parent.jo.selectListCall(true, joList.getSelectedVal(joList.params["field_id"]), joList.getSelectedVal(joList.params["field_text"]));
		}else{//默认赋值给对应id的输入框
			if(joList.params["id"]){
				var ids = joList.getSelectedVal(joList.params["field_id"]);
				parent.$("#"+joList.params["id"]).val(ids);
			}
			if(joList.params["text"]){
				var texts = joList.getSelectedVal(joList.params["field_text"]);
				parent.$("#"+joList.params["text"]).val(texts);
			}
			//alert(ids+"\n"+texts);
			parent.jo.Win.close();//关闭
		}
	};
	//点击取消
	joList.no = function(){
		if(typeof(parent.jo.selectListCall) == "function"){
			parent.jo.selectListCall(false, joList.getSelectedVal(joList.params["field_id"]), joList.getSelectedVal(joList.params["field_text"]));
		}else{
			parent.jo.Win.close();
		}
	};
})();
$(function(){
	joList.params = $.extend({},joList.params, parent.jo.selectParams);//合并参数
	joList.init();
});
</script>
<style>
	html,body{
		width: 100%;
		height: 100%;
	}
	.choice-list{
		padding: 5px;
	}
.choice-list li{width:100%;height:25px;line-height:25px; text-indent: 2px;font-size:12px;cursor:default;}
.choice-list li:hover{background-color:#F2F2F2;}
</style>
</head>
<body class="choice-list" style="/*overflow:hidden;*/">
<!-- 搜索框 -->
<div style="width:calc(100% - 2px);height:34px; /*border:#CCCCCC solid 1px;border-bottom:none;*/">
	<div style="width:100%;height:34px;vertical-align: middle;display: table-cell;">
		<%--&nbsp;--%>
		<%--<input id="search_inp" oninput="joList.search()" type="text"/>--%>
		<div class="input-group" style="width: 250px;">
			<input type="text" class="form-control input-sm" id="search_inp" oninput="joList.search()">
			<span class="input-group-btn">
				<button class="btn btn-default btn-sm" type="button" onclick="joList.search()">
					<i class="fa fa-search" aria-hidden="true"></i>&nbsp;搜索
				</button>
			</span>
		</div>
		<%--&nbsp;--%>
		<%--<input id="btn_search" onclick="joList.search()" type="button" value="搜索"/>--%>
	</div>
</div>
<!-- /搜索框 -->

<!-- 列表选择区域 -->
<div class="" style="width:100%;height:calc(100% - 75px);">
	<!-- 左侧待选择列表区 -->
	<div style="float:left;height:100%;width:calc(50% - 22px);">
		<div id="allChoiceList" style="width:calc(100% - 2px);height:calc(100% - 2px); border:#CCCCCC solid 1px;overflow-x:hidden;overflow-y:auto;">
			<ul style="list-style:none;margin:0px;padding:0px;">
				<!-- <li>用户表</li>
				<li>机构表</li>
				<li>权限表</li> -->
			</ul>
		</div>
	</div>
	<!-- /左侧待选择列表区 -->
	
	<!-- 快捷键区 -->
	<div style="float:left;height:100%;width:44px;">
		<div style="width:100%;height:calc(100% - 2px); /*border:#CCCCCC solid; border-width:1px 0px 1px 0px;*/overflow:hidden;">
			<table style="width:100%; height:100%;text-align:center;margin:0px;padding:0px;" cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td>
						<input id="btn_to_right" onclick="joList.checkAll()" type="button" value="&gt;&gt;" style="border:#CCCCCC solid 1px;background-color:#EDEDED; width:auto;cursor:pointer;"/>
						<div style="height:10px;"></div>
						<input id="btn_to_left" onclick="joList.backAll()" type="button" value="&lt;&lt;" style="border:#CCCCCC solid 1px;background-color:#EDEDED; width:auto;cursor:pointer;"/>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<!-- /快捷键区 -->
	
	<!-- 右侧已选择列表区 -->
	<div style="float:left;height:100%;width:calc(50% - 22px);">
		<div id="choiceList" style="width:calc(100% - 2px);height:calc(100% - 2px); border:#CCCCCC solid 1px;overflow-x:hidden;overflow-y:auto;">
			<ul style="list-style:none;margin:0px;padding:0px;">
				<!-- <li>用户表</li>
				<li>机构表</li>
				<li>权限表</li> -->
			</ul>
		</div>
	</div>
	<!-- /右侧已选择列表区 -->
	
	<!-- 清除浮动专用div -->
	<div style="clear:both;"></div>
	<!-- /清除浮动专用div -->
</div>
<!-- /列表选择区域 -->

<!-- 按钮区域 -->
<div style="width:100%;height:40px;">
	<div style="width:calc(100% - 2px);height:calc(100% - 6px);padding-top:5px;text-align:center;/* border:#CCCCCC solid 1px;border-top:none;*/">
		<%--<input type="button" value="确定" onclick="joList.yes()"/>
		&nbsp;&nbsp;
		<input type="button" value="取消" onclick="joList.no()"/>--%>
		<button class="btn btn-default btn-sm" type="button" onclick="joList.yes()"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;确定</button>
			&nbsp;&nbsp;
		<button class="btn btn-default btn-sm" type="button" onclick="joList.no()"><i class="fa fa-close" aria-hidden="true"></i>&nbsp;取消</button>
	</div>
</div>
<!-- /按钮区域 -->

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>