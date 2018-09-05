<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="renderer" content="webkit">
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
    <%--common公共方法--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--H+首页相关css--%>
    <link href="<%=URL_STATIC%>static/plugin/index_hplus/css/animate.min.css" rel="stylesheet">
    <link href="<%=URL_STATIC%>static/plugin/index_hplus/css/style.min862f.css" rel="stylesheet">
    <title>首页</title>
    <script type="text/javascript">
        //注销登录
        function logout(){
            jo.confirm("您确定要注销登录吗?", {title:"退出"}, function(){
                window.location.href = URL_UMS + "logout.action";
            });
        }
    </script>
    <style>
        /*四级菜单*/
        .nav-fourth-level li{
            border-bottom: none!important
        }
        .nav-fourth-level li a {
            padding-left: 72px;
        }
        .nav.nav-third-level>li.active{
            border: none;/*左边高亮防止重复*/
        }
        /*五级菜单*/
        .nav-fifth-level li{
            border-bottom: none!important
        }
        .nav-fifth-level li a {
            padding-left: 82px;/*缩进*/
        }
        .nav.nav-fourth-level>li.active{
            border: none;/*左边高亮防止重复*/
        }
    </style>
</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
    <!--左侧导航开始-->
    <nav class="navbar-default navbar-static-side" role="navigation">
        <div class="nav-close"><i class="fa fa-times-circle"></i>
        </div>
        <div class="sidebar-collapse">
            <ul class="nav" id="side-menu">
                <li class="nav-header">
                    <div class="dropdown profile-element">
                        <span><img alt="image" class="img-circle" src="<%=URL_FS%>fs/file/image.action?id=${loginUser.header}" width="64px" height="64px" /></span>
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                               <span class="block m-t-xs"><strong class="font-bold">${loginUser.name }</strong></span>
                                <span class="text-muted text-xs block">${loginUser.roleName }<b class="caret"></b></span>
                                </span>
                        </a>
                        <ul class="dropdown-menu animated fadeInRight m-t-xs">
                            <%--<li><a class="J_menuItem" href="form_avatar.html">修改头像</a>
                            </li>--%>
                            <li><a class="J_menuItem" href="{URL_UMS}page/ums/personInfo.jsp">个人资料</a>
                            </li>
                            <%--<li><a class="J_menuItem" href="contacts.html">联系我们</a>
                            </li>
                            <li><a class="J_menuItem" href="mailbox.html">信箱</a>
                            </li>--%>
                            <li class="divider"></li>
                            <li><a href="javascript:logout();">安全退出</a>
                            </li>
                        </ul>
                    </div>
                    <div class="logo-element">H+
                    </div>
                </li>

            </ul>
            <script type="text/javascript">
                var URL_MENU = "{URL_PORTAL}portal/getMenu.action";//菜单地址
                //根据菜单层级获取类样式
                function getClassByLevel(level){
                    if(level == 1){
                        console.warn("[菜单初始化] 菜单层级存在异常(通常不存在1级子菜单): "+level);
                        return "nav-second-level";
                    }else if(level == 2){
                        return "nav-second-level";
                    }else if(level == 3){
                        return "nav-third-level";
                    }else if(level == 4){
                        return "nav-fourth-level";
                    }else if(level == 5){
                        return "nav-fifth-level";
                    }
                    console.warn("[菜单初始化] 菜单层级存在异常(通常在2~5): "+level);
                    //默认返回五级菜单样式
                    return "nav-fifth-level";
                }
                //将平台带函数的链接转为纯url
                function parseHref(href){
                    if(href){
                        href = href.trim();//去除两边空格
                        if(href.indexOf("openPageOnMain") == 0){//右侧打开方法
                            href = href.replace("openPageOnMain('", "");
                            href = href.replace("')", "");
                        }
                        if(href.indexOf("newWindow") == 0){//新窗口方法
                            href = href.replace("newWindow('", "");
                            href = href.replace("')", "");
                        }
                        return href;
                    }else{
                        return "";
                    }
                }
                //生成菜单元html,参数1:菜单对象;参数2:菜单层级
                function getNavUnitHtml(menu, level){
                    var _html = '';
                    if(menu){
                        _html += '<li>';
                        if(menu.href){//链接有效,则使用J_menuItem,可点击状态
                            if(menu.href.indexOf("newWindow") == 0){//新窗口打开
                                _html += '<a target="_blank" href="'+parseHref(menu.href)+'">';
                            }else{
                                _html += '<a class="J_menuItem" href="'+parseHref(menu.href)+'">';
                            }
                        }else{//链接无效
                            _html += '<a href="javascript:;">';
                        }
                        _html += '<i class="fa '+menu.icon+' fa-fw"></i> ' +
                                '<span class="nav-label">'+menu.name+'</span>';
                        if(menu.children && menu.children.length > 0){//存在子菜单
                            _html += '<span class="fa arrow"></span>' +
                                    '</a>';
                            _html += '<ul class="nav '+getClassByLevel(level+1)+'">';
                            for(var i=0;i<menu.children.length;i++){
                                _html += getNavUnitHtml(menu.children[i], level+1);
                            }
                            _html += '</ul>';
                        }else{//没有子菜单
                            _html += '</a>';
                        }
                        _html += '</li>';
                    }
                    return _html;
                }
                $(function(){
                    //加载菜单
                    jo.postAjax(URL_MENU,{},function(json){
                        if(json && json.code == 0){
                            var menus = json.data;
                            if(menus && menus.length > 0){
                                var _html = '';
                                for(var i=0;i<menus.length;i++){
                                    var menu = menus[i];
                                    _html += getNavUnitHtml(menu, 1);
                                }
                                $("#side-menu").append(_html);//插入菜单
                                //当有且只有1个根节点时,自动展开
                                /*if(menus.length == 1){
                                    var one = $(".young-nav-container>.young-nav-unit")[0];
                                    var child = $(one).find(">.young-nav-child");
                                    childNavOpen(child);//展开节点
                                }*/
                            }
                        }else{
                            jo.alert(jo.getDefVal(json.info, "获取菜单异常!"));
                        }
                    });
                });
            </script>
        </div>
    </nav>
    <!--左侧导航结束-->
    <!--右侧部分开始-->
    <div id="page-wrapper" class="gray-bg dashbard-1">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0;">
                <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-primary " style="cursor: pointer;"><i class="fa fa-bars"></i> </a>
                    <form role="search" class="navbar-form-custom" method="post" action="">
                        <div class="form-group">
                            <%--<input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">--%>
                        </div>
                    </form>
                </div>
                <ul class="nav navbar-top-links navbar-right">
                    <%--消息--%>
                    <%--<li class="dropdown">
                        <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                            <i class="fa fa-envelope"></i> <span class="label label-warning">16</span>
                        </a>
                        <ul class="dropdown-menu dropdown-messages">
                            <li class="m-t-xs">
                                <div class="dropdown-messages-box">
                                    <a href="profile.html" class="pull-left">
                                        <img alt="image" class="img-circle" src="img/a7.jpg">
                                    </a>
                                    <div class="media-body">
                                        <small class="pull-right">46小时前</small>
                                        <strong>小四</strong> 这个在日本投降书上签字的军官，建国后一定是个不小的干部吧？
                                        <br>
                                        <small class="text-muted">3天前 2014.11.8</small>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="dropdown-messages-box">
                                    <a href="profile.html" class="pull-left">
                                        <img alt="image" class="img-circle" src="img/a4.jpg">
                                    </a>
                                    <div class="media-body ">
                                        <small class="pull-right text-navy">25小时前</small>
                                        <strong>国民岳父</strong> 如何看待“男子不满自己爱犬被称为狗，刺伤路人”？——这人比犬还凶
                                        <br>
                                        <small class="text-muted">昨天</small>
                                    </div>
                                </div>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a class="J_menuItem" href="mailbox.html">
                                        <i class="fa fa-envelope"></i> <strong> 查看所有消息</strong>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>--%>
                    <%--提醒--%>
                    <%--<li class="dropdown">
                        <a class="dropdown-toggle count-info" data-toggle="dropdown" href="#">
                            <i class="fa fa-bell"></i> <span class="label label-primary">8</span>
                        </a>
                        <ul class="dropdown-menu dropdown-alerts">
                            <li>
                                <a href="mailbox.html">
                                    <div>
                                        <i class="fa fa-envelope fa-fw"></i> 您有16条未读消息
                                        <span class="pull-right text-muted small">4分钟前</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <a href="profile.html">
                                    <div>
                                        <i class="fa fa-qq fa-fw"></i> 3条新回复
                                        <span class="pull-right text-muted small">12分钟钱</span>
                                    </div>
                                </a>
                            </li>
                            <li class="divider"></li>
                            <li>
                                <div class="text-center link-block">
                                    <a class="J_menuItem" href="notifications.html">
                                        <strong>查看所有 </strong>
                                        <i class="fa fa-angle-right"></i>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </li>--%>
                    <%--<li class="hidden-xs">
                        <a href="index_v1.html" class="J_menuItem" data-index="0"><i class="fa fa-cart-arrow-down"></i> 购买</a>
                    </li>--%>
                    <li class="dropdown hidden-xs">
                        <a class="right-sidebar-toggle" aria-expanded="false">
                            <i class="fa fa-tasks"></i> 主题
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="row content-tabs">
            <button class="roll-nav roll-left J_tabLeft"><i class="fa fa-backward"></i>
            </button>
            <nav class="page-tabs J_menuTabs">
                <%--tab页标题,与content-main里面的iframe要一一对应(data-id)--%>
                <div class="page-tabs-content">
                    <a href="javascript:;" class="active J_menuTab" data-id="page/portal/home.jsp">首页</a>
                </div>
            </nav>
            <button class="roll-nav roll-right J_tabRight"><i class="fa fa-forward"></i>
            </button>
            <div class="btn-group roll-nav roll-right">
                <button class="dropdown J_tabClose" data-toggle="dropdown">关闭操作<span class="caret"></span>
                </button>
                <ul role="menu" class="dropdown-menu dropdown-menu-right">
                    <li class="J_tabShowActive"><a>定位当前选项卡</a>
                    </li>
                    <li class="divider"></li>
                    <li class="J_tabCloseAll"><a>关闭全部选项卡</a>
                    </li>
                    <li class="J_tabCloseOther"><a>关闭其他选项卡</a>
                    </li>
                </ul>
            </div>
            <a href="javascript:logout();" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <%--iframe容器--%>
        <div class="row J_mainContent" id="content-main" style="">
            <iframe class="J_iframe" name="iframe0" width="100%" height="100%" src="page/portal/home.jsp" frameborder="0" data-id="page/portal/home.jsp" seamless></iframe>
        </div>
        <div class="footer">
            <div class="pull-right">&copy; 2018 <a target="_blank">中国环境科学研究院</a>
            </div>
        </div>
    </div>
    <!--右侧部分结束-->
    <!--右侧边栏开始-->
    <div id="right-sidebar">
        <div class="sidebar-container">

            <ul class="nav nav-tabs navs-3">

                <li class="active">
                    <a data-toggle="tab" href="#tab-1">
                        <i class="fa fa-gear"></i> 主题
                    </a>
                </li>
                <%--<li class=""><a data-toggle="tab" href="#tab-2">
                    通知
                </a>
                </li>
                <li><a data-toggle="tab" href="#tab-3">
                    项目进度
                </a>
                </li>--%>
            </ul>

            <div class="tab-content">
                <div id="tab-1" class="tab-pane active">
                    <div class="sidebar-title">
                        <h3> <i class="fa fa-comments-o"></i> 主题设置</h3>
                        <small><i class="fa fa-tim"></i> 你可以从这里选择和预览主题的布局和样式，这些设置会被保存在本地，下次打开的时候会直接应用这些设置。</small>
                    </div>
                    <div class="skin-setttings">
                        <div class="title">主题设置</div>
                        <div class="setings-item">
                            <span>收起左侧菜单</span>
                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="collapsemenu" class="onoffswitch-checkbox" id="collapsemenu">
                                    <label class="onoffswitch-label" for="collapsemenu">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="setings-item">
                            <span>固定顶部</span>

                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="fixednavbar" class="onoffswitch-checkbox" id="fixednavbar">
                                    <label class="onoffswitch-label" for="fixednavbar">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="setings-item">
                                <span>
                        固定宽度
                    </span>

                            <div class="switch">
                                <div class="onoffswitch">
                                    <input type="checkbox" name="boxedlayout" class="onoffswitch-checkbox" id="boxedlayout">
                                    <label class="onoffswitch-label" for="boxedlayout">
                                        <span class="onoffswitch-inner"></span>
                                        <span class="onoffswitch-switch"></span>
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="title">皮肤选择</div>
                        <div class="setings-item default-skin nb">
                                <span class="skin-name ">
                         <a href="#" class="s-skin-0">
                             默认皮肤
                         </a>
                    </span>
                        </div>
                        <div class="setings-item blue-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-1">
                            蓝色主题
                        </a>
                    </span>
                        </div>
                        <div class="setings-item yellow-skin nb">
                                <span class="skin-name ">
                        <a href="#" class="s-skin-3">
                            黄色/紫色主题
                        </a>
                    </span>
                        </div>
                    </div>
                </div>
                <%--<div id="tab-2" class="tab-pane">

                    <div class="sidebar-title">
                        <h3> <i class="fa fa-comments-o"></i> 最新通知</h3>
                        <small><i class="fa fa-tim"></i> 您当前有10条未读信息</small>
                    </div>

                    <div>

                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a1.jpg">

                                    <div class="m-t-xs">
                                        <i class="fa fa-star text-warning"></i>
                                        <i class="fa fa-star text-warning"></i>
                                    </div>
                                </div>
                                <div class="media-body">

                                    据天津日报报道：瑞海公司董事长于学伟，副董事长董社轩等10人在13日上午已被控制。
                                    <br>
                                    <small class="text-muted">今天 4:21</small>
                                </div>
                            </a>
                        </div>
                        <div class="sidebar-message">
                            <a href="#">
                                <div class="pull-left text-center">
                                    <img alt="image" class="img-circle message-avatar" src="img/a2.jpg">
                                </div>
                                <div class="media-body">
                                    HCY48之音乐大魔王会员专属皮肤已上线，快来一键换装拥有他，宣告你对华晨宇的爱吧！
                                    <br>
                                    <small class="text-muted">昨天 2:45</small>
                                </div>
                            </a>
                        </div>
                    </div>

                </div>
                <div id="tab-3" class="tab-pane">

                    <div class="sidebar-title">
                        <h3> <i class="fa fa-cube"></i> 最新任务</h3>
                        <small><i class="fa fa-tim"></i> 您当前有14个任务，10个已完成</small>
                    </div>

                    <ul class="sidebar-list">
                        <li>
                            <a href="#">
                                <div class="small pull-right m-t-xs">9小时以后</div>
                                <h4>市场调研</h4> 按要求接收教材；

                                <div class="small">已完成： 22%</div>
                                <div class="progress progress-mini">
                                    <div style="width: 22%;" class="progress-bar progress-bar-warning"></div>
                                </div>
                                <div class="small text-muted m-t-xs">项目截止： 4:00 - 2015.10.01</div>
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                <div class="small pull-right m-t-xs">9小时以后</div>
                                <h4>可行性报告研究报上级批准 </h4> 编写目的编写本项目进度报告的目的在于更好的控制软件开发的时间,对团队成员的 开发进度作出一个合理的比对

                                <div class="small">已完成： 48%</div>
                                <div class="progress progress-mini">
                                    <div style="width: 48%;" class="progress-bar"></div>
                                </div>
                            </a>
                        </li>

                        <li>
                            <a href="#">
                                <span class="label label-primary pull-right">NEW</span>
                                <h4>设计阶段</h4>
                                <!--<div class="small pull-right m-t-xs">9小时以后</div>-->
                                项目进度报告(Project Progress Report)
                                <div class="small">已完成： 22%</div>
                                <div class="small text-muted m-t-xs">项目截止： 4:00 - 2015.10.01</div>
                            </a>
                        </li>

                    </ul>

                </div>--%>
            </div>

        </div>
    </div>
    <!--右侧边栏结束-->
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<%--H+首页相关js--%>
<script src="<%=URL_STATIC%>static/plugin/index_hplus/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="<%=URL_STATIC%>static/plugin/index_hplus/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=URL_STATIC%>static/plugin/index_hplus/js/hplus.js"></script>
<%--tab选项卡形式展示网页,要在所有相关的菜单(.J_menuItem)生产后加载--%>
<script type="text/javascript" src="<%=URL_STATIC%>static/plugin/index_hplus/js/contabs.js"></script>
<script src="<%=URL_STATIC%>static/plugin/index_hplus/js/plugins/pace/pace.min.js"></script>
</body>
</html>
