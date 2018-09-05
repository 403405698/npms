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
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>单位用户</title>
    <script type="text/javascript">
        var schemeId = jo.getUrlParam("schemeId");
        if(!schemeId){
            jo.closeSelf();
        }
        $(function(){
            joView.params['condition'] = "COMPANY_ID="+loginUser.companyId;//默认单位选择根节点
            //创建左侧单位树
            createCompanyTree("companyTree",function(event,treeId,treeNode){
                joView.params['condition'] = "COMPANY_ID="+treeNode.ID;
                joView.select();
            });
            joView.init({grid:$("#mainList"), checkStyle:"none"});//初始化页面
        });
        joView.handleItem = function(oItem, iIndex){
            oItem.STATE = (oItem.STATE == 1 ? "<font color='green'>启用</font>" : "<font color='red'>禁用</font>");
            oItem.SEX = oItem.SEX == 1 ? "男" : "女";
        };
        //关联用户
        function relevance(){
            var ids = jo.getCheckBoxValue("ID");
            if(ids){
                jo.postAjax("portal/schemeUser/batchInsertSchemeUser.action", {"schemeId":schemeId, "userIds":ids}, function(json){
                    if(json && json.code == 0){
                        parent.jo.showMsg("关联成功!");
                        parent.loadSchemeUser();
                        jo.closeSelf();
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="ID">编号&nbsp;</label>
                    <input class="form-control input-sm" id="ID" name="ID" placeholder="用户编号" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="NAME">姓名&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="NAME" placeholder="用户姓名" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="SEX">性别&nbsp;</label>
                    <select class="form-control input-sm" id="SEX" name="SEX">
                        <option value=""></option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label" for="STATE">状态&nbsp;</label>
                    <select class="form-control input-sm" id="STATE" name="STATE">
                        <option value=""></option>
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="relevance()">
                    <i class="fa fa-link" aria-hidden="true"></i>&nbsp;关联
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="companyTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <%--grid--%>
            <div class="table-responsive">
                <table id="mainList" class="table table-bordered table-hover table-striped table-condensed" dataUrl="{URL_UMS}ums/user/getUserPage.action"
                       deleteUrl="" formUrl="page/ums/userForm.jsp">
                    <col field="<input type='checkbox' name='ID' value='{ID}'/>" title="<input type='checkbox' onclick='jo.checkAll(&quot;ID&quot;,this)'/>" title="" width="5%" align=""/>
                    <col field="NAME" title="姓名" width="15%" align="center" event=""/>
                   <%-- <col field="ACCOUNT" title="账号" width="10%" align=""/>--%>
                    <col field="BIRTHDAY" title="出生日期" width="10%" align=""/>
                    <col field="SEX" title="性别" width="5%" align=""/>
                    <col field="STATE" title="状态" width="10%" align=""/>
                    <col field="COMPANY_NAME" title="单位名称" width="10%" align=""/>
                    <%--<col field="[=jo.formatTime({C_CREATEDATE})]" title="发布时间" width="15%" align="center"/>--%>
                </table>
            </div>
            <%--/grid--%>

            <%--分页条--%>
            <div class="page-bar" gridId="mainList">

            </div>
            <%--/分页条--%>
        </div>
    </div>
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
