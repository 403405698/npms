<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>按人员审核基本信息</title>
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

    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <%@ include file="/common/uploadHeadOfImg.jsp" %>
    <script src="<%=URL_STATIC%>static/newjs/final_rh_audit_field_form.js"></script><%--//新增测试--%>
    <script>
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "auditPKName" : "userId",
                "saveAfter" : "toEdit",
                "addUrl" : "pms/pmsUser/insert.action",//新增
                "deleteUrl" : "pms/pmsUser/delete.action",//删除
                "updateUrl" : "pms/auditFieldBase/update.action",//修改
                "formDataUrl" : "pms/pmsUser/get.action",	//查询
                "auditDataUrl" : "pms/auditRecordBaseinfo/getUserAuditInfo",
                "changeStateUrl" : "pms/auditRecordBaseinfo/changeStatus.action"
            };
            joForm.initFormPage(jParams);//初始化
        });
        joForm.spliceStatus = function(formAuditData){
            //在此处理拼接状态显示：start
            var elements = document.getElementById("pageForm").elements;
            for (var i=0;i<elements.length;i++) {
                var element = $(elements[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<formAuditData.length;f++) {
                    if (key == formAuditData[f]["fieldKey"]){//找到同name
                        //后面拼接一下锁定状态显示和审核状态显示 start
                        //去除隐藏的input标签
                        if (element.attr("type") != "hidden")  {
                            //锁定状态拼接start
                            var status_html = "<span class=\"iconfont show\">";
                            if (formAuditData[f]["lockStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-suoding\"></i>";
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

                }
            }
            //对img单独处理
            //新增：处理img start
            var img = $("#pageForm").find("img");
            for(var i=0;i<img.length;i++) {
                var element = $(img[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                for (var f=0;f<formAuditData.length;f++) {
                    if ("photoAddress" == formAuditData[f]["fieldKey"]) {//找到同name
                        if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                            var status_html = "<span class=\"iconfont show\" style=\"right: 0;position: absolute;bottom: -30px\">";
                            if (formAuditData[f]["lockStatus"] == 1) {
                                status_html += "<i class=\"iconfont icon-suoding\"></i>";
                            }
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
            //处理状态显示end
        }
        joForm.initFormValueAfter = function(){
            if (jo.isValid(auditPhotoAddress)) {
                $("#header").attr("src", URL_FS + "fs/file/image.action?id=" + auditPhotoAddress);//使用审核库中的信息
            }
            $("#auditWho").attr("value",jo.getUrlParam("id"));
            $("#auditWho").text(userName);
            loadUserDept();
        };

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
                                _html += '<li>'+item.deptName+'<div class="li_close" title="移出此部门" onclick="deleteUserDept(\''+item.id+'\')">×</div></li>';
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
        var userId = jo.getDefVal(jo.getUrlParam("id"), loginUser.id);
        $(function(){
            goto();
            joForm.setAuditItem("id","pms/auditPmsUser/getAuditItem.action","待审核");//刷新条目
        });
        function goto(){
            $("a").each(function(){
                $(this).attr("lay-href",$(this).attr("lay-href") + userId);
            });
        }
    </script>

    <style>
        .person-content .tit {
            width: 120px;
        }

        .line {
            left: 130px;
        }

        .row-two .iconfont.show {
            position: absolute;
            top: 20px;
            left: -40px;
        }

        .row-one .col-item {
            position: relative;
        }

        .row-one .iconfont.show {
            position: absolute;
            top: 12px;
            left: -50px;
            width: 40px;
        }

        .row-one .iconfont.show i {
            float: right;
        }

        table .layui-form-checkbox {
            width: 100%;
        }

        table .col-item {
            text-align: left;
        }

        table .iconfont.show {
            left: 0 !important;
        }

        td.lang .col-item {
            width: 100% !important;
        }

        td.lang .layui-input {
            width: 100% !important;
        }
    </style>

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
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <div class="layui-col-md12 person">
            <div class="person-tit clear" style="padding: 0 0 18px 0;">
                    <span class="left title" style="padding: 0;font-size: 14px;line-height: 50px;">
                        提示：当前正在审核 <span style="color: red;" id="auditWho"></span>
                    </span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <%--布局问题，一键审核先隐藏--%>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(1,null,false)">单字段审核通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(2,null,false)">单字段审核不通过</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password no-reviewe" onclick="joForm.changeState(5,null,false)">置为未审核</button>
                        <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password no-reviewe">非审核字段</button>--%>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(null,1,false)">锁定字段</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(null,2,false)">解锁字段</button>
                    </div>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">1  基本信息</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">待审核</span>--%>
                        </div>
                        <div class="select-content">
                            <ul id="selectContent">
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditUserDoc.jsp?sf=rs&id=">
                                        <span class="left opt">1  基本信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditCommunicationForm.jsp?sf=rs&edit=true&id=">
                                        <span class="left opt">2  通讯信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditRelationList.jsp?sf=rs&userId=">
                                        <span class="left opt">3  家庭成员和社会关系</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditEducationList.jsp?sf=rs&userId=">
                                        <span class="left opt">4  教育经历</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditWorkList.jsp?sf=rs&userId=">
                                        <span class="left opt">5  工作经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditMainTechGroupList.jsp?sf=rs&userId=">
                                        <span class="left opt">6  社团兼职</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditHonorTitleList.jsp?sf=rs&userId=">
                                        <span class="left opt">7  荣誉称号</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditTechAwardsList.jsp?sf=rs&userId=">
                                        <span class="left opt">8  获奖情况</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPaperList.jsp?sf=rs&userId=">
                                        <span class="left opt">9  论文情况</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPublishList.jsp?sf=rs&userId=">
                                        <span class="left opt">10 出版著作</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPatentList.jsp?sf=rs&userId=">
                                        <span class="left opt">11 专利</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditJoinProjectList.jsp?sf=rs&userId=">
                                        <span class="left opt">12 项目经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditTnBraceList.jsp?sf=rs&userId=">
                                        <span class="left opt">13 技术支撑</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditSupportProjectList.jsp?sf=rs&userId=">
                                        <span class="left opt">14 人力培养计划/资助项目</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditYearCheckList.jsp?sf=rs&userId=">
                                        <span class="left opt">15 年度考核</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <%--                                <li>
                                                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditSelfEvaluationForm.jsp?sf=rs&id=">
                                                                        <span class="left opt">16 自我评价</span>
                                                                        &lt;%&ndash;<span class="baifen">待审核</span>&ndash;%&gt;
                                                                    </a>
                                                                </li>--%>
                            </ul>
                        </div>
                    </div>

                </div>
                <%--新增两个按钮--%>
                <div class="layui-form right" style="padding-right: 310px;">
                    <div class="layui-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeStateSave(1,null,false)">保存</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(1,null,true)">一键通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(null,1,true)">一键锁定</button>
                        <%--                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(2,null,true)">一键不通过</button>
                                                <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(null,2,true)">一键解锁</button>--%>
                    </div>
                </div>
                <%--end--%>
            </div>
            <form action="" class="person-content layui-form layui-form-box" id="pageForm">
                <div class="clear">
                    <%--头像区域--%>
                    <div class="left image" style="position:relative;overflow: visible;margin-bottom: 40px;">
                        <div class="left image" style="margin:0;">
                            <img id="header" onclick="uploadPhoto()" src="<%=URL_STATIC%>static/images/def_head.jpg" alt="" width="128px" height="158px">
                            <div style="left: 0;position: absolute;bottom: -40px">
                                <input type="checkbox" autocomplete="off" name="" status="" cname="photoAddress" lay-skin="primary" title="人员头像">
                            </div>
                            <%--                            <span class="iconfont show" style="right: 0;position: absolute;bottom: -30px">
                                                            <i class="iconfont icon-error"></i>
                                                            <i class="iconfont icon-suoding"></i>
                                                         </span>--%>
                        </div>
                    </div>
                    <%--头像区域end--%>
                    <div class="layui-row left row-one">
                        <div class="layui-col-md6 col-item">
                            <div>
                                <input type="checkbox" autocomplete="off" name="" status="" cname="userName" lay-skin="primary" title="人员姓名">
                            </div>
                            <div class="col-item">
                                <input type="text" name="userName"  placeholder="" autocomplete="off" class="layui-input" >

                                <input type="hidden" name="userId"/>
                                <input type="hidden" id="id" name="id"/>
                                <input type="hidden" id="photoAddress" name="photoAddress"/>
                            </div>
                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <input type="checkbox" autocomplete="off" name="" status="" cname="placeOfOrigin" lay-skin="primary"title="籍贯">
                            </div>
                            <div class="col-item">
                                <input type="text" name="placeOfOrigin"  placeholder="" autocomplete="off" class="layui-input">

                            </div>
                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <input type="checkbox" autocomplete="off" name="" status="" cname="oldName" lay-skin="primary" title="曾用名">
                            </div>
                            <div class="col-item">
                                <input type="text" name="oldName"  placeholder="" autocomplete="off" class="layui-input">

                            </div>
                        </div>
                        <div class="layui-col-md6 col-item">
                            <div>
                                <div class="label">所在部门
                                    <a class="cursor-hand" id="deptchoose" onclick="choiceDept('deptIds', 'deptNames', false)">（选择）</a>
                                </div>
                            </div>
                            <input type="hidden" id="deptIds" name="deptIds" disabled  placeholder="" autocomplete="off" class="layui-input">
                            <ul class="dept_ul" style="min-width:600px;">
                                <%--                               <li>人事处楚楚的<div class="li_close" title="移出此部门">×</div></li>
                                                               <li>人事处<div class="li_close" title="移出此部门">×</div></li>--%>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md2 layui-col-sm2 layui-col-xs-2">
                        <input type="checkbox" autocomplete="off" id="baseinfo" lay-filter="xqy" lay-skin="primary" title="基本信息">
                    </div>
                    <div class="line"></div>
                    <table class="layui-col-md10 layui-col-sm10 layui-col-xs-10">
                        <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="sex" class="col-item" lay-skin="primary" title="性别">
                            </td>
                            <td>
                                <div class="col-item save">
                                    <input type="text" name="sex" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select  async="true" name="sex" class="joSelect" data=""
                                             dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue"
                                             valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}' lay-verify=""></select>
                                </div>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="birth" class="col-item" lay-skin="primary"  title="出生日期">
                            </td>
                            <td>
                                <div class="col-item save">
                                    <input type="text" name="birth"  placeholder="" autocomplete="off" class="layui-input">
                                    <%--出生年月--%>
                                </div>
                                <div class="col-item edit">
                                    <%--出生年月--%>
                                    <input type="text" name="birth" ErrBirthBad  placeholder="格式：2018-08-08" autocomplete="off" class="layui-input">

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="nation" class="col-item" lay-skin="primary" title="民族">
                            </td>
                            <td>
                                <%--民族start--%>
                                <div class="col-item save">
                                    <input type="text" name="nation" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="nation"  lay-verify=""  class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--民族end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="idCard" class="col-item" lay-skin="primary"  title="身份证号">
                            </td>
                            <td>
                                <%--身份证号--%>
                                <div class="col-item">
                                    <input type="text" name="idCard"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="placeOfBirth" class="col-item" lay-skin="primary" title="出生地">
                            </td>
                            <td>
                                <%--出生地--%>
                                <div class="col-item">
                                    <input type="text" name="placeOfBirth"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>

                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="workStartTime" class="col-item" lay-skin="primary"  title="参加工作时间">
                            </td>
                            <td>
                                <%--入职时间--%>
                                <div class="col-item save">
                                    <input type="text" name="workStartTime"   placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="workStartTime" ErrBirthBad4  placeholder="" autocomplete="off" class="layui-input" id="entry" >

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="politicalOutlook" class="col-item" lay-skin="primary"  title="政治面貌">
                            </td>
                            <td>
                                <%--政治面貌start--%>
                                <div class="col-item save">
                                    <input type="text" name="politicalOutlook" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="politicalOutlook" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/POLITICAL_OUTLOOK"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--政治面貌end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="joinPartyTime" class="col-item" lay-skin="primary"  title="加入时间">
                            </td>
                            <td>
                                <%--入党时间--%>
                                <div class="col-item save">
                                    <input type="text" name="joinPartyTime"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="joinPartyTime"  ErrBirthBad4 placeholder="" autocomplete="off" class="layui-input" id="rudang" >

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="station" class="col-item" lay-skin="primary"  title="岗位">
                            </td>
                            <td>
                                <%--岗位--%>
                                <div class="col-item">
                                    <input type="text" name="station"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="toThereTime" class="col-item" lay-skin="primary"  title="来院时间">
                            </td>
                            <td>
                                <%--来院时间start--%>
                                <div class="col-item save">
                                    <input type="text" name="toThereTime"  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="toThereTime"  ErrBirthBad4 placeholder="" autocomplete="off" class="layui-input" id="toThereTime">
                                </div>
                                <%--来院时间end--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="baseinfo" status="" cname="takeWork" class="col-item" lay-skin="primary"  title="承担的工作">
                            </td>
                            <td class="lang" colspan="3">
                                <div class="col-item">
                                    <input type="text" name="takeWork"  placeholder="" autocomplete="off" class="layui-input" >
                                </div>
                            </td>
<%--                            <td>
                                &lt;%&ndash;承担的工作&ndash;%&gt;
                                <div class="col-item lang">
                                    <input type="text" name="takeWork"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>--%>

                        </tr>

                        </tbody>
                    </table>


                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md2 layui-col-sm2 layui-col-xs-2">
                        <input type="checkbox" autocomplete="off" id="workinfo" lay-filter="xqy" lay-skin="primary" title="工作信息">
                    </div>
                    <div class="line"></div>
                    <table class="layui-col-md10 layui-col-sm10 layui-col-xs-10">
                        <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="technicalPosition" class="col-item" lay-skin="primary"  title="专业技术职务">
                            </td>
                            <td>
                                <%--专业技术职务start--%>
                                <div class="col-item save">
                                    <input type="text" name="technicalPosition" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="technicalPosition" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_POSITION"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--专业技术职务end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="getTime" class="col-item" lay-skin="primary"  title="取得时间">
                            </td>
                            <td>
                                <%--取得时间--%>
                                <div class="col-item save">
                                    <input type="text" name="getTime"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="getTime" ErrBirthBad4  placeholder="" autocomplete="off" class="layui-input" id="get" >

                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="technicalLevel" class="col-item" lay-skin="primary"  title="专业技术等级">
                            </td>
                            <td>
                                <%--专业技术等级start--%>
                                <div class="col-item save">
                                    <input type="text" name="technicalLevel" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="technicalLevel" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_LEVEL" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--专业技术等级end--%>

                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="appointmentTime" class="col-item" lay-skin="primary"  title="聘任时间">
                            </td>

                            <td>
                                <%--聘任时间--%>
                                <div class="col-item save">
                                    <input type="text" name="appointmentTime"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="appointmentTime" ErrBirthBad4  placeholder="" autocomplete="off" class="layui-input" id="engage" >

                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="administrativeDuty" class="col-item" lay-skin="primary"  title="行政职务">
                            </td>
                            <td>
                                <%--行政职务--%>
                                <div class="col-item">
                                    <input type="text" name="administrativeDuty"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="tenureTime" class="col-item" lay-skin="primary"  title="任职时间">
                            </td>
                            <td>
                                <%--任职时间--%>
                                <div class="col-item save">
                                    <input type="text" name="tenureTime"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                                <div class="col-item edit">
                                    <input type="text" name="tenureTime" ErrBirthBad4  placeholder="" autocomplete="off" class="layui-input" id="tenureTime" >

                                </div>

                            </td>
                        </tr>

                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="administrativeLevel" class="col-item" lay-skin="primary"  title="行政级别">
                            </td>
                            <td>
                                <div class="col-item save">
                                    <input type="text" name="administrativeLevel" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="administrativeLevel" lay-verify="" class="joSelect"
                                            data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="researchField" class="col-item" lay-skin="primary"  title="研究领域">
                            </td>
                            <td>
                                <%--研究领域start--%>
                                <div class="col-item save">
                                    <input type="text" name="researchField" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="researchField" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/RESEARCH_FIELD" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--研究领域end--%>

                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="researchFieldDetail" class="col-item" lay-skin="primary"  title="研究领域细分">
                            </td>
                            <td>
                                <%--研究领域细分--%>
                                <div class="col-item">
                                    <input type="text" name="researchFieldDetail"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="workinfo" status="" cname="tempWorkExperience" class="col-item" lay-skin="primary"  title="是否有挂职经历">
                            </td>
                            <td>
                                <%--是否有挂职经历start--%>
                                <div class="col-item save">
                                    <input type="text" name="tempWorkExperience" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="tempWorkExperience" lay-verify="" class="joSelect"
                                            data="" dataurl="pms/pmsDictionary/getListByDictionary/TEMPORARY_WORK_EXPERIENCE"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>
                                <%--是否有挂职经历end--%>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md2 layui-col-sm2 layui-col-xs-2">
                        <input type="checkbox" autocomplete="off" id="eduinfo" lay-filter="xqy" lay-skin="primary" title="学历信息">
                    </div>
                    <div class="line"></div>
                    <table class="layui-col-md10 layui-col-sm10 layui-col-xs-10">
                        <tbody>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="firstEducation" class="col-item" lay-skin="primary"  title="全日制学历">
                            </td>
                            <td>
                                <%--第一学历start--%>
                                <div class="col-item save">
                                    <input type="text" name="firstEducation" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="firstEducation" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--第一学历end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="firstDegree" class="col-item" lay-skin="primary"  title="全日制学位">
                            </td>
                            <td>
                                <%--第一学位start--%>
                                <div class="col-item save">
                                    <input type="text" name="firstDegree" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="firstDegree" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--第一学位end--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="jobEducation" class="col-item" lay-skin="primary"  title="在职学历">
                            </td>
                            <td>
                                <%--在职学历start--%>
                                <div class="col-item save">
                                    <input type="text" name="jobEducation" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="jobEducation" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--在职学历end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="jobDegree" class="col-item" lay-skin="primary"  title="在职学位">
                            </td>
                            <td>
                                <%--在职学位start--%>
                                <div class="col-item save">
                                    <input type="text" name="jobDegree"  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="jobDegree" lay-verify="" class="joSelect" data=""
                                            dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue"
                                            valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--在职学位end--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="specialty" class="col-item" lay-skin="primary"  title="从事专业">
                            </td>
                            <td>
                                <%--从事专业--%>
                                <div class="col-item">
                                    <input type="text" name="specialty"  placeholder="" autocomplete="off" class="layui-input" >

                                </div>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="overseasStudyExperience" class="col-item" lay-skin="primary"  title="国外一年以上留学经历">
                            </td>
                            <td>
                                <%--国外1年以上留学经历start--%>
                                <div class="col-item save">
                                    <input type="text" name="overseasStudyExperience" disabled  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <div class="col-item edit">
                                    <select async="true" name="overseasStudyExperience" lay-verify="" class="joSelect"
                                            data="" dataurl="pms/pmsDictionary/getListByDictionary/OVERSEAS_STUDY_EXPERIENCE"
                                            keyfield="dicValue" valuefield="dicValue"
                                            firstitem='{"dicValue":"","dicValue":""}'></select>
                                </div>

                                <%--国外1年以上留学经历end--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="englishLevel" class="col-item" lay-skin="primary"  title="熟悉何种外语及水平">
                            </td>
                            <td>
                                <%--外语水平start--%>
                                <div class="col-item">
                                    <input type="text" name="englishLevel"  placeholder="" autocomplete="off" class="layui-input">
                                </div>
                                <%--外语水平end--%>
                            </td>
                            <td>
                                <input type="checkbox" autocomplete="off" name="eduinfo" status="" cname="remark" style="padding-top: 4px !important;" class="col-item" lay-skin="primary"  title="备注">
                            </td>
                            <td>
                                <%--备注--%>
<%--                                <div class="col-item">
                                    <input type="text" name="remark"  placeholder="" autocomplete="off" class="layui-input" >
                                </div>--%>
                                    <%--备注start--%>
                                    <%--<c:if test="${fn:contains(loginUser.roleId,'79a80080f55740f1a1b146af57dfcf27')}">--%>
                                        <div class="col-item save">
                                            <input type="text" name="remark"  required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                                        </div>
                                        <div class="col-item edit">
                                            <select name="remark" lay-verify="" >
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

                                    <%--</c:if>--%>
                                    <%--备注end--%>
                            </td>
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
                            });
                            laydate.render({
                                elem: '#rudang'
                            });
                            laydate.render({
                                elem: '#get'
                            });
                            laydate.render({
                                elem: '#engage'
                            });
                            laydate.render({
                                elem: '#tenureTime'
                            });
                            laydate.render({
                                elem: '#toThereTime'
                                ,type: 'month'//new
                            });*/
            form.on('checkbox(xqy)', function(data){
                var id = $(data.elem).attr("id");
                joForm.checkAll(id);
                form.render('checkbox');
            });
        });

        // $("input").attr("readonly", "readonly");
        // $("input").addClass("readonly");
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>