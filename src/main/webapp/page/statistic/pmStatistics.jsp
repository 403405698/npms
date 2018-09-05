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
    <title>男女比例情况统计</title>
    <script type="text/javascript">
        //部门名称
        var deptName;
        //角色名称
        var roleName;
        //部门编号
        var deptId;
        //校验是否是二级单位领导
        getRoleNameAndDeptName();//TODO old
        //系统录入所有人员数量
        var allUserCount;
        //根据条件获取系统录入所有人员数量
        //getAllUserCount();
        //获取系统录入的人员数量
        //getSystemInputCount();

        //系统录入所有科技奖数量
        var allTechAwardCount;
        //获取系统录入所有科技奖数量
        getAllTechAwardsCount();
        //有国外经历的数量
        var haveForeignExperience;
        //无国外经历的数量
        var noForeignExperience;
        //男
        var man;
        //女
        var women;
        //尚无资料
        var noInfo;
        //小于30岁
        var age30;
        //大于30岁，小于等于35岁
        var age30_35;
        //大于35岁，小于等于40岁
        var age35_40;
        //大于40岁，小于等于45岁
        var age40_45;
        //大于45岁，小于等于50岁
        var age45_50;
        //大于50岁
        var age50;

        //小于等于5年
        var work_year_5;
        //大于5年，小于等于10年
        var work_year_5_10;
        //大于10年，小于等于20年
        var work_year_10_20;
        //大于20年，小于等于30年
        var work_year_20_30;
        //大于30年，小于等于40年
        var work_year_30_40;
        //大于40年
        var work_year_40;

        //大气环境研究
        var researchField1;
        //水环境研究
        var researchField2;
        //生态环境研究
        var researchField3;
        //土壤与固体废物环境研究
        var researchField4;
        //清洁生产与循环经济环境研究
        var researchField5;
        //环境安全与健康研究
        var researchField6;
        //环境工程和环境影响评价研究
        var researchField7;
        //其他研究
        var researchField8;

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

        //奖励层次国家级
        var awardLevel;
        //奖励层次省部级
        var awardLeve2;
        //奖励层次厅级及以下
        var awardLeve3;



        //初始化图表属性
        $(function(){
            // getRoleNameAndDeptName();//new
            // console.log("roleName" + roleName);
            if(roleName.indexOf("二级单位领导")>-1){
                //根据条件获取系统录入所有人员数量
                getAllUserCount();
                // alert("执行了没有"+allUserCount);
                $("#allUserCount").html(deptName+"录入人数为"+allUserCount+"人");
            }else{
                //无条件查询系统内所有用户数量
                getSystemInputCount();
                $("#allUserCount").html("系统录入人数为"+allUserCount+"人");
            }

            //加载人才梯队建设
            loadTalentEchelon();
            var myChart_talentEchelonPie = echarts.init(document.getElementById("talentEchelonPie"));
            myChart_talentEchelonPie.setOption(option_talentEchelonPie);

            var myChart_talentEchelonBar = echarts.init(document.getElementById("talentEchelonBar"));
            myChart_talentEchelonBar.setOption(option_talentEchelonBar);

            //加载研究领域情况
            loadResearchField();
            var myChart_researchFieldPie = echarts.init(document.getElementById("researchFieldPie"));
            myChart_researchFieldPie.setOption(option_researchFieldPie);

            var myChart_researchFieldBar = echarts.init(document.getElementById("researchFieldBar"));
            myChart_researchFieldBar.setOption(option_researchFieldBar);

            //加载男女比例情况
            loadMenAndWomen();
            var myChart_menAndWomenPie = echarts.init(document.getElementById("menAndWomenPie"));
            myChart_menAndWomenPie.setOption(option_menAndWomenPie);

            var myChart_menAndWomenBar = echarts.init(document.getElementById("menAndWomenBar"));
            myChart_menAndWomenBar.setOption(option_menAndWomenBar);

            //加载学历分布情况
            loadEducationSpread();
            var myChart_educationSpreadPie = echarts.init(document.getElementById("educationSpreadPie"));
            myChart_educationSpreadPie.setOption(option_educationSpreadPie);

            var myChart_educationSpreadBar = echarts.init(document.getElementById("educationSpreadBar"));
            myChart_educationSpreadBar.setOption(option_educationSpreadBar);

            //加载国外经历属性
            loadForeignExperience();
            var myChart_foreignExperiencePie = echarts.init(document.getElementById("foreignExperiencePie"));
            myChart_foreignExperiencePie.setOption(option_foreignExperiencePie);

            var myChart_foreignExperienceBar = echarts.init(document.getElementById("foreignExperienceBar"));
            myChart_foreignExperienceBar.setOption(option_foreignExperienceBar);

            //加载工龄情况属性
            loadWorkYear();
            var myChart_workYearPie = echarts.init(document.getElementById("workYearPie"));
            myChart_workYearPie.setOption(option_workYearPie);

            var myChart_workYearBar = echarts.init(document.getElementById("workYearBar"));
            myChart_workYearBar.setOption(option_workYearBar);

            //加载奖励层次
            /*loadAwardLevel();
            var myChart_awardLevelPie = echarts.init(document.getElementById("awardLevelPie"));
            myChart_awardLevelPie.setOption(option_awardLevelPie);

            var myChart_awardLevelBar = echarts.init(document.getElementById("awardLevelBar"));
            myChart_awardLevelBar.setOption(option_awardLevelBar);*/

            //加载系统总人数
            //$("#allUserCount").html("8888888888888888888888888888888888"+allUserCount);



        });


        //加载人才梯队建设
        function loadTalentEchelon(){
            jo.postAjax("pms/statistic/getTalentEchelon",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];

                    //小于30岁
                    age30 = info["attr1"];
                    //大于30岁，小于等于35岁
                    age30_35 = info["attr2"];
                    //大于35岁，小于等于40岁
                    age35_40 = info["attr3"];
                    //大于40岁，小于等于45岁
                    age40_45 = info["attr4"];
                    //大于45岁，小于等于50岁
                    age45_50 = info["attr5"];
                    //大于50岁
                    age50 = info["attr6"];
                    //尚无填写
                    noInfo = allUserCount - age30 - age30_35 - age35_40 - age40_45 - age45_50 - age50;
                    //alert("总人数-"+allUserCount+";age30-"+age30+";age30_35-"+age30_35+";age35_40-"+age35_40+";age40_45-"+age40_45+";age45_50-"+age45_50+";age50-"+age50+";尚无填写-"+noInfo);
                    option_talentEchelonPie = {
                        title : {
                            text: '人才梯队建设饼状图',
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
                            data: ['<30岁','30-35岁','35-40岁','40-45岁','45-50岁','50+岁']
                        },
                        series : [
                            {
                                name: '人才梯队建设',
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
                                    {value:age30, name:'<30岁'},
                                    {value:age30_35, name:'30-35岁'},
                                    {value:age35_40, name:'35-40岁'},
                                    {value:age40_45, name:'40-45岁'},
                                    {value:age45_50, name:'45-50岁'},
                                    {value:age50, name:'50+岁'},
                                    {value:noInfo, name:'尚无填写'}
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
                    option_talentEchelonBar = {
                        title : {
                            text: '人才梯队建设柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['<30岁', '30-35岁', '35-40岁', '40-45岁', '45-50岁', '50+岁', '尚无填写']
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            label: {
                                normal: {
                                    show: true,
                                    formatter: '{c}'
                                }
                            },
                            data: [age30, age30_35, age35_40, age40_45, age45_50, age50, noInfo],
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
                }
            });
        }




        //加载研究领域情况
        function loadResearchField(){
            jo.postAjax("pms/statistic/getResearchField",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];

                    //大气环境研究
                    researchField1 = info["attr1"];
                    //水环境研究
                    researchField2 = info["attr2"];
                    //生态环境研究
                    researchField3 = info["attr3"];
                    //土壤与固体废物环境研究
                    researchField4 = info["attr4"];
                    //清洁生产与循环经济环境研究
                    researchField5 = info["attr5"];
                    //环境安全与健康研究
                    researchField6 = info["attr6"];
                    //环境工程和环境影响评价研究
                    researchField7 = info["attr7"];
                    //其他研究
                    researchField8 = info["attr8"];
                    //尚无填写
                    noInfo = allUserCount - researchField1 - researchField2 - researchField3 - researchField4 - researchField5 - researchField6 - researchField7 - researchField8;

                    option_researchFieldPie = {
                        title : {
                            text: '研究领域分布饼状图',
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
                            data: ['大气环境研究','水环境研究','生态环境研究','土壤与固体废物环境研究','清洁生产与循环经济环境研究','环境安全与健康研究','环境工程和环境影响评价研究','其他研究']
                        },
                        series : [
                            {
                                name: '人才梯队建设',
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
                                    {value:researchField1, name:'大气环境研究'},
                                    {value:researchField2, name:'水环境研究'},
                                    {value:researchField3, name:'生态环境研究'},
                                    {value:researchField4, name:'土壤与固体废物环境研究'},
                                    {value:researchField5, name:'清洁生产与循环经济环境研究'},
                                    {value:researchField6, name:'环境安全与健康研究'},
                                    {value:researchField7, name:'环境工程和环境影响评价研究'},
                                    {value:researchField8, name:'其他研究'},
                                    {value:noInfo, name:'尚无填写'}
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
                    option_researchFieldBar = {
                        title : {
                            text: '研究领域分布柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['大气环境研究','水环境研究','生态环境研究','土壤与固体废物环境研究','清洁生产与循环经济环境研究','环境安全与健康研究','环境工程和环境影响评价研究','其他研究','尚无填写'],
                            axisLabel :{
                                interval:0,
                                rotate:0,
                                formatter:function(val){
                                    return val.split("").join("\n");
                                }
                            }
                        },
                        grid: { // 控制图的大小，调整下面这些值就可以，
                            x: 40,
                            x2: 100,
                            y2: 180,// y2可以控制 X轴跟Zoom控件之间的间隔，避免以为倾斜后造成 label重叠到zoom上
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            label: {
                                normal: {
                                    show: true,
                                    formatter: '{c}'
                                }
                            },
                            data: [researchField1, researchField2, researchField3, researchField4, researchField5, researchField6, researchField7,researchField8,noInfo],
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
                }
            });
        }





        //加载男女比例情况
        function loadMenAndWomen(){
            jo.postAjax("pms/statistic/getMenAndWomen",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    //男
                    man = parseInt(info["attr1"]);
                    //女
                    women = parseInt(info["attr2"]);
                    //尚无资料
                    noInfo = allUserCount - man - women;

                    option_menAndWomenPie = {
                        title : {
                            text: '男女比例情况饼状图',
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
                            data: ['女','男','尚无填写']
                        },
                        series : [
                            {
                                name: '男女比例情况',
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
                                    {value:women, name:'女'},
                                    {value:man, name:'男'},
                                    {value:noInfo, name:'尚无填写'}
                                ],
                                itemStyle: {
                                    emphasis: {
                                        shadowBlur: 10,
                                        shadowOffsetX: 0,
                                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                                    }
                                }
                            }
                        ],
                        //color: ['rgb(252,157,154)','rgb(135,206,250)','rgb(200,100,300)']
                    };


                    //柱状图
                    option_menAndWomenBar = {
                        title : {
                            text: '男女比例情况柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['男','女','尚无填写'],
                            axisLabel :{
                                interval:0,

                            }
                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            label: {
                                normal: {
                                    show: true,
                                    formatter: '{c}'
                                }
                            },
                            data: [man, women, noInfo],
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

                }
            });
        }






        //加载学历分布情况
        function loadEducationSpread(){
            jo.postAjax("pms/statistic/getEducationSpread",{deptId:deptId}, function(json){
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
                    //本科
                    educationSpread5 = info["attr5"];
                    //硕士研究生
                    educationSpread6 = info["attr6"];
                    //博士研究生
                    educationSpread7 = info["attr7"];

                    //尚无填写
                    noInfo = allUserCount - educationSpread1 - educationSpread2 - educationSpread3 - educationSpread4 - educationSpread5 - educationSpread6-educationSpread7;

                    option_educationSpreadPie = {
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
                                name: '男女比例情况',
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
                    option_educationSpreadBar = {
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
                }
            });
        }








        //加载国外经历属性
        function loadForeignExperience(){
            jo.postAjax("pms/statistic/getForeignExperience",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    //有国外经历
                    haveForeignExperience = info["attr1"];
                    //无国外经历
                    noForeignExperience = info["attr2"];
                    //尚无资料
                    noInfo = allUserCount - haveForeignExperience - noForeignExperience;
                    option_foreignExperiencePie = {
                        title : {
                            text: '国外经历情况饼状图',
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
                            data: ['有国外经历','无国外经历','尚未填写']
                        },
                        series : [
                            {
                                name: '男女比例情况',
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
                                    {value:haveForeignExperience, name:'有国外经历'},
                                    {value:noForeignExperience, name:'无国外经历'},
                                    {value:noInfo, name:'尚未填写'},

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
                        option_foreignExperienceBar = {
                            title : {
                                text: '国外经历情况柱状图',
                                subtext: '环科院信息所',
                                x:'center'
                            },
                            xAxis: {
                                type: 'category',
                                data: ['有国外经历','无国外经历','尚未填写'],
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
                                data: [haveForeignExperience, noForeignExperience, noInfo],
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

                }
            });
        }




        //加载工作年限情况
        function loadWorkYear(){
            jo.postAjax("pms/statistic/getWorkYear",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];

                    //小于等于5年
                    work_year_5 = info["attr1"];
                    //大于5年，小于等于10年
                    work_year_5_10 = info["attr2"];
                    //大于10年，小于等于20年
                    work_year_10_20 = info["attr3"];
                    //大于20年，小于等于30年
                    work_year_20_30 = info["attr4"];
                    //大于30年，小于等于40年
                    work_year_30_40 = info["attr5"];
                    //大于40年
                    work_year_40 = info["attr6"];


                    //尚无填写
                    noInfo = allUserCount - work_year_5 - work_year_5_10 - work_year_10_20 - work_year_20_30 - work_year_30_40 - work_year_40;

                    option_workYearPie = {
                        title : {
                            text: '工作年限情况饼状图',
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
                            data: ['<5年','5-10年','10-20年','20-30年','30-40年','40+年','尚无填写']
                        },
                        series : [
                            {
                                name: '工作年限情况',
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
                                    {value:work_year_5, name:'<5年'},
                                    {value:work_year_5_10, name:'5-10年'},
                                    {value:work_year_10_20, name:'10-20年'},
                                    {value:work_year_20_30, name:'20-30年'},
                                    {value:work_year_30_40, name:'30-40年'},
                                    {value:work_year_40, name:'40+年'},
                                    {value:noInfo, name:'尚无填写'}
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
                    option_workYearBar = {
                        title : {
                            text: '工作年限情况柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['<5年','5-10年','10-20年','20-30年','30-40年','40+年','尚无填写'],
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
                            data: [work_year_5, work_year_5_10,work_year_10_20,work_year_20_30,work_year_30_40,work_year_40,noInfo],
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

                }
            });
        }



        //加载奖励层次属性
        function loadAwardLevel(){
            jo.postAjax("pms/statistic/getAwardLevel",{deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    //国家级
                    awardLevel = info["attr1"];
                    //省部级
                    awardLeve2 = info["attr2"];
                    //厅级及以下
                    awardLeve3 = info["attr3"];

                    //尚无资料
                    noInfo = awardLevel - awardLeve2 - awardLeve3;

                    //加载奖励层次属性
                    option_awardLevelPie = {
                        title : {
                            text: '奖励层次分布饼状图',
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
                            data: ['国家级','省部级','厅级及以下','尚未填写']
                        },
                        series : [
                            {
                                name: '奖励层次',
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
                                    {value:awardLevel, name:'国家级'},
                                    {value:awardLeve2, name:'省部级'},
                                    {value:awardLeve3, name:'厅级及以下'},
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
                    option_awardLevelBar = {
                        title : {
                            text: '奖励层次分布柱状图',
                            subtext: '环科院信息所',
                            x:'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: ['国家级','省部级','厅级及以下','尚未填写'],
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
                            data: [awardLevel, awardLeve2,awardLeve3, noInfo],
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

                }
            });
        }
        //根据条件查询系统内所有用户数量
        function getAllUserCount(){
            jo.postAjax("pms/statistic/getAllUserCount",{deptName:deptName,roleName:roleName,deptId:deptId}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allUserCount = info["attr1"];
                }
            });
        }


        //无条件查询系统内所有用户数量
        function getSystemInputCount(){
            jo.postAjax("pms/statistic/getSystemInputCount",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allUserCount = info["attr1"];
                }
            });
        }

        //查询系统内所有科技奖数量
        function getAllTechAwardsCount(){
            jo.postAjax("pms/statistic/getAllTechAwardsCount",{}, function(json){
                if(json && json.code == 0){
                    var data = json.data;
                    var info = data[0];
                    allTechAwardCount = info["attr1"];
                }
            });
        }

        //1.获取部门名称、角色名称、部门编号
        //2.根据角色名称查询部门人数
        function getRoleNameAndDeptName(){
            jo.postAjax("pms/statistic/getRoleNameAndDeptName",{}, function(json){
                // console.log("roleName" + JSON.stringify(json));
                if(json && json.code == 0){
                    var data = json.data;
                    deptName = data[4];
                    roleName = data[1];
                    //alert(deptName+roleName+deptId);
                    deptId = '';
                    if(roleName.indexOf("二级单位领导")>-1){
                        deptId = data[2];
                    }
                }else{
                    //{"data_id":"","data_desc":"","code":-1,"info":"请先给用户填写部门信息！","data":null,"callback":""}
                    layer.msg(json.info);//new
                }
            });
        }
    </script>

</head>
<body>
<div class="container-fluid" style="margin: 15px 0px;">
    <div class="row">
        <div class="col-xs-12">
            <div id="a" style="width: 100%;height: 80px;border: 1px solid silver;text-align: center;background-color: aliceblue;">
                <h3>环科院人事情况统计</h3>
                <h5 ><span id="allUserCount"></span></h5>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">

            <%--人才梯队--%>
            <div id="talentEchelon" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="talentEchelonPie" style="width: 50%;height: 600px;float: left;"><%--人才梯队饼状图--%>
                </div>
                <div id="talentEchelonBar" style="width: 50%;height: 600px;float: left;"><%--人才梯队柱状图--%>
                </div>
            </div>

            <%--研究领域--%>
            <div id="researchField" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="researchFieldPie" style="width: 50%;height: 600px;float: left;"><%--研究领域饼状图--%>
                </div>
                <div id="researchFieldBar" style="width: 50%;height: 600px;float: left;"><%--研究领域柱状图--%>
                </div>
            </div>

            <%--男女比例--%>
            <div id="menAndWomen" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="menAndWomenPie" style="width: 50%;height: 600px;float: left;"><%--男女比例饼状图--%>
                </div>
                <div id="menAndWomenBar" style="width: 50%;height: 600px;float: left;"><%--男女比例柱状图--%>
                </div>
            </div>

            <%--学历分布--%>
            <div id="educationSpread" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="educationSpreadPie" style="width: 50%;height: 600px;float: left;"><%--学历分布饼状图--%>
                </div>
                <div id="educationSpreadBar" style="width: 50%;height: 600px;float: left;"><%--学历分布柱状图--%>
                </div>
            </div>

            <%--国外经历--%>
            <div id="foreignExperience" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="foreignExperiencePie" style="width: 50%;height: 600px;float: left;"><%--国外经历饼状图--%>
                </div>
                <div id="foreignExperienceBar" style="width: 50%;height: 600px;float: left;"><%--国外经历柱状图--%>
                </div>
            </div>

            <%--工龄--%>
            <div id="workYear" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="workYearPie" style="width: 50%;height: 600px;float: left;"><%--工龄饼状图--%>
                </div>
                <div id="workYearBar" style="width: 50%;height: 600px;float: left;"><%--工龄柱状图--%>
                </div>
            </div>

            <%--奖励层次--%>
            <%--<div id="awardLevel" style="width: 100%;height: 600px;float: left;border: 1px solid silver;">
                <div id="awardLevelPie" style="width: 50%;height: 600px;float: left;">&lt;%&ndash;奖励层次饼状图&ndash;%&gt;
                </div>
                <div id="awardLevelBar" style="width: 50%;height: 600px;float: left;">&lt;%&ndash;奖励层次柱状图&ndash;%&gt;
                </div>
            </div>--%>
        </div>
    </div>
</div>


<script src="<%=URL_STATIC%>static/plugin/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<script type="text/javascript">
    jo.formatUI();//格式化jo组件
</script>
</body>
</html>
