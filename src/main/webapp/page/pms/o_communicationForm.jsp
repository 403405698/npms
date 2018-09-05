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
        <script src="<%=URL_STATIC%>static/newjs/audit_field_form_commu.js"></script>
        <%--//新增测试单独--%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>xxxx</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    // "addUrl" : "pms/communication/insert.action",//新增
                    "addUrl" : "pms/auditRecordCommunication/userUpdate.action",//新增
                    "deleteUrl" : "pms/communication/delete.action",//删除
                    "updateUrl" : "pms/auditRecordCommunication/userUpdate.action",//修改
                    // "updateUrl" : "pms/communication/update.action",//修改
                    "formDataUrl" : "pms/communication/get.action"	//查询
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){

            };
            //表单初始化值的后置处理,在此对formData进行判断,如果没有从后台查到结果(formData为{}),说明应该执行新增
            joForm.initFormValueAfter = function(){
                console.log("担担粉：" + joForm.formData.id + (!joForm.formData.id == true) + "皮皮长：" + (!joForm.formData.id));
                if(!joForm.formData.id){//新增表单,需要对joForm对象进行校正
                    joFormUpdateToAdd(true);//修改表单转新增表单
                }
            };
            //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
            joForm.initFormPageOfAdd = function(){
                userIdHandleInAddForm();//userId字段处理
            }
            //修改成功回调
            joForm.updateSuccessAfter = function () {
                top.jo.showMsg("修改成功!请耐心等待审核！");//提示信息
                if (top.main.joView.inited) {
                    top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();//刷新当前页面
                } else {
                    location.reload();
                }
            };
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
                <%--<button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-danger" onclick="joForm.del()">
                    <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                </button>--%>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <caption>个人通讯信息：</caption>
                    <tr>
                        <td width="15%" class="active" align="">办公电话</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="officePhone" class="form-control input-sm" />
                                <input type="hidden"  name="userId" class="form-control input-sm" />
                                <input type="hidden"  name="id" class="form-control input-sm readonly-edit" ErrEmpty />
                            </div>

                        </td>
                        <td width="15%" class="active" align="">手 机 号</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="mobilePhone" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">传 真 号</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="faxNumber" class="form-control input-sm" />

                            </div>
                        </td>
                        <td class="active" align="">邮箱地址</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emailAddress" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">通讯地址</td>
                        <td class="tnt" colspan="3">
                            <div class="input-group">
                                <input type="text"  name="postalAddress" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <caption>紧急联系人一：</caption>
                    <tr>
                        <td width="15%" class="active" align="">关 系</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="relationshipOne" class="form-control input-sm" />

                            </div>
                        </td>

                        <td width="15%" class="active" align="">姓名</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="nameOne" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">联系电话</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emergencyContactOne" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <caption>紧急联系人二：</caption>
                    <tr>
                        <td width="15%" class="active" align="">关 系</td>
                        <td class="tnt" colspan="">
                            <div class="input-group">
                                <input type="text"  name="relationshipTwo" class="form-control input-sm" />

                            </div>
                        </td>
                        <td width="15%" class="active" align="">姓名</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="nameTwo" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" class="active" align="">联系电话</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emergencyContactTwo" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
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
