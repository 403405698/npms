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
    <title>xxx</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id",formWidth:"1000px",winTitleOfAdd:"新增人员信息",winTitleOfUpdate:"人员信息"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
        //重写新增函数,实现在top打开表单
        joView.add = function(sUrl,sWidth,sHeight,sTitle){
            var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
            if(jo.isValid(sUrl)){
                sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
                top.jo.showWin(sUrl,jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfAdd"]), joView.params["winNameOfAdd"]);
            }
        };
        //重写编辑函数,实现在top打开表单
        joView.edit = function(id,sWidth,sHeight,sTitle){
            if(typeof(joView.clickItem) == "function"){
                joView.clickItem(id,sWidth,sHeight,sTitle);
            }else{
                if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
                    if(typeof(sWidth) == "object"){
                        sWidth = '';
                    }
                    top.jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfUpdate"]), joView.params["winNameOfUpdate"]);
                }
            }
        };
    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label">编号：&nbsp;</label>
                    <input type="text" name="id" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">名称：&nbsp;</label>
                    <input type="text" name="name" class="form-control input-sm" value="">
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
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-primary" onclick="joView.add('page/pms/userAddForm.jsp')">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-danger" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="window.location.reload()">
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
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="pms/pmsUser/getPage.action" deleteUrl="pms/pmsUser/delete.action" formUrl="page/pms/userForm.jsp">
                    <col field="userName" title="用户姓名" width="15%" align="" event="click"/>
                    <col field="oldName" title="曾用名" width="15%" align=""/>
                    <col field="sex" title="性别" width="15%" align=""/>
                    <col field="birth" title="出生年月" width="15%" align=""/>
                    <col field="nation" title="民族" width="15%" align=""/>
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
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
