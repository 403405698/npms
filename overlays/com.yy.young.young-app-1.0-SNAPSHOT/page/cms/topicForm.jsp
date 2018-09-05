<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
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
    <%--日期选择--%>
    <%@ include file="/common/dateHead.jsp"%>
    <title>主题表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                "addUrl" : "cms/topic/insert.action",//新增
                "deleteUrl" : "cms/topic/delete.action",//删除
                "updateUrl" : "cms/topic/update.action",//修改
                "formDataUrl" : "cms/topic/get.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
            oJson.createTime = jo.formatTime(oJson.createTime);
            oJson.updateTime = jo.formatTime(oJson.updateTime);
        };
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            <!--按钮栏-->
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
            <!--按钮栏-->
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <form id="pageForm" name="pageForm" action="" method="post">
                <table class="table table-bordered  table-condensed dataTables-example dataTable no-footer">
                    <tr>
                        <td width="15%" class="active must" align="">标　　题</td>
                        <td class="tnt">
                            <input type="text"   name="title" class="form-control input-sm " ErrEmpty />
                            <input type="hidden"   name="id" class="form-control input-sm readonly-edit" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">分类/频道</td>
                        <td class="tnt">
                            <input type="text"   name="category" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">文本内容</td>
                        <td class="tnt">
                            <textarea   name="contentText" class="form-control input-sm "  ></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">带格式内容</td>
                        <td class="tnt">
                            <textarea   name="contentFormat" class="form-control input-sm "  ></textarea>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">作者编号</td>
                        <td class="tnt">
                            <input type="text"   name="authorId" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">作者名字</td>
                        <td class="tnt">
                            <input type="text"   name="authorName" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active must" align="">应用编号</td>
                        <td class="tnt">
                            <input type="text"   name="appId" class="form-control input-sm " ErrEmpty />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">主题源ID</td>
                        <td class="tnt">
                            <input type="text"   name="sourceId" class="form-control input-sm " placeholder="默认与编号相同" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">访问地址</td>
                        <td class="tnt">
                            <input type="text"   name="url" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">创建时间</td>
                        <td class="tnt">
                            <input type="text"  name="createTime" class="form-control input-sm " readonly/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active" align="">修改时间</td>
                        <td class="tnt">
                            <input type="text"  name="updateTime" class="form-control input-sm " readonly/>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>

<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
