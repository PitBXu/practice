<%--
  Created by IntelliJ IDEA.
  User: 100622161
  Date: 2018-8-22
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
            $("#searchTime").val("");
        }
        function initMenu(){
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
                })
            ;
            $('.dropdown')
                .dropdown({
                    // you can use any ui transition
                    transition: 'drop'
                })
            ;
        }
    </script>
    <script type="text/javascript">
        $(document)
            .ready(function() {
                //$("table").tablesort();
                //导航栏选项卡
                initCalendar();
                initMenu();
                $("i.square.outline")
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
            })
        ;
    </script>
</head>
<body>

<div class="main ui container">
    <div id="loading" style="text-align: center; display: none;">
        <img src="/dist/assets/images/loading.gif">
        <br>
        <label>加载中...</label>
    </div>
    <div id="container" style="display: block;">
        <div class="ui two column doubling grid">
            <div class="two wide column" style="padding-left: 3%">
                <h4> 查看任务</h4>
            </div>
            <div class="three wide column"></div>
            <div class="seven wide column">
                <div class="ui pointing secondary menu">
                    <a class="item active" value="1">待完善</a>
                    <a class="item" value="2">待分配</a>
                    <a class="item" value="3">待接受</a>
                    <a class="item" value="4">进行中</a>
                    <a class="item" value="5">已完成</a>
                    <a class="item" value="5">被驳回</a>
                </div>
            </div>
        </div>
        <div class="ui">
            <div class="ui three column doubling grid">
                <div class="four wide column">
                    <div>
                        <div class="ui icon input">
                            <input id="inputNameOrId" type="text" placeholder="可搜索任务名称，角色、">
                            <i class="search icon"></i>
                        </div>
                        <div class="results"></div>
                    </div>
                </div>
                <div class="four wide column">
                    <div class="ui myCal calendar">
                        <div class="ui icon input"><div class="ui popup calendar"><table class="ui celled center aligned unstackable table seven column day"><thead><tr><th colspan="7"><span class="link">August 2018</span><span class="prev link"><i class="chevron left icon"></i></span><span class="next link"><i class="chevron right icon"></i></span></th></tr><tr><th>S</th><th>M</th><th>T</th><th>W</th><th>T</th><th>F</th><th>S</th></tr></thead><tbody><tr><td class="link adjacent disabled">29</td><td class="link adjacent disabled">30</td><td class="link adjacent disabled">31</td><td class="link">1</td><td class="link">2</td><td class="link">3</td><td class="link">4</td></tr><tr><td class="link">5</td><td class="link">6</td><td class="link">7</td><td class="link">8</td><td class="link">9</td><td class="link">10</td><td class="link">7</td></tr><tr><td class="link">12</td><td class="link">13</td><td class="link">14</td><td class="link">15</td><td class="link">16</td><td class="link">17</td><td class="link">18</td></tr><tr><td class="link">19</td><td class="link">20</td><td class="link">21</td><td class="link today focus">22</td><td class="link">23</td><td class="link">24</td><td class="link">25</td></tr><tr><td class="link">26</td><td class="link">27</td><td class="link">28</td><td class="link">29</td><td class="link">30</td><td class="link">31</td><td class="link adjacent disabled">1</td></tr><tr><td class="link adjacent disabled">2</td><td class="link adjacent disabled">3</td><td class="link adjacent disabled">4</td><td class="link adjacent disabled">5</td><td class="link adjacent disabled">6</td><td class="link adjacent disabled">7</td><td class="link adjacent disabled">8</td></tr></tbody></table></div>
                            <i class="calendar icon"></i>
                            <input id="searchTime" type="text" placeholder="未选择日期" value="">
                        </div>
                        <a class="ui basic" data-tooltip="清空日期" onclick="clearDate()">
                            <i class="ui delete icon"></i>
                        </a>
                    </div>
                </div>
                <div class="two wide column">
                    <div class="ui teal small left icon button" onclick="stateChanged()">
                        <i class="ui search icon"></i>
                        搜索
                    </div>
                </div>
                <div class="three wide column"></div>
                <div class="three wide column">
                    <button class="ui primary icon button">
                        <i class="ui add icon"></i>
                        新建任务
                    </button>
                </div>
            </div>
            <br/>
        </div>
        <table class="ui left aligned sortable table">
            <thead>
            <tr>
                <th>
                    <a>
                        <i class="ui plus square"></i>
                    </a>
                </th>
                <th>任务名称</th>
                <th>任务类别</th>
                <th>任务描述</th>
                <th>任务状态</th>
                <th>执行人员</th>
                <th>创建时间</th>
                <th>修改时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="tbody">
            <tr class="active">
                <td>
                    <a class="plus">
                        <i class="ui square outline icon minus"></i>
                    </a>
                </td>
                <td>练手系统1</td>
                <td>开发类</td>
                <td>一个贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长的描述</td>
                <td>待完善</td>
                <td>1-杨旭</td>
                <td>2018-8-22 10:28</td>
                <td>2018-8-22 10:28</td>
                <td>
                    <a data-tooltip="编辑">
                        <i class="ui edit icon"></i>
                    </a>
                </td>
            </tr>
            <tr style="background-color: #f1f1f1">
                <th colspan="1"></th>
                <th colspan="7">
                    <div class="transition">
                        <i class="ui history icon"></i>
                        任务阶段： &nbsp;&nbsp;&nbsp;
                        <i class="ui sitemap icon"></i>
                        需求分析_概要设计_原型设计_需求文档_后台开发_集成测试_最终上线_后期运维
                        <div class="ui fitted divider inverted hidden"></div>
                        任务进行阶段：
                        <a class="ui grey empty circular label"></a>未完成
                        <a class="ui teal empty circular label"></a>已完成
                        <a class="ui red empty circular label "></a>已逾期
                        <br>
                        <a class="ui teal empty circular label"></a>需求分析&nbsp;
                        <a class="ui teal empty circular label"></a>概要设计&nbsp;
                        <a class="ui red empty circular label "></a>原型设计&nbsp;
                        <a class="ui grey empty circular label"></a>需求文档&nbsp;
                        <a class="ui grey empty circular label"></a>后台开发&nbsp;
                        <a class="ui grey empty circular label"></a>集成测试&nbsp;
                        <a class="ui grey empty circular label"></a>最终上线&nbsp;
                        <a class="ui grey empty circular label"></a>后期运维&nbsp;
                    </div>
                </th>
                <th colspan="1"></th>
            </tr>
            <tr>
                <td>
                    <a class="plus">
                        <i class="ui plus square outline icon"></i>
                    </a>
                </td>
                <td>练手系统2</td>
                <td>开发类</td>
                <td>一个贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长的描述</td>
                <td>待完善</td>
                <td>2-徐广松</td>
                <td>2018-8-22 10:28</td>
                <td>2018-8-22 10:28</td>
                <td>
                    <a data-tooltip="编辑">
                        <i class="ui edit icon"></i>
                    </a>
                </td>
            </tr>
            <tr style="background-color: #f1f1f1">
                <th colspan="1"></th>
                <th colspan="7">
                    <div class="transition hidden">
                        <i class="ui history icon"></i>
                        任务阶段： &nbsp;&nbsp;&nbsp;
                        <i class="ui sitemap icon"></i>
                        需求分析_概要设计_原型设计_需求文档_后台开发_集成测试_最终上线_后期运维
                        <div class="ui fitted divider inverted hidden"></div>
                        任务进行阶段：
                        <a class="ui grey empty circular label"></a>未完成
                        <a class="ui teal empty circular label"></a>已完成
                        <a class="ui red empty circular label "></a>已逾期
                        <br>
                        <a class="ui teal empty circular label"></a>需求分析&nbsp;
                        <a class="ui teal empty circular label"></a>概要设计&nbsp;
                        <a class="ui red empty circular label "></a>原型设计&nbsp;
                        <a class="ui grey empty circular label"></a>需求文档&nbsp;
                        <a class="ui grey empty circular label"></a>后台开发&nbsp;
                        <a class="ui grey empty circular label"></a>集成测试&nbsp;
                        <a class="ui grey empty circular label"></a>最终上线&nbsp;
                        <a class="ui grey empty circular label"></a>后期运维&nbsp;
                    </div>
                </th>
                <th colspan="1"></th>
            </tr>
            <tr>
                <td>
                    <a class="plus">
                        <i class="ui plus square outline icon"></i>
                    </a>
                </td>
                <td>练手系统3</td>
                <td>开发类</td>
                <td>一个贼拉长不太长贼拉长贼拉长也不太长贼拉长贼拉长贼拉长的描述</td>
                <td>待完善</td>
                <td>2-徐广松</td>
                <td>2018-8-22 10:28</td>
                <td>2018-8-22 10:28</td>
                <td>
                    <a data-tooltip="编辑">
                        <i class="ui edit icon"></i>
                    </a>
                </td>
            </tr>
            <tr style="background-color: #f1f1f1">
                <th colspan="1"></th>
                <th colspan="7">
                    <div class="transition hidden">
                        <i class="ui history icon"></i>
                        任务阶段： &nbsp;&nbsp;&nbsp;
                        <i class="ui sitemap icon"></i>
                        需求分析_概要设计_原型设计_需求文档_后台开发_集成测试_最终上线_后期运维
                        <div class="ui fitted divider inverted hidden"></div>
                        任务进行阶段：
                        <a class="ui grey empty circular label"></a>未完成
                        <a class="ui teal empty circular label"></a>已完成
                        <a class="ui red empty circular label "></a>已逾期
                        <br>
                        <a class="ui teal empty circular label"></a>需求分析&nbsp;
                        <a class="ui teal empty circular label"></a>概要设计&nbsp;
                        <a class="ui red empty circular label "></a>原型设计&nbsp;
                        <a class="ui grey empty circular label"></a>需求文档&nbsp;
                        <a class="ui grey empty circular label"></a>后台开发&nbsp;
                        <a class="ui grey empty circular label"></a>集成测试&nbsp;
                        <a class="ui grey empty circular label"></a>最终上线&nbsp;
                        <a class="ui grey empty circular label"></a>后期运维&nbsp;
                    </div>
                </th>
                <th colspan="1"></th>
            </tr>
            <tr>
                <td>
                    <a class="plus">
                        <i class="ui plus square outline icon"></i>
                    </a>
                </td>
                <td>练手系统4</td>
                <td>开发类</td>
                <td>一个贼拉长贼拉长贼拉长贼拉长贼拉长贼拉长的描述</td>
                <td>待完善</td>
                <td>2-徐广松</td>
                <td>2018-8-22 10:28</td>
                <td>2018-8-22 10:28</td>
                <td>
                    <a data-tooltip="编辑">
                        <i class="ui edit icon"></i>
                    </a>
                </td>
            </tr>
            <tr style="background-color: #f1f1f1">
                <th colspan="1"></th>
                <th colspan="7">
                    <div class="transition hidden">
                        <i class="ui history icon"></i>
                        任务阶段： &nbsp;&nbsp;&nbsp;
                        <i class="ui sitemap icon"></i>
                        需求分析_概要设计_原型设计_需求文档_后台开发_集成测试_最终上线_后期运维
                        <div class="ui fitted divider inverted hidden"></div>
                        任务进行阶段：
                        <a class="ui grey empty circular label"></a>未完成
                        <a class="ui teal empty circular label"></a>已完成
                        <a class="ui red empty circular label "></a>已逾期
                        <br>
                        <a class="ui teal empty circular label"></a>需求分析&nbsp;
                        <a class="ui teal empty circular label"></a>概要设计&nbsp;
                        <a class="ui red empty circular label "></a>原型设计&nbsp;
                        <a class="ui grey empty circular label"></a>需求文档&nbsp;
                        <a class="ui grey empty circular label"></a>后台开发&nbsp;
                        <a class="ui grey empty circular label"></a>集成测试&nbsp;
                        <a class="ui grey empty circular label"></a>最终上线&nbsp;
                        <a class="ui grey empty circular label"></a>后期运维&nbsp;
                    </div>
                </th>
                <th colspan="1"></th>
            </tr>
            </tbody>
            <tfoot id="tfoot">
                <tr>
                    <th colspan="3">
                        每页显示
                        <div class="ui compact selection dropdown hidden" tabindex="0"><select id="selectPageNum">

                            <option value="10" selected="">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                        </select><i class="dropdown icon"></i><div class="text hidden">10</div><div class="menu hidden" tabindex="-1"><div class="item active selected hidden" data-value="10">10</div><div class="item hidden" data-value="20">20</div><div class="item hidden" data-value="30">30</div></div></div>
                    </th>
                    <th colspan="1"></th>
                    <th colspan="3">
                        <div class="ui pagination menu hidden">
                            <a class="item active disabled" id="pageMessage">第1页-（共1页）</a>
                            <a class="item disabled" id="previousPage">
                                <i class="ui left chevron icon"></i>
                            </a>
                            <a class="item disabled" id="nextPage">
                                <i class="ui right chevron icon"></i>
                            </a>
                        </div>
                    </th>
                    <th colspan="3">
                        跳转到：
                        <div class="ui compact selection dropdown hidden" tabindex="0"><select id="gotoPage">
                            <option value="1" selected="">1</option>
                        </select><i class="dropdown icon"></i><div class="text hidden">1</div><div class="menu hidden" tabindex="-1"><div class="item active selected hidden" data-value="1">1</div></div></div>
                    </th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>

</body>
</html>
