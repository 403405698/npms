<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<%--常量--%>
	<%@ include file="/common/constHead.jsp"%>
	<%--<title>中国环境科学研究院人事档案管理系统</title>--%>
	<link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
	<link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
	<link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/admin.css">
	<link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/style.css">


	<link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

	<script src="<%=URL_STATIC%>static/jquery/jquery-1.9.1.js"></script>
	<script src="<%=URL_STATIC%>static/jquery/jquery.cookie.js"></script>
	<script src="<%=URL_STATIC%>static/newjs/jo.js"></script>
	<script src="<%=URL_STATIC%>static/newjs/indexsta.js"></script>
	<script src="<%=URL_STATIC%>static/newjs/common.js"></script>

	<%--jo--%>
	<%@ include file="/common/joHead.jsp"%>
	<%--layer--%>
	<%@ include file="/common/layerHead.jsp"%>
	<%--公共--%>
	<%@ include file="/common/commonHead.jsp"%>
	<script>
        var pData = {};
        pData["id"] = "${loginUser.id }";
        $(function () {
            jo.postAjax("pms/pmsUser/get.action",pData,function (json) {
                if (json.code == 0 && json.data[0].photoAddress != null) {
                    $("#headerPic").attr("src","fs/file/image.action?id=" + json.data[0].photoAddress);
                }else {
                    $("#headerPic").attr("src","static/images/def_head.jpg");
                }
            });
        });
	</script>

</head>

<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<div class="layui-header">
		<%--<div class="layui-logo">
			<img class="left" src="<%=URL_STATIC%>static/newindex/image/logo.jpg" alt="中国环境科学研究院">
			<h2>中国环境科学研究院人事档案管理系统</h2>
		</div>--%>

		<div class="layui-nav layui-layout-right">
			<i class="iconfont icon-menu right"></i>
			<div class="line"></div>
			<img class="person-img right" src="" alt="">
			<div class="person right">
				<div class="position">${loginUser.roleName }</div>
				<div class="name">${loginUser.name }</div>
			</div>
		</div>
	</div>

	<!-- 固定的的右边菜单 -->
	<div class="fixed-nav">
		<div class="fixed-nav-content">
			<ul>
				<li>
					<a lay-href="javascript:;" onclick="logout()">
						<i class="iconfont icon-guanji"></i>
						<div>退出登录</div>
					</a>
				</li>
				<li>
					<a lay-href="javascript:;" onclick="openPageOnMain('page/personal/editDoc.jsp?edit=true')">
						<i class="iconfont icon-gerenxinxi"></i>
						<div>修改个人信息</div>
					</a>
				</li>
				<li>
					<a href="javascript:;" class="geshui">
						<i class="iconfont icon-geshui"></i>
						<div>个税计算器</div>
					</a>
				</li>
				<li>
					<a href="javascript:;" class="calculator-social-security">
						<i class="iconfont icon-jisuanqi"></i>
						<div>社保计算器</div>
					</a>
				</li>
				<li>
						<a lay-href="javascript:;" onclick="openPageOnMain('page/portal/common-web_no.jsp')">
							<i class="iconfont icon-wangzhan"></i>
							<div>常用网站</div>
						</a>
				</li>

                                <li>
                                    <a lay-href="personal-folders.html">
                                        <i class="iconfont icon-wenjianjia"></i>
                                        <div>个人文件夹</div>
                                    </a>
                                </li>
			</ul>
		</div>
	</div>


	<!-- 外置3级 -->
	<div id="outer3ji">

	</div>

	<!-- 侧边菜单 -->
	<div class="layui-side layui-side-menu">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">

			</ul>
		</div>
	</div>

	<div class="layui-body">
		<!-- 内容主体区域 -->
		<div class="layadmin-tabsbody-item layui-show" style="position: relative;height: 100%;">
			<iframe name="main" src="page/portal/home_no.jsp" frameborder="0" class="layadmin-iframe"></iframe>
		</div>
		<%--内容显示iframe--%>
		<%--<iframe name="main" class="main-iframe" src="<%=URL_STATIC%>page/statistic/pmStatistics.jsp" border="0" style="padding-bottom: 0px;"></iframe>--%>
		<%--/内容显示iframe--%>
	</div>



	<!-- <div class="layui-footer" style="text-align: right;padding-right: 45px;">
        Copyright @ 2018-2020 中国环境科学研究院人事档案管理系统
    </div> -->
</div>
<script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
<script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
<script>
    $(function() {
        //JavaScript代码区域
        layui.use('element', function() {
            var element = layui.element;
        });

        //在JS中使用了函数
        /*        $(".layui-nav-tree a").click(function() {
                    var href = $(this).attr("lay-href");
                    $(".layadmin-iframe").attr("src", href);
                })*/
        // 点击一级
        $(".mainAct").click(function() {
            $(".nav-child-list1").hide();
            $(".nav-child-list2").hide();
            $(".nav-child-list3").hide();
            $(".nav-child-list4").hide();
            $(".nav-child-list5").hide();
            $(".home").removeClass("layui-this");
            $(".layui-nav a").css("color", "#4a4a4a");
            $(".layui-nav a").css("background", "#fff");
            $(".layui-nav-child dd").removeClass("layui-this");
        })
        // 点击二级dd
        $(".layui-nav-child dd").click(function() {
            if ($(this).hasClass("layui-this")) {
                $(this).children("a").css("color", "#4ea0ff");
            }
        })
        // 点击首页
        $(".home").click(function() {
            $(".nav-child-list1").hide();
            $(".nav-child-list2").hide();
            $(".nav-child-list3").hide();
            $(".nav-child-list4").hide();
            $(".nav-child-list5").hide();
            $(".layui-nav-child dd").removeClass("layui-this");
            $(".layui-nav-item").removeClass("layui-nav-itemed");
            $(".layui-nav a").css("color", "#4a4a4a");
            $(".layui-nav a").css("background", "#fff");
        })
        // 点击二级
        $(".two-level").click(function(event) {
            event.stopPropagation();
            $(".nav-child-list1").hide();
            $(".nav-child-list2").hide();
            $(".nav-child-list3").hide();
            $(".nav-child-list4").hide();
            $(".nav-child-list5").hide();
            $(".layui-nav a").css("color", "#4a4a4a");
            $(".layui-nav a").css("background", "#fff");
            $(this).css("color", "#4ea0ff");
            $(this).css("background", "#fafafa");
        })

        $(".reviewe").click(function() {
            $('.nav-child-list2').hide();
            $('.nav-child-list1').show();
            $(".nav-child-list1").css("top", $(this).offset().top + 'px');
        })
        $(".flower").click(function() {
            $('.nav-child-list1').hide();
            $('.nav-child-list2').show();
            $(".nav-child-list2").css("top", $(this).offset().top + 'px');
        })
        $(".tongji").click(function() {
            $('.nav-child-list1').hide();
            $('.nav-child-list2').hide();
            $('.nav-child-list3').show();
            $(".nav-child-list3").css("top", $(this).offset().top + 'px');
        });
        //角色和单点
        $(".rolePermission").click(function() {
            $('.nav-child-list1').hide();
            $('.nav-child-list2').hide();
            $('.nav-child-list3').hide();
            $('.nav-child-list4').show();
            $(".nav-child-list4").css("top", $(this).offset().top + 'px');
        });
        $(".sso").click(function() {
            $('.nav-child-list1').hide();
            $('.nav-child-list2').hide();
            $('.nav-child-list3').hide();
            $('.nav-child-list4').hide();
            $('.nav-child-list5').show();
            $(".nav-child-list5").css("top", $(this).offset().top + 'px');
        });
        //角色end

        $(".nav-child-list1 a").click(function() {
            $(".nav-child-list1").hide();
            /*            var href = $(this).attr("lay-href");
                        $(".layadmin-iframe").attr("src", href);*/
        })
        $(".nav-child-list2 a").click(function() {
            $(".nav-child-list2").hide();
            /*            var href = $(this).attr("lay-href");
                        $(".layadmin-iframe").attr("src", href);*/
        })
        $(".nav-child-list3 a").click(function() {
            $(".nav-child-list3").hide();
            /*            var href = $(this).attr("lay-href");
                        $(".layadmin-iframe").attr("src", href);*/
        })
        //角色和单点
        $(".nav-child-list4 a").click(function() {
            $(".nav-child-list4").hide();
            /*           var href = $(this).attr("lay-href");
                       $(".layadmin-iframe").attr("src", href);*/
        })
        $(".nav-child-list5 a").click(function() {
            $(".nav-child-list5").hide();
            /*            var href = $(this).attr("lay-href");
                        $(".layadmin-iframe").attr("src", href);*/
        })
        //角色和单点end
        $(".fixed-nav a").click(function() {
            $(".fixed-nav").hide();
            // var href = $(this).attr("lay-href");
            // $(".layadmin-iframe").attr("src", href);
        })

        // 右侧浮动菜单
        $(".icon-menu").click(function(event) {
            event.stopPropagation();
            $(".fixed-nav").slideDown(600);
        })
        $(document.body).click(function() {
            $(".nav-child-list1").hide();
            $(".nav-child-list2").hide();
            $(".nav-child-list3").hide();
            $(".fixed-nav").hide();
        })
        layui.use(['layer', 'form', 'laydate'], function() {
            var form = layui.form;
            var layer = layui.layer;
            var laydate = layui.laydate;
            // 个税计算器
            $(".geshui").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '个人所得税计算器2018',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['600px', '450px'],
                    content: 'page/portal/calculator_no.jsp',
                    success: function(index) {
                        $(document.body).find(".layui-layer-title").css("fontSize", "18px");
                        $(document.body).find(".layui-layer-title").css("color", "#000000;");
                    }
                });
            })
            // 社保计算器
            $(".calculator-social-security").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '社保计算器2018',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['600px', '450px'],
                    content: 'page/portal/calculator-social-security_no.jsp',
                    success: function(index) {
                        $(document.body).find(".layui-layer-title").css("fontSize", "18px");
                        $(document.body).find(".layui-layer-title").css("color", "#000000;");
                    }
                });
            })
        })
    })
</script>
</body>

</html>