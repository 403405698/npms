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
    <title>业务表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "cms/business/insertBusiness.action",//新增
                "deleteUrl" : "cms/business/deleteBusiness.action",//删除
                "updateUrl" : "cms/business/updateBusiness.action",//修改
                "formDataUrl" : "cms/business/getBusinessList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值之前,格式化时间
        joForm.initFormValueBefore = function(oJson){
            oJson.createTime = jo.formatTime(oJson.createTime);
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
        <%--<table class="joForm"  cellpadding="3" cellspacing="0">--%>
            <tr>
                <td width="15%" class="active must" align="">编　　号</td>
                <td class="tnt">
                    <%--<input type="text" name="ID"/>--%>
                    <input type="text" name="id" class="form-control input-sm readonly-edit" placeholder="业务编号" ErrEmpty="业务编号不允许为空">
                </td>

                <td width="15%" class="active must">业务名称</td>
                <td>
                    <input type="text" name="name" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>
            <tr>
                <td class="active">所属模块</td>
                <td>
                    <select name="moduleId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/module/getModuleList.action" keyfield="id" valuefield="name"></select>
                </td>
                <td class="active">备　　注</td>
                <td>
                    <input type="text" name="remark" class="form-control input-sm" >
                </td>
            </tr>
            <tr>
                <td class="active">创建时间</td>
                <td>
                    <input type="text" name="createTime" <%--onclick="laydate()"--%> readonly class="form-control input-sm">
                </td>
                <td class="active">创 建 人</td>
                <td>
                    <input type="text" name="createUser"  readonly class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">单位编号</td>
                <td>
                    <input type="text" name="companyId" readonly class="form-control input-sm">
                </td>
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
