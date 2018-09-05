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
    <%--个人简历页面css--%>
    <link href="<%=URL_STATIC%>static/css/resume.css" rel="stylesheet">
    <title>简历展示</title>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("id"), loginUser.id);//如果没有传入指定用户id则查看当前用户简历
        $(function(){
            if(userId){
                loadBaseInfo();
                loadSelf();
                loadCommunication();
                loadRelations();
                loadEducation();
                loadWork();
                loadPaper();
                loadPublish();
                loadPatent();
                loadProject();
                loadBrace();
                loadTechAwards();
                loadMainGroup();
                loadSupport();
                loadHonor();
                loadYearCheck();
                loadLeader();
            }
        });
        //加载基础信息
        function loadBaseInfo(){
            jo.postAjax("pms/pmsUser/get", {"id":userId}, function(json){
                if(json && json.code == 0 && json.data[0]){
                    var user = json.data[0];
                    $(".c_top_right_name").text(user.userName);
                    var arr = ["birth", "placeOfOrigin", "nation", "sex"];//顶部展示信息
                    var _html = '';
                    for(var i=0;i<arr.length;i++){
                        if(user[arr[i]]){
                            _html += '<span class="ele_item">'+user[arr[i]]+'</span>';
                        }
                    }
                    $(".c_top_right_ele").html(_html);
                    //头像显示
                    if(user.photoAddress){
                        $("#header_img").attr("src", URL_FS + "fs/file/image.action?id=" + user.photoAddress);
                    }else{
                        $("#header_img").attr("src", URL_STATIC + 'static/images/def_head.jpg');
                    }
                    //基础信息
                    $("#baseInfo").find(".txt_space").each(function(idx, ele){
                        var name = $(ele).attr("name");
                        if(name){
                            $(ele).text(user[name]);
                        }
                    });
                }
            }, true);
        }
        //加载自我评价
        function loadSelf(){
            jo.postAjax("pms/pmsSelfEvaluation/get", {"id":userId}, function(json){
                if(json && json.code == 0 && json.data[0]){
                    var user = json.data[0];
                    $(".c_top_right_info").text(user.selfEvaluation);
                }
            }, true);
        }
        //加载通讯信息
        function loadCommunication(){
            jo.postAjax("pms/communication/get", {"id":userId}, function(json){
                if(json && json.code == 0 && json.data[0]){
                    var user = json.data[0];
                    var _html = '';
                    /*var arr = ["mobilePhone", "emailAddress"];//顶部展示信息
                    for(var i=0;i<arr.length;i++){
                        _html += '<span class="ele_item">'+user[arr[i]]+'</span>';
                    }
                    $(".c_top_right_ele").append(_html);*/
                    //通讯信息栏
                    _html = '<li class="li-1x">办公电话：'+user.officePhone+'</li>';
                    _html += '<li class="li-1x">手 机 号：'+user.mobilePhone+'</li>';
                    _html += '<li class="li-1x">传 真 号：'+user.faxNumber+'</li>';
                    _html += '<li class="li-1x">邮箱地址：'+user.emailAddress+'</li>';
                    _html += '<li class="li-2x">通讯地址：'+user.postalAddress+'</li>';
                    _html += '<li class="li-2x">紧急联系人一：'+user.nameOne+'（'+user.relationshipOne+'） - '+user.emergencyContactOne+'</li>';
                    _html += '<li class="li-2x">紧急联系人二：'+user.nameTwo+'（'+user.emergencyContactTwo+'） - '+user.emergencyContactTwo+'</li>';
                    $("#communication").html(_html);
                }
            }, true);
        }
        //加载社会关系
        function loadRelations(){
            jo.postAjax("pms/relation/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt"></div>';
                        _html += '<div class="unit_right_txt">姓名：'+jo.getDefVal(item.name, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;关系：'+jo.getDefVal(item.relation, '-')
                                +'&nbsp;&nbsp;&nbsp;&nbsp;性别：'+jo.getDefVal(item.sex, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;出生年月：'+jo.getDefVal(item.birthday, '-')
                                +'&nbsp;&nbsp;&nbsp;&nbsp;联系电话：'+jo.getDefVal(item.tel, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;工作单位：'+jo.getDefVal(item.unit, '-')
                                +'&nbsp;&nbsp;&nbsp;&nbsp;关系类型：'+jo.getDefVal(item.stype, '-')+'<hr style="margin: 5px 0px;"/></div>';
                    }
                    $("#relations").append(_html);
                }
            }, true);
        }
        //加载教育经历
        function loadEducation(){
            jo.postAjax("pms/education/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.startTime+' ~ '+item.stopTime+'</div>';
                        _html += '<div class="unit_right_txt">院校：'+jo.getDefVal(item.universityName, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;专业：'+jo.getDefVal(item.professionalName, '-')
                                +'&nbsp;&nbsp;&nbsp;&nbsp;学历：'+jo.getDefVal(item.education, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;学位：'+jo.getDefVal(item.degree, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;培养方式：'+jo.getDefVal(item.cultureMode, '-')+' </div>';
                    }
                    $("#education").append(_html);
                }
            }, true);
        }
        //加载工作经历
        function loadWork(){
            jo.postAjax("pms/work/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.startTime+' ~ '+item.stopTime+'</div>';
                        _html += '<div class="unit_right_txt">工作单位：'+jo.getDefVal(item.workCompany, '-')+'&nbsp;&nbsp;&nbsp;&nbsp;工作部门：'+jo.getDefVal(item.workDept, '-')
                                +'&nbsp;&nbsp;&nbsp;&nbsp;职务职称：'+jo.getDefVal(item.post, '-')+' </div>';
                    }
                    $("#work").append(_html);
                }
            }, true);
        }
        //加载论文情况
        function loadPaper(){
            jo.postAjax("pms/paper/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+jo.getDefVal(item.years, '-')+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">论文题目：《'+item.title+'》</li>' +
                                '<li class="li-2x">期刊名称：《'+item.periodicalName+'》</li>' +
                                '<li class="li-1x">卷期：'+item.volume+'</li>' +
                                '<li class="li-1x">页：'+item.page+'</li>' +
                                '<li class="li-1x">期刊类型：'+item.periodicalType+'</li>' +
                                '<li class="li-1x">排名：'+item.ranking+'</li>' +
                                '<li class="li-1x">影响因子：'+item.influenceFactor+'</li>' +
                                '<li class="li-1x">他引次数：'+item.hisCitation+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#paper").append(_html);
                }
            }, true);
        }
        //加载著作
        function loadPublish(){
            jo.postAjax("pms/publish/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+jo.getDefVal(item.years, '-')+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">书名：《'+item.bookName+'》</li>' +
                                '<li class="li-1x">出版社：'+item.press+'</li>' +
                                '<li class="li-1x">著作类型：'+item.workType+'</li>' +
                                '<li class="li-1x">排名：'+item.ranking+'</li>' +
                                '<li class="li-1x">撰写章节：'+item.writeChapter+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#publish").append(_html);
                }
            }, true);
        }
        //加载专利
        function loadPatent(){
            jo.postAjax("pms/patent/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+jo.getDefVal(item.years, '-')+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">专利名称：'+item.patentName+'</li>' +
                                '<li class="li-1x">专利号：'+item.patentNumber+'</li>' +
                                '<li class="li-1x">专利类型：'+item.patentType+'</li>' +
                                '<li class="li-1x">排名：'+item.ranking+'</li>' +
                                '<li class="li-1x">是否转让：'+item.isAttorn+'</li>' +
                                '<li class="li-1x">转让金额：'+item.attornMoney+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#patent").append(_html);
                }
            }, true);
        }
        //加载项目经历
        function loadProject(){
            jo.postAjax("pms/joinProject/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.startTime+' ~ '+item.stopTime+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">项目名称：'+item.projectName+'</li>' +
                                '<li class="li-1x">课题/专项类别：'+item.projectType+'</li>' +
                                '<li class="li-1x">担任角色：'+item.role+'</li>' +
                                '<li class="li-1x">经费：'+item.funds+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#project").append(_html);
                }
            }, true);
        }
        //加载技术支撑
        function loadBrace(){
            jo.postAjax("pms/technologyBrace/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.release+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">成果名称：'+item.achievementsName+'</li>' +
                                '<li class="li-1x">发布/采纳部门：'+item.releaseDept+'</li>' +
                                '<li class="li-1x">发布/采纳名称：'+item.releaseName+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#brace").append(_html);
                }
            }, true);
        }
        //加载科技奖情况
        function loadTechAwards(){
            jo.postAjax("pms/pmsTechAwards/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.years+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">项目名称：'+item.awardWinProjectName+'</li>' +
                                '<li class="li-1x">获奖等级：'+item.awardWinProjectLevel+'</li>' +
                                '<li class="li-1x">排名：'+item.ranking+'</li>' +
                                '<li class="li-1x">奖励层次：'+item.awardLevel+'</li>' +
                                '<li class="li-1x">奖励类别：'+item.awardType+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#techAwards").append(_html);
                }
            }, true);
        }
        //加载技术团队任职信息
        function loadMainGroup(){
            jo.postAjax("pms/pmsMainTechGroup/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.startTime+' ~ '+item.stopTime+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">团队/机构名称：'+item.groupName+'</li>' +
                                '<li class="li-1x">职务：'+item.post+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#mainGroup").append(_html);
                }
            }, true);
        }
        //加载人才计划
        function loadSupport(){
            jo.postAjax("pms/pmsSupportProject/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.years+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">计划名称：'+item.planProjectName+'</li>' +
                                '<li class="li-1x">人才层次：'+item.personnelLevel+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#support").append(_html);
                }
            }, true);
        }
        //加载荣誉称号
        function loadHonor(){
            jo.postAjax("pms/pmsHonorTitle/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.years+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-2x">荣誉称号：'+item.honorName+'</li>' +
                                '<li class="li-1x">颁发单位：'+item.awardDept+'</li>' +
                                '<li class="li-1x">称号级别：'+item.titleLevel+'</li>' +
                                //'<li class="li-1x">序号：'+item.serialNumber+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';

                    }
                    $("#honor").append(_html);
                }
            }, true);
        }
        //加载年度考核
        function loadYearCheck(){
            jo.postAjax("pms/pmsYearCheck/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+item.years+'</div>';
                        _html += '<div class="unit_right_txt">';
                        _html += '<ul class="unit_ul">' +
                                '<li class="li-1x">考核年度：'+item.years+'</li>' +
                                '<li class="li-1x">年度考核等级：'+jo.getDefVal(item.checkScore, '-')+'</li>' +
                                '<li class="li-1x">第一季度等级：'+jo.getDefVal(item.quarterOne, '-')+'</li>' +
                                '<li class="li-1x">第二季度等级：'+jo.getDefVal(item.quarterTwo, '-')+'</li>' +
                                '<li class="li-1x">第三季度等级：'+jo.getDefVal(item.quarterThree, '-')+'</li>' +
                                '<li class="li-1x">第四季度等级：'+jo.getDefVal(item.quarterFour, '-')+'</li>' +
                                '</ul>' +
                                '<hr style="margin: 5px 0px;"/>';
                        _html += '</div>';
                    }
                    $("#yearCheck").append(_html);
                }
            }, true);
        }
        //加载领导评价
        function loadLeader(){
            jo.postAjax("pms/pmsLeaderEvaluation/getList", {"userId":userId}, function(json){
                if(json && json.code == 0 && json.data.length > 0){
                    var _html = '';
                    for(var i =0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<div class="unit_left_txt">'+jo.getDefVal(item.years, '')+'</div>';
                        _html += '<div class="unit_right_txt">领导姓名：'+item.leaderId+'' +
                                '<p>评价：'+item.leaderEvaluation+'</p>' +
                                '<hr style="margin: 5px 0px;"/>' +
                                '</div>';
                    }
                    $("#leader").append(_html);
                }
            }, true);
        }
        //导出word简历
        function exportWord(){
            downloadResume(userId);
        }
    </script>
    <style>

    </style>
</head>
<body style="background-color: #dddddd;">
<div class="content-bar" id="resume">
    <!--简历顶部设计-->
    <div class="c_top">
        <div class="c_top_header"><img id="header_img" onerror="this.src='<%=URL_STATIC%>static/images/def_head.jpg'" width="100%" height="100%"/></div>
        <div class="c_top_right">
            <div class="c_top_right_name"></div>
            <div class="c_top_right_info"><%--一句话描述自己!--%></div>
            <div class="c_top_right_ele">
                <%--<span class="ele_item">1994-05-14</span>
                <span class="ele_item">北京</span>
                <span class="ele_item">18235146426</span>
                <span class="ele_item">243144837@sina.cn</span>--%>
            </div>
            <button isShow="" type="button" class="btn btn-sm btn-outline btn-primary" onclick="exportWord()">
                <i class="fa fa-cloud-download" aria-hidden="true"></i>&nbsp;导出简历
            </button>
        </div>
        <div class="clear"></div>
    </div>
    <!--分割线-->
    <div class="line-big"></div>
    <!--简历内容设计-->
    <div class="c_core">
        <div class="c_unit">
            <div class="unit_left unit_title">
                基本信息
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-file-text-o" aria-hidden="true"></i></div>
                <ul class="unit_ul" id="baseInfo">
                    <li class="li-1x">姓名：<span class="txt_space" name="userName"></span></li>
                    <li class="li-1x">曾用名：<span class="txt_space" name="oldName"></span></li>
                    <li class="li-1x">性别：<span class="txt_space" name="sex"></span></li>
                    <li class="li-1x">出生年月：<span class="txt_space" name="birth"></span></li>
                    <li class="li-1x">民族：<span class="txt_space" name="nation"></span></li>
                    <li class="li-1x">身份证号：<span class="txt_space" name="idCard"></span></li>
                    <li class="li-1x">籍贯：<span class="txt_space" name="placeOfOrigin"></span></li>
                    <li class="li-1x">出生地：<span class="txt_space" name="placeOfBirth"></span></li>
                    <li class="li-1x">参加工作时间：<span class="txt_space" name="workStartTime"></span></li>
                    <li class="li-1x">政治面貌：<span class="txt_space" name="politicalOutlook"></span></li>
                    <li class="li-1x">入党时间：<span class="txt_space" name="joinPartyTime"></span></li>
                    <li class="li-1x">专业技术职务：<span class="txt_space" name="technicalPosition"></span></li>
                    <li class="li-1x">取得时间：<span class="txt_space" name="getTime"></span></li>
                    <li class="li-1x">专业技术等级：<span class="txt_space" name="technicalLevel"></span></li>
                    <li class="li-1x">聘任时间：<span class="txt_space" name="appointmentTime"></span></li>
                    <li class="li-1x">行政职务：<span class="txt_space" name="administrativeDuty"></span></li>
                    <li class="li-1x">任职时间：<span class="txt_space" name="tenureTime"></span></li>
                    <li class="li-1x">行政级别：<span class="txt_space" name="administrativeLevel"></span></li>
                    <li class="li-1x">岗位：<span class="txt_space" name="station"></span></li>
                    <li class="li-1x">承担的工作：<span class="txt_space" name="takeWork"></span></li>
                    <li class="li-1x">研究领域：<span class="txt_space" name="researchField"></span></li>
                    <li class="li-1x">研究领域细分：<span class="txt_space" name="researchFieldDetail"></span></li>
                    <li class="li-1x">从事专业：<span class="txt_space" name="specialty"></span></li>
                    <li class="li-1x">外语水平：<span class="txt_space" name="englishLevel"></span></li>
                    <%--<li class="li-1x">最高学历：<span class="txt_space" name="highestEducation"></span></li>
                    <li class="li-1x">最高学位：<span class="txt_space" name="highestDegree"></span></li>--%>
                    <li class="li-1x">第一学历：<span class="txt_space" name="firstEducation"></span></li>
                    <li class="li-1x">第一学位：<span class="txt_space" name="firstDegree"></span></li>
                    <li class="li-1x">在职学历：<span class="txt_space" name="jobEducation"></span></li>
                    <li class="li-1x">在职学位：<span class="txt_space" name="jobDegree"></span></li>
                    <li class="li-1x">国外一年以上留学经历：<span class="txt_space" name="overseasStudyExperience"></span></li>
                    <li class="li-1x">备注：<span class="txt_space" name="remark"></span></li>
                </ul>
            </div>
        </div>
        <!--信息模块单元-->
        <div class="c_unit">
            <div class="unit_left unit_title">
                通讯信息
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-address-book" aria-hidden="true"></i></div>
                <ul class="unit_ul" id="communication">
                   <%-- <li>办公电话：1111</li>
                    <li>手机号：111</li>
                    <li>传真好：222</li>
                    <li>通讯地址：222</li>
                    <li>邮箱地址：121</li>
                    <li>紧急联系人一：李四</li>
                    <li>紧急联系人二：张三</li>--%>
                </ul>
            </div>
        </div>
        <div class="c_unit" id="relations">
            <div class="unit_left unit_title">
                家庭/社会关系
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-retweet" aria-hidden="true"></i></div>
            </div>
            <%--<div class="unit_left_txt">
                2012-09~2016-07
            </div>
            <div class="unit_right_txt">
                中北大学 软件工程 本科 学士学位 全日制
            </div>--%>
        </div>
        <div class="c_unit" id="education">
            <div class="unit_left unit_title">
                教育经历
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-graduation-cap" aria-hidden="true"></i></div>
            </div>
            <%--<div class="unit_left_txt">
                2012-09~2016-07
            </div>
            <div class="unit_right_txt">
                中北大学 软件工程 本科 学士学位 全日制
            </div>--%>
        </div>
        <div class="c_unit" id="work">
            <div class="unit_left unit_title">
                工作经历
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-briefcase" aria-hidden="true"></i></div>
            </div>
           <%-- <div class="unit_left_txt">
                2012-09~2016-07
            </div>
            <div class="unit_right_txt">
                工作单位 工作部门 职务职称
            </div>--%>
        </div>
        <div class="c_unit" id="mainGroup">
            <div class="unit_left unit_title">
                社团兼职
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-object-group" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="honor">
            <div class="unit_left unit_title">
                荣誉称号
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-star" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="techAwards">
            <div class="unit_left unit_title">
                获奖情况
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-star-half-o" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="paper">
            <div class="unit_left unit_title">
                论文情况
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-file-text" aria-hidden="true"></i></div>
            </div>
            <%--<div class="unit_left_txt">
                2012-09
            </div>
            <div class="unit_right_txt">
                <span>《关于xxx的论文》</span>
                <ul class="unit_ul" id="">
                    <li class="li-1x">办公电话：1111</li>
                    <li class="li-1x">手机号：111</li>
                </ul>
            </div>--%>
        </div>
        <div class="c_unit" id="publish">
            <div class="unit_left unit_title">
                出版著作/译著
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-book" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="patent">
            <div class="unit_left unit_title">
                专利
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-hourglass-end" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="project">
            <div class="unit_left unit_title">
                项目经历
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-bookmark" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="brace">
            <div class="unit_left unit_title">
                技术支撑
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-adjust" aria-hidden="true"></i></div>
            </div>
        </div>


        <div class="c_unit" id="support">
            <div class="unit_left unit_title">
                人才培养计划
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-plane" aria-hidden="true"></i></div>
            </div>
        </div>

        <div class="c_unit" id="yearCheck">
            <div class="unit_left unit_title">
                年度考核
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-check" aria-hidden="true"></i></div>
            </div>
        </div>
        <div class="c_unit" id="leader">
            <div class="unit_left unit_title">
                领导评价
            </div>
            <div class="unit_right">
                <div class="unit_icon"><i class="fa fa-comments" aria-hidden="true"></i></div>
            </div>
        </div>
    </div>
    <!--分割线-->
    <%--<div class="line-big"></div>--%>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
