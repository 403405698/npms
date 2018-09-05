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
    <%--日期头--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>查看用户信息</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "",//新增
                "deleteUrl" : "",//删除
                "updateUrl" : "",//修改
                "formDataUrl" : "ums/user/getUserList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //表单页初始化后置处理
        joForm.initFormValueAfter = function(){
            jo.form2Label("pageForm");
        }
    </script>
</head>
<body class="padding-15">

<form id="pageForm" name="pageForm" action="" method="post">
        <table class="table table-bordered dataTables-example dataTable no-footer">
            <tr>
                <td width="20%" class="active">姓　　名</td>
                <td>
                    <input type="text" name="NAME" class="form-control input-sm" ErrEmpty="姓名不允许为空">
                </td>
            </tr>
            <tr>
                <td class="active">所属单位</td>
                <td>
                    <input type="text" id="COMPANY_NAME" name="COMPANY_NAME" class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">出生日期</td>
                <td>
                    <input type="text" name="BIRTHDAY" class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">邮　　箱</td>
                <td>
                    <input type="text" name="EMAIL" class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">性　　别</td>
                <td>
                    <select name="SEX" class="form-control input-sm">
                        <option value=""></option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="active">电　　话</td>
                <td>
                    <input type="text" name="TEL" ErrLength="11" ErrNumber="电话必须是数字类型" class="form-control input-sm">
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
