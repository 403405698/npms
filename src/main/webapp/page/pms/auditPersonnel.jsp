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
    <title>按人员审核</title>
    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id",formWidth:"90%",formHeight:"90%",winTitleOfAdd:"新增人员信息",winTitleOfUpdate:"人员信息"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem._opt = '&nbsp;&nbsp;<button type="button" class="btn btn-xs btn-outline btn-primary" onclick="lookUserDoc(\''+oItem.id+'\')"><i class="fa fa-search" aria-hidden="true"></i>&nbsp;查看</button>';
            oItem._opt += '&nbsp;&nbsp;<button type="button" class="btn btn-xs btn-outline btn-warning" onclick="joView.edit(\''+oItem.id+'\')"><i class="fa fa-file-o" aria-hidden="true"></i>&nbsp;审核</button>';
        };
        //重写新增函数,实现在top打开表单
        /*joView.add = function(sUrl,sWidth,sHeight,sTitle){
            var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
            if(jo.isValid(sUrl)){
                sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
                top.jo.showWin(sUrl,jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfAdd"]), joView.params["winNameOfAdd"]);
            }
        };*/
        //重写编辑函数,实现在top打开表单
        joView.edit = function(id,sWidth,sHeight,sTitle){
            if(typeof(joView.clickItem) == "function"){
                joView.clickItem(id,sWidth,sHeight,sTitle);
            }else{
                if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
                    if(typeof(sWidth) == "object"){
                        sWidth = '';
                    }
                    //这个是旧的,2018-08-15，改回去审核可以修改，增加参数sf
                    top.jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+(id) +"&sf=rs&edit=true&"+ joView.params["transferParam"],jo.getDefVal("85%", joView.params["formWidth"]),jo.getDefVal("85%", joView.params["formHeight"]),jo.getDefVal("按人员审核", joView.params["winTitleOfUpdate"]), joView.params["winNameOfUpdate"]);
                    //TODO 改用新的暂且简单固定特殊测试李四
                    // opennew(id);
                    //jo.newWindow(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id);
                }
            }
        };

        //测试新打开弹出层
        function opennew(id) {
            // var url = "page/pms/auditUserDoc.jsp?id=d6ed740de85b437580b3c544a45032b5";
            var url = "page/pms/auditUserDoc.jsp?id=" + id;
            url = jo.parseUrl(url);
            layer.open({ /*弹出框*/
                type: 2,
                title: '按人员审核',
                // maxmin: true,//大小窗口切换
                shadeClose: true, //点击遮罩关闭层
                area: ['100%', '100%'],
                content: url
            });
        }
        //测试新打开弹出层end
        //作废用户
        function trashUser(){
            var ids = jo.getCheckBoxValue("id");
            if(ids){
                jo.confirm("您确定要删除勾选人员信息?", function(idx){
                    jo.postAjax("pms/pmsUser/trashUser", {userId:ids}, function(json){
                        if(json && json.code == 0){
                            jo.showMsg("操作成功");
                            joView.reloadCurrentPage();
                        }
                    }, true);
                    jo.close(idx);
                });
            }else{
                jo.showMsg("请勾选待删除人员信息!");
            }
        }
        function choiceAdministrativeLevel(idInp, nameInp){
            jo.selectList('pms/pmsDictionary/getListByDictionary/ADMINISTRATIVE_LEVEL',jo.getDefVal(idInp, 'administrativeLevel'),jo.getDefVal(nameInp, 'administrativeLevelName'),'dicValue','dicValue', true);
        }
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
                    <input type="text" name="userId" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">姓　　名：&nbsp;</label>
                    <input type="text" name="userName" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">人员类型：&nbsp;</label>
                    <select async="true" name="personType" class="joSelect form-control input-sm" data="" dataurl="pms/pmsDictionary/getListByDictionary/PERSON_TYPE" keyfield="dicValue" valuefield="dicValue" firstitem='{"dicValue":"","dicValue":""}'></select>
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
                    <label class="control-label">所属部门：&nbsp;</label>
                    <div class="input-group">
                        <input type="hidden" id="deptIds" name="deptIds" class="form-control input-sm" value="">
                        <input type="text" id="names" name="names" class="form-control input-sm" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceDept('deptIds','names',true)">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
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
<%--                <button isShow="" type="button" class="btn btn-sm btn-outline btn-primary" onclick="joView.add('page/pms/userAddForm.jsp')">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>--%>
                <%--<button type="button" class="btn btn-sm btn-outline btn-danger" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>--%>
<%--                <button type="button" class="btn btn-sm btn-outline btn-danger" onclick="trashUser()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>--%>
                <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
<%--    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditRecordBaseinfo')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;基本信息
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditRecordCommunication')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;通讯
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsRelations')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;社会关系
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsEducation')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;教育
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsWork')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;工作
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsMainTechGroup')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;社团
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsHonorTitle')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;称号
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsTechAwards')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;获奖
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsPaper')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;论文
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsPublish')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;出版
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsPatent')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;专利
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsJoinProject')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;项目经历
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsTechnologyBrace')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;技术支撑
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsSupportProject')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;资助项目
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsYearCheck')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;年度
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsSelfEvaluation')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;自我
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditPmsLeaderEvaluation')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;领导auditShowUser
    </button>
    <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="oldToAudit('auditShowUser')">
        <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;auditShowUser
    </button>--%>


            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="pms/auditShowUser/getPage.action" deleteUrl="" formUrl="page/pms/auditUserDoc.jsp">
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

<!-- 导入过去的数据start -->
<script>

    function  oldToAudit(sUrl) {
        var url = "pms/" + sUrl + "/oldToAudit";
        jo.postAjax(url,{},function(result){
            if(result.code == 0){
                jo.showMsg("操作成功！");
            }else{
                jo.showMsg(result.info)
            }
        });
    }
</script>
<!-- 导入过去的数据end -->
</body>
</html>
