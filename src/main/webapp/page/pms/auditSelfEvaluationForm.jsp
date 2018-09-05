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
    <%--<%@ include file="/common/joHead.jsp"%>--%>
        <link href="<%=URL_STATIC%>static/plugin/jo/joUI.css" rel="stylesheet"/>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo.js"></script>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo-page-view.js"></script>
        <script src="<%=URL_STATIC%>static/newjs/rh_audit_field_form_selfev.js"></script><%--//新增测试单独--%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>自我评价表单</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "pms/pmsSelfEvaluation/insert.action",//新增
                    "deleteUrl" : "pms/pmsSelfEvaluation/delete.action",//删除
                    "updateUrl" : "pms/auditPmsSelfEvaluation/update.action",//修改
                    "formDataUrl" : "pms/pmsSelfEvaluation/get.action"	//查询正式库中
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){
            };
            //表单初始化值的后置处理,在此对formData进行判断,如果没有从后台查到结果(formData为{}),说明应该执行新增
            joForm.initFormValueAfter = function(){
                if(!joForm.formData.id){//新增表单,需要对joForm对象进行校正
                    joFormUpdateToAdd(true);//修改表单转新增表单
                }
            };
        </script>

        <script type="text/javascript">
            var userId = jo.getUrlParam("id");
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
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
                <div class="form-group button-bar">
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="auditChange(1)">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;审核通过
                    </button>
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="auditChange(2)">
                        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;审核不通过
                    </button>
                    <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="auditChange(4)">
                        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                    </button>
                </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <label class="control-label">自我评价：
                    <input type="checkbox" name="" status="" lockStatus="">&nbsp;
                </label>
                <textarea  name="selfEvaluation" class="form-control input-sm" rows="5"></textarea>
                <input type="hidden"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
                <input type="hidden"  name="userId" class="form-control input-sm" />
                <%--<table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <td width="15%" class="active" align="">自我评价</td>
                        <td class="tnt" colspan="3">
                            <textarea  name="selfEvaluation" class="form-control input-sm" ></textarea>
                            <input type="hidden"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
                            <input type="hidden"  name="userId" class="form-control input-sm" />
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
<script>
    //1审核通过2审核不通过3不审核4删除
    var exist = false;
    function auditChange(status) {
        var oData = jo.form2Json(joForm.params["formObj"]);
        oData.status = status;
        jo.postAjax("pms/auditPmsSelfEvaluation/updateSingle.action",oData,function (json) {
            console.log("jsonrela----" +JSON.stringify(json));
            if (json.code == 0) {
                // console.log("22关闭222自己");
                try{
                    // console.log("重新加载父页面")
                    // top.main.joView.reloadCurrentPage();
                    window.parent.reloadCurrentPage();//重新加载父页面数据
                }catch(err){}
                // console.log("关闭222自己");
                // window.parent.jo.close('WIN_EDIT');
                jo.closeSelf('WIN_EDIT');
                window.parent.jo.showMsg("操作成功!");
            }
        });
    }

</script>
</body>
</html>
