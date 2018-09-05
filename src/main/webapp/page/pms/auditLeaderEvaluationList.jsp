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
    <%@ include file="/common/rh_joHead.jsp"%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>领导评价列表</title>
    <script type="text/javascript">
        $(function(){
            joViewInitAboutDoc();//jiView初始化处理
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem.lockStatus = (oItem.lockStatus == 1 ? "<font color='red'>已锁定</font>" : "<font color='green'>未锁定</font>") + "&nbsp;<a href='javascript:changeState(\""+oItem.lockStatus+"\",\""+oItem.id+"\");' title='切换状态'><i class=\"fa fa-exchange\" aria-hidden=\"true\"></i></a>";
        };
        //切换状态
        function changeState(oldState, id){
            var state = oldState == 1 ? 2 : 1;
            jo.postAjax("pms/auditPmsLeaderEvaluation/lockUpdate.action", {"lockStatus":state,"id":id}, function(json){
                if(json && json.code == 0){
                    jo.showMsg("状态切换成功!");
                    joView.reloadCurrentPage();
                }else{
                    jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                }
            });
        }
    </script>

    <script type="text/javascript">
        var userId = jo.getUrlParam("userId");
        $(function(){
            console.log("修改后赋值吗" + userId);
            jo.postAjax("pms/auditPmsUser/getAuditItem.action",{"userId":userId},function (json) {
                console.log("你是一只破该仔222222" + JSON.stringify(json));
                if (json.code == 0) {
                    //获取父页面所有的a标签
                    $("a",parent.document).each(function (i,ele) {
                        $.each(json.data,function (j,arr) {
                            if (i == j){
                                $(ele).next().html("<span style='color:red'>"+ arr +"</span>项待审核new");
                            }
                        });
                    });
                }
            });
        });
    </script>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <%--<form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label">编号：&nbsp;</label>
                    <input type="text" name="id" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">名称：&nbsp;</label>
                    <input type="text" name="name" class="form-control input-sm" value="">
                </div>
                <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
            </form>--%>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
                <div class="form-group button-bar">
                    <button type="button" class="btn btn-sm btn-outline btn-default" onclick="auditChange(1,'')">
                        <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;审核通过
                    </button>
                    <button type="button" class="btn btn-sm btn-outline btn-default" onclick="auditChange(2,'')">
                        <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;审核不通过
                    </button>
                    <button type="button" class="btn btn-sm btn-outline btn-default" onclick="auditChange(3,'')">
                        <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;不审核
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
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="pms/auditPmsLeaderEvaluation/getPage.action" deleteUrl="pms/auditPmsLeaderEvaluation/delete.action" formUrl="page/pms/auditLeaderEvaluationForm.jsp">
                    <col field="leaderEvaluation" title="领导评价" width="25%" align="left" event="click"/>
                    <col field="leaderId" title="领导编号" width="15%" align=""/>
                    <col field="status" title="状态" width="15%" align=""/>
                    <col field="lockStatus" title="锁定状态" width="10%" align=""/>
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
<script>
    //1审核通过2审核不通过3不审核4删除
    function auditChange(status,sIds) {
        var idStr = "";
        if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
            idStr = jo.getCheckBoxValue(joView.params["PKName"]);
        }else{//有传入值
            idStr = sIds;
        }
        if(idStr == ""){
            jo.showMsg("请选择要审核项");
        }else{
            jo.confirm("确定执行该操作？",function () {
                var auditUrl = "pms/auditPmsLeaderEvaluation/batchUpdate.action";
                var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&status=" + status;
                // console.log("auditurl-----" +url);
                jo.postAjax(url,{},function(result){
                    console.log("auditurl-----reuslt" + JSON.stringify(result));
                    if(result.code == 0){
                        jo.showMsg("操作成功！");
                        joView.reloadCurrentPage();//重新加载当前页数据
                        if(typeof (joView.delSuccessOver) == "function"){
                            joView.delSuccessOver(result, idStr);
                        }
                    }else{
                        jo.showMsg(result.info)
                    }
                });
            });
        }
    }

</script>
</body>
</html>

