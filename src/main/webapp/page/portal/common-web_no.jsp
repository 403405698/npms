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
           // sfSet();//在初始化表格之前
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
        // function sfSet() {
        //     console.log("打印表格属性sf："  + sf);
        //     if (jo.isValid(sf)) {
        //         $("#mainList").attr("formUrl",$("#mainList").attr("formUrl") + "?sf=rs");
        //         console.log("打印表格属性："  + $("#mainList").attr("formUrl"));
        //     }
        // }
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
        .icon-msnui-menu-down {
            transform: rotateZ(45deg);
            display: inline-block;
            color: #C7C7CD;
            margin-right: 10px;
            /* margin-top: 4px; */
            font-size: 12px;
        }

        .icon-msnui-menu-down.child {
            margin-left: 10px;
        }

        .icon-msnui-menu-down.childs {
            margin-left: 20px;
        }

        .person-tit .title {
            padding: 0;
        }

        .person-tit {
            padding: 18px;
        }

        button.close {
            background: #fff;
            color: #378CEF;
            border-color: #378CEF;
        }

        button.close:hover {
            border-color: #378CEF;
            color: #378CEF;
        }

        .layui-table a.edit {
            margin: 0;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form  class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">常用网站</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <button id="saveBtn" type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="saveCollect()">保存并锁定</button>

                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add" onclick="joView.add()">新增</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary del" onclick="joView.del()">删除</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary reset" onclick="window.location.reload()"><i class="layui-icon layui-icon-refresh"></i> 刷新</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary close">关闭</button>

                    </div>

                </div>
            </div>
        </form>
        <form id="pageForm" class="layui-form layui-form-box layui-col-md12 person">
            <div class="form-content">
                <i class="layui-icon layui-icon-search" style="position: absolute;top: 35px;left: 40px;"></i>
                <div class="layui-form-item">
                    <label class="layui-form-label">名称</label>
                    <div class="layui-input-inline">
                        <input type="text" id="chinese_name" name="chinese_name" placeholder="" autocomplete="off" class="layui-input list-input">
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline button-inline">
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry" onclick="joView.select()">搜索</button>
                    </div>
                </div>
            </div>
        </form>
        <form class="layui-form layui-form-box layui-col-md12 person">

        <div class="person-list-content">

                        <input type="hidden" id="userId" name="userId" />

                </div>
                <%--汇总end--%>
            </div>

                <table class="layui-table layui-form" id="mainList" dataUrl="pms/website/getPage.action?userId=${loginUser.id}&chinese_name=${chinese_name}"  deleteUrl="pms/website/delete.action" formUrl="page/pms/common-web-add_no.jsp?sf=rs">
                    <col field="chinese_name" title="中文名字" width="10%" align="left"  />
                    <col field="website" title="网址" width="60%" align=""/>
                    <col field="add_time" title="添加时间" width="10%" align=""/>
                    <col field="sort" title="排序" width="10%" align=""/>
                    <col field="id" title="操作" width="10%" align=""  event="click"/>
                </table>
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
                var chinese_name = $("#chinese_name").val();
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
        $(".close").click(function() {
            history.back(-1);
        })
        //textarea end
    });
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>