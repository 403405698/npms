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
    <%@ include file="/common/joHead.jsp"%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <%@ include file="/common/uploadHeadOfImg.jsp"%>
    <title>人员新增</title>
        <script type="text/javascript">
            $(function(){
                var jParams = {
                    "PKName" : "id",//主键属性名
                    "saveAfter" : "close",
                    "addUrl" : "pms/pmsUser/ninsert.action",//新增
                    "deleteUrl" : "pms/pmsUser/delete.action",//删除
                    "updateUrl" : "pms/pmsUser/update.action",//修改
                    "formDataUrl" : "pms/pmsUser/get.action"	//查询
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
                    $("#header").attr("src", "fs/file/image?id="+joForm.formData.photoAddress);
                }
            };
            //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
            joForm.initFormPageOfAdd = function(){
                userIdHandleInAddForm();//userId字段处理
                if(jo.getUrlParam("id") && document.getElementsByName("id")[0]){
                    document.getElementsByName("id")[0].value = jo.getUrlParam("id");//设置主键值
                    $(document.getElementsByName("id")[0]).attr("readonly",true);
                }
            };
           /* //新增成功回调
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
            };*/
            //上传照片
            /*var UPLOAD_FILE_TYPES = "jpg,png";//上传图片格式要求
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
            }*/
            //选择部门
            function choiceDept(idInp, nameInp, bMore){
                jo.selectTree('{URL_UMS}ums/tree/getDeptTree.action',jo.getDefVal(idInp, 'PARENT_ID'),jo.getDefVal(nameInp, 'PARENT_NAME'),'ID','NAME', 'PARENT_ID', bMore);
            }
        </script>
</head>
<body class="">
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.save()">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;保存
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-primary" onclick="joForm.update()">
                    <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
                </button>
                <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-danger" onclick="joForm.del()">
                    <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                </button>
            </div>
            <%--按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <%--<td width="140px" rowspan="4">
                            <img id="header" class="cursor-hand" src="" width="128px" height="158px" title="上传头像" onclick="uploadPhoto()"/>
                        </td>--%>
                        <td width="15%" class="active must" align="">人员账号</td>
                        <td class="tnt">
                            <input type="text"  name="userId" class="form-control input-sm" ErrEmpty="人员账号不允许为空" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">人员姓名</td>
                        <td class="tnt">
                            <input type="text"  name="userName" class="form-control input-sm" />

                            <input type="hidden" id="photoAddress" name="photoAddress" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">
                            所属部门
                        </td>
                        <td class="tnt">
                            <div class="input-group">
                                <input type="hidden" id="deptIds" name="deptIds" class="form-control input-sm">
                                <input type="text" id="deptNames" name="deptNames" class="form-control input-sm">
                                <span class="input-group-btn">
                                    <button class="btn btn-default btn-sm" type="button" onclick="choiceDept('deptIds', 'deptNames', false)">
                                        <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                                    </button>
                                </span>
                            </div>
                        </td>
                    </tr>
                    <c:if test="${fn:contains(loginUser.roleId,'79a80080f55740f1a1b146af57dfcf27')}">
                        <tr>
                            <td class="active" align="">人员类型</td>
                            <td class="tnt">
                                <select name="personType" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/PERSON_TYPE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                            </td>
                        </tr>
                        <tr>
                            <td class="active" align="">显示顺序</td>
                            <td class="tnt">
                                <input type="text"  name="num" class="form-control input-sm" placeholder="正整数，例如：10，人员查询时按照升序排列" />
                            </td>
                        </tr>
                    </c:if>
                   <%-- <tr>
                        <td width="15%" class="active" align="">曾 用 名</td>
                        <td class="tnt">
                            <input type="text"  name="oldName" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">籍　　贯</td>
                        <td class="tnt">
                            <input type="text"  name="placeOfOrigin" class="form-control input-sm" />
                        </td>
                    </tr>--%>
                </table>
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <%--<tr>
                        <td width="15%" class="active" align="">性　　别</td>
                        <td class="tnt">
                            <select name="sex" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td width="15%" class="active" align="">出生年月</td>
                        <td class="tnt">
                            <input type="text"  name="birth" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">民　　族</td>
                        <td class="tnt">
                            &lt;%&ndash;<input type="text"  name="nation" class="form-control input-sm" />&ndash;%&gt;
                            <select name="nation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        &lt;%&ndash;<td class="active" align="">籍　　贯</td>
                        <td class="tnt">
                            <input type="text"  name="placeOfOrigin" class="form-control input-sm" />
                        </td>&ndash;%&gt;
                        <td class="active" align="">身份证号</td>
                        <td class="tnt">
                            <input type="text"  name="idCard" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">出 生 地</td>
                        <td class="tnt">
                            <input type="text"  name="placeOfBirth" class="form-control input-sm" />
                        </td>
                        <td class="active" align="">参加工作时间</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()" name="workStartTime" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">政治面貌</td>
                        <td class="tnt">
                            <select name="politicalOutlook" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/POLITICAL_OUTLOOK" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">入党时间</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()" name="joinPartyTime" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">专业技术职务</td>
                        <td class="tnt">
                            <select name="technicalPosition" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_POSITION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">取得时间</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()" name="getTime" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">专业技术等级</td>
                        <td class="tnt">
                            <select name="technicalLevel" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_LEVEL" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">聘任时间</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()" name="appointmentTime" class="form-control input-sm" />
                        </td>

                    </tr>
                    <tr>
                        <td class="active" align="">行政职务</td>
                        <td class="tnt">
                            <input type="text"  name="administrativeDuty" class="form-control input-sm" />
                        </td>
                        <td class="active" align="">任职时间</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()" name="tenureTime" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">行政级别</td>
                        <td class="tnt">
                            <select name="administrativeLevel" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">研究领域</td>
                        <td class="tnt">
                            <select name="researchField" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/RESEARCH_FIELD" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">从事专业</td>
                        <td class="tnt">
                            <input type="text"  name="specialty" class="form-control input-sm" />
                        </td>
                        <td class="active" align="">最高学历</td>
                        <td class="tnt">
                            <select name="highestEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                    </tr>
                       <tr>
                           <td class="active" align="">第一学历</td>
                           <td class="tnt">
                               <select name="firstEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                           </td>
                           <td class="active" align="">在职学历</td>
                           <td class="tnt">
                               <select name="jobEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                           </td>
                       </tr>
                    <tr>
                        <td class="active" align="">最高学位</td>
                        <td class="tnt">
                            <select name="highestDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">外语水平</td>
                        <td class="tnt">
                            <input type="text"  name="englishLevel" class="form-control input-sm" />
                        </td>
                    </tr>
                    <tr>
                        <td class="active" align="">国外1年以上留学经历</td>
                        <td class="tnt">
                            <select name="overseasStudyExperience" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/OVERSEAS_STUDY_EXPERIENCE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                        </td>
                        <td class="active" align="">备　　注</td>
                        <td class="tnt">
                            <input type="text"  name="remark" class="form-control input-sm" />
                        </td>
                    </tr>--%>

                </table>
            </form>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
