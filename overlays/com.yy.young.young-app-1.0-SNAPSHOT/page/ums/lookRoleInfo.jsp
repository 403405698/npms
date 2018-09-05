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
    <%--日期头--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>查看角色</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "",//新增
                "deleteUrl" : "",//删除
                "updateUrl" : "",//修改
                "formDataUrl" : "ums/role/getRoleList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
            jo.form2Label("pageForm");
        });
    </script>
</head>
<body class="padding-15">
<form id="pageForm" name="pageForm" action="" method="post">
        <table class="table table-bordered dataTables-example dataTable no-footer">
            <tr>
                <td width="20%" class="active" align="">编　　号</td>
                <td class="tnt">
                    <input type="text" name="ID" class="form-control input-sm" ErrLength="32">
                </td>
            </tr>
            <tr>
                <td width="15%" class="active must">角色名称</td>
                <td>
                    <input type="text" name="NAME" class="form-control input-sm" ErrEmpty="角色名称不允许为空">
                </td>
            </tr>
            <tr>
                <td class="active">管理范围</td>
                <td>
                    <input type="text" id="RANGE_NAME" name="RANGE_NAME" class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">角色类型</td>
                <td>
                   <select class="form-control input-sm" id="TYPE" name="TYPE" onchange="roleChange(this.value)">
                       <option value="NORMAL">普通角色</option>
                       <option value="ADMIN">管理员角色</option>
                   </select>
                </td>
            </tr>
            <tr>
                <td class="active must">所属单位</td>
                <td>
                    <input type="text" id="COMPANY_NAME" name="COMPANY_NAME" class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">备　　注</td>
                <td>
                    <input type="text" name="REMARK" class="form-control input-sm">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
