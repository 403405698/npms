<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
    <%--cms相关js--%>
    <script src="<%=URL_STATIC%>static/js/cms/cms.js"></script>
    <title>视图表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键
                "saveAfter" : "toEdit",
                "addUrl" : "cms/view/insertView.action",//新增
                "deleteUrl" : "cms/view/deleteView.action",//删除
                "updateUrl" : "cms/view/updateView.action",//修改
                "formDataUrl" : "cms/view/getViewById.action"	//查询
                ,"formObj" : $("#baseForm")
            };
            joForm.initFormPage(jParams);//初始化
            if(!joForm.isAdd){
                var viewId = joForm.params["PKValue"];
                if(jo.isValid(viewId)){
                    joView.init({grid:$("#buttonList"),PKName:"id",dataUrl:"{URL_CMS}cms/viewButton/getViewButtonByViewId.action?viewId="+viewId,checkStyle:"order"});//初始化按钮列表
                }else{
                    jo.alert("视图编号无效!");
                }
            }
        });
        //新增初始化
        joForm.initFormPageOfAdd = function(){
            var moduleId = jo.getUrlParam("moduleId");
            if(jo.isValid(moduleId)){
                $("#moduleId").val(moduleId);
            }
            jo.iframeLoaded(window.joTabIframe1, function(){
                window.joTabIframe1.setContent();//设置检索栏代码
            });
            jo.iframeLoaded(window.joTabIframe2, function(){
                window.joTabIframe2.setContent();//设置main代码
            });
            jo.iframeLoaded(window.joTabIframe3, function(){
                window.joTabIframe3.setContent();//设置js代码
            });
            jo.iframeLoaded(window.joTabIframe4, function(){
                window.joTabIframe4.setContent();//设置css代码
            });
        };
        //初始化编辑表单后置处理函数
        joForm.initFormValueAfter = function(){
            var info = "创建人：" + joForm.formData.createUser + "&nbsp;&nbsp;&nbsp;&nbsp;单位：" + joForm.formData.companyId
                    + "<br/>创建时间：" + jo.formatTime(joForm.formData.createTime)
                    + "&nbsp;&nbsp;&nbsp;&nbsp;更新时间：" + jo.formatTime(joForm.formData.updateTime);
            $("#createInfo").html(info);
            jo.iframeLoaded(window.joTabIframe1, function(){
                //console.info("search代码为:"+joForm.formData.searchCode);
                window.joTabIframe1.setContent(joForm.formData.searchCode);//设置检索栏代码
            });
            jo.iframeLoaded(window.joTabIframe2, function(){
                window.joTabIframe2.setContent(joForm.formData.mainCode);//设置main代码
            });
            jo.iframeLoaded(window.joTabIframe3, function(){
                window.joTabIframe3.setContent(joForm.formData.jsCode);//设置js代码
            });
            jo.iframeLoaded(window.joTabIframe4, function(){
                window.joTabIframe4.setContent(joForm.formData.cssCode);//设置css代码
            });

        };
        //修改前处理
        joForm.dealDataAtUpdateBefore = function(oData){
            //返回null值表示没有改动,对于没有改动的数据,不做处理,降低请求内容长度
            if(window.joTabIframe1.getContent() != null){
                oData.searchCode = encodeURIComponent(window.joTabIframe1.getContent());
            }
            if(window.joTabIframe2.getContent() != null){
                oData.mainCode = encodeURIComponent(window.joTabIframe2.getContent());
            }
            if(window.joTabIframe3.getContent() != null){
                oData.jsCode = encodeURIComponent(window.joTabIframe3.getContent());
            }
            if(window.joTabIframe4.getContent() != null){
                oData.cssCode = encodeURIComponent(window.joTabIframe4.getContent());
            }
        };
        //新增前处理
        joForm.dealDataAtSaveBefore = function(oData){
            oData.searchCode = encodeURIComponent(window.joTabIframe1.getContent());
            oData.mainCode = encodeURIComponent(window.joTabIframe2.getContent());
            oData.jsCode = encodeURIComponent(window.joTabIframe3.getContent());
            oData.cssCode = encodeURIComponent(window.joTabIframe4.getContent());
        };
        //添加按钮到视图
        function appendButton2View(){
            var viewId = joForm.params["PKValue"];
            if(jo.isValid(viewId)){
                var sUrl = "{URL_CMS}page/cms/appendButton.jsp?viewId="+viewId;
                parent.window.viewForm = window;//将当前window对象设置给父页面,方便添加按钮页面调用
                parent.jo.showWin(sUrl, "800px", "400px", "选择按钮", "APPEND_BUTTON");
            }else{
                jo.alert("视图编号无效!");
            }
        }
        //按钮详情
        joView.clickItem = function(id,sWidth,sHeight,sTitle){
            if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
                if(typeof(sWidth) == "object"){
                    sWidth = '';
                }
                jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],'500px','280px',jo.getDefVal(sTitle,'编辑'), "WIN_EDIT");
            }
        };
    </script>
</head>
<body style="padding: 0px 15px;">
<%--按钮栏--%>
<div class="form-group button-bar">
    <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
        <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.update()">
        <i class="fa fa-save" aria-hidden="true"></i>&nbsp;保存
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.del()">
        <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
    </button>
    <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="appendButton2View()">
        <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;添加按钮
    </button>
</div>
<%--按钮栏--%>
<ul class="joTab">
    <li class="cur" tab="base">基础信息</li>
    <li class="" tab="buttons">按　钮</li>
    <li class="" tab="searchCode">检 索 栏</li>
    <li class="" tab="mainCode">主　体</li>
    <li class="" tab="jsCode"> JS脚本 </li>
    <li class="" tab="cssCode"> C S S </li>
</ul>

<div class="joTabSheet" id="base">
    <form id="baseForm" name="pageForm" action="" method="post">
        <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
            <%--<table class="joForm"  cellpadding="3" cellspacing="0">--%>
            <tr>
                <td width="15%" class="active" align="">编　　号</td>
                <td class="tnt">
                    <input type="text" name="id" class="form-control input-sm readonly-edit" placeholder="视图编号">
                </td>

                <td width="15%" class="active must">视图名称</td>
                <td>
                    <input type="text" name="name" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>
            <tr>
                <td class="active">所属模块</td>
                <td>
                    <select id="moduleId" name="moduleId" class="joSelect form-control input-sm" data="" firstItem='' dataurl="{URL_CMS}cms/module/getModuleList.action" keyfield="id" valuefield="name"></select>
                </td>
                <td class="active must">排　　序</td>
                <td>
                    <input type="text" name="num" value="99" class="form-control input-sm" ErrEmpty>
                </td>
            </tr>
                <tr>
                    <td class="active">备　　注</td>
                    <td colspan="3">
                        <input type="text" name="remark" class="form-control input-sm">
                    </td>
                </tr>

        </table>
        <p id="createInfo" style="color: red;"></p>
    </form>
</div>
<div class="joTabSheet" id="buttons">
    <div class="table-responsive">
        <table class="table table-bordered table-hover table-striped table-condensed" id="buttonList" dataUrl=""
               deleteUrl="" formUrl="page/cms/viewButtonForm.jsp">
            <col field="name" title="按钮名称" width="15%" align="" event="click"/>
            <col field="click" title="事件" width="35%" align=""/>
            <col field="num" title="排序" width="10%" align=""/>
        </table>
    </div>
</div>
<iframe class="joTabSheet" name="joTabIframe1" id="searchCode" style="width:100%;height:300px;border: none;" src="page/cms/codeEdit/searchCodeEdit.jsp">
</iframe>
<iframe class="joTabSheet" name="joTabIframe2" id="mainCode" style="width:100%;height:300px;border: none;" src="page/cms/codeEdit/mainCodeEdit.jsp">
</iframe>
<iframe class="joTabSheet" name="joTabIframe3" id="jsCode" style="width:100%;height:300px;border: none;" src="page/cms/codeEdit/jsCodeEdit.jsp">
</iframe>
<iframe class="joTabSheet" name="joTabIframe4" id="cssCode" style="width:100%;height:300px;border: none;" src="page/cms/codeEdit/cssCodeEdit.jsp">
</iframe>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();
</script>

</body>
</html>
