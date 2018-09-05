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
    <script src="<%=URL_STATIC%>static/plugin/echarts/echarts.js"></script>
    <title>学历分布情况统计</title>
    <script type="text/javascript">
        //系统录入所有人员数量
        var allUserCount;
        //获取系统录入所有人员数量
        getAllUserCount();


        //小学
        var educationSpread1;
        //初中
        var educationSpread2;
        //中专/高中
        var educationSpread3;
        //大专
        var educationSpread4;
        //大学
        var educationSpread5;
        //硕士研究生
        var educationSpread6;
        //博士研究生
        var educationSpread7;


        //部门编号
        var deptId;
        //职称
        var zc;
        //职务
        var zw;
        //人员类型
        var personType;

        //初始化图表属性
        $(function(){
            loadInfo();
        });

        //加载页面所有信息
        function loadInfo(){
            //加载搜索信息
            loadSearchInfo();

            //加载角色信息
            getRoleNameAndDeptName();

            //加载某条件下人数
            getAllUserCount();

            //加载学历分布情况
            loadEducationSpread();
            var myChart1 = echarts.init(document.getElementById("educationSpreadPie"));
            myChart1.setOption(option1);

            var myChart2 = echarts.init(document.getElementById("educationSpreadBar"));
            myChart2.setOption(option2);

            //加载系统总人数
            $("#allUserCount").html(allUserCount);
        }



        //加载学历分布情况
        function loadEducationSpread(){
            jo.postAjax("pms/statistic/getEducationSpread",{deptId:deptId,zc:zc,zw:zw,personType:personType}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];

                    //小学
                    educationSpread1 = info["attr1"];
                    //初中
                    educationSpread2 = info["attr2"];
                    //中专/高中
                    educationSpread3 = info["attr3"];
                    //专科
                    educationSpread4 = info["attr4"];
                    //专科/本科
                    educationSpread5 = info["attr5"];
                    //硕士研究生
                    educationSpread6 = info["attr6"];
                    //博士研究生
                    educationSpread7 = info["attr7"];

                    //尚无填写
                    noInfo = allUserCount - educationSpread1 - educationSpread2 - educationSpread3 - educationSpread4 - educationSpread5 - educationSpread6 - educationSpread6;
                    if(noInfo<0){
                        noInfo = 0;
                    }
                    //饼状图
                    option1 = {
                        title : {
                            text: '学历分布情况饼状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        tooltip : {
                            trigger: 'item',
                            formatter: "{a} <br/>{b} : {c} ({d}%)"
                        },
                        legend: {
                            orient: 'vertical',
                            left: 'left',
                            data: ['小学','初中','中专/高中','大专','大学','硕士研究生','博士研究生','尚未填写']
                        },
                        series : [
                            {
                                name: '学历分布情况',
                                type: 'pie',
                                radius : '55%',
                                center: ['50%', '60%'],
                                label: {
                                    normal: {
                                        show: true,
                                        formatter: '{b}: {c}({d}%)'
                                    }
                                },
                                data:[
                                    {value:educationSpread1, name:'小学'},
                                    {value:educationSpread2, name:'初中'},
                                    {value:educationSpread3, name:'中专/高中'},
                                    {value:educationSpread4, name:'大专'},
                                    {value:educationSpread5, name:'大学'},
                                    {value:educationSpread6, name:'硕士研究生'},
                                    {value:educationSpread7, name:'博士研究生'},
                                    {value:noInfo, name:'尚未填写'}
                                ],
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ]
                    };



                    //柱状图
                    option2 = {
                        title : {
                            text: '学历分布情况柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['小学','初中','中专/高中','大专','大学','硕士研究生','博士研究生','尚未填写'],
                            axisLabel :{
                                interval:0,
                                rotate:0,
                                formatter:function(val){
                                    return val.split("").join("\n");
                                }
                            }
                        },
                        yAxis: {
                            type: 'value'
                        },
                        grid: { // 控制图的大小，调整下面这些值就可以，
                            x: 40,
                            x2: 100,
                            y2: 180,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
                        },
                        series: [{
                            label: {
                                normal: {
                                    show: true,
                                    formatter: '{c}'
                                }
                            },
                            data: [educationSpread1, educationSpread2, educationSpread3,educationSpread4,educationSpread5,educationSpread6,educationSpread7,noInfo],
                            type: 'bar',
                            itemStyle: {
                                emphasis: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }]
                    };



                    var list = [];
                    list.push({option:"小学", num:educationSpread1});
                    list.push({option:"初中", num:educationSpread2});
                    list.push({option:"中专/高中", num:educationSpread3});
                    list.push({option:"大专", num:educationSpread4});
                    list.push({option:"大学", num:educationSpread5});
                    list.push({option:"硕士研究生", num:educationSpread6});
                    list.push({option:"博士研究生", num:educationSpread7});
                    list.push({option:"尚无填写", num:noInfo});
                    list.push({option:"总数", num:allUserCount});
                    Grid("educationSpreadList").loadData(list);


                }
            });
        }



        //查询系统内所有用户数量
        function getAllUserCount(){
            jo.postAjax("pms/statistic/getAllUserCount",{deptId:deptId,zc:zc,zw:zw}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allUserCount = info["attr1"];
                }
            });
        }

        //加载搜索信息
        function loadSearchInfo(){
            //部门编号
            deptId = $("#deptId").val();
            //职称
            zc = $("#zcDicValue").val();
            //职务
            zw = $("#zwDicValue").val();
            //人员类型
            personType = $("#personTypeValue").val();
        }

        //行政级别
        function choiceZC(idInp, nameInp, bMore){
            jo.selectTree('pms/statistic/getDicValue/ADMINISTRATIVE_LEVEL',idInp,nameInp,'id','dicValue',null, bMore);
        }

        //专业技术等级
        function choiceZW(idInp, nameInp, bMore){
            jo.selectTree('pms/statistic/getDicValue/TECHNICAL_POSITION',idInp,nameInp,'id','dicValue',null, bMore);
        }

        //人员类型
        function choicePersonType(idInp, nameInp, bMore){
            jo.selectTree('pms/statistic/getDicValue/PERSON_TYPE',idInp,nameInp,'id','dicValue',null, bMore);
        }

        //1.获取部门名称、角色名称、部门编号
        //2.根据角色名称查询部门人数
        function getRoleNameAndDeptName(){
            jo.postAjax("pms/statistic/getRoleNameAndDeptName",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    deptName = data[4];
                    roleName = data[1];

                    if(roleName.indexOf("人事处")>-1){
                        $("#personType").show();
                    }else if(roleName.indexOf("二级单位领导")>-1){
                        deptId = data[2];
                        $("#deptId").hide();
                        $("#deptOtherName").html(deptName);
                    }
                }else{

                }
            });
        }
    </script>

</head>
<body>
<div class="container-fluid" style="margin: 15px 0px;">
    <div class="row">
        <div class="col-xs-12 form-inline">
            <div class="form-group">
                <label class="control-label">部门：&nbsp;</label>
                <select id="deptId" name="deptId" class="joSelect form-control input-sm" data="" dataurl="pms/statistic/getDeptList" keyfield="wholeName" valuefield="deptName" firstitem='{"wholeName":"","deptName":""}'></select>
                <span id="deptOtherName"></span>
                &nbsp; &nbsp; &nbsp; &nbsp;

                <div class="form-group">
                    <label class="control-label">行政级别：&nbsp;</label>
                    <div class="input-group">
                        <input type="hidden" id="zcId" name="xzjbId" class="form-control input-sm" value="">
                        <input type="text" id="zcDicValue" name="xzjbDicValue" class="form-control input-sm" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceZC('zcId','zcDicValue',true)">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                </div>
                &nbsp; &nbsp; &nbsp; &nbsp;


                <div class="form-group" style="display: none;" id="personType">
                    <label class="control-label">人员类型：&nbsp;</label>
                    <div class="input-group">
                        <input type="hidden" id="personTypeId" name="id" class="form-control input-sm" value="">
                        <input type="text" id="personTypeValue" name="dicValue" class="form-control input-sm" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choicePersonType('personTypeId','personTypeValue',true)">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                </div>
                &nbsp; &nbsp; &nbsp; &nbsp;


                <div class="form-group">
                    <label class="control-label">专业技术职务：&nbsp;</label>
                    <div class="input-group">
                        <input type="hidden" id="zwId" name="id" class="form-control input-sm" value="">
                        <input type="text" id="zwDicValue" name="dicValue" class="form-control input-sm" value="">
                        <span class="input-group-btn">
                            <button class="btn btn-default btn-sm" type="button" onclick="choiceZW('zwId','zwDicValue',true)">
                                <i class="fa fa-bars" aria-hidden="true"></i>&nbsp;选择
                            </button>
                        </span>
                    </div>
                </div>
                &nbsp; &nbsp; &nbsp; &nbsp;

            </div>
            &nbsp; &nbsp; &nbsp; &nbsp;<button type="button" class="btn btn-primary btn-sm" onclick="loadInfo()"> <i class="fa fa-search" aria-hidden="true"></i>&nbsp;查询</button>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div id="a" style="width: 100%;height: 80px;float: left;border: 1px solid silver;text-align: center;background-color: aliceblue;">
                <h3>环科院学历分布情况统计</h3>
                <h5 >系统录入完整的人数：<span id="allUserCount"></span>人</h5>
            </div>


            <div id="educationSpreadPie" style="width: 40%;height: 600px;float: left;"><%--学历分布情况饼状图--%>
            </div>

            <div id="educationSpreadBar" style="width: 60%;height: 600px;float: left;"><%--学历分布情况柱状图--%>
            </div>

            <div style="float: left;margin: auto;">
                <table class="table table-bordered table-hover table-striped table-condensed" id="educationSpreadList" style="margin: auto;width: 80%;margin-top: 50px;">
                    <col field="_seq" title="排序" width="20%" align=""/>
                    <col field="option" title="性别" width="50%" align=""/>
                    <col field="num" title="数量" width="30%" align="" order="num"/>
                </table>
            </div>

        </div>
    </div>
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
