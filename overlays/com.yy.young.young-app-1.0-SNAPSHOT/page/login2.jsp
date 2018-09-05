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
    <title>登录</title>
    <link href="<%=URL_STATIC%>static/css/login.css" rel="stylesheet">
    <script type="text/javascript">
        $(function () {

        });
        function loginSubmit(){
            jo.showLoading();
            var account = $("#account").val();
            var password = $("#password").val();
            var redirectTo = jo.getUrlParam("redirectTo");//登录成功后重定向的地址
            jo.postAjax('{URL_UMS}login.action',{"account":account,"password":password,"redirectTo":redirectTo},function(json){
                if(json.code == 1 && json.redirectTo){
                    window.location.href = json.redirectTo;
                }else{
                    jo.alert(json.info);
                }

            });
            jo.showLoading(false);
        }
    </script>
</head>
<body class="" style="background-color: #26A8FA;">

<div class="container-fluid" style="height: 100%;">
    <div class="row">
        <div class="login-head" style="border-color: #DDDDDD;">
            <img src="<%=URL_STATIC%>static/images/login_logo2.png" class="login-logo" style="height: 40px;">
            <span style="color:white;font-size: 20px;vertical-align: middle;font-weight: bold;">检测实验室系统</span>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-2"></div>
        <div class="col-lg-8">
            <div class="login-content">
                <div class="login-ad">

                </div>
                <div class="login-bar" style="background-color: #EEF3F7;border: white solid 1px;height: 340px;">
                    <span class="h4"><b>密码登录</b></span>
                    <br/><br/>
                    <h5 style="color: #73777A;">使用账号密码进行登录</h5>
                    <br/>
                    <input class="form-control" value="admin" id="account" name="account" placeholder="用户名" autocomplete="off" type="text">
                    <br/>
                    <input class="form-control" value="123456" id="password" name="password" placeholder="登录密码" autocomplete="off" type="password">
                    <br/>
                    <button type="button" class="btn btn-primary" style="width: 100%;" onclick="loginSubmit()">登录</button>

                    <%--<div class="hint">
                        <a href="#">忘记密码</a>
                        &nbsp;
                        <a href="#">免费注册</a>
                    </div>--%>
                    <%--<h6>其他方式登录：
                        <img class="login-other" title="微博授权登录" src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaWNvbiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PGRlZnM+PHN0eWxlLz48L2RlZnM+PHBhdGggZD0iTTc1OC4xODcgNTI3LjY2Yy0zOS44MDgtNy43MjQtMjAuNDM4LTI5LjIyOC0yMC40MzgtMjkuMjI4czM4LjkxLTY0LjM0LTcuNjgtMTExLjE0N2MtNTcuODU3LTU3Ljk0LTE5OC40IDcuMzgyLTE5OC40IDcuMzgyLTUzLjYzMyAxNi42ODItMzkuMzgyLTcuNjM4LTMxLjc4Ny00OS4wMjQgMC00OC43MjYtMTYuNjgzLTEzMS4yNDMtMTU5LjYxNi04Mi41MThDMTk3LjQ2IDMxMi4xNSA3NC43OTUgNDgzLjc5NyA3NC43OTUgNDgzLjc5Ny0xMC40NTMgNTk3Ljg4Ny44NTMgNjg2LjA4Ljg1MyA2ODYuMDhjMjEuMzM0IDE5NC42ODggMjI3LjU4NCAyNDguMTA3IDM4OC4wMSAyNjAuNzM2IDE2OC43OSAxMy4yNyAzOTYuNjczLTU4LjMyNSA0NjUuNzA4LTIwNS40NCA2OS4xMi0xNDcuMzctNTYuNDQ3LTIwNS42NTMtOTYuNDI2LTIxMy42NzV6bS0zNTYuNzggMzY0LjI0NGMtMTY3LjYzNiA3Ljg1LTMwMy4wNi03Ni4zNzMtMzAzLjA2LTE4OC41IDAtMTEyLjI1NyAxMzUuNDI0LTIwMi4yNCAzMDMuMDYtMjEwLjAwNyAxNjcuNjgtNy43NjUgMzAzLjM2IDYxLjUyNiAzMDMuMzYgMTczLjUyNiAwIDExMi4xMjgtMTM1LjY4IDIxNy4zNDQtMzAzLjM2IDIyNC45OHoiIGZpbGw9IiNFNjNDNTMiLz48cGF0aCBkPSJNMzY3LjkxNSA1NjcuMzRDMTk5LjM4IDU4Ny4wOTIgMjE4Ljg4IDc0NS4zODYgMjE4Ljg4IDc0NS4zODZzLTEuNzA3IDUwLjA5IDQ1LjIyNyA3NS42NDhjOTguNTYgNTMuNTQ2IDIwMC4xMDYgMjEuMTIgMjUxLjQzNC00NS4zMTIgNTEuMjg3LTY2LjQzMiAyMS4yMDctMjI4LjA1NC0xNDcuNjI1LTIwOC4zODR6TTMyNS40MiA3ODkuNDZjLTMxLjQ0NyAzLjcxMy01Ni44MzMtMTQuNTA1LTU2LjgzMy00MC44NzMgMC0yNi4yODMgMjIuNTI4LTUzLjgwMyA1NC4wMTYtNTcuMDg4IDM2LjEzOC0zLjQ1NyA1OS43MzMgMTcuNDA3IDU5LjczMyA0My44MTcgMCAyNi4yODMtMjUuNTU3IDUwLjU2LTU2LjkxNyA1NC4xODd6bTk5LjM3LTg0Ljg2M2MtMTAuNjY3IDguMDIyLTIzLjc2NiA2LjkxMi0yOS4zOTgtMi42ODgtNS44ODgtOS4zNDUtMy42Ny0yNC4zMiA3LjA4My0zMi4xNyAxMi41LTkuMzQ1IDI1LjQ3Mi02LjY1NyAzMS4xNDYgMi42ODcgNS42MzMgOS42IDEuNTggMjMuOTM2LTguODMgMzIuMTd6bTQxNS40ODctMjQ1LjQ2YTI3LjQzNSAyNy40MzUgMCAwIDAgMjcuNDM1LTI2LjE1NmMyMC41NjUtMTg1LjYtMTUxLjY4LTE1My42LTE1MS42OC0xNTMuNmEyNy42MDUgMjcuNjA1IDAgMCAwLTI3LjUyIDI3Ljg2M2MwIDE1LjE5IDEyLjI0NSAyNy42MDUgMjcuNTIgMjcuNjA1IDEyMy43MzMtMjcuMzkyIDk2LjQyNyA5Ni42NCA5Ni40MjcgOTYuNjQgMCAxNS4zNiAxMi40NTcgMjcuNjQ4IDI3LjgxNyAyNy42NDh6IiBmaWxsPSIjRTYzQzUzIi8+PHBhdGggZD0iTTgyMC4yMjQgMTM1LjI1M2MtNTkuNjA1LTEzLjk5NC0xMjAuODMyLTEuOTItMTM3Ljk4NCAxLjM2Ni0xLjI4LjEyNy0yLjU2IDEuMzY0LTMuNzk3IDEuNjItLjU5OC4xMjgtLjk0LjcyNS0uOTQuNzI1YTQwLjUzMyA0MC41MzMgMCAwIDAgMTAuODggNzkuMzZzMjEuNjc2LTIuOSAzNi4zNTMtOC42NmMxNC41OTItNS44OSAxMzcuOS00LjM5NiAxOTkuMjEgOTguNzMgMzMuNDEgNzUuMzA2IDE0LjY3OCAxMjUuNjUzIDEyLjM3NCAxMzMuNzYgMCAwLTcuOTggMTkuNTg0LTcuOTggMzguODI2IDAgMjIuMTg4IDE3Ljg4IDM2LjE4MyA0MC4wMjMgMzYuMTgzIDE4LjUxNyAwIDM0LjA0OC0yLjU2IDM4LjYxMy0zMy45MmguMjU2YzY1Ljc5Mi0yMTkuNzc2LTgwLjQ3LTMyMy4wNzItMTg3LjAwOC0zNDcuOTl6IiBmaWxsPSIjRTYzQzUzIi8+PC9zdmc+">
                        &nbsp;&nbsp;<img class="login-other" title="支付宝授权登录" src="data:image/svg+xml;base64,PHN2ZyBjbGFzcz0iaWNvbiIgdmlld0JveD0iMCAwIDEwMjQgMTAyNCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCI+PGRlZnM+PHN0eWxlLz48L2RlZnM+PHBhdGggZD0iTTIyNi45NjUgNjI5LjEyYzAgMzUuMjcyIDIxLjUwMyA4NC4yODUgMTIzLjgzNSA4NC4yODUgMTAyLjMyMyAwIDE4OS4xNzUtMTAzLjE2OCAxODkuMTc1LTEwMy4xNjhzLTExNy41Ni02NS43MTUtMjA0LjY1NS02MC4yMjNjLTg3LjExIDUuNTctMTA4LjM1NSA0My44NC0xMDguMzU1IDc5LjEwNXoiIGZpbGw9IiMxMjk2ZGIiLz48cGF0aCBkPSJNNTEyLjAxNS4wM0MyMjkuMjYyLjAzLjAyIDIyOS4yNTIuMDIgNTEyLjAwNmMwIDI4Mi43NCAyMjkuMjQyIDUxMS45NjMgNTExLjk5NSA1MTEuOTYzIDI4Mi43MjcgMCA1MTEuOTY0LTIyOS4yMjQgNTExLjk2NC01MTEuOTYzQzEwMjMuOTggMjI5LjI1MyA3OTQuNzQuMDMgNTEyLjAxNC4wM3pNODk4LjE2NyA3ODEuN0w2MDguMTk1IDY0NC4yMlM1NTMuMzUgNzA0LjkgNDk3LjQxOCA3MzEuNTc4Yy01NS45MzUgMjYuNjg3LTEyMC4xOSA0My4zMjctMTg5LjY5IDI2Ljg4LTY5LjU2NS0xNi4zOC0xMTguOTA3LTYwLjg1Ni0xMTAuMzk2LTE0Mi45NyA4LjUxMi04Mi4xMDUgOTYuMjU1LTExMC4zOTMgMTY4LjQ0My0xMTAuMzkzIDcyLjE4IDAgMjA5LjIwNSA0Ni43NyAyMDkuMjA1IDQ2Ljc3czExLjUxMi0yNS43OCAyMi43MTgtNTUuMjc4YzExLjItMjkuNSAxNC40MDItNTMuMTg1IDE0LjQwMi01My4xODVIMzIwLjQwNnYtMjkuMzE4aDE0MS43NHYtNTUuOTM1bC0xNzYuNjk1IDEuMjlWMzIyLjU3aDE3Ni41MTN2LTgzLjg5NGg5Mi43OXY4My44OTVINzQ0LjEydjM2Ljg2NmwtMTg5LjM2NyAxLjI3M3Y1Mi4wOWwxNTYuNDA3IDEuMjgycy0yLjgxIDI5LjI1Ni0yMi42NDggODIuNDQyYy0xOS44NDMgNTMuMTg1LTM4LjM5NiA4MC4zMTctMzguMzk2IDgwLjMxN2wzMDMuNDEgOTkuNTc1cy0xMC44OCAyOC40ODItMjQgNTMuNDM1Yy0xMy4xMTcgMjQuOTUyLTMxLjM2IDUxLjg1LTMxLjM2IDUxLjg1eiIgZmlsbD0iIzEyOTZkYiIvPjwvc3ZnPg=="/>
                    </h6>--%>
                </div>
            </div>
        </div>
        <div class="col-lg-2"></div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
