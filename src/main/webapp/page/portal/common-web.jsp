<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>个人文件夹</title>
    <script src="../js/layui.js"></script>
    <link rel="stylesheet" href="../css/layui.css">
    <script src="../js/jquery.min.js"></script>
    <link rel="stylesheet" href="../font/font2/iconfont.css">
    <!-- <link rel="stylesheet" href="css/announcement-list.css"> -->
    <link rel="stylesheet" href="../css/common.css">
    <link rel="stylesheet" href="../css/person-document.css">
    <!-- <script src="../js/common.js"></script> -->
    <style>
        .icon-msnui-menu-down {
            transform: rotateZ(45deg);
            display: inline-block;
            color: #C7C7CD;
            margin-right: 10px;
            /* margin-top: 4px; */
            font-size: 12px;
        }

        .icon-msnui-menu-down.child {
            margin-left: 10px;
        }

        .icon-msnui-menu-down.childs {
            margin-left: 20px;
        }

        .person-tit .title {
            padding: 0;
        }

        .person-tit {
            padding: 18px;
        }

        button.close {
            background: #fff;
            color: #378CEF;
            border-color: #378CEF;
        }

        button.close:hover {
            border-color: #378CEF;
            color: #378CEF;
        }

        .layui-table a.edit {
            margin: 0;
        }
    </style>
</head>

<body>
    <div class="container">
        <div class="layui-row">
            <form class="layui-form layui-form-box layui-col-md12 person">
                <div class="person-tit clear">
                    <span class="left title">常用网站</span>
                    <div class="layui-form right">
                        <div class="layui-inline button-group">
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary add">新增</button>
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary del">删除</button>
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary reset"><i class="layui-icon layui-icon-refresh"></i> 刷新</button>
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary close">关闭</button>
                        </div>
                    </div>
                </div>

                <div class="form-content">
                    <i class="layui-icon layui-icon-search" style="position: absolute;top: 35px;left: 40px;"></i>
                    <div class="layui-form-item">
                        <label class="layui-form-label" style="width: 50px;">名称</label>
                        <div class="layui-input-inline" style="padding-left: 30px;">
                            <input type="text" name="name" placeholder="" autocomplete="off" class="layui-input list-input">
                        </div>
                    </div>

                    <div class="layui-form-item">
                        <div class="layui-input-inline button-inline">
                            <button type="button" class="layui-btn layui-btn-radius layui-btn-primary inquiry">搜索</button>
                        </div>
                    </div>
                </div>

                <div class="person-list-content">
                    <table class="layui-table layui-form">
                        <thead>
                            <tr>
                                <th><input type="checkbox" name="all" lay-skin="primary" lay-filter="allChoose"></th>
                                <th>中文名称</th>
                                <th>网址</th>
                                <th>添加时间</th>
                                <th>排序</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><input type="checkbox" name="" lay-skin="primary"></td>
                                <td>人事部网址1</td>
                                <td>xxx.com</td>
                                <td>2018-09-02</td>
                                <td>2018-09-02</td>
                                <td>
                                    <a href="javascript:;" class="edit">编辑</a>
                                </td>
                            </tr>
                            <tr>
                                <td><input type="checkbox" name="" lay-skin="primary"></td>
                                <td>人事部网址2</td>
                                <td>xxx.com</td>
                                <td>2018-09-02</td>
                                <td>2018-09-02</td>
                                <td>
                                    <a href="javascript:;" class="edit">编辑</a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div id="pages">
                        <div class="prompt">共<span>2</span>条记录</div>
                        <button type="button" class="layui-btn layui-btn-primary">首页</button>
                        <button type="button" class="layui-btn layui-btn-primary">上一页</button>
                        <button type="button" class="layui-btn layui-btn-primary">下一页</button>
                        <button type="button" class="layui-btn layui-btn-primary">尾页</button>
                    </div>
                </div>
            </form>
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
                    })
                    $(".edit").click(function() {
                        // layer.msg('Hello World');
                        layer.open({ /*弹出框*/
                            type: 2,
                            title: '编辑常用网址',
                            // maxmin: true,//大小窗口切换
                            shadeClose: true, //点击遮罩关闭层
                            area: ['650px', '240px'],
                            content: 'common-web-edit.html'
                        });
                    })
                    $(".look").click(function() {
                        // layer.msg('Hello World');
                        layer.open({ /*弹出框*/
                            type: 2,
                            title: '查看',
                            // maxmin: true,//大小窗口切换
                            shadeClose: true, //点击遮罩关闭层
                            area: ['650px', '430px'],
                            content: 'bulletin-look.html'
                        });
                    })
                    $(".delete").click(function() {
                        // layer.msg('Hello World');
                        layer.open({ /*弹出框*/
                            type: 2,
                            title: '删除此条',
                            // maxmin: true,//大小窗口切换
                            shadeClose: true, //点击遮罩关闭层
                            area: ['650px', '430px'],
                            content: 'bulletin-delete.html'
                        });
                    })

                    // 多选删除
                    $(".del").click(function() {
                        layer.confirm('确定要删除勾选的条目吗？', {
                            skin: 'more-del',
                            title: '删除所选条目',
                            btn: ['再考虑一下', '确定删除'],
                            area: ['650px', '280px'],
                            success: function(layero, index) {
                                $(document.body).find(".layui-layer-content").css("textAlign", "center");
                                $(document.body).find(".layui-layer-content").css("lineHeight", "121px");
                            }
                        }, function(index, layero) {
                            //再考虑
                        }, function(index) {
                            //确定删除
                        });
                    })
                    $(".add").click(function() {
                        // layer.msg('Hello World');
                        layer.open({ /*弹出框*/
                            type: 2,
                            title: '新增常用网站',
                            // maxmin: true,//大小窗口切换
                            shadeClose: true, //点击遮罩关闭层
                            area: ['650px', '240px'],
                            content: 'common-web-add.html'
                        });
                    })
                    $(".close").click(function() {
                        history.back(-1);
                    })
                });;
            })
        </script>
</body>

</html