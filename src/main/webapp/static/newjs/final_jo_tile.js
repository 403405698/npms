/*
 * jo:基于jQuery封装,引入jo前要引入jQuery包;
 */
window.jo = {};
//jo初始化
(function () {
    //[Attr] 域名集合
    jo.address = {
        "contextPath" : contextPath ? contextPath : "/young/",
        "BAM" : "/young/",
        "UMS" : "/young/",
        "PORTAL" : "/young/",
        "STATIC" : "/young/",
        "FS" : "/young/"
    };
    //jo常量
    jo.Const = {
        URI_LOGOUT : "logout.action"//用户注销uri
    };
    jo.params = {};//页面参数集
    //[Attr] jt.bIE###是否是IE
    var ie_upto10 = /MSIE \d/.test(navigator.userAgent);
    var ie_11up = /Trident\/(?:[7-9]|\d{2,})\..*rv:(\d+)/.exec(navigator.userAgent);
    //[Attr] 是不是IE
    jo.bIE = ie_upto10 || ie_11up;
    //[Attr] IE版本
    jo.IEVersion = jo.bIE && (ie_upto10 ? document.documentMode || 6 : ie_11up[1]);
    //[Attr] 是否是Edge
    jo.bEdge = /Edge\//i.test(navigator.userAgent); //Edge
    //[Attr] 是否是IE6
    jo.bIE6 = /msie 6/i.test(navigator.userAgent);
    //[Attr] 是否是Chrome
    jo.bChrome = /chrome/i.test(navigator.userAgent);
    //[Attr] 是否是FireFox
    jo.bFireFox = /firefox/i.test(navigator.userAgent);
    //[Attr] 是否是Opera
    jo.bOpera = /Opera/i.test(navigator.userAgent);
    //[Func] 判断val是否有效(即:!=null,!='null',!='NULL',!='',!='undefined')
    jo.isValid = function(val){
        if(typeof(val) == "undefined"){
            return false;
        }else{
            if(val != null && val !="null" && val != "undefined"){
                if(val != ""){
                    return true;
                }
                if(val === 0){//因为0==""返回的是true,所以在这要对0做处理
                    return true;
                }
            }
        }
        return false;
    };
    //[Func] 判断参数不是undefined
    jo.isNotUndefined = function(val){
        if(typeof (val) == "undefined"){
            return false;
        }
        return true;
    };
    //[Func] 获取默认值,val有效返回val,def返回def(def无效返回"")
    jo.getDefVal = function(val,def){
        if(typeof(val) == "number"){
            return val;
        }
        if(typeof(val) == "boolean"){
            return val;
        }
        return jo.isValid(val) ? val : (jo.isValid(def) ? def : "");
    };
    //[Func] 获取jo策略的UUID
    jo.getUUID = function(){
        var UUIDLen = 32;//UUID长度
        var mm = new Date().getTime().toString();//时间戳
        var str = "AbC13DE2F56g4hi79JKL0MN8opqR9STU8VwxYZ7aBc6def5GHI4jkl3mnO2PQr1stu0vWXyz";//72个字符
        var len = UUIDLen - mm.length;//计算还差几个长度
        for(var i=0;i<len;i++){//循环生成
            mm += str.charAt(Math.floor(Math.random()*71));//生成0-71的随机数,根据随机数获取对应索引的字符
        }
        return mm;
    };
    //[Func] 获取对象
    jo._ = function(finder){
        return $(finder);
    };
    //[Func] 获取对象
    window.jo_ = function(finder){
        return $(finder);
    };
    //[Func] 获取尺寸数字,例如:输入5px,输出5
    jo.getSizeNum = function(nPX){
        return parseInt(nPX.substring(0,nPX.length-2));
    };
    //[Func] 解析URL,例如:输入{umsPath}/ums/getXX.action,输出http://www.rookie.com/rookie/ums/getXX.action
    jo.parseUrl = function(sUrl){
        return jo.getCode(sUrl,jo.address);//sUrl.replace(/\{[a-zA-Z]*Path\}/ig,"http://www.rookie.com/rookie");
    };
    //[Func] 对象转为json字符串
    jo.obj2JsonStr = function(obj){
        if(!jo.isValid(obj)){
            return null;
        }
        if(typeof (obj) == "object" && !(obj instanceof Array)){
            var arr = new Array();
            for(var e in obj){
                if(typeof (obj[e]) != "function"){//排除方法
                    var v = jo.obj2JsonStr(obj[e]);
                    arr.push('"'+e+'":'+v+'');
                }
            }
            return '{'+arr.join(",")+'}';
        }else if(typeof (obj) == "string"){
            return '"'+obj+'"';
        }else if(typeof (obj) == "number"){
            return obj+"";
        }else if(typeof (obj) == "boolean"){//布尔类型
            return obj+"";
        }else if(typeof (obj) == "object" && (obj instanceof Array)){//数组
            if(obj.length > 0){
                var str = '[';
                for(var i=0;i< obj.length;i++){
                    if(i == 0){
                        str += jo.obj2JsonStr(obj[i]);
                    }else{
                        str += ',' + jo.obj2JsonStr(obj[i]);
                    }
                }
                str += ']';
                return str;
            }else{
                return "[]";
            }
        }else{
            return {};
        }
    };
    //[Func] xml对象转json
    jo.xmlDocument2Json = function(xmlDoc){
        var xmlObj = $(xmlDoc);//jq对象化
        var child = xmlObj.children();//一级根节点
        var json = {};
        if(child && child.length > 0){
            for(var i=0;i<child.length;i++){
                var ele = child[i];//节点
                var tagName = ele.tagName;//节点名称
                if(typeof (json[tagName]) == "object" && (json[tagName] instanceof Array)){//该节点名已存在数组类型的值,添加进去
                    json[tagName].push(jo.xmlDocument2Json(ele));
                }else if(typeof (json[tagName]) != "undefined"){//已经存在该节点名的对象,则改装为数组形式
                    var _arr = new Array();
                    _arr.push(json[tagName]);//将原先的放到数组中
                    _arr.push(jo.xmlDocument2Json(ele));//将当前的也放到数组中
                    json[tagName] = _arr;//更新为数组
                }else{
                    json[tagName] = jo.xmlDocument2Json(ele);
                }
            }
            //读取节点属性
            if(xmlDoc.attributes && xmlDoc.attributes.length && xmlDoc.attributes.length > 0){
                //var attrsArray = Array.prototype.slice.call(xmlDoc.attributes);
                for(var i=0;i<xmlDoc.attributes.length;i++){
                    var attr = xmlDoc.attributes[i];
                    if(typeof (json[attr.name]) == "undefined"){
                        json[attr.name] = attr.value;
                    }else{
                        json["_"+attr.name] = attr.value;//节点中存在同名节点,则以_为前缀
                    }
                }
            }
        }else if(xmlDoc.attributes && xmlDoc.attributes.length && xmlDoc.attributes.length > 0){
            for(var i=0;i<xmlDoc.attributes.length;i++){
                var attr = xmlDoc.attributes[i];
                if(typeof (json[attr.name]) == "undefined"){
                    json[attr.name] = attr.value;
                }else{
                    json["_"+attr.name] = attr.value;//节点中存在同名节点,则以_为前缀
                }
            }
        }else{//不存在子节点和属性,则返回节点内容
            return $(xmlDoc).text();
        }
        return json;
    };
    //[Func] post类型的普通请求:虚拟表单实现
    jo.post = function(sUrl,oData){
        var temp = document.createElement("form");
        temp.action = jo.parseUrl(sUrl);
        temp.method = "post";
        temp.style.display = "none";
        for (var x in oData) {
            var opt = document.createElement("textarea");
            opt.name = x;
            opt.value = oData[x];
            temp.appendChild(opt);
        }
        document.body.appendChild(temp);
        temp.submit();
        return temp;
    };
    //[Func] post类型的ajax请求
        jo.postAjax = function(sUrl,sData,func,isAsync){
        sUrl = jo.parseUrl(sUrl);//解析url
        //判断是否跨域
        if(sUrl.indexOf("http://") == 0 || sUrl.indexOf("https://") == 0){//url为完整形式时继续判断是否跨域
            var cur = location.protocol + "//" + location.host;//当前页面的域名
            if(sUrl.indexOf(cur) != 0){//如果请求地址不是以当前页面的域名开头,则认为是跨域请求
                jo.postJSONP(sUrl, sData, func);//调用跨域请求
                return;
            }
        }
        if(!jo.isValid(isAsync)){
            isAsync = false;//默认非异步加载
        }
        if(!sData){
            sData = null;
        }else{
            if(typeof(sData) == "string"){//字符串,key=value形式

            }else if(typeof(sData) == "object"){//对象,{key:value,key:value}形式
                //转换为1=1&2=2形式字符串
                var str = "";

                for(var k in sData){
                    // console.info(sData[k]+"----"+encodeURIComponent(sData[k]))
                    str += "&" + k + "=" + encodeURIComponent(sData[k]);
                }
                //replace(/\+/g, '%2B') 处理加号传到服务端变成空格的问题
                sData = str.substring(1);//.replace(/\+/g, '%2B');
            }
        }
        var res = null;
        $.ajax({
            type : "POST",
            url :  sUrl,
            data: sData,
            async: isAsync,
            cache: false,
            contentType:'application/x-www-form-urlencoded',//'application/json',数据提交类型
            processData: false,
            datatype:"json", //返回值类型
            beforeSend: function() {//加载前执行函数

            },
            success : function(result,textStatus,jqXHR) {
                if(jo.isValid(result)){
                    if(typeof(func) == "function"){
                        try{func(result)}catch(err){};
                    }
                    res = result;
                }else{
                    res = null;
                }
            },
            complete : function(jqXHR,textStatus){
                if(jo.isValid(jqXHR.responseText)){//后台传的json字符串
                    var re = '';
                    try{
                        re = JSON.parse(jqXHR.responseText);
                    }catch(err){
                        if(textStatus == "error"){

                        }
                    }
                    if(jo.isValid(re) && re.code == '-101'){//session过期异常代码
                        /*jo.confirm(re.info,function(){

                        });*/
                        if(re.redirectTo){
                            top.window.location.href = re.redirectTo;
                        }else{
                            top.window.location.href = jo.getDefVal(URL_UMS, contextPath) + jo.Const.URI_LOGOUT;//登出
                        }
                        //top.window.location.href ="page/jsp/login.jsp";  //跳转页面
                    }else if(jo.isValid(re) && re.code == '-102'){//平台业务异常代码
                        jo.showMsg(jo.getDefVal(re.info,"非法操作!"));
                    }else if(jo.isValid(re) && re.code == '-901'){//平台业务异常代码
                        jo.showMsg(jo.getDefVal(re.info,"*系统异常!"));
                    }else if(jo.isValid(re) && re.code == '-999'){//系统异常代码
                        jo.showMsg("*系统出现异常,请与管理员联系!");
                    }else{

                    }
                }else{

                }
            },
            error : function(jqXHR,textStatus,err) {
                //jqXHR:jQuery增强的XHR
                //textStatus:请求完成状态
                //err:底层通过throw抛出的异常对象，类型与值与错误类型有关
                console.log(arguments);
                console.error(" --ajax请求出错-参数打印...--" + "\n" +
                    "【请求地址】"+this.url + "\n" +
                    "【请求类型】"+this.type + "\n" +
                    "【请求参数】"+this.data + "\n" +
                    "【返回状态】"+jqXHR.status + "\n" +
                    "【返回类型】"+this.datatype + "\n");
            },
            statusCode:{
                '403':function(jqXHR,textStatus,err){
                    //jqXHR:jQuery增强的XHR
                    //textStatus:请求完成状态
                    //err:底层通过throw抛出的异常对象，类型与值与错误类型有关
                    console.log(arguments);
                    console.log(403);
                },
                '400':function(){
                    console.log(400);
                },
                '404':function(){
                    console.log(404+":阿偶,无法链接到二次元资源:"+this.url);
                }
            }
        });
        return res;
    };
    //[Func] 获取地址栏参数
    jo.getUrlParam = function(key){
        var reg = new RegExp("(^|&)" + key + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        //decodeURI(escape(unescape(r[2])))处理中文乱码
        if (r != null) {
            if(jo.bIE){
                return r[2];
            }else{
                return decodeURI(escape(unescape(r[2])));
            }
        }
        return "";
    };
    //[Func] 获取所有地址栏参数
    jo.getUrlParams = function(sUrl){
        var searchStr = jo.getDefVal(sUrl,window.location.search);
        if(searchStr.indexOf("?") > -1){//有参数
            searchStr = searchStr.substring(1);
            var searchs = searchStr.split("&");
            var res = {};
            for(var i=0;i<searchs.length;i++){
                var j = searchs[i].indexOf("=");
                var skey = searchs[i].substring(0,j);
                var svalue = searchs[i].substring(j+1);
                res[skey] = svalue;
            }
            return res;
        }else{
            return {};
        }
    };
    //[Func] 页面弹出提示信息
    jo.showMsg = function(msg){
        jo.closeMsg();
        var msg_box = "<div style='width:20%;height:auto;position:absolute;z-index:9999;top:40%;left:40%;background-color:#333333;line-height:25px; letter-spacing:1px;padding:3px 5px;font-size:16px;color:#FFFFFF;text-align:center;display:none;' class='showMsg_style' id='showMsg' onclick='jo.closeMsg()'>" + msg + "</div>";
        $("body").append(msg_box);
        $("#showMsg").fadeIn(1000).fadeOut(3000);
    };
    //[Func] 关闭提示信息
    jo.closeMsg = function(){
        if($("#showMsg")){//存在提示消息窗
            $("#showMsg").remove();
        }
    };
    //[Func] 正在加载提示框,当传入false表示关闭
    jo.showLoading = function(msgOrClose){
        //当参数为false时,关闭提示
        if(typeof(msgOrClose) == "boolean" && !msgOrClose){
            jo.remove(document.getElementById("joMsg_loading"));
        }else{
            var obj = document.getElementById("joMsg_loading");
            if(jo.isValid(obj)){
                $(obj).html(jo.getDefVal(msgOrClose,"正在加载..."));
            }else{
                var _html = '<div class="joMsg_loading" id="joMsg_loading">';
                _html += jo.getDefVal(msgOrClose,"正在加载...");
                _html += '</div>';
                $("body").append(_html);
            }
        }
    };
    //[Func] 将表单数据转为json对象
    jo.form2Json = function(id){
        var arr = null;
        if(typeof(id) == "string"){//传入字符串,说明是表单的ID
            if(!($("#" + id).attr("id"))){
                return null;
            }
            arr = $("#" + id).serializeArray();
        }else if(typeof(id) == "object"){
            arr = id.serializeArray();
        }else{
            return null;
        }
        /*var jsonStr = "";
        jsonStr += '{';
        for (var i = 0; i < arr.length; i++) {
            jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",';
        }
        if(jsonStr.length > 1){
            jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
        }
        jsonStr += '}';
        //处理json字符串中的特殊字符导致的异常
        jsonStr = jsonStr.replace(/\r/ig, "\\r");
        jsonStr = jsonStr.replace(/\n/ig, "\\n");
        var json = JSON.parse(jsonStr);*/

        //直接返回js对象
        var json = {};
        for(var i=0;i<arr.length;i++){
            var val = arr[i].value;
            //在这里不需要对换行做处理,否则会将换行符变为\r\n字符串
            /*if(val){
                val = val.replace(/\r/ig, "\\r");
                val = val.replace(/\n/ig, "\\n");
            }*/
            json[arr[i].name] = val;
        }
        return json;
    };
    //[Func] 将表单数据转为json字符串
    jo.form2JsonStr = function(id){
        /*if(!($("#" + id).attr("id"))){
        return "";
        }
        var arr = $("#" + id).serializeArray();
        var jsonStr = "";
        jsonStr += '{';
        for (var i = 0; i < arr.length; i++) {
            jsonStr += '"' + arr[i].name + '":"' + arr[i].value + '",';
        }
        jsonStr = jsonStr.substring(0, (jsonStr.length - 1));
        jsonStr += '}';*/
        return JSON.stringify(jo.form2Json(id));
    };
    //[Func] 将表单数据转为key1=value1&key2=value2..形式
    jo.form2ParamStr = function(id){
        if(!($("#" + id).attr("id"))){
            return "";
        }
        /*var arr = $("#" + id).serializeArray();
        var jsonStr = "";
        for (var i = 0; i < arr.length; i++) {
            jsonStr += arr[i].name + '=' + arr[i].value + '&';
        }
        jsonStr = jsonStr.substring(0, (jsonStr.length - 1));*/
        return $("#" + id).serialize();
    };
    //[Func] 重置表单,传入表单id
    jo.reset = function(id){
        document.getElementById(id).reset();
    };
    //[Func] 全选/取消全选,全选框的id为checkAll,参数为复选框的name(默认是ID);参数obj表示全选框对象,通常用this;示例:<input type="checkbox" onclick="jo.checkAll('ID',this)">
    jo.checkAll = function(name,obj){
        var _id = name ? name : "ID";
        if(typeof(obj) == "object"){
            $("input[name='"+_id+"']").prop("checked",jo.getDefVal($(obj).prop("checked"),false));//1.9以上jquery使用
        }else{
            $("input[name='"+_id+"']").prop("checked",jo.getDefVal($("#checkAll").prop("checked"),false));//1.9以上jquery使用
            /*//低版本jquery使用
             if(!$("#checkAll").attr("checked")){
             $("input[name='"+_id+"']").attr("checked",false);
             }else{
             $("input[name='"+_id+"']").attr("checked",true);
             }
             */
        }
    };
    //[Func] 得到所有选中复选框的值:参数为checkbox的name;返回以逗号间隔的字符串
    jo.getCheckBoxValue = function (boxName){
        if(!boxName){
            boxName = "ID";
        }
        var ids = $("input[name='"+boxName+"']" + ":checked");
        idStr = "";
        //获取勾选集
        for(var i=0;i<ids.length;i++){
            idStr += "," + ids[i].value;
        }
        idStr = idStr.substring(1);
        return idStr;
    };
    //[Func] 获得url添加条件的连接符,即判断传入的URL后方链接新参数应该用'?'还是用'&'
    jo.getLinkSign = function(str){
        if(str.indexOf("?") >= 0){//传进来的URL带有'?'
            if(str.indexOf("?")+1 == str.length){//当url以?结尾时,返回''
                return "";
            }
            if(str.indexOf("&")+1 == str.length){//当url以&结尾,返回''
                return '';
            }else{
                if(str.split("?").length > 2){//有且只有1个'?'
                    console.info("URL格式可能存在异常:"+str);
                }
                return "&";
            }
        }else{
            return "?";
        }
    };
    //[Func] 格式化日期 : 毫秒数/date==>yyyy-MM-dd
    jo.formatDate = function(ms){
        if(!jo.isValid(ms)){
            return "";
        }
        if(typeof (ms) == "string" && !isNaN(ms)){
            ms = parseInt(ms);
        }
        var _ms = jo.getDefVal(ms);
        var myDate = new Date(_ms);//生成时间类型
        var yyyy = myDate.getFullYear();//年份 xxxx
        var MM = (myDate.getMonth() + 1) < 10 ? "0" + (myDate.getMonth() + 1) : (myDate.getMonth() + 1);//月份 0-11,加1就是真实月份
        var dd = myDate.getDate() < 10 ? "0" + myDate.getDate() : myDate.getDate();//日期 1-31
        //myDate.getDay();//星期几 0-6 ,0代表星期天
        return yyyy+"-"+MM+"-"+dd;
    };
    //[Func] 格式化时间 : 毫秒数/date==>yyyy-MM-dd hh:mm:ss
    jo.formatTime = function(ms){
        if(!jo.isValid(ms)){
            return "";
        }
        if(typeof (ms) == "string" && !isNaN(ms)){
            ms = parseInt(ms);
        }
        var _ms = jo.getDefVal(ms);
        var myDate = new Date(_ms);//生成时间类型
        var yyyy = myDate.getFullYear();//年份 xxxx
        var MM = (myDate.getMonth() + 1) < 10 ? "0" + (myDate.getMonth() + 1) : (myDate.getMonth() + 1);//月份 0-11,加1就是真实月份
        var dd = myDate.getDate() < 10 ? "0" + myDate.getDate() : myDate.getDate();//日期 1-31
        //时分秒小于10时在前补0
        var hh = myDate.getHours() < 10 ? "0" + myDate.getHours() : myDate.getHours();//小时数
        var mm = myDate.getMinutes() < 10 ? "0" + myDate.getMinutes() : myDate.getMinutes();//分钟数
        var ss = myDate.getSeconds() < 10 ? "0" + myDate.getSeconds() : myDate.getSeconds();//秒数
        return yyyy+"-"+MM+"-"+dd+" "+hh+":"+mm+":"+ss;
    };
    //[Func] 执行代码
    jo.execCode = function(sCode,paramArr){
        if(jo.isValid(sCode)){//待执行代码的有效性
            return eval(jo.getCode(sCode,paramArr));
        }else{
            return false;
        }
    };
    //[Func] 解析代码
    jo.getCode = function(sCode,paramArr){
        if(jo.isValid(sCode)){//待执行代码的有效性
            if(jo.isValid(paramArr)){//替换参数有效的话,执行替换,否则直接返回sCode
                //替换变量
                var reg = /\{[a-zA-Z0-9_]*\}/g;
                if(reg.test(sCode)){
                    var a = sCode.match(reg);
                    if(!jo.isValid(paramArr)){
                        //参数替换数组无效
                    }else{
                        for(var i=0;i<a.length;i++){
                            var x = a[i]+"";
                            var key = x.substring(1,x.length-1);
                            sCode = sCode.replace(x,paramArr[key]);
                        }
                    }
                }
            }
            return sCode;
        }else{
            return "";
        }
    };
    //[Func] 初始化按钮权限
    jo.initBtnAuth = function(){
        $("#joBtn[isShow]").each(function(index,element){
            var isShow = $(this).attr("isShow");
            //当返回false或'false'时才隐藏,isShow为空时也隐藏
            if(jo.execCode(isShow) == false || jo.execCode(isShow) == 'false'){
                $(this).hide();
            }else{
                $(this).show();
            }
        });
    };
    //[Func] 加载css,参数sUrl为css地址
    jo.loadCSS = function(sUrl){
        if(jo.isValid(sUrl)){
            var link = document.createElement("link");
            link.setAttribute("rel","stylesheet");
            link.setAttribute("href",sUrl);
            document.head.appendChild(link);
        }
    };

    //[Func] 加载JavaScript,参数sUrl为js地址
    jo.loadJS = function(sUrl){
        if(jo.isValid(sUrl)){
            var script = document.createElement("script");
            script.setAttribute("type","text/javascript");
            script.setAttribute("charset", "utf-8");
            script.setAttribute("src",sUrl);
            document.head.appendChild(script);
        }
    };
    //JSONP回调方法数组
    window.joJSONP = new Array();
    //[Func] JSONP跨域请求
    jo.postJSONP = function(sUrl, sData, callback){
        if(jo.isValid(sUrl)){
            if(typeof(sData) == "string"){//字符串,key=value形式

            }else if(typeof(sData) == "object"){//对象,{key:value,key:value}形式
                //转换为1=1&2=2形式字符串
                var str = "";
                for(var k in sData){
                    str += "&" + k + "=" + encodeURIComponent(sData[k]);//sData[k];
                }
                //replace(/\+/g, '%2B') 处理加号传到服务端变成空格的问题
                sData = str.substring(1);//.replace(/\+/g, '%2B');
            }
            var idx = joJSONP.push(callback) - 1;
            sUrl += jo.getLinkSign(sUrl) + "callback=joJSONP["+idx+"]";
            if(sData){
                sUrl += "&" + sData;
            }
            jo.loadJS(sUrl);
        }
    };

    //[Func] 移除某元素
    jo.remove = function(element){
        if(jo.isValid(element)){
            var pElement = element.parentNode;
            pElement.removeChild(element);
        }
    };

    //[Func] iframe加载完成事件处理
    jo.iframeLoaded = function(iframe, func){
        if (iframe.attachEvent){
            iframe.attachEvent("onload", func);
        } else {
            iframe.onload = func;
        }
    };

    //[Func] 生成遮罩层,返回遮罩层元素,引用的jo窗口相关css
    jo.getShade = function(zIndex){
        var shadeElement = document.createElement("div");
        //遮罩层ID为窗口名字+Shade
        shadeElement.setAttribute("id", "joShade");
        //遮罩层样式为joWinShade
        shadeElement.setAttribute("class", "joWinShade");
        if(jo.isValid(zIndex)){
            //z-index属性
            shadeElement.style.zIndex = zIndex;
        }
        document.body.appendChild(shadeElement);
        return shadeElement;
    };
    //[Func] 打开新窗口
    jo.newWindow = function(sUrl){
        window.open(sUrl);
    };

    /**
     * [Func] 表单验证,参数为表单jQuery对象
     * 1.ErrEmpty 为空提示,含有此属性说明该项为必填项,属性值为提示信息;
     * 2.ErrLength 长度验证,值为该项允许的最大长度;
     * 3.ErrInfo 错误提示,发生验证错误时的提示信息;
     * 4.ErrReg 验证的正则表达式,可以自定义;
     */
    jo.checkForm = function(oForm){
        //必填/非空验证
        var emptys = oForm.find("input[ErrEmpty]");
        for(var i=0;i<emptys.length;i++){
            var e = emptys[i];
            var val = $(e).val();
            if(val == ""){
                jo.showMsg(jo.getDefVal($(e).attr("ErrEmpty"),"该项不可以为空！"));//提示信息
                $(e).focus();//获取焦点
                return false;
            }
        }
        //select下拉列表的非空验证
        emptys = oForm.find("select[ErrEmpty]");
        for(var i=0;i<emptys.length;i++){
            var e = emptys[i];
            var val = $(e).val();
            if(val == ""){
                jo.showMsg(jo.getDefVal($(e).attr("ErrEmpty"),"该项不可以为空！"));//提示信息
                $(e).focus();//获取焦点
                return false;
            }
        }
        //长度验证
        var lengths = oForm.find("input[ErrLength]");
        for(var i=0;i<lengths.length;i++){
            var e = lengths[i];
            var len = $(e).attr("ErrLength");//限制长度
            var val = $(e).val();//值
            //alert(len+"--"+val);
            if(jo.isValid(len) && jo.isValid(val)){//长度和值均有效时,判断是否超过长度
                if(val.length > parseInt(len)){//长度超过
                    jo.showMsg(jo.getDefVal($(e).attr("ErrInfo"),"该项超过最大长度["+len+"]！"));//提示信息
                    $(e).focus();//获取焦点
                    return false;
                }
            }
        }

        //数字验证
        var numbers = oForm.find("input[ErrNumber]");
        for(var i=0;i<numbers.length;i++){
            var e = numbers[i];
            //var len = $(e).attr("ErrLength");//限制长度
            var val = $(e).val();//值
            if(jo.isValid(val)){//值有效时,判断是否是数字类型
                if(isNaN(val)){
                    jo.showMsg(jo.getDefVal($(e).attr("ErrNumber"),"该值必须是数字类型！"));//提示信息
                    $(e).focus();//获取焦点
                    return false;
                }
            }
        }

        return true;
    };

    //[Func] confirm选择框
    jo.confirm = function(sMsg,funcOk){
        if(window.confirm(sMsg)){
            funcOk();
        }
    };

    /**
     * [Func] 数组排序,基于冒泡排序算法
     * @param arr 待排序数组
     * @param func 核心比较回调函数(参考java中Comparator比较器),回调函数有2参数,返回元素a和b的比较结果,返回true表示元素a在b前
     */
    jo.sort = function(arr, func){
        for(var i=0;i<arr.length;i++){
            for(var j=i+1;j<arr.length;j++){
                //两者比较,返回true则a在b前面,返回false则b在a前面
                if(!func(arr[i], arr[j])){
                    var temp = arr[i];
                    arr[i] = arr[j];
                    arr[j] = temp;
                }
            }
        }
    };

    /**
     * 智能解析key
     * 1.key可以是普通字符串,例如name,返回oObj对象的name属性
     * 2.key可以是多属性拼接表达式,例如{id}({name}),传入该值返回的是{id}和{name}分别被id和name属性替换后的值==> id的值(name的值)
     * 3.key可以是有返回值的方法表达式,例如:[=format({time})],返回的是time属性传入format方法后返回的值
     * @param oObj
     * @param sKey
     */
    jo.parseKey = function(oObj, sKey){
        var _val = sKey;
        //对可执行字段进行处理
        if(jo.isValid(_val)){
            //以 [= 开头, ] 结尾的格式,表示调用函数对字段进行处理,其中的变量(即该行json的字段值)要使用花括号括起来,例如 [=jo.formatDate('{time}')],time为从数据库查询出来的字段
            if(_val && /^\[=(.)*\]$/.test(_val)){
                //去掉无效的[=和]
                _val = _val.substring(2, _val.length - 1);
                //解析{xx}类型的变量
                _val = jo.getCode(_val, oObj);
                //执行该函数
                _val = eval(_val);
            }else if(/\{(.)*\}/g.test(_val)){//解析{xx}类型的变量
                _val = jo.getCode(_val, oObj);
            }else{
                _val = jo.getDefVal(oObj[_val],"");//正常字段名则从接送中取对应字段值
            }
        }
        return jo.getDefVal(_val,"");//最后对_val进行检查,无效则赋值空
    };
    /**
     * 将只读属性的表单元素转为文本
     * @param formId 表单id
     */
    jo.readonly2Label = function(formId){
        formId = formId || "pageForm";
        var form = $("#"+formId);//表单
        //处理input
        form.find("input[type='text'][readonly]").each(function(idx, ele){
            var val = $(ele).val();
            var label = '<span>'+val+'</span>';
            $(ele).after(label);//在元素后加文本
            jo.remove(ele);//删除元素
        });
        //处理select
        form.find("select[readonly]").each(function(idx, ele){
            var text = "";
            if(typeof (ele.options[ele.options.selectedIndex]) != "undefined"){//避免因异步问题或空值带来的undefind错误
                text = ele.options[ele.options.selectedIndex].text;
            }
            var label = '<span>'+text+'</span>';
            $(ele).after(label);
            jo.remove(ele);
        });
        //处理textarea
        form.find("textarea[readonly]").each(function(idx, ele){
            var val = $(ele).val();
            var label = '<span>'+val+'</span>';
            $(ele).after(label);
            jo.remove(ele);
        });
    }
    /**
     * 表单元素转label
     * @param formId
     */
    jo.form2Label = function(formId){
        formId = formId || "pageForm";
        var form = $("#"+formId);//表单
        //处理input
        form.find("input[type='text']").each(function(idx, ele){
            var val = $(ele).val();
            var label = '<span>'+val+'</span>';
            $(ele).after(label);//在元素后加文本
            jo.remove(ele);//删除元素
        });
        //处理select
        form.find("select").each(function(idx, ele){
            var text = "";
            if(typeof (ele.options[ele.options.selectedIndex]) != "undefined"){//避免因异步问题或空值带来的undefind错误
                text = ele.options[ele.options.selectedIndex].text;
            }
            var label = '<span>'+text+'</span>';
            $(ele).after(label);
            jo.remove(ele);
        });
        //处理textarea
        form.find("textarea").each(function(idx, ele){
            var val = $(ele).val();
            var label = '<span>'+val+'</span>';
            $(ele).after(label);
            jo.remove(ele);
        });
    }
})();
//jo初始化完成

//jo树操作初始化
(function () {
    /**
     * jo树的展示,对于zTree相关封装
     * 参数说明:
     * treeId:树的id
     * zNodes:节点集信息
     * setting:zTree树的相关设置(为空则使用默认设置)
     * onClickFunc:树节点的点击事件
     * asyn:异步加载标识,0和1
     * onAsynSuccess:异步加载完成后的回调
     * childUrl:子节点的url
     * autoParam:查询子节点时携带的参数(详情参见zTree API)
     * txt_id:回显ID值的框的id
     * txt_name:回显NAME值的框的id
     * field_id:回显ID的字段名,与txt_id对应;--默认为item_id
     * field_name:回显NAME的字段名,与txt_name对应;--默认为item_show
     * item_id:节点的id字段名
     * item_pid:节点的父id字段名(控制层级)
     * item_show:节点显示文本的字段名
     * item_title:节点的提示信息字段名;--默认为item_show
     *
     * check:树勾选配置
     * edit:树编辑配置
     * initZTreeBefore:初始化ztree树的前置处理,参数1为树id,参数2为setting,参数3为nodes
     *
     */
    //[Attr] 页面内zTree树的信息,存放了回显信息等,可以在需要的时候调用,参数key参见注释
    jo.zTrees = {
    };
    //[Func] 渲染zTree(简单zTree)
    jo.drawZTree = function(oParams){
        if(typeof(oParams) == "object"){//树参数有效
            var _treeId = jo.getDefVal(oParams.treeId,"zTree");
            var _zNodes = {};
            if(jo.isValid(oParams.zNodes)){
                _zNodes = oParams.zNodes;
            }else{
                console.log("树参数异常:zNodes树节点信息无效!");
                return;
            }
            var setting = {};
            if(jo.isValid(oParams.setting)){
                setting = oParams.setting;
            }else{
                var _itemId = jo.getDefVal(oParams.item_id,"id");
                var _itemPid = jo.getDefVal(oParams.item_pid,"pid");
                var _showField = jo.getDefVal(oParams.item_show,"name");
                var _title = jo.getDefVal(oParams.item_title,_showField);
                var _onClickFunc = typeof(oParams.onClickFunc) == "function" ? oParams.onClickFunc : jo.zTreeOnClick;
                var _asyn = true;//默认异步加载
                if(jo.isValid(oParams.asyn) && (oParams.asyn == "0" || oParams.asyn == "false" || oParams.asyn == false)){
                    _asyn = false;
                }
                var _autoParam = jo.getDefVal(oParams.autoParam,[]);//异步加载时自动传到后台的数据
                /*
                 * 异步加载完成后的回调
                 */
                var onAsynSuccess = function(event, treeId, nodeData,msg){
                    if(typeof(oParams.onAsynSuccess) == "function"){
                        oParams.onAsynSuccess(event, treeId, nodeData,msg);
                    }
                };
                setting = {
                    data: {
                        simpleData: {
                            enable: true,
                            idKey: _itemId,
                            pIdKey: _itemPid
                        },
                        key: {
                            name: _showField,
                            title: _title
                        }
                    },
                    async: {
                        enable: _asyn,
                        dataType: "text",
                        url: jo.getChildUrl,
                        autoParam: _autoParam,
                        dataFilter: jo.dealChildData
                    },
                    callback: {
                        onClick: _onClickFunc,
                        onAsyncSuccess: onAsynSuccess
                    },
                    view: {
                        showLine: false
                    }
                };
                if(jo.isValid(oParams.check)){
                    setting.check = oParams.check;//勾选配置
                }
                if(jo.isValid(oParams.edit)){
                    setting.edit = oParams.edit;//编辑配置
                }
            }
            //初始化树前置操作
            if(typeof (oParams.initZTreeBefore) == "function"){
                oParams.initZTreeBefore(_treeId, setting, _zNodes);
            }
            $.fn.zTree.init($("#"+_treeId), setting, _zNodes);
            //创建树对象,jo.zTrees进行统一管理
            //存入之前先删除掉节点,设置,事件等无用信息
            delete(oParams.zNodes);
            delete(oParams.setting);
            delete(oParams.onClickFunc);
            jo.zTrees[_treeId] = oParams;//存入jo.zTrees,key为树的id,调用示例(获取xx树的节点id字段):jo.zTrees["xxTree"].item_id;
        }else{
            console.log("树的参数无效:不是object类型!");
        }
    };
    //[Func] 获取子节点的URL
    jo.getChildUrl = function(treeId, treeNode){
        return jo.getDefVal(treeNode.childUrl,jo.getCode(jo.zTrees[treeId]["childUrl"],jo.address));
    };
    //[Func] 异步获取到数据后的处理
    jo.dealChildData = function(treeId, parentNode, responseData){
        return responseData.data;
    };
    //[Func] jo的zTree默认点击事件,回显数据
    jo.zTreeOnClick = function(event,treeId,treeNode){
        //回显字段默认是节点id字段和显示文本字段,树选择框与父亲属于同一个DOM时有效
        var _fieldId = jo.getDefVal(jo.zTrees[treeId]["field_id"],jo.zTrees[treeId]["item_id"]);
        var _fieldName = jo.getDefVal(jo.zTrees[treeId]["field_name"],jo.zTrees[treeId]["item_show"]);
        var _txtId = jo.zTrees[treeId]["txt_id"];
        if(jo.isValid(_txtId)){jo._("#"+_txtId).val(treeNode[jo.getDefVal(_fieldId,"id")]);}
        var _txtName = jo.zTrees[treeId]["txt_name"];
        if(jo.isValid(_txtName)){jo._("#"+_txtName).val(treeNode[jo.getDefVal(_fieldName,"name")]);}
    };
    //[Func] 获取zTree树对象
    jo.getZTreeObj = function(treeId){
        return $.fn.zTree.getZTreeObj(treeId);
    };
    //[Func] 获取zTree树选中的节点对象数组
    jo.getZTreeCheckedNodes = function(treeId){
        var treeObj = jo.getZTreeObj(treeId);
        return treeObj.getCheckedNodes(true);
    };
    //[Func] 获取zTree树选中的节点id,逗号拼接,默认拼接ID属性,可通过传入id参数指定拼接的属性
    jo.getZTreeCheckedNodesIds = function(treeId, id){
        var nodes = jo.getZTreeCheckedNodes(treeId);
        //获取勾选中的节点ID
        var navIds = "";
        for(var i=0;i<nodes.length;i++){
            navIds += "," + nodes[i][jo.getDefVal(id, "ID")];
        }
        return jo.isValid(navIds) ? navIds.substring(1) : "";
    };
    //zTree--END---
})();
//jo树操作初始化结束

//jo弹出窗口初始化
(function () {
    //[Attr] 存放弹窗对象,key为弹窗的name
    jo.Win = {};
    //jo窗口类
    function JoWin(sUrl,sWidth,sHeight,sTitle,sWinName,sType,dialogElement,isFull,hasShade,oParams){
        this.name = jo.getDefVal(sWinName,"joWin");//弹窗名字
        this.url = jo.getDefVal(sUrl,"");//请求地址
        this.type = jo.getDefVal(sType,"window");//窗口类型,不同的类型有不同的布局方式,dialog:对话|window:窗口
        this.dialogElement = jo.getDefVal(dialogElement,null);
        if(jo.isValid(this.dialogElement) && typeof(this.dialogElement) == "object"){//当对话节点是真实的页面元素时,窗口大小与元素一致
            this.dialogElement.style.display = "block";
            this.width = jo.getDefVal(this.dialogElement.offsetWidth+12+"px",jo.getDefVal(sWidth,"70%"));
            this.height = jo.getDefVal(this.dialogElement.offsetHeight+"px",jo.getDefVal(sHeight,"80%"));
        }else{
            this.width = jo.getDefVal(sWidth,"70%");//宽度
            this.height = jo.getDefVal(sHeight,"80%");//高度
        }
        this.initMargin();//初始化外边距,定位
        this.title = jo.getDefVal(sTitle,"编辑");//标题
        this.isFull = jo.getDefVal(isFull,false);//是否最大化
        this.hasShade = jo.getDefVal(hasShade,true);//是否有遮罩层
        this.params = jo.getDefVal(oParams,{});//其他参数,对象类型
        this.shadeClass = "joWinShade";//遮罩层样式
        if(this.hasShade){
            this.placeClass = "joWinPlace";//窗口位置,大小样式
        }else{//没有遮罩层时,使用joWinPlace_noShade样式
            this.placeClass = "joWinPlace_noShade";//窗口位置,大小样式
        }
        this.init();//初始化
        jo.Win[this.name] = this;//将窗口对象放入jo.Win,方便调用
    };
    //JoWin原型方法
    JoWin.prototype = {
        initMargin : function(){
            //计算位置,默认居中
            var wW = window.innerWidth;
            var wH = window.innerHeight;
            var _w = wW * 0.7;
            var _h = wH * 0.6;
            if(typeof(this.width) == "number"){
                _w = this.width;
            }else{
                if(this.width.indexOf("%") >= 0){//百分比表示
                    var t = this.width.replace("%","").trim();
                    _w = parseInt(t)/100 * wW;
                }else{
                    _w = jo.getSizeNum(this.width);
                }
            }
            if(typeof(this.height) == "number"){
                _h = this.height;
            }else{
                if(this.height.indexOf("%") >= 0){//百分比表示
                    var t = this.height.replace("%","").trim();
                    _h = parseInt(t)/100 * wH;
                }else{
                    _h = jo.getSizeNum(this.height);
                }
            }
            var left = parseInt((wW - 20 - _w) / 2);//距离左
            var top = parseInt((wH - 2 - _h) / 2) - 10;//距离上
            this.left = left;
            this.top = top;
        },
        //窗口初始化
        init : function(){
            this.scroll = window.document.body.style.overflow;
            window.document.body.style.overflow = "hidden";//去除页面滚动条
            if(this.hasShade){//存在遮罩层,则对其进行初始化
                this.initShade();
            }
            this.initPlace();//初始化位置和大小
            this.initLayout();//初始化布局
            this.initMain();//初始化主区域
        },
        //初始化遮罩层
        initShade : function(){
            var shadeElement = document.createElement("div");
            //遮罩层ID为窗口名字+Shade
            shadeElement.setAttribute("id", jo.getDefVal(this.name+"Shade","joShade"));
            //遮罩层样式为joWinShade
            shadeElement.setAttribute("class", this.shadeClass);
            //shadeElement.appendChild(document.createTextNode(""));
            document.body.appendChild(shadeElement);
            this.shadeElement = shadeElement;//将该遮罩层元素存入对象
        },
        //初始化弹窗位置,大小
        initPlace : function(){
            var ePlace = document.createElement("div");
            ePlace.setAttribute("id", jo.getDefVal(this.name+"Place","joPlace"));
            ePlace.setAttribute("class", this.placeClass);
            if(jo.isValid(this.dialogElement) && typeof(this.dialogElement) && !jo.isValid(this.url)){
                ePlace.style.width = this.width;
                ePlace.style.height = this.height;

            }else{
                ePlace.style.width = this.width;
                ePlace.style.height = this.height;
                /*ePlace.style.width = this.width;
                ePlace.style.height = this.height;*/
            }
            //alert(this.width+"\n"+this.left+"\n"+ePlace.style.width+"--"+ePlace.style.height);
            if(this.hasShade){//存在遮罩层,则插入到遮罩层中
                //ePlace.style.marginTop = this.top + "px";
                //ePlace.style.marginLeft = this.left + "px";
                ePlace.style.top = this.top + "px";
                ePlace.style.left = this.left + "px";
                this.shadeElement.appendChild(ePlace);
            }else{
                ePlace.style.top = this.top + "px";
                ePlace.style.left = this.left + "px";
                document.body.appendChild(ePlace);
            }
            //添加事件,用于拖拽
            var mFlag = false;//拖拽开关
            var iTop = 0;//光标距离顶部
            var iLeft = 0;//光标距左
            var objTop = 0;//拖拽对象距上
            var objLeft = 0;//拖拽对象距左
            //鼠标按下事件
            ePlace.onmousedown = function(event){
                mFlag = true;//打开开关
                iTop = event.clientY;
                iLeft = event.clientX;
                var obj = event.currentTarget;//拖拽对象
                objTop = obj.offsetTop;
                objLeft = obj.offsetLeft;
            };
            //鼠标松开停止拖拽
            ePlace.onmouseup = function(event){
                mFlag = false;//关闭开关
            };
            //鼠标移动时进行拖拽
            ePlace.onmousemove = function(event){
                if(mFlag){//拖拽开关开启时进行拖拽操作,也就是鼠标左键按下不松手进行拖拽
                    var newTop = event.clientY;
                    var newLeft = event.clientX;
                    var obj = event.currentTarget;//拖拽对象

                    //新位置=原位置+变化距离
                    objTop = objTop + (newTop - iTop);
                    objLeft = objLeft + (newLeft - iLeft);

                    //更新参数
                    iTop = newTop;
                    iLeft = newLeft;

                    //修改位置
                    obj.style.top = objTop + "px";
                    obj.style.left = objLeft + "px";


                }
            };
            //鼠标移出元素,关闭拖拽
            ePlace.onmouseout = function(event){
                mFlag = false;//关闭开关
            };
            this.placeElement = ePlace;
        },
        //初始化弹窗布局
        initLayout : function(){
            if(this.type == "dialog"){
                //对话类型的弹窗,没有布局,place元素下全是内容,直接初始化Main
            }else{
                //关闭按钮
                var btn_close = "<a href='javascript:jo.Win.close(\""+this.name+"\")' class='joWinClose'></a>";
                //放大缩小按钮
                var btn_chengeSize = "<a href='javascript:jo.Win.changeSize(\""+this.name+"\")' class='joWinSize'></a>";
                //刷新按钮
                var btn_refresh = "<a href='javascript:jo.Win.refresh(\""+this.name+"\")' class='joWinRefresh'></a>";
                var layout = "<table class='joWinTb' id='"+this.name+"Tb' cellpadding='0' cellspacing='0'>";
                layout += "<tr>" +
                    "<td class='td_11'></td>" +
                    "<td>" +
                    "<table class='joWinTb_title' cellpadding='0' cellspacing='0'>" +
                    "<tr>" +
                    "<td class='joWinTb_title_font' id='"+this.name+"Title'>"+this.title+"</td>" +
                    "<td class='joWinTb_title_btn'>" + btn_close + btn_chengeSize + btn_refresh + "</td>" +
                    "</tr>" +
                    "</table>" +
                    "</td>" +
                    "<td class='td_13'></td>" +
                    "</tr>";
                layout += "<tr>" +
                    "<td class='td_21'></td>" +
                    "<td style='vertical-align:top;height:100%;'>" +
                    "<div id='"+this.name+"Main' class='joWinMain'>" +
                    "</div>" +
                    "</td>" +
                    "<td class='td_23'></td>" +
                    "</tr>";
                layout += "<tr>" +
                    "<td class='td_31'></td>" +
                    "<td class='td_32'></td>" +
                    "<td class='td_33'></td>" +
                    "</tr>";
                layout += "</table>";
                this.placeElement.innerHTML = layout;
                this.titleElement = document.getElementById(this.name+"Title");
                var mainElement = document.getElementById(this.name+"Main");
                this.mainElement = mainElement;
            }
        },
        //初始化主要内容
        initMain : function(){
            if(jo.isValid(this.url)){//url有效,则生成iframe元素
                var iframe = document.createElement("iframe");
                iframe.setAttribute("name", this.name+"Iframe");
                iframe.setAttribute("src", this.url);
                iframe.setAttribute("class", "joWinIframe");
                iframe.setAttribute("id", this.name+"Iframe");
                if(this.type == "dialog"){
                    this.placeElement.appendChild(iframe);
                }else{
                    this.mainElement.appendChild(iframe);
                }
                this.iframeElement = iframe;
            }else{//没有url,则生成html元素
                if(typeof(this.dialogElement) == "object"){//插入的是节点
                    if(this.type == "dialog"){
                        this.dialogElement.style.display = "block";//显示
                        this.placeElement.appendChild(this.dialogElement);
                    }else{
                        this.dialogElement.style.display = "block";//显示
                        this.mainElement.appendChild(this.dialogElement);
                    }
                }else{//插入的是html代码
                    if(this.type == "dialog"){
                        this.placeElement.innerHTML = this.dialogElement;
                    }else{
                        this.mainElement.innerHTML = this.dialogElement;
                    }
                }
            }
        },
        //关闭弹窗
        close : function(){
            window.document.body.style.overflow = this.scroll;//恢复页面滚动条
            if(this.hasShade){//存在遮罩层,直接移除遮罩
                if(jo.isValid(this.dialogElement) && typeof(this.dialogElement) == "object"){
                    //还原元素
                    document.body.appendChild(this.dialogElement);
                }
                jo.remove(this.shadeElement);
            }else{//不存在遮罩,移除定位层
                jo.remove(this.placeElement);
            }
        },
        //最大化,最小化
        changeSize : function(){
            if(this.isFull){//已经是最大化,变小
                this.placeElement.style.width = this.width;
                this.placeElement.style.height = this.height;
                if(!this.hasShade){//没有遮罩,添加边距
                    this.placeElement.style.top = this.top + "px";
                    this.placeElement.style.left = this.left + "px";
                }else{
                    //this.placeElement.style.marginLeft = this.left + "px";
                    //this.placeElement.style.marginTop = this.top + "px";
                    this.placeElement.style.top = this.top + "px";
                    this.placeElement.style.left = this.left + "px";
                }
                //布局大小变化
                this.isFull = false;
                this.refresh();
            }else{//不是最大化,变大
                this.placeElement.style.width = "100%";
                this.placeElement.style.height = "100%";
                if(!this.hasShade){//没有遮罩,去除外边距
                    this.placeElement.style.top = "0px";
                    this.placeElement.style.left = "0px";
                }else{
                    //this.placeElement.style.marginLeft = "0px";
                    //this.placeElement.style.marginTop = "0px";
                    this.placeElement.style.top = "0px";
                    this.placeElement.style.left = "0px";
                }
                this.isFull = true;//改变状态
                this.refresh();
            }
        },
        //刷新
        refresh : function(){
            window[this.name+"Iframe"].location.href = window[this.name+"Iframe"].location.href;
        }
    };
    //[Func] 关闭弹窗
    jo.Win.close = function(sWinName){
        if(jo.isValid(sWinName)){
            jo.Win[sWinName].close();
        }else{
            var tName = "";
            for(var n in jo.Win){
                tName = n;
            }
            //删除最后一个
            if(jo.isValid(tName)){
                jo.Win[tName].close();
            }else{
                jo.showMsg("获取弹窗name属性失败!");
            }
        }
    };
    //[Func] 弹窗最大/最小化
    jo.Win.changeSize = function(sWinName){
        jo.Win[sWinName].changeSize();
    };
    //[Func] 刷新弹窗
    jo.Win.refresh = function(sWinName){
        jo.Win[sWinName].refresh();
    };

    //[Func] 弹出对话窗dialog,插入的是html节点元素对象或者代码,暂时不支持url
    jo.showDialog = function(dialogElement,sWinName,hasShade){
        if(jo.isValid(dialogElement)){
            new JoWin('','','','',jo.getDefVal(sWinName,"dialog"),"dialog",dialogElement,'',hasShade,'');
        }
    };
    //[Func] 弹出窗口,插入的是url
    jo.showWin = function(sUrl,sWidth,sHeight,sTitle,sWinName,isFull,hasShade){
        if(jo.isValid(sUrl)){
            new JoWin(sUrl,sWidth,sHeight,sTitle,sWinName,'window','',isFull,hasShade,'');
        }
    };
    //[Func] 弹出对话窗口,插入的是元素
    jo.showDialogWin = function(dialogElement,sTitle,sWinName,hasShade){
        if(jo.isValid(dialogElement)){
            new JoWin('','','',sTitle,jo.getDefVal(sWinName,"dialogWin"),"window",dialogElement,'',hasShade,'');
        }
    };


    //[Func] 弹出选择列表窗口
    jo.selectList = function(sUrl,inpId,inpName,fieldId,fieldName,multiple,callback){
        //[Attr] 选择框参数
        jo.selectParams = {
            "url" : sUrl,
            "field_id" : jo.getDefVal(fieldId,"ID"),
            "field_text" : jo.getDefVal(fieldName,"NAME"),
            "id" : jo.getDefVal(inpId,""),
            "text" : jo.getDefVal(inpName,""),
            "multiple" : jo.getDefVal(multiple,false)
        };
        if(typeof(callback) == "function"){
            //[Func] 列表选择的回调函数,
            //参数1[status]表示回调类型,true表示确定按钮的回调,false表示取消的回调
            //参数2[checkedIds]表示选中项ids,多个使用逗号间隔
            //参数3[checkedNames]表示选中项names,多个使用逗号间隔
            jo.selectListCall = callback;
        }
        //弹出窗口
        return jo.showWin(contextPath+"common/choice_list.jsp","400px","80%","选择");
    };

    //[Func] 弹出选择树窗口,参数zTreeParamOrCallBack表示ztee树的参数(jo.drawZTree的参数),或者是初始化树的方法(参数为ajax返回结果)
    jo.selectTree = function(sUrl,inpId,inpName,fieldId,fieldName,fieldPid,multiple,callback,zTreeParamOrCallBack,nodeCanChoiceCallBack,drawBeforeCallBack){
        //[Attr] 选择框参数
        jo.selectParams = {
            "url" : sUrl,
            "field_id" : jo.getDefVal(fieldId,"ID"),
            "field_text" : jo.getDefVal(fieldName,"NAME"),
            "field_pid" : jo.getDefVal(fieldPid,"PARENT_ID"),
            "id" : jo.getDefVal(inpId,""),
            "text" : jo.getDefVal(inpName,""),
            "multiple" : jo.getDefVal(multiple,false)
        };
        if(typeof(callback) == "function"){
            //[Func] 列表选择的回调函数,
            //参数[status]表示回调类型,true表示确定按钮的回调,false表示取消的回调
            //参数2[checkedIds]表示选中项ids,多个使用逗号间隔
            //参数3[checkedNames]表示选中项names,多个使用逗号间隔
            jo.selectListCall = callback;
        }

        //生成树回调
        if(typeof(zTreeParamOrCallBack) == "function"){//回调有2个参数,参数1为ajax返回的结果result,参数2为选择框window对象
            jo.selectTreeDrawTree = zTreeParamOrCallBack;
        }else{
            jo.selectParams["zTreeParam"] = zTreeParamOrCallBack;
        }

        //选择树的节点是否可选回调函数,参数为树节点对象
        if(typeof(nodeCanChoiceCallBack) == "function"){
            jo.selectTreeNodeCanChoice = nodeCanChoiceCallBack;
        }

        //生成树之前的处理回调
        if(typeof(drawBeforeCallBack) == "function"){
            jo.selectTreeDrawBefore = drawBeforeCallBack;
        }

        //弹出窗口
        return jo.showWin(contextPath+"common/choice_tree.jsp","400px","80%","选择");
    };

    //[Func] 弹出图标选择窗口,回调参数为所选择的图标class属性
    jo.selectIcon = function(inpIdOrCallback){
        //弹出图标选择窗口的图标单击事件:参数为图标的class属性
        if(typeof(inpIdOrCallback) == "function"){
            jo.iconSelectClick = inpIdOrCallback;//自定义回调
        }else{
            //默认回调
            jo.iconSelectClick = function(sClass){
                $("#"+jo.getDefVal(inpIdOrCallback, "ICON")).val(sClass);
                jo.Win.close();
            }
        }
        //弹出窗口
        return jo.showWin(contextPath+'common/choice_icon.jsp','520px','320px','选择图标');
    };
})();
//jo弹出窗口初始化结束

//jo 对象型插件初始化
(function(){
    //[Object] 倒计时对象,参数格式:"HH:MM:SS" 时分秒,callBack为回调函数
    function TimeDown(sTime,callBack,overCallBack){
        var arr = sTime.split(":");
        this.val = sTime;
        this.HH = parseInt(arr[0]);
        this.MM = parseInt(arr[1]);
        this.SS = parseInt(arr[2]);
        function start_(sVal){
            var HH = parseInt(sVal.split(":")[0]);
            var MM = parseInt(sVal.split(":")[1]);
            var SS = parseInt(sVal.split(":")[2]);
            if(SS > 0){//秒大于0
                SS -= 1;
            }else{//秒为0
                if(MM > 0){//分大于0
                    MM -= 1;//分减1
                    SS = 59;//秒调到59
                }else{//分秒都为0
                    if(HH > 0){//时大于0
                        HH -= 1;//时减1
                        MM = 59;//分调到59
                        SS = 59;//秒也调到59
                    }else{//时分秒都为0,倒计时结束
                        if(typeof(overCallBack) == "function"){
                            overCallBack();
                        }else{
                            alert("时间到!");
                        }
                        return;
                    }
                }
            }
            var res = (HH<10? "0"+HH : HH) + ":" + (MM<10? "0"+MM : MM) + ":" + (SS<10? "0"+SS : SS);
            var val = res;
            if(jo.isValid(callBack) && typeof(callBack) == "function"){
                callBack(res);//回调函数
            }
            setTimeout(function(){start_(val)},1000);
        }

        this.start = function(){
            start_(this.val);
        };
    }

    //[Func] jo暴露出的调用倒计时插件的接口方法,按秒倒计时
    jo.timeDown = function(sTime,callBack){
        new TimeDown(sTime,callBack).start();
    };
})();
//jo 对象型插件初始化结束

//jo特效处理初始化
(function(){
    //设置拖拽
    jo.setMove = function(element){
        //默认为绝对定位
        if(jo.getDefVal(element.style.position,"") != "absolute"){
            element.style.position = "absolute";
        }
        var mFlag = false;//拖拽开关
        var iTop = 0;//光标距离顶部
        var iLeft = 0;//光标距左
        var objTop = 0;//拖拽对象距上
        var objLeft = 0;//拖拽对象距左
        //鼠标按下事件
        element.onmousedown = function(event){
            mFlag = true;//打开开关
            iTop = event.clientY;
            iLeft = event.clientX;
            var obj = event.currentTarget;//拖拽对象
            objTop = obj.offsetTop;
            objLeft = obj.offsetLeft;
        };
        //鼠标松开停止拖拽
        element.onmouseup = function(event){
            mFlag = false;//关闭开关
        };
        //鼠标移动时进行拖拽
        element.onmousemove = function(event){
            if(mFlag){//拖拽开关开启时进行拖拽操作,也就是鼠标左键按下不松手进行拖拽
                var newTop = event.clientY;
                var newLeft = event.clientX;
                var obj = event.currentTarget;//拖拽对象

                //新位置=原位置+变化距离
                objTop = objTop + (newTop - iTop);
                objLeft = objLeft + (newLeft - iLeft);

                //更新参数
                iTop = newTop;
                iLeft = newLeft;

                //修改位置
                obj.style.top = objTop + "px";
                obj.style.left = objLeft + "px";
                //alert(obj.style.top+"\n"+obj.style.left);

            }
        };
        //鼠标移出元素,关闭拖拽
        element.onmouseout = function(event){
            mFlag = false;//关闭开关
        };
    };

    //[Func] 元素设置箭头控制移动
    jo.setMoveByKey = function(element,bFlag){
        var kFlag = jo.getDefVal(bFlag,false);//键盘控制移动的开关
        var kTop = kBottom = kLeft = kRight = false;
        var kTimer = null;//轮询监听控制
        var moveObj = element;
        var ix = 10;//每次移动的距离
        var ims = 30;//灵敏度(越小越灵敏).2次移动之间的时间间隔
        //初始化移动事件
        if(kFlag){
            kTimer = window.setInterval(function(){
                if(kFlag){
                    if(kTop){
                        moveObj.style.top = moveObj.offsetTop - ix + "px";
                    }else if(kBottom){
                        moveObj.style.top = moveObj.offsetTop + ix + "px";
                    }else if(kLeft){
                        moveObj.style.left = moveObj.offsetLeft - ix + "px";
                    }else if(kRight){
                        moveObj.style.left = moveObj.offsetLeft + ix + "px";
                    }
                }
            },ims);
        }
        //鼠标点击该元素,控制移动开关
        element.onclick = function(event){
            kFlag = !kFlag;
            if(kFlag){
                moveObj = event.currentTarget;
                kTimer = window.setInterval(function(){
                    if(kFlag){
                        if(kTop){
                            moveObj.style.top = moveObj.offsetTop - ix + "px";
                        }else if(kBottom){
                            moveObj.style.top = moveObj.offsetTop + ix + "px";
                        }else if(kLeft){
                            moveObj.style.left = moveObj.offsetLeft - ix + "px";
                        }else if(kRight){
                            moveObj.style.left = moveObj.offsetLeft + ix + "px";
                        }
                    }
                },ims);
            }else{
                if(kTimer){
                    clearInterval(kTimer);
                }
            }
        };
        //上下左右键捕捉
        document.onkeydown = function(event){
            var keyCode = event.keyCode;

            switch(keyCode){
                case 37:
                    kLeft = true;
                    break;
                case 38:
                    kTop = true;
                    break;
                case 39:
                    kRight = true;
                    break;
                case 40:
                    kBottom = true;
                    break;
            }
        };
        document.onkeyup = function(event){
            var keyCode = event.keyCode;

            switch(keyCode){
                case 37:
                    kLeft = false;
                    break;
                case 38:
                    kTop = false;
                    break;
                case 39:
                    kRight = false;
                    break;
                case 40:
                    kBottom = false;
                    break;
            }
        };
    };
})();
//jo特效处理初始化结束

//jo组件相关初始化开始
//下拉列表模型
var JoSelectTool = {};//jo下拉组件池
function JoSelect(obj){
    //初始化数据
    this.element = obj;
    this.data = new Array();//下拉列表数据
    this.keyField = jo.getDefVal(this.element.getAttribute("keyField"),"ID");//选项key字段
    this.valueField = jo.getDefVal(this.element.getAttribute("valueField"),"NAME");//选项value字段
    this.firstItem = null;
    this.async = false;//异步标识,默认为false(同步)
    this.state = 1;//组件状态,默认为1(新建状态),状态分别是: 1(新建),2(正在初始化),3(正在装载/格式化),4(正常状态)
    var _async = this.element.getAttribute("async");//异步属性
    if(typeof (_async) == 'boolean' && _async == true){
        this.async = true;
    }else if(typeof (_async) == 'string' && _async == 'true'){
        this.async = true;
    }else if(typeof (_async) == 'string' && _async == '1'){
        this.async = true;
    }else if(typeof (_async) == 'string' && _async == 'yes'){
        this.async = true;
    }
    this.id = jo.getDefVal(this.element.getAttribute("id"), this.element.getAttribute("name"));
    if(this.id){
        JoSelectTool[this.id] = this;//缓存当前下拉对象
    }else{
        console.warn("JoSelect查找id和name属性失败,请确认该下拉框相关属性有效!此错误可能会导致事件监听异常!");
    }
    this.event = {};//事件
    this.waitValue = null;//等待设置的属性值,设置完成后需要清空
    /**
     * 设置值
     * 如果调用此方法时组件还没有装载完毕,则会等到装载结束后进行赋值
     * 最差的情况是会执行2次赋值操作,但没有任何影响
     * @param val 值
     */
    this.setValue = function(val){
        //放在这里缓存,而不是放在下面的else代码块,主要是为了解决因为线程安全问题带来值未正确设置问题
        //比如:在判断状态==4失败之后,在缓存waitValue之前,组件装载完毕,状态回归4,最后才执行的设置waitValue,此时会导致值没有得到设置
        //将此操作提前在状态判断之前可以避免上述问题,唯一的不足是可能会发生2次设置值的操作,但是不影响,重复设置相同的值不会像上述问题一样带来不可原谅的错误
        this.waitValue = val;
        if(this.state == 4){//正常状态,则直接赋值
            //注释掉该行主要还是为了那一丢丢的出错可能性,注释掉后就算会赋值2次起码不会有赋值null的情况
            //this.waitValue = null;//保证在设置值之后该属性为null,多线程下有可能会导致设置2次值,而那一次可能会设置null
            this.element.value = val;
        }
    };
    /**
     * 注册事件,支持同一事件个回调
     * 要注意注册顺序,只有在回调时间点前注册才有效
     * @param eventName 事件名称,loaded:加载完成事件
     * @param callback 事件对应的回调函数
     */
    this.on = function(eventName, callback){
        if(this.event[eventName]){//存在此事件
            this.event[eventName].push(callback);
        }else{
            this.event[eventName] = [callback];
        }
    };
    /**
     * 初始化
     */
    this.init = function(){
        this.state == 2;//初始化状态,因为本方法总是会调用load()方法,所以不需要考虑方法结束时状态是什么
        this.showLoading("正在加载...");
        if(jo.isValid(this.element.getAttribute("firstItem"))){
            this.firstItem = JSON.parse(this.element.getAttribute("firstItem"));
        }
        //存在请求地址,则获取数据
        if(jo.isValid(this.element.getAttribute("dataUrl"))){
            //请求该地址的数据
            var _this = this;//定义_this指向当前对象,处理回调等函数内部不识别this
            //定义获取列表数据后的执行函数
            var _temp = function(){
                var sData = jo.getDefVal(_this.element.getAttribute("data"),"");
                if(jo.isValid(sData)){
                    if(typeof(sData) == "string"){
                        _this.data = eval(sData);
                    }else{
                        _this.data = sData;
                    }
                }else{
                    console.warn("下拉列表组件数据来源信息为空!");
                }
                _this.load();//装载 数据
            };
            var sUrl = this.element.getAttribute("dataUrl");//数据地址
            sUrl = jo.parseUrl(sUrl);
            /*$.getJSON(sUrl, function(result){
                _this.element.setAttribute("data",JSON.stringify(result.data));
                _temp();
            });*/
            jo.postAjax(sUrl, {}, function(result){
                _this.element.setAttribute("data",JSON.stringify(result.data));
                _temp();
            }, this.async);
        }else{
            var sData = jo.getDefVal(this.element.getAttribute("data"),"");
            if(jo.isValid(sData)){
                if(typeof(sData) == "string"){
                    this.data = eval(sData);
                }else{
                    this.data = sData;
                }
            }else{
                console.log("下拉列表组件数据来源信息为空!");
            }
            this.load();//装载 数据
        }
    };
    //加载,参数为数组类型
    this.load = function(oData){
        this.state == 3;//装载状态
        if(oData){
            this.data = oData;
            this.element.setAttribute("data",JSON.stringify(oData));
        }
        if(this.data && this.data.length){
            var _html = '';
            var k = this.keyField;
            var v = this.valueField;
            if(jo.isValid(this.firstItem)){
                _html += '<option value="'+this.firstItem[k]+'">' + this.firstItem[v] + '</option>';
            }
            for(var i=0;i<this.data.length;i++){
                var item = this.data[i];
                _html += '<option value="'+item[k]+'">' + jo.parseKey(item, v) + '</option>';
            }
            this.element.innerHTML = _html;
        }else{
            this.element.innerHTML = '<option value=""></option>';//默认为空,如果什么都没有,在表单取值时会有问题
        }

        //joSelect装载完成事件
        if(this.event["loaded"]){
            for(var i=0;i<this.event["loaded"].length;i++){
                this.event["loaded"][i](this);//回调
            }
        }
        this.state == 4;//正常使用状态
        if(this.waitValue != null){//等待设置的值不为null,则进行赋值
            this.element.value = this.waitValue;
            this.waitValue = null;//设置完后,继续回归null
        }
        console.info("JoSelect["+this.id+"]装载完成!");
    };
    //显示正在加载
    this.showLoading = function(str){
        if(str == false){

        }else{
            this.element.innerHTML = '<option value="">'+jo.getDefVal(str,"正在加载...")+'</option>';
        }
    };
}
/**
 * Grid中的Col对象,记录Grid中每一列的相关属性
 * @param jqColElement col标签对应的jq对象
 * @returns
 */
function Col(jqColElement){
    this.obj = jqColElement;
    this.field = jo.getDefVal(jqColElement.attr("field"),"");
    this.title = jo.getDefVal(jqColElement.attr("title"),"");
    this.width = jo.getDefVal(jqColElement.attr("width"),"");
    this.align = jo.getDefVal(jqColElement.attr("align"),"center");//表格内容水平位置
    this.event = jo.getDefVal(jqColElement.attr("event"),"none");
    this.headAlign = jo.getDefVal(jqColElement.attr("headAlign"),"center");//标题水平位置,默认居中
    this.order = jo.getDefVal(jqColElement.attr("order"),"");//列排序标记
    //col对象转json,供joView使用
    this.col2Json = function(){
        var col = {};
        col["field"] = this.field;
        col["title"] = this.title;
        col["width"] = this.width;
        col["align"] = this.align;
        col["event"] = this.event;
        col["headAlign"] = this.headAlign;
        col["order"] = this.order;
        console.log("colfinal" + col);
        return col;
    };
}
/**
 * Grid对象,记录Grid表格相关属性,传入的不是字符串时要使用new关键字
 * @param jqGridElement Grid表格对应的jq对象
 * @returns
 */
var GridTool = {};
function Grid(jqGridElement){
    if(typeof (jqGridElement) == "string"){//当传入表格id时
        if(GridTool[jqGridElement]){//如果已存在,返回引用
            return GridTool[jqGridElement];
        }else{
            //必须使用new关键字,原先不使用new关键字的方式会导致this指向的是window对象(不是我们想要的Grid对象)
            return new Grid($("#"+jqGridElement));
        }
    }
    this.obj = $(jqGridElement);//记录该Grid对象(jq对象)
    this.dataUrl = jo.getDefVal(this.obj.attr("dataUrl"),"");//数据源url
    this.deleteUrl = jo.getDefVal(this.obj.attr("deleteUrl"),"");//删除数据的url
    this.formUrl = jo.getDefVal(this.obj.attr("formUrl"),"");//打开表单对应的url
    this.cols = new Array();//Col对象数组
    this.data = null;//表格数据
    this.titleInited = false;//标记标题初始化状态
    this.titleCss = jo.getDefVal(this.obj.attr("titleCss"), "");//标题行样式
    this.trClick = jo.getDefVal(this.obj.attr("trClick"),"");//行点击事件方法名,推荐不带括号
    this.noHead = jo.getDefVal(this.obj.attr("noHead"), "false");//不要标题行
    this.trHandle = jo.getDefVal(this.obj.attr("trHandle"), "");//行处理函数,生成表格行之前的行对象处理,参数1为行数据对象,参数2为在数据中的位置索引
    if(typeof this == "object"){
        this.id = this.obj.attr("id");
        GridTool[this.id] = this;//将此Grid引用存入池中,方便下次获取
    }
    //初始化
    var _cols = this.obj.find("col");
    if(_cols && _cols.length > 0){//存在col配置
        for(var i=0;i<_cols.length;i++){
            var col = new Col($(_cols[i]));
            this.cols.push(col);
            jo.remove(_cols[i]);//记录结束col数据后删除,原因: 不删除会影响宽度属性异常
        }
    }
    //添加thead和tbody标签,用于存放标题行和内容
    this.obj.html("");
    //返回该Grid对象的colsInfo信息,供joView使用
    this.colsInfo = function(){
        var _colsInfo = new Array();
        for(var i=0;i<this.cols.length;i++){
            _colsInfo.push(this.cols[i].col2Json());
        }
        return _colsInfo;
    };
    //清空数据
    this.clearData = function(){
        $("#myTileGrid").html("");
        this.data = null;
    };
}
/**
 * Grid表格排序事件
 * @param element 被点击元素this
 * @param isAsc 是否升序
 * @constructor
 */
function GridOrder(element, isAsc){
    var grid = GridTool[$(element).attr("grid")];//待排序表格
    var field = $(element).attr("field");//待排序字段
    var p = $(element).parent();//排序容器
    var arr = p.find("div");//0为升序,1为降序
    //将表格下所有的排序图标重置
    grid.obj.find(".order-asc").removeClass("fa-caret-up");
    grid.obj.find(".order-desc").removeClass("fa-caret-down");
    grid.obj.find(".order-asc").addClass("fa-angle-up");
    grid.obj.find(".order-desc").addClass("fa-angle-down");
    if(arr){
        if(isAsc){
            $(arr[0]).removeClass("fa-angle-up");
            $(arr[0]).addClass("fa-caret-up");//变成实心图标
            //$(arr[1]).removeClass("fa-caret-down");
            //$(arr[1]).addClass("fa-angle-down");
            //对数据排序
            if(grid){
                jo.sort(grid.data, function(a, b){
                    return a[field] < b[field];
                });
                grid.loadData(grid.data);
            }
        }else{
            $(arr[1]).removeClass("fa-angle-down");
            $(arr[1]).addClass("fa-caret-down");//变成实心图标
            //$(arr[0]).removeClass("fa-caret-up");
            //$(arr[0]).addClass("fa-angle-up");
            //对数据排序
            if(grid){
                jo.sort(grid.data, function(a, b){
                    return a[field] > b[field];
                });
                grid.loadData(grid.data);
            }
        }
    }
}
(function(){
    /**
     * [Func] jo组件统一格式化ui入口,组件默认采用同步方式进行格式化,避免因为异步带来的渲染顺序问题
     */
    jo.formatUI = function(){
        console.log("jo组件格式化...");
        //格式化下拉列表
        $(".joSelect").each(function(idx,ele){
            new JoSelect(ele).init();
        });
    };
})();
//jo组件相关初始化结束