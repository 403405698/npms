<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>工作经历列表页</title>
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
    <script src="<%=URL_STATIC%>static/newjs/final_jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_grid.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>

    <script type="text/javascript">
        $(function(){
            sfSet();//在初始化表格之前
            joViewInitAboutDoc();//joView初始化处理
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
    </script>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("userId"), loginUser.id);
        var sf = jo.getDefVal(jo.getUrlParam("sf"),"");
        var _edit = jo.getDefVal(jo.getUrlParam("edit"),"");

        $(function(){
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
        function sfSet() {
            console.log("打印表格属性sf："  + sf);
            if (jo.isValid(sf)) {
                $("#mainList").attr("formUrl",$("#mainList").attr("formUrl") + "?sf=rs");
                console.log("打印表格属性："  + $("#mainList").attr("formUrl"));
            }
        }
    </script>
    <script>
        //diff
        var collectData;
        var addCollect = false;
        $(function () {
            $("#userId").val(userId);
            getCollectData();

            if (jo.isValid(sf)) {
                $("#collectDiv").show();
                $("#content").removeAttr("readonly");
                $("#content").removeClass("readonly");
                $('textarea').css("border","");
                $("#saveBtn").show();
            }else {
                $("#content").attr("readonly","readonly");
                $("#content").addClass("readonly");
                $("#saveBtn").hide();
            }
            initCollectVal();
        });
        function getCollectData() {
            var result = jo.postAjax("pms/pmsCollectWork/get",{"id":userId});
            if(result != null && result.data.length > 0 && result.data[0]){
                collectData = result.data[0];
            }else{
                collectData = {};
                $("#collectDiv").hide();
                addCollect = true;
            }
        }
        function initCollectVal(oJson) {
            oJson = collectData;
            if(jo.isValid(oJson["content"])){//值有效才赋值
                $("#content").val(oJson["content"]);
            }
            if (oJson["lockStatus"]=="1") {
                $("#lockStatus").show();
            }
        }
        function saveCollect(sUrl){

            if (addCollect) {
                sUrl = "pms/pmsCollectWork/insert";
            }else {
                sUrl = "pms/pmsCollectWork/update";
            }
            if(jo.isValid(sUrl)){

                var oData = {};
                oData["id"] = $("#userId").val();
                oData["content"] = $("#content").val();
                oData["lockStatus"] = "1";

                jo.postAjax(sUrl,oData, function(result){
                    if(result.code == 0){
                        window.parent.jo.showMsg("操作成功!");
                        window.location.reload();
                    }else{
                        jo.showMsg(result.info)
                    }
                });

            }else{
                jo.showMsg("URL无效!");
            }
        };
        //diff
    </script>
    <style>
        /*分页条start*/
        .page-bar{
            width: 100%;
        }
        .page-bar::after{ /*将分页条拉回文档流*/
            content: '';
            display: block;
            clear: both;
        }
        .page-bar-float{/*分页条悬浮在窗口下方*/
            position: fixed;
            bottom: 0px;
            left: 52px;
            width: 100%;
            padding: 5px 15px 3px 15px;
            background-color: white;
            clear: both;
            border-top: #DDDDDD solid 1px;
        }

        .pagination li {
            display:inline-block;
        }

        .pagination>li>a, .pagination>li>span {
            position: relative;
            float: left;
            padding: 6px 12px;
            margin-left: -1px;
            line-height: 1.42857143;
            color: #337ab7;
            text-decoration: none;
            background-color: #fff;
            border: 1px solid #ddd;
        }

        .layui-form-select {
            height: 28px;
            width:80px;
            display: inline-block;
        }

        .pull-right {
            text-align:right;
        }

        .page-bar {
            margin-left: -30px;
            width: 92%;
        }
        /*分页条样式end*/
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form  class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">信息编辑</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button id="saveBtn" type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="saveCollect()">保存并锁定</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add" onclick="joView.add()">新增</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary del" onclick="joView.del()">删除</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary reset" onclick="window.location.reload()"><i class="layui-icon layui-icon-refresh"></i> 刷新</button>
                    </div>
<%--                    <div class="layui-inline">
                        <i class="layui-icon layui-icon-search"></i>
                        <input type="text" name="title" placeholder="搜索条目编号" autocomplete="off" class="layui-input search-input">
                    </div>--%>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">5  工作经历</span>
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
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/selfEvaluationForm.jsp?id=">
                                        <span class="left opt">16 自我评价</span>
                                        <%--               <span class="txt">完善度</span>
                                                       <span class="baifen">0%</span>--%>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </form>
            <form id="pageForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="form-content">
                <i class="iconfont icon-shaixuan"></i>
                <div class="layui-form-item">
                    <label class="layui-form-label">工作单位</label>
                    <div class="layui-input-inline">
                        <input type="text" name="content" placeholder="" autocomplete="off" class="layui-input list-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline button-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.select()">查询</button>
                    </div>
                </div>
            </div>
        </form>
        <form class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-list-content">
                <div style="width: 100%;margin: 20px auto;text-align: center;">
                    <div style="font-size: 22px;font-weight: bold;color: #666;">工作经历</div>
                    <%--汇总strat--%>
                    <div id="collectDiv" class="">
                        <%--edit-item layui-col-md12 layui-col-xs12--%>
                        <label class="layui-form-label">
                            汇总内容
                            <i id="lockStatus" class="iconfont icon-suoding" hidden="hidden"></i>
                        </label>
                        <div class="layui-input-inline" style="width: calc(100% - 140px);">
                            <input type="hidden" id="userId" name="userId" />
                            <textarea class="layui-textarea" name="content" placeholder="格式：起始时间--结束时间 详细内容。例如：2018.09--2019.06 北京大学。说明：时间之间用两个减号分割，内容与时间之间用空格即可，多条记录请按Enter!" id="content" autoHeight="true" cols="50" style="height:auto;margin-top:10px;border: none;background: #fff;"></textarea>
                        </div>
                    </div>
                    <%--汇总end--%>
                </div>

                <table class="layui-table layui-form" id="mainList" dataUrl="pms/auditPmsWork/getPage.action" deleteUrl="pms/auditPmsWork/delete.action" formUrl="page/pms/workForm.jsp">
                    <col field="content" title="详细内容" width="20%" align="left" event="click"/>
<%--                    <col field="workCompany" title="工作单位" width="20%" align="left" event="click"/>
                    <col field="workDept" title="工作部门" width="15%" align=""/>
                    <col field="post" title="职务职称" width="15%" align=""/>--%>
                    <col field="startTime" title="起始时间" width="15%" align=""/>
                    <col field="stopTime" title="终止时间" width="15%" align=""/>
                    <col field="status" title="状态" width="15%" align=""/>
                    <col field="lockStatus" title="锁定状态" width="10%" align=""/>
                </table>
<%--                <div id="pages">
                    <div class="prompt">共<span>2</span>条记录</div>
                    <button type="button" class="layui-btn layui-btn-primary">尾页</button>
                    <button type="button" class="layui-btn layui-btn-primary">下一页</button>
                    <button type="button" class="layui-btn layui-btn-primary">上一页</button>
                    <button type="button" class="layui-btn layui-btn-primary">首页</button>
                </div>--%>
                <%--分页条--%>
                <div class="page-bar page-bar-float layui-row" gridid="mainList">

                </div>
                <%--/分页条--%>
            </div>
        </form>
    </div>
</div>
    <script>
        $(function() {
            layui.use(['layer', 'form', 'laydate'], function() {
                var form = layui.form;
                var layer = layui.layer;
                var laydate = layui.laydate;

                //全选
                form.on('checkbox(allChoose)', function(data) {
                    var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
                    child.each(function(index, item) {
                        item.checked = data.elem.checked;
                    });
                    form.render('checkbox');
                });
                form.on('select(choicePageSize)', function(data) {
                    var iNum = $(data.elem).val();
                    joView.choicePageSize(iNum);
                });
            });

            //textarea高度自适应
            $.fn.autoHeight = function(){
                function autoHeight(elem){
                    elem.style.height = 'auto';
                    elem.scrollTop = 0; //防抖动
                    elem.style.height = elem.scrollHeight + 'px';
                }
                this.each(function(){
                    autoHeight(this);
                    $(this).on('keyup', function(){
                        autoHeight(this);
                    });
                });
            }
            $('textarea[autoHeight]').autoHeight();
            //textarea end
        });
    </script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>