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

        });
        function test(){
            console.info(jo.form2Json("pageForm"));
            console.info(jo.form2JsonStr("pageForm"));
            console.info(jo.form2ParamStr("pageForm"));
        }
    </script>
</head>
<body style="padding: 20px;">
<input type="button" value="表单转为json数据" onclick="test()"/>
<form id="pageForm" name="pageForm" action="" method="post">
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <%--<table class="joForm"  cellpadding="3" cellspacing="0">--%>
        <tr>
            <td width="15%" class="active" align="">编　　号</td>
            <td class="tnt">
                <%--<input type="text" name="ID"/>--%>
                <input type="text" name="id" class="form-control input-sm readonly-edit" placeholder="应用系统代号" ErrEmpty="应用系统代号不允许为空">
            </td>

            <td width="15%" class="active must">应用名称</td>
            <td>
                <input type="text" name="name" class="form-control input-sm" ErrEmpty>
            </td>
        </tr>
        <tr>
            <td class="active must">首页地址</td>
            <td colspan="3">
                <textarea id="urlIndex" name="urlIndex" class="form-control input-sm">"</textarea>
                <textarea id="urlIndex2" name="urlIndex2" class="form-control input-sm">"</textarea>
            </td>
        </tr>

    </table>
</form>
</body>
</html>
