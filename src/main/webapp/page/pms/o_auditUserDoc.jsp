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
    <%@ include file="/common/joHead.jsp"%>
    <%--bootstrap和字体--%>
    <%@ include file="/common/bootstrapHead.jsp"%>
    <%--layer--%>
    <%@ include file="/common/layerHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>人事档案审核</title>
        <script type="text/javascript">
            var userId = jo.getUrlParam("id");
            $(function(){
                jo.postAjax("pms/auditPmsUser/getAuditItem.action",{"userId":userId},function (json) {
                    if (json.code == 0) {
                        $.each($("a"),function (i,ele) {
                           $.each(json.data,function (j,arr) {
                               if (i == j){
                                   // ele.after(""+arr+"项待审核");
                                   $(ele).next().html("<span style='color:red'>"+ arr +"</span>项待审核");
                               }
                           });
                        });
                    }
                });
                $("#baseInfo").click();
            });
            function goTo(url){
                console.info(url + userId);
                $("iframe[name='person']").attr("src", url + userId);
                //document.person.src = url + joForm.params.PKValue;
            }
        </script>
        <style>
            html,body,.container-fluid{
                height: 100%;
            }
            .title-bar>p{
                font-size: 17.5px;
                font-weight: bold;
                margin-bottom: 5px;
                line-height: 25px;
            }
            .nav-pills>li{
                width: 100%;
            }
        </style>
</head>
<body class="">
<div class="container-fluid" style="height: 100%;">
    <div class="row" style="height: 100%;position: relative;">
        <div class="bg" style="height: 100%;padding: 15px;overflow-y: auto;position: absolute;top: 0px;left: 0px;width: 280px;z-index: 2;">
            <%--胶囊选项卡--%>
            <ul class="nav nav-pills" style="">
                <li class="active"><a id="baseInfo" class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditUserForm.jsp?id=')">基本信息</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/o_auditCommunicationForm.jsp?id=')">通讯信息</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditRelationList.jsp?userId=')">家庭成员和社会关系</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditEducationList.jsp?userId=')">教育经历</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditWorkList.jsp?userId=')">工作经历</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditMainTechGroupList.jsp?userId=')">社团兼职</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditHonorTitleList.jsp?userId=')">荣誉称号</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditTechAwardsList.jsp?userId=')">获奖情况</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditPaperList.jsp?userId=')">论文情况</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditPublishList.jsp?userId=')">出版著作/译著</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditPatentList.jsp?userId=')">专利</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditJoinProjectList.jsp?userId=')">项目经历</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditTnBraceList.jsp?userId=')">技术支撑</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditSupportProjectList.jsp?userId=')">人才培养计划、资助项目</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditYearCheckList.jsp?userId=')">年度考核</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditSelfEvaluationForm.jsp?id=')">自我评价</a><span></span></li>
                <li><a class="cursor-hand" data-target="#" data-toggle="pill" onclick="goTo('page/pms/auditLeaderEvaluationList.jsp?userId=')">领导评价</a><span></span></li>
            </ul>
        </div>
        <div class="col-xs-12" style="height: 100%;overflow-y: hidden;padding: 0px 0px 0px 280px;margin: 0px;overflow: hidden;position: relative;z-index: 1;">
            <iframe id="person" name="person" class="" src="" border="0" style="padding: 0px;width: 100%;height: 100%;border: none;margin: 0px;"></iframe>
            <%--<div class="tab-content">
                &lt;%&ndash;点位信息&ndash;%&gt;
                <div class="tab-pane fade in active" id="point" style="background-color: red;width: 100%;height: 100%;">
                    &lt;%&ndash;<h3>基础信息</h3>&ndash;%&gt;
                    1
                </div>
            </div>--%>
        </div>
    </div>
</div>



<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
