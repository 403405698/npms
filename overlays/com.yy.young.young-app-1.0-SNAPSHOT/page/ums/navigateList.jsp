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
    <title>资源管理</title>
    <script type="text/javascript">
        $(function(){
            //创建左侧资源树
            createNavigateTree("navigateTree",function(event,treeId,treeNode){
                if(treeNode.ID != "ROOT"){
                    joView.setTransferParam("navId="+treeNode.ID+"&navName="+treeNode.NAME+"&navLevel="+treeNode.NAV_LEVEL);
                }else{
                    joView.setTransferParam("");
                }
                joView.params['condition'] = "PARENT_ID="+treeNode.ID;
                joView.select();
            });
            joView.init({grid:$("#mainList")});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem.icon_show = '<i title="'+oItem.ICON+'" class="fa '+oItem.ICON+'" aria-hidden="true"></i>';
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
                    <label class="control-label" for="NAME">资源名称&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="NAME" placeholder="资源名称" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="NAV_LEVEL">资源层级&nbsp;</label>
                    <select class="form-control input-sm" id="NAV_LEVEL" name="NAV_LEVEL">
                        <option value=""></option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
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
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button <%--onmouseover="jo.tips('删除资源的同时会删除权限关系,请慎重!',this,{tips:3});"--%> type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
                <span class="font-red">注意：删除资源的同时会删除权限关系，请慎重！</span>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="navigateTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="ums/navigate/getNavigatePage.action"
                       deleteUrl="ums/navigate/deleteNavigate.action" formUrl="page/ums/navigateForm.jsp">
                    <col field="NAME" title="资源名称" width="14%" align="" event="click"/>
                    <col field="HREF" title="链接" width="35%" align="left"/>
                    <col field="PARENT_NAME" title="父节点" width="10%" align=""/>
                    <col field="icon_show" title="图标" width="10%" align=""/>
                    <col field="TYPE" title="类型" width="10%" align=""/>
                    <col field="NAV_LEVEL" title="层级" width="8%" align=""/>
                    <col field="NUM" title="排序" width="8%" align=""/>
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
