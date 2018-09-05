<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>通讯信息审核</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/common.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/person-document.css">
    <script src="<%=URL_STATIC%>static/final/js/common.js"></script>

    <script src="<%=URL_STATIC%>static/plugin/jo/jo.js"></script>
    <script src="<%=URL_STATIC%>static/plugin/jo/jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_rh_audit_field_form.js"></script><%--//新增测试--%>
    <script>
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "auditPKName" : "userId",
                "saveAfter" : "toEdit",
                "formDataUrl" : "pms/pmsUser/get.action",	//查询
                "auditDataUrl" : "pms/auditRecordCommunication/getUserAuditInfo",
                "changeStateUrl" : "pms/auditRecordCommunication/changeStatus.action"
            };
            joForm.initFormPage(jParams);//初始化
        });

        //new
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

        //new

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

            //处理状态显示end
        }

        function setUserName() {
            var adata = {};
            var odata = {};
            var auditData = jo.postAjax("pms/auditRecordBaseinfo/getUserAuditInfo",{"userId":userId});
            if(auditData != null && auditData.data.length > 0 && auditData.data[0]){
                adata = auditData.data[0];//存放到form.formData,方便调用
            }else{
                adata = {};
            }
            var result = jo.postAjax("pms/pmsUser/get.action",{"id":userId});
            if(result != null && result.data.length > 0 && result.data[0]){
                odata = result.data[0];
            }else{
                odata = {};
            }

            $("#auditWho").attr("value",userId);
            if (jo.isValid(odata["userName"])) {
                $("#auditWho").text(odata["userName"]);
            } else {//正式库没有数据，使用审核库
                for (var i=0;i<adata.length;i++) {
                    if("userName" == adata[i]["fieldKey"]) {
                        $("#auditWho").text(adata[i]["fieldVal"]);
                    }
                }
            }

        }
    </script>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("id"), loginUser.id);
        $(function(){
            goto();
            setUserName();
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
            width: 140px;
        }

        .line {
            left: 150px;
        }

        .row-two .iconfont.show {
            position: absolute;
            top: 20px;
            left: -40px;
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
                        <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(1,null,true)">一键通过</button>--%>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(1,null,false)">单字段审核通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(2,null,false)">单字段审核不通过</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password no-reviewe" onclick="joForm.changeState(5,null,false)">置为未审核</button>
                        <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password no-reviewe">非审核字段</button>--%>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joForm.changeState(null,1,false)">锁定字段</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joForm.changeState(null,2,false)">解锁字段</button>
                    </div>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">2  通讯信息</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">待审核</span>--%>
                        </div>
                        <div class="select-content">
                            <ul id="selectContent">
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditUserDoc.jsp?edit=true&id=">
                                        <span class="left opt">1  基本信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditCommunicationForm.jsp?edit=true&id=">
                                        <span class="left opt">2  通讯信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditRelationList.jsp?userId=">
                                        <span class="left opt">3  家庭成员和社会关系</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditEducationList.jsp?userId=">
                                        <span class="left opt">4  教育经历</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditWorkList.jsp?userId=">
                                        <span class="left opt">5  工作经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditMainTechGroupList.jsp?userId=">
                                        <span class="left opt">6  社团兼职</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditHonorTitleList.jsp?userId=">
                                        <span class="left opt">7  荣誉称号</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditTechAwardsList.jsp?userId=">
                                        <span class="left opt">8  获奖情况</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditPaperList.jsp?userId=">
                                        <span class="left opt">9  论文情况</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditPublishList.jsp?userId=">
                                        <span class="left opt">10 出版著作</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditPatentList.jsp?userId=">
                                        <span class="left opt">11 专利</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditJoinProjectList.jsp?userId=">
                                        <span class="left opt">12 项目经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditTnBraceList.jsp?userId=">
                                        <span class="left opt">13 技术支撑</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditSupportProjectList.jsp?userId=">
                                        <span class="left opt">14 人力培养计划/资助项目</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditYearCheckList.jsp?userId=">
                                        <span class="left opt">15 年度考核</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
<%--                                <li>
                                    <a lay-href="<%=basePath%>page/pms/auditSelfEvaluationForm.jsp?id=">
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
            <form id="pageForm" class="layui-form layui-form-box person-content">
                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 150px;">
                        <input type="checkbox" autocomplete="off" id="selfcommu" lay-skin="primary" lay-filter="xqy" title="个人通讯信息">
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;width: 140px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="selfcommu" status="" cname="officePhone" lay-skin="primary" title="办公电话">
                        </div>
                        <div>
                            <input type="checkbox" autocomplete="off" name="selfcommu" status="" cname="faxNumber" lay-skin="primary" title="传真号">
                        </div>
                        <div>
                            <input type="checkbox" autocomplete="off" name="selfcommu" status="" cname="postalAddress" lay-skin="primary" title="通讯地址">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="hidden" name="userId"/>
                            <input type="hidden" id="id" name="id"/>

                            <input type="text" name="officePhone" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="text" name="faxNumber" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item lang">
                            <input type="text" name="postalAddress" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1" style="width: 140px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="selfcommu" status="" cname="mobilePhone" lay-skin="primary" title="手机号">
                        </div>
                        <div>
                            <input type="checkbox" autocomplete="off" name="selfcommu" status="" cname="emailAddress" lay-skin="primary" title="邮箱地址">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="number" name="mobilePhone" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="email" name="emailAddress" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 150px;">
                        <input type="checkbox" autocomplete="off" id="contactOne" lay-skin="primary" lay-filter="xqy" title="紧急联系人一">
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;width: 130px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactOne" status="" cname="relationshipOne" lay-skin="primary" title="关系">
                        </div>
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactOne" status="" cname="emergencyContactOne" lay-skin="primary" title="手机号">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="text" name="relationshipOne" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="text" name="emergencyContactOne" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1" style="width: 100px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactOne" status="" cname="nameOne" lay-skin="primary" title="姓名">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item ">
                            <input type="text" name="nameOne" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 150px;">
                        <input type="checkbox" autocomplete="off" id="contactTwo" lay-skin="primary" lay-filter="xqy" title="紧急联系人二">
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;width: 130px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactTwo" status="" cname="relationshipTwo" lay-skin="primary" title="关系">
                        </div>
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactTwo" status="" cname="emergencyContactTwo" lay-skin="primary" title="手机号">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="text" name="relationshipTwo" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="text" name="emergencyContactTwo" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1" style="width: 100px;">
                        <div>
                            <input type="checkbox" autocomplete="off" name="contactTwo" status="" cname="nameTwo" lay-skin="primary" title="姓名">
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item ">
                            <input type="text" name="nameTwo" required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>

            </form>
        </div>
    </div>
</div>


    <script>
        $(function() {
            layui.use(['layer', 'form', 'laydate'], function() {
                var form = layui.form;
                var layer = layui.layer;
                var laydate = layui.laydate;
                laydate.render({
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

                form.on('checkbox(xqy)', function(data){
                    var id = $(data.elem).attr("id");
                    joForm.checkAll(id);
                    form.render('checkbox');
                });
/*                //全选
                form.on('checkbox(allChoose)', function(data) {
                    var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
                    child.each(function(index, item) {
                        item.checked = data.elem.checked;
                    });
                    form.render('checkbox');
                });*/
            });
            // $("input").attr("readonly", "readonly");
            // $("input").addClass("readonly");


        })
    </script>
</body>

</html>
