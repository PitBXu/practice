<%--
  Created by IntelliJ IDEA.
  User: 100622161
  Date: 2018-8-24
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>任务分配</title>
    <link href="${pageContext.request.contextPath}/dist/semantic.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/dist/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/dist/semantic.js"></script>
    <link href="${pageContext.request.contextPath}/dist/calendar.css" rel="stylesheet" >
    <script src="${pageContext.request.contextPath}/dist/calendar.js" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/dist/tablesort.js"></script>
    <script type="text/javascript">
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
        function clearDate() {
            //点击按键之后清空日期的选择
            $("#searchTime1").val("");
            $("#searchTime2").val("");
        }
        function initMenu(){
            $('.ui.dropdown')
                .dropdown({
                    allowAdditions: true
                })
            ;
            $(".ui.menu a.item")
                .on('click', function() {
                    $(this)
                        .addClass('active')
                        .siblings()
                        .removeClass('active')
                    ;
                    var datatab = $(this).attr("data-tab");
                    $("[data-pop='"+datatab+"']")
                        .addClass('active')
                        .siblings()
                        .removeClass('active')
                    ;
                })
            ;

        }
    </script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
                initCalendar();
                initMenu();
            })
        ;
    </script>
</head>
<body>
    <div class="main ui container">
        <div id="container" style="display: block;">
            <a class="ui big blue ribbon label">
                <i class="ui random icon"></i>
                任务分配
            </a>
            <br/>
            <br/>
            <div class="ui segment">
                <div class="ui three column doubling grid">
                    <div class="two wide column"></div>
                    <div class="two wide column">
                        <h4>指定日期区间：</h4>
                    </div>
                    <div class="four wide column">
                        <div class="ui myCal calendar">
                            <div class="ui icon input"><div class="ui popup calendar"><table class="ui celled center aligned unstackable table seven column day"><thead><tr><th colspan="7"><span class="link">August 2018</span><span class="prev link"><i class="chevron left icon"></i></span><span class="next link"><i class="chevron right icon"></i></span></th></tr><tr><th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th></tr></thead><tbody><tr><td class="link adjacent disabled">29</td><td class="link adjacent disabled">30</td><td class="link adjacent disabled">31</td><td class="link">1</td><td class="link">2</td><td class="link">3</td><td class="link">4</td></tr><tr><td class="link">5</td><td class="link">6</td><td class="link">7</td><td class="link">8</td><td class="link">9</td><td class="link">10</td><td class="link">7</td></tr><tr><td class="link">12</td><td class="link">13</td><td class="link">14</td><td class="link">15</td><td class="link">16</td><td class="link">17</td><td class="link">18</td></tr><tr><td class="link">19</td><td class="link">20</td><td class="link">21</td><td class="link today focus">22</td><td class="link">23</td><td class="link">24</td><td class="link">25</td></tr><tr><td class="link">26</td><td class="link">27</td><td class="link">28</td><td class="link">29</td><td class="link">30</td><td class="link">31</td><td class="link adjacent disabled">1</td></tr><tr><td class="link adjacent disabled">2</td><td class="link adjacent disabled">3</td><td class="link adjacent disabled">4</td><td class="link adjacent disabled">5</td><td class="link adjacent disabled">6</td><td class="link adjacent disabled">7</td><td class="link adjacent disabled">8</td></tr></tbody></table></div>
                                <i class="calendar icon"></i>
                                <input id="searchTime1" type="text" placeholder="选择起始日期" value="">
                            </div>
                        </div>
                    </div>
                    <div class="four wide column">
                        <div class="ui myCal calendar">
                            <div class="ui icon input"><div class="ui popup calendar"><table class="ui celled center aligned unstackable table seven column day"><thead><tr><th colspan="7"><span class="link">August 2018</span><span class="prev link"><i class="chevron left icon"></i></span><span class="next link"><i class="chevron right icon"></i></span></th></tr><tr><th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th></tr></thead><tbody><tr><td class="link adjacent disabled">29</td><td class="link adjacent disabled">30</td><td class="link adjacent disabled">31</td><td class="link">1</td><td class="link">2</td><td class="link">3</td><td class="link">4</td></tr><tr><td class="link">5</td><td class="link">6</td><td class="link">7</td><td class="link">8</td><td class="link">9</td><td class="link">10</td><td class="link">7</td></tr><tr><td class="link">12</td><td class="link">13</td><td class="link">14</td><td class="link">15</td><td class="link">16</td><td class="link">17</td><td class="link">18</td></tr><tr><td class="link">19</td><td class="link">20</td><td class="link">21</td><td class="link today focus">22</td><td class="link">23</td><td class="link">24</td><td class="link">25</td></tr><tr><td class="link">26</td><td class="link">27</td><td class="link">28</td><td class="link">29</td><td class="link">30</td><td class="link">31</td><td class="link adjacent disabled">1</td></tr><tr><td class="link adjacent disabled">2</td><td class="link adjacent disabled">3</td><td class="link adjacent disabled">4</td><td class="link adjacent disabled">5</td><td class="link adjacent disabled">6</td><td class="link adjacent disabled">7</td><td class="link adjacent disabled">8</td></tr></tbody></table></div>
                                <i class="calendar icon"></i>
                                <input id="searchTime2" type="text" placeholder="选择结束日期" value="">
                            </div>
                        </div>
                    </div>
                    <div class="two wide column"></div>
                    <div class="two wide column">
                        <div class="ui buttons">
                            <div class="ui primary icon button" onclick="clearDate()" data-tooltip="清空">
                                <i class="ui delete icon"></i>
                            </div>
                            <div class="or"></div>
                            <div class="ui green icon button" data-tooltip="检索">
                                <i class="ui search icon"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="ui two column doubling grid">
                    <div class="ui four wide column"></div>
                    <div class="ui four wide column">
                        <div class="ui icon input">
                            <input id="inputNameOrId" type="text" placeholder="可搜索任务名称，角色、">
                            <i class="search icon"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ui segment">
                <div class="ui three column doubling grid">
                    <div class="two wide column"></div>
                    <div class="two wide column">
                        <h4>选择任务：</h4>
                    </div>
                    <div class="eight wide column">
                        <select name="tasks" class="ui fluid dropdown">
                            <option value="">选择任务</option>
                            <option value="task1">练手系统1</option>
                            <option value="task2">练手系统2</option>
                            <option value="task3">练手系统3</option>
                        </select>
                    </div>
                    <div class="two wide column"></div>
                </div>
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
                <div class="ui column doubling grid">
                    <div class="two wide column"></div>
                    <div class="eight wide column">
                    </div>
                    <div class="two wide column">
                        <button class="ui mini black left labeled icon button">
                            <i class="minus circle icon"></i>
                            取消
                        </button>
                    </div>
                    <div class="two wide column">
                        <button class="ui mini positive left labeled icon button">
                            <i class="check circle icon"></i>
                            保存
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
