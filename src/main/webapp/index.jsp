<%--
  Created by IntelliJ IDEA.
  User: yangxu
  Date: 2018/08/21
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>恒大集团练手系统</title>
    <link href="dist/semantic.css" rel="stylesheet">
    <script src="dist/jquery.min.js"></script>
    <script src="dist/semantic.js"></script>
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
                $("#mainPage")
                    .on('click',function(){
                        $(".ui.main.segment").load("pages/mainPage.jsp");
                    })
                ;
                $("#newTask")
                    .on('click',function(){
                        $(".ui.main.segment").load("pages/newTask.jsp");
                    })
                ;
                $("#selectTask")
                    .on('click',function(){
                        $(".ui.main.segment").load("pages/selectTask.jsp");
                    })
                ;
                $("#selectTaskStep1")
                    .on('click',function(){
                        $(".ui.main.segment").load("pages/selectTaskStep1.jsp");
                    })
                ;
                $("#grantTask")
                    .on('click',function(){
                        $(".ui.main.segment").load("pages/grantTask.jsp");
                    })
                ;
                $("#candidateManager")
                    .on('click', function () {
                        $(".ui.main.segment").load("Settings/candidateManager.jsp");
                    })
                ;
                $("#positionManager")
                    .on('click', function () {
                        $(".ui.main.segment").load("Settings/positionManager.jsp");
                    })
                ;
            })
        ;
    </script>
    <script type="text/css">

    </script>
</head>
<body>
<div class="">
    <div class="bar" style="width: 100%;height: 65px;">
        <div class="logo" style="position: absolute; left: 3%">
            <a href="http://www.evergrande.com">
                <img src="dist/assets/images/logo2.jpg" style="width: auto; height: 50px; float: left; margin-top: 7px">
            </a>
            <img src="dist/assets/images/name.png" style="width: 20px;float: left;">
        </div>
        <div class="ui buttons" style="position: absolute;right: 10%; top:10px;">
            <button class="ui basic huge icon button">
                <i class="ui calendar outline icon"></i>
            </button>
            <button class="ui basic huge icon button">
                <i class="ui alarm icon"></i>
            </button>

        </div>
        <div style="position: absolute;right: 7%; top:20px;">
            <img class="ui avatar image" src="dist/assets/images/tom.jpg">
        </div>

    </div>
    <div class="ui grid">
        <div class="two wide column">
            <div class="ui vertical fluid tabular icon labeled menu">
                <a class="item active" id="mainPage">
                    <i class="ui home icon"></i>
                    首页
                </a>
                <a class="item" id="positionManager">
                    <i class="ui user icon"></i>
                    消息中心
                </a>
                <div class="item">
                    <i class="ui flag icon"></i>
                    任务管理
                </div>
                <a class="item" id="newTask">
                    新建任务
                </a>
                <a class="item right" id="selectTask">
                    查看任务
                </a>
                <a class="item" id="grantTask">
                任务分配
            </a>
                <a class="item" id="selectTaskStep1">
                    <i class="ui setting icon"></i>
                    配置中心
                </a>

                <div class="item" style="height: 300px">

                </div>
            </div>
        </div>
        <div class="fourteen wide stretched column">
            <div class="ui main segment"></div>
        </div>
    </div>
</div>

<div class="ui inverted vertical footer segment" style="background-color: #0d1517;">
    <div class="ui container">
        <div class="seven wide column">
            <small>&#169; Copyright 2017 EverGrande | Powered by <a href="http://www.EverGrande.com">EverGrande.com</a> | <a href="#">Top</a> </small>
        </div>
    </div>
</div>

</body>
</html>
