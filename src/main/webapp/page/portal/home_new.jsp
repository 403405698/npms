<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="../js/layui.js"></script>
    <link rel="stylesheet" href="../css/layui.css">
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../font/font2/iconfont.css">
    <link rel="stylesheet" href="../css/home.css">
</head>

<body>
<div class="layui-row txt">
    <div class="layui-col-md12">
        <p><a href="javascript:;">张三</a>上午好，欢迎登录</p>
        <p>您上次登录的时间为 2018-06-06 19:23 (不是您登录的？<a href="javascript:;">修改密码</a>)</p>
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
</body>

</html>