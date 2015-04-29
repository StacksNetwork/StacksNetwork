
function inichosen() {
    if (typeof jQuery.fn.chosen != 'function') {
        $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
        $.getScript('templates/default/js/chosen/chosen.min.js', function() {
            inichosen();
            return false;
        });
        return false;
    }
    var target = $('#facebox').length ? $('#facebox') : $('#page_view');
    $('select[name=parent_id]', target).each(function(n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=module&module=dedimgr&do=getjsonlist&rack_id=' + $('input[name=rack_id]', target).val() + '&item_id=' + $('#item_id', target).val(), function(data) {
            if (data.list != undefined) {
                for (var i in data.list) {
                    var name = data.list[i].label;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    that.append('<option value="' + data.list[i].id + '" ' + select + '>' + name + '</option>');
                }
            }
            that.chosen();
        });
    });
    $('select[name=build_id]', target).each(function(n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=module&module=inventory_manager&action=getjsonbuilds', function(data) {
            if (data.list != undefined) {
                for (var i in data.list) {
                    var name = data.list[i].label;
                    var select = selected == data.list[i].id ? 'selected="selected"' : '';
                    if (selected == data.list[i].id)
                        reloadInventory(selected);
                    that.append('<option value="' + data.list[i].id + '" ' + select + '>' + name + '</option>');
                }
            }
            that.chosen();
        });
    });
    $('select[name=client_id]', target).each(function(n) {
        var that = $(this);
        var selected = that.attr('default');
        $.get('?cmd=clients&action=json', function(data) {
            if (data.list != undefined) {
                for (var i = 0; i < data.list.length; i++) {
                    var name = data.list[i][3].length ? data.list[i][3] : data.list[i][1] + ' ' + data.list[i][2];
                    var select = selected == data.list[i][0] ? 'selected="selected"' : '';
                    that.append('<option value="' + data.list[i][0] + '" ' + select + '>#' + data.list[i][0] + ' ' + name + '</option>');
                }
            }
            that.chosen();
            reloadServices();

        });
    });
    $('#configurations', target).delegate().delegate('a.rem', 'click', function() {
        $.get($(this).attr('href'), function(data) {
            $('#configurations', '#saveform').html(parse_response(data));
        });
        return false;
    });
}

function reloadServices() {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    $.post('?cmd=module&module=dedimgr&do=getclientservices', {client_id: $("select[name=client_id]", target).val(), service_id: $('#account_id', target).val()}, function(data) {
        $('#related_service', target).html(parse_response(data));
        updateLayout();
    });
}

function editBladeItem(id) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');

    var postdata = {
        do: 'itemeditor',
        backview: target.is('#page_view') ? 'parent' : '',
        item_id: id
    };
    $('.spinner').show();
    $(document).trigger('close.facebox');
    setTimeout(function() {
        var box = function() {
            $.post('index.php?cmd=module&module=dedimgr', postdata, function(data) {
                $.facebox.reveal(parse_response(data))
            });
        }
        box.opacity = 0.9;
        box.nofooter = true;
        box.width = 900;
        box.addclass = 'modernfacebox';
        $.facebox(box);
    }, 1000);
    return false;
}

function createBladeEntry() {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    var postdata = {
        do: 'itemeditor',
        parent_id: $('#item_id', target).val(),
        addblade: true,
        item_id: 'new',
        position: 0,
        rack_id: $('input[name=rack_id]', target).val(),
        category_id: $('#blade_cat_id', target).val(),
        type_id: $('select[name=type_id]', target).val(),
        backview: target.is('#page_view') ? 'parent' : ''
    };

    $('.spinner').show();
    $(document).trigger('close.facebox');
    setTimeout(function() {

        var box = function() {
            $.post('index.php?cmd=module&module=dedimgr', postdata, function(data) {
                $.facebox.reveal(parse_response(data))
            });
        }
        box.opacity = 0.9;
        box.nofooter = true;
        box.opacity = 0.8;
        box.width = 900;
        box.addclass = 'modernfacebox';
        $.facebox(box);
    }, 1000);

    return false;

}
function loadSubitems(el) {
    var v = $(el).val();
    if (v == '0')
        return false;
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');

    $('#updater1', target).addLoader();
    $.post('?cmd=module&module=dedimgr&do=inventory&subdo=category', {category_id: v}, function(data) {
        $('#updater1', target).html(parse_response(data));
        updateLayout();
    });
    return false;
}

function loadItemEditor(el) {
    $('#bladeadd').hide();
    var v = $(el).val();
    if (v == '0')
        return false;

    $('#bladeadd').show();
    updateLayout();
    return false;
}

function reloadInventory(build_id) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    if (!build_id) {
        $('#inventorygrid', target).hide().html('');
        return;
    }
    $('#inventorygrid', target).html('');
    $.get('?cmd=inventory_manager&action=rackitem&build_id=' + build_id, function(data) {
        $('#inventorygrid', target).html(parse_response(data));
        updateLayout();
    });
}

function setports(count, type, dir) {
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');
    $.post('?cmd=module&module=dedimgr&do=setports', {
        count: count,
        type: type,
        direction: dir,
        item_id: $('#item_id', target).val()
    }, function(data) {
        $('#connection_mgr', target).html(parse_response(data));
        updateLayout();
    });
}

function refreshports() {

    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view');

    $.post('?cmd=module&module=dedimgr&do=setports', {
        item_id: $('#item_id', target).val()
    }, function(data) {
        $('#connection_mgr', target).html(parse_response(data));
        updateLayout();
    });
}

function loadports(field, type, el){
    if(!confirm('This operation may reset some of your ports settings. Do you want to proceed?'))
        return false;
    var target = $('#facebox #saveform:visible').length ? $('#facebox') : $('#page_view'),
        btn = $(el).children();
    btn.addClass('loadsth');
    $.post('?cmd=module&module=dedimgr&do=loadports', {
        item_id: $('#item_id', target).val(),
        app: $('select[name="field['+field+']"]', target).val(),
        type: type
    }, function(data) {
        $('#connection_mgr', target).html(parse_response(data));
        updateLayout();
        btn.removeClass('loadsth');
        if(target.is('#page_view'))
            $('html,body').animate({
                scrollTop: $('#connection_mgr', target).offset().top
            }, 500, 'linear');
        else{
            $('#lefthandmenu a[href="#4"]', target).click();
        }
    });
}

function loadItemMonitoring(manual) {
    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view');
    var hash = $('#item_hash', target).val();
    if (manual) {
        $('#itemmonitoring', target).addLoader();
        $.getJSON('?cmd=module&module=dedimgr&do=loadmonitoring&hash='+hash, function(data) {
            if (data && data.status) {
                for (var i in data.status) {
                    if (hash == data.status[i].hash) {
                        $('#itemmonitoring', target).html(buildMonitoring(data.status[i].hash, data.status[i]));
                        updateLayout();
                    }
                }
            }
        });
    }else if ($('#monitoringdata #status_' + hash, target).length) {
        $('#itemmonitoring', target).html($('#monitoringdata #status_' + hash, target).html());
        updateLayout();
    } else if (MonitoringData[hash] !== undefined) {
        $('#itemmonitoring', target).html(buildMonitoring(hash, MonitoringData[hash]));
        updateLayout();
    }
}

function tabbMenu() {
    var target = $('#facebox:visible').length ? $('#facebox') : $('#page_view');
    if ($('#lefthandmenu',target).length) {
        var menu = $('#lefthandmenu',target),
            links = menu.children(),
            tabbs = $('#facebox .tabb');
        links.each(function() {
            var that = $(this);
            $(this).click(function(e) {
                links.removeClass('picked active');
                that.addClass('picked active');
                var href = that.attr('href').match(/[^#]/)[0];
                tabbs.hide().filter(function() {
                    return $(this).attr('data-tab') == href
                }).show().find('h3').each(function() {
                    var h = $(this);
                    if (!h.find('.name').length)
                        $('<span></span>').attr('class', 'name').text(' - ' + $('#item_name', '#facebox').val()).appendTo(h);
                    return false;
                });
                updateLayout();
                return false;
            });
        }).eq(0).click();
    }
}

function updateLayout() {
    if ($('#page_view').length) {
        var x = -4;
        $('#page_view .conv_content').children().css({height: ''}).each(function() {
            var that = $(this),
                    height = that.height(),
                    grid = 50,
                    mod = height % grid;
            if (!mod)
                grid = 0;
            that.height(height - mod + grid);
            that.width(that.width());
        }).end().freetile({selector: '.tabb'});
    } else {
        var menu = $('#lefthandmenu'),
                tab = $('.conv_content'),
                h1 = tab.height() - (menu.outerHeight() - menu.height()),
                h2 = menu.children().length * 30;
        menu.height(h1 < h2 ? h2 : h1);
    }
}

function changeHardwareApp(select, type){
    var that = $(select);
    if(that.val() == 'new'){
        window.open('?cmd=module&module=dedimgr&do=newhardwareapp&type='+type).focus();
        that.val(0);
    }
        
}

$(function() {
    inichosen();
    loadItemMonitoring();
    tabbMenu();
    updateLayout();
    $('.vtip_description', '#facebox').vTip();
    $('.connector.hastitle', '#facebox').vTip();
})

