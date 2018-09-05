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
        URL_MENU = "{URL_PORTAL}portal/scheme/getMenu.action";//重置菜单地址
        $(function(){
            //当前活动菜单作标注
            var last = null;
            $(".young-nav-tit").on("click",function(event){
                if(last){
                    last.removeClass("menu-active");
                }
                $(this).addClass("menu-active");
                last = $(this);//缓存当前选中节点
            });
        });
    </script>
    <style>
        .menu-active{
            border-left: #337AB7 solid 4px;
            box-sizing: border-box;
        }
        .tools-ul li:hover{
            background: rgba(0,0,0,0.1);
            opacity: 0.8;
        }
    </style>
</head>
<body>
<table class="layout-table" cellspacing="0" cellpadding="0">
    <tr>
        <td class="layout-table-td-head">
            <div class="head-bar bg-head">
                <%--logo区域--%>
                <div class="logo-bar">
                    <i class="fa fa-2x fa-diamond" aria-hidden="true"></i>
                    &nbsp;
                    <span class="font-18">信息系统</span>
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
                                <!--
                                <%--导航单元,一个完整的导航单元包含导航标题和导航子节点(如果有的话)--%>
                                <div class="young-nav-unit">
                                    <%--导航标题(包括图标和箭头)--%>
                                    <div class="young-nav-tit">
                                        <div class="young-nav-icon"><i class="fa fa-bath" aria-hidden="true"></i></div>
                                        <div class="young-nav-name">菜单1</div>
                                        <div class="young-nav-handle"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                                    </div>
                                    <%--子节点--%>
                                    <div class="young-nav-child child-open">
                                        <div class="young-nav-unit">
                                            <div class="young-nav-tit">
                                                <div class="young-nav-icon"><i class="fa fa-bath" aria-hidden="true"></i></div>
                                                <div class="young-nav-name">2级菜单1-1</div>
                                                <div class="young-nav-handle"><i class="fa fa-angle-right" aria-hidden="true"></i></div>
                                            </div>
                                            <div class="young-nav-child child-close">
                                                <div class="young-nav-unit">
                                                    <div class="young-nav-tit">
                                                        <div class="young-nav-icon"><i class="fa fa-bath" aria-hidden="true"></i></div>
                                                        <div class="young-nav-name">3级菜单1-1-1</div>
                                                        <div class="young-nav-handle"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="young-nav-unit">
                                            <div class="young-nav-tit">
                                                <div class="young-nav-icon"><i class="fa fa-bath" aria-hidden="true"></i></div>
                                                <div class="young-nav-name">菜单1-2</div>
                                                <div class="young-nav-handle"></div>
                                            </div>
                                        </div>
                                        <div class="young-nav-unit">
                                            <div class="young-nav-tit">
                                                <div class="young-nav-icon"><i class="fa fa-bath" aria-hidden="true"></i></div>
                                                <div class="young-nav-name">菜单1-3</div>
                                                <div class="young-nav-handle"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%--/导航单元--%>
                                -->
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
                            <iframe name="main" class="main-iframe" src="<%=URL_STATIC%>page/portal/home.jsp" border="0" style="padding-bottom: 0px;"></iframe>
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
