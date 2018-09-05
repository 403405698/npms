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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>操作日志</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
        //清空
        function clearAll(){
            jo.confirm("您确定要清空日志(此操作无法恢复)?", function(){
                jo.postAjax("common/operLog/clear.action", {}, function(json){
                    if(json && json.code == 0){
                        jo.showMsg("成功清空日志!");
                        joView.select();
                    }
                });
            });
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
                    <label class="control-label">编　　号：&nbsp;</label>
                    <input type="text" name="id" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">用户编号：&nbsp;</label>
                    <input type="text" name="userId" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">用户名称：&nbsp;</label>
                    <input type="text" name="userName" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">操　　作：&nbsp;</label>
                    <input type="text" name="oper" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">操作时间：&nbsp;</label>
                    <input class="form-control input-sm" name="startTime" onclick="laydate()" placeholder="起始时间" autocomplete="off" type="text">
                    ~ <input class="form-control input-sm" name="endTime" onclick="laydate()" placeholder="截止时间" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label>
                        <input type="checkbox" name="hasException" value="1" style="vertical-align: text-bottom;"/>
                        <span style="vertical-align: middle;">仅异常日志</span>
                    </label>
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
                <%--<button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>--%>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="clearAll()">
                    <i class="fa fa-bolt" aria-hidden="true"></i>&nbsp;清空日志
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
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="common/operLog/getOperLogPage.action" deleteUrl="common/operLog/delete.action" formUrl="page/common/operLogForm.jsp">
                    <col field="oper" title="操作" width="15%" align="left" event="click"/>
                    <col field="url" title="请求地址" width="30%" align="left"/>
                    <col field="[=jo.formatTime('{startTime}')]" title="请求时间" width="15%" align=""/>
                    <col field="userName" title="操作人" width="15%" align=""/>
                    <col field="clientIp" title="客户端IP" width="10%" align=""/>
                    <col field="timeConsuming" title="耗时(毫秒)" width="10%" align="right"/>
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
