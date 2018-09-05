<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link href="<%=URL_STATIC%>static/css/reset.css" rel="stylesheet">
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
    <title>YOUNG</title>
    <link href="<%=URL_STATIC%>static/css/index.css" rel="stylesheet">
    <script src="<%=URL_STATIC%>static/js/index.js"></script>
    <script type="text/javascript">
        $(function(){
            timeBgGo();
        });
        //时间主题开启
        function timeBgGo(){
            var time = new Date();//当前时间
            var hour = time.getHours();//小时
            var opacity = 0;
            if(hour >= 22 || hour <= 2){
                opacity = 1;
                console.info("当前时间处于晚上10点到凌晨2点之间,时间主题切换为[纯黑]...");
            }else{
                opacity = parseInt(calc(hour, 12) / 20 * 10)/10;
                console.info("当前时间为"+hour+"点,时间主题切换为["+opacity+"]...");
            }
            //矫正时间主题
            $("#bg_time").css("opacity", opacity);
            //开始自动切换到下一个主题
            //toNextTimeBg(opacity);
        }
        //切换到下一个主题,参数为当前主题
        function toNextTimeBg(curOpacity){
            var GAP = 1000 * 60 * 60 * 2;//默认切换间隔2小时
            //没有传入当前主题则自动获取
            curOpacity = jo.getDefVal(curOpacity, parseFloat($("#bg_time").css("opacity")) );
            //计算下一个
            var next = curOpacity;
            var hour = new Date().getHours();
            if(hour >= 22 || hour == 0){//晚上的下一次变化还是纯黑
                next = 1;
            }else if(hour >= 12){//下午就加0.1
                next = curOpacity + 0.1;
            }else{//上午就减0.1
                next = curOpacity - 0.1;
            }
            console.info("下一次时间主题为"+next);
            $("#bg_time").animate({'opacity':next}, GAP, function(){
                console.info("时间主题已切换为"+next+",时间继续go on...");
                toNextTimeBg(next);
            });
        }
        //计算绝对值
        function calc(a, b){
            return a > b ? (a-b) : (b-a);
        }
    </script>
    <style>
        .bg-head{ /*顶部背景色*/
            background: none;
            border-bottom: #2898D3 solid 0px;
            color: white;
        }
        .tools-ul li:hover{ /*顶部工具栏悬浮变色*/
            background: none;
        }
        .bg-right{ /*右侧背景*/
            background: none;
        }
        .body-left-bar{ /*左侧栏*/
            color: #000000;
            border-right: #2898D3 solid 0px;
            color: white;
        }
        .body-td-left{
            border-right:none;
        }
        .bg-left{ /*左侧背景*/
            background: none;
        }
        .young-nav-container{ /*菜单栏颜色*/
            background: none;
        }
        .young-nav-tit:hover{ /*菜单项悬浮变色*/
            background: none;
        }
        .bottom-info,.young-nav-crumbs{
            background: none;
            color: white;
        }
        .young-nav-crumbs{border-bottom: #2898D3 solid 0px;}
        .bottom-info{border-top: #2898D3 solid 0px;}
        .body-right-bar{border-left: #2898D3 solid 0px;}
    </style>
</head>
<body style="">
<div style="background: url('<%=URL_STATIC%>static/images/moon.jpg') no-repeat center bottom;absolute: absolute;z-index: 2;top: 0px;left: 0px; width: 100%; height: 100%;"></div>
<div id="bg_time" style="background-color: black;opacity: 1; width: 100%; height: 100%;position: absolute;z-index: 3;top: 0px;left: 0px;"></div>
<table class="layout-table" cellspacing="0" cellpadding="0" style="position: absolute;z-index: 4;top: 0px;left: 0px;background: none;">
    <tr>
        <td class="layout-table-td-head">
            <div class="head-bar bg-head">
                <%--logo区域--%>
                <div class="logo-bar">
                    <i class="fa fa-2x fa-diamond" aria-hidden="true"></i>
                    &nbsp;
                    <span class="font-18">Young快速开发平台</span><small style="color: #ffffff;">&nbsp;开发从未如此简单!</small>
                </div>
                <%--/logo区域--%>

                <%--顶部工具栏--%>
                <div class="head-tools-bar">
                    <ul class="tools-ul">
                        <li data-toggle="popover" title="" data-container="body" data-trigger="hover"
                            data-toggle="popover" data-placement="bottom" data-content="消息">
                            <i class="fa fa-1x fa-bell" aria-hidden="true"></i>
                        </li>
                        <li data-toggle="popover" title="" data-container="body" data-trigger="hover"
                            data-toggle="popover" data-placement="bottom" data-content="设置主题与布局" onclick="openPage('page/setTheme.jsp','主题设置')">
                            <i class="fa fa-1x fa-map-o" aria-hidden="true"></i>
                        </li>
                        <li data-toggle="popover" title="" data-container="body" data-trigger="hover"
                            data-toggle="popover" data-placement="bottom" data-content="全屏">
                            <i class="fa fa-1x fa-arrows-alt" aria-hidden="true"></i>
                        </li>
                        <li data-toggle="popover" title="" data-container="body" data-trigger="hover"
                            data-toggle="popover" data-placement="bottom" data-content="个人信息" onclick="openPage('{URL_UMS}page/ums/personInfo.jsp','个人信息')">
                            <i class="fa fa-1x fa-user" aria-hidden="true"></i>
                        </li>
                        <li data-toggle="popover" title="" data-container="body" data-trigger="hover"
                            data-toggle="popover" data-placement="bottom" data-content="注销" onclick="logout()">
                            <i class="fa fa-1x fa-close" aria-hidden="true"></i>
                        </li>
                    </ul>
                </div>
                <%--/顶部工具栏--%>
            </div>
        </td>
    </tr>
    <tr>
        <td style="height: 100%;padding-bottom: 70px;box-sizing: border-box;">
            <table class="layout-table-body" cellspacing="0" cellpadding="0">
                <tr style="height: 100%;">
                    <td class="body-td-left">
                        <%--左侧栏--%>
                        <div class="body-left-bar bg-left">
                            <h6 style="padding-left: 20px;color: gray;">菜单栏</h6>
                            <%--菜单容器--%>
                            <div class="young-nav-container">

                            </div>
                            <%--/菜单容器--%>
                        </div>
                        <%--/左侧栏--%>
                    </td>
                    <td class="body-td-right">
                        <%--右侧栏--%>
                        <div class="body-right-bar bg-right">
                            <%--面包屑--%>
                            <div class="young-nav-crumbs" id="crumbs">
                                首页
                            </div>
                            <%--/面包屑--%>

                            <%--内容显示iframe--%>
                            <iframe name="main" class="main-iframe" src="" border="0" style="padding-right:30px;padding-bottom: 0px;"></iframe>
                            <%--/内容显示iframe--%>

                            <%--底部消息--%>
                            <%--<div class="bottom-info">
                                &copy;2017 Young @北京银宇空间科技有限公司
                            </div>--%>
                            <%--/底部消息--%>
                        </div>
                        <%--/右侧栏--%>
                    </td>
                </tr>
            </table>
        </td>
    </tr>

</table>
<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    resizeLeftBar();//重置左侧区域的的大小
    //窗口大小改变事件
    window.onresize = function(){
        resizeLeftBar();
    };
</script>
</body>
</html>
