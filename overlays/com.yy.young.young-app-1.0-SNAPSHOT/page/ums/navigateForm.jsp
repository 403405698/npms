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
    <title>资源管理</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "ID",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "ums/navigate/insertNavigate.action",//新增
                "deleteUrl" : "ums/navigate/deleteNavigate.action",//删除
                "updateUrl" : "ums/navigate/updateNavigate.action",//修改
                "formDataUrl" : "ums/navigate/getNavigateList.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化新增页
        joForm.initFormPageOfAdd = function(){
            $("#PARENT_ID").val(jo.getUrlParam("navId"));
            $("#PARENT_NAME").val(jo.getUrlParam("navName"));
            if(jo.isValid(jo.getUrlParam("navLevel"))){
                $("#NAV_LEVEL").val(parseInt(jo.getUrlParam("navLevel"))+1);
            }
        };
        function setHref(str){
            $('#HREF').val(str);
        }
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
                <td width="15%" class="active" align="">编　　号</td>
                <td>
                    <input type="text" name="ID" class="form-control input-sm readonly-edit">
                   <%-- <input type="text" name="ID"/>--%>
                </td>

                <td width="15%" class="active">名　　称</td>
                <td>
                    <input type="text" name="NAME" class="form-control input-sm">
                    <%--<input type="text" name="NAME"/>--%>
                </td>
            </tr>
            <tr>
                <td class="active">链　　接</td>
                <td colspan="3">
                    <div class="container-fluid" style="margin: 0px;padding: 0px;">
                        <div class="row" style="margin: 0px;padding: 0px;">
                            <div class="col-xs-9" style="margin: 0px;padding: 0px;">
                                <input type="text" name="HREF" class="form-control input-sm col-xs-9" id="HREF">
                            </div>
                            <div class="col-xs-3" style="margin: 0px;padding-right: 0px;">
                                <select class="form-control input-sm col-xs-3" onchange="setHref(this.value)" style="margin: 0px;padding: 0px 5px;">
                                    <option value="">方法提示</option>
                                    <option value="openPageOnMain('http://')">右侧窗口打开</option>
                                    <option value="newWindow('http://')">新窗口打开</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <%--<input type="text" name="HREF"/>--%>
                </td>
            </tr>
            <tr>
                <td class="active">父 节 点</td>
                <td>
                    <div class="input-group">
                        <input type="hidden" id="PARENT_ID" name="PARENT_ID" class="form-control input-sm">
                        <input type="text" id="PARENT_NAME" name="PARENT_NAME" class="form-control input-sm">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceNavigate()">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                   <%-- <input type="hidden" id="PARENT_ID" name="PARENT_ID" style="width:calc(100% - 65px);"/>
                    <input type="text" id="PARENT_NAME" name="PARENT_NAME" style="width:calc(100% - 65px);"/>
                    <input type="button" value="选择" onClick="jo.selectList('{URL_UMS}ums/navigate/getNavigateList.action','PARENT_ID','PARENT_NAME','ID','NAME')"/>
                --%></td>

                <td class="active">图　　标</td>
                <td>
                    <div class="input-group">
                        <input type="text" id="ICON" name="ICON" class="form-control input-sm">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceIcon('ICON')">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                </td>
            </tr>
            <tr>
                <td class="active">类　　型</td>
                <td>
                    <input type="text" name="TYPE" class="form-control input-sm">
                   <%-- <input type="text" name="TYPE"/>--%>
                </td>

                <td class="active">层　　级</td>
                <td>
                    <input type="text" id="NAV_LEVEL" name="NAV_LEVEL" value="1" class="form-control input-sm">
                    <%--<input type="text" id="NAV_LEVEL" name="NAV_LEVEL" value="1"/>--%>
                </td>
            </tr>
            <tr>
                <td class="active">显示顺序</td>
                <td>
                    <input type="text" name="NUM" class="form-control input-sm" value="99">
                    <%--<input type="text" name="NUM" value="99"/>--%>
                </td>
            </tr>
        </table>
    </form>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
