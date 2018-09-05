<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>个人档案</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
    <!-- <link rel="stylesheet" href="css/announcement-list.css"> -->
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/common.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/person-document.css">
    <script src="<%=URL_STATIC%>static/final/js/common.js"></script>

    <%--<script src="<%=URL_STATIC%>static/plugin/jo/jo.js"></script>--%>
    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <%@ include file="/common/uploadHeadOfImg.jsp" %>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("id"), loginUser.id);
        var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
        var _edit = jo.getDefVal(jo.getUrlParam("edit"),"");

        var officialData = {};
        var formAuditData = {};
        var auditPhotoAddress;//审核库中的图片地址
        $(function () {
            loadBaseInfo();
            initFormValue();
            loadUserDept();
            initStatus();
        });
        //加载基础信息
        function loadBaseInfo(){
            var auditData = jo.postAjax("pms/auditRecordBaseinfo/getUserAuditInfo",{"userId":userId});
            if(auditData != null && auditData.data.length > 0 && auditData.data[0]){
                formAuditData = auditData.data[0];//存放到form.formData,方便调用
            }else{
                formAuditData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
            }

            var result = jo.postAjax("pms/pmsUser/get.action",{"id":userId});
            if(result != null && result.data.length > 0 && result.data[0]){
                officialData = result.data[0];//存放到form.formData,方便调用
            }else{
                officialData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
            }
        }
        //赋值start
        function initFormValue(json) {
            json = formAuditData;
            var inp = $("#pageForm").find("input[type!='button'][type!='radio'][type!='checkbox'][type!='file']");//文本框
            for(var i=0;i<inp.length;i++){
                //获取name
                var element = $(inp[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<json.length;f++) {
                    if (key == json[f]["fieldKey"]){//找到同name
                        element.val(json[f]["fieldVal"]);//赋值
                        if (key == "photoAddress") {
                            if (typeof (formAuditData[f]["fieldVal"]) != "undefined") {
                                auditPhotoAddress = formAuditData[f]["fieldVal"];
                            }
                        }
                    }
                }
                //新改：重新赋值一遍，新用户提交时审核库汇中不包含ID和userid start
                if (key == "id" || key == "userId") {
                    element.val(officialData[key]);//赋值
                }
                if (formAuditData.length < 1) {
                    element.val(officialData[key]);//赋值
                }
                //新改：新用户提交时不包含ID和userid end

            }

            var sel = $("#pageForm").find("select");//下拉列表
            for(var i=0;i<sel.length;i++){
                //获取name
                var element = $(sel[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<json.length;f++) {
                    if (key == json[f]["fieldKey"]) {//找到同name\
                        if(typeof (json[f]["fieldVal"]) != "undefined"){
                            element.val(json[f]["fieldVal"]);//赋值
                            layui.use('form', function() {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    }
                }
                //审核库信息为空
                if (formAuditData.length < 1) {
                    if(typeof (officialData[key]) != "undefined"){
                        element.val(officialData[key]);//赋值
                    }
                }
            }

            //jo下拉列表组件异步回显处理--通过调用setValue来赋值
            var joSel = $("#pageForm").find(".joSelect");
            for(var i=0;i<joSel.length;i++){
                var element = joSel[i];//元素
                var key = jo.getDefVal(element.getAttribute("name"), element.getAttribute("id"));
// 新改：处理下拉列表
                for (var f=0;f<json.length;f++) {
                    if (key == json[f]["fieldKey"]) {//找到同name\
                        if(typeof (json[f]["fieldVal"]) != "undefined"){
                            var joSId = jo.getDefVal(element.getAttribute("id"), element.getAttribute("name"));//jo组件id
                            var jos = JoSelectTool[joSId];//jo下拉对象

                            if(jos){
                                jos.setValue(json[f]["fieldVal"]);//安全的赋值方法
                            }
                            layui.use('form', function() {
                                var form = layui.form;
                                form.render();
                            });
                        }
                    }
                }
                //审核库信息为空
                if (formAuditData.length < 1) {
                    if(typeof (officialData[key]) != "undefined"){
                        var joSId = jo.getDefVal(element.getAttribute("id"), element.getAttribute("name"));//jo组件id
                        var jos = JoSelectTool[joSId];//jo下拉对象
                        if(jos){
                            jos.setValue(officialData[key]);//安全的赋值方法
                        }
                        layui.use('form', function() {
                            var form = layui.form;
                            form.render();
                        });
                    }
                }
            }
            // $("#header").attr("src", URL_FS + "fs/file/image.action?id=" + joForm.formData.photoAddress);
            if (jo.isValid(auditPhotoAddress)) {
                $("#header").attr("src", URL_FS + "fs/file/image.action?id=" + auditPhotoAddress);//使用审核库中的信息
            }
        }
        //赋值end
        //设置状态和锁定start
        function initStatus() {
            var elements = document.getElementById("pageForm").elements;
            for (var i=0;i<elements.length;i++) {
                var element = $(elements[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<formAuditData.length;f++) {
                    if (key == formAuditData[f]["fieldKey"]){ //找到同name
                        //后面拼接一下锁定状态显示和审核状态显示 start
                        //去除隐藏的input标签
                        if (element.attr("type") != "hidden")  {
                            //锁定状态拼接start
                            var status_html = "<span class=\"iconfont show\">";
                            if (formAuditData[f]["lockStatus"] != 1) {
                                element.removeAttr("disabled");
                            }
                            if (formAuditData[f]["lockStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-suoding\"></i>";
                                if ("tempWorkExperience" == formAuditData[f]["fieldKey"] && element[0].type == "select-one") {
                                    element.attr("disabled","disabled");
                                }
                                if ("toThereTime" == formAuditData[f]["fieldKey"]) {
                                    element.attr("disabled","disabled");
                                }
                            }
                            //锁定状态拼接end
                            if (formAuditData[f]["auditStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-duihao\"></i>";
                            }
                            else if (formAuditData[f]["auditStatus"] == 2) {
                                status_html += "<i class=\"iconfont icon-error\"></i>";
                            }
                            else {
                                //待审核
                                status_html += "<i class=\"iconfont icon-smenu\"></i>";
                            }
                            status_html += "</span>";
                            element.after(status_html);
                        }
                        //后面拼接一下锁定状态显示和审核状态显示 end
                    }
                    //rs
                    if (jo.isValid(sf)) {
                        element.removeAttr("disabled");
                    }
                    //rs
                }

                //处理审核库中没有数据时无法修改问题start
                if (formAuditData.length == 0) {
                    element.removeAttr("disabled");
                }
                //处理审核库中没有数据时无法修改问题end
            }

            //新增：处理img start
            var img = $("#pageForm").find("img");
            for(var i=0;i<img.length;i++) {
                var element = $(img[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<formAuditData.length;f++) {
                    if ("photoAddress" == formAuditData[f]["fieldKey"]) {//找到同name
                        if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                            var status_html = "<span class=\"iconfont show\" style=\"position: absolute;bottom:-24px;left: 0px\">";
                            if (formAuditData[f]["lockStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-suoding\"></i>";
                                //锁定不可编辑，移除事件
                                if (!jo.isValid(sf)) {
                                    element.removeAttr("onclick");

                                }

                            }
                            //锁定状态拼接end
                            if (formAuditData[f]["auditStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-duihao\"></i>";
                            }
                            else if (formAuditData[f]["auditStatus"] == 2) {
                                status_html += "<i class=\"iconfont icon-error\"></i>";
                            }
                            else {
                                status_html += "<i class=\"iconfont icon-smenu\"></i>";
                            }
                            status_html += "</span>";
                            element.after(status_html);
                        }
                    }
                }
            }
            //处理img end
        }
        //设置状态和锁定end
        function checkForm(oForm){
            //必填/非空验证
            var emptys = oForm.find("input[ErrEmpty]");
            for(var i=0;i<emptys.length;i++){
                var e = emptys[i];
                var val = $(e).val();
                if(val == ""){
                    jo.showMsg(jo.getDefVal($(e).attr("ErrEmpty"),"该项不可以为空！"));//提示信息
                    $(e).focus();//获取焦点
                    return false;
                }
            }
            //select下拉列表的非空验证
            emptys = oForm.find("select[ErrEmpty]");
            for(var i=0;i<emptys.length;i++){
                var e = emptys[i];
                var val = $(e).val();
                if(val == ""){
                    jo.showMsg(jo.getDefVal($(e).attr("ErrEmpty"),"该项不可以为空！"));//提示信息
                    $(e).focus();//获取焦点
                    return false;
                }
            }
            //长度验证
            var lengths = oForm.find("input[ErrLength]");
            for(var i=0;i<lengths.length;i++){
                var e = lengths[i];
                var len = $(e).attr("ErrLength");//限制长度
                var val = $(e).val();//值
                //alert(len+"--"+val);
                if(jo.isValid(len) && jo.isValid(val)){//长度和值均有效时,判断是否超过长度
                    if(val.length > parseInt(len)){//长度超过
                        jo.showMsg(jo.getDefVal($(e).attr("ErrInfo"),"该项超过最大长度["+len+"]！"));//提示信息
                        $(e).focus();//获取焦点
                        return false;
                    }
                }
            }

            //数字验证
            var numbers = oForm.find("input[ErrNumber]");
            for(var i=0;i<numbers.length;i++){
                var e = numbers[i];
                //var len = $(e).attr("ErrLength");//限制长度
                var val = $(e).val();//值
                if(jo.isValid(val)){//值有效时,判断是否是数字类型
                    if(isNaN(val)){
                        jo.showMsg(jo.getDefVal($(e).attr("ErrNumber"),"该值必须是数字类型！"));//提示信息
                        $(e).focus();//获取焦点
                        return false;
                    }
                }
            }

            //生日验证验证
            var births = oForm.find("input[ErrBirth]");
            var reg_birth = /^(\d{4})(-)(\d{2})(-)(\d{2})$/;
            for(var i=0;i<births.length;i++){
                var e = births[i];
                var val = $(e).val();//值
                // if(jo.isValid(val)){//值有效时,判断是否是数字类型
                    if(!reg_birth.test(val)){
                        jo.showMsg(jo.getDefVal($(e).attr("ErrBirth"),"请填写正确的日期格式！"));//提示信息
                        $(e).focus();//获取焦点
                        return false;
                    }
                // }
            }

            //生日验证验证年月
            var births4 = oForm.find("input[ErrBirth4]");
            var reg_birth4 = /^(\d{4})(-)(\d{2})$/;
            for(var i=0;i<births4.length;i++){
                var e = births4[i];
                var val = $(e).val();//值
                // if(jo.isValid(val)){//值有效时,判断是否是数字类型
                if(!reg_birth4.test(val)){
                    jo.showMsg(jo.getDefVal($(e).attr("ErrBirth4"),"请填写正确的年月格式！"));//提示信息
                    $(e).focus();//获取焦点
                    return false;
                }
                // }
            }


//TODO BT START

            var birthsBad6 = $("#pageForm").find("input[ErrBirthBad]");
            var areg_birthB1 = /^(\d{4})(-)(\d{2})(-)(\d{2})$/;
            var areg_birthB2 = /^(\d{4})(\d{2})(\d{2})$/;
            var areg_birthB3 = /^(\d{4})(\.)(\d{2})(\.)(\d{2})$/;
            var areg_birthB4 = /^(\d{4})(\/)(\d{2})(\/)(\d{2})$/;
            for(var i=0;i<birthsBad6.length;i++){
                var e = birthsBad6[i];
                // $(e).blur(function () {
                var val = $(e).val();//值
                if(val != ""){//可以不填
                    if(areg_birthB1.test(val) || areg_birthB2.test(val) || areg_birthB3.test(val) || areg_birthB4.test(val)){
                        /*          if (areg_birthB1.test(val)) {

                                  }*/
                        if (areg_birthB2.test(val)) {

                            var _val = val.substring(0,4) + "-" + val.substring(4,6) + "-"+val.substring(6);
                            $(e).val(_val);
                        }
                        else if (areg_birthB3.test(val)) {
                            var _val = val.substring(0,4) + "-" + val.substring(5,7)+"-"+val.substring(8);
                            $(e).val(_val);
                        }
                        else  if (areg_birthB4.test(val)) {
                            var _val = val.substring(0,4) + "-" + val.substring(5,7)+"-"+val.substring(8);
                            $(e).val(_val);
                        }else {

                        }
                    }else {
                        jo.showMsg(jo.getDefVal($(e).attr("ErrBirthBad"),"请填写正确的年月格式！"));//提示信息
                        $(e).focus();//获取焦点
                        return false;
                    }
                }
                // });
            }

            var birthsBad = $("#pageForm").find("input[ErrBirthBad4]");
            var reg_birthB1 = /^(\d{4})(-)(\d{2})$/;
            var reg_birthB2 = /^(\d{4})(\d{2})$/;
            var reg_birthB3 = /^(\d{4})(\.)(\d{2})$/;
            var reg_birthB4 = /^(\d{4})(\/)(\d{2})$/;
            for(var i=0;i<birthsBad.length;i++){
                var e = birthsBad[i];

                // $(e).blur(function () {
                var val = $(e).val();//值
  /*              console.log("生日4长度：" + val);
                console.log("生日4长度：" + jo.isValid(val));
                console.log("生日长度：" + reg_birthB1.test(val));*/
                if(val != ""){//可以不填
                    if(reg_birthB1.test(val) || reg_birthB2.test(val) || reg_birthB3.test(val) || reg_birthB4.test(val)){
                        /*               if (reg_birthB1.test(val)) {

                                       }*/
                        if (reg_birthB2.test(val)) {
                            var _val = val.substring(0,4) + "-" + val.substring(4);
                            $(e).val(_val);
                        }
                        else if (reg_birthB3.test(val)) {
                            var _val = val.substring(0,4) + "-" + val.substring(5);
                            $(e).val(_val);
                        }
                        else if (reg_birthB4.test(val)) {
                            var _val = val.substring(0,4) + "-" + val.substring(5);
                            $(e).val(_val);
                        }else {

                        }
                    }else {
                        jo.showMsg(jo.getDefVal($(e).attr("ErrBirthBad4"),"请填写正确的年月格式！"));//提示信息
                        $(e).focus();//获取焦点
                        return false;
                    }
                }
                // });
            }

            //TODO BT END


            return true;
        };
        //保存start
        function save() {
            //TODO 用户修改提交时移除disabled
            var elements = document.getElementById("pageForm").elements;
            for (var i=0;i<elements.length;i++) {
                var e = elements[i];
                if (e.type != "checkbox" && e.type != "hidden") {
                    e.removeAttribute("disabled");
                }
            }

            if(!checkForm($("#pageForm"))){//验证不通过直接返回
                return;
            }

            var oData = jo.form2Json("pageForm");
            var sUrl = "pms/auditRecordBaseinfo/userUpdate.action";
            //new sf
            if (jo.isValid(sf)) {
                sUrl = sUrl + "?sf=rs";//携带
            }
            //new sf
            jo.postAjax(sUrl,{"pData":JSON.stringify(oData)}, function(result){
                if(result.code == 0){
                    if (jo.isValid(sf)) {
                        window.parent.jo.showMsg("修改成功!");
                    }else {
                        window.parent.jo.showMsg("修改成功，请等待管理员审核!");
                    }
                    window.location.reload();
                }else{
                    jo.showMsg(result.info);
                }
            });
        }
        //保存end
        //上传照片start
        var UPLOAD_FILE_TYPES = "jpg,png";//上传图片格式要求
        function uploadPhoto() {
            jo.uploadFile("{URL_FS}fs/file/upload", function (success, file, json) {
                if (success && json) {
                    jo.closeUploadDialog();//关闭上传窗口
                    if (json.code == "0" && json.data[0]) {
                        $("#photoAddress").val(json.data[0].id);
                        $("#header").attr("src", URL_FS + "fs/file/image?id=" + json.data[0].id);
                        jo.showMsg("上传成功,点击保存按钮进行保存!");

                    } else {
                        jo.showMsg(json.info);
                    }
                }
            });
        }
        //上传图片end
        //加载用户部门信息start
/*        function loadUserDept() {
            if (userId) {
                jo.postAjax("pms/pmsUser/getUserDeptByUserId",{"userId":userId}, function (json) {
                    if (json && json.code == 0) {
                        if (json.data && json.data.length > 0) {
                            var _html = '';
                            var ids = '';
                            for (var i = 0; i < json.data.length; i++) {
                                var item = json.data[i];
                                _html += '<li>' + item.deptName + '</li>';//个人编辑页,不提供编辑部门功能<div class="li_close" title="移出此部门" onclick="deleteUserDept(\''+item.id+'\')">×</div>
                                ids += ',' + item.deptId;
                            }
                            $(".dept_ul").html(_html);
                            if (ids) {
                                $("#deptIds").val(ids.substring(1));//将部门号存储在input中,用于部门回显
                            }
                        }
                    }
                });
            }
        }*/
        //加载部门end

        //选择部门
        var deptWinIdx;
        function choiceDept(idInp, nameInp, bMore){
            deptWinIdx = jo.selectTree('{URL_UMS}ums/tree/getDeptTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
        }
        //选择窗按钮点击回调
        jo.selectListCall = function(status, ids, names){
            if(status){//确定按钮
                if(ids && userId){
                    jo.postAjax("pms/pmsUser/refreshUserDept", {"userId":userId, deptIds:ids}, function(json){
                        if(json && json.code == 0){
                            jo.showMsg("成功设置用户部门!");
                            loadUserDept();//加载用户部门
                        }
                    });
                }
            }else{//取消按钮

            }
            jo.close(deptWinIdx);
        }
        //加载用户部门信息
        function loadUserDept(){
            if(userId){
                jo.postAjax("pms/pmsUser/getUserDeptByUserId", {"userId":userId}, function(json){
                    if(json && json.code == 0){
                        if(json.data && json.data.length > 0){
                            var _html = '';
                            var ids = '';

                            for(var i=0;i<json.data.length;i++){
                                var item = json.data[i];
                                if (jo.isValid(sf)) {
                                    _html += '<li>'+item.deptName+'<div class="li_close" title="移出此部门" onclick="deleteUserDept(\''+item.id+'\')">×</div></li>';

                                }else {
                                    _html += '<li>' + item.deptName + '</li>';

                                }
                                ids += ',' + item.deptId;
                            }
                            $(".dept_ul").html(_html);
                            if(ids){
                                $("#deptIds").val(ids.substring(1));//将部门号存储在input中,用于部门回显
                            }
                        }else {
                            //修复最后一个删除，无法及时刷新
                            //TODO deptids暂时没用，设置部门时单独操作，虽然页面显示了
                            $(".dept_ul").html("");
                            $("#deptIds").val("");//部门回显置空，或者不插入审核库
                        }
                    }
                });
            }

        }
        //删除关联关系
        function deleteUserDept(id){
            if(id){
                jo.postAjax("pms/pmsUser/deleteUserDept", {"id":id}, function(json){
                    if(json && json.code == 0){
                        jo.showMsg("成功删除该关联!");
                        loadUserDept();//加载部门关联
                    }
                });
            }

        }
    </script>
    <script type="text/javascript">
        $(function(){
            goto();
            initChoose();
        });
        function goto(){
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
        }
    </script>
    <style>
        .dept_ul {
            width: auto;
            height: auto;
            list-style: none;
            margin: 0px;
            padding: 0px;
        }

        .dept_ul > li {
            width: auto;
            height: 28px;
            line-height: 28px;
            border: #dddddd solid 1px;
            display: inline-block;
            padding: 0px 32px 0px 12px;
            background-color: #F7F7F7;
            cursor: default;
            position: relative;
            margin-right: 8px;
        }

        .li_close {
            width: 20px;
            height: 20px;
            line-height: 20px;
            text-align: center;
            border-radius: 10px;
            cursor: pointer;
            border: #DCDCDC solid 1px;
            position: absolute;
            right: 3px;
            top: 3px;
        }

        .li_close:hover {
            color: blue;
            font-weight: bolder;
            border: #CBCBCB solid 1px;
        }

        .cursor-hand{
            cursor: pointer;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <td class="layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">信息编辑</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary export">导出Excel</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary preview">信息预览</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary edit">编辑</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary save" id="save" onclick="save()">保存</button>
                    </div>
<%--                    <div class="layui-inline">
                        <i class="layui-icon layui-icon-search"></i>
                        <input type="text" name="title" placeholder="搜索条目编号" autocomplete="off" class="layui-input search-input">
                    </div>--%>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">1  基本信息</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">60%</span>--%>
                        </div>
                        <div class="select-content">
                            <ul id="selectContent">
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/personal/selfBaseInfoForm.jsp?id=">
                                        <span class="left opt">1  基本信息</span>
                                        <%--             <span class="txt">完善度</span>
                                                     <span class="baifen">60%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/communicationForm.jsp?id=">
                                        <span class="left opt">2  通讯信息</span>
                                        <%--              <span class="txt">完善度</span>
                                                      <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/relationList.jsp?userId=">
                                        <span class="left opt">3  家庭成员和社会关系</span>
                                        <%--               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/educationList.jsp?userId=">
                                        <span class="left opt">4  教育经历</span>
                                        <%--                <span class="txt">完善度</span>
                                                        <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/workList.jsp?userId=">
                                        <span class="left opt">5  工作经历</span>
                                        <%--                <span class="txt">完善度</span>
                                                        <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/mainTechGroupList.jsp?userId=">
                                        <span class="left opt">6  社团兼职</span>
                                        <%--           <span class="txt">完善度</span>
                                                   <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/honorTitleList.jsp?userId=">
                                        <span class="left opt">7  荣誉称号</span>
                                        <%--             <span class="txt">完善度</span>
                                                     <span class="baifen">60%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/techAwardsList.jsp?userId=">
                                        <span class="left opt">8  获奖情况</span>
                                        <%--               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/paperList.jsp?userId=">
                                        <span class="left opt">9  论文情况</span>
                                        <%--          <span class="txt">完善度</span>
                                                  <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/publishList.jsp?userId=">
                                        <span class="left opt">10 出版著作</span>
                                        <%--                 <span class="txt">完善度</span>
                                                         <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/patentList.jsp?userId=">
                                        <span class="left opt">11 专利</span>
                                        <%--                      <span class="txt">完善度</span>
                                                              <span class="baifen">80%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;"  lay-href="<%=basePath%>page/pms/joinProjectList.jsp?userId=">
                                        <span class="left opt">12 项目经历</span>
                                        <%--  <span class="txt">完善度</span>
                                          <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/tnBraceList.jsp?userId=">
                                        <span class="left opt">13 技术支撑</span>
                                        <%--                   <span class="txt">完善度</span>
                                                           <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/supportProjectList.jsp?userId=">
                                        <span class="left opt">14 人力培养计划/资助项目</span>
                                        <%--                      <span class="txt">完善度</span>
                                                              <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/yearCheckList.jsp?userId=">
                                        <span class="left opt">15 年度考核</span>
                                        <%--                       <span class="txt">完善度</span>
                                                               <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
<%--                                <li>
                                    <a  href="javascript:;" lay-href="<%=basePath%>page/pms/selfEvaluationForm.jsp?id=">
                                        <span class="left opt">16 自我评价</span>
                                        &lt;%&ndash;               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>&ndash;%&gt;
                                    </a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <form action="" class="person-content layui-form layui-form-box" id="pageForm">
                <div class="clear">
<%--                    <div class="left image">
                        <img id="header" onclick="uploadPhoto()" src="<%=URL_STATIC%>static/images/def_head.jpg" alt="" width="128px" height="158px">
                    </div>--%>
                    <div class="left image" style="position:relative;    overflow: initial;">
                        <div class="left image" style="margin:0;">
                            <img id="header" onclick="uploadPhoto()" src="<%=URL_STATIC%>static/images/def_head.jpg" alt="" width="128px" height="158px">
<%--                            <span class="iconfont show" style="position: absolute;bottom:-24px;left: 0px">
                                <i class="iconfont icon-duihao"></i>
                                <i class="iconfont icon-suoding"></i>
                            </span>--%>
                        </div>
                    </div>
                    <div class="layui-row left row-one">
                        <div class="layui-col-md6 col-item">
                            <div>
                                <div class="label">人员姓名</div>
                            </div>
                            <input type="text" name="userName" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">

                            <input type="hidden" name="userId"/>
                            <input type="hidden" id="id" name="id"/>
                            <input type="hidden" id="photoAddress" name="photoAddress"/>
                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <div class="label">籍贯</div>
                            </div>
                            <input type="text" name="placeOfOrigin" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">

                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <div class="label">曾用名</div>
                            </div>
                            <input type="text" name="oldName" disabled placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <div class="label">所在部门
                                    <a class="cursor-hand" id="deptchoose" hidden="hidden" onclick="choiceDept('deptIds', 'deptNames', false)">（选择）</a>
                                </div>
                            </div>
                            <input type="hidden" id="deptIds" name="deptIds" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                            <ul class="dept_ul" style="min-width:600px;">
 <%--                               <li>人事处楚楚的<div class="li_close" title="移出此部门">×</div></li>
                                <li>人事处<div class="li_close" title="移出此部门">×</div></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit">
                        基本信息
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 30px;">
                        <div>
                            <div class="label">性别</div>
                        </div>
                        <div>
                            <div class="label">民族</div>
                        </div>
                        <div>
                            <div class="label">出生地</div>
                        </div>
                        <div>
                            <div class="label">政治面貌</div>
                        </div>
                        <div>
                            <div class="label">岗位</div>
                        </div>
                        <div>
                            <div class="label">承担的工作</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item save">
                            <input type="text" name="sex" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                                <select disabled async="true" name="sex" class="joSelect" data=""
                                        dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue"
                                        valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}' lay-verify=""></select>
                        </div>

                        <%--民族start--%>
                        <div class="col-item save">
                            <input type="text" name="nation" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="nation" disabled lay-verify=""  class="joSelect" data=""
                                    dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue"
                                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <%--民族end--%>
                        <%--出生地start--%>
                        <div class="col-item">
                            <input type="text" name="placeOfBirth" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <%--出生地end--%>
                        <%--政治面貌start--%>
                        <div class="col-item save">
                            <input type="text" name="politicalOutlook" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="politicalOutlook" lay-verify="" disabled class="joSelect" data=""
                                    dataurl="pms/pmsDictionary/getListByDictionary/POLITICAL_OUTLOOK"
                                    keyfield="dicValue" valuefield="dicValue"
                                    firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <%--政治面貌end--%>
                        <div class="col-item">
                            <input type="text" name="station" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>

                        <div class="col-item lang">
                            <input type="text" name="takeWork" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div>
                            <div class="label">出生日期</div>
                        </div>
                        <div>
                            <div class="label">身份证号</div>
                        </div>
                        <div>
                            <div class="label">参加工作时间</div>
                        </div>
                        <div>
                            <%--<div class="label">入党时间</div>--%>
                            <div class="label">加入时间</div>
                        </div>
                        <div>
                            <div class="label">来院时间</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <%--出生年月start--%>
                        <div class="col-item save">
                            <input type="text" name="birth" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="birth" ErrBirthBad disabled required lay-verify="required" placeholder="格式：2018-08-08" autocomplete="off" class="layui-input">
                        </div>

                        <%--出生年月end--%>
                        <div class="col-item">
                            <input type="text" name="idCard" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                            <%--入职时间start--%>
                        <div class="col-item save">
                            <input type="text" name="workStartTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="workStartTime" ErrBirthBad4 disabled  placeholder="" autocomplete="off" class="layui-input" id="entry">
                        </div>

                            <%--入职时间end--%>
                        <%--入党时间start--%>
                        <div class="col-item save">
                            <input type="text" name="joinPartyTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="joinPartyTime" ErrBirthBad4  disabled placeholder="" autocomplete="off" class="layui-input" id="rudang">
                        </div>

                        <%--入党时间end--%>
                        <%--来院时间start--%>
                        <div class="col-item save">
                            <input type="text" name="toThereTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="toThereTime" ErrBirthBad4  placeholder="" autocomplete="off" class="layui-input" id="toThereTime">
                        </div>
                        <%--来院时间end--%>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit">
                        工作信息
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 30px;">
                        <div>
                            <div class="label">专业技术职务</div>
                        </div>
                        <div>
                            <div class="label">专业技术等级</div>
                        </div>
                        <div>
                            <div class="label">行政职务</div>
                        </div>
                        <div>
                            <div class="label">行政级别</div>
                        </div>
                        <div>
                            <div class="label">研究领域细分</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <%--专业技术职务start--%>
                        <div class="col-item save">
                            <input type="text" name="technicalPosition" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="technicalPosition" lay-verify="" disabled class="joSelect" data=""
                                    dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_POSITION"
                                    keyfield="dicValue" valuefield="dicValue"
                                    firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <%--专业技术职务end--%>
                        <%--专业技术等级start--%>
                        <div class="col-item save">
                            <input type="text" name="technicalLevel" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="technicalLevel" lay-verify="" disabled class="joSelect" data=""
                                    dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_LEVEL" keyfield="dicValue"
                                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <%--专业技术等级end--%>
                        <!-- 行政职务start -->
                        <div class="col-item">
                            <input type="text" name="administrativeDuty" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <!-- 行政职务end -->
                        <!-- 行政级别start -->
                        <div class="col-item save">
                            <input type="text" name="administrativeLevel" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="administrativeLevel" lay-verify="" disabled class="joSelect"
                                    data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL"
                                    keyfield="dicValue" valuefield="dicValue"
                                    firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <!-- 行政级别end -->
<%--                        研究领域细分start
                        <div class="col-item lang">
                            <input type="text" name="researchFieldDetail" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        研究领域细分end--%>
                        <%--研究领域细分start--%>
                        <div class="col-item">
                            <input type="text" name="researchFieldDetail" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <%--研究领域细分end--%>

                    </div>
                    <div class="layui-col-md1" style="width: 100px;">
                        <div>
                            <div class="label">取得时间</div>
                        </div>
                        <div>
                            <div class="label">聘任时间</div>
                        </div>
                        <div>
                            <div class="label">任职时间</div>
                        </div>
                        <div>
                            <div class="label">研究领域</div>
                        </div>
                        <div>
                            <div class="label">是否有挂职经历</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item save">
                            <input type="text" name="getTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="getTime" ErrBirthBad4 disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="get">
                        </div>

                        <!-- 聘任时间start -->
                        <div class="col-item save">
                            <input type="text" name="appointmentTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="appointmentTime" ErrBirthBad4 disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="engage">
                        </div>

                        <!-- 聘任时间end -->
                        <!-- 任职时间start -->
                        <div class="col-item save">
                            <input type="text" name="tenureTime" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <input type="text" name="tenureTime" ErrBirthBad4 disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" id="tenureTime">
                        </div>

                        <!-- 任职时间end -->
                        <%--研究领域start--%>
                        <div class="col-item save">
                            <input type="text" name="researchField" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="researchField" lay-verify="" disabled class="joSelect" data=""
                                    dataurl="pms/pmsDictionary/getListByDictionary/RESEARCH_FIELD" keyfield="dicValue"
                                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>

                        <%--研究领域end--%>
                        <%--是否有挂职经历start--%>
                        <div class="col-item save">
                            <input type="text" name="tempWorkExperience" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                        <div class="col-item edit">
                            <select async="true" name="tempWorkExperience" lay-verify="" class="joSelect"
                                    data="" dataurl="pms/pmsDictionary/getListByDictionary/TEMPORARY_WORK_EXPERIENCE"
                                    keyfield="dicValue" valuefield="dicValue"
                                    firstitem='{"dicValue":"","dicValue":""}'></select>
                        </div>
                        <%--是否有挂职经历end--%>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 layui-col-sm1 layui-col-xs-1" style="font-size: 14px;    margin-top: 14px;">
                        学历信息
                    </div>
                    <div class="line"></div>
                    <table class="layui-col-md11 layui-col-sm11 layui-col-xs-11" style="padding-left:10px;box-sizing:border-box;">
                        <tbody>
                        <tr>
                            <td>全日制学历</td>
                            <td>
                                <%--第一学历start--%>
                                <div class="col-item save">
                                    <input type="text" name="firstEducation" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="firstEducation" lay-verify="" disabled class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--第一学历end--%>
                            </td>
                            <td>全日制学位</td>
                            <td>
                                <%--第一学位start--%>
                                <div class="col-item save">
                                    <input type="text" name="firstDegree" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="firstDegree" lay-verify="" disabled class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--第一学位end--%>
                            </td>
                        </tr>
<tr>
    <td>在职学历</td>
    <td>
        <%--在职学历start--%>
        <div class="col-item save">
            <input type="text" name="jobEducation" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
        <div class="col-item edit">
            <select async="true" name="jobEducation" lay-verify="" disabled class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION"
                    keyfield="dicValue" valuefield="dicValue"
                    firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>

        <%--在职学历end--%>
    </td>
    <td>在职学位</td>
    <td>
        <%--在职学位start--%>
        <div class="col-item save">
            <input type="text" name="jobDegree" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
        <div class="col-item edit">
            <select async="true" name="jobDegree" lay-verify="" disabled class="joSelect" data=""
                    dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue"
                    valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
        </div>

        <%--在职学位end--%>
    </td>
</tr>
   <tr>
       <td>从事专业</td>
       <td>
           <%--从事专业start--%>
           <div class="col-item">
               <input type="text" name="specialty" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
           </div>
           <%--从事专业end--%>
       </td>
       <td>国外一年以上留学经历</td>
       <td>
           <%--国外1年以上留学经历start--%>
           <div class="col-item save">
               <input type="text" name="overseasStudyExperience" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
           </div>
           <div class="col-item edit">
               <select async="true" name="overseasStudyExperience" disabled lay-verify="" class="joSelect"
                       data="" dataurl="pms/pmsDictionary/getListByDictionary/OVERSEAS_STUDY_EXPERIENCE"
                       keyfield="dicValue" valuefield="dicValue"
                       firstitem='{"dicValue":"","dicValue":""}'></select>
           </div>

           <%--国外1年以上留学经历end--%>
       </td>
   </tr>
<tr>
    <td>熟悉何种外语及水平</td>
    <td>
        <%--外语水平start--%>
        <div class="col-item">
            <input type="text" name="englishLevel" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
        </div>
        <%--外语水平end--%>
    </td>
    <c:if test="${fn:contains(loginUser.roleId,'79a80080f55740f1a1b146af57dfcf27')}">

        <td>备注</td>
    </c:if>

    <%--备注start--%>
    <c:if test="${fn:contains(loginUser.roleId,'79a80080f55740f1a1b146af57dfcf27')}">
        <td>
            <div class="col-item save">
                <input type="text" name="remark" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
            </div>
            <div class="col-item edit">
                <select name="remark" lay-verify="" disabled>
                    <option value=""></option>
                    <option value="在编">在编</option>
                    <option value="院聘">院聘</option>
                    <option value="劳务派遣">劳务派遣</option>
                    <option value="劳务协议">劳务协议</option>
                    <option value="离职">离职</option>
                    <option value="退休">退休</option>
                    <option value="离休">离休</option>
                    <option value="博士后">博士后</option>
                    <option value="其他">其他</option>
                </select>
            </div>
        </td>

    </c:if>
    <%--备注end--%>

</tr>

                        </tbody>
                    </table>

                </div>
            </form>
        </div>
    </div>

</div>

    <script>
        $(function() {
            // 初始化展示页面不显示输入框样式
            layui.use(['layer', 'form', 'laydate'], function() {
                var form = layui.form;
                var layer = layui.layer;
                var laydate = layui.laydate;
/*                laydate.render({
                    elem: '#birthday'
                });
                laydate.render({
                    elem: '#entry'
                    ,type: 'month'//new
                });
                laydate.render({
                    elem: '#rudang'
                    ,type: 'month'//new
                });
                laydate.render({
                    elem: '#get'
                    ,type: 'month'//new
                });
                laydate.render({
                    elem: '#engage'
                    ,type: 'month'//new
                });
                laydate.render({
                    elem: '#tenureTime'
                    ,type: 'month'//new
                });
                laydate.render({
                    elem: '#toThereTime'
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