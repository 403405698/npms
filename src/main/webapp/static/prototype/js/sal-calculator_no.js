
// 20160907 五险一金计算器
$(function () {
    //salaryRange-应纳税额  taxRate-税率(%)  DeductNumber-速算扣除数
    var proportion = {
        level_1 : {
            salaryRange:[0,1500],
            taxRate:3,
            DeductNumber:0
        },
        level_2 : {
            salaryRange:[1501,4500],
            taxRate:10,
            DeductNumber:105
        },
        level_3 : {
            salaryRange:[4501,9000],
            taxRate:20,
            DeductNumber:555
        },
        level_4 : {
            salaryRange:[9001,35000],
            taxRate:25,
            DeductNumber:1005
        },
        level_5 : {
            salaryRange:[35001,55000],
            taxRate:30,
            DeductNumber:2755
        },
        level_6 : {
            salaryRange:[55001,80000],
            taxRate:35,
            DeductNumber:5505
        },
        level_7 : {
            salaryRange:[80001, 'more'],
            taxRate:45,
            DeductNumber:13505
        }
    };

    //创建城市ul dom
    /*for(var i = 0; i < cityMap.length; i++){
        var cityLi="<li id='"+cityMap[i].id+"'><a href='#'>"+cityMap[i].name_hz+"</a></li>";
        $("#citylist").append(cityLi);
    }*/
    //当前城市相关数据 currCityObj：当前城市 初始化
    var currCityId = $("#curr-city").val(), currCityObj;
    for(var i = 0; i < cityMap.length; i++){
        if (cityMap[i].id == currCityId){
            currCityObj = cityMap[i];
            break;
        }
    }
    //给隐藏域赋值
    /*$("#citylist li").click(function(){
        $(this).addClass("curr-city").siblings().removeClass("curr-city");
        $("#curr-city").val($(this).attr("id"));
        //获取具体数据
        for(var i = 0; i < cityMap.length; i++){
            if (cityMap[i].id == $(this).attr("id")){
                currCityObj = cityMap[i];
                break;
            }
        }
    });*/
    // 判断正则
    var initValSocial;
    var initValAfunds;
    var rg=/^[0-9]+(.[0-9]{1,})?$/; //只能输入有两位小数的正实数
    //设置社保基数,公积金基数
    var $baseSocial = $("#socialBase");//社保基数
    var $baseAfunds = $("#afundsBase");//公积金基数
    var curIns = currCityObj.insurance,//五险一金
        curMaxBS = curIns.maxSocial, curMinBS = curIns.minSocial, curMaxBF = curIns.maxfunds, curMinBF = curIns.minfunds;
    if(curMinBS && curMinBS != 'salary'){
        $baseSocial.val(curMinBS);
        initValSocial=$baseSocial.val();
        currCityObj.baseInsur = curMinBS;
    }else{
        $baseSocial.val(0);
        initValSocial=$baseSocial.val();
        currCityObj.baseInsur = 0;
    }
    if(curMinBF && curMinBF != 'salary'){
        $baseAfunds.val(curMinBF);
        initValAfunds=$baseAfunds.val();
        currCityObj.basefunds = curMinBF;
    }else{
        $baseAfunds.val(0);
        initValAfunds=$baseAfunds.val();
        currCityObj.basefunds = 0;
    }
    $('#salText').keyup(function(){
        var salaryVal = $(this).val();
        //限制输入长度
        if (salaryVal.length >= 10) {
            salaryVal = salaryVal.substring(0,9);
            $(this).val(salaryVal);
        }
        salaryVal = salaryVal*1;
        salaryVal = salaryVal || 0;
        if(!$('#socialBasebtn').prop('checked')){//默认社保基数
            if(curMinBS != 'salary' && salaryVal < curMinBS){
                currCityObj.baseInsur = curMinBS;
            }else if(curMaxBS != 'salary' && salaryVal > curMaxBS){
                currCityObj.baseInsur = curMaxBS;
            }else{
                currCityObj.baseInsur = salaryVal;
            }
            $baseSocial.val(currCityObj.baseInsur);
        }
        if(!$('#afundsBasebtn').prop('checked')){///默认公积金基数
            if(curMinBF != 'salary' && salaryVal < curMinBF){
                currCityObj.basefunds = curMinBF;
            }else if(curMaxBF != 'salary' && salaryVal > curMaxBF){
                currCityObj.basefunds = curMaxBF;
            }else{
                currCityObj.basefunds = salaryVal;
            }
            $baseAfunds.val(currCityObj.basefunds);
        }
    });
    //自定义社保基数
    $("#socialBasebtn").click(function() {
        var t = $(this);
        if(t.prop('checked')){
            $baseSocial.removeAttr('disabled');
        }else{
            $baseSocial.attr('disabled', 'disabled');
            $('#salText').trigger('keyup');//恢复社保基数为指定值
        }
    });
    //自定义公积金基数
    $("#afundsBasebtn").click(function() {
        var t = $(this);
        if(t.prop('checked')){
            $baseAfunds.removeAttr('disabled');
        }else{
            $baseAfunds.attr('disabled', 'disabled');
            $('#salText').trigger('keyup');//恢复公积金基数为指定值
        }
    });
    //计算按钮
    $("#compute").click(function(){
        if(!currCityObj){
            alert("没有获取到城市数据");
            return;
        }
        var inputSally = $("#salText"), salVal = inputSally.val();
        if(!rg.test(salVal)){//输入的薪资不是数字时，薪资设置为0
            salVal = 0;
            inputSally.val(salVal);
        }else{
            salVal = salVal*1;
        }
        //社保基数
        var socBase = $("#socialBase"), baSoVal = socBase.val();
        if(!rg.test(baSoVal)){
            socBase.val(currCityObj.baseInsur);
        }else{
            currCityObj.baseInsur = baSoVal*1;
        }
        //公积金基数
        var  funBase = $("#afundsBase"), baFuVal = funBase.val();
        if(!rg.test(baFuVal)){
            funBase.val(currCityObj.basefunds);
        }else{
            currCityObj.basefunds = baFuVal*1;
        }
        //税收起征点
        var threshold = parseFloat($('#threshold').val() || 0);
        // 是否交公积金
        var checkedHousing=$(".moreother input:first").prop("checked");
        //根据当前的收入计算保险及缴税费用
        var salDetail = incomeDetail(salVal, currCityObj, proportion, threshold, checkedHousing);
        $(".tables-cont").css("display","block");
        //显示数据到表格
        $(".pie-chart").css("display","block");
        $(".my-salary").css("display","block");
        showDetail(salDetail);
        //绘制税后薪资饼图
        afterSalary(salDetail);
        //绘制个人薪资详情饼图
        personDetail(salDetail);
        //单位成本详情饼图
        companyDetail(salDetail);
        // 显示推荐职位
        posRecommend(currCityId, salVal);
        //评星效果
        get_rate(salDetail.salAfterTax);
    });
    //计算收入详细
    //salary:工资 cityInsurance:保险 taxLevel：纳税
    function incomeDetail(salary, cityInsurance, proLevel, taxThreshold, hasHousing){
        var detail = {salary: salary, p_pay:{}, c_pay:{}}, insuranceRate = cityInsurance.insurance,
            pPayTotal = 0, cPayTotal = 0, taxSal = 0,
            insCalVal = cityInsurance.baseInsur,//用于计算的社保基数
            insFunVal = cityInsurance.basefunds;//用于计算的公积金基数
        //p_pay：个人缴纳  c_pay：公司缴纳  insuranceRate：保险税率 taxRate：纳税税率
        //个人养老
        var rate_p_pension = insuranceRate.p_pension || 0, cost_p_pension = keepTwoDecimal(rate_p_pension * 0.01 * insCalVal);
        detail.p_pay.pension = {
            //rate : keepTwoDecimal(cost_p_pension/salary*100),//个人养老比率
            rate :rate_p_pension,
            cost : cost_p_pension//个人养老缴费
        };
        pPayTotal = pPayTotal + cost_p_pension;
        //个人医疗
        var rate_p_medical = insuranceRate.p_medical || 0, cost_p_medical = keepTwoDecimal(rate_p_medical * 0.01 * insCalVal);
        detail.p_pay.medical = {
            //rate : keepTwoDecimal(cost_p_medical/salary*100),//个人医疗比率
            rate :rate_p_medical,
            cost : cost_p_medical//个人医疗缴费
        };
        pPayTotal = pPayTotal + cost_p_medical;
        //个人失业
        var rate_p_unemployed = insuranceRate.p_unemployed || 0, cost_p_unemployed = keepTwoDecimal(rate_p_unemployed * 0.01 * insCalVal);
        detail.p_pay.unemployed = {
            //rate : keepTwoDecimal(cost_p_unemployed/salary*100),//个人失业比率
            rate :rate_p_unemployed,
            cost : cost_p_unemployed//个人失业缴费
        };
        pPayTotal = pPayTotal + cost_p_unemployed;
        //个人住房
        var rate_p_housing = insuranceRate.p_housing || 0, cost_p_housing = hasHousing ? keepTwoDecimal(rate_p_housing * 0.01 * insFunVal) : 0;
        detail.p_pay.housing = {
            //rate : keepTwoDecimal(cost_p_housing/salary*100),//个人住房比率
            rate :rate_p_housing,
            cost : cost_p_housing//个人住房缴费
        };
        pPayTotal = pPayTotal + cost_p_housing;
        //公司缴纳保险
        //公司养老
        var rate_c_pension = insuranceRate.c_pension || 0, cost_c_pension = keepTwoDecimal(rate_c_pension * 0.01 * insCalVal);
        detail.c_pay.pension = {
            //rate : keepTwoDecimal(cost_c_pension/salary*100),//公司养老比率
            rate :rate_c_pension,
            cost : cost_c_pension//公司养老缴费
        };
        cPayTotal = cPayTotal + cost_c_pension;
        //公司医疗
        var rate_c_medical = insuranceRate.c_medical || 0, cost_c_medical = keepTwoDecimal(rate_c_medical * 0.01 * insCalVal);
        detail.c_pay.medical = {
            //rate : keepTwoDecimal(cost_c_medical/salary*100),//公司医疗比率
            rate :rate_c_medical,
            cost : cost_c_medical//公司医疗缴费
        };
        cPayTotal = cPayTotal + cost_c_medical;
        //公司失业
        var rate_c_unemployed = insuranceRate.c_unemployed || 0, cost_c_unemployed = keepTwoDecimal(rate_c_unemployed * 0.01 * insCalVal);
        detail.c_pay.unemployed = {
            //rate : keepTwoDecimal(cost_c_unemployed/salary*100),//公司失业比率
            rate :rate_c_unemployed,
            cost : cost_c_unemployed//公司失业缴费
        };
        cPayTotal = cPayTotal + cost_c_unemployed;
        //公司住房
        var rate_c_housing = insuranceRate.c_housing || 0, cost_c_housing = hasHousing ? keepTwoDecimal(rate_c_housing * 0.01 * insFunVal) : 0;
        detail.c_pay.housing = {
            //rate : keepTwoDecimal(cost_c_housing/salary*100),//公司住房比率
            rate :rate_c_housing,
            cost : cost_c_housing//公司住房缴费
        };
        cPayTotal = cPayTotal + cost_c_housing;
        //公司工伤
        var rate_c_injury = insuranceRate.c_injury || 0, cost_c_injury = keepTwoDecimal(rate_c_injury * 0.01 * insCalVal);
        detail.c_pay.injury = {
            //rate : keepTwoDecimal(cost_c_injury/salary*100),//公司工伤比率
            rate :rate_c_injury,
            cost : cost_c_injury//公司工伤缴费
        };
        cPayTotal = cPayTotal + cost_c_injury;
        //公司生育
        var rate_c_maternity = insuranceRate.c_maternity || 0, cost_c_maternity = keepTwoDecimal(rate_c_maternity * 0.01 * insCalVal);
        detail.c_pay.maternity = {
            //rate : keepTwoDecimal(cost_c_maternity/salary*100),//公司生育比率
            rate :rate_c_maternity,
            cost : cost_c_maternity//公司生育缴费
        };
        cPayTotal = cPayTotal + cost_c_maternity;
        //保险缴纳总额
        detail.pInsPay = keepTwoDecimal(pPayTotal);//个人保险缴纳总额
        detail.cInsPay = keepTwoDecimal(cPayTotal);//公司保险缴纳总额
        //个人所得税计算
        taxSal = salary - pPayTotal - taxThreshold;
        //小于0时不需要缴税
        var taxPro = {}, perTax = 0;
        if(taxSal > 0){
            for(var key in proLevel){
                var currPro = proLevel[key], salRan = currPro.salaryRange;
                if(taxSal > salRan[0] && (salRan[1] == 'more' || taxSal < salRan[1])){
                    taxPro = currPro;
                    break;
                }
            }
            perTax = taxSal * taxPro.taxRate * 0.01 - taxPro.DeductNumber;
        }else{
            taxSal = 0;
            taxPro = {
                salaryRange:0,
                taxRate:0,
                DeductNumber:0
            };
        }
        detail.taxLeval = taxPro;//缴税比例等级
        detail.needTaxMoney = keepTwoDecimal(taxSal < 0 ? 0 : taxSal);//需要缴税的钱
        detail.personTax = keepTwoDecimal(perTax < 0 ? 0 : perTax);//个人所得税
        detail.personTaxRate = salary <=0 ? 0 : keepTwoDecimal(detail.personTax/salary*100);//个人所得税所占比率
        var saAfTa = salary - pPayTotal - perTax;
        detail.salAfterTax = keepTwoDecimal(saAfTa <= 0 ? 0 : saAfTa);//个人税后月薪
        detail.salAfterRate = salary <=0 ? 0 : keepTwoDecimal(detail.salAfterTax/salary*100);//税后工资所占比率
        detail.hasHousing = hasHousing;//缴纳公积金为true，不缴纳公积金为false
        return detail;
    }
    //保留两位小数
    function keepTwoDecimal(val){
        if(typeof val == 'number'){
            return Math.floor(val * 100)/100;
        }else {
            return 0;
        }
    }

    //显示table
    function showDetail(salDetail){
        var personPay = salDetail.p_pay;
        var personallPay = salDetail.pInsPay;//个人五险一金综合
        var companyPay = salDetail.c_pay;
        var companyallPay = salDetail.cInsPay;
        var personPayTax = salDetail.personTax;
        var afterTax = keepTwoDecimal(salDetail.salary - personallPay);
        var actualSal = salDetail.salAfterTax;
        var takehomePay= keepTwoDecimal(salDetail.salary-salDetail.personTax-salDetail.pInsPay);// 实际工资
        // var supHouserate= $("#bcHouserate").val();
        // var supHousemoney= currCityObj.basefunds*(supHouserate.replace('%','')*1/100);
        var isHousing= salDetail.hasHousing;
        //默认隐藏table
        $("#gr_yl").text(personPay.pension.cost);
        $("#gr_yl_sl").text(personPay.pension.rate + "%");
        $("#gr_yiliao").text(personPay.medical.cost);
        $("#gr_yiliao_sl").text(personPay.medical.rate + "%");
        $("#gr_sy").text(personPay.unemployed.cost);
        $("#gr_sy_sl").text(personPay.unemployed.rate + "%");
        $("#gr_gjj").text(isHousing ? personPay.housing.cost : 0);
        $("#gr_gjj_sl").text(isHousing ? (personPay.housing.rate + "%") : 0);
        $("#gr_zzc").text(personallPay);
        $("#gs_yl").text(companyPay.pension.cost);
        $("#gs_yl_sl").text(companyPay.pension.rate + "%");
        $("#gs_yiliao").text(companyPay.medical.cost);
        $("#gs_yiliao_sl").text(companyPay.medical.rate + "%");
        $("#gs_sy").text(companyPay.unemployed.cost);
        $("#gs_sy_sl").text(companyPay.unemployed.rate + "%");
        $("#gs_gjj").text(isHousing ? companyPay.housing.cost : 0);
        $("#gs_gjj_sl").text(isHousing ? (companyPay.housing.rate + "%") : 0);
        $("#gs_gs").text(companyPay.injury.cost);
        $("#gs_gs_sl").text(companyPay.injury.rate + "%");
        $("#gs_shengyu").text(companyPay.maternity.cost);
        $("#gs_shengyu_sl").text(companyPay.maternity.rate + "%");
        $("#gs_zzc").text(companyallPay);//公司共支出
        $("#geshui").text(personPayTax);//个人所得税
        $("#sh_yx").text(afterTax);
        $("#sh_xz").text(actualSal);//个人税后薪资

        // if ($('#bcHouse').prop('checked')) {
            // $(".show_percent_factor_exgjj").text(supHouserate);
            // $("#show_personal_exgjj,#show_org_exgjj").text(supHousemoney);
        // }
    }
    //我的工资
    function afterSalary(salDetail){
        var dataSalary = [];
        //税后工资
        dataSalary.push({value:salDetail.salAfterTax, name:'税后工资 ' + salDetail.salAfterTax});
        //个人所得税
        dataSalary.push({value:salDetail.personTax, name:'个人所得税 ' + salDetail.personTax});
        //五险一金
        dataSalary.push({value:salDetail.pInsPay, name:'五险一金 ' + salDetail.pInsPay});

        var option = {
            title : {
                text: ' 我的工资 ',
                x:'center',
                y:'20px'
            },
            tooltip : {
                trigger: 'item',
                // formatter: "{a} <br/>{b} : {c} ({d}%)"
                formatter:function(params, ticket, callback){
                    return (params.name.replace(/[\d\.]/g, '') + ' : '+ params.value);
                }
            },
            toolbox: {
                show : false
            },
            color : ["#ffd700", "#6699FF","#ff6666","#b8860b"],
            series : [
                {
                    name:'我的工资',
                    type:'pie',
                    radius : '55%',
                    center: ['52%', '52%'],//水平 垂直
                    data: dataSalary
                }
            ]
        };
        // 基于准备好的dom，初始化ECharts图表
        var personChart = echarts.init(document.getElementById('person_after_pie'));
        // 为ECharts对象加载数据
        personChart.clear();
        personChart.setOption(option);
    }

    //个人薪资详情饼图
    function personDetail(salDetail){
        var dataSalary = [];
        //税后工资
        dataSalary.push({value:salDetail.salAfterTax, name:'税后工资' + salDetail.salAfterRate + '%'});
        //养老保险金
        var p_pen = salDetail.p_pay.pension;
        dataSalary.push({value:p_pen.cost, name:'养老保险金' + (p_pen.rate) + '%'});
        //医疗保险金
        var p_med = salDetail.p_pay.medical;
        dataSalary.push({value:p_med.cost, name:'医疗保险金' + (p_med.rate) + '%'});
        //失业保险金
        var p_une = salDetail.p_pay.unemployed;
        dataSalary.push({value:p_une.cost, name:'失业保险金' + (p_une.rate) + '%'});
        //住房保险金
        var p_hou = salDetail.p_pay.housing;
        dataSalary.push({value:p_hou.cost, name:'住房保险金' + (p_hou.rate) + '%'});
        //个人所得税
        dataSalary.push({value:salDetail.personTax, name:'个人所得税' + (salDetail.personTaxRate) + '%'});
        var option = {
            title : {
                text: '个人薪资详情',
                x:'center',
                y:'50px'
            },
            tooltip : {
                trigger: 'item',
                // formatter: "{a} <br/>{b} : {c} ({d}%)"
                formatter: "{a} <br/>{b} : {c}"
            },
            toolbox: {
                show : false
            },
            color : ["#ff7f50","#87cefa","#da70d6","#32cd32","#6495ed","#ff69b4","#ba55d3","#cd5c5c","#ffa500","#40e0d0","#1e90ff","#ff6347","#7b68ee","#00fa9a","#ffd700","#6699FF","#ff6666"],
            series : [
                {
                    name:'个人薪资详情',
                    type:'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data: dataSalary
                }
            ]
        };
        // 基于准备好的dom，初始化ECharts图表
        var personChart = echarts.init(document.getElementById('person_detail_pie'));
        // 为ECharts对象加载数据
        personChart.clear();
        personChart.setOption(option);
    }
    //单位成本详情饼图
    function companyDetail(salDetail){
        var dataSalary = [];
        //税后工资
        dataSalary.push({value:salDetail.salAfterTax, name:'税后工资' + salDetail.salAfterRate + '%'});
        //养老保险金
        var c_pen = salDetail.c_pay.pension;
        dataSalary.push({value:c_pen.cost, name:'养老保险金' + (c_pen.rate) + '%'});
        //医疗保险金
        var c_med = salDetail.c_pay.medical;
        dataSalary.push({value:c_med.cost, name:'医疗保险金' + (c_med.rate) + '%'});
        //失业保险金
        var c_une = salDetail.c_pay.unemployed;
        dataSalary.push({value:c_une.cost, name:'失业保险金' + (c_une.rate) + '%'});
        //住房保险金
        var c_hou = salDetail.c_pay.housing;
        dataSalary.push({value:c_hou.cost, name:'住房保险金' + (c_hou.rate) + '%'});
        //工伤保险金
        var c_inj = salDetail.c_pay.injury;
        dataSalary.push({value:c_inj.cost, name:'工伤保险金' + (c_inj.rate) + '%'});
        //生育保险金
        var c_mate = salDetail.c_pay.maternity;
        dataSalary.push({value:c_mate.cost, name:'生育保险金' + (c_mate.rate) + '%'});
        //个人所得税
        dataSalary.push({value:salDetail.personTax, name:'个人所得税' + (salDetail.personTaxRate) + '%'});
        var option = {
            title : {
                text: '单位成本动向',
                x:'center',
                y:'50px'
            },
            tooltip : {
                trigger: 'item',
                // formatter: "{a} <br/>{b} : {c} ({d}%)"
                formatter: "{a} <br/>{b} : {c}"
            },
            toolbox: {
                show : false
            },
            color : ["#32cd32","#6495ed","#ff69b4","#ba55d3","#cd5c5c","#ffa500","#7b68ee","#00fa9a","#ffd700","#6699FF","#ff6666","#3cb371","#30e0e0"],
            series : [
                {
                    name:'税前工资去向',
                    type:'pie',
                    radius : '55%',
                    center: ['50%', '60%'],
                    data: dataSalary
                }
            ]
        };
        // 基于准备好的dom，初始化ECharts图表
        var personChart = echarts.init(document.getElementById('company_detail_pie'));
        // 为ECharts对象加载数据
        personChart.clear();
        personChart.setOption(option);
    }
    // 鼠标提示效果
    $("#thresholdTip").hover(function(){
        $(this).siblings("p").css("display","block");
    },function(){
        $(this).siblings("p").css("display","none");
    });
    function get_rate(rate){
        var output = "";
        var width = 0;
        if(rate <= 2000){
            output =  "温饱";
            width = 28;
        }
        else if(rate <= 4000){
            output = "小康";
            width = 56;
        }
        else if(rate <= 6000){
            output = "殷实";
            width = 84;
        }
        else if(rate <= 15000){
            output = "准土豪";
            width = 112;
        }
        else{
            output = "土豪";
            width = 140;
        }
        $("#s").text(output);
        $(".big_rate_up").animate({width:width,height:26},1000);
    }
    // 同城职位推荐
    function posRecommend (cityId, salary) {
        $.ajax({
            url:'//www.zhaopin.com/gz_www/job/query/?city='+cityId +'&salary='+salary,
            type:'GET',
            dataType:'json',
            success:function(data){
                if (data.Code == 200) {
                    var posList="<ul class='clearfix'>";
                    for (var i=0; i<data.Data.length;i++) {
                        var pos=data.Data[i];
                        posList+='<li><a href="'+pos.Url+'" target="_blank">'+pos.Name+'</a><span>'+ pos.Salary+'</span></li>';
                    };
                    posList+='</ul>';
                    $(".positionlist").html(posList);
                    $(".rec-job").css("display","block")
                };
            }
        });
    }
    // 按首字母查找城市
    $("#options span").mouseover(function() {
        var index = $(this).index();
        $(this).css({ backgroundColor: "#689fee", color: "#fff" }).siblings().css({ backgroundColor: "#eff6ff", color: "#4d4d4d" });
        $(this).click(function() {
            $("#cityOptions ul").eq(index).show().siblings().hide();
        });
    });
    //更多选项显示隐藏
    /*$("#more").click(function() {
        $("#morebox").toggle();
    });*/
    $('.salbox .more').hide();
    $('.morebox .moretext').hide();
    $("#morebox").show();
    //重新计算
    $("#reset").click(function() {
        $("#salText").val("");
        $(".pie-chart").css("display", "none");
        $(".my-salary").css("display", "none");
        $("#detail-tables").css("display", "none");
        $("#afundsBase").val(initValAfunds);
        $("#socialBase").val(initValSocial);
    });
});


