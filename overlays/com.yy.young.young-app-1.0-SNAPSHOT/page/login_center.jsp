<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script type="text/javascript">
        if(self != top){top.location.href = self.location.href;}
    </script>
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
    <title>系统登录</title>
    <link href="<%=URL_STATIC%>static/css/login.css" rel="stylesheet">
    <script type="text/javascript">
        if(jo.isValid(loginUser)){//已登录则跳转首页
            window.location.href = URL_PORTAL+"page/portal/old_index.jsp";
        }
        //cookie中存储用户名的key
        var COOKIE_ACCOUNT = "account";
        //绑定键盘事件
        document.onkeydown = function(event){
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if(e && e.keyCode==13){//enter
                loginSubmit();
            }
        };
        $(function () {
            if(jo.isValid($.cookie(COOKIE_ACCOUNT))){
                $("#account").val($.cookie(COOKIE_ACCOUNT));//回显账号
                document.getElementById("rememberMe").checked = true;
            }else{
                document.getElementById("rememberMe").checked = false;
            }
        });
        //登录
        function loginSubmit(){
            var account = $("#account").val();
            var password = $("#password").val();
            if(!jo.isValid(account) || !jo.isValid(password)){
                jo.alert("请填写用户名和密码!");
                return;
            }
            jo.showLoading();
            $("#loginBtn").text("正在登录...");
            var redirectTo = jo.getUrlParam("redirectTo");//登录成功后重定向的地址
            jo.postAjax('{URL_UMS}login.action',{"account":account,"password":password,"redirectTo":redirectTo},function(json){
                if(json.code == 1 && json.redirectTo){
                    //登录成功后缓存cookie
                    if(document.getElementById("rememberMe").checked){
                        $.cookie(COOKIE_ACCOUNT, account, { expires: 7 });//有效期7天
                    }else{//当没有勾选记住时,删除cookie
                        $.removeCookie(COOKIE_ACCOUNT);
                    }
                    if(json.redirectTo.indexOf("/") != 0 && json.redirectTo.indexOf("http://") != 0){//相对路径
                        window.location.href = contextPath + json.redirectTo;
                    }else{
                        window.location.href = json.redirectTo;
                    }
                }else{
                    jo.alert(json.info);
                }

            });
            jo.showLoading(false);
            $("#loginBtn").text("登录");
        }
    </script>
    <style>
        html,body{
            width: 100%;
            height: 100%;
            overflow: hidden;
        }
        .loginCss{
            padding:0px;
            margin:0px;
            background-image: url("<%=URL_STATIC%>static/images/moon.jpg");
            background-size: 100% 100%;
            background-repeat: no-repeat;
            width: 100%;
            height: 100%;
        }
        .login-bar-center{ /*登录区域*/
            width: 380px;
            height: 330px;
            float: none;
            display: block;
            background: rgba(255,255,255,0.5);
            padding: 25px;
            box-sizing: border-box;
            border: white solid 1px;
            /*opacity: 0.9;*/
            clear: both;
            margin:125px auto;
            border-radius: 2px;
        }
        .login-title{
            margin:30px auto;
            width: 670px;
            text-align: center;
            color:#FFFFFF;
            font-size: 40px;
            vertical-align: middle;
            font-weight: bold;
            line-height: 50px;
        }
    </style>
</head>
<body class="loginCss">
<div class="container-fluid" style="height: 100%;">
    <%--<div class="row">
        <div class="login-head" style="border: none;">
            &lt;%&ndash;<img src="<%=URL_STATIC%>static/images/login_logo2.png" class="login-logo" style="height: 40px;">&ndash;%&gt;
            &nbsp;&nbsp;&nbsp;
        </div>
    </div>--%>
    <div class="row">
        <div class="col-lg-12">
            <%--<div class="login-title">
                 Young
            </div>--%>
            <div class="login-bar-center">
                <span class="h4"><b>密码登录</b></span>
                <br/><br/>
                <h5 style="color: #73777A;">使用账号密码进行登录</h5>
                <br/>
                <input class="form-control" value="" id="account" name="account" placeholder="用户名" autocomplete="off" type="text">
                <br/><input class="form-control" value="" id="password" name="password" placeholder="登录密码" autocomplete="off" type="password">
                <br/>
                <button type="button" id="loginBtn" class="btn btn-primary" style="width: 100%;" onclick="loginSubmit()">登录</button>
                <div class="hint">
                    <label class="pull-left">
                        <input type="checkbox" id="rememberMe" style="vertical-align: text-bottom;"/>
                        <span style="vertical-align: middle;">记住我</span>
                    </label>
                    <a href="#">忘记密码</a>
                    &nbsp;
                    <a href="#">免费注册</a>
                </div>


            </div>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
