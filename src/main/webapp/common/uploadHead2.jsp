<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<link href="<%=URL_STATIC%>static/plugin/webuploader-0.1.5/webuploader.css" rel="stylesheet">
<script src="<%=URL_STATIC%>static/plugin/webuploader-0.1.5/webuploader.js"></script>
<script type="text/javascript">
    /**
     * 上传文件
     * @param sUrl 文件上传地址
     * @param callback 文件上传回调,参数1是boolean类型,代表是否上传成功,参数2是file对象
     */
    function uploadFile(sUrl, callback){
        var _uploadHtml = '<div id="uploadWin" style="width:100%;padding: 12px;">' +
                '<div class="alert alert-warning font-size-14"><strong>提醒！</strong>请使用平台提供的模板进行导入，否则会导致错误发生!</div>' +
                '<div id="choiceFileBtn" style="float: left;display: none;">选择文件</div>' +
                '<button id="uploadBtn" class="btn btn-primary" style="width: 78px;height: 37px; margin-bottom: 5px;margin-left: 12px;display: none;">开始上传</button>' +
                '<table id="uploadList" class="table table-hover table-condensed"></table>' +
                '</div>';
        var options = {
            title : "上传文件",
            area : ['500px','300px'],
            btn : ["下载模板","选择文件", "开始上传", "关闭"],
            btn1 : function(){
                if(typeof (EXCEL_DOWNLOAD_URL) != "undefined" && jo.isValid(EXCEL_DOWNLOAD_URL)){
                    jo.confirm("您确定要下载此模板?", {}, function(idx){
                        jo.newWindow(EXCEL_DOWNLOAD_URL);//下载模板
                        jo.closeUploadDialog();
                        jo.close(idx);
                    });
                }else{
                    jo.showMsg("暂时没有模板地址可供下载!");
                }
                return true;
            },
            btn2 : function(){
                $('#choiceFileBtn').find("label").click();
                return false;
            },
            btn3 : function(){
                $('#uploadBtn').click();
                return false;//不关闭窗口
            }
        };
        jo.showDialog(_uploadHtml, "uploadWin", true, options);//弹窗
        uploaderInit(sUrl, callback);//初始化
    }
    //uploaderInit插件初始化
    function uploaderInit(sUrl, callback){
        if(sUrl){
            sUrl = replaceUrlConstants(sUrl);
        }else{
            var idx = jo.alert("上传地址无效!", '', function(){
                jo.close("uploadWin");//关闭上传窗口
                jo.close(idx);
            });
            return;
        }
        var uploader;//uploader对象
        var $list = $('#uploadList');//上传列表
        var $btn = $('#uploadBtn');//开始上传按钮
        var state = 'pending';//上传状态
        uploader = WebUploader.create({
            // swf文件路径
            swf: '<%=URL_STATIC%>static/plugin/webuploader-0.1.5/Uploader.swf',
            // 文件接收服务端。
            server: sUrl,
            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#choiceFileBtn',
            //允许的文件后缀
            accept : {
                extensions : typeof (UPLOAD_FILE_TYPES) == 'string' ? UPLOAD_FILE_TYPES : ''
            },
            // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
            resize: false
        });
        // 当有文件被添加进队列的时候
        uploader.on( 'fileQueued', function( file ) {
            var _tr = '<tr id="'+file.id+'" style="height:30px;">' +
                    '<td class="fileName" style="border: none;" width="30%">'+file.name+'</td>' +
                    '<td class="fileProgress" style="border: none;" width="50%"></td>' +
                    '<td class="fileState" style="border: none;" width="20%">等待上传...</td>' +
                    '</tr>';
            $list.append(_tr);
        });
        // 文件上传过程中创建进度条实时显示。
        uploader.on( 'uploadProgress', function( file, percentage ) {
            var $li = $( '#'+file.id);//行
            var progressTd = $li.find(".fileProgress");//进度条td
            var $percent = $li.find('.progress .progress-bar');//进度条
            // 避免重复创建
            if ( !$percent.length ) {
                $percent = $('<div class="progress progress-striped active" style="margin: 0px;">' +
                        '<div class="progress-bar" role="progressbar" style="width: 0%;height: 25px;">' +
                        '</div>' +
                        '</div>').appendTo( progressTd ).find('.progress-bar');
            }
            $li.find('td.fileState').text('上传中');
            $percent.css( 'width', percentage * 100 + '%' );
        });
        //上传成功
        uploader.on( 'uploadSuccess', function( file, response) {
            $( '#'+file.id ).find('td.fileState').text('上传成功');
            if(typeof (callback) == "function"){
                callback(true, file, response);//回调
            }
        });
        //上传失败
        uploader.on( 'uploadError', function( file ) {
            $( '#'+file.id ).find('td.fileState').text('上传出错');
            if(typeof (callback) == "function"){
                callback(false, file);//回调
            }
        });
        //上传结束,不论成功失败
        uploader.on( 'uploadComplete', function( file ) {
            $( '#'+file.id ).find('.progress').fadeOut();//进度条淡出
        });
        //错误事件
        uploader.on( 'error', function( type ) {
            if (type == "Q_TYPE_DENIED") {
                jo.showMsg("请上传正确格式的文件");
            }
        });
        //绑定上传事件
        $btn.on('click', function(){
            uploader.upload();
        });
    }
</script>