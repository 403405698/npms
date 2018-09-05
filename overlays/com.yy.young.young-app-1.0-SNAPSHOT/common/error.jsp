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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--上传插件--%>
    <%@ include file="/common/uploadHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>错误页面</title>
    <script type="text/javascript">
        $(function () {

        });
        function showDivInfo(){
            var div=document.getElementById('divInfo');
            div.style.display = div.style.display=='none'?'':'none';
        }
    </script>
    <style>
        body{background-color: white;}
        #divCaption {color: gray;}
        #divCaption, #divCaption a{font-size: 16px; font-family:  "微软雅黑";}
    </style>
</head>
<body>
<center>
    <div style="padding-top:100px; padding-bottom:30px;"><img src="<%=URL_STATIC%>static/images/error.png"></div>
    <div id="divCaption">页面出错了，请与管理员联系。 <a href="javascript:void(0);" onclick="showDivInfo();return false;">详细信息</a></div>
</center>
<div id="divInfo" style="text-align:left;display:none; padding:10px;">
    <h3>Debug Information:</h3>
    &nbsp;&nbsp;Requested URL = ${url}<br>
    &nbsp;&nbsp;Exception Msg = ${ex.message}<br>
    <br>
    <strong>Exception Stack Trace:</strong><br>
    <c:forEach items="${ex.stackTrace}" var="ste">
        &nbsp;&nbsp;${ste}<br>
    </c:forEach>
</div>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
