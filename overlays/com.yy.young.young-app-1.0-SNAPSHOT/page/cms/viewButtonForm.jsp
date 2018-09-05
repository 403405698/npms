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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>视图按钮表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "",//新增
                "deleteUrl" : "cms/viewButton/deleteViewButton.action",//删除
                "updateUrl" : "cms/viewButton/updateViewButton.action",//修改
                "formDataUrl" : "cms/viewButton/getViewButtonById.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        joForm.initFormPageOfAdd = function(){
            var moduleId = jo.getUrlParam("moduleId");
            if(jo.isValid(moduleId)){
                $("#moduleId").val(moduleId);
            }
        };
    </script>
</head>
<body class="padding-15">
<%--按钮栏--%>
<div class="form-group button-bar">
    <%--<button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
    </button>--%>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.update()">
        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.del()">
        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
    </button>
</div>
<%--按钮栏--%>
<form id="pageForm" name="pageForm" action="" method="post">
        <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
            <tr>
                <td width="25%" class="active must">按钮名称</td>
                <td>
                    <input type="hidden" name="id" class="form-control input-sm" readonly>
                    <input type="text" name="name" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>
            <tr>
                <td width="25%" class="active" align="">显示条件</td>
                <td>
                    <textarea type="text" name="display" class="form-control input-sm"></textarea>
                </td>
            </tr>
            <tr>
                <td class="active must">排　　序</td>
                <td>
                    <input type="text" name="num" value="99" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>

        </table>

    </form>
<script type="text/javascript">
    jo.formatUI();
</script>
</body>
</html>
