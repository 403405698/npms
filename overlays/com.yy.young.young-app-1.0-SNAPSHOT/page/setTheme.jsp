<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp"%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>YOUNG</title>
    <script type="text/javascript">
        $(function () {

        });
        function choiceTheme(url, bgcolor, obj){
            if($(obj).attr("curStyle") && $(obj).attr("curStyle") == 1){
                console.info("已选择当前风格!");
            }else{
                top.jo.loadCSS(url);
                $(obj).parent().find(">li").css("background", "#ffffff");
                $(obj).parent().find(">li").attr("curStyle", "0");
                $(obj).css("background", bgcolor);
                $(obj).attr("curStyle", "1");
            }
        }
    </script>
    <style>
        .circle-sm li{width: 20px;
            height: 20px;
            -webkit-border-radius: 10px;
            -moz-border-radius: 10px;
            border-radius: 10px;
            list-style: none;
            float: left;
            display: block;
            margin: 5px;
            cursor: pointer;}
        .circle-sm::after{
            content: '';
            display: block;
            clear: both;}
        .circle-default{border: #4E97D9 solid 1px;}
        .circle-brown{border: #8D6658 solid 1px;}
        .circle-green{border: #46BE8A solid 1px;}
        .circle-black{border: #333333 solid 1px;}
        .circle-white{border: #dddddd solid 1px;}
        .circle-yellow{border: #F9CD48 solid 1px;}
        .circle-pink{border: #F96197 solid 1px;}
        .circle-gray{border: #757575 solid 1px;}
        .circle-blue{border: #3EAFE0 solid 1px;}
    </style>
</head>
<body class="padding-20">
主题风格
<ul class="circle-sm">
    <li class="circle-default" onmouseover="jo.tips('默认风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_default.css','#4E97D9',this)"></li>
    <li class="circle-brown" onmouseover="jo.tips('棕色风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_brown.css','#8D6658',this)"></li>
    <li class="circle-green" onmouseover="jo.tips('青色风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_green.css','#46BE8A',this)"></li>
    <li class="circle-yellow" onmouseover="jo.tips('橙色风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_yellow.css','#F9CD48',this)"></li>
    <li class="circle-pink" onmouseover="jo.tips('粉色风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_pink.css','#F96197',this)"></li>
    <li class="circle-gray" onmouseover="jo.tips('灰色风格',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/theme_gray.css','#757575',this)"></li>
</ul>
左边栏样式
<ul class="circle-sm">
    <li class="circle-black" onmouseover="jo.tips('深色',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/left_black.css','#333333',this)"></li>
    <li class="circle-white" onmouseover="jo.tips('浅色',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/left_white.css','#dddddd',this)"></li>
    <li class="circle-blue" onmouseover="jo.tips('蓝色',this,{tips:3})" onmouseout="jo.close()" onclick="choiceTheme(URL_STATIC + 'static/css/theme/left_blue.css','#3EAFE0',this)"></li>
</ul>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
