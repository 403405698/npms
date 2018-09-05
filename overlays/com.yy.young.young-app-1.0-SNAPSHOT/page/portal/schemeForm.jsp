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
    <title>方案表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                "addUrl" : "portal/scheme/insert.action",//新增
                "deleteUrl" : "portal/scheme/delete.action",//删除
                "updateUrl" : "portal/scheme/update.action",//修改
                "formDataUrl" : "portal/scheme/getScheme.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
            loadSchemeMenu();//加载方案菜单
            loadSchemeUser();//加载方案用户
            loadSchemeCompany();//加载方案单位
            loadSchemeRole();//加载方案角色
        });

        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
            oJson.createTime = jo.formatTime(oJson.createTime);
            oJson.updateTime = jo.formatTime(oJson.updateTime);
        };
        //加载方案菜单
        function loadSchemeMenu(){
            if(joForm.params.PKValue){
                jo.postAjax("{URL_PORTAL}portal/schemeMenu/getMenuListBySchemeId.action", {"schemeId":joForm.params.PKValue}, function(json){
                    if(json && json.code =="0"){
                        if(json.data.length > 0){
                            var nodes = json.data;
                            for(var i=0;i<json.data.length;i++){
                                nodes[i].icon2 = nodes[i].icon;
                                nodes[i].icon = "";//去掉icon因为icon是ztree中的节点图标关键字
                            }
                            var param = {
                                treeId : "schemeMenuTree"
                                ,zNodes : nodes
                                ,item_id : "id"
                                ,item_pid : "parentId"
                                ,item_show : "name"
                            };
                            param.onClickFunc = menuTreeClick;//树节点点击回调
                            param.check = {//需引入cxcheck扩展包
                                enable: true,    //勾选框开关
                                chkStyle: "checkbox",    //默认checkbox(与chkboxType属性关联),也可以写radio(与radioType属性关联)
                                chkboxType: {"Y":"s","N":"s"},    //Y和N固定不变,Y表示勾选,N表示取消勾选;Y和N的值为p或s或ps,p表示会影响父节点,s表示会影响子节点
                                radioType: "all"    //取值为"all"和"level",all表示在所有节点中单选,level表示在同一层级内单选
                            };
                            jo.drawZTree(param);
                        }else{
                            $("#schemeMenuTree").text("该方案暂时没有菜单信息!");
                        }
                    }
                }, true);
            }
        }
        //菜单点击回调
        var curMenu = null;//当前选中的菜单对象
        function menuTreeClick(event,treeId,treeNode){
            if(treeId == 'schemeMenuTree'){
                $("#menuForm").show();
                curMenu = treeNode;
                joForm.initFormValue($("#menuForm"), treeNode);
            }
        }
        //导入菜单
        var navTreeInited = false;
        function appendMenu(type){
            if(type == 2){
                if(!curMenu){
                    jo.showMsg("请选择待导入子菜单的菜单项!");
                    return;
                }
            }
            if(!navTreeInited){
                var sUrl = "{URL_PORTAL}portal/schemeMenu/getCurUserNavigate.action";
                var oDate = {};
                jo.postAjax(sUrl,oDate,function(json){
                    if(json && json.code==0){
                        for(var i=0;i<json.data.length;i++){
                            json.data[i].icon2 = json.data[i].icon;
                            json.data[i].icon = "";//去掉icon因为icon是ztree中的节点图标关键字
                        }
                        var param = {
                            "treeId":"navTree",
                            "zNodes":json.data,
                            "setting":{
                                data: {
                                    simpleData: {
                                        enable: true,
                                        idKey: "id",
                                        pIdKey: "parentId"
                                    },
                                    key: {
                                        name: "name",
                                        title: "name"
                                    }
                                },
                                callback: {
                                    onClick: function(){},
                                },
                                view: {
                                    showLine: false
                                },
                                check: {//需引入cxcheck扩展包
                                    enable: true,    //勾选框开关
                                    chkStyle: "checkbox",    //默认checkbox(与chkboxType属性关联),也可以写radio(与radioType属性关联)
                                    chkboxType: {"Y":"s","N":"s"},    //Y和N固定不变,Y表示勾选,N表示取消勾选;Y和N的值为p或s或ps,p表示会影响父节点,s表示会影响子节点
                                    radioType: "all"    //取值为"all"和"level",all表示在所有节点中单选,level表示在同一层级内单选
                                }
                            }
                        };
                        jo.drawZTree(param);
                    }
                });
                navTreeInited = true;
            }
            jo.showDialog($("#navTree"), "NAV_WIN", true, {
                title : "导入菜单",
                btn : ["确定", "取消"],
                btn1 : function(idx){
                    var ids = jo.getZTreeCheckedNodesIds("navTree");
                    var nodes = jo.getZTreeCheckedNodes("navTree");//获取已选节点
                    if(nodes && nodes.length > 0){
                        var arr = new Array();
                        for(var i=0;i<nodes.length;i++){
                            var item = nodes[i];
                            arr.push({"id":item.id,"name":item.name,"parentId":item.parentId,"navId":item.id,"navHref":item.href,"icon":item.icon2,"num":item.num});
                        }
                        var param = {"menus":jo.obj2JsonStr(arr),"schemeId":joForm.params.PKValue};
                        if(type == 2 && curMenu && curMenu.id){
                            param.menuId = curMenu.id;
                        }
                        jo.postAjax("portal/schemeMenu/batchInsertMenu.action", param, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("添加成功!");
                                loadSchemeMenu();//重新加载菜单
                                jo.close(idx);
                            }else{
                                jo.showMsg("导入菜单失败!");
                            }

                        }, true);
                    }else{
                        jo.showMsg("请选择至少一条数据!");
                    }
                }
            });
        }
        //选择上级菜单
        function choiceParentMenu(idInp, nameInp){
            if(joForm.params.PKValue){
                jo.selectTree('{URL_PORTAL}portal/schemeMenu/getMenuListBySchemeId.action?schemeId='+joForm.params.PKValue,jo.getDefVal(idInp, 'parentId'),jo.getDefVal(nameInp, 'PARENT_NAME'),'id','name', 'parentId',
                '','','','',function(data){
                            for(var i=0;i<data.length;i++){
                                data[i].icon2 = data[i].icon;
                                data[i].icon = "";//去掉icon因为icon是ztree中的节点图标关键字
                            }
                        });
            }
        }
        //保存菜单
        function saveMenu(){
            if(jo.checkForm($("#menuForm"))){
                var obj = jo.form2Json("menuForm");
                if(obj && obj.id){
                    obj.icon = obj.icon2;
                    jo.postAjax("{URL_PORTAL}portal/schemeMenu/update.action", obj, function(json){
                        if(json && json.code == "0"){
                            jo.showMsg("保存成功!");
                            loadSchemeMenu();
                        }else{
                            jo.showMsg("保存失败!");
                        }
                    });
                }
            }


        }
        //删除菜单
        function delMenu(){
            var delIds = jo.getZTreeCheckedNodesIds('schemeMenuTree', 'id');
            if(delIds){
                jo.confirm("确定要删除被选中菜单(共"+delIds.split(",").length+"条)?", function(){
                    jo.postAjax("{URL_PORTAL}portal/schemeMenu/delete.action", {ids:delIds}, function(json){
                        if(json && json.code == "0"){
                            jo.showMsg("删除成功!");
                            loadSchemeMenu();
                            jo.reset("menuForm");
                            $("#menuForm").hide();
                        }else{
                            jo.showMsg("删除失败!");
                        }
                    });
                });
            }
        }
        //新建菜单
        function addMenu(){
            jo.reset("menuForm");
            $("#schemeId").val(joForm.params.PKValue);
            jo.showDialog($("#menuForm"), 'ADD_MENU', true, {area:['550px', '330px'],title:"新建菜单",btn:["确定","取消"],btn1:function(idx){
                if(jo.checkForm($("#menuForm"))){
                    var obj = jo.form2Json("menuForm");
                    if(obj && !obj.id && obj.schemeId){
                        obj.icon = obj.icon2;
                        jo.postAjax("{URL_PORTAL}portal/schemeMenu/insert.action", obj, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("新建成功!");
                                loadSchemeMenu();
                            }else{
                                jo.showMsg("新建失败!");
                            }
                            jo.close(idx);
                        });
                    }else{
                        jo.showMsg("操作异常!");
                    }
                }
            }});
        }
    </script>
    <style>
        .title-tr{background-color: #F3F3F4;}
    </style>
</head>
<body class="padding-15">
<%--胶囊选项卡--%>
<ul class="nav nav-tabs">
    <li class="active"><a class="cursor-hand" data-target="#scheme" data-toggle="tab">方案信息</a></li>
    <li><a class="cursor-hand" data-target="#schemeMenu" data-toggle="tab">方案菜单</a></li>
    <li><a class="cursor-hand" data-target="#schemeCompany" data-toggle="tab">方案单位</a></li>
    <li><a class="cursor-hand" data-target="#schemeRole" data-toggle="tab">方案角色</a></li>
    <li><a class="cursor-hand" data-target="#schemeUser" data-toggle="tab">方案用户</a></li>
</ul>
<%--选项卡内容--%>
<div class="tab-content">
    <div class="tab-pane fade in active" id="scheme">
        <%--按钮栏--%>
        <div class="form-group button-bar">
            <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
                <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;新增
            </button>
            <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.update()">
                <i class="fa fa-pencil-square" aria-hidden="true"></i>&nbsp;修改
            </button>
            <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.del()">
                <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
            </button>
        </div>
        <%--/按钮栏--%>
        <form id="pageForm" name="pageForm" action="" method="post">
            <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                <tr>
                    <td width="15%" class="active must" align="">方案编号</td>
                    <td class="tnt">
                        <input type="text"  name="id" class="form-control input-sm readonly-edit" ErrEmpty/>
                    </td>
                </tr>
                <tr>
                    <td width="15%" class="active must" align="">方案名称</td>
                    <td class="tnt">
                        <input type="text"  name="name" class="form-control input-sm" ErrEmpty/>
                    </td>
                </tr>
                <tr>
                    <td class="active" align="">首页地址</td>
                    <td class="tnt">
                        <input type="text"  name="indexUrl" class="form-control input-sm"/>
                    </td>
                </tr>
                <tr>
                    <td class="active" align="">备　　注</td>
                    <td class="tnt">
                        <input type="text"  name="remark" class="form-control input-sm"/>
                    </td>
                </tr>
                <tr>
                    <td class="active" align="">显示顺序</td>
                    <td class="tnt">
                        <input type="text"  name="num" class="form-control input-sm" value="99"/>
                    </td>

                </tr>
                <tr>
                    <td class="active" align="">创建时间</td>
                    <td class="tnt">
                        <input type="text" name="createTime" class="form-control input-sm" readonly/>
                    </td>
                </tr>
                <tr>
                    <td class="active" align="">更新时间</td>
                    <td class="tnt">
                        <input type="text" name="updateTime" class="form-control input-sm" readonly/>
                    </td>
                </tr>
            </table>
        </form>
    </div>
    <%--方案菜单--%>
    <div class="tab-pane fade" id="schemeMenu">

        <div class="container-fluid" style="padding: 0px;">
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-group button-bar">
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="appendMenu()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;导入菜单
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="appendMenu(2)">
                            <i class="fa fa-link" aria-hidden="true"></i>&nbsp;导入子菜单
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="saveMenu()">
                            <i class="fa fa-floppy-o" aria-hidden="true"></i>&nbsp;保存修改
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="addMenu()">
                            <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新建菜单
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="delMenu()">
                            <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3" style="overflow: auto;">
                    <%--方案菜单树--%>
                    <div id="schemeMenuTree" class="ztree">

                    </div>
                </div>
                <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
                    <form id="menuForm" name="menuForm" action="" method="post" style="display: none;padding: 5px;box-sizing: border-box;">
                        <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                            <tr>
                                <td width="25%" class="active must" align="">菜单名称</td>
                                <td class="tnt">
                                    <input type="hidden"  name="id" class="form-control input-sm" />
                                    <input type="text"  name="name" class="form-control input-sm" ErrEmpty/>
                                </td>
                            </tr>
                            <tr>
                                <td class="active" align="">上级编号</td>
                                <td class="tnt">
                                    <div class="input-group">
                                        <input type="text" id="parentId" name="parentId" class="form-control input-sm"/>
                                        <%--<input type="text" id="PARENT_NAME" name="PARENT_NAME" class="form-control input-sm"/>--%>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default btn-sm" type="button" onclick="choiceParentMenu('parentId', '')">
                                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                                            </button>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="active" align="">菜单链接</td>
                                <td class="tnt">
                                    <input type="text"  name="navHref" class="form-control input-sm" />
                                </td>
                            </tr>
                            <tr>
                                <td class="active" align="">图　　标</td>
                                <td class="tnt">
                                    <div class="input-group">
                                        <input type="text" id="icon2" name="icon2" class="form-control input-sm"/>
                                        <span class="input-group-btn">
                                            <button class="btn btn-default btn-sm" type="button" onclick="choiceIcon('icon2')">
                                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                                            </button>
                                        </span>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="active" align="">显示顺序</td>
                                <td class="tnt">
                                    <input type="text"  name="num" class="form-control input-sm" value="99"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="active must" align="">方案编号</td>
                                <td class="tnt">
                                    <input type="text" id="schemeId"  name="schemeId" readonly class="form-control input-sm" ErrEmpty/>
                                </td>
                            </tr>
                            <tr>
                                <td class="active" align="">关联资源</td>
                                <td class="tnt">
                                    <input type="text"  name="navId" readonly class="form-control input-sm" />
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <%--方案单位--%>
    <div class="tab-pane fade" id="schemeCompany">

        <script type="text/javascript" charset="utf-8">
            //加载方案单位
            var companyGrid = null;
            function loadSchemeCompany(){
                if(joForm.params.PKValue){
                    if(companyGrid == null){//初始化grid
                        companyGrid = new Grid($("#schemeCompanyList"));
                    }
                    companyGrid.loadData("{URL_PORTAL}portal/schemeCompany/getSchemeCompanyList.action?schemeId="+joForm.params.PKValue);
                }
            }
            //删除方案单位
            function delSchemeCompany(){
                var ids = jo.getCheckBoxValue('id2');
                if(ids){
                    jo.confirm("确定要删除被选中关联单位(共"+ids.split(",").length+"条)?", function(){
                        jo.postAjax("{URL_PORTAL}portal/schemeCompany/delete.action", {ids:ids}, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("删除成功!");
                                loadSchemeCompany();
                            }else{
                                jo.showMsg("删除失败!");
                            }
                        });
                    });

                }
            }
            //打开选择页面
            function openChoiceCompany(){
                if(joForm.params.PKValue){
                    var tidx = jo.selectTree('{URL_UMS}ums/tree/getCompanyTree.action', 'SchemeCompanyIds', '','ID','NAME', 'PARENT_ID', true, function(type){
                        if(type){
                            var cids = jo.getLayerIframe(tidx).joList.getSelectedVal("ID");
                            if(cids){
                                jo.postAjax("{URL_PORTAL}portal/schemeCompany/batchInsertSchemeCompany.action", {"schemeId":joForm.params.PKValue, "companyIds":cids}, function(json){
                                    if(json && json.code == 0){
                                        jo.showMsg("关联成功!");
                                        loadSchemeCompany();
                                        jo.close(tidx);
                                    }
                                });
                            }
                        }else{
                            jo.close(tidx);
                        }
                    });
                }
            }
            //处理单位ID,用于单位选择时的回显
            function handleCompanyId(companyId){
                $("#SchemeCompanyIds").val($("#SchemeCompanyIds").val() ? ($("#SchemeCompanyIds").val()+","+companyId) : companyId);
                return "<a class='cursor-hand' onclick='lookCompanyInfo(\""+companyId+"\")'>" + companyId + "</a>";
            }
            function lookCompanyInfo(companyId){
                jo.showWin('{URL_UMS}page/ums/lookCompanyInfo.jsp?ID='+companyId, '80%', '330px', '查看单位信息');
            }
        </script>
        <div class="container-fluid" style="padding: 0px;">
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="form-group button-bar">
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="openChoiceCompany()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;关联单位
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="delSchemeCompany()">
                            <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="table-responsive">
                        <input type="hidden" id="SchemeCompanyIds"/>
                        <table class="table table-hover table-condensed table-bordered" id="schemeCompanyList" titleCss="title-tr">
                            <col field="<input type='checkbox' name='id2' value='{id}'/>" title="<input type='checkbox' onclick='jo.checkAll(&quot;id2&quot;,this)'/>" width="5%" align=""/>
                            <col field="[=handleCompanyId('{companyId}')]" title="单位编号" width="30%" align=""/>
                            <col field="companyName" title="单位名称" width="30%" align=""/>
                            <col field="[=jo.formatTime('{createTime}')]" title="关联时间" width="30%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%--方案角色--%>
    <div class="tab-pane fade" id="schemeRole">

        <script type="text/javascript" charset="utf-8">
            //加载方案角色
            var roleGrid = null;
            function loadSchemeRole(){
                if(joForm.params.PKValue){
                    if(roleGrid == null){//初始化grid
                        roleGrid = new Grid($("#schemeRoleList"));
                    }
                    roleGrid.loadData("{URL_PORTAL}portal/schemeRole/getSchemeRoleList.action?schemeId="+joForm.params.PKValue);
                }
            }
            //删除方案角色
            function delSchemeRole(){
                var ids = jo.getCheckBoxValue('id3');
                if(ids){
                    jo.confirm("确定要删除被选中关联角色(共"+ids.split(",").length+"条)?", function(){
                        jo.postAjax("{URL_PORTAL}portal/schemeRole/delete.action", {ids:ids}, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("删除成功!");
                                loadSchemeRole();
                            }else{
                                jo.showMsg("删除失败!");
                            }
                        });
                    });
                }
            }
            var roleLoaded = false;
            //打开角色选择页面
            function openChoiceRole(){
                if(joForm.params.PKValue){
                    if(!roleLoaded){
                        createRoleTree("RoleDialog", null, true);
                        roleLoaded = true;
                    }
                    jo.showDialog($("#RoleDialog"), "choiceRole", true, {btn:"确定", yes:function(){
                        var roles = jo.getZTreeCheckedNodesIds("RoleDialog");
                        if(jo.isValid(roles)){
                            jo.postAjax("{URL_PORTAL}portal/schemeRole/batchInsertSchemeRole.action",{schemeId:joForm.params.PKValue,roleIds:roles},function(json){
                                if(json && json.code == 0){
                                    jo.showMsg("关联成功!");
                                    loadSchemeRole();
                                }else{
                                    jo.showMsg(jo.getDefVal(json.info, "操作失败!"));
                                }
                            });
                        }
                        jo.close("choiceRole");
                    }});
                }
            }
            function lookRoleInfo(id){
                jo.showWin('{URL_UMS}page/ums/lookRoleInfo.jsp?ID='+id, '540px', '330px', '查看角色信息');
            }
        </script>
        <div class="container-fluid" style="padding: 0px;">
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div id="RoleDialog" class="ztree" style="display: none;">

                    </div>
                    <div class="form-group button-bar">
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="openChoiceRole()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;关联角色
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="delSchemeRole()">
                            <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="table-responsive">
                        <table class="table table-hover table-condensed table-bordered" id="schemeRoleList" titleCss="title-tr">
                            <col field="<input type='checkbox' name='id3' value='{id}'/>" title="<input type='checkbox' onclick='jo.checkAll(&quot;id3&quot;,this)'/>" width="5%" align=""/>
                            <col field="<a class='cursor-hand' onclick=&quot;lookRoleInfo('{roleId}')&quot;>{roleId}</a>" title="角色编号" width="30%" align=""/>
                            <col field="roleName" title="角色名称" width="30%" align=""/>
                            <col field="[=jo.formatTime('{createTime}')]" title="创建时间" width="30%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <%--方案用户--%>
    <div class="tab-pane fade" id="schemeUser">

        <script type="text/javascript" charset="utf-8">
            //加载方案用户
            var userGrid = null;
            function loadSchemeUser(){
                if(joForm.params.PKValue){
                    if(userGrid == null){//初始化grid
                        userGrid = new Grid($("#schemeUserList"));
                    }
                    userGrid.loadData("{URL_PORTAL}portal/schemeUser/getSchemeUserList.action?schemeId="+joForm.params.PKValue);
                }
            }
            //删除方案用户
            function delSchemeUser(){
                var ids = jo.getCheckBoxValue('id');
                if(ids){
                    jo.confirm("确定要删除被选中关联用户(共"+ids.split(",").length+"条)?", function(){
                        jo.postAjax("{URL_PORTAL}portal/schemeUser/delete.action", {ids:ids}, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("删除成功!");
                                loadSchemeUser();
                            }else{
                                jo.showMsg("删除失败!");
                            }
                        });
                    });
                }
            }
            //打开用户选择页面
            function openChoiceUser(){
                if(joForm.params.PKValue){
                    jo.showWin('page/portal/choiceUser.jsp?schemeId='+joForm.params.PKValue, '99%', '99%', '关联用户');
                }
            }
            function lookUserInfo(userId){
                jo.showWin('{URL_UMS}page/ums/lookUserInfo.jsp?ID='+userId, '80%', '340px', '查看用户信息');
            }
        </script>
        <div class="container-fluid" style="padding: 0px;">
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="form-group button-bar">
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="openChoiceUser()">
                            <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;关联用户
                        </button>
                        <button type="button" isShow="!joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="delSchemeUser()">
                            <i class="fa fa-trash" aria-hidden="true"></i>&nbsp;删除
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="table-responsive">
                        <table class="table table-hover table-condensed table-bordered" id="schemeUserList" titleCss="title-tr">
                            <col field="<input type='checkbox' name='id' value='{id}'/>" title="<input type='checkbox' onclick='jo.checkAll(&quot;id&quot;,this)'/>" width="5%" align=""/>
                            <col field="<a class='cursor-hand' onclick=&quot;lookUserInfo('{userId}')&quot;>{userId}</a>" title="用户" width="40%" align=""/>
                            <col field="userName" title="用户名称" width="40%" align=""/>
                            <col field="[=jo.formatTime('{createTime}')]" title="关联时间" width="40%" align=""/>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--导入菜单模态框--%>
<div id="navTree" class="ztree" style="display: none;">

</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>