<%--
  Created by IntelliJ IDEA.
  User: 100622161
  Date: 2018-8-22
  Time: 17:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
            <a data-tooltip="详细信息">
                <i class="ui file alternate outline icon" onclick="showDetails()"></i>
            </a>
        </td>
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
            <a data-tooltip="详细信息">
                <i class="ui file alternate outline icon"></i>
            </a>
        </td>
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
            <a data-tooltip="详细信息">
                <i class="ui file alternate outline icon"></i>
            </a>
        </td>
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
            <a data-tooltip="详细信息">
                <i class="ui file alternate outline icon"></i>
            </a>
        </td>
    </tr>
    </tbody>
    <tfoot id="tfoot">
    <tr>
        <th colspan="3">
            每页显示
            <div class="ui compact selection dropdown hidden" tabindex="0">
                <select id="selectPageNum">
                    <option value="10" selected="">10</option>
                    <option value="20">20</option>
                    <option value="30">30</option>
                </select>
                <i class="dropdown icon"></i>
                <div class="text hidden">10</div>
                <div class="menu hidden" tabindex="-1">
                    <div class="item active selected hidden" data-value="10">10</div>
                    <div class="item hidden" data-value="20">20</div>
                    <div class="item hidden" data-value="30">30</div>
                </div>
            </div>
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
            <div class="ui compact selection dropdown hidden" tabindex="0">
                <select id="gotoPage">
                    <option value="1" selected="">1</option>
                </select>
                <i class="dropdown icon"></i>
                <div class="text hidden">1</div>
                <div class="menu hidden" tabindex="-1">
                    <div class="item active selected hidden" data-value="1">1</div>
                </div>
            </div>
        </th>
    </tr>
    </tfoot>
</table>
</body>
</html>
