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
                    "addUrl" : "pms/pmsLeaderEvaluation/insert.action",//新增
                    "deleteUrl" : "pms/pmsLeaderEvaluation/delete.action",//删除
                    "updateUrl" : "pms/auditPmsLeaderEvaluation/update.action",//修改
                    "formDataUrl" : "pms/auditPmsLeaderEvaluation/get.action"	//查询
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


        <%--新增：设置不可编辑start--%>
        <script>
            $(function () {
                var elements = document.getElementById("pageForm").elements;
                for (var i=0;i<elements.length;i++) {
                    var e = elements[i];
                    e.setAttribute("readonly",true);
                    e.setAttribute("disabled",true);
                }
            });
        </script>
        <%--新增：设置不可编辑end--%>
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
<script>
    //1审核通过2审核不通过3不审核4删除
    var exist = false;
    function auditChange(status) {
        //新增：将ID和userID的disabled属性移除,防止提交数据为空 start
        $("#userId").removeAttr("disabled");
        $("#id").removeAttr("disabled");
        //新增：将ID和userID的disabled属性移除 end
        var oData = jo.form2Json(joForm.params["formObj"]);
        oData.status = status;
        jo.postAjax("pms/auditPmsLeaderEvaluation/update.action",oData,function (json) {
            // console.log("jsonrela----" +JSON.stringify(json));
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

    //新增到正式库
    function save(sUrl,callBack){
        if (exist == false) {
            sUrl = jo.getDefVal(sUrl,joForm.params["addUrl"]);
        }else {
            sUrl = "pms/relation/update.action";
        }
        if(jo.isValid(sUrl)){

            var oData = jo.form2Json(joForm.params["formObj"]);
            //保存前对表单数据的处理
            if(typeof(joForm.dealDataAtSaveBefore) == "function"){
                joForm.dealDataAtSaveBefore(oData);
            }
            //表单验证
            if(typeof (joForm.checkForm) == "function"){
                if(!joForm.checkForm(joForm.form)){
                    return;
                }
            }else{
                if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                    return;
                }
            }
            jo.postAjax(sUrl,oData, function(result){
                if(result.code == 0){
                    if(typeof(callBack) == "function"){//回调
                        callBack(result);
                    }else if(typeof(joForm.saveSuccessAfter) == "function"){
                        joForm.saveSuccessAfter(result);
                    }else{

                        try{
                            window.parent.reloadCurrentPage();//重新加载父页面数据
                        }catch(err){}
                        if(joForm.params["saveAfter"] == "toEdit"){//保存之后的操作,toEdit表示去编辑
                            if(jo.isValid(oData[joForm.params["PKName"]])){
                                window.location.href = window.location.href+jo.getLinkSign(window.location.href)+joForm.params["PKName"]+"="+oData[joForm.params["PKName"]];
                            }else{
                                jo.closeSelf('WIN_EDIT');
                                //window.parent.jo.close("WIN_ADD");
                            }
                        }else{
                            console.log("关闭自己");
                            // window.parent.jo.close('WIN_EDIT');

                            jo.closeSelf('WIN_EDIT');//关闭自己
                        }
                        // top.jo.showMsg("创建成功!");//提示信息
                        window.parent.jo.showMsg("保存成功!");
                    }
                }else{
                    jo.showMsg(result.info)
                }
            });

        }else{
            jo.showMsg("{addUrl}无效!");
        }
    };
</script>
</body>
</html>
