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
            });
            new Grid($("#mainList")).loadData();
        });
    </script>
    <style>
        .welcome-info,.login-info{
            height: 40px;
            line-height: 40px;
        }
        .about{

        }
        .folder-ul{
            list-style: none;
            margin: 0px;
            padding: 8px 0px;
        }
        .folder-li{
            width: 275px;
            height: 70px;
            list-style: none;
            padding: 0px;
            margin: 0px 10px 7px 0px;
            float: left;
            border: white solid 1px;
        }
        .folder-li:hover{
            border: #E5ECF0 solid 1px;
            background-color: #FCFCFC;
            cursor: pointer;
        }
        .folder-li-pic{
            float: left;
            height: 50px;
            width: 50px;
            margin-top: 12px;
            margin-left: 12px;
        }
        .folder-li-pic-bg img{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
        .folder-li-info{
            width: 202px;
            height: 62px;
            float: right;
            padding: 5px 5px 0px 0px;
        }
        .icon{
            width: 20px;
            text-align: center;
        }
    </style>
</head>
<body class="padding-20">
<div class="welcome-info">
    <i class="fa fa-2x fa-sun-o" aria-hidden="true" style="vertical-align: middle;color: #FFB433;"></i>&nbsp;
    <b style="vertical-align: middle;">${loginUser.name} <span id="timer">早上</span>好，欢迎登录！</b>
</div>
<div class="login-info">
    <i class="fa fa-2x fa-clock-o" aria-hidden="true" style="vertical-align: middle;color: #9D9D9D;"></i>&nbsp;
    <span style="vertical-align: middle;">您上次登录的时间：<span id="lastLoginTime"></span> （不是您登录的？ <a href="">请点这里</a>）</span>
</div>
<hr/>
<div class="about">
    <i class="fa fa-lg fa-users" aria-hidden="true" style="vertical-align: middle;"></i>&nbsp;
    <b style="vertical-align: middle;">关于我们</b>
    <ul class="folder-ul" id="disks">
        <li class="folder-li">
            <div class="folder-li-pic folder-li-pic-bg"><img src="<%=URL_STATIC%>static/images/wjy.jpg"/></div>
            <div class="folder-li-info">
                <div>
                    <i class="fa fa-male icon" aria-hidden="true"></i>&nbsp;王吉雨
                </div>
                <div style="padding: 5px 0px;">
                    <i class="fa fa-phone icon" aria-hidden="true"></i>&nbsp;18235146426
                </div>
                <p>
                    <i class="fa fa-envelope-o icon" aria-hidden="true"></i>&nbsp;18235146426@sina.cn
                </p>
            </div>
        </li>
        <li class="folder-li">
            <div class="folder-li-pic folder-li-pic-bg"><img src="<%=URL_STATIC%>static/images/wjy.jpg"/></div>
            <div class="folder-li-info">
                <div>
                    <i class="fa fa-male icon" aria-hidden="true"></i>&nbsp;杨伟
                </div>
                <div style="padding: 5px 0px;">
                    <i class="fa fa-phone icon" aria-hidden="true"></i>&nbsp;13623648626
                </div>
                <p>
                    <i class="fa fa-envelope-o icon" aria-hidden="true"></i>&nbsp;106336976@qq.com
                </p>
            </div>
        </li>
    </ul>
</div>
<div class="clear"></div>
<style>
    .lump{width:500px;height:auto;background-color: #FBFDFE;border:#F1F7FC solid 1px;border-radius: 2px;box-sizing: border-box;font-family: "微软雅黑", "Arial", "Verdana", "Helvetica", "宋体", "sans-serif";}
    .lump-title{width: 100%;height: 30px;box-sizing: border-box;border-bottom: #DEF3FC solid 3px;position: relative;line-height: 30px;padding: 0px 12px;}
    .lump-title-item{height: 30px;display: inline-block;font-weight: bold;font-size: 14px;letter-spacing: 1px;cursor: default;}
    .lump-title-item-active{border-bottom: #0081E3 solid 2px;}
    .lump-title-more{position: absolute;top:0px;right: 0px;padding-right:12px;font-size: 10px;cursor: pointer;}
    .lump-title-separator{padding:0px 3px;height: 30px;display: inline-block;}
    .lump-content{width: 100%;height: 170px;box-sizing: border-box;padding: 2px 0px;overflow: auto;}/*内容为html*/
    .lump-iframe{width: 100%;height:170px;border:none;padding: 0px;margin:0px;}/*内容为页面*/
</style>
<%--<div class="lump">
    <div class="lump-title">
        <div class="lump-title-item lump-title-item-active">已办</div>
        <div class="lump-title-separator">|</div>
        <div class="lump-title-item">待办</div>
        <div class="lump-title-more">更多</div>
    </div>
    <div class="lump-content">
        <table class="table table-hover table-condensed" id="mainList" dataUrl="ums/navigate/getNavigatePage.action"
               deleteUrl="ums/navigate/deleteNavigate.action" formUrl="page/ums/navigateForm.jsp" noHead="true">
            <col field="NAME" title="资源名称" width="14%" align="" event="click"/>
            <col field="HREF" title="链接" width="35%" align="left"/>
            <col field="PARENT_NAME" title="父节点" width="10%" align=""/>
            <col field="icon_show" title="图标" width="10%" align=""/>
            <col field="TYPE" title="类型" width="10%" align=""/>
            <col field="NAV_LEVEL" title="层级" width="8%" align=""/>
            <col field="NUM" title="排序" width="8%" align=""/>
        </table>
    </div>
    &lt;%&ndash;<iframe class="lump-iframe" src="http://www.baidu.com"></iframe>&ndash;%&gt;
</div>--%>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>
