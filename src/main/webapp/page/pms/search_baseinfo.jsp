<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>基本信息搜索</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <!-- <link rel="stylesheet" href="css/person-document.css"> -->
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">

    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_normal_form.js"></script>
    <style>
        .layui-input-inline {
            width: 140px;
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

        .layui-form {
            padding-top: 30px;
            padding-bottom: 30px;
            position: relative;
            padding-right: 30px;
        }

        .choose-btn {
            height: 32px;
            background: #fff;
            border: 1px solid #ccc !important;
            font-size: 12px;
            padding: 0 10px;
            line-height: 32px;
        }

        .input-group-btn {
            position: absolute;
            right: 0;
            bottom: 0;
        }
    </style>
</head>

<body>
<form class="layui-form layui-row" action="">
    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">性别</label>
        <div class="layui-input-inline">
            <select async="true" name="sex" class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue"
                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}' lay-verify=""></select>
        </div>
    </div>
    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">民族</label>
        <div class="layui-input-inline">
            <select async="true" name="nation" lay-verify="" class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue"
                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
    </div>


    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">在职学历</label>
        <div class="layui-input-inline">
            <select async="true" name="jobEducation" lay-verify="" class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION"
                    keyfield="dicValue" valuefield="dicValue"
                    firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
    </div>
    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">在职学位</label>
        <div class="layui-input-inline">
            <select async="true" name="jobDegree" lay-verify="" class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue"
                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
    </div>

    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">行政职务</label>
        <div class="layui-input-inline">
            <input type="text" name="administrativeDuty" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">所属部门</label>
        <div class="layui-input-inline">
            <input type="text" id="branch" name="PARENT_NAME" class="layui-input">
            <span class="input-group-btn">
                        <button class="layui-btn layui-btn-primary choose-btn" type="button">
                            <i class="iconfont icon-menu" aria-hidden="true"></i>&nbsp;选择
                        </button>
             </span>
        </div>
    </div>
<%--    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">年龄段</label>
        <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="startY" style="width: 100px;display: inline-block;">
        <!-- <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="startM" style="width: 50px;display: inline-block;"> -->
        <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="endY" style="width: 100px;display: inline-block;">
        <!-- <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="endM" style="width: 50px;display: inline-block;"> -->
    </div>--%>

    <div class="edit-item layui-col-md4 layui-col-xs4">
        <label class="layui-form-label">行政级别</label>
        <div class="layui-input-inline">
            <select async="true" name="administrativeLevel" class="joSelect"
                    data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL"
                    keyfield="dicValue" valuefield="dicValue"
                    firstitem='{"dicValue":"","dicValue":""}'></select>
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
    </div>--%>
<%--    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">学位</label>
        <div style="padding: 9px 15px;">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="所有" title="所有">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="学士" title="学士">
        </div>
    </div>--%>
<%--    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">行政级别</label>
        <div style="padding: 9px 15px;">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="所有" title="所有">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="局长" title="局长">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="局长" title="局长">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="局长" title="局长">
        </div>
    </div>
    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">职称</label>
        <div style="padding: 9px 15px;">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="所有" title="所有">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="人事处长" title="人事处长">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="人事处长" title="人事处长">
            <input type="checkbox" name="" class="col-item" lay-skin="primary" value="人事处长" title="人事处长">
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
            // laydate.render({
            //     elem: '#startM',
            //     type: 'month',
            // });
            // laydate.render({
            //     elem: '#endM',
            //     type: 'month',
            // });
            $(".save").click(function() {
                parent.document.getElementsByClassName("primary")[0].className += " active";
                //当你在iframe页面关闭自身时
                var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                parent.layer.close(index); //再执行关闭

            })

            var newpsw;
            $(".choose-btn").click(function() {
                var indext = layer.open({ /*弹出框*/
                    type: 2,
                    title: '选择',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['550px', '260px'],
                    content: 'branch.html',
                    success: function(index) {
                        newpsw = window[index.find('iframe')[0]['name']];
                    },
                    end: function() {
                        var value = newpsw.getChoseId();
                        $("#branch").val(value);
                    }

                })
            })

            //设置开始时间
            var startDate = laydate.render({
                elem: '#startY', //开始时间选择控件id
                // min: '2018 - 6 - 1',
                type: 'month',
                format: 'yyyy-MM', //可任意组合
                done: function(value, date) {
                    if (value !== '') {
                        endDate.config.min.year = date.year;
                        endDate.config.min.month = date.month - 1;
                        // endDate.config.min.date = date.date;
                        // endDate.config.min.hours = date.hours;
                        // endDate.config.min.minutes = date.minutes;

                    } else {
                        endDate.config.min.year = '';
                        endDate.config.min.month = '';
                        // endDate.config.min.date = '';
                        // endDate.config.min.hours = '';
                        // endDate.config.min.minutes = '';
                    }
                }
            });


            //设置结束时间
            var endDate = laydate.render({
                elem: '#endY', //结束时间选择控件id
                type: 'month',
                format: 'yyyy-MM', //可任意组合
                done: function(value, date) {
                    if (value !== '') {
                        startDate.config.max.year = date.year;
                        startDate.config.max.month = date.month - 1;
                        // startDate.config.max.date = date.date;
                        // startDate.config.max.hours = date.date;
                        // startDate.config.max.minutes = date.date;
                    } else {
                        startDate.config.max.year = '';
                        startDate.config.max.month = '';
                        // startDate.config.max.date = '';
                        // startDate.config.max.hours = '';
                        // startDate.config.max.minutes = '';
                    }
                }
            });
        });


    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>