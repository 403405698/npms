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
   <%-- <%@ include file="/common/zTreeHead.jsp"%>--%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>按钮管理</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id"});//初始化页面
        });
        //添加
        function toAppend(){
            var buttonIds = jo.getCheckBoxValue("id");
            if(!jo.isValid(buttonIds)){
                jo.alert("请先勾选待添加的按钮!");
                return;
            }
            var viewId = jo.getUrlParam("viewId");//视图编号
            var formId = jo.getUrlParam("formId");//表单编号
            if(jo.isValid(viewId)){
                jo.postAjax("{URL_CMS}cms/viewButton/batchAddButtonToView.action", {"viewId":viewId,"buttonIds":buttonIds}, function(json){
                    if(json && json.code == "0"){
                        parent.window.viewForm.joView.reloadCurrentPage();//重新视图下的按钮
                        parent.jo.showMsg("添加成功!");
                        jo.closeSelf("APPEND_BUTTON");
                    }
                });
            }else if(jo.isValid(formId)){
                alert("form");
            }else{
                jo.alert("视图编号或表单编号无效!");
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">

   <%-- <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            &lt;%&ndash;按钮栏&ndash;%&gt;
            <div class="form-group button-bar">
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;添加
                </button>

            </div>
            &lt;%&ndash;/按钮栏&ndash;%&gt;
        </div>
    </div>--%>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="name">按钮名&nbsp;</label>
                    <input class="form-control input-sm" id="NAME" name="name" placeholder="按钮名称" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="moduleId">模块&nbsp;</label>
                    <select id="moduleId" name="moduleId" class="joSelect form-control input-sm" data="" firstItem='{"id":"COMMON","name":"公共按钮"}' dataurl="{URL_CMS}cms/module/getModuleList.action" keyfield="id" valuefield="name"></select>
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
                <button isShow="" type="button" class="btn btn-sm btn-success" onclick="toAppend()">
                    <i class="fa fa-check" aria-hidden="true"></i>&nbsp;添加
                </button>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="{URL_CMS}cms/button/getButtonPage.action"
                       deleteUrl="" formUrl="">
                    <col field="name" title="按钮名称" width="15%" align=""/>
                    <col field="click" title="事件" width="35%" align=""/>
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
<br/>
<script type="text/javascript">
    jo.formatUI();
</script>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
