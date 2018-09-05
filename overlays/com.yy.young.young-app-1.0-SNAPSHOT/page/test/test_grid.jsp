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
        $(function(){
            new Grid($("#mainList")).loadData();

        });
    </script>
</head>
<body style="padding: 20px;">
<table class="table table-hover table-condensed" id="mainList" dataUrl="ums/navigate/getNavigatePage.action"
       deleteUrl="ums/navigate/deleteNavigate.action" formUrl="page/ums/navigateForm.jsp">
    <col field="NAME" title="资源名称" width="14%" align="" event="click" order="NAME"/>
    <col field="HREF" title="链接" width="35%" align="left"/>
    <col field="PARENT_NAME" title="父节点" width="10%" align=""/>
    <col field="icon_show" title="图标" width="10%" align=""/>
    <col field="TYPE" title="类型" width="10%" align=""/>
    <col field="NAV_LEVEL" title="层级" width="8%" align=""/>
    <col field="NUM" title="排序" width="8%" align="" order="NUM"/>
</table>
</body>
</html>
