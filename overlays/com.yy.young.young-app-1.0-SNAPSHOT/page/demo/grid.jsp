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
    <title>grid表格demo</title>
    <script type="text/javascript">
        $(function () {
            new Grid($("#mainList"))
            Grid("mainList").loadData();
            Grid("mainList")
        });
        function trHandle(item, idx){
            //console.info(idx + "--" + item.NAME);
        }
    </script>
</head>
<body>
<table id="mainList" class="table table-bordered table-hover table-striped table-condensed" dataUrl="ums/user/getUserPage.action"
       deleteUrl="ums/user/deleteUser.action" formUrl="page/ums/userForm.jsp" trHandle="trHandle">
    <%--<col field="ID" title="编号" width="10%" align="left"/>--%>
    <col field="{NAME}" title="姓名" width="15%" align="center" event="click"/>
    <col field="ACCOUNT" title="账号" width="10%" align=""/>
    <col field="BIRTHDAY" title="出生日期" width="10%" align=""/>
    <col field="SEX" title="性别" width="5%" align=""/>
    <col field="TEL" title="电话" width="10%" align="left"/>
    <col field="EMAIL" title="邮箱" width="20%" align="left"/>
    <col field="COMPANY_NAME" title="单位" width="10%" align=""/>
    <col field="STATE" title="状态" width="10%" align=""/>
    <col field="NUM" title="排序" width="5%" align=""/>
    <%--<col field="[=jo.formatTime({C_CREATEDATE})]" title="发布时间" width="15%" align="center"/>--%>
</table>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
