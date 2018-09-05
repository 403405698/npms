window.joView = {};
/**
 * 接管函数列表:
 * 1.设置Grid标题:joView.setGridHead()
 * 2.设置Grid数据:joView.setGridData(oList)
 * 3.加工Grid中每个小格显示的值:joView.handleItemValue(sVal,iIndex)
 * 4.处理Grid中的行对象(可以取代接管函数3):joView.handleItem(oItem,iIndex)
 * 5.生成数据行的前置处理:joView.setGridDataBefore(oList)
 * 6.生成数据行的后置处理:joView.setGridDataAfter(oList);
 * 7.数据行的点击事件(参数为主键值):joView.clickItem(id)
 * 8.生成数据列表后的操作:joView.setGridDataAfter(oList);
 * 9.删除操作成功结束后的回调(参数1为后台返回的结果,参数2为删除的编号集):joView.delSuccessOver(result, idStr);
 */
/**
 * joView参数
 */
joView.params = {
    "transferParam" : "",//向表单页传参
    "pageSizeArr" : [10,25,50,75,100],//每页多少条选择集合
    "JS_table" : "page/js/table.js",//Grid特效,已停用
    "currentPage" : 1,//当前页,默认第一页
    "pageSize" : 10,//每页多少条
    "shouldPage" : "",//新增参数，是否分页
    "url" : "",//分页查询url
    "formData" : null,//分页查询参数(查询表单中的参数+其他参数(例如排序参数orderBy等))
    "condition" : "",//分页查询条件(自定义查询条件key=value形式)
    "colsInfo" : null,//展示列表的列信息(名称,值,宽度等)
    "checkStyle" : "checkBox",//选择框样式,checkBox:多选框|radio:单选框|order:序号|none:没有选择框
    "checkStyleWidth" : "5%",//选择框宽度,默认5%
    "PKName" : "ID",//主键
    "formUrl" : "",//[新增/修改]表单地址
    "deleteUrl" : "",//[删除]数据的url
    "dataUrl" : "",//[Grid数据]的url
    "grid" : null//grid表格jq对象	2017-06-16新增参数
    ,"formWidth" : "650px"//表单窗口的宽度，新界面area: ['650px', '390px'],
    ,"formHeight" : "80%"//表单窗口的高度,2018-03-05新加参数
    ,"winTitleOfAdd" : "新增"//新增弹窗的标题,2018-03-05新加参数
    ,"winTitleOfUpdate" : "编辑"//修改弹窗的标题,2018-03-05新加参数
    ,"winNameOfAdd" : "WIN_ADD"//新增弹窗的标题,2018-03-05新加参数
    ,"winNameOfUpdate" : "WIN_EDIT"//修改弹窗的标题,2018-03-05新加参数
    ,"orderBy" : ""//排序字段,2018-04-25新加参数
    ,"orderType" : ""//排序类型,asc:升序|desc:降序,2018-04-25新加参数
};
/**
 * 标记joView对象是否发生初始化,即是否有使用
 * @type {boolean}
 */
joView.inited = false;
/**
 * grid表格jq对象
 * @date 2017-06-16
 * @type {null}
 */
joView.grid = null;
/**
 * 格式化后的Grid对象(**仅供内部方法使用,禁止外部调用)
 * @type {null}
 */
joView.Grid = null;
/**
 * 初始化grid对象
 * 如果需要继续添加自定义属性,需要同时在Grid类中做处理
 */
joView.initGrid = function(oGrid){
    if(jo.isValid(oGrid)){
        joView.grid = $(oGrid);//jq对象
        joView.Grid = new Grid(joView.grid);//格式化后的Grid对象
        joView.params["formUrl"] = joView.Grid.formUrl;//[新增/修改]表单地址
        joView.params["deleteUrl"] = joView.Grid.deleteUrl;//[删除]数据的url
        joView.params["dataUrl"] = joView.Grid.dataUrl;//[Grid数据]的url
        joView.params["colsInfo"] = joView.Grid.colsInfo();
        var _html = "<thead></thead><tbody></tbody>";
        joView.grid.html(_html);//插入head和body,因为joView里面用到这2个标签,在这里作插入就可以省去在html中写
    }
};
/**
 * 设置传输参数
 */
joView.setTransferParam = function(sParam){
    joView.params["transferParam"] = sParam;
};
/**
 * 设置joView参数
 */
joView.putParam = function(sKey,sValue){
    joView.params[sKey] = sValue;
};
/**
 * 批量设置joView参数
 */
joView.putParams = function(oParams){
    joView.params = $.extend({},joView.params, oParams);
};
/**
 * 页面初始化
 * 1.初始化html元素;
 * 2.格式化样式;
 * 3.初始化数据;
 */
joView.init = function(oParams){
    //将使用标记切换为true
    joView.inited = true;
    //初始化joView参数
    if(jo.isValid(oParams)){
        if(oParams.grid){
            joView.initGrid(oParams.grid);//初始化grid对象
        }else{//没有传入grid,默认为$("#mainList")
            joView.grid = $("#mainList");
        }
        //joView对象的一切参数还是以传入的参数为准,传入的参数可以覆盖掉grid对象中设置的参数
        joView.putParams(oParams);
    }
    //初始化视图页面参数,bam入口
    joView.initViewParams();
    //格式化样式
    joView.formatUI();
    //初始化列表数据
    joView.select();
    //覆盖原先[重新加载当前页]函数,为了兼容jo-page-form.js的重新加载父页面数据操作
    if(typeof(reloadCurrentPage) == "function"){
        reloadCurrentPage = joView.reloadCurrentPage;
    }else{
        window.reloadCurrentPage = joView.reloadCurrentPage;
    }
};

/**
 * 查询数据
 * 需要对查询参数做调整,通常在本方法进行
 */
joView.select = function(){
    //查询
    if(jo.isValid(joView.params["dataUrl"])){
        //$("#mainList>tbody").html("");
        joView.clearGrid();//清空
        //每次加载都要刷新url和formData参数(如果有的话)
        if(jo.isValid(document.getElementById("pageForm"))){
            joView.params["formData"] = jo.form2Json(jo._("#pageForm"));//new FormData($("#pageForm")[0]);
        }else{
            joView.params["formData"] = {};//new FormData($("#pageForm")[0]);
        }
        //为了避免查询表单中参数名与排序参数重复
        if(typeof (joView.params["formData"]["orderBy"]) != "undefined" || typeof (joView.params["formData"]["orderType"]) != "undefined"){//表单存在orderBy或orderType关键字
            console.warn("[joView列表查询] 检索表单中存在orderBy或orderType参数字段,与joView排序功能关键字产生冲突!这将导致您的自定义排序功能失效!");
        }else{
            //插入排序参数
            joView.params["formData"]["orderBy"] = joView.params["orderBy"];
            joView.params["formData"]["orderType"] = joView.params["orderType"];
        }
        //额外携带condition自定义查询参数
        joView.params["url"] = joView.params["dataUrl"] + jo.getLinkSign(joView.params["dataUrl"]) + joView.params["condition"];
        //加载第一页数据
        joView.goPage(1);
    }
};
/**
 * 切换到第几页,这里不对查询参数做调整,调用select()方法才会对查询参数做重新计算
 * 该方法是对joView.loadData的简化,通常在调用该方法前将需要设置的参数赋值给joView.params
 * @param goPage 去第几页
 */
joView.goPage = function(goPage){
    if (joView.params["shouldPage"] == "noPageSize") {
        joView.params["pageSize"] = 999;
    }

    joView.loadData(joView.params["url"], joView.params["formData"], goPage, joView.params["pageSize"]);
};
/**
 * 加载数据
 * 该方法为基础方法,被调用时要从joView.params中取数据,在该方法内部不对参数进行任何关于joView.params处理
 * @param url 加载数据的url
 * @param formData 查询参数
 * @param goPage 第几页
 * @param pageSize 每页多少条
 */
joView.loadData = function(url,formData,goPage,pageSize){
    // jo.showLoading("正在加载...");//先一律注释
    if(!goPage){
        goPage = 1;//默认第一页
    }
    if(!pageSize){
        pageSize = "";
    }
    if(url.indexOf("?") >= 0){//传进来的URL带有参数
        url += jo.getLinkSign(url)+"pageNumber=" + goPage + "&pageSize=" + pageSize;
    }else{
        url += "?pageNumber=" + goPage + "&pageSize=" + pageSize;
    }

    var formData = formData;
    var url = url;
    jo.postAjax(url, formData, function(result){
        var list = result ? result.data : null;
        if(list != null && list.length>0){
            try {joView.showData(list);}catch(err){jo.showMsg("发生异常,请检查joView.showData()方法是否出错!")}finally{}//自定义方法展示数据
        }else{//为空,清空原有数据
            //$("#mainList>tbody").html("");
            joView.clearGrid();
            $("#myTileGrid").html("<span>暂无数据需要汇总！</span>");
        }
        //更新分页信息
        try{
            if(result){
                joView.showPageInfo(result);
            }
            //新增
            layui.use('form', function(){
                var form = layui.form;
                form.render();
            });
        }catch(err){
            console.info("更新分页信息异常!"+err);
        }
        // jo.showLoading(false);
    });
};
/**
 * 清空表格数据
 */
joView.clearGrid = function(){
    joView.grid.find(">tbody").html("");
};
/**
 * 展示数据,即将数据填充到表格
 */
joView.showData = function(oList){

    if(jo.isValid(joView.params["colsInfo"])){
        var showFieldsInfo = joView.params["colsInfo"];
        //展示列表头信息{"field":"userName","title":"姓名","width":"15%","align":"center","event":"none","headAlign":"center","order":"user_Name"},
        var checkStyle = jo.getDefVal(joView.params["checkStyle"],"");
        /*
         * 生成表头
         */
        /*if(typeof(joView.setGridHead) == "function"){//生成Grid头接管函数
            joView.setGridHead();
        }else{
            var _headHtml = "<tr>";
            if(checkStyle == "checkBox"){//复选框
                _headHtml += '<td style="width:5%;"><input type="checkbox" onclick="checkAll()" id="checkAll"/></td>';
            }else if(checkStyle == "radio"){//单选框
                _headHtml += '<td style="width:5%;">选择</td>';
            }else{
                //不要选择框
            }
            //遍历生产表头
            for( var i=0;i<showFieldsInfo.length;i++){
                _headHtml += '<td style="width:' + showFieldsInfo[i]["width"] + ';">' + showFieldsInfo[i]["title"] + '</td>';
            }
            _headHtml += "</tr>";
            $("#mainList>thead").html(_headHtml);
        }*/
        /*
         * 生成数据行
         */
        if(typeof(joView.setGridDataBefore) == "function"){//生成数据行的前置处理
            try{
                joView.setGridDataBefore(oList);
            }catch(err){
                jo.showMsg("joView.setGridDataBefore方法异常!");
            }
        }
        if(typeof(joView.setGridData) == "function"){//生成Grid数据接管函数
            try{
                joView.setGridData(oList);
            }catch(err){
                jo.showMsg("joView.setGridData方法异常!");
            }
        }else{
            var _html = "";
            for(var i=0;i<oList.length;i++){
                _html += "<tr>";
                //TODO 可以在此处设置有关审核数据字体显示,
                if (oList[i]["status"] == 2) {
                    //审核不通过
                    _html += "<tr class='nopass'>";
                }
                if (oList[i]["status"] == 1) {
                    _html += "<tr class='pass'>";
                }
                //处理数据行对象
                if(typeof(joView.handleItem) == "function"){
                    joView.handleItem(oList[i],i);
                }
                //与列表展示的表头对应
                var sHtml = oList[i]["CheckBoxStyleHtml"];
                if(jo.isValid(sHtml)){
                    _html += '<td style="text-align: center;">'+sHtml+'</td>';
                }else if(checkStyle == "checkBox"){//复选框
                    _html += "<td><input type='checkbox' id='"+joView.params["PKName"]+"' name='"+joView.params["PKName"]+"' value='"+oList[i][joView.params["PKName"]]+"' lay-skin=\"primary\"/></td>";//复选框
                }else if(checkStyle == "radio"){//单选框
                    _html += '<td style="text-align: center;"><input type="radio" name="'+joView.params["PKName"]+'" value="'+oList[i][joView.params["PKName"]]+'"></td>';
                }else if(checkStyle == "order"){
                    _html += '<td style="text-align: center;">'+(i+1)+'</td>';
                }else{
                    //不要选择框
                }
                //遍历生产数据行
                for(var j=0;j<showFieldsInfo.length;j++){
                    //判断td内容的align属性,默认居中
                    var sAlign = jo.getDefVal(showFieldsInfo[j]["align"],"center");
                    // var alignHtml = ' align=\"'+sAlign+'\"';//TODO  此处注释掉，为了和静态页面一致
                    var alignHtml = '';
                    var _val = showFieldsInfo[j]['field'];
                    if(jo.isValid(_val)){
                        //以 [= 开头, ] 结尾的格式,表示调用函数对字段进行处理,其中的变量(即该行json的字段值)要使用花括号括起来,例如 [=jo.formatDate('{time}')],time为从数据库查询出来的字段
                        if(_val && /^\[=(.)*\]$/.test(_val)){
                            //去掉无效的[=和]
                            _val = _val.substring(2,_val.length - 1);
                            //解析{xx}类型的变量
                            _val = jo.getCode(_val,oList[i]);
                            //执行该函数
                            _val = eval(_val);
                        }else if(/\{(.)*\}/g.test(_val)){//解析{xx}类型的变量
                            _val = jo.getCode(_val,oList[i]);
                        }else{
                            var statusKey = _val;
                            _val = jo.getDefVal(oList[i][_val],"");//赋值
                            //新增状态：start
                            if (statusKey == "status") {
                                if (_val == 5) {
                                    _val = "<span style='color:red'>待审核</span>";
                                }else  if (_val == 1) {
                                    _val = "<span style='color:blue'>已通过</span>";
                                } else if (_val == 2) {
                                    _val = "<span style='color:red'>未通过</span>";
                                } else if (_val == 3) {
                                    _val = "不审核";
                                }else {
                                    _val = "暂无";
                                }
                            }
                            if (statusKey == "lockStatus") {
                                if (_val == 1) {
                                    _val = "<span style='color:red'>已锁定</span>";
                                }else {
                                    _val = "未锁定";
                                }
                            }
                            if (statusKey == "id") {
                                if (_val.length== 32) {

                                    _val = '<option style="color: blue " value="'+_val+'" calss="update">编辑</option>'
                                  /*   _val = "<span style='color:blue'>编辑</span>";*/

                                }else {
                                    _val = "未锁定";
                                }
                            }
                            //新增状态：end

                        }
                    }
                    _val = jo.getDefVal(_val,"");//最后对_val进行检查,无效则赋值空格
                    //生成td
                    /*if(typeof(joView.handleItemValue) == "function"){//该接管函数对每个格子的值进行复制,不适用上面解析后的值
                        _html += "<td "+alignHtml+"><a href='javascript:joView.edit(\""+oList[i][joView.params["PKName"]]+"\","+JSON.stringify(oList[i]).replace(/\'/ig,"\\\'")+")' style='color:black;' title='点击编辑详情'>"+(oList[i][showFieldsInfo[j]['field']] ? joView.handleItemValue(oList[i][showFieldsInfo[j]['field']],j) : '&nbsp;')+"</a></td>";
                    }else{//使用.replace(/\'/ig,"\\\"")是为了解决因为单引号造成的显示问题和点击事件异常
                        _html += "<td "+alignHtml+"><a href='javascript:joView.edit(\""+oList[i][joView.params["PKName"]]+"\","+JSON.stringify(oList[i]).replace(/\'/ig,"\\\"")+")' style='color:black;' title='点击编辑详情'>"+_val+"</a></td>";
                    }*/
                    //2017-05-06修改:将点击事件挂在td上,取消掉之前的a标签
                    if(typeof(joView.handleItemValue) == "function"){//该接管函数对每个格子的值进行复制,不适用上面解析后的值
                        _html += "<td "+alignHtml+" onclick='joView.edit(\""+oList[i][joView.params["PKName"]]+"\","+JSON.stringify(oList[i]).replace(/\'/ig,"\\\'")+")'>"+(oList[i][showFieldsInfo[j]['field']] ? joView.handleItemValue(oList[i][showFieldsInfo[j]['field']],j) : '&nbsp;')+"</td>";
                    }else{//使用.replace(/\'/ig,"\\\"")是为了解决因为单引号造成的显示问题和点击事件异常
                        var evt = showFieldsInfo[j]['event'];
                        if(evt == "none"){//event属性为none时表示禁用点击事件
                            _html += "<td "+alignHtml+" >"+_val+"</td>";
                        }else{
                            _html += "<td "+alignHtml+" onclick='joView.edit(\""+oList[i][joView.params["PKName"]]+"\","+JSON.stringify(oList[i]).replace(/\'/ig,"\\\"")+")'><a href='javascript:;' style='color: #337ab7'>"+_val+"</a></td>";
                        }
                    }
                }
                _html += "</tr>";
            }
            //$("#mainList>tbody").html(_html);
            joView.grid.find(">tbody").html(_html);
            //$("head").append('<script type="text/javascript" src="'+joView.params["JS_table"]+'"><\/script>');//加载列表效果,如果使用的是joGrid则不需要
        }
        if(typeof(joView.setGridDataAfter) == "function"){
            joView.setGridDataAfter(oList);
        }
    }else{
        jo.showMsg("colsInfo无效!");
    }
};
/**
 * 更新分页信息
 */
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
        _size += '<select class="input-sm" lay-filter="choicePageSize">';
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
        _html = '<div class="pull-left layui-col-md5">当前第&nbsp;'+currentPage+"&nbsp;页，每页&nbsp;"+_size+"&nbsp;条，共&nbsp;"+totalCount+"&nbsp;条记录</div>";
    }
    _html += '<ul class="pagination pull-right layui-col-md7">'
        + first
        + last
        + normal
        + next
        + end
        + '</ul>';
    pageBar.html(_html);
};
/**
 * 重新加载当前页
 */
joView.reloadCurrentPage = function(){
    if(typeof(joView.refreshAuditItem) == "function"){
        joView.refreshAuditItem();
    }
    joView.goPage(joView.params["currentPage"]);
};
/**
 * 选择每页显示多少条
 * @param iNum 每页多少条数据
 */
joView.choicePageSize = function(iNum){
    joView.params["pageSize"] = iNum;
    joView.goPage(1);
};
/**
 * 设置默认每页显示多少条
 * @param iNum 每页多少条数据
 */
joView.setDefaultPageSize = function(iNum){
    joView.params["pageSize"] = jo.getDefVal(iNum,joView.params["pageSize"]);
    var _html = '';
    _html += '<option value="5">5</option>';
    _html += '<option value="10">10</option>';
    _html += '<option value="'+joView.params["pageSize"]+'" selected="selected">'+joView.params["pageSize"]+'</option>';
    _html += '<option value="15">15</option>';
    _html += '<option value="20">20</option>';
    $("#pageSize").html(_html);
};
/**
 * 初始化数据
 */
joView.initData = function(){

};
/**
 * 初始化视图参数,bam组件初始化页面参数入口
 */
joView.initViewParams = function(oParams){

};
/**
 * 格式化UI
 */
joView.formatUI = function(){
    //初始化面包屑
    // joView.initPlace();//新界面未用到
    //初始化按钮
    // joView.initBtn();//新界面暂且未用到，用于显示按钮隐藏和显示
    //初始化Grid标题行
    joView.initGridHead();
    //初始化分页脚信息
    joView.initFoot();
};
/**
 * 初始化分页脚
 * 主要是初始化每页多少条,在加载数据之前执行
 */
joView.initFoot = function(){
    console.log("初始化分页脚" + $("#pageSize"));
    var pageSizeArr = joView.params["pageSizeArr"];
    if(jo.isValid(pageSizeArr) && typeof(pageSizeArr) == "object"){
        $("#pageSize").html("");//情况默认选择项
        var _html = '';
        //生产选择项
        for(var i=0;i<pageSizeArr.length;i++){
            _html += '<option value="' + pageSizeArr[i] + '">' + pageSizeArr[i] + '</option>';
        }
        //插入选择项
        $("#pageSize").html(_html);
        //选择默认项
        var defPageSize = joView.params["pageSize"];
        $("#pageSize").val(defPageSize);
    }
};
/**
 * 初始化按钮可以控制按钮显示与否
 * 权限处理
 */
joView.initBtn = function(){
    $(".button-bar>button[isShow]").each(function(index,element){
        var isShow = $(this).attr("isShow");
        if(isShow == ""){//isShow为空时不隐藏
            $(this).show();
        }else{
            //当返回false或'false'时才隐藏
            if(joView.execCode(isShow) == false || joView.execCode(isShow) == 'false'){
                $(this).hide();
            }else{
                $(this).show();
            }
        }
    });
};
/**
 * 执行字符串形式的代码
 */
joView.execCode = function(sCode){
    if(jo.isValid(sCode)){//待执行代码的有效性
        return eval(sCode);
    }else{
        return false;
    }
};
/**
 * 初始化Grid标题行
 */
joView.initGridHead = function(){
    if(jo.isValid(joView.params["colsInfo"])){
        /*
         * 生成表头
         */
        if(typeof(joView.setGridHead) == "function"){//生成Grid头接管函数
            joView.setGridHead();
        }else{
            var showFieldsInfo = joView.params["colsInfo"];
            var checkStyle = jo.getDefVal(joView.params["checkStyle"],"");
            var _headHtml = "<tr>";
            var checkWidth = jo.getDefVal(joView.params["checkStyleWidth"],"5%");
            if(checkStyle == "checkBox"){//复选框
                // _headHtml += '<th style="text-align:center;width:'+checkWidth+';"><input type="checkbox" onclick="jo.checkAll(\''+joView.params["PKName"]+'\')" id="checkAll"/></th>';
                _headHtml += "<th><input type=\"checkbox\" name=\"all\" lay-skin=\"primary\" lay-filter=\"allChoose\"></th>";
            }else if(checkStyle == "radio"){//单选框
                _headHtml += '<th style="text-align:center;width:'+checkWidth+';">选择</th>';
            }else if(checkStyle == "order"){
                _headHtml += '<th style="text-align:center;width:'+checkWidth+';">序号</th>';
            }else{
                //不要选择框
            }
            //遍历生产表头
            for(var i=0;i<showFieldsInfo.length;i++){
                var lcr = jo.getDefVal(showFieldsInfo[i]["headAlign"], 'center');//标题行文本位置,默认center
                _headHtml += '<th>' + showFieldsInfo[i]["title"];
                if(showFieldsInfo[i]["order"]){//当前列开启排序功能
                    _headHtml += '<span style="display: inline-block;width: 1px;height: 15px;position: relative;">';/*caret*/
                    _headHtml += '<div class="order-asc cursor-hand fa fa-angle-up" field="'+showFieldsInfo[i]["order"]+'" grid="'+joView.Grid.id+'" onclick="joView.orderSelect(this, true)" style="font-weight: bold;height:7px;width: 15px;padding: 0px;margin:0px;position: absolute;top:0px;"><!--<i class="fa fa-caret-up" aria-hidden="true"></i>--></div>';
                    _headHtml += '<div class="order-desc cursor-hand fa fa-angle-down" field="'+showFieldsInfo[i]["order"]+'" grid="'+joView.Grid.id+'" onclick="joView.orderSelect(this, false)" style="font-weight: bold;height:7px;width: 15px;padding: 0px;margin:0px;position: absolute;bottom:0px;"><!--<i class="fa fa-caret-down" aria-hidden="true"></i>--></div>';
                    _headHtml += '</span>';
                }
                _headHtml += '</th>';
            }
            _headHtml += "</tr>";
            //$("#mainList>thead").html(_headHtml);
            joView.grid.find(">thead").html(_headHtml);
            console.log("表格标题行初始化完毕");
        }
    }
};
/**
 * 排序查询
 * @param element 被点击的排序元素:this
 * @param isAsc 升序标识,true表示升序,false表示降序
 */
joView.orderSelect = function(element, isAsc){
    var p = $(element).parent();//排序容器
    var field = $(element).attr("field");//待排序字段
    var arr = p.find("div");//0为升序,1为降序
    //将表格下所有的排序图标重置
    joView.grid.find(".order-asc").removeClass("fa-caret-up");
    joView.grid.find(".order-desc").removeClass("fa-caret-down");
    joView.grid.find(".order-asc").addClass("fa-angle-up");
    joView.grid.find(".order-desc").addClass("fa-angle-down");
    if(arr){
        if(isAsc){
            $(arr[0]).removeClass("fa-angle-up");
            $(arr[0]).addClass("fa-caret-up");//变成实心图标
            //排序查询
            joView.putParam("orderBy", field);
            joView.putParam("orderType", "asc");
        }else{
            $(arr[1]).removeClass("fa-angle-down");
            $(arr[1]).addClass("fa-caret-down");//变成实心图标
            //排序查询
            joView.putParam("orderBy", field);
            joView.putParam("orderType", "desc");
        }
        joView.select();//查询
    }else{
        console.error("joView排序查询 : 未找到排序标签!");
    }
};
/**
 * 初始化面包屑
 */
joView.initPlace = function (){
    var places = $("td.place[type=auto]").text();
    if(jo.isValid(places)){
        var placeArr = places.split(",");
        var _place = "<ul><li>&nbsp;&nbsp;<b>位置：</b></li>";
        if(placeArr.length > 0){
            _place += "<li>"+placeArr[0]+"</li>";
            for(var i=1;i<placeArr.length;i++){
                _place += "<li class='arrows'>&nbsp;&nbsp;&nbsp;</li>";
                _place += "<li>"+placeArr[i]+"</li>";
            }
        }
        _place += "</ul>";
        $("td.place[type=auto]").html(_place);
    }
};

//管理员审核操作1审核通过2审核不通过3不审核4删除,有提示主要用于顶部按钮
joView.auditChange = function(status,surl,sIds) {
    var idStr = "";
    if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
        idStr = jo.getCheckBoxValue(joView.params["PKName"]);
    }else{//有传入值
        idStr = sIds;
    }
    if(idStr == ""){
        jo.showMsg("请选择要审核项");
    }else{
        jo.confirm("确定执行该操作？",function () {
            var auditUrl = surl;
            var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&status=" + status;
            jo.postAjax(url,{},function(result){
                if(result.code == 0){
                    jo.showMsg("操作成功！");
                    joView.reloadCurrentPage();//重新加载当前页数据
                    if(typeof (joView.delSuccessOver) == "function"){
                        joView.delSuccessOver(result, idStr);
                    }
                }else{
                    jo.showMsg(result.info)
                }
            });
        });
    }
}

//管理员审核操作1审核通过2审核不通过3不审核4删除,新增方法根据用户批量操作，主要用于教育和工作
joView.auditChangeByUserID = function(status,surl,sIds) {
    var idStr = "";
    if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
        idStr = jo.getCheckBoxValue(joView.params["PKName"]);
    }else{//有传入值
        idStr = sIds;
    }
    var msg = "";
    if(idStr == ""){
        msg = "<span style='color: red'>未勾选任何一项，默认将操作所有！</span>";
        idStr = jo.getAllCheckBoxValue(joView.params["PKName"]);//由于未分页，所以此处不做URL变换

    }else{
        msg = "确定执行该操作？";
    }
    jo.confirm(msg,function () {
        var auditUrl = surl;
        var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&status=" + status;
        jo.postAjax(url,{},function(result){
            if(result.code == 0){
                jo.showMsg("操作成功！");
                joView.reloadCurrentPage();//重新加载当前页数据
                if(typeof (joView.delSuccessOver) == "function"){
                    joView.delSuccessOver(result, idStr);
                }
            }else{
                jo.showMsg(result.info)
            }
        });
    });
}

//
joView.auditChangeNoConfirm = function(status,surl,sIds) {
    var idStr = "";
    if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
        idStr = jo.getCheckBoxValue(joView.params["PKName"]);
    }else{//有传入值
        idStr = sIds;
    }
    if(idStr == ""){
        jo.showMsg("请选择要审核项");
    }else{
        // jo.confirm("确定执行该操作？",function () {
            var auditUrl = surl;
            var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&status=" + status;
            jo.postAjax(url,{},function(result){
                if(result.code == 0){
                    jo.showMsg("操作成功！");
                    joView.reloadCurrentPage();//重新加载当前页数据
                    if(typeof (joView.delSuccessOver) == "function"){
                        joView.delSuccessOver(result, idStr);
                    }
                }else{
                    jo.showMsg(result.info)
                }
            });
        // });
    }
}
//管理员审核操作end

//状态锁定start，主要用于顶部按钮，有提示
joView.changeState = function(oldState,surl,sIds){
    var state = oldState == 1 ? 1 : 2;
    var idStr = "";
    if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
        idStr = jo.getCheckBoxValue(joView.params["PKName"]);
    }else{//有传入值
        idStr = sIds;
    }
    if(idStr == ""){
        jo.showMsg("请选择要锁定项");
    }else {
        jo.confirm("确定执行该操作？", function () {
            var auditUrl = surl;
            var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&lockStatus=" + state;
            jo.postAjax(url, {}, function (result) {
                if (result.code == 0) {
                    jo.showMsg("状态切换成功！");
                    joView.reloadCurrentPage();//重新加载当前页数据
                } else {
                    jo.showMsg(jo.getDefVal(json.info, "切换失败"));
                }
            });
        });
    }
}
//状态锁定end
//new func 用于工作经历，不选择默认全部
joView.changeStateByUserID = function(oldState,surl,sIds){
    var state = oldState == 1 ? 1 : 2;
    var idStr = "";
    var msg = "";
    if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
        idStr = jo.getCheckBoxValue(joView.params["PKName"]);
    }else{//有传入值
        idStr = sIds;
    }
    if(idStr == ""){
        msg = "<span style='color: red'>未勾选任何一项，默认将操作所有！</span>";
        idStr = jo.getAllCheckBoxValue(joView.params["PKName"]);//由于未分页，所以此处不做URL变换
    }else {
        msg = "确定执行该操作？";
    }
    jo.confirm(msg,function () {
        var auditUrl = surl;
        var url = auditUrl + jo.getLinkSign(auditUrl) + "ids=" + idStr + "&lockStatus=" + state;
        jo.postAjax(url, {}, function (result) {
            if (result.code == 0) {
                jo.showMsg("状态切换成功！");
                joView.reloadCurrentPage();//重新加载当前页数据
            } else {
                jo.showMsg(jo.getDefVal(json.info, "切换失败"));
            }
        });
    });
}

joView.setUserName = function(){
    var adata = {};
    var odata = {};
    var auditData = jo.postAjax("pms/auditRecordBaseinfo/getUserAuditInfo",{"userId":userId});
    if(auditData != null && auditData.data.length > 0 && auditData.data[0]){
        adata = auditData.data[0];//存放到form.formData,方便调用
    }else{
        adata = {};
    }
    var result = jo.postAjax("pms/pmsUser/get.action",{"id":userId});
    if(result != null && result.data.length > 0 && result.data[0]){
        odata = result.data[0];
    }else{
        odata = {};
    }

    $("#auditWho").attr("value",userId);
    if (jo.isValid(odata["userName"])) {
        $("#auditWho").text(odata["userName"]);
    } else {//正式库没有数据，使用审核库
        for (var i=0;i<adata.length;i++) {
            if("userName" == adata[i]["fieldKey"]) {
                $("#auditWho").text(adata[i]["fieldVal"]);
            }
        }
    }
}

/**
 * 新增按钮事件
 * 打开新增页面
 * @param sUrl 打开表单的地址
 */
joView.add = function(sUrl,sWidth,sHeight,sTitle){
    var sUrl = jo.getDefVal(sUrl,joView.params["formUrl"]);
    if(jo.isValid(sUrl)){
        sUrl = sUrl + jo.getLinkSign(sUrl) + joView.params["transferParam"];
        //getPopWin(sUrl,jo.getDefVal(sWidth,'780px'),jo.getDefVal(sHeight,'80%'),jo.getDefVal(sTitle,'新增'));
        jo.showWin(sUrl,jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfAdd"]), joView.params["winNameOfAdd"]);
    }
};
/**handleItem
 * 删除
 */
joView.del = function(sIds){
    if(jo.isValid(joView.params["deleteUrl"])){
        var deleteUrl = joView.params["deleteUrl"];
        var idStr = "";
        if(!jo.isValid(sIds)){//没有传入ID,获取选中复选框的ID
            idStr = jo.getCheckBoxValue(joView.params["PKName"]);
        }else{//有传入值
            idStr = sIds;
        }
        if(idStr == ""){
            jo.showMsg("请选择待删除选项");
        }else{
            jo.confirm("确定要删除吗？",function () {
                var url = deleteUrl + jo.getLinkSign(deleteUrl) + "ids=" + idStr;
                jo.postAjax(url,{},function(result){
                    if(result.code == 0){
                        jo.showMsg("删除成功");
                        joView.reloadCurrentPage();//重新加载当前页数据
                        if(typeof (joView.delSuccessOver) == "function"){
                            joView.delSuccessOver(result, idStr);
                        }
                    }else{
                        jo.showMsg(result.info)
                    }
                });
            });
        }
    }else{
        jo.showMsg("请检查删除配置参数{deleteUrl}是否有效!");
    }
};
/**
 * 编辑
 * 数据列表的点击事件
 * @param id 数据的主键值
 * @param sWidth 弹窗的宽度,或者是该行数据的json格式的值(object类型)
 */
joView.edit = function(id,sWidth,sHeight,sTitle){
    if(typeof(joView.clickItem) == "function"){
        joView.clickItem(id,sWidth,sHeight,sTitle);
    }else{
        if(jo.isValid(joView.params["formUrl"])){//有效的表单地址
            if(typeof(sWidth) == "object"){
                sWidth = '';
            }
            //getPopWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],jo.getDefVal(sWidth,'780px'),jo.getDefVal(sHeight,'80%'),jo.getDefVal(sTitle,'编辑'));
            jo.showWin(joView.params["formUrl"]+jo.getLinkSign(joView.params["formUrl"])+joView.params["PKName"]+'='+id +"&"+ joView.params["transferParam"],jo.getDefVal(sWidth, joView.params["formWidth"]),jo.getDefVal(sHeight, joView.params["formHeight"]),jo.getDefVal(sTitle, joView.params["winTitleOfUpdate"]), joView.params["winNameOfUpdate"]);
        }
    }
};