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
    <title>角色管理</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id"});//初始化页面
        });
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="name">应用名称&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="name" placeholder="应用名称" autocomplete="off" type="text">
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
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="{URL_UMS}ums/app/getAppPage.action"
                       deleteUrl="{URL_UMS}ums/app/deleteApp.action" formUrl="page/ums/appForm.jsp">
                    <col field="name" title="应用系统名称" width="20%" align="" event="click"/>
                    <col field="[=jo.formatTime({createTime})]" title="接入时间" width="15%" align=""/>
                    <col field="[=jo.formatTime('{updateTime}')]" title="修改时间" width="15%" align=""/>
                    <col field="urlIndex" title="首页地址" width="35%" align=""/>
                    <col field="num" title="排序" width="10%" align=""/>
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
