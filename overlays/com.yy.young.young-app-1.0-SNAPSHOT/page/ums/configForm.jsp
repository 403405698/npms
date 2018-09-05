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
    <title>UMS系统配置表单</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "ums/config/insert.action",//新增
                    "deleteUrl" : "ums/config/delete.action",//删除
                    "updateUrl" : "ums/config/update.action",//修改
                    "formDataUrl" : "ums/config/getConfig.action"	//查询
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
                <input type="text"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
            </td>
            <td width="15%" class="active" align="">显示顺序</td>
            <td class="tnt">
                <input type="text"  name="num" class="form-control input-sm" />
            </td>

        </tr>
        <tr>
            <td width="15%" class="active" align="">k e y</td>
            <td class="tnt">
                <input type="text"  name="key" class="form-control input-sm" />
            </td>
            <td class="active" align="">值</td>
            <td class="tnt">
                <input type="text"  name="value" class="form-control input-sm" />
            </td>

        </tr>
        <tr>
            <td class="active" align="">是否启用</td>
            <td class="tnt">
                <select  name="state" class="form-control input-sm" >
                    <option value=""></option>
                    <option value="1">启用</option>
                    <option value="0">禁用</option>
                </select>
            </td>
            <td class="active" align="">备　　注</td>
            <td class="tnt">
                <input type="text"  name="remark" class="form-control input-sm" />
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
