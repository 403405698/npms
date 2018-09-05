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
    <%--zTree树--%>
    <%@ include file="/common/zTreeHead.jsp"%>
    <%--公共--%>
    <%@ include file="/common/commonHead.jsp"%>
    <title>管辖内人事档案</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id",formWidth:"90%",formHeight:"90%",winTitleOfAdd:"新增人员信息",winTitleOfUpdate:"人员信息"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem._opt = '<button type="button" class="btn btn-xs btn-outline btn-primary" onclick="lookUserDoc(\''+oItem.id+'\')"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;浏览简历</button>';
            //oItem._opt += '&nbsp;&nbsp;<button type="button" class="btn btn-xs btn-outline btn-warning" onclick="joView.edit(\''+oItem.id+'\')"><i class="fa fa-file-o" aria-hidden="true"></i>&nbsp;档案编辑</button>';
        };
        //重写新增函数,实现在top打开表单
        joView.add = function(sUrl,sWidth,sHeight,sTitle){
            var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
            if(jo.isValid(sUrl)){
                sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
                top.jo.showWin(sUrl,jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfAdd"]), joView.params["winNameOfAdd"]);
            }
        };
        //重写编辑函数,实现在top打开表单
        joView.edit = function(id,sWidth,sHeight,sTitle){
            if(typeof(joView.clickItem) == "function"){
                joView.clickItem(id,sWidth,sHeight,sTitle);
            }else{
                if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
                    if(typeof(sWidth) == "object"){
                        sWidth = '';
                    }
                    top.jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfUpdate"]), joView.params["winNameOfUpdate"]);
                    //jo.newWindow(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id);
                }
            }
        };
    </script>
    <style>
        .form-group{
            margin-top: 4px;
        }
        .form-group>input.form-control,.form-group>select.form-control{
            width: 168px;
            max-width: 100%;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label">账　　号：&nbsp;</label>
                    <input type="text" name="id" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">姓　　名：&nbsp;</label>
                    <input type="text" name="userName" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">性　　别：&nbsp;</label>
                    <select async="true" name="sex" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/SEX" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">民　　族：&nbsp;</label>
                    <select async="true" name="nation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/NATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">第一学历：&nbsp;</label>
                    <select async="true" name="firstEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">第一学位：&nbsp;</label>
                    <select async="true" name="firstDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">在职学历：&nbsp;</label>
                    <select async="true" name="jobEducation" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_EDUCATION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">在职学位：&nbsp;</label>
                    <select async="true" name="jobDegree" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/HIGHEST_DEGREE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">职　　称：&nbsp;</label>
                    <select async="true" name="technicalPosition" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/TECHNICAL_POSITION" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                </div>
                <div class="form-group">
                    <label class="control-label">行政职务：&nbsp;</label>
                    <input type="text" name="administrativeDuty" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">行政级别：&nbsp;</label>
                    <div class="input-group">
                        <input type="hidden" id="administrativeLevel" name="administrativeLevel" class="form-control input-sm" value="">
                        <input type="text" id="administrativeLevelName" name="administrativeLevelName" class="form-control input-sm" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceAdministrativeLevel('administrativeLevel','administrativeLevelName',true)">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                    <%--<select async="true" name="administrativeLevel" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
                    --%>
                </div>
                <div class="form-group">
                    <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
                    &nbsp;&nbsp;
                    <button type="button" class="btn btn-default btn-sm" onclick="jo.reset('pageForm')"> <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;置空</button>
                </div>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <%--<button isShow="" type="button" class="btn btn-sm btn-outline btn-primary" onclick="joView.add('page/pms/userAddForm.jsp')">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-danger" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>--%>
                <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="pms/pmsUser/getPageInDept.action" deleteUrl="pms/pmsUser/delete.action" formUrl="page/pms/userDoc.jsp">
                    <col field="userName" title="姓名" width="15%" align="" event="" order="user_Name"/>
                    <col field="sex" title="性别" width="15%" align="" order="sex"/>
                    <col field="deptNames" title="部门" width="20%" align="left"/>
                    <col field="technicalPosition" title="职称" width="15%" align="" order="technical_Level"/>
                    <col field="administrativeDuty" title="行政职务" width="15%" align="" order="administrative_Duty"/>
                    <col field="_opt" title="操作" width="18%" align=""/>
                </table>
            </div>
            <%--/grid--%>

            <%--分页条--%>
            <div class="page-bar" gridId="mainList">

            </div>
            <%--/分页条--%>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
