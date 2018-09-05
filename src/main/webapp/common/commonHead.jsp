<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link href="<%=URL_STATIC%>static/css/common.css" rel="stylesheet">
<script src="<%=URL_STATIC%>static/js/common.js"></script>
<%--<script src="<%=URL_STATIC%>static/js/sso.js"></script>--%>
<link rel="shortcut icon" href="<%=URL_STATIC%>static/images/favicon.ico">
<script src="<%=URL_STATIC%>static/js/common_biz.js"></script>
<script type="text/javascript">
    //自定义实现视图页面表格标题行生成
    joView.setGridHead = function(){
        var showFieldsInfo = joView.params["colsInfo"];
        var checkStyle = jo.getDefVal(joView.params["checkStyle"],"");
        var _headHtml = "<tr class='def-table-header'>";
        var checkWidth = jo.getDefVal(joView.params["checkStyleWidth"],"5%");
        if(checkStyle == "checkBox"){//复选框
            _headHtml += '<th style="border-color:#4E97D9;text-align:center;width:'+checkWidth+';"><input type="checkbox" onclick="jo.checkAll(\''+joView.params["PKName"]+'\')" id="checkAll"/></th>';
        }else if(checkStyle == "radio"){//单选框
            _headHtml += '<th style="border-color:#4E97D9;text-align:center;width:'+checkWidth+';">选择</th>';
        }else if(checkStyle == "order"){
            _headHtml += '<th style="border-color:#4E97D9;text-align:center;width:'+checkWidth+';">序号</th>';
        }else{
            //不要选择框
        }
        //遍历生产表头
        for(var i=0;i<showFieldsInfo.length;i++){
            //_headHtml += '<th style="border-color:#4E97D9;width:' + showFieldsInfo[i]["width"] + ';">' + showFieldsInfo[i]["title"] + '</th>';
            var lcr = jo.getDefVal(showFieldsInfo[i]["headAlign"], 'center');//标题行文本位置,默认center
            _headHtml += '<th style="border-color:#4E97D9;text-align:'+lcr+';width:' + showFieldsInfo[i]["width"] + ';">' + showFieldsInfo[i]["title"];
            if(showFieldsInfo[i]["order"]){//当前列开启排序功能
                _headHtml += '<span style="display: inline-block;width: 1px;height: 15px;position: relative;">';/*caret*/
                _headHtml += '<div class="order-asc cursor-hand fa fa-angle-up" field="'+showFieldsInfo[i]["order"]+'" grid="'+joView.Grid.id+'" onclick="joView.orderSelect(this, true)" style="font-weight: bold;height:7px;width: 15px;padding: 0px;margin:0px;position: absolute;top:0px;"><!--<i class="fa fa-caret-up" aria-hidden="true"></i>--></div>';
                _headHtml += '<div class="order-desc cursor-hand fa fa-angle-down" field="'+showFieldsInfo[i]["order"]+'" grid="'+joView.Grid.id+'" onclick="joView.orderSelect(this, false)" style="font-weight: bold;height:7px;width: 15px;padding: 0px;margin:0px;position: absolute;bottom:0px;"><!--<i class="fa fa-caret-down" aria-hidden="true"></i>--></div>';
                _headHtml += '</span>';
            }
            _headHtml += '</th>';
        }
        _headHtml += "</tr>";
        joView.grid.find(">thead").html(_headHtml);
    };
    //默认每页显示25条
    if(joView){
        joView.params["pageSize"] = 25;
    }
    //重写jo的表单验证
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
        emptys = oForm.find("textarea[ErrEmpty]");//textarea
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
    //获取layer弹窗window对象
    jo.getLayerIframe = function(idxOrName){
        if (typeof (idxOrName) == "number"){
            return  window['layui-layer-iframe' + idxOrName];
        }else{
            return  window['layui-layer-iframe' + jo.WinMemory.get(idxOrName)];
        }
    };
    //joView分页信息展示
    joView.showPageInfo = function(result){
        var pageBar = $(".page-bar");//分页条
        //验证是否有分页条
        if(!pageBar || !pageBar.attr("class")){
            console.info("分页条未发现!");
            return;
        }
        //验证分页必要参数的有效性
        if(!jo.isValid(result.pageSize) || !jo.isValid(result.pageNumber) /*|| !jo.isValid(result.total)*/){
            console.info("分页必要参数无效!");
            pageBar.html("");
            pageBar.hide();
            return;
        }
        var maxPageNormalBarNum = 8;//分页条保持的最大可点击块的数量,确保在页数很多的时候也最多显示8个小块块
        var currentPage = result.pageNumber;//当前页
        joView.params["currentPage"] = currentPage;
        var totalPage = Math.ceil(result.total/result.pageSize);//总页数
        var totalCount = result.total;//记录总数

        if(totalCount < 1 && currentPage == 1){
            console.info("第一页总记录数小于1,隐匿分页条!");
            pageBar.html(" 暂无数据!");
            pageBar.removeClass("page-bar-float");
            //$(".table-responsive").removeClass("margin-bottom-40");
            $("body").removeClass("padding-bottom-40");
            pageBar.show();
            return;
        }else if(totalCount < 1 && currentPage > 1){
            console.error("[分页条异常] 总记录数小于1，但是当前页大于1。可能是在查询该页记录之前记录发生了删除！");
        }

        var first = '<li onclick="joView.goPage(1)"><a>首页</a></li>';//首页
        var last = '<li onclick="joView.goPage('+(currentPage-1)+')"><a>上一页</a></li>';//上一页
        var normal = '<li class="active" onclick="joView.goPage(1)"><a>1</a></li>';//普通的页数
        var next = '<li onclick="joView.goPage('+(currentPage+1)+')"><a>下一页</a></li>';//下一页
        var end = '<li onclick="joView.goPage('+totalPage+')"><a>尾页</a></li>';//尾页

        //首页和上一页
        if(currentPage > 1){
            //处理因为同步问题带来的特殊情况
            if((currentPage - totalPage) > 1){//当前页大于总页数至少1页,上一页禁用
                last = '<li class="disabled" onclick=""><a>上一页</a></li>';
            }
        }else{//当前页小于等于1,上一页和首页都禁用
            first = '<li class="disabled" onclick=""><a>首页</a></li>';
            last = '<li class="disabled" onclick=""><a>上一页</a></li>';
        }

        //下一页和尾页
        if(currentPage < totalPage){

        }else{
            next = '<li class="disabled" onclick=""><a>下一页</a></li>';
            end = '<li class="disabled" onclick=""><a>尾页</a></li>';
        }

        if(totalPage > 1){//总页数大于1时,处理分页小块
            normal = '';
            if(totalPage <= maxPageNormalBarNum){//总页数小于等于最大限制数,正常循环显示
                for(var i=0;i<totalPage;i++){
                    var n = i + 1;//页数
                    if(currentPage == n){//当前页着色
                        normal += '<li class="active" onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                    }else{
                        normal += '<li onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                    }
                }
            }else{
                var l = Math.floor(maxPageNormalBarNum/2);//中心左边个数
                var r = maxPageNormalBarNum - 1 - l;//中心右边个数

                if(currentPage <= l){
                    for(var i=0;i<maxPageNormalBarNum;i++){//这里和上面的循环的区别就在这里可以完全显示最大允许数量的块
                        var n = i + 1;//页数
                        if(currentPage == n){//当前页着色
                            normal += '<li class="active" onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                        }else{
                            normal += '<li onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                        }
                    }
                }else if(currentPage > l && currentPage < (totalPage - r)){//当前页超出限制范围一半且距离最大页也差一半时,以当前页为中心,左右扩充到限制数大小
                    var s = currentPage - l;
                    var e = currentPage + r;
                    while(s <= e){
                        if(currentPage == s){//当前页着色
                            normal += '<li class="active" onclick="joView.goPage('+s+')"><a>'+s+'</a></li>';
                        }else{
                            normal += '<li onclick="joView.goPage('+s+')"><a>'+s+'</a></li>';
                        }
                        s++;
                    }
                }else{//当前页超出右临界点
                    for(var i=0;i<maxPageNormalBarNum;i++){
                        var n = totalPage - maxPageNormalBarNum + 1 + i;//页数
                        if(currentPage == n){//当前页着色
                            normal += '<li class="active" onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                        }else{
                            normal += '<li onclick="joView.goPage('+n+')"><a>'+n+'</a></li>';
                        }
                    }
                }
            }
        }
        var _size = '';
        var _html = '';
        var pageSizeArr = joView.params["pageSizeArr"];
        //var defSize = joView.params["pageSize"];
        if(jo.isValid(pageSizeArr) && typeof(pageSizeArr) == "object"){
            //生产选择项
            var flag = false;//标记pagesize是否在备选池中
            _size += '<select class="input-sm" onchange="joView.choicePageSize(this.value)">';
            for(var i=0;i<pageSizeArr.length;i++){
                if(result.pageSize && result.pageSize == pageSizeArr[i]){
                    _size += '<option value="' + pageSizeArr[i] + '" selected="selected">' + pageSizeArr[i] + '</option>';
                    flag = true;
                }else{
                    _size += '<option value="' + pageSizeArr[i] + '">' + pageSizeArr[i] + '</option>';
                }
            }
            _size += '</select>';
            if(!flag){
                console.error("每页记录数pageSize在备选池pageSizeArr中检索不到，请检查相关参数设置！")
                _size = result.pageSize;
            }
            _html = '<div class="pull-left">当前第&nbsp;'+currentPage+"&nbsp;页，每页&nbsp;"+_size+"&nbsp;条，共&nbsp;"+totalCount+"&nbsp;条记录</div>";
        }
        _html += '<ul class="pagination pull-right">'
                + first
                + last
                + normal
                + next
                + end
                + '</ul>';
        pageBar.addClass("page-bar-float");
        pageBar.html(_html);
        //$(".table-responsive").addClass("margin-bottom-40");
        $("body").addClass("padding-bottom-40");
        pageBar.show();
    };
    /**
     * 解析字段核心方法(供具体的解析方法调用)
     * @param ids
     * @param obj
     * @returns {*}
     */
    function parseOption(ids, obj) {
        var res = "";
        if (ids) {
            if (!obj) {//映射无效则直接返回ids
                return ids;
            }
            var kv = obj;
            var arr = ids.split(",");
            for (var i = 0; i < arr.length; i++) {
                if (i != 0) {
                    res += ",";
                }
                res += jo.getDefVal(kv[arr[i]], arr[i]);//取不到值则返回key
            }
        }
        return res;
    }

    /**
     * 项目类型转换
     * @param ids
     * @param bFormat
     * @returns {*}
     */
    function parse_type(ids, bFormat) {
        var kv = {};
        if (bFormat) {//格式化开启,通常视图页面需要对不同的状态显示不同的样式
            kv = {
                "1": "<span class='bg-primary font-white padding-2'>评价大类</span>",
                "2": "<span class='bg-green font-white padding-2'>具体评价小项</span>"
            };
        } else {
            kv = {
                "1": "评价大类",
                "2": "具体评价小项"
            };
        }
        return parseOption(ids, kv);
    }
</script>
<style>
    body form .table > tbody > tr > td{
        vertical-align: middle; /*解决bootstrap表格中文字偏上的问题,原属性为top*/
        overflow:visible;white-space:normal;text-overflow: inherit; /*文字超长时显示为...*/
        /* white-space:nowrap;word-break:keep-all; overflow:hidden;text-overflow:ellipsis;*/
    }
    body .table-line-auto > tbody > tr > td{
        vertical-align: middle; /*解决bootstrap表格中文字偏上的问题,原属性为top*/
        overflow:visible;white-space:normal;text-overflow: inherit; /*文字超长时显示为...*/
        /* white-space:nowrap;word-break:keep-all; overflow:hidden;text-overflow:ellipsis;*/
    }
    .button-bar{ /*按钮栏*/
        /*position: static;
        top: 0px;*/
        background-color: inherit;
        width: 100%;
        z-index: 99;
        margin-bottom: 2px;
    }
    .button-float{
        position: fixed;
        top: 0px;
    }
    .margin-0{
        margin: 0px;
    }
    .bg{
        background-color: #F7F7F7;
    }
    .bg-white{
        background-color: #FFFFFF;
    }
    .flex-control{/*伸缩控制*/
        position: absolute;top: 0px;right: 0px;cursor: pointer;
    }
    .flex-control:hover{
        background-color: #3379B6;
        opacity: 0.8;
    }
    .panel>.panel-heading>h3.panel-title{/*.flex-control的父元素*/
        position: relative;
    }
    .def-table-header{/*默认表格标题行样式*/
        background-color: #58AFF7;
        color: #FFFFFF;
        border-top: #4E97D9 solid 1px;
    }
    .form-inline>.form-group,.form-inline>button{
        margin-bottom: 8px;
    }
    .margin-top-15{
        margin-top: 15px;
    }
    .margin-top-12{
        margin-top: 12px;
    }
    .padding-2{
        padding: 2px;
    }
    .margin-bottom-40{
        margin-bottom: 40px;
    }
    .padding-bottom-40{
        padding-bottom: 40px;
    }
    .page-bar-float{/*分页条悬浮在窗口下方*/
        position: fixed;
        bottom: 0px;
        left: 0px;
        width: 100%;
        padding: 5px 15px 3px 15px;
        background-color: white;
        clear: both;
        border-top: #DDDDDD solid 1px;
    }
    .bg-orange{
        background-color: #FF7F00;
    }
    /*body{
        font-family: "Helvetica Neue", Helvetica, "PingFang SC", 微软雅黑, Tahoma, Arial, sans-serif;
    }*/
</style>