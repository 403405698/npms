<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>按人员审核</title>
    <%--常量--%>
    <%@ include file="/common/constHead.jsp"%>
    <link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">

    <script src="<%=URL_STATIC%>static/final/js/layui.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/layui.css">
    <script src="<%=URL_STATIC%>static/final/js/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/font/font2/iconfont.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/common.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/person-document.css">
    <link rel="stylesheet" href="<%=URL_STATIC%>static/final/css/employee.css">
    <!-- <script src="<%=URL_STATIC%>static/final/js/common.js"></script> -->

    <script src="<%=URL_STATIC%>static/newjs/final_jo.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_jo-adapt.js"></script>
    <script src="<%=URL_STATIC%>static/newjs/final_grid.js"></script>
    <script src="<%=URL_STATIC%>static/js/common.js"></script>
    <script src="<%=URL_STATIC%>static/js/common_biz.js"></script>

    <script type="text/javascript">
        $(function(){
            joView.init({grid:$("#mainList"),PKName:"id",formWidth:"90%",formHeight:"90%",winTitleOfAdd:"新增人员信息",winTitleOfUpdate:"人员信息"});//初始化页面
        });
        //行处理
        joView.handleItem = function(oItem,iIndex){
            oItem._opt = '<a href="javascript:;" class="edit" onclick="lookUserDoc(\''+oItem.id+'\')">查看</a>';
            oItem._opt += '&nbsp;&nbsp;<a href="javascript:;" class="on" onclick="joView.edit(\''+oItem.id+'\')">审核</a>';
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
                    //这个是旧的,2018-08-15，改回去审核可以修改，增加参数sf
                    top.jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+(id) +"&sf=rs&edit=true&"+ joView.params["transferParam"],jo.getDefVal("80%", joView.params["formWidth"]),jo.getDefVal("85%", joView.params["formHeight"]),jo.getDefVal("按人员审核", joView.params["winTitleOfUpdate"]), joView.params["winNameOfUpdate"]);
                    //TODO 改用新的暂且简单固定特殊测试李四
                    // opennew(id);
                }
            }
        };

        //测试新打开弹出层
        function opennew(id) {
            // var url = "page/pms/auditUserDoc.jsp?id=d6ed740de85b437580b3c544a45032b5";
            var url = "page/pms/auditUserDoc.jsp?id=" + id;
            url = jo.parseUrl(url);
            console.log("新弹出层特殊测试URL：" + url);
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
    </style>
</head>

<body>
<div class="container">
    <div class="layui-row">
        <form class="layui-form layui-form-box layui-col-md12 person">
            <div class="person-tit clear">
                <span class="left title">按人员审核</span>
                <div class="layui-form right">
                    <div class="layui-inline button-group">
                        <!-- <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add">新增</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary change-password">密码重置</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary del">删除</button>
                        <button type="button" class="layui-btn layui-btn-radius layui-btn-primary reset"><i class="layui-icon layui-icon-refresh"></i> 刷新</button> -->
                    </div>
                </div>
            </div>

            <div class="form-content">
                <div class="item">
                    <i class="layui-icon layui-icon-search"></i>
                    <div class="layui-form-item">
                        <label class="layui-form-label">基本搜索</label>
                        <div class="layui-input-inline">
                            <input type="text" name="name" placeholder="请输入姓名" autocomplete="off" class="layui-input list-input">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <div class="layui-input-inline button-inline">
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary search">搜索</button>
                        </div>
                    </div>
                </div>
                <div class="w-line"></div>
                <div class="item">
                    <i class="iconfont icon-shaixuan"></i>
                    <div class="shaixuanBtn">
                        <label class="layui-form-label">高级筛选</label>
                        <div>
                            <a class="layui-btn layui-btn-radius layui-btn-primary primary">基本信息</a>
                            <a class="layui-btn layui-btn-radius layui-btn-primary message">通讯信息</a>
                            <a class="layui-btn layui-btn-radius layui-btn-primary education">教育经历</a>
                            <a class="layui-btn layui-btn-radius layui-btn-primary the-situation">论文情况</a>
                            <a class="layui-btn layui-btn-radius layui-btn-primary publishing">出版著作/译著</a>
                        </div>
                    </div>
                    <div class="layui-form-item inquiry-item">
                        <div class="layui-input-inline button-inline">
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry">查询</button>
                        </div>
                    </div>
                </div>
                <div class="w-line" style="margin-top: 24px;"></div>
                <div class="item">
                    <label class="layui-form-label" style="width: 100px;">当前筛选条件</label>
                    <div class="now-item">
                        <label class="layui-form-label">基本信息</label>
                        <div class="info">张小虎</div>
                    </div>
                    <div class="now-item">
                        <label class="layui-form-label">性别</label>
                        <div class="info">男</div>
                    </div>
                    <div class="now-item">
                        <label class="layui-form-label">通讯信息</label>
                        <div class="info num">13120910203</div>
                    </div>
                </div>
            </div>

            <div class="person-list-content">
                <table class="layui-table layui-form"  id="mainList" dataUrl="pms/auditShowUser/getPage.action" deleteUrl="" formUrl="page/pms/auditUserDoc.jsp">
                    <col field="userName" title="姓名" width="15%" align="" event="" order="user_Name"/>
                    <col field="sex" title="性别" width="15%" align="" order="sex"/>
                    <col field="deptNames" title="部门" width="20%" align="left"/>
                    <col field="technicalPosition" title="职称" width="15%" align="" order="technical_Level"/>
                    <col field="administrativeDuty" title="行政职务" width="15%" align="" order="administrative_Duty"/>
                    <col field="_opt" title="操作" width="18%" align=""/>
                </table>
                <%--分页条--%>
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
                joView.choicePageSize(iNum);
            });
/*            $(".edit").click(function() {
                // layer.msg('Hello World');
                layer.open({ /!*弹出框*!/
                    type: 2,
                    title: '编辑教育经历',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['650px', '390px'],
                    content: 'education-experience-edit.html'
                });
            })
            // 审核
            $(".on").click(function() {
                layer.open({ /!*弹出框*!/
                    type: 2,
                    title: '按人员审核',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['100%', '100%'],
                    content: 'person-primary-info-reviewe.html'
                });
            })*/
            $(".primary").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '添加基本信息搜索条件',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['840px', '350px'],
                    content: ['page/pms/search_baseinfo.jsp', 'no'],
                });
            });

            $(".message").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '添加通讯信息搜索条件',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['650px', '290px'],
                    content: ['page/pms/search_commu.jsp', 'no'],
                });
            })
            $(".education").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '添加教育经历搜索条件',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['650px', '290px'],
                    content: ['page/pms/search_edu.jsp', 'no'],
                });
            });
            $(".the-situation").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '添加论文情况搜索条件',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['650px', '290px'],
                    content: ['page/pms/search_paper.jsp', 'no'],
                });
            })
            $(".publishing").click(function() {
                layer.open({ /*弹出框*/
                    type: 2,
                    title: '添加出版著作/译著搜索条件',
                    // maxmin: true,//大小窗口切换
                    shadeClose: true, //点击遮罩关闭层
                    area: ['650px', '290px'],
                    content: ['page/pms/search_publish.jsp', 'no'],
                });
            })
            // 点击高级筛选按钮
            // $(".shaixuanBtn a").click(function() {
            //     if (!$(this).hasClass("active")) {
            //         $(this).addClass("active");
            //     } else {
            //         $(this).removeClass("active");
            //     }
            // })
        });;
    })
</script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>

</html>