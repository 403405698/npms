<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>修改密码</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp"%>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/layui.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/font/font2/iconfont.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/common.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/change-password.css">

    <script src="<%=URL_STATIC%>static/prototype/js/layui.js"></script>
    <script type="text/javascript">
        $(function () {
        });

        function  checkold() {
          var old = $("#old").val();
          if(old != "" || old != null || old != undefined) { // "",null,undefined
              $("#olderror").html("");
              return false;
          }

      }

       function checkPass() {
           var n = $("#new").val();
           var n2 = $("#new2").val();
           if(n != n2){
               $("#difference").html("两次密码输入不一致！");
               return  false;
           }else{
               $("#difference").html("");
               return false;

           }
       }

        //修改密码
        function updatePassword(){
            var old = $("#old").val();
            if(old == "" || old == null || old == undefined) { // "",null,undefined
                $("#olderror").html("请填写旧密码");
                return false;
            }
            if(jo.checkForm($("#updatePwdForm"))){

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
                        // jo.alert(json.info);
                        $("#olderror").html("旧密码输入不正确！");
                        return false;
                    }
                });
            }
        }
    </script>
</head>

<body>
    <div class="container">
        <div class="layui-row">
            <form class="layui-form layui-form-box layui-col-md12 password" role="form" id="updatePwdForm">
                <div class="password-tit clear">
                    <span class="left title">修改密码</span>
                </div>
                <div class="password-content">
                    <div class="layui-form-item">
                        <label class="layui-form-label" for="old">旧密码</label>
                        <div class="layui-input-inline">
                            <input type="password" name="" id="old" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" onmouseout="checkold();">
                            <span class="tipinfo" id="olderror"></span>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"for="new">新密码</label>
                        <div class="layui-input-inline">
                            <input type="password" name="" id="new" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" for="new2">重复密码</label>
                        <div class="layui-input-inline">
                            <input type="password" name="" id="new2" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input"  onmouseout="checkPass();">
                            <span class="tipinfo" id="difference"></span>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label" for="new"></label>
                        <div class="layui-input-inline">
                            <button type="button"  isShow="joForm.isAdd"  class="layui-btn layui-btn-primary change" onclick="updatePassword()">确认修改</button>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"></label>
                        <div class="layui-input-inline">
                            <a href="javascript:;" class="forget">忘记密码？</a>
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label"></label>
                        <div class="layui-input-inline">
                            <div class="forget-box">
                                <i class="bdnuarrow"></i>
                                <div class="forget-box-wrap">
                                    本系统为内部系统，用户登录账号信息由管理员设定开通，如果登录信息遗忘，请联系**部 王某某，电话***。暂不支持自主注册用户，感谢您的支持和谅解。
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>

</div>

        <script>
            $(function() {
                layui.use(['layer', 'form', 'laydate'], function() {
                    var form = layui.form;
                    var layer = layui.layer;
                    var laydate = layui.laydate;
                    // laydate.render({
                    //     elem: '#birthday'
                    // });
                    // laydate.render({
                    //     elem: '#entry'
                    // });
                    // laydate.render({
                    //     elem: '#rudang'
                    // });
                    // laydate.render({
                    //     elem: '#get'
                    // });
                    // laydate.render({
                    //     elem: '#engage'
                    // });
                });
                $(".forget").click(function(event) {
                    event.stopPropagation();
                    $(".forget-box").css("opacity", 1);
                })
                $(document.body).click(function() {
                    $(".forget-box").css("opacity", 0);
                })
            })
        </script>
</body>

</html>