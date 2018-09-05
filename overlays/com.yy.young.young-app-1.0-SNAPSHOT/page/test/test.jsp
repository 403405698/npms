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
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>YOUNG</title>
    <script type="text/javascript">
    function gogogo(){
         var url = $("#url").val();
         var param = $("#param").val();
        if(url){
            $("#result").attr("src",url+"?"+param);
        }
    }
    var SSO_COOKIE_URL = URL_UMS + "token.action";
    jo.postJSONP(SSO_COOKIE_URL, function(json){
        alert(decodeURI(json.token));
    });
    </script>
</head>
<body style="padding: 20px;">
<br/>请求地址:<textarea style="width:calc(100% - 90px);height: 40px;line-height: 40px;" id="url">ums/.action</textarea><br/>
<br/>请求参数:<textarea style="width:calc(100% - 90px);height: 40px;line-height: 40px;" id="param"></textarea>
<button class="btn btn-lg" type="" style="margin:5px;background-color: deepskyblue;" onclick="gogogo()">
    <i class="fa fa-check"></i>发起请求
</button>
<iframe id="result" style="width:100%;height:400px;border: #111111 solid 1px;overflow: auto;" border="0"></iframe>
<script src="static/jquery/jquery-1.10.2.min.js"></script>
</body>
</html>
