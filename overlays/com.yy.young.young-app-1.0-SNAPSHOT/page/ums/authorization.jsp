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
    <title>角色管理</title>
    <script type="text/javascript">
        $(function(){
            //创建左侧角色树
            createRoleTree("roleTree",function(event,treeId,treeNode){
                if(treeNode.nodeType == "COMPANY"){

                }else{
                    roleClick(treeNode.ID);
                }
            });
        });
        var roleId = "";
        function roleClick(id){
            if(jo.isValid(id)){roleId = id;}else{return;}
            var sUrl = "ums/navigate/getNavigateByRole.action";
            var oDate = {"roleId":id};
            jo.postAjax(sUrl,oDate,function(json){
                if(json && json.code==0){
                    var param = {
                        "treeId":"navTree",
                        "zNodes":json.data,
                        /* "item_id":"ID",
                         "item_pid":"PARENT_ID",
                         "item_show":"NAME",*/
                        "setting":{
                            data: {
                                simpleData: {
                                    enable: true,
                                    idKey: "ID",
                                    pIdKey: "PARENT_ID"
                                },
                                key: {
                                    name: "NAME",
                                    title: "NAME"
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
                                chkboxType: {"Y":"ps","N":"s"},    //Y和N固定不变,Y表示勾选,N表示取消勾选;Y和N的值为p或s或ps,p表示会影响父节点,s表示会影响子节点
                                radioType: "all"    //取值为"all"和"level",all表示在所有节点中单选,level表示在同一层级内单选
                            }
                        }
                    }
                    jo.drawZTree(param);
                }
            });
        };
        function setAuth(){
            if(jo.isValid(roleId)){
                var ids = jo.getZTreeCheckedNodesIds("navTree");
                jo.postAjax("ums/role/batchInsertNavigate2Role.action",{"roleId":roleId,"navigateId":ids},function(json){
                    if(json && json.code==0){
                        jo.showMsg("授权成功!");
                    }else{
                        jo.showMsg(jo.getDefVal(json.info,"授权失败!"));
                    }
                });
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="setAuth()">
                    <i class="fa fa-sliders" aria-hidden="true"></i>&nbsp;授权
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-3 col-md-3 col-sm-3">
            <div id="roleTree" class="ztree">

            </div>
        </div>
        <div class="col-xs-12 col-lg-9 col-md-9 col-sm-9">
            <div class="zTreeDemoBackground left">
                <div class="treeTitle">资源链接池</div>
                <ul id="navTree" class="ztree"></ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
