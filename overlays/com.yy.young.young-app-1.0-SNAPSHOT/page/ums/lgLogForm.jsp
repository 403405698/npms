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
    <title>模块表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "ums/lgLog/insertLGLog.action",//新增
                "deleteUrl" : "ums/lgLog/deleteLGLog.action",//删除
                "updateUrl" : "ums/lgLog/updateLGLog.action",//修改
                "formDataUrl" : "ums/lgLog/getLGLogById.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
            readonly2Label();
        });
        //初始化表单值之前,格式化时间
        joForm.initFormValueBefore = function(oJson){
            oJson.loginTime = jo.formatTime(oJson.loginTime);
        };
        //将只读属性的表单元素转为文本
        function readonly2Label(){
            var form = $("#pageForm");//表单
            //处理input
            form.find("input[type='text'][readonly]").each(function(idx, ele){
                var val = $(ele).val();
                var label = '<span>'+val+'</span>';
                $(ele).after(label);//在元素后加文本
                jo.remove(ele);//删除元素
            });
            //处理select
            form.find("select[readonly]").each(function(idx, ele){
                var text = ele.options[ele.options.selectedIndex].text;
                var label = '<span>'+text+'</span>';
                $(ele).after(label);
                jo.remove(ele);
            });
            //处理textarea
            form.find("textarea[readonly]").each(function(idx, ele){
                var val = $(ele).val();
                var label = '<span>'+val+'</span>';
                $(ele).after(label);
                jo.remove(ele);
            });
        }
    </script>
</head>
<body class="padding-15">
<%--按钮栏--%>
<div class="form-group button-bar">
   <%-- <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
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
                <td width="15%" class="active must" align="">账　　号</td>
                <td class="tnt">
                    <%--<input type="text" name="ID"/>--%>
                    <input type="text" name="account" class="form-control input-sm" readonly placeholder="登录账号" ErrEmpty="账号不允许为空">
                </td>
            </tr>
            <tr>
                <td width="15%" class="active must">登录时间</td>
                <td>
                    <input type="text" name="loginTime" readonly class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">登录结果</td>
                <td>
                    <select name="result" readonly class="form-control input-sm" disabled="disabled">
                        <option value="1">成功</option>
                        <option value="0">失败</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="active">登 录 IP</td>
                <td>
                    <input type="text" name="clientIp" readonly class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">服务器IP</td>
                <td>
                    <input type="text" name="serverIp" readonly class="form-control input-sm">
                </td>
            </tr>
            <tr>
                <td class="active">备　　注</td>
                <td>
                    <textarea name="remark" readonly class="form-control input-sm"></textarea>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
