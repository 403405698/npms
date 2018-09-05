<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
    <title>xxxx</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "common/administrative/insert.action",//新增
                    "deleteUrl" : "common/administrative/delete.action",//删除
                    "updateUrl" : "common/administrative/update.action",//修改
                    "formDataUrl" : "common/administrative/getAdministrative.action"	//查询
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){
            };
        </script>
</head>
<body class="padding-15">
<%--按钮栏--%>
<div class="form-group button-bar">
    <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
    </button>
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
            <td width="15%" class="active must" align="">主　　键</td>
            <td class="tnt">
                <input type="text"  name="id" class="form-control input-sm readonly-edit" ErrEmpty>
            </td>
            <td width="15%" class="active" align="">行政编码</td>
            <td class="tnt">
                <input type="text"  name="code" class="form-control input-sm">
            </td>
        </tr>
        <tr>
            <td class="active" align="">行政区划名称</td>
            <td class="tnt">
                <input type="text"  name="name" class="form-control input-sm">
            </td>
            <td class="active" align="">上级编码</td>
            <td class="tnt">
                <input type="text"  name="parentId" class="form-control input-sm">
            </td>
        </tr>
        <tr>
            <td class="active" align="">级　　别</td>
            <td class="tnt" colspan="3">
                <%--<input type="text"  name="level" class="form-control input-sm">--%>
                <select name="level" class="form-control input-sm">
                    <option value=""></option>
                    <option value="PROVINCE">省</option>
                    <option value="CITY">市</option>
                    <option value="COUNTY">县</option>
                </select>
            </td>
        </tr>
    </table>
</form>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
