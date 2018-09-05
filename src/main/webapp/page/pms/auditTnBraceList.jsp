<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>技术支撑审核列表</title>
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
    <script src="<%=URL_STATIC%>static/newjs/final_normal_form.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>

    <script type="text/javascript">
        $(function(){
            joViewInitAboutDoc();//joView初始化处理
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem._opt = '<a href="javascript:;" class="pass" onclick="joView.auditChangeNoConfirm(1,\'pms/auditPmsTechnologyBrace/batchUpdate.action\',\''+oItem.id+'\')">审核通过</a>';
            oItem._opt += '<a href="javascript:;" class="nopass" onclick="joView.auditChangeNoConfirm(2,\'pms/auditPmsTechnologyBrace/batchUpdate.action\',\''+oItem.id+'\')">审核不通过</a>';
            oItem._opt += '<a href="javascript:;" class="no-reviewe" onclick="joView.auditChangeNoConfirm(5,\'pms/auditPmsTechnologyBrace/batchUpdate.action\',\''+oItem.id+'\')">置为未审核</a>';
        };
        joView.refreshAuditItem = function () {
            joForm.setAuditItem("userId","pms/auditPmsUser/getAuditItem.action","待审核");//刷新条目
        };
    </script>
    <script type="text/javascript">
        var userId = jo.getDefVal(jo.getUrlParam("userId"), loginUser.id);
        $(function(){
            goto();
            joView.setUserName();
            joForm.setAuditItem("userId","pms/auditPmsUser/getAuditItem.action","待审核");//刷新条目
        });
        function goto(){
            $("ul a").each(function(){
                $(this).attr("lay-href",$(this).attr("lay-href") + userId);
            });
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
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form id="pageForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear" style="padding: 0 0 18px 0;">
                <span class="left title" style="padding: 0;"></span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joView.auditChange(1,'pms/auditPmsTechnologyBrace/batchUpdate.action')">审核通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joView.auditChange(2,'pms/auditPmsTechnologyBrace/batchUpdate.action')">审核不通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password no-reviewe" onclick="joView.auditChange(5,'pms/auditPmsTechnologyBrace/batchUpdate.action')">置为未审核</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary" style="background: #ff6600;border-color: #ff6600;color: #fff" onclick="joView.changeState(1,'pms/auditPmsTechnologyBrace/lockBatchUpdate.action')">锁定条目</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add pass" onclick="joView.changeState(2,'pms/auditPmsTechnologyBrace/lockBatchUpdate.action')">解锁条目</button>
                    </div>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">13 技术支撑</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">待审核</span>--%>
                        </div>
                        <div class="select-content">
                            <ul id="selectContent">
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditUserDoc.jsp?edit=true&id=">
                                        <span class="left opt">1  基本信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditCommunicationForm.jsp?edit=true&id=">
                                        <span class="left opt">2  通讯信息</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditRelationList.jsp?userId=">
                                        <span class="left opt">3  家庭成员和社会关系</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditEducationList.jsp?userId=">
                                        <span class="left opt">4  教育经历</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditWorkList.jsp?userId=">
                                        <span class="left opt">5  工作经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditMainTechGroupList.jsp?userId=">
                                        <span class="left opt">6  社团兼职</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditHonorTitleList.jsp?userId=">
                                        <span class="left opt">7  荣誉称号</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditTechAwardsList.jsp?userId=">
                                        <span class="left opt">8  获奖情况</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPaperList.jsp?userId=">
                                        <span class="left opt">9  论文情况</span>
                                        <%--<span class="baifen">已审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPublishList.jsp?userId=">
                                        <span class="left opt">10 出版著作</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditPatentList.jsp?userId=">
                                        <span class="left opt">11 专利</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditJoinProjectList.jsp?userId=">
                                        <span class="left opt">12 项目经历</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditTnBraceList.jsp?userId=">
                                        <span class="left opt">13 技术支撑</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditSupportProjectList.jsp?userId=">
                                        <span class="left opt">14 人力培养计划/资助项目</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditYearCheckList.jsp?userId=">
                                        <span class="left opt">15 年度考核</span>
                                        <%--<span class="baifen">待审核</span>--%>
                                    </a>
                                </li>
<%--                                <li>
                                    <a href="javascript:;" lay-href="<%=basePath%>page/pms/auditSelfEvaluationForm.jsp?id=">
                                        <span class="left opt">16 自我评价</span>
                                        &lt;%&ndash;<span class="baifen">待审核</span>&ndash;%&gt;
                                    </a>
                                </li>--%>
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
            <div style="padding-left: 40px;padding-top: 20px;">
                提示：当前正在审核 <span style="color: red;" id="auditWho"></span>
            </div>
            <div class="form-content">
                <i class="iconfont icon-shaixuan"></i>
                <div class="layui-form-item" style="padding-left: 40px;">
                    <div class="layui-input-inline sex-inline">
                        <select name="status" lay-verify="">
                            <option value=""></option>
                            <option value="5">待审核</option>
                            <option value="1">已通过</option>
                            <option value="2">未通过</option>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline button-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.select()">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="window.location.reload()">刷新</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.add()">新增</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.del()">删除</button>
                    </div>
                </div>
            </div>

            <div class="person-list-content">
                <table class="layui-table layui-form" id="mainList" dataUrl="pms/auditPmsTechnologyBrace/getPage.action" deleteUrl="pms/auditPmsTechnologyBrace/delete.action" formUrl="page/pms/auditTnBraceForm.jsp?sf=rs">
                    <col field="achievementsName" title="成果名称" width="25%" align="left" event="click"/>
                    <col field="releaseDept" title="发布/采纳部门" width="15%" align=""/>
                    <col field="releaseName" title="发布/采纳名称" width="15%" align=""/>
                    <col field="release" title="发布/采纳时间" width="15%" align=""/>
                    <col field="status" title="状态" width="15%" align=""/>
                    <col field="lockStatus" title="锁定状态" width="10%" align=""/>
                    <col field="_opt" title="操作" width="18%" align=""/>
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
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>
