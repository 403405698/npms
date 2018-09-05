<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <%--jQuery--%>
    <%@ include file="/common/jqueryHead.jsp"%>
    <%--jo--%>
    <%--<%@ include file="/common/joHead.jsp"%>--%>
        <link href="<%=URL_STATIC%>static/plugin/jo/joUI.css" rel="stylesheet"/>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo.js"></script>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
        <script src="<%=URL_STATIC%>static/plugin/jo/jo-page-view.js"></script>
        <script src="<%=URL_STATIC%>static/newjs/rh_audit_field_form.js"></script><%--//新增测试--%>
        <%--<script src="<%=URL_STATIC%>static/newjs/jo-page-form.js"></script>&lt;%&ndash;//新增测试&ndash;%&gt;--%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%@ include file="/common/uploadHeadOfImg.jsp"%>

    <title>基本信息编辑</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "pms/pmsUser/insert.action",//新增
                    "deleteUrl" : "pms/pmsUser/delete.action",//删除
                    // "updateUrl" : "pms/auditPmsUser/update.action",//修改
                    "updateUrl" : "pms/auditFieldBase/update.action",//修改
                    // "formDataUrl" : "pms/auditPmsUser/get.action"	//查询
                    "formDataUrl" : "pms/pmsUser/get.action"	//查询
                    // "formDataUrl" : "pms/auditFieldBase/getUserAuditInfo.action"	//查询
                };
                joForm.initFormPage(jParams);//初始化
            });
            //初始化表单值前处理
            joForm.initFormValueBefore = function(oJson){
            };
            //表单初始化值的后置处理,在此对formData进行判断,如果没有从后台查到结果(formData为{}),说明应该执行新增
            joForm.initFormValueAfter = function(){
                if(!joForm.formData.id){//新增表单,需要对joForm对象进行校正
                    joFormUpdateToAdd(true);//修改表单转新增表单
                }else{
                    // $("#header").attr("src", "fs/file/image?id="+joForm.formData.photoAddress);
                    $("#header").attr("src", "fs/file/image?id="+auditPhotoAddress);

                }
                loadUserDept();
            };
            //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
            joForm.initFormPageOfAdd = function(){
                userIdHandleInAddForm();//userId字段处理
                if(jo.getUrlParam("id") && document.getElementsByName("id")[0]){
                    document.getElementsByName("id")[0].value = jo.getUrlParam("id");//设置主键值
                    $(document.getElementsByName("id")[0]).attr("readonly",true);
                }
            };
            //新增成功回调
            joForm.saveSuccessAfter = function(result){
                top.jo.showMsg("创建成功!");//提示信息
                if(top.main.joView.inited){
                    top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    jo.closeSelf('WIN_ADD');//关闭自己
                }else{
                    location.reload();
                }
            };
            //删除成功回调
            joForm.delSuccessAfter = function(){
                top.jo.showMsg("删除成功!");//提示信息
                if(top.main.joView.inited){
                    top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    jo.closeSelf('WIN_EDIT');//关闭自己
                }else{
                    location.reload();
                }
            };
            //修改成功回调
            joForm.updateSuccessAfter = function(){
                top.jo.showMsg("修改成功!");//提示信息
                if(top.main.joView.inited){
                    top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();//刷新当前页面
                }else{
                    location.reload();
                }
            };
            //上传照片
            var UPLOAD_FILE_TYPES = "jpg,png";//上传图片格式要求
            function uploadPhoto(){
                jo.uploadFile("{URL_FS}fs/file/upload", function(success, file, json){
                    if(success && json){
                        jo.closeUploadDialog();//关闭上传窗口
                        if(json.code == "0" && json.data[0]){
                            $("#photoAddress").val(json.data[0].id);
                            $("#header").attr("src", URL_FS + "fs/file/image?id="+json.data[0].id);
                            if(joForm.isAdd){
                                jo.showMsg("上传成功,点击新增按钮进行保存!", {icon:1});
                            }else{
                                jo.showMsg("上传成功,点击修改按钮进行保存!", {icon:1});
                            }
                        }else{
                            jo.showMsg(json.info);
                        }
                    }
                });
            }
            //选择部门
            var deptWinIdx;
            function choiceDept(idInp, nameInp, bMore){
                deptWinIdx = jo.selectTree('{URL_UMS}ums/tree/getDeptTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
            }
            //选择窗按钮点击回调
            jo.selectListCall = function(status, ids, names){
                if(status){//确定按钮
                    if(ids && joForm.formData.id){
                        jo.postAjax("pms/pmsUser/refreshUserDept", {userId:joForm.formData.id, deptIds:ids}, function(json){
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
                console.log("userform.jsp:" + joForm.formData.toString());
                if(joForm.formData.id){
                    jo.postAjax("pms/pmsUser/getUserDeptByUserId", {userId:joForm.formData.id}, function(json){
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

            //获取选中的checkbox的id
            function getCheckBoxIds(flag) {
                console.log("获取所有CHECKBOX：是否一键：" + flag);
                var eles;
                if (flag) {
                    //获取所有、用于一键操作
                    eles = $("input:checkbox");
                }else {
                    eles = $("input:checkbox:checked");
                }
                var idStr = "";
                for(var i=0;i<eles.length;i++){
                    //TODO 注意：不要给小区域总复选框 name 属性
                    if (eles[i].getAttribute("name") != null) {
                        idStr += "," + eles[i].value;
                    }
                }
                idStr = idStr.substring(1);
                return idStr;
            }
            //锁定按钮 start
            //复选切换状态
            function changeState(auditStatus,lockStatus,onekey){
                var idStr = getCheckBoxIds(onekey);
                var userId = $("#id").val();
                var itemId = $("#itemId").val();
                console.log("破该仔测试条目ID：" + itemId);
                console.log("破该仔测试auditStatus：" + auditStatus);
                console.log("破该仔测试打印ID：" + idStr);
                console.log("破该仔测试lockStatus：" + lockStatus);
                if (idStr == "") {
                    // window.parent.jo.showMsg("请至少选择一项!");
                    jo.showMsg("请至少选择一项!");//可以用
                    return;
                }else {
                    var tipMsg = "确定执行该操作？";
                    if (onekey) {
                        tipMsg = "<span style='color:red'>提示：该操作将一键通过所有字段！</span>";
                    }
                    jo.confirm(tipMsg,function () {
                        var url = "pms/auditRecordBaseinfo/changeStatus.action";
                        var oData = {};
                        oData["ids"] = idStr;
                        oData["userId"] = userId;
                        oData["itemId"] = itemId;
                        if (auditStatus != null) {
                            oData["auditStatus"] = auditStatus;
                        }
                        if (lockStatus != null) {
                            oData["lockStatus"] = lockStatus;
                        }
                        console.log("审核人员审核提交的数据：" + JSON.stringify(oData));
                        jo.postAjax(url,oData,function(result){
                            console.log("返回结果：" + JSON.stringify(result));
                            if(result.code == 0){
                                // jo.showMsg("操作成功！");
                                // window.parent.jo.showMsg("操作成功！");
                                top.jo.showMsg("操作成功！");
                                // top.main.joView.reloadCurrentPage();//重新加载父页面数据
                                // window.location.reload();//刷新当前页面
                                // joView.reloadCurrentPage();//重新加载当前页数据(no)
                                // window.parent.reloadCurrentPage();//重新加载父页面数据(keyi)
                                window.parent.location.reload();//锁定目标，可以刷新右侧显示
                                if(typeof (joView.delSuccessOver) == "function"){
                                    joView.delSuccessOver(result, idStr);
                                }
                            }else{
                                jo.showMsg(result.info)
                            }
                        });
                    });
                }
/*                var state = oldState == 1 ? 2 : 1;
                jo.postAjax("pms/auditPmsWork/lockUpdate.action", {"lockStatus":state,"id":id}, function(json){
                    if(json && json.code == 0){
                        jo.showMsg("状态切换成功!");
                        joView.reloadCurrentPage();
                    }else{
                        jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                    }
                });*/
            }
            //暂且没用：单一切换
            function singleChangeState(oldState){
                var state = oldState == 1 ? 2 : 1;
                jo.postAjax("pms/auditPmsWork/lockUpdate.action", {"lockStatus":state,"id":id}, function(json){
                    if(json && json.code == 0){
                        jo.showMsg("状态切换成功!");
                        joView.reloadCurrentPage();
                    }else{
                        jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                    }
                });
            }
            //锁定按钮end

            //复选框checkall start 增加判断条件默认全选待审核
            function checkAll (id) {
                // $("input[name='"+id+"']:checkbox").prop("checked",$("#" + id).prop("checked"));
                $("input[name='"+id+"']:checkbox").each(function () {
                    if ($(this).attr("status") == 5) {
                        $(this).prop("checked",$("#" + id).prop("checked"));
                    }
                });
            }
            //复选框checkall end
        </script>
        <%--新增：旧页面临时处理，设置不可编辑,去除checkbox标签 start--%>
        <script>
            $(function () {
                var elements = document.getElementById("pageForm").elements;
                for (var i=0;i<elements.length;i++) {
                    var e = elements[i];
                    if (e.type != "checkbox" && e.type != "hidden") {
                        e.setAttribute("readonly",true);
                        e.setAttribute("disabled",true);
                    }
                }

                //移除img点击事件
                var img = $("#header");
                img.removeAttr("onclick");
            });
        </script>
        <%--新增：设置不可编辑end--%>

        <script type="text/javascript">
            var userId = jo.getUrlParam("id");
            $(function(){
                console.log("修改后赋值吗" + userId);
                jo.postAjax("pms/auditPmsUser/getAuditItem.action",{"userId":userId},function (json) {
                    console.log("刷新左侧菜单返回的值：" + JSON.stringify(json));
                    if (json.code == 0) {
                        //获取父页面所有的a标签
                        $("a",parent.document).each(function (i,ele) {
                            $.each(json.data,function (j,arr) {
                                if (i == j){
                                    $(ele).next().html("<span style='color:red'>"+ arr +"</span>项待审核new");
                                }
                            });
                        });
                    }
                });
            });
        </script>
    <style>
        .dept_ul{
            width: auto;height: auto;list-style: none;
            margin: 0px;padding: 0px;
        }
        .dept_ul>li{
            width:auto;height: 28px;line-height: 28px;border: #dddddd solid 1px;display: inline-block;
            padding: 0px 35px 0px 12px;background-color: #F7F7F7;cursor: default;
            position: relative;margin-right: 8px;
        }
        .li_close{
            width: 20px;height: 20px;line-height: 20px;text-align: center;
            border-radius: 10px;cursor: pointer;
            border: #DCDCDC solid 1px;position: absolute;right: 3px;top: 3px;
        }
        .li_close:hover{
            color: blue;font-weight: bolder;border: #CBCBCB solid 1px;
        }
    </style>
</head>
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
                <div class="form-group button-bar">
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(1,null,true)">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;一键通过
                    </button>
<%--                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(2,null,true)">
                        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;一键不通过
                    </button>--%>
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(1,null,false)">
                        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;单字段审核通过
                    </button>
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(2,null,false)">
                        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;单字段审核不通过
                    </button>
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(null,1,false)">
                        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;锁定字段
                    </button>
                    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(null,2,false)">
                        <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;解锁字段
                    </button>
      <%--              <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="auditChange(4)">
                        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                    </button>--%>
                </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <tr>
                        <td width="140px" rowspan="4" title="上传头像">
                            <input type="checkbox" name="" status="" lockStatus="">头像
                            <img id="header" onerror="this.src='<%=URL_STATIC%>static/images/def_head.jpg'" class="cursor-hand" width="128px" height="158px" onclick="uploadPhoto()"/>
                        </td>

                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="" status="" lockStatus="">人员姓名
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="hidden" id="id"  name="id" class="form-control input-sm" readonly ErrEmpty="用户编号不允许为空" />
                                <input type="hidden"  name="userId" class="form-control input-sm" readonly  />
                                <input type="hidden" id="itemId" class="form-control input-sm" readonly  />
                                <input type="hidden" id="photoAddress" name="photoAddress" class="form-control input-sm" />
                                <input type="text"  name="userName" class="form-control input-sm" />
                            </div>

                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="" status="" lockStatus="">曾 用 名
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="oldName" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="" status="" lockStatus="">籍　　贯
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="placeOfOrigin" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            所属部门
                            (<a class="cursor-hand" onclick="choiceDept('deptIds', 'deptNames', true)">选择</a>)
                        </td>
                        <td class="tnt">
                            <ul class="dept_ul">
                                <%--<li>人事处<div class="li_close" title="移出此部门">×</div></li>--%>
                            </ul>
                            <input type="hidden" id="deptIds" name="deptIds" class="form-control input-sm">
                            <%--<input type="text" id="deptNames" name="deptNames" class="form-control input-sm">--%>
                            <%--<div class="input-group">
                                <input type="hidden" id="deptIds" name="deptIds" class="form-control input-sm">
                                <input type="text" id="deptNames" name="deptNames" class="form-control input-sm">
                                <span class="input-group-btn">
                                    <button class="btn btn-default btn-sm" type="button" onclick="choiceDept('deptIds', 'deptNames', true)">
                                        <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                                    </button>
                                </span>
                            </div>--%>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <caption>基本信息：
                        <input type="checkbox" id="baseinfo" onclick="checkAll('baseinfo')">
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">性　　别
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="sex" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">出生年月
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="birth" class="form-control input-sm" onclick="laydate()" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">民　　族
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="nation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                            <%--<input type="text"  name="nation" class="form-control input-sm" />--%>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">身份证号
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="idCard" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">出 生 地
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="placeOfBirth" class="form-control input-sm" />

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">参加工作时间
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text" onclick="laydate()" name="workStartTime" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">政治面貌
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="politicalOutlook" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/POLITICAL_OUTLOOK" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">入党时间
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text" onclick="laydate()" name="joinPartyTime" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">岗　　位
                        </td>
                        <td class="tnt" colspan="3">
                            <div class="input-group">
                                <input type="text" name="station" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="baseinfo" status="" lockStatus="">承担的工作
                        </td>
                        <td class="tnt" colspan="3">
                            <textarea name="takeWork" class="form-control input-sm" ></textarea>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <caption>工作信息：
                        <input type="checkbox" id="workinfo" onclick="checkAll('workinfo')">
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">专业技术职务
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="technicalPosition" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_POSITION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">取得时间
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text" onclick="laydate()" name="getTime" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                                    <input type="checkbox" name="workinfo" status="" lockStatus="">专业技术等级
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="technicalLevel" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_LEVEL" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">聘任时间
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text" onclick="laydate()" name="appointmentTime" class="form-control input-sm" />

                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">行政职务
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="administrativeDuty" class="form-control input-sm" />

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">任职时间
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text" onclick="laydate()" name="tenureTime" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">行政级别
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="administrativeLevel" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">研究领域
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="researchField" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/RESEARCH_FIELD" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="workinfo" status="" lockStatus="">研究领域细分
                        </td>
                        <td class="tnt" colspan="3">
                            <div class="input-group">
                                <input type="text" name="researchFieldDetail" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 15px;">
                    <caption>学历信息：
                        <input type="checkbox" id="eduinfo" onclick="checkAll('eduinfo')">
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <%--<tr>
                        <td width="15%" class="active" align="">最高学历</td>
                        <td class="tnt">
                            <select async="true" name="highestEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td width="15%" class="active" align="">最高学位</td>
                        <td class="tnt">
                            <select async="true" name="highestDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                    </tr>--%>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">第一学历
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="firstEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">第一学位
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="firstDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">在职学历
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="jobEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                        <td width="15%" class="active" align="">
                                    <input type="checkbox" name="eduinfo" status="" lockStatus="">在职学位

                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="jobDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">从事专业
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="specialty" class="form-control input-sm" />

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">国外1年以上留学经历</td>
                        <td class="tnt">
                            <div class="input-group">
                                <select async="true" name="overseasStudyExperience" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/OVERSEAS_STUDY_EXPERIENCE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">外语水平
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="englishLevel" class="form-control input-sm" />
                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="eduinfo" status="" lockStatus="">备　　注
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="remark" class="form-control input-sm" />
                            </div>
                        </td>
                    </tr>

                    <c:if test="${fn:contains(loginUser.roleId,'79a80080f55740f1a1b146af57dfcf27')}">
                        <tr>
                            <td class="active" align="">人员类型</td>
                            <td class="tnt">
                                <select async="true" name="personType" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/PERSON_TYPE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                            </td>
                            <td class="active" align="">显示顺序</td>
                            <td class="tnt">
                                <input type="text"  name="num" class="form-control input-sm" />
                            </td>
                        </tr>
                    </c:if>
                </table>
            </form>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
<script>

// 一键审核
    function  auditChange(status) {
        var ss = jo.form2Json(joForm.params["formObj"]);
        console.log("测试打印：" + JSON.stringify(ss));
        var len = $('input[type=checkbox]').length;
        var allLen = $('input[type=checkbox]').length;;
/*        if (len == 0) {
           window.parent.jo.showMsg("没有要审核的项!");
           return;
       }*/
        var pData = {};
        var userId = $("input[name='id']").val();
        pData["status"] = status;
        pData["id"] = userId;
        $.each($("input[type='checkbox']"),function(){
            var key = $(this).next().attr("name");
            var val = $(this).next().val();
            pData[key] = val;
        });
        console.log("pdata" + JSON.stringify(pData));

        if (len < allLen) {
            //没有全部点击，有不同
            pData["hasDiff"] = 1;
        }

        console.log("pdata" + JSON.stringify(pData));
        sUrl = "pms/auditFieldBase/update.action";

        if(typeof(joForm.dealDataAtUpdateBefore) == "function"){
            joForm.dealDataAtUpdateBefore(pData);
        }

        console.log("pdata22" + JSON.stringify({"pData":pData}));
        jo.postAjax(sUrl,{"pData":JSON.stringify(pData)}, function(result){
            if(result.code == 0){
                if(typeof(joForm.updateSuccessAfter) == "function"){
                    joForm.updateSuccessAfter(result);
                }else{
                    window.parent.jo.showMsg("操作成功!");
                    window.parent.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();
                }
            }else{
                jo.showMsg(result.info)
            }
        });
    };
    // 审核 end


   // 单字段审核 start
    /**
     * 修改数据
     */
    function  auditField(status) {
        var len = $('input[type=checkbox]:checked').length;
        var allLen = $('input[type=checkbox]').length;;
        console.log("长度" + len);
        if (len == 0) {
            window.parent.jo.showMsg("请至少选择一项!");
            return;
        }
        var pData = {};
        var userId = $("input[name='id']").val();
        pData["status"] = status;
        pData["id"] = userId;
        $.each($("input[type='checkbox']:checked"),function(){
            var key = $(this).next().attr("name");
            var val = $(this).next().val();
            pData[key] = val;
        });
        console.log("pdata" + JSON.stringify(pData));
        
        if (len < allLen) {
            //没有全部点击，有不同
            pData["hasDiff"] = 1;
        }

        console.log("pdata" + JSON.stringify(pData));
        sUrl = "pms/auditFieldBase/update.action";

        //修改前对表单数据的处理
        if(typeof(joForm.dealDataAtUpdateBefore) == "function"){
            joForm.dealDataAtUpdateBefore(pData);
        }
        //表单验证
        /*                if(typeof (joForm.checkForm) == "function"){
                    joForm.checkForm(joForm.form);
                }else{
                    if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                        return;
                    }
                }*/
        console.log("pdata22" + JSON.stringify({"pData":pData}));
        jo.postAjax(sUrl,{"pData":JSON.stringify(pData)}, function(result){
            if(result.code == 0){
                if(typeof(joForm.updateSuccessAfter) == "function"){
                    joForm.updateSuccessAfter(result);
                }else{
                    window.parent.jo.showMsg("操作成功!");
                    window.parent.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();
                }
            }else{
                jo.showMsg(result.info)
            }
        });
    };
    // 单字段审核 end

</script>

<script>
    $(function () {
        console.log("参数打印：" + JSON.stringify(joForm.params["formObj"]));
    });

</script>
</body>
</html>
