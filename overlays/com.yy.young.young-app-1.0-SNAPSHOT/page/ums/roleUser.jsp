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
    <title>角色用户</title>
    <script type="text/javascript">
        var node = null;//被选中节点
        $(function(){
            //创建左侧角色树
            createRoleTree("roleTree",function(event,treeId,treeNode){
                node = treeNode;
                if(treeNode.nodeType == "COMPANY"){

                }else{
                    joView.params['condition'] = "ROLE_ID="+treeNode.ID;
                    joView.select();
                }
            });
            joView.init({grid:$("#mainList")});//初始化页面
            //页面初始化过后赋值查询地址,防止自动查询所有角色用户
            joView.params["dataUrl"] = "ums/roleUser/getRoleUserPage.action";
        });
        joView.handleItem = function(oItem, iIndex){
            oItem.STATE = (oItem.STATE == 1 ? "<font color='green'>启用</font>" : "<font color='red'>禁用</font>") + "&nbsp;<a href='javascript:changeState(\""+oItem.STATE+"\",\""+oItem.USER_ID+"\");' title='切换状态'><i class=\"fa fa-exchange\" aria-hidden=\"true\"></i></a>";
            oItem.SEX = oItem.SEX == 1 ? "男" : "女";
        };
        //切换状态
        function changeState(oldState, id){
            var state = oldState == 1 ? 0 : 1;
            jo.postAjax("{URL_UMS}ums/user/updateUser.action", {STATE:state,ID:id}, function(json){
                if(json && json.code == 0){
                    jo.showMsg("状态切换成功!");
                    joView.reloadCurrentPage();
                }else{
                    jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                }
            });
        }
        //行点击事件托管函数
        joView.clickItem = function(id,sWidth,sHeight,sTitle){
            jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+sWidth.USER_ID +"&"+ joView.params["transferParam"],jo.getDefVal('','780px'),jo.getDefVal(sHeight,'80%'),jo.getDefVal(sTitle,'编辑'));
        }
        //添加用户
        function addUser2Dept(){
            if(node && node.nodeType != "COMPANY"){//当选中角色节点时
                jo.showWin({title:"关联用户",content:"{URL_UMS}page/ums/choiceUserDialog.jsp",area:['80%', '80%'],btn:["确定", "取消"],yes:function(idx){
                    var ifm = jo.getLayerIframe(idx);
                    var ids = ifm.getCheckUser();
                    if(ids){
                        jo.postAjax("{URL_UMS}ums/role/batchInsertUser2Role.action", {"roleId":node.ID, "userId":ids}, function(json){
                            if(json && json.code == "0"){
                                jo.showMsg("关联成功!");
                                joView.reloadCurrentPage();
                            }else{
                                jo.showMsg(jo.getDefVal(json.info, "操作失败!"));
                            }
                            jo.close(idx);//关闭弹窗
                        });
                    }else{
                        jo.showMsg("请勾选待关联用户!");
                    }
                }});
            }else{
                jo.showMsg("请选择待添加人员的角色节点!");
            }
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--检索栏--%>
            <form class="form-inline search-bar" id="pageForm">
                <div class="form-group">
                    <label class="control-label" for="USER_NAME">姓名&nbsp;</label>
                    <input class="form-control input-sm" id="USER_NAME" name="USER_NAME" placeholder="用户姓名" autocomplete="off" type="text">
                </div>
                <div class="form-group">
                    <label class="control-label" for="SEX">性别&nbsp;</label>
                    <select class="form-control input-sm" id="SEX" name="SEX">
                        <option value=""></option>
                        <option value="1">男</option>
                        <option value="0">女</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="control-label" for="STATE">状态&nbsp;</label>
                    <select class="form-control input-sm" id="STATE" name="STATE">
                        <option value=""></option>
                        <option value="1">启用</option>
                        <option value="0">禁用</option>
                    </select>
                </div>

                <button type="button" class="btn btn-primary btn-sm" onclick="joView.select()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
            </form>
            <%--/检索栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12 col-lg-12 col-md-12 col-sm-12">
            <%--按钮栏--%>
            <div class="form-group button-bar">
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-default" onclick="addUser2Dept()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;添加人员
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-default" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
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
            <%--grid--%>
            <div class="table-responsive">
                <table id="mainList" class="table table-bordered table-hover table-striped table-condensed" dataUrl=""
                       deleteUrl="ums/roleUser/delete.action" formUrl="page/ums/userForm.jsp">
                    <%--<col field="ID" title="编号" width="10%" align="left"/>--%>
                    <col field="USER_NAME" title="姓名" width="15%" align="center" event="click"/>
                   <%-- <col field="ACCOUNT" title="账号" width="10%" align=""/>--%>
                    <col field="BIRTHDAY" title="出生日期" width="10%" align=""/>
                    <col field="SEX" title="性别" width="5%" align=""/>
                    <col field="TEL" title="电话" width="10%" align="left"/>
                    <col field="EMAIL" title="邮箱" width="20%" align="left"/>
                    <col field="STATE" title="状态" width="10%" align=""/>
                    <col field="COMPANY_NAME" title="部门名称" width="10%" align=""/>
                    <%--<col field="[=jo.formatTime({C_CREATEDATE})]" title="发布时间" width="15%" align="center"/>--%>
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
</body>
</html>
