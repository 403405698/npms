window.joForm = {};//表单页面对象,存放表单页面的相关信息和操作
//表单页面对象相关属性
/**
 * ***初始化相关回调
 * init 初始化,此时仅仅更新完成joForm参数
 * initFormPageBefore 初始化页面前置操作,此时页面已经确定是否为新增
 * initFormPageUrl 初始化页面相关url参数
 * initFormPageOfAdd 初始化新增页面操作(在初始化按钮前)
 * initFormValueAfter(formData) 初始化表单值后置操作(此时已经获取到表单数据)
 * initFormValueBefore(oJson) 初始化表单值前置操作,在只读处理前
 * ***新增/修改相关回调
 * dealDataAtSaveBefore(oData) 新增前置处理,参数为表单数据
 * dealDataAtUpdateBefore(oData) 修改前置处理
 * checkForm(form) 表单验证,新增和修改共用,参数为表单jq对象
 * saveSuccessAfter(result) 新增成功后处理回调函数,参数为后台返回结果
 * updateSuccessAfter(result) 修改成功后的处理回调
 ***删除相关回调
 * delSuccessAfter(result) 删除成功后的处理回调函数
 */
/**
 * 表单页面的参数,key/value的形式
 * 包括: 1.地址栏传递的参数; 2.表单页面相关url等参数
 * 通常在表单页面进行添加操作,禁止直接覆盖该参数
 */
joForm.params = {
    /*"formObj" 页面的[表单对象],可以在页面进行赋值,默认为id=pageForm的表单*/
    "PKName" : "ID",//主键
    "PKValue" : "",//[主键]的值,通常从url传递
    "saveAfter" : "close",//新增数据后的操作,close表示关闭窗口(默认),toEdit表示跳转编辑
    "addUrl" : "",//[新增]数据的url
    "deleteUrl" : "",//[删除]数据的url
    "updateUrl" : "",//[修改]数据]的url
    "formDataUrl" : ""//[获取数据]的url
};
/**
 * 为joForm.params添加参数
 */
joForm.putParam = function(sKey,sValue){
    joForm.params[sKey] = sValue;
};
/**
 * 为joForm.params添加多个参数
 */
joForm.putParams = function(sParams){
    joForm.params = $.extend({},joForm.params, sParams);
};
/**
 * 表单数据
 * 包括: 1.表单编辑时获取到的信息的数据
 */
joForm.formData = {};
formAuditData = {};
/*
 * 表单状态是否是新增
 */
joForm.isAdd = true;
/*
 * 表单jq对象
 */
joForm.form = null;
/**
 * 表单页面入口: 初始化表单页面
 */
joForm.initFormPage = function(oParams){
    var idx = jo.showMsg('加载中...', {
        icon: 16
        ,shade: 0.01
        ,time: 0
        ,area: "200px"
        ,offset: "rb"
    });
    if(jo.isValid(oParams) && typeof(oParams) == "object"){
        joForm.putParams(oParams);
    }
    if(typeof(joForm.init) == "function"){joForm.init()}
    //获取location携带的参数,并存入params中,方便调用
    joForm.putParams(jo.getUrlParams());
    //初始化表单对象
    if(!jo.isValid(joForm.params["formObj"])){//表单对象无效的话,默认表单对象为$("#pageForm)
        joForm.putParam("formObj",jo._("#pageForm"));
        joForm.form = $("#pageForm");
    }else{
        joForm.form = $(joForm.params["formObj"]);
    }
    //获取表单状态
    var sPKName = jo.getDefVal(joForm.params["PKName"],"ID");//主键名
    var sID = jo.getUrlParam(sPKName);//获取主键的值
    if(jo.isValid(sID)){
        joForm.isAdd = false;
        joForm.putParam(sPKName,sID);//将主键存入joForm.params属性,方便调用
        joForm.putParam("PKValue",sID);//存入主键值,方便逻辑调用
    }else{
        joForm.isAdd = true;
    }
    //初始化页面前操作,托管函数,页面实现此方法即可在初始化前做操作
    if(typeof(joForm.initFormPageBefore) == "function"){joForm.initFormPageBefore();}
    //初始化页面操作的url
    if(typeof(joForm.initFormPageUrl) == "function"){joForm.initFormPageUrl();}
    //初始化表单
    if(joForm.isAdd){//新增
        if(typeof(joForm.initFormPageOfAdd) == "function"){joForm.initFormPageOfAdd();}
        //初始化按钮
        joForm.initFormPageBtn();
    }else{//编辑
        joForm.getFormData();//获取表单数据
        //初始化按钮,放在获取值之后进行,方便根据表单值空值按钮显示
        joForm.initFormPageBtn();
        //if(typeof(joForm.initFormValueBefore) == "function"){joForm.initFormValueBefore();}//初始化表单值前置函数,放在initFormValue里回调
        joForm.initFormValue();//初始化表单数据,默认表单id为pageForm,数据为formData
        //if(typeof(joForm.initFormValueAfter) == "function"){joForm.initFormValueAfter(joForm.formData);}//初始化表单值后置函数,放在initFormValue里回调
    }
    //处理只读属性
    joForm.handleReadOnly();
    jo.showMsg('加载完成', {
        icon: 1
        ,shade: 0
        ,time: 1500
        ,area: "200px"
        ,offset: "rb"
    });
};
/**
 * 处理readonly
 * readonly-add : 表单在新增时该项为只读
 * readonly-edit : 表单在编辑时该项为只读
 * readonly : 该项恒是只读,common.js中页面加载完自动处理readonly
 */
joForm.handleReadOnly = function(){
    if(joForm.isAdd){
        //新增时只读
        joForm.form.find(".readonly-add").each(function(element,index){
            $(this).attr("readonly",true);
        });
        /*$(".readonly-add input").each(function(element,index){
            $(element).attr("readonly","readonly");
            //$(this).attr("disabled",true);
        });*/
    }else{
        //编辑时只读
        joForm.form.find(".readonly-edit").each(function(element,index){
            $(this).attr("readonly",true);
        });
        /*$(".readonly-edit input").each(function(element,index){
            $(this).attr("readonly","readonly");
            //$(this).attr("disabled",true);
        });*/
    }
};
/**
 * 初始化表单页面的操作url,增删改查等url
 */
joForm.initFormPageUrl = function(){

};
/**
 * 初始化表单按钮
 */
joForm.initFormPageBtn = function(){
    $(".button-bar>button[isShow]").each(function(index,element){
        var isShow = $(this).attr("isShow");
        //当返回false或'false'时才隐藏,isShow为空时也隐藏
        if(joForm.execCode(isShow) == false || joForm.execCode(isShow) == 'false'){
            $(this).hide();
        }else{
            $(this).show();
        }
    });
};
/**
 * 执行代码
 */
joForm.execCode = function(sCode,paramArr){
    if(jo.isValid(sCode)){//待执行代码的有效性
        //替换变量
        var reg = /\{[a-zA-Z0-9_]*\}/g;
        if(reg.test(sCode)){
            var a = sCode.match(reg);
            if(!jo.isValid(paramArr)){
                paramArr = $.extend({},joForm.params, joForm.formData);//默认参数来源为表单页面的参数集与表单参数
            }
            for(var i=0;i<a.length;i++){
                var x = a[i]+"";
                var key = x.substring(1,x.length-1);
                sCode = sCode.replace(x,paramArr[key]);
            }
        }
        return eval(sCode);
    }else{
        return false;
    }
};
/**
 * 获取表单数据
 */
joForm.getFormData = function(){
    var sUrl = joForm.params["formDataUrl"];
    var PKName = (joForm.params["PKName"]);
    var PKValue = (joForm.params["PKValue"]);
    var sData = {};
    sData[PKName] = PKValue;
    var result = jo.postAjax(sUrl,sData);//JSON.stringify(sData)正式库的信息
    var auditData = jo.postAjax("pms/auditPmsSelfEvaluation/getUserAuditInfo",{"id":PKValue});
    if(result != null && result.data.length > 0 && result.data[0]){
        joForm.formData = result.data[0];//存放到form.formData,方便调用
    }else{
        joForm.formData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
    }

    if(auditData != null && auditData.data.length > 0 && auditData.data[0]){
        formAuditData = auditData.data[0];//存放到form.formData,方便调用
    }else{
        formAuditData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
    }


};
/**
 * 初始化表单值,默认文本框的id和name是一样的
 * 默认表单id为pageForm
 * 默认json数据为joForm.formData
 */
joForm.initFormValue = function(oForm,oJson){
    if(!jo.isValid(oForm)){
        oForm = jo.getDefVal(joForm.params["formObj"],jo._("#pageForm"));
    }
    if(!jo.isValid(oJson)){
        oJson = joForm.formData;
    }

    //初始化表单值之前的自定义操作
    if(typeof(joForm.initFormValueBefore) == "function"){
        joForm.initFormValueBefore(oJson);
    }

    //新改：在此处理拼接状态显示：start
    var elements = document.getElementById("pageForm").elements;
    for (var i=0;i<elements.length;i++) {
        var element = $(elements[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        for (var f=0;f<formAuditData.length;f++) {
                //后面拼接一下锁定状态显示和审核状态显示 start
                //去除隐藏的input标签
                if (element.attr("type") != "hidden")  {
                    //锁定状态拼接start
                    var status_html = "";
                    if (formAuditData["lockStatus"] == 1) {
                        status_html += "<span class=\"input-group-addon\">";
                        status_html += "<span style='color:red'>已锁定</span>";
                        status_html += "</span>";
                        //锁定不可编辑
                        element.attr("disabled",true);
                    }
                    //锁定状态拼接end
                    status_html += "<span class=\"input-group-addon\">";
                    if (formAuditData["status"] == 1) {
                        status_html += "<span style='color:green'>已通过</span>";
                    }
                    else if (formAuditData["status"] == 2) {
                        status_html += "<span style='color:red'>未通过</span>";
                    }
                    else {
                        status_html += "<span style='color:blue'>待审核</span>";
                    }
                    status_html += "</span>";
                    element.after(status_html);
                }
                //后面拼接一下锁定状态显示和审核状态显示 end
        }
    }
    //处理状态显示end

    var names = new Array();//存放输入框name
    var inp = oForm.find("input[type!='button'][type!='radio'][type!='checkbox'][type!='file']");//文本框
    for(var i=0;i<inp.length;i++){
        //获取name
        var element = $(inp[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        //存在此参数(包括后台返回的为空字符或者null)则赋值,
        //此条件比isValid更合适,对数据不做强制要求;并且兼容默认值的情况,因为后台如果没传值,则不会对此表单元素做处理
        if(typeof (oJson[key]) != "undefined"){
            element.val(oJson[key]);//赋值
            for (var f=0;f<formAuditData.length;f++) {
                if (oJson[key] != formAuditData[f][key]) {
                    element.val(formAuditData[f][key]);
                    element.attr("readonly",true);
                }
            }

        }
    }
    //处理radio---------begin
    var radio = oForm.find("input[type='radio']");
    //radio数组name属性去重
    var nameArr = new Array();//存放结果数组
    var oHash = {};//判断是否发生重复
    for(var i=0;i<radio.length;i++){
        var element = $(radio[i]);
        var name = jo.getDefVal(element.attr("name"),"");
        if(jo.isValid(name)){
            if(jo.isValid(oHash[name])){
                //该name在hash里面存在,则发生重复,无操作
            }else{
                nameArr.push(name);//存入结果数组
                oHash[name] = "1";//记录hash,判断是否重复
            }
        }
    }
    for(var i=0;i<nameArr.length;i++){
        var name = nameArr[i];
        var val = jo.getDefVal(oJson[name],"");
        if(jo.isValid(val)){
            $("input[type='radio'][name='"+name+"'][value='"+val+"']").attr("checked","checked");
        }
    }
    //处理radio---------end
    var checkbox = oForm.find("input[type='checkbox']");
    //获取表单checkbox控件,即从所有的checkbox中去重(name相同是算一个控件),和radio类似
    var nameArr2 = new Array();//存放结果数组
    var oHash2 = {};//判断是否发生重复
    for(var i=0;i<checkbox.length;i++){
        var element2 = $(checkbox[i]);
        var name2 = jo.getDefVal(element2.attr("name"),"");
        if(jo.isValid(name2)){
            if(jo.isValid(oHash2[name2])){
                //该name在hash里面存在,则发生重复,无操作
            }else{
                nameArr2.push(name2);//存入结果数组
                oHash2[name2] = "1";//记录hash,判断是否重复
            }
        }
    }
    //赋值
    for(var i=0;i<nameArr2.length;i++){
        var _name = nameArr2[i];
        var _val = jo.getDefVal(oJson[_name],"");
        if(jo.isValid(_val)){
            //将多选框的值分割,循环赋给对应的checkbox
            var _vals = _val.split(",");
            for(var j=0;j<_vals.length;j++){
                var _v = _vals[j];
                $("input[type='checkbox'][name='"+_name+"'][value='"+_v+"']").attr("checked","checked");
            }
        }
    }
    //**处理checkbox----------begin

    //**处理checkbox----------end

    var sel = oForm.find("select");//下拉列表
    for(var i=0;i<sel.length;i++){
        //获取name
        var element = $(sel[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        //element.val(oJson[key]);//赋值
        if(typeof (oJson[key]) != "undefined"){
            element.val(oJson[key]);//赋值
        }
    }

    //jo下拉列表组件异步回显处理--通过调用setValue来赋值
    var joSel = oForm.find(".joSelect");
    for(var i=0;i<joSel.length;i++){
        var element = joSel[i];//元素
        var key = jo.getDefVal(element.getAttribute("name"), element.getAttribute("id"));
        if(typeof (oJson[key]) != "undefined"){
            var joSId = jo.getDefVal(element.getAttribute("id"), element.getAttribute("name"));//jo组件id
            var jos = JoSelectTool[joSId];//jo下拉对象
            if(jos){
                jos.setValue(oJson[key]);//安全的赋值方法
            }
        }
    }

    var area = oForm.find("textarea");//文本域
    for(var i=0;i<area.length;i++){
        //获取name
        var element = $(area[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        //element.val(oJson[key]);//赋值
        if(typeof (oJson[key]) != "undefined"){
            element.val(oJson[key]);//赋值
            for (var f=0;f<formAuditData.length;f++) {
                if (oJson[key] != formAuditData[f][key]) {
                    element.val(formAuditData[f][key]);
                    element.attr("readonly",true);
                }
            }
        }
    }

    //初始化值后置操作
    if(typeof(joForm.initFormValueAfter) == "function"){joForm.initFormValueAfter(oJson);}
};
/**
 * 新增:保存表单数据
 */
joForm.save = function(sUrl,callBack){
    sUrl = jo.getDefVal(sUrl,joForm.params["addUrl"]);
    if(jo.isValid(sUrl)){
        if(!joForm.isAdd){
            jo.showMsg("表单状态异常:joForm.isAdd="+joForm.isAdd);
        }else{
            var oData = jo.form2Json(joForm.params["formObj"]);
            //保存前对表单数据的处理
            if(typeof(joForm.dealDataAtSaveBefore) == "function"){
                joForm.dealDataAtSaveBefore(oData);
            }
            //表单验证
            if(typeof (joForm.checkForm) == "function"){
                if(!joForm.checkForm(joForm.form)){
                    return;
                }
            }else{
                if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                    return;
                }
            }
            jo.postAjax(sUrl,oData, function(result){
                if(result.code == 0){
                    if(typeof(callBack) == "function"){//回调
                        callBack(result);
                    }else if(typeof(joForm.saveSuccessAfter) == "function"){
                        joForm.saveSuccessAfter(result);
                    }else{

                        try{
                            window.parent.reloadCurrentPage();//重新加载父页面数据
                        }catch(err){}
                        if(joForm.params["saveAfter"] == "toEdit"){//保存之后的操作,toEdit表示去编辑
                            if(jo.isValid(oData[joForm.params["PKName"]])){
                                window.location.href = window.location.href+jo.getLinkSign(window.location.href)+joForm.params["PKName"]+"="+oData[joForm.params["PKName"]];
                            }else{
                                jo.closeSelf('WIN_ADD');
                                //window.parent.jo.close("WIN_ADD");
                            }
                        }else{
                            window.parent.jo.close('WIN_ADD');
                        }
                        window.parent.jo.showMsg("保存成功!");
                    }
                }else{
                    jo.showMsg(result.info)
                }
            });

        }
    }else{
        jo.showMsg("{addUrl}无效!");
    }
};
/**
 * 删除该条数据
 */
joForm.del = function(sUrl){
    sUrl = jo.getDefVal(sUrl,joForm.params["deleteUrl"]);
    if(jo.isValid(sUrl)){
        jo.confirm("确定删除该数据吗?", function(){
            if(joForm.isAdd){
                jo.showMsg("表单状态异常:joForm.isAdd="+joForm.isAdd);
            }else{
                var ids = joForm.params["PKValue"];
                var oData = {"ids":ids};
                jo.postAjax(sUrl,oData, function(result){
                    if(result.code == 0){
                        if(typeof(joForm.delSuccessAfter) == "function"){
                            joForm.delSuccessAfter(result);
                        }else{
                            window.parent.jo.close("WIN_EDIT");
                            window.parent.jo.showMsg("删除成功!");
                            window.parent.reloadCurrentPage();//重新加载父页面数据
                        }
                    }else{
                        jo.showMsg(result.info)
                    }
                });

            }
        });
    }else{
        jo.showMsg("{deleteUrl}无效!");
    }
};
/**
 * 修改数据
 */
joForm.update = function(sUrl){
    sUrl = jo.getDefVal(sUrl,joForm.params["updateUrl"]);
    if(jo.isValid(sUrl)){
        if(joForm.isAdd){
            jo.showMsg("表单状态异常:joForm.isAdd="+joForm.isAdd);
        }else{
            var pData = jo.form2Json(joForm.params["formObj"]);//使用新方法(现在数据和历史对比)，判断哪些被真正更改了
        /*    var oForm = jo.getDefVal(joForm.params["formObj"],jo._("#pageForm"));
            var inp = oForm.find("input[type!='button'][type!='radio'][type!='checkbox'][type!='file']");//文本框
            var pData = {};
            var PKName = (joForm.params["PKName"]);
            var PKValue = (joForm.params["PKValue"]);
            pData[PKName] = PKValue;
            for(var i=0;i<inp.length;i++){
                var element = $(inp[i]);
                var key = jo.getDefVal(element.attr("name"),element.attr("id"));
                if(typeof (newData[key]) != "undefined"){
                    if (key != "deptIds") {
                        // console.log("newData[key] != joForm.formData[key]" + newData[key] + "   " +joForm.formData[key])
                        if (newData[key] != joForm.formData[key]) {
                            pData[key] = newData[key];
                        }}
                    }
                }

*/
            //修改前对表单数据的处理
            if(typeof(joForm.dealDataAtUpdateBefore) == "function"){
                joForm.dealDataAtUpdateBefore(oData);
            }
            //表单验证
            if(typeof (joForm.checkForm) == "function"){
                joForm.checkForm(joForm.form);
            }else{
                if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                    return;
                }
            }
            jo.postAjax(sUrl,pData, function(result){
                if(result.code == 0){
                    if(typeof(joForm.updateSuccessAfter) == "function"){
                        joForm.updateSuccessAfter(result);
                    }else{
                        window.parent.jo.showMsg("修改成功!");
                        window.parent.reloadCurrentPage();//重新加载父页面数据
                        window.location.reload();
                    }
                }else{
                    jo.showMsg(result.info)
                }
            });

        }
    }else{
        jo.showMsg("{updateUrl}无效!");
    }
};