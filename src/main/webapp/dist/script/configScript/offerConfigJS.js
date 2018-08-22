/**
 * Created by zhouhao on 2017/12/1.
 * Describe:offer配置js文件
 */

$('.ui.dropdown').dropdown();
$('.ui.radio.checkbox').checkbox();
$('.menu .item').tab();

//全局变量
var types=new Array();//所有得字段类型
var ids=new Array();//每个类型所对应得list得id
var orderIds = new Object();//排序后得id顺序
//根据指定字段类型初始化
function init(type,id) {
    var t_id='#'+id;
    $.ajax(
        {
            type: "POST",
            url: contextPath + "/initOfferConfig",
            data: "type="+type,
            dataType: "json",
            success: function (msg) {
                var configInfo = "";
                for (i = 0; i < msg.length; i++) {
                    var fieldName = msg[i].fieldName;
                    var fieldAlias = msg[i].fieldAlias.split("_")[0];
                    var type=msg[i].fieldAlias.split("_")[1];
                    var del_id = "del-" + fieldName;
                    var edit_id = "edit-" + fieldName;
                    //console.log(fieldName + "***********" + fieldAlias);
                    configInfo += "<li class='ulli' id='" + fieldName + "'>";
                    configInfo += "<div class='ui equal width center aligned padded grid'>";
                    configInfo += " <button class='ui mini icon violet basic button'> <i class='sort icon'></i> </button>";
                    configInfo += " <div class= 'column'> <label>" + fieldAlias + "</label> </div>";
                    configInfo += "<div class= 'column'> <i class='edit icon' id='" + edit_id + "' name='" + fieldAlias + "'onclick=modalModifyShow($(this).attr('id'),'"+type+"')></i> </div>";
                    configInfo += "<div class= 'column'> <i class='remove circle icon'  name='" + fieldAlias + "' id='" + del_id + "' onclick=modalDelShow($(this).attr('id'),'"+type+"')></i></a> </div>";
                    configInfo += "</div></li>"
                }
                $(t_id).html(configInfo);
            },
            error: function (msg) {
                alert("fail");
            }
        });
};

$(function () {
    //获取所有得type,以及id,type在添加字段button得name属性，id在list得子节点ul得id属性
    var i=0;
    $.each($(".column button[name]"),function () {
        types[i++]=$(this).attr("name");
        //console.log($(this).attr("name"));
    })
    i=0;
    $.each($('.list ul'),function () {
        ids[i++]=$(this).attr("id");
        //console.log($(this).attr('id'));
    })
    //console.log(types);
    //console.log(ids);
    for(var index=0;index<i;index++) {
        init(types[index], ids[index]);
        var t_id='#'+ids[index];
        $(t_id).sortable({
            update: function (event, ui) {
                var result = $(this).sortable('toArray');
                orderIds = result;
            },
            start: function (event, ui) {
                var result = $(this).sortable('toArray');
                orderIds = result;
            }
        });
    }
    $(t_id).disableSelection();
});

//提交配置
function submitConfig() {
    //console.log(orderIds);
    var params = JSON.stringify(orderIds);
    //console.log(params);
    $.ajax({
        type: "POST",
        url: contextPath + "/submitConfig",
        data: "fieldNames=" + orderIds,
        dataType: "json",
        success: function (msg) {
            //console.log(msg);
        },
        complete: function () {
            alert("提交成功");
        }
    });
}
//添加字段按钮点击
function addmodalShow(type) {
    $('.ui.mini.add.modal').modal('show');
    $('#input_field').attr('placeholder',type);
};
//    添加字段，确认(通用)
function addFieldConfirm(value,type) {
    var params = {
        "fieldAlias": value,
        "type": type
    };
    $.ajax(
        {
            type: "POST",
            url: contextPath + "/addFields",
            data: params,
            dataType: "json",
            success: function (msg) {
               // console.log(msg);
                var index=types.indexOf(type);
                init(types[index],ids[index]);
            },
            error: function (msg) {
                alert("fail");
            }
        });
};

//修改图标点击弹框
function modalModifyShow(id,type) {
    $('.ui.mini.modify.modal').modal('show');
    var t_id = '#' + id;
    $('#modify_input_id').attr("placeholder", $(t_id).attr('name'));//把字段名称赋给输入框得placeholder
    $('#modify_input_id').attr("name", id);//把字段得id赋给输入框得name属性
    $('#modify_input_id').attr("title", type);//把字段得类型赋值给title属性
};

//修改字段确定点击
function modifyConfirm(modifyId,type) {
    //var modeifyId = $('#modify_input_id').attr('name');//要修改得字段属性 'edit-' +field_name
    var modifyValue = $('#modify_input_id').val();//输入得值
    var params = {
        field_name: modifyId,
        field_alias: modifyValue
    };
    $.ajax({
        type: "POST",
        url: contextPath+"/modifyField",
        data: params,
        dataType: "json",
        success: function (data) {
            alert("修改成功");
            var index=types.indexOf(type);
            init(types[index],ids[index]);
        },
        error: function () {
            alert("fail");
        }
    });
}

//删除图标点击
function modalDelShow(id,type) {
    $('.ui.mini.basic.modal').modal('show');
    var t_id = '#' + id;
    var d_name = $(t_id).attr("name");
    $('#del_content_id').html(d_name);
    $('#del_confirm').attr('name', t_id);
    $('#del_confirm').attr('title', type);
};

//删除确定按钮点击
function delConfirm(name,type) {//name == 字段名称前面加上   ""#del-"" 如:字段name 对应 #del-name
    var d_name = name.split('-')[1];//删除前缀
    //console.log(d_name);
    $.ajax(
        {
            type: "POST",
            url: contextPath + "/delFieldAlias",
            data: "fieldName=" + d_name,
            dataType: "json",
            success: function (data) {
                alert("删除成功");
                var index=types.indexOf(type);
                init(types[index],ids[index]);
            },
            error: function (msg) {
                alert("fail")
            }
        }
    )
};
