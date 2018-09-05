<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>信息编辑-家庭关系</title>
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
    <style>
        .layui-form-label {
            width: 90px;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form id="pageForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">信息编辑</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
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
                            <span class="left">7  荣誉称号</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">60%</span>--%>
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

            <div class="form-content">
                <i class="iconfont icon-shaixuan"></i>
                <div class="layui-form-item">
                    <label class="layui-form-label">荣誉称号名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="honorName" placeholder="" autocomplete="off" class="layui-input list-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline button-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.select()">查询</button>
                    </div>
                </div>
            </div>

            <div class="person-list-content">
                <table class="layui-table layui-form" id="mainList" dataUrl="pms/auditPmsHonorTitle/getPage.action" deleteUrl="pms/auditPmsHonorTitle/delete.action" formUrl="page/pms/honorTitleForm.jsp">
                    <col field="honorName" title="荣誉称号名称" width="25%" align="left" event="click"/>
                    <col field="awardDept" title="颁发单位" width="15%" align=""/>
                    <col field="titleLevel" title="称号级别" width="15%" align=""/>
                    <col field="years" title="年月" width="15%" align=""/>
                    <col field="status" title="状态" width="15%" align=""/>
                    <col field="lockStatus" title="锁定状态" width="10%" align=""/>
                    <%--<col field="serialNumber" title="序号" width="15%" align=""/>--%>
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
/*                $(".edit").click(function() {
                    var url = "";
                    if ($(this).parents("tr").find("i").hasClass("icon-suoding")) {
                        url = 'honorary-title-edit.html?lock=true';
                    } else {
                        url = 'honorary-title-edit.html';
                    }
                    layer.open({ /!*弹出框*!/
                        type: 2,
                        title: '编辑荣誉称号',
                        // maxmin: true,//大小窗口切换
                        shadeClose: true, //点击遮罩关闭层
                        area: ['650px', '390px'],
                        content: url
                    });
                })*/
/*                $(".add").click(function() {
                    layer.open({ /!*弹出框*!/
                        type: 2,
                        title: '新增荣誉称号',
                        // maxmin: true,//大小窗口切换
                        shadeClose: true, //点击遮罩关闭层
                        area: ['650px', '390px'],
                        content: 'honorary-title-add.html'
                    });
                })*/
            });
        })
    </script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>