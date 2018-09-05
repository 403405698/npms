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
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>数据源配置</title>
    <script type="text/javascript">
        $(function(){
            //创建模块树
            cms.createModuleTree("moduleTree",function(event,treeId,treeNode){
                if(treeNode.id){
                    joView.setTransferParam("moduleId="+treeNode.id);
                    joView.putParam("condition", "moduleId="+treeNode.id);
                }else{
                    joView.setTransferParam("");
                    joView.putParam("condition", "");
                }
                joView.select();
            });
            joView.init({grid:$("#mainList"),PKName:"id"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
        joView.add = function(sUrl,sWidth,sHeight,sTitle){
            var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
            if(jo.isValid(sUrl)){
                sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
                jo.showWin(sUrl,jo.getDefVal(sWidth,'800px'),jo.getDefVal(sHeight,'80%'),jo.getDefVal(sTitle,'新增'),'WIN_ADD');
            }
        };
        joView.clickItem = function(id,sWidth,sHeight,sTitle){
            console.log("有效的表单地址");
            console.log("" + jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"]);
            if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
                if(typeof(sWidth) == "object"){
                    sWidth = '';
                }
                jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],'800px','80%','编辑', "WIN_EDIT");
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
                    <label class="control-label" for="name">业务名称&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="name" placeholder="业务名称" autocomplete="off" type="text">
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
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="moduleTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="cms/dataSource/getDataSourcePage.action" deleteUrl="cms/dataSource/delete.action" formUrl="page/cms/dataSourceForm.jsp">
                    <col field="id" title="数据源编号" width="15%" align="" event="click"/>
                    <col field="name" title="数据源名称" width="15%" align=""/>
                    <col field="tableId" title="关联表" width="15%" align=""/>
                    <col field="moduleId" title="所属模块" width="15%" align=""/>
                    <col field="[=jo.formatTime('{updateTime}')]" title="修改时间" width="15%" align=""/>
                    <col field="num" title="显示顺序" width="15%" align=""/>
                    <col field="remark" title="备注" width="15%" align=""/>
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
