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
    <title>业务表表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "cms/table/insertTable.action",//新增
                "deleteUrl" : "cms/table/deleteTable.action",//删除
                "updateUrl" : "cms/table/updateTable.action",//修改
                "formDataUrl" : "cms/table/getTableList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值之前,格式化时间
        joForm.initFormValueBefore = function(oJson){
            oJson.createTime = jo.formatTime(oJson.createTime);
        };
        //初始化编辑表单后置处理函数
        joForm.initFormValueAfter = function(){
            var info = "创建人：" + joForm.formData.createUser + "&nbsp;&nbsp;&nbsp;&nbsp;单位：" + joForm.formData.companyId + "&nbsp;&nbsp;&nbsp;&nbsp;创建时间：" + joForm.formData.createTime;
            $("#createInfo").html(info);
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
                    <input type="text" name="id" class="form-control input-sm readonly-edit" placeholder="模块编号" ErrEmpty="模块编号不允许为空">
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
                <td class="active">所属业务</td>
                <td>
                    <select name="businessId" class="joSelect form-control input-sm" data="" dataurl="{URL_CMS}cms/business/getBusinessList.action" keyfield="id" valuefield="name"></select>
                </td>
            </tr>
            <tr>
                <td class="active must">排　　序</td>
                <td>
                    <input type="text" name="num" value="99" class="form-control input-sm" ErrEmpty>
                </td>
                <td class="active must">是否主表</td>
                <td>
                    <div class="radio" style="margin: 0px;">
                        <label>
                            <input type="radio" name="master" value="1" checked="checked">是
                        </label>
                        <label>
                            <input type="radio" name="master" value="0">否
                        </label>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="active">备　　注</td>
                <td colspan="3">
                    <input type="text" name="remark" class="form-control input-sm" >
                </td>
            </tr>
           <%-- <tr>
                <td class="active">创建时间</td>
                <td>
                    <input type="text" name="createTime" &lt;%&ndash;onclick="laydate()"&ndash;%&gt; readonly class="form-control input-sm">
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

            </tr>--%>
        </table>
        <p id="createInfo" style="color: red;"></p><%--创建人：JaneYork&nbsp;&nbsp;|&nbsp;&nbsp;单位：ROOT&nbsp;&nbsp;|&nbsp;&nbsp;创建时间：2017-08-14 14:20:01--%>

    </form>
<script type="text/javascript">
    jo.formatUI();
</script>
</body>
</html>
