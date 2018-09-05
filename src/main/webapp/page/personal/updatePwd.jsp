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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--上传插件--%>
    <%@ include file="/common/uploadHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>YOUNG</title>
    <script type="text/javascript">
        $(function () {
        });
        //修改密码
        function updatePassword(){
            if(jo.checkForm($("#updatePwdForm"))){
                var old = $("#old").val();
                var n = $("#new").val();
                var n2 = $("#new2").val();
                if(n != n2){
                    jo.showMsg("两次输入的新密码不一致!");
                    return;
                }
                jo.postAjax("{URL_UMS}ums/user/updatePassword.action", {"oldPwd":old, "newPwd":n}, function(json){
                    if(json && json.code == 0){
                        jo.alert("密码修改成功！");
                        jo.reset("updatePwdForm");
                    }else{
                        jo.alert(json.info);
                    }
                });
            }
        }
    </script>
    <style>
        .config-ul>li{height: 25px;line-height: 25px;}
        .config:hover>.config-ul{display: block;}
        .config-ul>li:hover{background-color: #F3F3F4;}
    </style>
</head>
<body class="padding-20">
<div class="container-fluid" style="padding: 0px;">
    <div class="single-row">
        <div class="col-md-12">
            <div id="updatePwdBox" style="margin: 0px;padding: 0px;">
                <form class="form-horizontal" role="form" id="updatePwdForm">
                    <div class="form-group" style="margin-left: 0px; margin-right: 0px;margin-top: 20px;">
                        <label for="old" class="col-sm-3 control-label">旧密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="old" placeholder="" ErrEmpty="请填写旧密码">
                        </div>
                    </div>
                    <div class="form-group" style="margin-left: 0px; margin-right: 0px;">
                        <label for="new" class="col-sm-3 control-label">新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="new" placeholder="" ErrEmpty="请填写新密码">
                        </div>
                    </div>
                    <div class="form-group" style="margin-left: 0px; margin-right: 0px;">
                        <label for="new2" class="col-sm-3 control-label">重复新密码</label>
                        <div class="col-sm-7">
                            <input type="password" class="form-control" id="new2" placeholder="" ErrEmpty="请重复新密码">
                        </div>
                    </div>
                    <div class="form-group" style="margin-left: 0px; margin-right: 0px;">
                        <label for="new" class="col-sm-3 control-label"></label>
                        <div class="col-sm-7">
                            <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="updatePassword()">
                                <i class="fa fa-check" aria-hidden="true"></i>&nbsp;修改密码
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
