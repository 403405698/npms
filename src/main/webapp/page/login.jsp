<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <script type="text/javascript">
        if(self != top){top.location.href = self.location.href;}
    </script>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <title>系统登录</title>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/style.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/newlogin/css/login.css">

    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">
    <script src="<%=URL_STATIC%>static/jquery/jquery-1.9.1.js"></script>
    <script src="<%=URL_STATIC%>static/jquery/jquery.cookie.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/jo.js"></script>


    <script type="text/javascript">
        // console.log("jo.isValid(loginUser)" + jo.isValid(loginUser));
        if(jo.isValid(loginUser)){//已登录则跳转首页
            alert(URL_PORTAL);
            window.location.href = URL_PORTAL+"page/portal/index.jsp";
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

        //获得焦点
        function inputOnfocus(key){
            $("#" + key).hide();
        }
        //登录
        function loginSubmit(){
            var account = $("#account").val();
            var password = $("#password").val();
            var user_tip = $("#user_tip");
            var pwd_tip = $("#pwd_tip");
            if(account == "" && password == ""){
                pwd_tip.show();
                user_tip.show();
                return;
            }
            if(!jo.isValid(account)){
                user_tip.show();
                return;
            }
            if(!jo.isValid(password)){
                pwd_tip.show();
                return;
            }
            var redirectTo = jo.getUrlParam("redirectTo");//登录成功后重定向的地址
            jo.postAjax('<%=basePath%>login.action',{"account":account,"password":password,"redirectTo":redirectTo},function(json){
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
                    $("#pwd_tip").text(json.info);
                    $("#pwd_tip").show();
                }
            });

        }
    </script>
</head>

<body>
<div class="container-fluid">
    <div class="header clear">
      <%--  <div class="left">
            <img src="<%=URL_STATIC%>static/newlogin/image/logo.jpg" alt="">
            <h2>中国环境科学研究院人事档案管理系统</h2>
        </div>--%>
        <div class="right">
            <a href="<%=URL_PORTAL%>static/aboutUs.jsp">关于我们</a>
        </div>
    </div>

    <div class="content">
        <div class="login-box">
            <div class="tit">
                系统登录
            </div>
            <form class="form-horizontal" name="submit_form">
                <div class="form-group">
                    <label class="col-lg-3 control-label user-label" for="account">用户名</label>
                    <div class="col-lg-7 user-txt">
                        <input name="user" type="text" class="form-control"  id="account" onfocus="inputOnfocus('user_tip')" placeholder="请输入用户名" required />
                        <span class="tipinfo" ng-show="submit_form.$dirty&&submit_form.user.$error.required" hidden="hidden" id="user_tip">用户名不能为空</span>
                    </div>
                </div>
                <div class="form-group password-formGroup">
                    <label class="col-lg-3 control-label password-label" for="password">密&nbsp;&nbsp;&nbsp;&nbsp;码</label>
                    <div class="col-lg-7 password-txt">
                        <input name="password" type="password" class="form-control" id="password" onfocus="inputOnfocus('pwd_tip')" placeholder="请输入密码" required />
                        <span class="tipinfo" ng-show="submit_form.$dirty&&submit_form.password.$error.required" hidden="hidden" id="pwd_tip">密码不能为空</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-lg-3"></label>
                    <div class="checkbox col-lg-7">
                        <label>
                            <input class="che" type="checkbox" id="rememberMe">&nbsp;记住用户名
                            <div class="show-box"></div>
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-3 col-lg-7 bottonG">
                        <button type="button" class="btn btn-primary" onclick="loginSubmit()" id="loginBtn">登录</button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-3 col-lg-7 forget">
                        <a href="javascript:;">忘记密码?</a>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="footer">
        <p>Copyright @ 2018-2020 中国环境科学研究院人事档案管理系统</p>
    </div>
</div>
</body>

</html>