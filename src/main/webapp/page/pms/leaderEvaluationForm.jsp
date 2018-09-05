<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>领导评价表单</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "pms/auditPmsLeaderEvaluation/auditInsert.action",//新增
                    "deleteUrl" : "pms/auditPmsLeaderEvaluation/delete.action",//删除
                    "updateUrl" : "pms/auditPmsLeaderEvaluation/update.action",//修改
                    "formDataUrl" : "pms/pmsLeaderEvaluation/get.action"	//查询
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){
            };
            //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
            joForm.initFormPageOfAdd = function(){
                userIdHandleInAddForm();//userId字段处理
            }
        </script>

</head>
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.save()">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;保存
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.update()">
                    <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-danger" onclick="joForm.del()">
                    <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                </button>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <label class="control-label">领导编号：&nbsp;</label>
                <input type="text"  name="leaderId" class="form-control input-sm" />
                <input type="hidden" id="userId" name="userId" class="form-control input-sm"  />
                <input type="hidden" id="id" name="id" class="form-control input-sm readonly-edit"  />
                <label class="control-label">领导评价：&nbsp;</label>
                <textarea  name="leaderEvaluation" class="form-control input-sm" rows="5"></textarea>
                <%--<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <td width="15%" class="active" align="">领导编号</td>
                        <td class="tnt" colspan="3">
                            <input type="text"  name="leaderId" class="form-control input-sm" />
                            <input type="hidden"  name="id" class="form-control input-sm readonly-edit" />
                            <input type="hidden"  name="userId" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">领导评价</td>
                        <td class="tnt" colspan="3">
                            <textarea  name="leaderEvaluation" class="form-control input-sm" rows="5"></textarea>
                        </td>
                    </tr>
                </table>--%>
            </form>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
