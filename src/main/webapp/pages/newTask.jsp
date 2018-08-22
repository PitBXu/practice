<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: 100622161
  Date: 2018-8-21
  Time: 19:29
  Describe: 新建任务页面，创建好的任务状态为“待完善或待分配”
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新建任务</title>
    <link href="../dist/semantic.css" rel="stylesheet">
    <script src="../dist/jquery.min.js"></script>
    <script src="../dist/semantic.js"></script>
    <link href="../dist/calendar.css" rel="stylesheet" >
    <script src="../dist/calendar.js" charset="utf-8"></script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
                $('.ui.menu .ui.dropdown').dropdown({
                    on: 'hover'
                });
                $('.ui.menu a.item')
                    .on('click', function () {
                        $(this)
                            .addClass('active')
                            .siblings()
                            .removeClass('active')
                        ;
                    })
                ;
                $('#addTaskForm')
                    .form({
                    inline: true,
                    on: 'blur',
                    fields: {
                        taskName:{
                            identifier  : 'taskName',
                            rules: [
                                {
                                    type   : 'empty',
                                    prompt : "任务名称不能为空"
                                }
                            ]
                        }
                    }});
                initCalendar();
                $("#mySubmit").on('click',function(){
                    $(".save.modal")
                        .modal('show')
                    ;
                });
            });
    </script>
    <script type="text/javascript">
        function addStep() {
            /*本函数用于添加阶段，计算本阶段 是第几步*/
            var val = $("#defaultField").children("div:last-child").attr("value");
            if (val == null) {
                val = 1;
            }
            val = Number(val) + 1;
            $("#defaultField").append("<div class=\"field\" value = \"" + val + "\">\n" +
                "                    <label>阶段" + val + "</label>\n" +
                "                    <div class=\"three fields\">\n" +
                "                        <div class=\"three wide field\">\n" +
                "                            <input type=\"text\" placeholder=\"名称\">\n" +
                "                        </div>\n" +
                "                        <div class=\"three wide field\">\n" +
                "                            <div class=\"ui myCal calendar\" >\n" +
                "                                <div class=\"ui icon input\">\n" +
                "                                    <i class=\"calendar icon\"></i>\n" +
                "                                    <input type=\"text\" placeholder=\"截止日期\" value=\"\">\n" +
                "                                </div>\n" +
                "                            </div>\n" +
                "                        </div>\n" +
                "                        <div class=\"ten wide field\">\n" +
                "                            <input type=\"text\" placeholder=\"描述\">\n" +
                "                        </div>\n" +
                "                    </div>\n" +
                "               </div>\n");
            initCalendar();/*再加载一遍日历显示控件*/
        }
        
        function deleteStep() {
            if ($("#defaultField:has(div)").length == 0){
                $('.delete.mini.modal')
                    .modal('show')
                ;
            }
            $("#defaultField").children("div:last-child").remove();
        }

        function initCalendar() {
            $('.myCal.calendar').calendar({
                type: 'date',
                formatter: { // 自定义日期的格式
                    date: function(date, settings) {
                        if (!date) return '';

                        var year  = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day   = date.getDate();

                        month = month < 10 ? '0'+month : month;
                        day   = day   < 10 ? '0'+day   : day;

                        return year + '-' + month + '-' + day;
                    }
                }
            });
        }
    </script>
</head>
<body>

<div>
    <a class="ui big red ribbon label">
        <i class="ui add icon"></i>
        新建任务
    </a>
    <p></p>
    <div class="ui content">
        <form class="ui form" action="#" enctype="multipart/form-data">
            <div class="field">
                <label>任务基本信息</label>
                <div class="two fields">
                    <div class="three wide field">
                        <input type="text" placeholder="任务名称">
                    </div>
                    <div class="thirteen wide field">
                        <input type="text" placeholder="任务描述">
                    </div>
                </div>
            </div>
            <div class="field" id="basicField">
                <label>阶段1</label>
                <div class="three fields">
                    <div class="three wide field">
                        <input type="text" placeholder="名称">
                    </div>
                    <div class="three wide field">
                        <div class="ui myCal calendar" id="">
                            <div class="ui icon input">
                                <i class="calendar icon"></i>
                                    <%
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
                                        String myDate = sdf.format(new Date());
                                    %>
                                    <input id="inputWorkTime" type="text" placeholder="截止日期" value="">
                                </div>
                            </div>
                        </div>
                        <div class="ten wide field">
                            <input type="text" placeholder="描述">
                        </div>
                    </div>
                </div>
                <div class="field" id="defaultField"></div>
                <div class="filed">
                    <div class="actions">
                        <div class="fields">
                            <div class="four wide field"></div>
                            <div class="three wide field">
                                <button class="ui blue icon button" onclick="addStep()">
                                    <i class="add icon"></i>
                                    添加阶段
                                </button>
                            </div>
                            <div class="three wide field">
                                <button class="ui red icon button" onclick="deleteStep()">
                                    <i class="delete icon"></i>
                                    删除阶段
                                </button>
                            </div>
                            <div class="three wide field">
                                <button class="ui black left labeled icon button">
                                    <i class="minus circle icon"></i>
                                    取消
                                </button>
                            </div>
                            <div class="three wide field">
                                <button id="mySubmit" type="submit" class="ui positive left labeled icon button">
                                    <i class="check circle icon"></i>
                                    保存
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

<div class="ui delete mini modal">
    <div class="header">
        <i class="ui exclamation circle icon"></i>
        删除失败
    </div>
    <div class="content">
        <p>
            至少包含一个阶段！
        </p>
    </div>
    <div class="actions">
        <div class="ui approve green button">确认</div>
    </div>
</div>
<div class="ui save mini modal">
    <div class="header">
        <i class="ui check circle icon"></i>
        保存成功
    </div>
    <div class="content">
        <p>
            单击“查看任务”选项卡以分配任务
        </p>
    </div>
    <div class="actions">
        <div class="ui approve green button">确认</div>
        <div class="ui green button">转到查看任务</div>
    </div>
</div>

</body>
</html>
