<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>通讯信息</title>
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
        var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
        var _edit = jo.getDefVal(jo.getUrlParam("edit"),"");
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "auditPKName" : "userId",//用于获取审核库数据时用到的主键字段类是userID获取到的是list，必须写
                "saveAfter" : "toEdit",//保存之后是关闭还是继续编辑
                "formDataUrl" : "pms/communication/get.action",	//正式库信息
                "auditDataUrl" : "pms/auditRecordCommunication/getUserAuditInfo",//审核库中的信息
                "auditUpdateUrl" : "pms/auditRecordCommunication/userUpdate.action"//用户修改提交审核URL
            };

            var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
            if (jo.isValid(sf)) {
                jParams["auditUpdateUrl"] = "pms/auditRecordCommunication/userUpdate.action?sf=rs";
            }

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
                            if (formAuditData[f]["lockStatus"] != 1) {
                                element.removeAttr("disabled");
                            }
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
                //rs
                if (jo.isValid(sf)) {
                    element.removeAttr("disabled");
                }
                //rs
            }
            //处理状态显示end
        }

        joForm.initFormValueAfter = function(){
        };

    </script>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("id"), loginUser.id);
        $(function(){
            $("#id").val(userId);
            goto();
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
    </script>
    <style>
        .person-content .tit {}

        .line {
            left: 120px;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <div class="layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">个人档案</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary export">导出Excel</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary preview">信息预览</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary edit">编辑</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary save" onclick="joForm.auditUpdate()">保存</button>
                        <%--<button type="button" class="layui-btn layui-btn-radius layui-btn-primary save" onclick="joForm.auditUpdate()">修改</button>--%>
                    </div>
<%--                    <div class="layui-inline">
                        <i class="layui-icon layui-icon-search"></i>
                        <input type="text" name="title" placeholder="搜索条目编号" autocomplete="off" class="layui-input search-input">
                    </div>--%>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">2  通讯信息</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">0%</span>--%>
                        </div>
                        <div class="select-content">
                            <ul id="selectContent">
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/personal/myDoc.jsp?id=">
                                        <span class="left opt">1  基本信息</span>
                                        <%--             <span class="txt">完善度</span>
                                                     <span class="baifen">60%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/communicationForm.jsp?id=">
                                        <span class="left opt">2  通讯信息</span>
                                        <%--              <span class="txt">完善度</span>
                                                      <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/relationList.jsp?userId=">
                                        <span class="left opt">3  家庭成员和社会关系</span>
                                        <%--               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/educationList.jsp?userId=">
                                        <span class="left opt">4  教育经历</span>
                                        <%--                <span class="txt">完善度</span>
                                                        <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/workList.jsp?userId=">
                                        <span class="left opt">5  工作经历</span>
                                        <%--                <span class="txt">完善度</span>
                                                        <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/mainTechGroupList.jsp?userId=">
                                        <span class="left opt">6  社团兼职</span>
                                        <%--           <span class="txt">完善度</span>
                                                   <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/honorTitleList.jsp?userId=">
                                        <span class="left opt">7  荣誉称号</span>
                                        <%--             <span class="txt">完善度</span>
                                                     <span class="baifen">60%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/techAwardsList.jsp?userId=">
                                        <span class="left opt">8  获奖情况</span>
                                        <%--               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/paperList.jsp?userId=">
                                        <span class="left opt">9  论文情况</span>
                                        <%--          <span class="txt">完善度</span>
                                                  <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/publishList.jsp?userId=">
                                        <span class="left opt">10 出版著作</span>
                                        <%--                 <span class="txt">完善度</span>
                                                         <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/patentList.jsp?userId=">
                                        <span class="left opt">11 专利</span>
                                        <%--                      <span class="txt">完善度</span>
                                                              <span class="baifen">80%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/joinProjectList.jsp?userId=">
                                        <span class="left opt">12 项目经历</span>
                                        <%--  <span class="txt">完善度</span>
                                          <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/tnBraceList.jsp?userId=">
                                        <span class="left opt">13 技术支撑</span>
                                        <%--                   <span class="txt">完善度</span>
                                                           <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/supportProjectList.jsp?userId=">
                                        <span class="left opt">14 人力培养计划/资助项目</span>
                                        <%--                      <span class="txt">完善度</span>
                                                              <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/yearCheckList.jsp?userId=">
                                        <span class="left opt">15 年度考核</span>
                                        <%--                       <span class="txt">完善度</span>
                                                               <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
<%--                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/selfEvaluationForm.jsp?id=">
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
            <form id="pageForm" class="layui-form layui-form-box person-content">
                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 140px;">
                        个人通讯信息
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;">
                        <div>
                            <div class="label">办公电话</div>
                        </div>
                        <div>
                            <div class="label">传真号</div>
                        </div>
                        <div>
                            <div class="label">通讯地址</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="text" name="officePhone" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input">
                            <input type="hidden"  name="userId" />
                            <input type="hidden" id="id" name="id"/>
                        </div>
                        <div class="col-item">
                            <input type="text" name="faxNumber" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item lang">
                            <input type="text" name="postalAddress" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div>
                            <div class="label">手机号</div>
                        </div>
                        <div>
                            <div class="label">邮箱地址</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="number" name="mobilePhone" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="email" name="emailAddress" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 140px">
                        紧急联系人一
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;">
                        <div>
                            <div class="label">关系</div>
                        </div>
                        <div>
                            <div class="label">手机号</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="text" name="relationshipOne" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="text" name="emergencyContactOne" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div>
                            <div class="label">姓名</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item ">
                            <input type="text" name="nameOne" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                </div>

                <div class="layui-row row-two">
                    <div class="layui-col-md1 tit" style="width: 140px;">
                        紧急联系人二
                    </div>
                    <div class="line"></div>
                    <div class="layui-col-md1" style="margin-left: 10px;">
                        <div>
                            <div class="label">关系</div>
                        </div>
                        <div>
                            <div class="label">手机号</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item">
                            <input type="text" name="relationshipTwo" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                        <div class="col-item">
                            <input type="text" name="emergencyContactTwo" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input" >
                        </div>
                    </div>
                    <div class="layui-col-md1">
                        <div>
                            <div class="label">姓名</div>
                        </div>
                    </div>
                    <div class="layui-col-md3">
                        <div class="col-item ">
                            <input type="text" name="nameTwo" disabled required lay-verify="required" placeholder="" autocomplete="off" class="layui-input"  >
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
                });*/
            });;
        })
    </script>
</body>

</html>