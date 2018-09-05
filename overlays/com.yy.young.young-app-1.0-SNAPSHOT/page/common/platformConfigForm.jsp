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
    <title>平台参数配置表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "common/platformConfig/insertConfig.action",//新增
                "deleteUrl" : "common/platformConfig/deleteConfig.action",//删除
                "updateUrl" : "common/platformConfig/updateConfig.action",//修改
                "formDataUrl" : "common/platformConfig/getConfigList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        joForm.initFormPageOfAdd = function(){
            var prefix = jo.getUrlParam("prefix");
            if(jo.isValid(prefix)){
                document.getElementsByName("CKEY")[0].value = prefix;
                $("#info").html("域名配置项的KEY必须以URL_开头");
            }
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
<p class="font-red" id="info"></p>
<%--按钮栏--%>
<form id="pageForm" name="pageForm" action="" method="post">
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
    <%--<table class="joForm"  cellpadding="3" cellspacing="0">--%>
        <tr>
            <td width="25%" class="active must" align="">KEY</td>
            <td class="tnt">
                <input type="hidden" name="ID" class="form-control input-sm">
                <input type="text" name="CKEY" class="form-control input-sm readonly-edit" ErrEmpty="key不允许为空">
            </td>
        </tr>
        <tr>
            <td width="25%" class="active must">VALUE</td>
            <td>
                <input type="text" name="CVALUE" class="form-control input-sm" ErrEmpty="配置值不允许为空">
            </td>
        </tr>
        <tr>
            <td class="active">分　　组</td>
            <td>
                <input type="text" name="CATEGORY" value="" class="form-control input-sm">
            </td>
        </tr>
        <tr>
            <td class="active">备　　注</td>
            <td>
                <input type="text" name="REMARK" class="form-control input-sm">
            </td>
        </tr>
        <tr>
            <td class="active">排　　序</td>
            <td>
                <input type="text" name="NUM" value="99" class="form-control input-sm">
            </td>
        </tr>

    </table>
</form>
</body>
</html>
