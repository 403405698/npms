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
    <title>home</title>
    <script type="text/javascript">
        $(function () {
            var time = new Date();
            if(time.getHours() < 9){
                $("#timer").html("早上");
            }else if(time.getHours() < 14){
                $("#timer").html("上午");
            }else if(time.getHours() < 18){
                $("#timer").html("下午");
            }else if(time.getHours() < 24){
                $("#timer").html("晚上");
            }
            jo.postAjax("{URL_PORTAL}portal/getLastLoginTime.action", {}, function(json){
                if(json && json.code == "0"){
                    if(json.data && json.data[0]){
                        $("#lastLoginTime").text(jo.formatTime(json.data[0]));
                    }else{
                        $(".login-info").remove();
                    }
                }
            }, true);
            new Grid($("#mainList")).loadData();
            new Grid($("#mainList2")).loadData();
        });
        function getAddr(provinceName, cityName, countyName, time){
            return '【' + jo.formatDate(time) + '】 ' + provinceName + (cityName ? (countyName ? "-" + cityName + "-" + countyName : "-" + cityName) : "");
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
        //格式化通知标题
        function formatTitle(time, title){
            return '【' + jo.formatDate(time) + '】 ' + title;
        }
        //通知点击事件
        function noticeClick(item, json, idx){
            jo.showWin('page/nyb/flow/samplingNoticePmForm.jsp?id=' + item.id, '780px', '80%', '采样通知', "WIN_EDIT");
        }
        //点位审核点击
        function pointClick(item, json, idx){
            parent.jo.showWin("page/nyb/point/pointCheckForm.jsp?id=" + item.id, '90%', '90%', '点位调整申请详情', 'WIN_CHECK');
        }
    </script>
    <style>
        .welcome-info,.login-info{
            height: auto;
            line-height: 30px;
            padding: 8px 12px;
            margin-bottom: 0px;
            border: #DFE0DF solid 1px;
            border-radius: 2px;
        }
        .padding-top-15{
            padding-top: 15px;
        }
        .home-bar{
            line-height: 1.7;
            padding: 8px 12px;
            margin-bottom: 12px;
            border: #DFE0DF solid 1px;
            border-radius: 2px;
        }
        .lump{width:100%;height:auto;background-color: #FFFFFF;border:#DFE0DF solid 1px;border-radius: 2px;box-sizing: border-box;font-family: "微软雅黑", "Arial", "Verdana", "Helvetica", "宋体", "sans-serif";}
        .lump-title{width: 100%;height: 35px;line-height: 35px;box-sizing: border-box;border-bottom: #DEF3FC solid 3px;position: relative;padding: 0px 12px;}
        .lump-title-item{height: 35px;display: inline-block;font-weight: bold;font-size: 14px;letter-spacing: 1px;cursor: default;}
        .lump-title-item-active{border-bottom: #0081E3 solid 2px;}
        .lump-title-more{position: absolute;top:0px;right: 0px;padding-right:12px;font-size: 10px;cursor: pointer;}
        .lump-title-separator{height: 35px;padding:0px 3px;display: inline-block;}
        .lump-content{width: 100%;height: 214px;box-sizing: border-box;padding: 2px 0px;overflow: auto;}/*内容为html*/
        .lump-iframe{width: 100%;height:210px;border:none;padding: 0px;margin:0px;box-sizing: border-box;}/*内容为页面*/
    </style>
</head>
<body class="bg">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 margin-top-12">
            <div class="welcome-info bg-white">
                <i class="fa fa-2x fa-sun-o" aria-hidden="true" style="vertical-align: middle;color: #FFB433;"></i>&nbsp;
                <b style="vertical-align: middle;">${loginUser.name} <span id="timer">早上</span>好，欢迎登录！</b>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 margin-top-12">
            <div class="login-info bg-white">
                <i class="fa fa-2x fa-clock-o" aria-hidden="true" style="vertical-align: middle;color: #9D9D9D;"></i>&nbsp;
                <span style="vertical-align: middle;">您上次登录的时间：<span id="lastLoginTime"></span> （不是您登录的？ <a class="cursor-hand" onclick="updatePassword()">修改密码</a>）</span>
            </div>
        </div>
    </div>
    <%--<div class="row">
        <div class="col-sm-6 margin-top-12">
            <div class="lump">
                <div class="lump-title">
                    <div class="lump-title-item lump-title-item-active">采样通知</div>
                    <div class="lump-title-more" onclick="top.openPage('page/nyb/flow/samplingNoticeList.jsp', '采样通知')">更多</div>
                </div>
                <div class="lump-content">
                    <table class="table table-hover margin-0" id="mainList" dataUrl="flow/samplingNotice/getSamplingNoticePage.action?pageSize=10"
                           noHead="true" trClick="noticeClick">
                        <col field="[=formatTitle('{createTime}','{title}')]" title="标题" width="99%" align="left" event="click"/>
                        &lt;%&ndash;<col field="[=jo.formatDate('{createTime}')]" title="创建时间" width="100px" align="right"/>&ndash;%&gt;
                    </table>
                </div>
            </div>
        </div>
        <div class="col-sm-6 margin-top-12">
            &lt;%&ndash;<div class="home-bar bg-white">
                34
            </div>&ndash;%&gt;
            <div class="lump">
                <div class="lump-title">
                    <div class="lump-title-item lump-title-item-active">点位调整</div>
                    <div class="lump-title-more" onclick="top.openPage('page/nyb/point/pointCheckOfNone.jsp', '地域统计');">更多</div>
                </div>
                &lt;%&ndash;<iframe class="lump-iframe" src=""></iframe>&ndash;%&gt;
                <div class="lump-content">
                    <table class="table table-hover margin-0" id="mainList2" dataUrl="point/pointCheck/getPointCheckPage.action?status=1&pageSize=10"
                           noHead="true" trClick="pointClick">
                        <col field="[=getAddr('{provinceName}','{cityName}','{countyName}','{applyTime}')]" title="行政区" width="80%" align="left" event="click"/>
                        <col field="[=parse_pointCheckStatus('{status}', true)]" title="审核状态" width="20%" align="right"/>
                    </table>
                </div>
            </div>
        </div>
    </div>--%>
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
