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
    <title>单位信息</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "",//新增
                "deleteUrl" : "",//删除
                "updateUrl" : "",//修改
                "formDataUrl" : "ums/dept/getDeptList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
            jo.form2Label("pageForm");
        });
    </script>
</head>
<body class="padding-15">
<form id="pageForm" name="pageForm" action="" method="post">
        <table class="table table-bordered  dataTables-example dataTable no-footer">
            <tr>
                <td width="15%" class="active" align="">编　　号</td>
                <td class="tnt">
                    <input type="text" name="ID" class="form-control input-sm" placeholder="编号为空时将使用系统默认值">
                </td>

                <td width="15%" class="active must">部门名称</td>
                <td>
                    <input type="text" name="NAME" class="form-control input-sm" ErrEmpty onchange="setShortName(this.value)">
                </td>
            </tr>
            <tr>
                <td class="active must">部门简称</td>
                <td>
                    <input type="text" id="SHORT_NAME" name="SHORT_NAME" class="form-control input-sm" ErrEmpty>
                </td>
                <td class="active must">上级部门</td>
                <td>
                    <input type="text" id="PARENT_NAME" name="PARENT_NAME" class="form-control input-sm">
                </td>

            </tr>
            <tr>
                <td class="active">类　　型</td>
                <td>
                    <select class="form-control input-sm" name="TYPE">
                        <option value="DEPT">部门</option>
                        <option value="COMPANY">单位</option>
                        <option value="OTHER">其他</option>
                    </select>
                </td>
                <td class="active must">部门层级</td>
                <td>
                    <input type="text" id="DEPT_LEVEL" name="DEPT_LEVEL" value="1" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>

            <tr>
                <td class="active">编号全路径</td>
                <td>
                    <input type="text" name="WHOLE_ID" readonly class="form-control input-sm">
                </td>
                <td class="active">名称全路径</td>
                <td>
                    <input type="text" name="WHOLE_NAME" readonly class="form-control input-sm">
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
