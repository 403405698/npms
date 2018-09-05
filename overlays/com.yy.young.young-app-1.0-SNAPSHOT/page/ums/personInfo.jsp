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
            initInfo();
        });
        //初始化信息
        function initInfo(){
            jo.postAjax("{URL_UMS}ums/user/queryMyStatisticsInfo.action", {}, function(json){
                if(json && json.code == "0" && json.data && json.data.length > 0){
                    var info = json.data[0];
                    var userInfo = info.user;
                    $("#name").text(userInfo.name);
                    $("#birthday").text(userInfo.birthday);
                    if(userInfo.sex == "1"){
                        $("#sex").text("男");
                    }else{
                        $("#sex").text("女");
                    }
                    $("#tel").text(userInfo.tel);
                    $("#email").text(userInfo.email);
                    $("#company").text(userInfo.companyName);
                    $("#lastLoginTime").text(jo.formatTime(info.lastLoginTime));
                    $("#loginNum").text(info.loginNum);
                    $("#messageNum").text(info.messageNum);
                    $("#logNum").text(info.logNum);
                    $("img.info-header").attr("src", URL_FS+"fs/file/image.action?id="+userInfo.header);
                }
            });
        }
        //上传头像
        function upload(){
            jo.uploadFile("{URL_UMS}ums/user/uploadHeader.action?folderId=header", function(success, file, json){
                if(success && json){
                    jo.closeUploadDialog();//关闭上传窗口
                    if(json.code == "0"){
                        jo.showMsg("上传成功!", {icon:1});
                        initInfo();
                    }else{
                        jo.showMsg(json.info);
                    }
                }
            });
        }
        //修改密码
        function updatePassword(){
            jo.reset("updatePwdForm");//重置表单
            jo.showDialog($("#updatePwdBox"), "updatePwd", true, {title:"修改密码", area:["450px","280px"], btn:["确定","取消"], btn1:function(index){
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
                        }else{
                            jo.alert(json.info);
                        }
                        jo.close(index);//关闭
                    });
                }
            }});
        }
    </script>
    <style>
        .simple-info{background-color: white;padding-top: 15px;padding-left: 0px;padding-right: 0px;}
        .info-header-bar{width: 110px;
            height
            : 110px; margin: 20px auto; border-radius: 55px;}
        .info-header{width: 100%;
            height: 100%; border-radius: 50%;
            cursor: pointer;}
        .info-text{width: 100%;
            height: auto; padding: 5px 0px; text-align: center;}
        .info-stat{width: 100%; height: 80px; background-color: #F6F9FD;margin-top: 30px;}
        .stat-ele{width: 33%;height: 80px;display:block;float: left;padding:15px;margin: 0px; line-height: 25px;text-align: center;}
        .stat-number{font-size: 16px; color: #526069;}
        .stat-text{color: #A3AFB7;}

        .info-detail{background-color: white; width: 100%;padding: 17px 0px 17px 17px;position: relative;}
        .config{position: absolute;top: 15px;right:20px;}
        .config-ul{list-style: none;position: absolute;top: 16px;right: -3px;padding: 3px 0px;margin: 0px;
            width: 66px;text-align: center;display: none;background-color: #ffffff;border: #f3f3f4 solid 1px;}
        .config-ul>li{height: 25px;line-height: 25px;}
        .config:hover>.config-ul{display: block;}
        .config-ul>li:hover{background-color: #F3F3F4;}
    </style>
</head>
<body class="padding-20 main-bg-color">
<div class="container-fluid" style="padding: 0px;">
    <div class="single-row">
        <div class="col-md-3 simple-info">
            <div class="info-header-bar">
                <img class="info-header" src="<%=URL_STATIC%>static/images/moon.jpg" onclick="upload()"/>
            </div>
            <div class="info-text">
                ${loginUser.name}
            </div>
            <div class="info-text">
                上次登录：<span id="lastLoginTime"></span>
            </div>
            <div class="info-stat">
                <div class="stat-ele">
                    <span class="stat-number" id="loginNum">0</span>
                    <br/>
                    <span class="stat-text">登录</span>
                </div>
                <div class="stat-ele">
                    <span class="stat-number" id="messageNum">0</span>
                    <br/>
                    <span class="stat-text">消息</span>
                </div>
                <div class="stat-ele">
                    <span class="stat-number" id="logNum">0</span>
                    <br/>
                    <span class="stat-text">日志</span>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <div class="col-md-9" style="padding: 0px;">
            <div class="info-detail">
                <div class="cursor-hand config">
                    <i class="fa fa-navicon" aria-hidden="true"></i>&nbsp;编辑
                    <ul class="config-ul">
                        <li onclick="updatePassword()">修改密码</li>
                        <li>个人信息</li>
                    </ul>
                </div>
                <p><b>个人信息</b></p>
                <p>姓名：<span id="name"></span></p>
                <p>生日：<span id="birthday"></span></p>
                <p>性别：<span id="sex"></span></p>
                <p>电话：<span id="tel"></span></p>
                <p>邮箱：<span id="email"></span></p>
                <p>单位：<span id="company"></span></p>
            </div>
        </div>
    </div>
</div>

<%--修改密码模态框--%>
<div id="updatePwdBox" style="display: none;margin: 0px;padding: 0px;">
    <form class="form-horizontal" role="form" id="updatePwdForm">
        <div class="form-group" style="margin-left: 0px; margin-right: 0px;margin-top: 20px;">
            <label for="old" class="col-sm-3 control-label">旧密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="old" placeholder="" ErrEmpty="请填写旧密码">
            </div>
        </div>
        <div class="form-group" style="margin-left: 0px; margin-right: 0px;">
            <label for="new" class="col-sm-3 control-label">新密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="new" placeholder="" ErrEmpty="请填写新密码">
            </div>
        </div>
        <div class="form-group" style="margin-left: 0px; margin-right: 0px;">
            <label for="new2" class="col-sm-3 control-label">重复新密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="new2" placeholder="" ErrEmpty="请重复新密码">
            </div>
        </div>
    </form>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
