<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>教育信息搜索</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <!-- <link rel="stylesheet" href="css/person-document.css"> -->

    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_normal_form.js"></script>
    <style>
        .layui-input-inline {
            width: 180px;
        }

        .layui-input-inline input {
            height: 32px;
            background: #FCFCFC;
            border: 1px solid #DDDDDD;
            border-radius: 4px;
        }

        .layui-form {
            padding-top: 30px;
            padding-bottom: 30px;
            position: relative;
        }

        .edit-item {
            margin-bottom: 10px;
        }

        button.layui-btn-primary.save,
        button.layui-btn-primary.reset {
            /* width: 20px;
            height: 42px; */
            border-color: #1E9FFF;
            background-color: #1E9FFF;
            color: #fff;
            margin-top: 30px;
            /* margin-right: 50px; */
        }

        .lang input {
            width: 506px;
        }

        .layui-form-label {
            width: 90px;
        }
    </style>
</head>

<body>
<form class="layui-form layui-row" action="">
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">院校名称</label>
        <div class="layui-input-inline">
            <input type="text" name="universityName" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">专业名称</label>
        <div class="layui-input-inline">
            <input type="text" name="professionalName" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">起始时间</label>
        <div class="layui-input-inline">
            <input type="text" name="startTime" placeholder="" autocomplete="off" class="layui-input" id="start">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">终止时间</label>
        <div class="layui-input-inline">
            <input type="text" name="stopTime" placeholder="" autocomplete="off" class="layui-input" id="end">
        </div>
    </div>

    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">学　　历</label>
        <div class="layui-input-inline">
            <select name="education" class="joSelect" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
        </div>
    </div>

    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">学　　位</label>
        <div class="layui-input-inline">
            <select name="degree" class="joSelect" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
    </div>

<%--    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">学历</label>
        <div style="padding: 9px 15px;">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="所有" title="所有">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
        </div>
    </div>
    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">学位</label>
        <div style="padding: 9px 15px;">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="所有" title="所有">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
        </div>
    </div>--%>

    <!-- <button class="layui-btn layui-btn-primary reset">重置</button>
    <button class="layui-btn layui-btn-primary save">确认添加</button> -->
    <div class="layui-layer-btn layui-layer-btn- layui-col-md12 layui-col-xs12" style="text-align: center;">
        <button class="layui-btn layui-btn-primary reset">重置</button>
        <button class="layui-btn layui-btn-primary save">确认添加</button>
    </div>
</form>



<script>
    $(function() {
        layui.use(['form', 'laydate'], function() {
            var form = layui.form;
            var laydate = layui.laydate;
            laydate.render({
                elem: '#time',
            });

            //设置开始时间
            var startDate = laydate.render({
                elem: '#start', //开始时间选择控件id
                // min: '2018 - 6 - 1',
                type: 'date',
                format: 'yyyy-MM-dd', //可任意组合
                done: function(value, date) {
                    if (value !== '') {
                        endDate.config.min.year = date.year;
                        endDate.config.min.month = date.month - 1;
                        endDate.config.min.date = date.date;
                        endDate.config.min.hours = date.hours;
                        endDate.config.min.minutes = date.minutes;

                    } else {
                        endDate.config.min.year = '';
                        endDate.config.min.month = '';
                        endDate.config.min.date = '';
                        endDate.config.min.hours = '';
                        endDate.config.min.minutes = '';
                    }
                }
            });

            //设置结束时间
            var endDate = laydate.render({
                elem: '#end', //结束时间选择控件id
                type: 'date',
                format: 'yyyy-MM-dd', //可任意组合
                done: function(value, date) {
                    if (value !== '') {
                        startDate.config.max.year = date.year;
                        startDate.config.max.month = date.month - 1;
                        startDate.config.max.date = date.date;
                        startDate.config.max.hours = date.date;
                        startDate.config.max.minutes = date.date;
                    } else {
                        startDate.config.max.year = '';
                        startDate.config.max.month = '';
                        startDate.config.max.date = '';
                        startDate.config.max.hours = '';
                        startDate.config.max.minutes = '';
                    }
                }
            });

            $(".save").click(function() {
                parent.document.getElementsByClassName("education")[0].className += " active";
                //当你在iframe页面关闭自身时
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.layer.close(index); //再执行关闭

            })
        });


    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>