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
    <title>数据字典列表</title>
    <script type="text/javascript">
        $(function(){
            jo.postAjax("pms/pmsDictionary/getDictionaryCatalog", {}, function(json){
                if(json && json.code == 0){
                    var _html = '';
                    for(var i=0;i<json.data.length;i++){
                        var item = json.data[i];
                        _html += '<li onclick="lookDic(\''+item.bedicId+'\', this, \''+item.dicType+'\')">'+(i+1)+'、'+item.dicType+'<br/>'+item.bedicId+'</li>';
                    }
                    $(".catalog").html(_html);
                }
            });
            joView.init({grid:$("#mainList"),PKName:"id"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){

        };
        //查看字典
        function lookDic(did, obj, dicType){
            $(".catalog>li").removeClass("li_action");
            $(obj).addClass("li_action");
            joView.params.condition = "bedicId=" + did;
            joView.params.dataUrl = "pms/pmsDictionary/getPage.action";
            console.info("sId="+did+"&sName="+dicType);
            joView.setTransferParam("sId="+did+"&sName="+dicType);
            joView.select();
        }
    </script>
    <style>
        .catalog{
            margin: 0px;
            padding: 0px;
            list-style: none;
            width: 100%;
            line-height: 1.6;
            font-size: 14px;
            letter-spacing: 1px;
        }
        .catalog>li{
            padding: 2px 5px;
            overflow: hidden;
            border-bottom: #dddddd solid 1px;
            cursor: pointer;
        }
        .catalog>li:hover{
            background-color: #58AFF7;
            color: #FFFFFF;
        }
        .li_action{
            background-color: #58AFF7;
            color: #FFFFFF;
            font-weight: bolder;
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
                    <label class="control-label">编号：&nbsp;</label>
                    <input type="text" name="id" class="form-control input-sm" value="">
                </div>
                <div class="form-group">
                    <label class="control-label">名称：&nbsp;</label>
                    <input type="text" name="dicValue" class="form-control input-sm" value="">
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
                <button isShow="" type="button" class="btn btn-sm btn-outline btn-primary" onclick="joView.add()">
                    <i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-danger" onclick="joView.del()">
                    <i class="fa fa-trash-o" aria-hidden="true"></i>&nbsp;删除
                </button>
                <button type="button" class="btn btn-sm btn-outline btn-warning" onclick="window.location.reload()">
                    <i class="fa fa-refresh" aria-hidden="true"></i>&nbsp;刷新
                </button>
            </div>
            <%--/按钮栏--%>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-3 col-sm-3 col-md-3">
            <ul class="catalog bg">
               <%-- <li>SEX<br/>性别</li>
                <li>SEX<br/>性别</li>
                <li>SEX<br/>性别</li>
                <li>SEX<br/>性别</li>--%>
            </ul>
        </div>
        <div class="col-xs-9 col-sm-9 col-md-9">
            <%--grid--%>
            <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped table-condensed" id="mainList" dataUrl="pms/pmsDictionary/getPage.action" deleteUrl="pms/pmsDictionary/delete.action" formUrl="page/pms/dictionaryForm.jsp">
                    <col field="dicValue" title="字典值" width="15%" align="" event="click"/>
                    <%--<col field="dicDesc" title="描述" width="15%" align=""/>--%>
                    <col field="dicType" title="字典类型" width="15%" align=""/>
                    <col field="bedicId" title="所属字典" width="15%" align=""/>
                    <col field="remark" title="备注" width="15%" align=""/>
                    <col field="dicNum" title="字典顺序" width="10%" align=""/>
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
