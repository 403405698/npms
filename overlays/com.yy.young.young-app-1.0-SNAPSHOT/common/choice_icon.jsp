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
<title>按钮选择</title>
<style>
body{overflow:hidden; list-style:none;margin:0px;padding:0px;}
ul{list-style:none;margin:0px;padding:0px;}
.icon_bar{width:100%;height:100%;border:#58AFF7 solid 0px;}
.icon_type{width:100%;height:34px;border-bottom:#58AFF7 solid 1px; background-color: #ffffff;}
.icon_show{width:100%;height:calc(100% - 35px);}
.icon_ul{width:100%;height:100%;overflow-x:hidden;overflow-y:auto;}
.icon_ul::after{content:""; display: block;clear:both;}
.icon_ul li{width:25px;height:25px;line-height:25px;border:rgba(36,61,89,0) solid 1px;float:left;text-align:center;cursor:default;font-size:16px;}
.icon_ul li i{font-size:16px;}
.icon_ul li a{color:#333333;}
.icon_ul li:hover{border:#58AFF7 solid 1px;}
.icon_ul li:active{font-size:20px;}

.joTab{margin:0px;padding:0px;list-style:none;height:32px;line-height:32px;}
.joTab::after{content:""; display: block;clear:both;}
.joTab li{width:auto;height:100%;max-height:35px;float:left;padding:0px 10px;
text-align:center;border:rgba(36,61,89,0) solid 0px;margin:0px 1px;}
.joTab li:hover{border:#58AFF7 solid 0px;border-bottom:red solid 2px;cursor:pointer;border-radius:4px 4px 0px 0px;}
.joTab .cur{border:#58AFF7 solid 0px;border-bottom:red solid 2px;cursor:pointer;border-radius:4px 4px 0px 0px;
background-color: #58AFF7;color:#FFFFFF;}
.joTabSheet{display:none;}
</style>
<script type="text/javascript">
$(function(){
	$(".joTab li").live("click",function(){
		$(".joTab li").removeClass("cur");
		$(this).addClass("cur");
		var sheet = $(this).attr("tab");//对应标签页的id
		$(".joTabSheet").css("display","none");//其他的隐藏
		$("#"+sheet).css("display","block");//选中的显示
	});
	$("#"+$(".joTab .cur").attr("tab")).css("display","block");
	
	$(".fa").click(function(){
		//$("#showIconWord").val($(this).attr("class"));
		if(typeof(parent.jo.iconSelectClick) == "function"){
			var cls = $(this).attr("class");
			cls = cls.replace("fa ","");
			parent.jo.iconSelectClick(cls);
		}
	});
	

})
</script>

</head>
<body>
	
	<div class="icon_bar">
		<div class="icon_type">
			<ul class="joTab" style="padding-top:2px;padding-left:2px;">
				<li tab="tab2" class="cur">功能图标</li>
				<li tab="tab1">箭头图标</li>
				<li tab="tab5">音频图标</li>
				<li tab="tab7">文本编辑</li>
				<li tab="tab3">列表图标</li>
				<li tab="tab6">导航图标</li>
				<li tab="tab4">其他图标</li>
			</ul>
		</div>

		<!-- 箭头 -->
		<div class="icon_show joTabSheet" id="tab1">
			<ul class="icon_ul">
				<li><a class="fa fa-angle-double-down" ></a></li>
				<li><a class="fa fa-angle-double-left" ></a></li>
				<li><a class="fa fa-angle-double-right" ></a></li>
				<li><a class="fa fa-angle-double-up" ></a></li>
				<li><a class="fa fa-angle-down" ></a></li>
				<li><a class="fa fa-angle-left" ></a></li>
				<li><a class="fa fa-angle-right" ></a></li>
				<li><a class="fa fa-angle-up" ></a></li>
				<li><a class="fa fa-arrow-circle-down" ></a></li>
				<li><a class="fa fa-arrow-circle-left" ></a></li>
				<li><a class="fa fa-arrow-circle-o-down" ></a></li>
				<li><a class="fa fa-arrow-circle-o-left" ></a></li>
				<li><a class="fa fa-arrow-circle-o-right" ></a></li>
				<li><a class="fa fa-arrow-circle-o-up" ></a></li>
				<li><a class="fa fa-arrow-circle-right" ></a></li>
				<li><a class="fa fa-arrow-circle-up" ></a></li>
				<li><a class="fa fa-arrow-down" ></a></li>
				<li><a class="fa fa-arrow-left" ></a></li>
				<li><a class="fa fa-arrow-right" ></a></li>
				<li><a class="fa fa-arrow-up" ></a></li>
				<li><a class="fa fa-arrows" ></a></li>
				<li><a class="fa fa-arrows-alt" ></a></li>
				<li><a class="fa fa-arrows-h" ></a></li>
				<li><a class="fa fa-arrows-v" ></a></li>
				<li><a class="fa fa-caret-down" ></a></li>
				<li><a class="fa fa-caret-left" ></a></li>
				<li><a class="fa fa-caret-right" ></a></li>
				<li><a class="fa fa-caret-square-o-down" ></a></li>
				<li><a class="fa fa-caret-square-o-left" ></a></li>
				<li><a class="fa fa-caret-square-o-right" ></a></li>
				<li><a class="fa fa-caret-square-o-up" ></a></li>
				<li><a class="fa fa-caret-up" ></a></li>
				<li><a class="fa fa-chevron-circle-down" ></a></li>
				<li><a class="fa fa-chevron-circle-left" ></a></li>
				<li><a class="fa fa-chevron-circle-right" ></a></li>
				<li><a class="fa fa-chevron-circle-up" ></a></li>
				<li><a class="fa fa-chevron-down" ></a></li>
				<li><a class="fa fa-chevron-left" ></a></li>
				<li><a class="fa fa-chevron-right" ></a></li>
				<li><a class="fa fa-chevron-up" ></a></li>
				<li><a class="fa fa-exchange" ></a></li>
				<li><a class="fa fa-hand-o-down" ></a></li>
				<li><a class="fa fa-hand-o-left" ></a></li>
				<li><a class="fa fa-hand-o-right" ></a></li>
				<li><a class="fa fa-hand-o-up" ></a></li>
				<li><a class="fa fa-long-arrow-down" ></a></li>
				<li><a class="fa fa-long-arrow-left" ></a></li>
				<li><a class="fa fa-long-arrow-right" ></a></li>
				<li><a class="fa fa-long-arrow-up" ></a></li>
				<li><a class="fa fa-toggle-down" ></a></li>
				<li><a class="fa fa-toggle-left" ></a></li>
				<li><a class="fa fa-toggle-right" ></a></li>
				<li><a class="fa fa-toggle-up" ></a></li>

			</ul>
		</div>
		<!-- 功能型 -->
		<div class="icon_show joTabSheet" id="tab2">
			<ul class="icon_ul">
				<li><a title="fa-check-square" class="fa fa-check-square"></a></li>
				<li><a title="fa-check-square-o" class="fa fa-check-square-o"></a></li>
				<li><a title="fa-circle" class="fa fa-circle"></a></li>
				<li><a title="fa-circle-o" class="fa fa-circle-o"></a></li>
				<li><a title="fa-dot-circle-o" class="fa fa-dot-circle-o"></a></li>
				<li><a class="fa fa-minus-square"></a></li>
				<li><a class="fa fa-minus-square-o"></a></li>
				<li><a class="fa fa-plus-square"></a></li>
				<li><a class="fa fa-plus-square-o"></a></li>
				<li><a class="fa fa-square"></a></li>
				<li><a class="fa fa-square-o"></a></li>
				<li><a class="fa fa-area-chart"></a></li>
				<li><a class="fa fa-bar-chart"></a></li>
				<li><a class="fa fa-bar-chart-o"></a></li>
				<li><a class="fa fa-line-chart"></a></li>
				<li><a class="fa fa-pie-chart"></a></li>
			</ul>
		</div>
		<!-- 列表 -->
		<div class="icon_show joTabSheet" id="tab3">
			<ul class="icon_ul">
				<li><a title="icon-list-alt"><i class="icon-list-alt"></i></a></li>

			</ul>
		</div>
		<!-- 音频 -->
		<div class="icon_show joTabSheet" id="tab5">
			<ul class="icon_ul">
				<li><a class="fa fa-arrows-alt" ></a></li>
				<li><a class="fa fa-backward" ></a></li>
				<li><a class="fa fa-compress" ></a></li>
				<li><a class="fa fa-eject" ></a></li>
				<li><a class="fa fa-expand" ></a></li>
				<li><a class="fa fa-fast-backward" ></a></li>
				<li><a class="fa fa-fast-forward" ></a></li>
				<li><a class="fa fa-forward" ></a></li>
				<li><a class="fa fa-pause" ></a></li>
				<li><a class="fa fa-pause-circle" ></a></li>
				<li><a class="fa fa-pause-circle-o" ></a></li>
				<li><a class="fa fa-play" ></a></li>
				<li><a class="fa fa-play-circle" ></a></li>
				<li><a class="fa fa-play-circle-o" ></a></li>
				<li><a class="fa fa-random" ></a></li>
				<li><a class="fa fa-step-backward" ></a></li>
				<li><a class="fa fa-step-forward" ></a></li>
				<li><a class="fa fa-stop" ></a></li>
				<li><a class="fa fa-stop-circle" ></a></li>
				<li><a class="fa fa-stop-circle-o" ></a></li>
				<li><a class="fa fa-youtube-play" ></a></li>

			</ul>
		</div>
		<!-- 导航 -->
		<div class="icon_show joTabSheet" id="tab6">
			<ul class="icon_ul">
				<li><a title="icon-minus-sign-alt"><i class="icon-minus-sign-alt"></i></a></li>

			</ul>
		</div>
		<!-- 文本编辑 -->
		<div class="icon_show joTabSheet" id="tab7">
			<ul class="icon_ul">
				<li><a class="fa fa-align-center" ></a></li>
				<li><a class="fa fa-align-justify" ></a></li>
				<li><a class="fa fa-align-left" ></a></li>
				<li><a class="fa fa-align-right" ></i>
				<li><a class="fa fa-bold" ></a></li>
				<li><a class="fa fa-chain" ></a></li>
				<li><a class="fa fa-chain-broken" ></a></li>
				<li><a class="fa fa-clipboard" ></a></li>
				<li><a class="fa fa-columns" ></a></li>
				<li><a class="fa fa-copy" ></i>
				<li><a class="fa fa-cut" ></a></li>
				<li><a class="fa fa-dedent" ></a></li>
				<li><a class="fa fa-eraser" ></a></li>
				<li><a class="fa fa-file" ></a></li>
				<li><a class="fa fa-file-o" ></a></li>
				<li><a class="fa fa-file-text" ></a></li>
				<li><a class="fa fa-file-text-o" ></a></li>
				<li><a class="fa fa-files-o" ></a></li>
				<li><a class="fa fa-floppy-o" ></a></li>
				<li><a class="fa fa-font" ></a></li>
				<li><a class="fa fa-header" ></a></li>
				<li><a class="fa fa-indent" ></a></li>
				<li><a class="fa fa-italic" ></i>
				<li><a class="fa fa-link" ></a></li>
				<li><a class="fa fa-list" ></a></li>
				<li><a class="fa fa-list-alt" ></a></li>
				<li><a class="fa fa-list-ol" ></a></li>
				<li><a class="fa fa-list-ul" ></a></li>
				<li><a class="fa fa-outdent" ></a></li>
				<li><a class="fa fa-paperclip" ></a></li>
				<li><a class="fa fa-paragraph" ></a></li>
				<li><a class="fa fa-paste" ></a></li>
				<li><a class="fa fa-repeat" ></a></li>
				<li><a class="fa fa-rotate-left" ></a></li>
				<li><a class="fa fa-rotate-right" ></a></li>
				<li><a class="fa fa-save" ></a></li>
				<li><a class="fa fa-scissors" ></a></li>
				<li><a class="fa fa-strikethrough" ></a></li>
				<li><a class="fa fa-subscript" ></a></li>
				<li><a class="fa fa-superscript" ></a></li>
				<li><a class="fa fa-table" ></a></li>
				<li><a class="fa fa-text-height" ></a></li>
				<li><a class="fa fa-text-width" ></a></li>
				<li><a class="fa fa-th" ></a></li>
				<li><a class="fa fa-th-large" ></a></li>
				<li><a class="fa fa-th-list" ></a></li>
				<li><a class="fa fa-underline" ></a></li>
				<li><a class="fa fa-undo" ></a></li>
				<li><a class="fa fa-unlink" ></a></li>

			</ul>
		</div>
		<div class="icon_show joTabSheet" id="tab4">
			<ul class="icon_ul">
				<li><a title="icon-glass"><i class="icon-glass"></i></a></li>

			</ul>
		</div>
	</div>

</body>
</html>