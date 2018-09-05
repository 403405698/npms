<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <script src="<%=URL_STATIC%>static/newjs/rh_audit_field_form_commu.js"></script><%--//新增测试--%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>xxxx</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "toEdit",
                    "addUrl" : "pms/auditPmsCommunication/insert.action",//新增
                    "deleteUrl" : "pms/communication/delete.action",//删除
                    "updateUrl" : "pms/auditFieldCommu/updateSingle.action",//修改
                    "formDataUrl" : "pms/communication/get.action"	//查询
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
                }
            };
            //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
            joForm.initFormPageOfAdd = function(){
                userIdHandleInAddForm();//userId字段处理
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
                console.log("破该仔测试打印IDS：" + idStr);
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
                        var url = "pms/auditRecordCommunication/changeStatus.action";
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
                                window.parent.jo.showMsg("操作成功！");
                                // top.jo.showMsg("操作成功！");//最顶级显示
                                // top.main.joView.reloadCurrentPage();//重新加载父页面数据
                                window.location.reload();//刷新当前页面
                                // joView.reloadCurrentPage();//重新加载当前页数据(no)
                                // window.parent.reloadCurrentPage();//重新加载父页面数据(keyi)
                                // window.parent.location.reload();//锁定目标，刷新父级页面
                                if(typeof (joView.delSuccessOver) == "function"){
                                    joView.delSuccessOver(result, idStr);
                                }
                            }else{
                                jo.showMsg(result.info)
                            }
                        });
                    });
                }

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
            });
        </script>
        <%--新增：设置不可编辑end--%>
        <script type="text/javascript">
            var userId = jo.getUrlParam("id");
            $(function(){
                console.log("修改后赋值吗" + userId);
                jo.postAjax("pms/auditPmsUser/getAuditItem.action",{"userId":userId},function (json) {
                    console.log("刷新左侧返回的值：" + JSON.stringify(json));
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

</head>
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(1,null,true)">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;一键审核
                </button>
<%--                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="changeState(2,null,true)">
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
                    <caption>个人通讯信息：
                        <input type="checkbox" id="selfcommu" onclick="checkAll('selfcommu')" >
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="selfcommu" status="" lockStatus="">办公电话
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="officePhone" class="form-control input-sm" />
                                <input type="hidden"  name="userId" class="form-control input-sm" />
                                <input type="hidden" id="id" name="id" class="form-control input-sm readonly-edit" ErrEmpty />
                                <input type="hidden" id="itemId" class="form-control input-sm" readonly  />
                            </div>

                        </td>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="selfcommu" status="" lockStatus="">手 机 号</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="mobilePhone" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="selfcommu" status="" lockStatus="">传 真 号</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="faxNumber" class="form-control input-sm" />

                            </div>
                        </td>
                        <td class="active" align="">
                            <input type="checkbox" name="selfcommu" status="" lockStatus="">邮箱地址</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emailAddress" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">
                            <input type="checkbox" name="selfcommu" status="" lockStatus="">通讯地址</td>
                        <td class="tnt" colspan="3">
                            <div class="input-group">
                                <input type="text"  name="postalAddress" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer" style="margin-bottom: 5px;">
                    <caption>紧急联系人一：
                        <input type="checkbox" id="contactOne" onclick="checkAll('contactOne')">
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="contactOne" status="" lockStatus="">关　　系</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="relationshipOne" class="form-control input-sm" />

                            </div>
                        </td>

                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="contactOne" status="" lockStatus="">姓　　名</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="nameOne" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="contactOne" status="" lockStatus="">联系电话</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emergencyContactOne" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <caption>紧急联系人二：
                        <input type="checkbox" id="contactTwo" onclick="checkAll('contactTwo')">
                        <span style="color: red">(点击可以快速选择待审核字段!)</span>
                    </caption>
                    <tr>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="contactTwo" status="" lockStatus="">关　　系</td>
                        <td class="tnt" colspan="">
                            <div class="input-group">
                                <input type="text"  name="relationshipTwo" class="form-control input-sm" />

                            </div>
                        </td>
                        <td width="15%" class="active" align="">
                            <input type="checkbox" name="contactTwo" status="" lockStatus="">姓　　名</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="nameTwo" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td width="100%" class="active" align="">
                            <input type="checkbox" name="contactTwo" status="" lockStatus="">联系电话</td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="text"  name="emergencyContactTwo" class="form-control input-sm" />

                            </div>
                        </td>
                    </tr>
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
    //1审核通过2审核不通过3不审核4删除
    function auditChange(status) {
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
        if(typeof(joForm.dealDataAtUpdateBefore) == "function"){
            joForm.dealDataAtUpdateBefore(pData);
        }

        console.log("pdata22" + JSON.stringify({"pData":pData}));
        sUrl = "pms/auditFieldCommu/updateSingle.action";
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
    }


    // 单字段审核 start
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
        sUrl = "pms/auditFieldCommu/updateSingle.action";

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
</body>
</html>

