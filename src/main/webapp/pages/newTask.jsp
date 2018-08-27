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
                $('.coupled.modal')
                    .modal({
                        allowMultiple: true
                    })
                ;
                $('.selectPerson.modal')
                    .modal('attach events', '.save.modal .approve.button')
                ;
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
    <a class="ui big green ribbon label">
        <i class="ui add icon"></i>
        新建任务
    </a>
    <p></p>
    <div class="ui content">
        <form class="ui form" action="#" enctype="multipart/form-data">
            <div class="required field">
                <h4>任务基本信息</h4>
                <div class="two fields">
                    <div class="three wide field">
                        <label>任务名称：</label>
                        <input type="text" placeholder="少于15个字" maxlength="15">
                    </div>
                    <div class="two wide field">
                        <label>任务时长（天）：</label>
                        <input type="number">
                    </div>
                    <div class="eleven wide field">
                        <label>任务内容：</label>
                        <input type="text" placeholder="少于200个字" maxlength="200">
                    </div>
                </div>
            </div>
            <%--<div class="field">
                <div class="fields">
                    <div class="one wide fild">
                        <h4>任务阶段：</h4>
                    </div>
                    <div class="two wide fild">
                        <div class="ui mini basic icon buttons">
                            <button class="ui button" onclick="addStep()" data-tooltip="添加阶段"><i class="add icon"></i></button>
                            <button class="ui button" onclick="deleteStep()" data-tooltip="删除阶段"><i class="delete icon"></i></button>
                        </div>
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
                </div>--%>
            <div class="field">
                <div class="fields">
                    <div class="one wide fild">
                        <h4>添加附件：</h4>
                    </div>
                </div>
            </div>
                <div class="field" id="defaultField"></div>
                <div class="filed">
                    <div class="actions">
                        <div class="fields">
                            <div class="three wide field">
                                <input type="file" placeholder="上传附件...">
                            </div>
                            <div class="seven wide field"></div>
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
<div class="ui save coupled mini modal">
    <div class="header">
        <i class="ui check circle icon"></i>
        保存成功
    </div>
    <div class="content">
        <p>任务名称：恒大集团练手系统</p>
        <p>任务描述：这是一个给恒大集团新员工的练手系统</p>
        <p>预期时间：24天</p>
        <p>
            任务附件：资料.zip
            <a class="ui icon button">
                <i class="ui cloud download icon"></i>
                点击下载
            </a>
        </p>
    </div>
    <div class="actions">
        <div class="ui approve blue button">分配人员</div>
        <div class="ui green button">转到查看任务</div>
    </div>
</div>

<div class="ui selectPerson coupled modal">
    <div class="header">
        <i class="ui random icon"></i>
        任务分配
    </div>
    <div class="content">
        <div class="ui three column doubling grid">
            <div class="two wide column"></div>
            <div class="two wide column">
                <h4>选择角色：</h4>
            </div>
            <div class="eight wide column">
                <select name="staff" class="ui fluid dropdown">
                    <option value="">选择角色</option>
                    <option value="staff1">1-杨旭</option>
                    <option value="staff2">2-徐广松</option>
                </select>
            </div>
            <div class="two wide column"></div>
        </div>
    </div>
    <div class="actions">
        <div class="ui green button">确认</div>
        <div class="ui button">取消</div>
    </div>
</div>

</body>
</html>
