window.joForm = {};//表单页面对象,存放表单页面的相关信息和操作
/* 此文件为新工具
简单公共统一操作，如果有扩展，额外加
审核类的用此文件*/
joForm.params = {
    /*"formObj" 页面的[表单对象],可以在页面进行赋值,默认为id=pageForm的表单*/
    "PKName" : "ID",//主键
    "auditPKName" : "ID",//用于获取审核库数据时用到的主键
    "PKValue" : "",//[主键]的值,通常从url传递
    "saveAfter" : "close",//新增数据后的操作,close表示关闭窗口(默认),toEdit表示跳转编辑
    "addUrl" : "",//[新增]数据的url
    "deleteUrl" : "",//[删除]数据的url
    "updateUrl" : "",//[修改]数据]的url
    "formDataUrl" : "",//[获取正式库数据]的url
    "auditDataUrl" : "",//审核库中的数据URL
    "changeStateUrl" : "",//改变审核状态URL
    "auditUpdateUrl" : "",//[修改]数据]的url
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
joForm.formData = {};//正式库信息
formAuditData = {};//审核库信息
tempComData = {};//审核库信息
var auditPhotoAddress;//对照片特殊赋值
var userName;//姓名
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
/*    var idx = jo.showMsg('加载中...', {
        icon: 16
        ,shade: 0.01
        ,time: 0
        ,area: "200px"
        ,offset: "rb"
    });*/
    if(jo.isValid(oParams) && typeof(oParams) == "object"){
        joForm.putParams(oParams);
    }
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
    //初始化表单
    if(joForm.isAdd){//新增
        if(typeof(joForm.initFormPageOfAdd) == "function"){joForm.initFormPageOfAdd();}
        //初始化按钮
        joForm.initFormPageBtn();
    }else{//编辑
        joForm.getFormData();//获取表单数据
        //初始化按钮,放在获取值之后进行,方便根据表单值空值按钮显示
        joForm.initFormPageBtn();
        joForm.initFormValue();//初始化表单数据,默认表单id为pageForm,数据为formData

    }
    // tempComData = jo.form2Json(joForm.params["formObj"]);

    // tempComData = $("#pageForm").serialize();
/*    jo.showMsg('加载完成', {
        icon: 1
        ,shade: 0
        ,time: 1500
        ,area: "200px"
        ,offset: "rb"
    });*/
};
/**
 * 初始化表单按钮
 */
joForm.initFormPageBtn = function(){
    $("button[isShow]").each(function(index,element){
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
    var aUrl = joForm.params["auditDataUrl"];
    var PKName = (joForm.params["PKName"]);
    var PKValue = (joForm.params["PKValue"]);
    var sData = {};
    sData[PKName] = PKValue;
    var result = jo.postAjax(sUrl,sData);
    var auditPKName = (joForm.params['auditPKName']);
    var aData = {};
    aData[auditPKName] = PKValue;
    var auditData = jo.postAjax(aUrl,aData);//获取所有，不加限制条件startus=5
    if(result != null && result.data.length > 0 && result.data[0]){
        joForm.formData = result.data[0];//存放到form.formData,方便调用
    }else{
        joForm.formData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
    }
    if(auditData.data[0] != null){
        formAuditData = auditData.data[0];//存放到form.formData,方便调用
    }else{
        formAuditData = {};//当没有查找到对应数据时,创建空对象,避免之后赋值阶段报错
    }
};
/**
 * 初始化表单值,默认文本框的id和name是一样的
 * 默认表单id为pageForm
 * 默认json数据为正式库
 */
joForm.initFormValue = function(oForm,oJson){
    if(!jo.isValid(oForm)){
        oForm = jo.getDefVal(joForm.params["formObj"],jo._("#pageForm"));//$("#pageForm");
    }
    if(!jo.isValid(oJson)){
        oJson = joForm.formData;//正式库信息，不带有状态，日后可以悬浮提示等扩展
        // oJson = formAuditData;//审核库中的信息，带有状态
    }
    //TODO  对复选框赋值start  条目ID锁定状态审核状态等，暂且只赋值ID
    var checkbox = oForm.find("input[type='checkbox']");
    for(var i=0;i<checkbox.length;i++){
        var element = $(checkbox[i]);
        var key = element.attr("cname");//自定义的属性
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]){
                element.attr("value",formAuditData[f]["id"]);
                element.attr("status",formAuditData[f]["auditStatus"]);
            }
        }

    }
    //对复选框赋值 end
    if(typeof(joForm.spliceStatus) == "function"){joForm.spliceStatus(formAuditData);}
    //在此处理拼接状态显示：start
/*    var elements = document.getElementById("pageForm").elements;
    for (var i=0;i<elements.length;i++) {
        var element = $(elements[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]){//找到同name
                //后面拼接一下锁定状态显示和审核状态显示 start
                console.log("审核状态："  + formAuditData[f]["auditStatus"] + "锁定状态：" + formAuditData[f]["lockStatus"]);
                //去除隐藏的input标签
                if (element.attr("type") != "hidden")  {
                    //锁定状态拼接start
                    var status_html = "<span class=\"iconfont show\">";
                    if (formAuditData[f]["lockStatus"] == 1) {
                        status_html += "<i class=\"iconfont icon-suoding\"></i>";
                    }
                    //锁定状态拼接end
                    if (formAuditData[f]["auditStatus"] == 1) {
                        status_html += "<i class=\"iconfont icon-duihao\"></i>";
                    }
                    else if (formAuditData[f]["auditStatus"] == 2) {
                        status_html += "<i class=\"iconfont icon-error\"></i>";
                    }
                    else {
                        //待审核
                        status_html += "<i class=\"iconfont icon-smenu\"></i>";
                    }
                    status_html += "</span>";
                    element.after(status_html);
                }
                //后面拼接一下锁定状态显示和审核状态显示 end
            }

        }
    }
    //对img单独处理
    //新增：处理img start
    var img = oForm.find("img");
    console.log("拼接IMG");
    for(var i=0;i<img.length;i++) {
        var element = $(img[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        console.log("拼接IMG：key:" + key);
        for (var f=0;f<formAuditData.length;f++) {
            if ("photoAddress" == formAuditData[f]["fieldKey"]) {//找到同name
                if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                    var status_html = "<span class=\"iconfont show\" style=\"right: 0;position: absolute;bottom: -30px\">";
                    if (formAuditData[f]["lockStatus"] == 1) {
                        status_html += "<i class=\"iconfont icon-suoding\"></i>";
                    }
                    if (formAuditData[f]["auditStatus"] == 1) {
                        status_html += "<i class=\"iconfont icon-duihao\"></i>";
                    }
                    else if (formAuditData[f]["auditStatus"] == 2) {
                        status_html += "<i class=\"iconfont icon-error\"></i>";
                    }
                    else {
                        status_html += "<i class=\"iconfont icon-smenu\"></i>";
                    }
                    status_html += "</span>";
                    element.after(status_html);
                    console.log("img结束！");
                }
            }
        }
    }*/
    //处理img end
    //处理状态显示end

    var inp = oForm.find("input[type!='button'][type!='radio'][type!='checkbox'][type!='file']");//文本框
    for(var i=0;i<inp.length;i++){
        //获取name
        var element = $(inp[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        if (formAuditData.length < 1) {
            //TODO 新增，对通讯信息为新增时，移除disabled
            element.removeAttr("disabled");
        }
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]){
                element.val(formAuditData[f]["fieldVal"]);//使用审核库数据，
                tempComData[key] = formAuditData[f]["fieldVal"];//TODO new
                if (key == "photoAddress") {
                    if (typeof (formAuditData[f]["fieldVal"]) != "undefined") {
                        auditPhotoAddress = formAuditData[f]["fieldVal"];
                    }
                }
                if (key == "userName") {
                    if (typeof (formAuditData[f]["fieldVal"]) != "undefined") {
                        userName = formAuditData[f]["fieldVal"];
                    }
                }
            }
        }
            //新改：重新赋值一遍，新用户提交时审核库中没有ID和userid start
            if (key == "id" || key == "userId") {
                element.val(oJson[key]);//赋值
                tempComData[key] = oJson[key];//TODO new
            }
            if (formAuditData.length < 1) {
                element.val(oJson[key]);//赋值
            }
            //新改：新用户提交时不包含ID和userid end
    }

    //
    var sel = $("#pageForm").find("select");//下拉列表
    for(var i=0;i<sel.length;i++){
        //获取name
        var element = $(sel[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        /*                if(typeof (oJson[key]) != "undefined"){
                            element.val(oJson[key]);//赋值
                        }*/
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]) {//找到同name\
                if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                    element.val(formAuditData[f]["fieldVal"]);//赋值
                    tempComData[key] = formAuditData[f]["fieldVal"];//TODO new
                    layui.use('form', function() {
                        var form = layui.form;
                        form.render();
                    });
                }
            }
        }
    }
    //
    //jo下拉列表组件异步回显处理--通过调用setValue来赋值
    var joSel = oForm.find(".joSelect");
    for(var i=0;i<joSel.length;i++){
        var element = joSel[i];//元素
        var key = jo.getDefVal(element.getAttribute("name"), element.getAttribute("id"));
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]) {//找到同name\
                if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                    var joSId = jo.getDefVal(element.getAttribute("id"), element.getAttribute("name"));//jo组件id
                    var jos = JoSelectTool[joSId];//jo下拉对象
                    if(jos){
                        jos.setValue(formAuditData[f]["fieldVal"]);//安全的赋值方法
                        tempComData[key] = formAuditData[f]["fieldVal"];//TODO new
                    }
                    layui.use('form', function() {
                        var form = layui.form;
                        form.render();
                    });
                }
            }
        }
    }
    //下拉列表end

    //文本域start
    var area = oForm.find("textarea");
    for(var i=0;i<area.length;i++){
        //获取name
        var element = $(area[i]);
        var key = jo.getDefVal(element.attr("name"),element.attr("id"));
        for (var f=0;f<formAuditData.length;f++) {
            if (key == formAuditData[f]["fieldKey"]) {//找到同name
                if(typeof (formAuditData[f]["fieldVal"]) != "undefined"){
                    element.val(formAuditData[f]["fieldVal"]);//赋值
                    tempComData[key] = formAuditData[f]["fieldVal"];//TODO new
                }
            }
        }
    }
    //文本域end

    //初始化值后置操作
    if(typeof(joForm.initFormValueAfter) == "function"){joForm.initFormValueAfter(oJson);}

    //半夜新增
    // tempComData = jo.form2Json(joForm.params["formObj"]);
};
/**
 * 新增:保存表单数据
 */
joForm.save = function(sUrl,callBack){
    sUrl = jo.getDefVal(sUrl,joForm.params["addUrl"]);
    if(jo.isValid(sUrl)){

        //表单验证start
        if(typeof (joForm.checkForm) == "function"){
            joForm.checkForm(joForm.form);
        }else{
            if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                return;
            }
        }
        //表单验证end
        var oData = jo.form2Json(joForm.params["formObj"]);

        //保存前对表单数据的处理
        if(typeof(joForm.dealDataAtSaveBefore) == "function"){
            joForm.dealDataAtSaveBefore(oData);
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
                            // jo.closeSelf('WIN_ADD');
                        }
                    }else{
                        // window.parent.jo.close('WIN_ADD');
                    }
                    window.parent.jo.showMsg("保存成功!");
                }
            }else{
                jo.showMsg(result.info)
            }
        });

    }else{
        jo.showMsg("{addUrl}无效!");
    }
};


//复选框checkall start 增加判断条件默认全选待审核
joForm.checkAll = function(id) {
    // $("input[name='"+id+"']:checkbox").prop("checked",$("#" + id).prop("checked"));
    $("input[name='"+id+"']:checkbox").each(function () {
        // if ($(this).attr("status") == 5) {//TODO 去除限制
            $(this).prop("checked",$("#" + id).prop("checked"));
        // }
    });
}
//复选框checkall end

//获取选中的checkbox的id
joForm.getCheckBoxIds = function(flag) {
    var eles;
    if (flag) {
        //获取所有、用于一键操作
        eles = $("input:checkbox");
    }else {
        eles = $("input:checkbox:checked");
    }
    var idStr = "";
    for(var i=0;i<eles.length;i++){
        //TODO 注意：不要给小区域总复选框 name 属性
        if (eles[i].getAttribute("name") != null) {
            idStr += "," + eles[i].value;
        }
    }
    idStr = idStr.substring(1);
    return idStr;
}

joForm.getCheckBoxNames = function(flag) {
    var eles;
    if (flag) {
        //获取所有、用于一键操作
        eles = $("input:checkbox");
    }else {
        eles = $("input:checkbox:checked");
    }
    var idStr = "";
    for(var i=0;i<eles.length;i++){
        //TODO 注意：不要给小区域总复选框 name 属性
        if (eles[i].getAttribute("name") != null) {
            idStr += "," + eles[i].getAttribute("cname");
        }
    }
    idStr = idStr.substring(1);
    return idStr;
}

joForm.getCheckVal = function(flag) {
    var eles;
    if (flag) {
        //获取所有、用于一键操作
        eles = $("input:checkbox");
    }else {
        eles = $("input:checkbox:checked");
    }
    var vStr = "";
    var xx = jo.form2Json(joForm.params["formObj"]);
    for(var i=0;i<eles.length;i++){
        //新增start
        if (eles[i].getAttribute("name") != null) {
            var cname = eles[i].getAttribute("cname");

            if (typeof (cname) != "undefined") {
                vStr += "," + xx[cname];
            }
        }

        //新增end
    }
    vStr = vStr.substring(1);
    return vStr;
}
//锁定按钮 start
//复选切换状态

joForm.changeState = function(auditStatus,lockStatus,onekey){
    //临时新增：表单校验
    //表单验证start
    if(typeof (joForm.checkForm) == "function"){
        joForm.checkForm(joForm.form);
    }else{
        if(!jo.checkForm(joForm.form)){//验证不通过直接返回
            return;
        }
    }
    //表单验证end
    //表单校验end
    var idStr = joForm.getCheckBoxIds(onekey);
    var vStr = joForm.getCheckVal(onekey);
    var userId = $("#id").val();

    var vName = joForm.getCheckBoxNames(onekey);

    if (idStr == "") {
        // window.parent.jo.showMsg("请至少选择一项!");
        jo.showMsg("请至少选择一项!");//可以用
        return;
    }else {
        var tipMsg = "确定执行该操作？";
        if (onekey) {
            tipMsg = "<span style='color:red'>提示：该操作将一键操作所有字段！</span>";
        }
        jo.confirm(tipMsg,function () {
            var url = joForm.params["changeStateUrl"];
            var oData = {};
            oData["ids"] = idStr;
            oData["userId"] = userId;
            oData["vStr"] = vStr;
            oData["vName"] = vName;
            if (auditStatus != null) {
                oData["auditStatus"] = auditStatus;
            }
            if (lockStatus != null) {
                oData["lockStatus"] = lockStatus;
            }
            jo.postAjax(url,oData,function(result){
                if(result.code == 0){
                    // jo.showMsg("操作成功！");
                    // window.parent.jo.showMsg("操作成功！");
                    top.jo.showMsg("操作成功！");
                    // top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();//刷新当前页面
                    // joView.reloadCurrentPage();//重新加载当前页数据(no)
                    // window.parent.reloadCurrentPage();//重新加载父页面数据(keyi)
                    // window.parent.location.reload();//锁定目标，可以刷新右侧显示
                }else{
                    jo.showMsg(result.info)
                }
            });
        });
    }
}

//用于保存
joForm.diffAutoCheck = function(){
    var xx = jo.form2Json(joForm.params["formObj"]);
    for (var key in xx) {
        if(xx[key] != tempComData[key]){
            // console.log("---------------------------:"+key+"     "+ xx[key] +"    "+tempComData[key]);
        }
        if (xx[key] != tempComData[key]) {
            $("input[cname='"+key+"']:checkbox").each(function () {
                $(this).prop("checked",true);
            });
        }

/*            for(var i=0;i<formAuditData.length;i++){
                if (key == formAuditData[i]["fieldKey"]) {
                    if (xx[key] != formAuditData[i]["fieldVal"]) {
                        $("input[cname='"+key+"']:checkbox").each(function () {
                            $(this).prop("checked",true);
                        });
                    }
                }
            }*/

    }
}
joForm.changeStateSave = function(auditStatus,lockStatus,onekey){
    //临时新增：表单校验
    //表单验证start
    if(typeof (joForm.checkForm) == "function"){
        joForm.checkForm(joForm.form);
    }else{
        if(!jo.checkForm(joForm.form)){//验证不通过直接返回
            return;
        }
    }
    //表单验证end
    // var xx = jo.form2Json(joForm.params["formObj"]);
    joForm.diffAutoCheck();
    var idStr = joForm.getCheckBoxIds(onekey);
    var vStr = joForm.getCheckVal(onekey);
    var userId = $("#id").val();
    var vName = joForm.getCheckBoxNames(onekey);


    //表单校验end


    if (idStr == "") {
        // window.parent.jo.showMsg("请至少选择一项!");
        jo.showMsg("未更改任何内容!");//可以用
        return;
    }else {
        var tipMsg = "确定执行该操作？";
        if (onekey) {
            tipMsg = "<span style='color:red'>提示：该操作将一键操作所有字段！</span>";
        }
        jo.confirm(tipMsg,function () {
            var url = joForm.params["changeStateUrl"];
            var oData = {};
            oData["ids"] = idStr;
            oData["userId"] = userId;
            oData["vStr"] = vStr;
            oData["vName"] = vName;
            if (auditStatus != null) {
                oData["auditStatus"] = auditStatus;
            }
            if (lockStatus != null) {
                oData["lockStatus"] = lockStatus;
            }
            jo.postAjax(url,oData,function(result){
                if(result.code == 0){
                    // jo.showMsg("操作成功！");
                    // window.parent.jo.showMsg("操作成功！");
                    top.jo.showMsg("操作成功！");
                    // top.main.joView.reloadCurrentPage();//重新加载父页面数据
                    window.location.reload();//刷新当前页面
                    // joView.reloadCurrentPage();//重新加载当前页数据(no)
                    // window.parent.reloadCurrentPage();//重新加载父页面数据(keyi)
                    // window.parent.location.reload();//锁定目标，可以刷新右侧显示
                }else{
                    jo.showMsg(result.info)
                }
            });
        });
    }
}


//涉及到审核：用户修改提交审核的地址
joForm.auditUpdate = function(sUrl) {
    //TODO 用户修改提交时移除disabled
    var elements = document.getElementById("pageForm").elements;
    for (var i=0;i<elements.length;i++) {
        var e = elements[i];
        if (e.type != "checkbox" && e.type != "hidden") {
            e.removeAttribute("disabled");
        }
    }

    sUrl = jo.getDefVal(sUrl,joForm.params["auditUpdateUrl"]);
    if(jo.isValid(sUrl)){
        var oData = jo.form2Json("pageForm");
        jo.postAjax(sUrl,{"pData":JSON.stringify(oData)}, function(result){
            if(result.code == 0){
                if (jo.isValid(sf)) {
                    window.parent.jo.showMsg("修改成功!");
                }else {
                    window.parent.jo.showMsg("修改成功，请等待管理员审核!");
                }
                window.location.reload();
            }else{
                jo.showMsg(result.info)
            }
        });
    }else {
        jo.showMsg("{deleteUrl}无效!");
    }
}

//赋值左侧菜单start 用于刷新条目,字段类为id，非字段类为userid
joForm.setAuditItem = function(pkName,sUrl,msg) {
    var userId = jo.getUrlParam(pkName);
    jo.postAjax(sUrl,{"userId":userId},function (json) {
        if (json.code == 0) {
            //li display: none;
            // $(".select .clear").append(msg);//TODO 此处赋值错误
            var zero_html = "";
            $("#selectContent li a").each(function (i,ele) {
                $.each(json.data,function (j,arr) {
                    if (i == j){
                        if (arr == 0) {
                            zero_html = 'style="color:black"';
                        }else {
                            zero_html = "";
                        }
                        $(ele).append("<span class=\"baifen right\" "+zero_html+">"+msg+"    "+arr+"</span>");
                    }
                });
            });
        }
    });
}
//赋值左侧菜单end

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
            //表单验证
            if(typeof (joForm.checkForm) == "function"){
                joForm.checkForm(joForm.form);
            }else{
                if(!jo.checkForm(joForm.form)){//验证不通过直接返回
                    return;
                }
            }

            var oData = jo.form2Json(joForm.params["formObj"]);
            //修改前对表单数据的处理
            if(typeof(joForm.dealDataAtUpdateBefore) == "function"){
                joForm.dealDataAtUpdateBefore(oData);
            }

            jo.postAjax(sUrl,oData, function(result){
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