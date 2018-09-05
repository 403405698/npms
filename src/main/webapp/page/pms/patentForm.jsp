<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>家庭成员编辑</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
    <!-- <link rel="stylesheet" href="css/person-document.css"> -->
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
                "addUrl" : "pms/auditPmsPatent/auditInsert.action",//新增
                "deleteUrl" : "pms/auditPmsPatent/delete.action",//删除
                "updateUrl" : "pms/auditPmsPatent/update.action",//修改
                "formDataUrl" : "pms/patent/get.action",	//正式库信息
                "auditDataUrl" : "pms/auditPmsPatent/get.action"//审核库中的信息,列表类此参数其实没用到
            };

            var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
            console.log("打印表单属性sf："  + sf);
            if (jo.isValid(sf)) {
                jParams["addUrl"] = "pms/auditPmsPatent/auditInsert.action?sf=rs";
                jParams["updateUrl"] = "pms/auditPmsPatent/update.action?sf=rs";
            }

            joForm.initFormPage(jParams);//初始化
        });
        joForm.spliceStatus = function(formAuditData){
            console.log("JSP打印参数；" + JSON.stringify(formAuditData));
            console.log("JSP打印参数条目是否锁定1：" + (formAuditData.lockStatus));
            // if (loginUser.roleName == "普通员工") {
            if (loginUser.roleId == "72b51c53a39744fe9d8b380910c77e63") {
                if (formAuditData.lockStatus == 1 || formAuditData.lockStatus == "") {
                    $("input[type!='hidden']").attr("disabled", "disabled");
                    $("input").attr("background", "#FFF");
                    $("input").css("border", "none");
                    $("select").attr("disabled", "disabled");
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

        .layui-form-label {
            width: 90px;
        }
    </style>
</head>

<body>
<form id="pageForm" class="layui-form layui-row" action="">
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">专利名称</label>
        <div class="layui-input-inline">
            <input type="text" name="patentName" ErrEmpty placeholder="" autocomplete="off" class="layui-input">
            <input type="hidden" id="userId" name="userId" />
            <input type="hidden" id="id" name="id"/>
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">专 利 号</label>
        <div class="layui-input-inline">
            <input type="text" name="patentNumber" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">专利类型</label>
        <div class="layui-input-inline">
            <select name="patentType" class="joSelect" data="" dataurl="pms/pmsDictionary/getListByDictionary/PATENT_TYPE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">年　　月</label>
        <div class="layui-input-inline">
            <input type="text" name="years" placeholder="" autocomplete="off" class="layui-input" id="time">
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">是否转让</label>
        <div class="layui-input-inline">
            <select  name="isAttorn">
                <option value=""></option>
                <option value="是">是</option>
                <option value="否">否</option>
            </select>
        </div>
    </div>
    <div class="edit-item layui-col-md6 layui-col-xs6">
        <label class="layui-form-label">转让金额</label>
        <div class="layui-input-inline">
            <input type="text" name="attornMoney" placeholder="" autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="edit-item layui-col-md12 layui-col-xs12">
        <label class="layui-form-label">排　　名</label>
        <div class="layui-input-inline lang">
            <input type="text" name="ranking" placeholder="" autocomplete="off" class="layui-input">
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
/*            laydate.render({
                elem: '#time'
                ,type: 'month'//new
            });*/
        });
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>
