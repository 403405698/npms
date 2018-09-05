<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>教育经历审核列表页</title>
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
            joView.params["shouldPage"] = "noPageSize";//新增参数
            joViewInitAboutDoc();//joView初始化处理
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
        //重写新增函数,实现在top打开表单
        joView.add = function(sUrl,sWidth,sHeight,sTitle){
            var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
            if(jo.isValid(sUrl)){
                sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
                jo.showWin(sUrl,jo.getDefVal("100%", joView.params["formWidth"]),jo.getDefVal("100%", joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfAdd"]), joView.params["winNameOfAdd"]);
            }
        };

        joView.setGridData = function (oList) {
            console.log("进入自定义接管函数" + oList.length);
            console.log("进入自定义接管函数" + JSON.stringify(oList));
            var _html = '';
            for (var i=0;i<oList.length;i++) {
                var lock_html = '';
                if (oList[i].lockStatus == 1) {
                    lock_html = '<i class="iconfont icon-suoding"></i>';
                } else {
                    lock_html = '';
                }
                var audit_html = '';
                if (oList[i].status == 1) {
                    audit_html = '<i class="iconfont icon-duihao"></i>';
                } else if (oList[i].status == 2) {
                    audit_html = '<i class="iconfont icon-error"></i>';
                } else {
                    audit_html = '<i class="iconfont icon-smenu"></i>';
                }
                //新增排序
                var order_html = '';
                var order_num = 10;
                if (jo.isValid(oList[i].orderNum)) {
                    order_num = oList[i].orderNum;
                }
                order_html = '                            <div class="layui-col-md1 paixu">\n' +
                    '                                <input type="text" name="orderNum" placeholder="排序" autocomplete="off" class="layui-input" value="'+order_num+'" class="layui-input">\n' +
                    '                            </div>\n' +
                    '                            <i class="iconfont icon-jiahao" onclick="addIcon(this)" style="float:left;padding: 10px;"></i>';


                _html += '                    <div class="layui-row">\n' +
                    '                        <div class="layui-col-md1">\n' +
                    '                            <input type="checkbox" name="id" lay-skin="primary" value="'+oList[i].id+'">\n' + lock_html + audit_html +
                    '                        </div>\n' +
                    '                        <div class="layui-col-md2" style="text-align: right;">\n' +
                    '                            <input type="hidden" name="id" value="'+oList[i].id+'">' +
                    '                            <input type="text" name="startTime" placeholder="" autocomplete="off" class="layui-input readonly" readonly="readonly" value="'+oList[i].startTime+'">\n' +
                    '                            -\n' +
                    '                            <input type="text" name="stopTime" placeholder="" autocomplete="off" class="layui-input readonly" readonly="readonly" value="'+oList[i].stopTime+'"></div>\n' +
                    '                        <div class="layui-col-md8" style="text-align: left;padding-left: 10px;"><input type="text" name="content" placeholder="" autocomplete="off" class="layui-input readonly" readonly="readonly" value="'+oList[i].content+'"></div>\n'
                    + order_html +
                    '                    </div>';
            }
            // console.log("打印界面：" + _html);
            $("#myTileGrid").html(_html);

/*            $(".icon-jiahao").click(function() {
                var sUrl = joView.params["formUrl"]
                // console.log("hehehe" + $(this).prev().html());
                sUrl = sUrl + "&num=" + $(this).prev().children(":first").val();
                console.log("URLORDER" + sUrl);
                joView.add(sUrl);
            });*/

        };
        joView.refreshAuditItem = function () {
            joForm.setAuditItem("userId","pms/auditPmsUser/getAuditItem.action","待审核");//刷新条目
        };


        function addIcon(obj) {
            var msUrl = joView.params["formUrl"]
            msUrl = msUrl + "&num=" + $(obj).prev().children(":first").val();
            console.log("URLORDER" + msUrl);
            joView.add(msUrl);
        }
        
        function save() {
            var jsonStr = $("#dataForm").serializeJson();
            console.log(JSON.stringify(jsonStr));
            var sUrl = "pms/auditPmsEducation/rsBatchUpdate.action";
            sUrl = jo.parseUrl(sUrl);//解析url
            $.ajax({
                url: sUrl,
                type: "POST",
                contentType : 'application/json;charset=utf-8', //设置请求头信息
                dataType:"json",
                data: jsonStr,
                success: function(data){
                    if (data.code == 0) {
                        window.parent.jo.showMsg("修改成功!");
                        window.location.reload();
                    }
                },
                complete : function(jqXHR,textStatus){
                    if(jo.isValid(jqXHR.responseText)){//后台传的json字符串
                        var re = '';
                        try{
                            re = JSON.parse(jqXHR.responseText);
                            // console.log("re" + JSON.stringify(re));
                        }catch(err){
                            if(textStatus == "error"){

                            }
                        }
                        if(jo.isValid(re) && re.code == '-101'){//session过期异常代码
                            if(re.redirectTo){
                                top.window.location.href = re.redirectTo;
                            }else{
                                top.window.location.href = jo.getDefVal(URL_UMS, contextPath) + jo.Const.URI_LOGOUT;//登出
                            }
                            //top.window.location.href ="page/jsp/login.jsp";  //跳转页面
                        }else if(jo.isValid(re) && re.code == '-102'){//平台业务异常代码
                            jo.showMsg(jo.getDefVal(re.info,"非法操作!"));
                        }else if(jo.isValid(re) && re.code == '-901'){//平台业务异常代码
                            jo.showMsg(jo.getDefVal(re.info,"*系统异常!"));
                        }else if(jo.isValid(re) && re.code == '-999'){//系统异常代码
                            jo.showMsg("*系统出现异常,请与管理员联系!");
                        }else{

                        }
                    }else{

                    }
                },
                error: function(res){
                    // alert("err:"+res.responseText);
                }
            });
            // var url = "/pms/auditPmsEducation/rsBatchUpdate.action";

            /*            jo.postAjax(url,a, function(result){
                            if(result.code == 0){
                                window.parent.jo.showMsg("修改成功!");
                                window.location.reload();
                            }else{
                                jo.showMsg(result.info);
                            }
                        });*/
        }
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
    <script type="text/javascript" language="JavaScript">
        //将表单序列化成json格式的数据(但不适用于含有控件的表单，例如复选框、多选的select)
        (function($){
            $.fn.serializeJson = function(){
                var jsonData1 = {};
                var serializeArray = this.serializeArray();
                // 先转换成{"id": ["12","14"], "name": ["aaa","bbb"], "pwd":["pwd1","pwd2"]}这种形式
                $(serializeArray).each(function () {
                    if (jsonData1[this.name]) {
                        if ($.isArray(jsonData1[this.name])) {
                            jsonData1[this.name].push(this.value);
                        } else {
                            jsonData1[this.name] = [jsonData1[this.name], this.value];
                        }
                    } else {
                        jsonData1[this.name] = this.value;
                    }
                });
                console.log("jsonData1" + JSON.stringify(jsonData1));
                // 再转成[{"id": "12", "name": "aaa", "pwd":"pwd1"},{"id": "14", "name": "bb", "pwd":"pwd2"}]的形式
                var vCount = 0;
                // 计算json内部的数组最大长度
                for(var item in jsonData1){
                    var tmp = $.isArray(jsonData1[item]) ? jsonData1[item].length : 1;
                    vCount = (tmp > vCount) ? tmp : vCount;
                }

                if(vCount > 1) {
                    var jsonData2 = new Array();
                    for(var i = 0; i < vCount; i++){
                        var jsonObj = {};
                        for(var item in jsonData1) {
                            jsonObj[item] = jsonData1[item][i];
                        }
                        jsonData2.push(jsonObj);
                    }
                    return JSON.stringify(jsonData2);
                }else{
                    return "[" + JSON.stringify(jsonData1) + "]";
                }
            };
        })(jQuery);
    </script>
    <style>
        .layui-row {
            margin: 3px 0;
            position: relative;
        }

        .layui-row .icon-jiahao {
            position: absolute;
            right: 0;
            cursor: pointer;
        }

        .layui-col-md1 {
            padding: 10px 0;
            text-align: left;
        }

        .layui-col-md2 input {
            width: 65px;
            display: inline-block;
        }

        .layui-col-md2 input:first-child {
            text-align: right;
        }

        .layui-col-md8 input {
            width: 95% !important;
        }

        .layui-col-md1.paixu {
            padding: 0;
            width: 50px;
            display: none;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">教育经历审核</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary edit" style="background: #378CEF;border-color: #378CEF;color: #fff;">编辑</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary save" onclick="save()">保存</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add allPass" onclick="joView.auditChangeByUserID(1,'pms/auditPmsEducation/batchUpdate.action')">审核通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary lock allPass" onclick="joView.auditChangeByUserID(2,'pms/auditPmsEducation/batchUpdate.action')">审核不通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add allPass" onclick="joView.changeStateByUserID(1,'pms/auditPmsEducation/lockBatchUpdate.action')">锁定</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary lock allPass" onclick="joView.changeStateByUserID(2,'pms/auditPmsEducation/lockBatchUpdate.action')">解锁</button>
<%--                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add" onclick="joView.add()">新增</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary edit" style="background: #378CEF;border-color: #378CEF;color: #fff;">编辑</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary save" onclick="save()">保存</button>
                        &lt;%&ndash;<button type="button" class="layui-btn layui-btn-radius layui-btn-primary del">删除</button>&ndash;%&gt;
                        &lt;%&ndash;<button type="button" class="layui-btn layui-btn-radius layui-btn-primary review" style="color: rgb(255, 102, 0);background: rgb(255, 255, 255);border-color: rgb(255, 102, 0);">审核</button>&ndash;%&gt;
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary reset" onclick="window.location.reload()"><i class="layui-icon layui-icon-refresh"></i> 刷新</button>--%>
                    </div>
<%--                    <div class="layui-inline">
                        <i class="layui-icon layui-icon-search"></i>
                        <input type="text" name="title" placeholder="搜索条目编号" autocomplete="off" class="layui-input search-input">
                    </div>--%>

                    <div class="layui-inline">
                        <div class="select clear">
                            <span class="left">4  教育经历</span>
                            <i class="layui-icon layui-icon-triangle-d right"></i>
                            <%--<span class="baifen right">0%</span>--%>
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
                <%--新增按钮--%>
<%--                <div class="layui-form right" style="padding-right: 310px;">
                    <div class="layui-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add allPass" onclick="joView.auditChangeByUserID(1,'pms/auditPmsEducation/batchUpdate.action')">审核通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary lock allPass" onclick="joView.auditChangeByUserID(2,'pms/auditPmsEducation/batchUpdate.action')">审核不通过</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add allPass" onclick="joView.changeStateByUserID(1,'pms/auditPmsEducation/lockBatchUpdate.action')">锁定</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary lock allPass" onclick="joView.changeStateByUserID(2,'pms/auditPmsEducation/lockBatchUpdate.action')">解锁</button>
                    </div>
                </div>--%>
                <%--新增按钮结束--%>
            </div>
        </form>
            <form id="pageForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="form-content">
                <i class="iconfont icon-shaixuan"></i>
                <div class="layui-form-item">
                    <label class="layui-form-label">院校名称</label>
                    <div class="layui-input-inline">
                        <input type="text" name="content" placeholder="" autocomplete="off" class="layui-input list-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline button-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.select()">查询</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.add()">新增</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="window.location.reload()"><i class="layui-icon layui-icon-refresh"></i> 刷新</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.del()">删除</button>

                    </div>
                </div>
            </div>
            </form>

            <form id="dataForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-list-content">
                <div style="width: 100%;margin: 20px auto;text-align: center;">
                    <div style="font-size: 22px;font-weight: bold;color: #666;">教育经历</div>
<%--                    <i class="iconfont icon-suoding"></i>
                    <i class="iconfont icon-duihao"></i>
                    <i class="iconfont icon-smenu"></i>--%>
                    <%--data row--%>
                    <div id="myTileGrid">
                        <table class="layui-table layui-form" id="mainList" dataUrl="pms/auditPmsEducation/getPage.action" deleteUrl="pms/auditPmsEducation/delete.action" formUrl="page/pms/auditEducationForm.jsp?sf=rs">
                            <col field="universityName" title="院校名称" width="15%" align="" event="click"/>
                            <col field="professionalName" title="专业名称" width="15%" align=""/>
                            <col field="degree" title="学位" width="15%" align=""/>
                            <col field="education" title="学历" width="15%" align=""/>
                            <col field="startTime" title="起始时间" width="15%" align=""/>
                            <col field="stopTime" title="终止时间" width="15%" align=""/>
                            <col field="status" title="状态" width="15%" align=""/>
                            <col field="lockStatus" title="锁定状态" width="10%" align=""/>
                            <col field="_opt" title="操作" width="18%" align=""/>
                        </table>
                    </div>

                </div>
                <!-- <div id="pages">
                    <div class="prompt">共<span>2</span>条记录</div>
                    <button type="button" class="layui-btn layui-btn-primary">尾页</button>
                    <button type="button" class="layui-btn layui-btn-primary">下一页</button>
                    <button type="button" class="layui-btn layui-btn-primary">上一页</button>
                    <button type="button" class="layui-btn layui-btn-primary">首页</button>
                </div> -->


            </div>
        </form>
    </div>
</div>
    <script>
        $(function() {
/*            $(".icon-jiahao").click(function() {
                var sUrl = joView.params["formUrl"]
                console.log("hehehe" + $(this).prev().html());
                sUrl = sUrl + "&num=" + $(this).prev().children(":first").val();
                console.log("URLORDER" + sUrl);
                joView.add(sUrl);
            });*/


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
                // $(".icon-jiahao").click(function() {
                //     joView.add();
/*                    var url = "page/pms/auditEducationForm.jsp?sf=rs";
                    top.layer.open({ /!*弹出框*!/
                        type: 2,
                        title: '教育经历新增',
                        name : 'WIN_ADD',
                        // maxmin: true,//大小窗口切换
                        shadeClose: true, //点击遮罩关闭层
                        area: ['90%', '90%'],
                        content: url
                    });*/
                // });
                // $(".edit").click(function() {
                //     var url = "";
                //     if ($(this).parents("tr").find("i").hasClass("icon-suoding")) {
                //         url = 'education-experience-edit.html?lock=true';
                //     } else {
                //         url = 'education-experience-edit.html';
                //     }
                //     layer.open({ /*弹出框*/
                //         type: 2,
                //         title: '编辑教育经历',
                //         // maxmin: true,//大小窗口切换
                //         shadeClose: true, //点击遮罩关闭层
                //         area: ['650px', '390px'],
                //         content: url
                //     });
                // })
/*                $(".add").click(function() {
                    layer.open({ /!*弹出框*!/
                        type: 2,
                        title: '新增教育经历',
                        // maxmin: true,//大小窗口切换
                        shadeClose: true, //点击遮罩关闭层
                        area: ['650px', '390px'],
                        content: 'pms/page/auditEducationQuick.jsp'
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