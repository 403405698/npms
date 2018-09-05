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
    <title>数据字典生成</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id",checkStyleWidth:"50px"});//初始化页面
        });
        //下载文档
        var flag = true;//下载开关,防止用户连续点击
        function downloadDBExcel(includePlatformTb){
            if(flag){
                flag = false;
                window.setTimeout(function(){
                    flag = true;//10秒后可以继续下载
                }, 10000);
                var ids = jo.getCheckBoxValue("id");
                jo.post("{URL_CMS}cms/db/downloadDBExcel.action", {tableIds:ids, all:includePlatformTb});
            }else{
                console.info("请不要频繁点击!");
            }
        }
    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <p><br/>规则说明：
                <br/>1.勾选需要生成说明文档的数据库表（无勾选项表示下载全部）；
                <br/>2.点击“文档下载”或“文档下载（排除平台表）”即可下载选中表的说明文档；
                <br/>3.若点击“文档下载（排除平台表）”按钮，则除了已选中的平台表，其他的平台表默认不生成说明文档；
            </p>
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="downloadDBExcel(true)">
                    <i class="fa fa-download" aria-hidden="true"></i>&nbsp;文档下载
                </button>
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="downloadDBExcel(false)">
                    <i class="fa fa-download" aria-hidden="true"></i>&nbsp;文档下载（排除平台表）
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="{URL_CMS}cms/db/getTableList.action">
                    <col field="id" title="表" width="40%" align=""/>
                    <col field="name" title="说明" width="55%" align=""/>
                </table>
            </div>
            <%--/grid--%>
        </div>
    </div>
</div>
<br/>
<br/>
<script type="text/javascript">
    jo.formatUI();
</script>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
