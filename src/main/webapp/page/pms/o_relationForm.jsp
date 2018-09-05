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
    <title>家庭成员和社会关系表单</title>
    <script type="text/javascript">
        $(function(){
            var jParams = {
                "PKName" : "id",//主键属性名
                "saveAfter" : "toEdit",
                // "addUrl" : "pms/relation/insert.action",//新增auditInsert
                "addUrl" : "pms/auditPmsRelations/auditInsert.action",//新增
                "deleteUrl" : "pms/relation/delete.action",//删除
                // "updateUrl" : "pms/auditrelation/insert.action",//修改
                "updateUrl" : "pms/auditPmsRelations/update.action",//修改
                "formDataUrl" : "pms/relation/get.action"	//查询
            };
            joForm.initFormPage(jParams);//初始化
        });
        //初始化表单值前处理
        joForm.initFormValueBefore = function(oJson){
        };
        //新增页面的初始化,当传入userId时,对userId参数进行赋值处理
        joForm.initFormPageOfAdd = function(){
            userIdHandleInAddForm();//userId字段处理
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12">
            <!--按钮栏-->
            <div class="form-group button-bar">
                <button type="button" isShow="joForm.isAdd" class="btn btn-sm btn-outline btn-default" onclick="joForm.save()">
                    <i class="fa fa-plus-circle" aria-hidden="true"></i>&nbsp;保存
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
                        <td width="15%" class="active must" align="">姓　　名</td>
                        <td class="tnt">
                            <input type="text"   name="name" class="form-control input-sm " ErrEmpty="姓名不允许为空" />
                            <input type="hidden" id="userId" name="userId" class="form-control input-sm"  />
                            <input type="hidden" id="id" name="id" class="form-control input-sm readonly-edit"  />
                        </td>
                        <td width="15%" class="active must" align="">关　　系</td>
                        <td class="tnt">
                            <input type="text"   name="relation" class="form-control input-sm " ErrEmpty="关系不允许为空" placeholder="例如: 父亲/母亲/妻子/丈夫/儿子/朋友/同学/同事等"  />
                        </td>

                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">性　　别</td>
                        <td class="tnt">
                            <select id="sex" name="sex" class="form-control input-sm "  >
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </td>
                        <td width="15%" class="active " align="">出生年月</td>
                        <td class="tnt">
                            <input type="text" onclick="laydate()"  name="birthday" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">联系电话</td>
                        <td class="tnt">
                            <input type="text"   name="tel" class="form-control input-sm "  />
                        </td>
                        <td width="15%" class="active " align="">工作单位</td>
                        <td class="tnt">
                            <input type="text"   name="unit" class="form-control input-sm "  />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="active " align="">关系类型</td>
                        <td class="tnt">
                            <select id="stype" name="stype" class="form-control input-sm " >
                                <option value="家庭成员">家庭成员</option>
                                <option value="社会关系">社会关系</option>
                            </select>
                        </td>
                        <td width="15%" class="active " align="">显示顺序</td>
                        <td class="tnt">
                            <input type="text"   name="num" class="form-control input-sm "  value="10" />
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
