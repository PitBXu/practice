<%--
  Created by IntelliJ IDEA.
  User: 100622161
  Date: 2018-8-22
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="${pageContext.request.contextPath}/dist/semantic.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/semantic.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $(".ui.menu .ui.dropdown").dropdown({
                on: 'hover'
            });
            $(".ui.menu a.item")
                .on('click', function() {
                    $(this)
                        .addClass('active')
                        .siblings()
                        .removeClass('active')
                    ;
                    var datatab = $(this).attr("data-tab");
                    $("[data-tab='"+datatab+"']")
                        .addClass('active')
                        .siblings()
                        .removeClass('active')
                    ;
                })
            ;
        })
        ;
    </script>
</head>
<body>
<div class="ui secondary pointing menu">
    <a class="active item" data-tab="1">
        Home
    </a>
    <a class="item" data-tab="2">
        Messages
    </a>
    <a class="item" data-tab="3">
        Friends
    </a>
    <div class="right menu">
        <a class="ui item" data-tab="4">
            Logout
        </a>
    </div>
</div>
<div class="ui bottom attached tab segment active" data-tab="1">
    <p>我是第一段</p>
</div>
<div class="ui bottom attached tab segment" data-tab="2">
    <p>我是第2段</p>
</div>
<div class="ui bottom attached tab segment" data-tab="3">
    <p>我是第3段</p>
</div>
<div class="ui bottom attached tab segment" data-tab="4">
    <p>我是第4段</p>
</div>
</body>
</html>
