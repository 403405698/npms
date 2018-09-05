<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>教育经历</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
    <script src="<%=URL_STATIC%>static/final/js/lock-common.js"></script>

    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_normal_form.js"></script>

    <script>
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "auditPKName" : "id",//用于获取审核库数据时用到的主键字段类是userID获取到的是list，必须写
                "saveAfter" : "",//保存之后是关闭还是继续编辑toEdit默认close
                "addUrl" : "pms/auditPmsEducation/auditInsert.action",//新增
                "deleteUrl" : "pms/education/delete.action",//删除
                "updateUrl" : "pms/auditPmsEducation/update.action",//修改
                "formDataUrl" : "pms/education/get.action",	//正式库信息
                "auditDataUrl" : "pms/auditPmsEducation/get.action",//审核库中的信息,列表类此参数其实没用到
            };

            var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
            if (jo.isValid(sf)) {
                jParams["addUrl"] = "pms/auditPmsEducation/auditInsert.action?sf=rs";
                jParams["updateUrl"] = "pms/auditPmsEducation/update.action?sf=rs";
            }

            joForm.initFormPage(jParams);//初始化
        });
        joForm.spliceStatus = function(formAuditData){
            // if (loginUser.roleName == "普通员工") {
            if (loginUser.roleId == "72b51c53a39744fe9d8b380910c77e63") {
                if (formAuditData.lockStatus == 1 || formAuditData.lockStatus == "") {
                    $("input[type!='hidden']").attr("disabled", "disabled");
                    $("input").attr("background", "#FFF");
                    $("input").css("border", "none");
                    $("select").attr("disabled", "disabled");
                    $("textarea").attr("disabled","disabled");
                }
            }
        }

        joForm.initFormValueAfter = function(){
        };
        //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
        joForm.initFormPageOfAdd = function(){
            userIdHandleInAddForm();//userId字段处理
        }
    </script>
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

        button.layui-btn-primary.save {
            width: 240px;
            height: 42px;
            background: #62abff;
            color: #fff;
            position: absolute;
            bottom: -30px;
            left: 35%;
        }

        .lang input,
        .layui-input-inline.lang {
            width: 506px;
        }
    </style>
</head>

<body>
<form id="pageForm" class="layui-form layui-row" action="">
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">起始时间</label>
        <div class="layui-input-inline">
            <input type="hidden" id="userId" name="userId" />
            <input type="hidden" id="id" name="id"/>
            <input type="hidden" name="orderNum" value="10"/>
            <input type="text" name="startTime" placeholder="格式：2018.08" ErrBirthBad4 autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">终止时间</label>
        <div class="layui-input-inline">
            <input type="text" name="stopTime" placeholder="格式：2018.08" ErrEmpty autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md12 layui-col-xs12 ">
        <label class="layui-form-label">内容</label>
        <div class="layui-input-inline" style="width: calc(100% - 140px);">
            <textarea class="layui-textarea" name="content" placeholder="请填写此项！格式：某学校某专业某学历" ErrEmpty id="content" cols="10"></textarea>
        </div>
    </div>

    <button type="button" class="layui-btn layui-btn-primary save" isShow="joForm.isAdd" onclick="joForm.save()">保存</button>
    <button type="button" class="layui-btn layui-btn-primary save" isShow="!joForm.isAdd" onclick="joForm.update()">修改</button>
</form>



<script>
    $(function() {
        layui.use(['form', 'laydate'], function() {
            var form = layui.form;
            var laydate = layui.laydate;
            //设置开始时间
/*            var startDate = laydate.render({
                elem: '#start', //开始时间选择控件id
                // min: '2018 - 6 - 1',
                type: 'datetime',
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
                type: 'datetime',
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
            });*/
        });
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>