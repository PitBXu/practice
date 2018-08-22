<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: 杨旭
  Date: 2018.08.21
  Time: 14:14
  To change this template use File | Settings | File Templates.
  Alter: yangxu
  Date: 2017.12.6

--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务管理</title>
    <link href="${pageContext.request.contextPath}/dist/semantic.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/dist/calendar.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/dist/jquery-3.2.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/semantic.js"></script>
    <script src="${pageContext.request.contextPath}/dist/tablesort.js"></script>
    <script src="${pageContext.request.contextPath}/dist/calendar.min.js"></script>

    <script type="text/javascript">
        var InStatus = 1;//参数1，入职状态1待入职，2已入职，3放弃入职，0全部，默认显示待入职
        var pageNo = 1;//参数2，第几页
        var pageNum = 10;//参数3，每页显示多少条
        var nameOrId = "";//参数4，姓名或id的检索
        var workCity = "";//参数5，工作城市
        var personCategory = 0;//参数6，人员类别
        var departNumber = 0;//参数7，部门umber
        var workTime = "";//参数8，入职日期
        $(document).ready(function () {
            loadData();
            selectByCondition();
        });
        function initPage() {
            //表格排序
            $("table").tablesort();
            //导航栏选项卡
            $('.secondary.menu a.item')
                .tab()
            ;
            $('.secondary.menu a.item')
                .on('click', function() {
                    $(this).addClass('active').siblings().removeClass('active');
                    InStatus = $(this).attr("value");
                    //清空所有输入框
                    initData();
                    $("#inputNameOrId").val("");
                    $("#inputWorkCity").val("");
                    $("#inputWorkTime").val("");
                    //清空部门选择
                    $("#selectDepartNumber").siblings("div.text").text("选择部门");
                    $("#selectDepartNumber").siblings("div.menu").children().removeClass("active selected");
                    $("#selectDepartNumber").siblings("div.menu").children().eq(0).addClass("active selected");
                    //alert($("#selectDepartNumber").siblings("div.menu").children(".active").attr("data-value"));
                    //清空人员类别选择
                    $("#selectPersonCategory").siblings("div.text").text("人员类别");
                    $("#selectPersonCategory").siblings("div.menu").children().removeClass("active selected");
                    $("#selectPersonCategory").siblings("div.menu").children().eq(0).addClass("active selected");
                    //更改状态之后重新查询
                    initData();
                    loadData();
                    selectByCondition();
                })
            ;
            /*对应下面的按照人员类别搜索*/
            $('.dropdown')
                .dropdown({
                    // you can use any ui transition
                    transition: 'drop'
                })
            ;
            /*日期*/
            $('#example1').calendar({
                type: 'date',
                formatter: { // 自定义日期的格式
                    date: function (date, settings) {
                        if (!date) return '';
                        var year = date.getFullYear();
                        var month = date.getMonth() + 1;
                        var day = date.getDate();
                        month = month < 10 ? '0' + month : month;
                        day = day < 10 ? '0' + day : day;
                        return year + '-' + month + '-' + day;
                    }
                }
            });
            //点击展开的功能
            $("i.plus.square.outline")
                .on('click',function () {
                    if ($(this).hasClass("plus")){
                        //点开某个加号
                        //把别人变成加号
                        $("tr td a.plus i").removeClass("minus").addClass("plus");
                        //把自己变成减号
                        $(this).removeClass("plus").addClass("minus");
                        //隐藏别人的内容
                        $("tr th div").addClass("hidden");
                        //显示自己的内容
                        $(this).parent().parent().parent().next().children().children().removeClass("hidden");
                        //变为选中
                        $(this).parent().parent().parent().addClass("active").siblings().removeClass("active");
                    }else{
                        //点击某个减号
                        //把自己变成加号
                        $(this).removeClass("minus").addClass("plus");
                        //隐藏自己的内容
                        $(this).parent().parent().parent().next().children().children().addClass("hidden");
                    }
                })
            ;
            $("#gotoPage").on('change',function () {
                pageNo = $(this).val();
                stateChanged();
            });
            $("#nextPage.ok").on('click',function () {
                pageNo = parseInt(pageNo) + 1;
                stateChanged();
            });
            $("#previousPage.ok").on('click',function () {
                pageNo = parseInt(pageNo) - 1;
                stateChanged();
            });
            $.ajax({
                type: 'post',
                url: '/getDepartmentList',
                success: function (data) {
                    var departmentList = eval(data).rows;
                    $.each(departmentList, function (i, department) {
                        $("#selectDepartNumber").append(
                            "<option value=" + department.departmentNumber + ">" + department.departmentName + "</option>"
                        )
                    });
                }
            });
        }
        function loadData() {
            //改变条件之后的装载数据到表单
            $("#InStatus").val(InStatus);
            $("#pageNo").val(pageNo);
            $("#pageNum").val(pageNum);
            $("#nameOrId").val(nameOrId);
            $("#workCity").val(workCity);
            $("#personCategory").val(personCategory);
            $("#departNumber").val(departNumber);
            $("#workTime").val(workTime);
        }
        function initData() {
            pageNum = $("#selectPageNum").val();
            nameOrId = $("#inputNameOrId").val();
            workCity = $("#inputWorkCity").val();
            personCategory = $("#selectPersonCategory").val();
            if (personCategory == "人员类别"){
                //人员类别需要预处理，后台需要的类型是int
                personCategory = 0;
            }
            departNumber = $("#selectDepartNumber").val();
            if (departNumber == "选择部门"){
                //人员类别需要预处理，后台需要的类型是int
                departNumber = 0;
            }
            workTime = $("#inputWorkTime").val();
        }
        function clearDate() {
            //点击按键之后清空日期的选择
            $("#inputWorkTime").val("");
        }
        function selectByCondition() {
            //查询数据方法
            $("#container").css("display", "none");
            $("#loading").css("display", "block");
            $.ajax({
                type: "post",
                url: "/selectPositionWithCondition.do",
                dataType: "json",
                timeout: 10000,
                async: false,
                cache: false,
                data: $("#initPage").serialize(),
                success : function(data,textStatus){
                    var pageInfo = eval(data).rows;
                    var positionList = pageInfo.list;
                    clear();
                    if (pageInfo.total == 0){
                        alert("当前暂无入职人员！");
                    }else{
                        $.each(positionList, function (i, pos) {
                            //循环之前先解析材料信息
                            var material = "";
                            for (var i=0;i<pos.loyerMaterialDetails.length;i++){
                                var cont = pos.loyerMaterialDetails[i].split("-");
                                var stateList = "";
                                var contentList = "";
                                if (parseInt(cont[0]) == 0){
                                    stateList = "<a class=\'ui grey empty circular label\'></a>";//未提交
                                }else if(parseInt(cont[0]) == 1){//已提交
                                    stateList = "<a class=\'ui teal empty circular label\'></a>";
                                }else if(parseInt(cont[0]) == 3){//已通过
                                    stateList ="<a class='green label'><i class='ui check square icon'></i></a>";
                                }else{
                                    stateList = "<a class=\'ui grey empty circular label\'></a>";//未提交
                                }
                                contentList = cont[1] + "&nbsp";
                                material = material + stateList + contentList;
                            }
                            var tool = "";
                            if (pos.offerStatus == "待入职"){
                                tool = "放弃入职";
                            }
                            $("#tbody").append("<tr>\n" +
                                "            <td>\n" +
                                "                <a class=\"plus\">\n" +
                                "                    <i class=\"ui plus square outline icon\"></i>\n" +
                                "                </a>\n" +
                                "            </td>\n" +
                                "            <td>"+pos.name+"</td>\n" +
                                "            <td>"+pos.employeeNumber+"</td>\n" +
                                "            <td>"+pos.positionName+"</td>\n" +
                                "            <td>"+pos.workCity+"</td>\n" +
                                "            <td>"+pos.staffType+"</td>\n" +
                                "            <td>"+pos.exceptWorkTime+"</td>\n" +
                                "            <td>"+pos.candidateStatus+"</td>\n" +
                                "            <td>"+pos.loyerMaterial+"</td>\n" +
                                "            <td>"+pos.otherMaterial+"</td>\n" +
                                "            <td>"+pos.socialInsurancePayBj+"</td>\n" +
                                "            <td>"+pos.offerStatus+"</td>\n" +
                                "            <td>\n" +
                                "                <a data-tooltip='"+tool+"'>\n" +
                                "                    <i class=\"ui setting icon\"></i>\n" +
                                "                </a>\n" +
                                "            </td>\n" +
                                "        </tr>\n" +
                                "        <tr style=\"background-color: #f1f1f1\">\n" +
                                "            <th colspan=\"1\"></th>\n" +
                                "            <th colspan=\"11\">\n" +
                                "                <div class=\"transition hidden\" >\n" +
                                "                    <i class=\"ui building outline icon\"></i>\n" +
                                "                    宜信卓越财富投资管理（北京）有限公司 &nbsp;&nbsp;&nbsp;\n" +
                                "                    <i class=\"ui sitemap icon\"></i>\n" +
                                "                    "+pos.departRoute+"\n" +
                                "                    <div class=\"ui fitted divider inverted\"></div>\n" +
                                "                    材料提交情况：<a class=\"ui grey empty circular label\"></a>待提交\n" +
                                "                    <a class=\"ui teal empty circular label\"></a>已提交\n" +
                                "                    <a class=\"green label\"><i class=\"ui check square icon\"></i></a>已通过\n" +
                                "                    <br/>\n" +
                                "                    "+material+"\n" +
                                "                </div>\n" +
                                "            </th>\n" +
                                "            <th colspan=\"1\"></th>\n" +
                                "        </tr>")
                        });
                        var pageNumber = pageInfo.pages;
                        var pageContent = "";
                        for (var i=1;i<=pageNumber;i++){
                            if (i == pageInfo.pageNum){
                                pageContent = pageContent + "<option value='"+i+"' selected = ''>"+i+"</option>";
                            }else{
                                pageContent = pageContent + "<option value='"+i+"'>"+i+"</option>";
                            }
                        }
                        $("#tfoot").append("<tr>\n" +
                            "            <th colspan=\"3\">\n" +
                            "                每页显示\n" +
                            "                <select id=\"selectPageNum\" class=\"ui compact selection dropdown\">\n" +
                            "                    <i class=\"dropdown icon\"></i>\n" +
                            "                    <option value=\"10\" selected=\"\">10</option>\n" +
                            "                    <option value=\"20\">20</option>\n" +
                            "                    <option value=\"30\">30</option>\n" +
                            "                </select>\n" +
                            "            </th>\n" +
                            "            <th colspan=\"4\"></th>\n" +
                            "            <th colspan=\"4\">\n" +
                            "                <div class=\"ui pagination menu\">\n" +
                            "                    <a class=\"item active disabled\" id='pageMessage'>第" + pageInfo.pageNum + "页-（共" + pageInfo.pages + "页）</a>\n" +
                            "                    <a class=\"item\" id='previousPage'>\n" +
                            "                        <i class=\"ui left chevron icon\"></i>\n" +
                            "                    </a>\n" +
                            "                    <a class=\"item\" id='nextPage'>\n" +
                            "                        <i class=\"ui right chevron icon\"></i>\n" +
                            "                    </a>\n" +
                            "                </div>\n" +
                            "            </th>\n" +
                            "            <th colspan=\"2\">\n" +
                            "                跳转到：\n" +
                            "                <select id='gotoPage' class=\"ui compact selection dropdown\">\n" +
                            "                    <i class=\"dropdown icon\"></i>\n" +
                            "                    "+ pageContent +"\n" +
                            "                </select>\n" +
                            "            </th>\n" +
                            "        </tr>")
                        ;
                        if (pageInfo.pageNum == 1){
                            $("#previousPage").addClass("disabled");
                            $("#previousPage").removeClass("ok");
                        }else{
                            $("#previousPage").removeClass("disabled");
                            $("#previousPage").addClass("ok");
                        }
                        if (pageInfo.pageNum == pageInfo.pages){
                            $("#nextPage").addClass("disabled");
                            $("#nextPage").removeClass("ok");
                        }else {
                            $("#nextPage").removeClass("disabled");
                            $("#nextPage").addClass("ok");
                        }
                    }
                    initPage();
                    $("#container").css("display", "block");
                    $("#loading").css("display", "none");
                }
            });
        }
        function stateChanged() {
            initData();
            loadData();
            selectByCondition();
        }
        function clear() {
            $("#tbody").html("");
            $("#tfoot").html("");
        }
    </script>
</head>
<body>
<div class="main ui container">
    <div id="loading" style="text-align: center">
        <img src="${pageContext.request.contextPath}/dist/assets/images/loading.gif">
        <br/>
        <label>加载中...</label>
    </div>
    <div id="container" style="display: none;">
        <div class="ui three column doubling grid">
            <div class="two wide column" style="padding-left: 3%">
                <h6> 入职管理</h6>
            </div>
            <div class="three wide column"></div>
            <div class="five wide column">
                <%--导航栏--%>
                <div class="ui four pointing secondary menu">
                    <a class="item active" value="1">待入职</a>
                    <a class="item" value="2">已入职</a>
                    <a class="item" value="3">放弃入职</a>
                    <a class="item" value="0">全部</a>
                </div>
            </div>
        </div>
        <div class="ui segment">

            <div class="ui three column doubling grid">
                <%--第一个搜索框--%>
                <div class="four wide column">
                    <div>
                        <div class="ui icon input">
                            <input id="inputNameOrId" type="text" placeholder="可搜索员工姓名、ID">
                            <i class="search icon"></i>
                        </div>
                        <div class="results"></div>
                    </div>
                </div>
                <div class="nine wide column">
                    <div class="ui teal small left icon button" onclick="stateChanged()">
                        <i class="ui search icon"></i>
                        搜索
                    </div>
                </div>
                <%--新建入职--%>
                <div class="three wide column">
                    <button class="ui primary button">＋ 新建入职</button>
                </div>
            </div>

            <div class="ui four column doubling grid">
                <%--按照工作城市--%>
                <div class="four wide column">
                    <div>
                        <div class="ui icon input">
                            <input id="inputWorkCity" type="text" placeholder="工作城市">
                            <i class="search icon"></i>
                        </div>
                        <div class="results"></div>
                    </div>
                </div>
                <%--按照人员类别--%>
                <div class="four wide column">
                    <select id="selectPersonCategory" class="ui search dropdown">
                        <i class="dropdown icon"></i>
                        <option class="default text">人员类别</option>
                        <option value="1">1-试用</option>
                        <option value="2">2-实习</option>
                    </select>
                </div>
                <%--按照部门搜索--%>
                <div class="four wide column">
                    <select id="selectDepartNumber" class="ui search dropdown">
                        <i class="dropdown icon"></i>
                        <option class="default text">选择部门</option>
                    </select>
                </div>
                <%--按照入职日期搜索--%>
                <div class="four wide column">
                    <div class="ui calendar" id="example1">
                        <div class="ui icon input">
                            <i class="calendar icon"></i>
                            <%
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
                                String myDate = sdf.format(new Date());
                            %>
                            <input id="inputWorkTime" type="text" placeholder="未选择日期" value="">
                        </div>
                        <a class="ui basic" data-tooltip="清空日期" onclick="clearDate()">
                            <i class="ui delete icon"></i>
                        </a>
                    </div>
                </div>
            </div>
            <br/>
            <%--主表格--%>



        </div>
        <table class="ui left aligned sortable table">
            <thead>
            <tr>
                <th>
                    <a>
                        <i class="ui plus square"></i>
                    </a>
                </th>
                <th>证件姓名</th>
                <th>员工编号</th>
                <th>职位</th>
                <th>地点</th>
                <th>人员类别</th>
                <th>入职日期</th>
                <th>个人信息</th>
                <th>法定材料</th>
                <th>其他材料</th>
                <th>社保</th>
                <th>入职状态</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tbody">

            </tbody>
            <tfoot id="tfoot">

            </tfoot>
        </table>
    </div>
</div>

<form id="initPage">
    <%--//参数1，入职状态1待入职，2已入职，3放弃入职，0全部
    //参数2，第几页
    //参数3，每页显示多少条
    //参数4，姓名或id的检索
    //参数5，工作城市
    //参数6，人员类别
    //参数7，部门umber
    //参数8，入职日期
    //参数9，入职状态--%>
    <input id="InStatus" name="InStatus" style="display: none;">
    <input id="pageNo" name="pageNo" style="display: none;">
    <input id="pageNum" name="pageNum" style="display: none;">
    <input id="nameOrId" name="nameOrId" style="display: none;">
    <input id="workCity" name="workCity" style="display: none;">
    <input id="personCategory" name="personCategory" style="display: none;">
    <input id="departNumber" name="departNumber" style="display: none;">
    <input id="workTime" name="workTime" style="display: none;">
</form>


</body>
</html>
