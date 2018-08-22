<%--
  Created by IntelliJ IDEA.
  User: YangXu
  Date: 2018-8-21
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <link href="../dist/semantic.css" rel="stylesheet">
    <script src="../dist/jquery.min.js"></script>
    <script src="../dist/semantic.js"></script>
    <script>
        $(document)
                    .ready(function() {
                        $('.ui.menu .ui.dropdown').dropdown({
                            on: 'hover'
                        });
                        $('.ui.menu a.item')
                            .on('click', function() {
                                $(this)
                                    .addClass('active')
                                    .siblings()
                                    .removeClass('active')
                                ;
                            })
                        ;
                $('#example5')
                    .progress({
                        text: {
                            active  : '练手系统已完成 {value} % ',
                            success : '{total} % 完成!'
                        }
                    })
                ;
                $('#example6')
                    .progress({
                        text: {
                            active  : '剩余 {value} 小时 ',
                            success : '{total} % 完成!'
                        }
                    })
                ;
                $(".ui.pointing.label")
                    .on('click',function () {
                        $('#example5')
                            .progress('increment')
                        ;
                        $('#example6')
                            .progress('decrement')
                        ;
                    })
                ;
            })
        ;
    </script>
    <script type="text/javascript">

    </script>
</head>


<body>
    <div class = "ui two cards">
        <div class="ui card">
            <div class="ui raised segment">
                <a class="ui red ribbon label">
                    <i class="ui crosshairs icon"></i>
                    任务情况追踪
                </a>
                <div class="ui secondary pointing menu">
                    <a class="ui black pointing below ignored label">
                        <i class="ui plus icon"></i> Increase
                    </a>
                    <div class="right menu">
                        <a class="item active">杨旭</a>
                        <a class="item">徐广松</a>
                    </div>
                </div>
                <div class="ui content">
                    <div class="ui indicating progress" data-value="1" data-total="100" id="example5">
                        <div class="bar"></div>
                        <div class="label">练手系统</div>
                    </div>
                    <div class="ui indicating progress" data-value="80" data-total="100" id="example6">
                        <div class="bar"></div>
                        <div class="label">剩余时间</div>
                    </div>
                    <a class="ui teal right ribbon label">预计完成日期：2018年9月5日</a>
                </div>
            </div>
        </div>
        <div class="ui card">
            <div class="ui raised segment">
                <a class="ui blue ribbon label">
                    <i class="ui chart area icon"></i>
                    本月任务情况
                </a>
                <div class="content">
                    本月任务完成情况良好，请继续保持！
                    <p></p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
