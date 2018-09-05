<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>工作经历审核</title>
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
                "addUrl" : "pms/auditPmsWork/auditInsert.action",//新增
                "deleteUrl" : "pms/auditPmsWork/delete.action",//删除
                "updateUrl" : "pms/auditPmsWork/update.action",//修改
                "formDataUrl" : "pms/work/get.action",	//正式库信息
                "auditDataUrl" : "pms/auditPmsWork/get.action",//审核库中的信息,列表类此参数其实没用到
            };

            var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
            // if (jo.isValid(sf)) {
            jParams["addUrl"] = "pms/auditPmsWork/auditInsert.action?sf=rs";
            jParams["updateUrl"] = "pms/auditPmsWork/update.action?sf=rs";
            // }

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
    <script>
        function save() {
            var dataArr = new Array();
            var content = $("#content").val();
            var arr = content.split(/\n/);
            if (jo.isValid(content)) {
                for (var i=0;i<arr.length;i++) {
                    console.log("arr:" + arr[i]);
                    var item = arr[i];
                    if (item.indexOf("--") < 1) {
                        jo.showMsg("请输入正确的格式！");
                        return;
                    }

                    var itemArr = item.split("--");//~ 半角空格

                    var s_index = -1;
                    if (itemArr[1] != "") {
                        s_index = itemArr[1].indexOf(" ");
                    }else {
                        jo.showMsg("请输入正确的格式！");
                        return;
                    }
                    var str_content = "";
                    if (s_index > -1) {
                        str_content = itemArr[1].substring(s_index+1);
                        str_content = str_content.replace(/\s+/g,"");
                    }else {
                        jo.showMsg("请输入正确的格式！");
                        return;
                    }

                    var end_time = itemArr[1].substring(0,s_index);
                    // console.log("str_content" + str_content);
                    var oData = {};
                    oData["startTime"] = itemArr[0];
                    oData["stopTime"] = end_time;
                    oData["content"] = str_content;
                    oData["userId"] = $("#userId").val();
                    oData["status"] = 1;
                    oData["lockStatus"] = 2;

                    var num_o = jo.getUrlParam("num");
                    if (!jo.isValid(num_o)){
                        num_o = 10;
                    }else {
                        num_o = parseInt(num_o);
                    }
                    oData["orderNum"] = num_o;

                    dataArr.push(oData);
                    for (var j=0;j<itemArr.length;j++) {
                        console.log("item:" + itemArr[j]);
                    }
                }

                console.log("打印数组数据；" + JSON.stringify(dataArr));
                var pData;
                if (dataArr.length > 0) {
                    pData = JSON.stringify(dataArr)
                } else {
                    pData = {};
                }
                console.log("打印发送数据；" + JSON.stringify(pData));
                var sUrl = "pms/auditPmsWork/rsBatchInsert.action";
                sUrl = jo.parseUrl(sUrl);//解析url
                $.ajax({
                    url: sUrl,
                    type: "POST",
                    contentType : 'application/json;charset=utf-8', //设置请求头信息
                    dataType:"json",
                    data: pData,
                    success: function(data){
                        console.log("返回数据：" + JSON.stringify(data));
                        if (data.code == 0) {

                            try{
                                window.parent.reloadCurrentPage();//重新加载父页面数据
                            }catch(err){}
                            if(joForm.params["saveAfter"] == "toEdit"){//保存之后的操作,toEdit表示去编辑
                                if(jo.isValid(oData[joForm.params["PKName"]])){
                                    console.log("保存表单打印主键参数；" + joForm.params["PKName"]+"="+oData[joForm.params["PKName"]]);
                                    window.location.href = window.location.href+jo.getLinkSign(window.location.href)+joForm.params["PKName"]+"="+oData[joForm.params["PKName"]];
                                }else{
                                    console.log("关闭弹窗自己");
                                    jo.closeSelf('WIN_ADD');
                                }
                            }else{
                                console.log("关闭弹窗父级");
                                window.parent.jo.close('WIN_ADD');
                            }
                            window.parent.jo.showMsg("保存成功!");
                        }else {
                            jo.showMsg(data.info)
                        }
                    },
                    complete : function(jqXHR,textStatus){
                        if(jo.isValid(jqXHR.responseText)){//后台传的json字符串
                            var re = '';
                            try{
                                re = JSON.parse(jqXHR.responseText);
                                // console.log("re" + JSON.stringify(re));
                            }catch(err){
                                if(textStatus == "error"){

                                }
                            }
                            if(jo.isValid(re) && re.code == '-101'){//session过期异常代码
                                if(re.redirectTo){
                                    top.window.location.href = re.redirectTo;
                                }else{
                                    top.window.location.href = jo.getDefVal(URL_UMS, contextPath) + jo.Const.URI_LOGOUT;//登出
                                }
                                //top.window.location.href ="page/jsp/login.jsp";  //跳转页面
                            }else if(jo.isValid(re) && re.code == '-102'){//平台业务异常代码
                                jo.showMsg(jo.getDefVal(re.info,"非法操作!"));
                            }else if(jo.isValid(re) && re.code == '-901'){//平台业务异常代码
                                jo.showMsg(jo.getDefVal(re.info,"*系统异常!"));
                            }else if(jo.isValid(re) && re.code == '-999'){//系统异常代码
                                jo.showMsg("*系统出现异常,请与管理员联系!");
                            }else{

                            }
                        }else{

                        }
                    },
                    error: function(res){
                        // alert("err:"+res.responseText);
                    }
                });
            }else {
                jo.showMsg("请输入正确的格式！");
            }

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
    <%--    <div class="edit-item layui-col-md6 layui-col-xs6">
            <label class="layui-form-label">起始时间</label>
            <div class="layui-input-inline">
                <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="edit-item layui-col-md6 layui-col-xs6">
            <label class="layui-form-label">终止时间</label>
            <div class="layui-input-inline">
                <input type="text" name="" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>--%>
    <div class="edit-item layui-col-md12 layui-col-xs12 ">
        <label class="layui-form-label">内容</label>
        <div class="layui-input-inline" style="width: calc(100% - 140px);">
            <input type="hidden" id="userId" name="userId" />
            <input type="hidden" id="id" name="id"/>
            <textarea class="layui-textarea" name="content" placeholder="格式：起始时间-结束时间 详细内容。例如：2018.09--2019.06 环科院人事部普通员工。说明：时间之间用两个减号分割，内容与时间之间用空格即可" id="content" cols="50" style="height:300px;"></textarea>
        </div>
    </div>

    <button type="button" class="layui-btn layui-btn-primary save" isShow="joForm.isAdd" onclick="save()">保存</button>
    <%--<button type="button" class="layui-btn layui-btn-primary save" isShow="!joForm.isAdd" onclick="joForm.update()">修改</button>--%>
</form>



<script>
    $(function() {
        layui.use(['form', 'laydate'], function() {
            var form = layui.form;
            var laydate = layui.laydate;
            //设置开始时间
            var startDate = laydate.render({
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
            });
        });
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>