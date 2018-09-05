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
    <title>操作日志表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                "addUrl" : "common/operLog/insert.action",//新增
                "deleteUrl" : "common/operLog/delete.action",//删除
                "updateUrl" : "common/operLog/update.action",//修改
                "formDataUrl" : "common/operLog/getOperLog.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
            oJson.startTime = jo.formatTime(oJson.startTime);
            oJson.endTime = jo.formatTime(oJson.endTime);
        };
        joForm.initFormValueAfter = function(oJson){
            jo.form2Label();
        }
    </script>
</head>
<body class="padding-15">
<%--按钮栏--%>
<div class="form-group button-bar">
    <%--<button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.update()">
        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
    </button>--%>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.del()">
        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
    </button>
</div>
<%--按钮栏--%>
<form id="pageForm" name="pageForm" action="" method="post">
    <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
        <tr>
            <td width="15%" class="active must" align="">编　　号</td>
            <td class="tnt">
                <input type="text"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
            </td>
            <td width="15%" class="active" align="">操　　作</td>
            <td class="tnt">
                <input type="text"  name="oper" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">请求时间</td>
            <td class="tnt">
                <input type="text" onclick="laydate()" name="startTime" class="form-control input-sm" />
            </td>
            <td class="active" align="">完成时间</td>
            <td class="tnt">
                <input type="text" onclick="laydate()" name="endTime" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">用户编号</td>
            <td class="tnt">
                <input type="text"  name="userId" class="form-control input-sm" />
            </td>
            <td class="active" align="">用户名称</td>
            <td class="tnt">
                <input type="text"  name="userName" class="form-control input-sm" />
            </td>
        </tr>

        <tr>
            <td class="active" align="">服务器IP</td>
            <td class="tnt">
                <input type="text"  name="serverIp" class="form-control input-sm" />
            </td>
            <td class="active" align="">客户端IP</td>
            <td class="tnt">
                <input type="text"  name="clientIp" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">浏览器信息</td>
            <td class="tnt" colspan="3">
                <input type="text"  name="clientBrowser" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">请求URL</td>
            <td class="tnt" colspan="3">
                <input type="text"  name="url" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">请求参数</td>
            <td class="tnt" colspan="3" style="word-break: break-all;">
                <input type="text"  name="param" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">返回结果</td>
            <td class="tnt" colspan="3">
                <input type="text"  name="result" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">异常信息</td>
            <td class="tnt" colspan="3">
                <input type="text"  name="exceptionInfo" class="form-control input-sm" />
            </td>
        </tr>
        <tr>
            <td class="active" align="">备　　注</td>
            <td class="tnt" colspan="3" style="word-break: break-all;">
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
