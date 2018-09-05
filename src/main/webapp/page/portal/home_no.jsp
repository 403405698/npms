<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>首页</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--jo--%>
    <%@ include file="/common/joHead.jsp"%>
     <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/layui.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/font/font2/iconfont.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/prototype/css/home.css">
   <script src="<%=URL_STATIC%>static/prototype/js/layui.js"></script>
    <script type="text/javascript">
        $(function () {
          /*  goto();
            initChoose();*/
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


     /*   function goto(){
            if (jo.isValid(sf)) {
                $("ul a").each(function(){
                    $(this).attr("lay-href",$(this).attr("lay-href") + userId + "&sf=rs");
                });
            }else {
                $("ul a").each(function(){
                    $(this).attr("lay-href",$(this).attr("lay-href") + userId);
                });
            }
            if (jo.isValid(_edit)){
                $("ul a").each(function(){
                    $(this).attr("lay-href",$(this).attr("lay-href") + "&edit=true");
                });
            }
        }
        function initChoose() {
            if (jo.isValid(sf)) {
                $("#deptchoose").show();
            }
        }*/
    </script>
</head>

<body>
    <div class="layui-row txt">
        <div class="layui-col-md12">
            <p><a  href="<%=basePath%>page/personal/myDoc.jsp?id=">${loginUser.name} </a> <span id="timer">早上</span>好，欢迎登录</p>
            <p>您上次登录的时间为 <span id="lastLoginTime"></span> （不是您登录的？
                    <a class="cursor-hand"   href="<%=basePath%>page/personal/password_no.jsp?id=">修改密码</a>）</p>
        </div>
    </div>
    <div class="layui-row home-row">
        <div class="calendar layui-col-md6">
            <div class="home-tit clear">
                <span class="left">日历</span>
                <i class="right layui-icon  layui-icon-triangle-d"></i>
            </div>
            <div id="test2"></div>
        </div>
        <div class="layui-col-md6 announcement">
            <div class="home-tit clear">
                <span class="left">公告</span>
                <i class="layui-icon layui-icon-triangle-r right"></i>
                <a class="right more" href="announcement-list.html">更多</a>
            </div>
            <ul>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">
                        2018/06/21
                    </span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
                <li class="clear">
                    <a href="javascript:;" class="left">
                        <i class="iconfont icon-quan"></i>陈斌书记应邀率团访问澳大利亚联邦科学与工业研究组织并签署科研合作谅解备忘录
                    </a>
                    <span class="date right">2018/06/21</span>
                </li>
            </ul>
        </div>
    </div>
    <div class="footer">
        Copyright @ 2018-2020 中国环境科学研究院人事档案管理系统
    </div>


    <script>
        layui.use(['layer', 'laydate'], function() {
            var layer = layui.layer,
                laydate = layui.laydate;

            laydate.render({ /*日历*/
                elem: '#test2',
                position: 'static',
                /*底部按钮*/
                showBottom: false
            });
        })
    </script>
    <script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>

</html>