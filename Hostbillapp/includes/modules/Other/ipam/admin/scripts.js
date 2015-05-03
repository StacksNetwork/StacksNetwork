var IPActions = {
    add_list: 'addlist',
    del_list: 'dellist',
    edit_list: 'listdetails',
    get_list: 'details',
    save: 'singlesave',
    del: 'dellip',
    search: 'search',
    target: '#ipamright',
    updater: '#updater',
    form: '#ipform',
    leftform: '#ipamleftform',
    treecontener: '#treecont',
    add_template: {
        0: 'input', 2: 'input', 6: 'textarea', 3: 'textarea', 4: 'textarea'
    },
    sorter: {
        list: '#currentlist',
        low: '#sorterlow',
        high: '#sorterhigh',
        records: '#sorterrecords',
        total: '#totalpages'
    },
}

var VLANActions = {
    add_list: 'vlan_addlist',
    del_list: 'vlan_dellist',
    edit_list: 'vlan_listdetails',
    get_list: 'vlan_details',
    save: 'vlan_singlesave',
    del: 'vlan_del',
    search: 'vlan_search',
    target: '#vlanright',
    updater: '#vlanupdater',
    form: '#vlanform',
    leftform: '#vlanleftform',
    treecontener: '#vlantreecont',
    add_template: {
        0: 'input', 1: 'input', 2: 'textarea'
    },
    sorter: {
        list: '#vlancurrentlist',
        low: '#vlansorterlow',
        high: '#vlansorterhigh',
        records: '#vlansorterrecords',
        total: '#vlantotalpages'
    },
}

var LOGSActions = {
    target: '#logsright',
    updater: '#logsupdater',
    form: '#logsform',
    sorter: {
        list: '#logscurrentlist',
        low: '#logssorterlow',
        high: '#logssorterhigh',
        records: '#logssorterrecords',
        total: '#logstotalpages'
    },
}

ActSet = IPActions;

$(function() {
    var timeout = false;
    $('.ipam-search input[name="stemp"]').keypress(function(k) {
        var that = $(this);
        if (k.which == 13)
            k.preventDefault();
        slideUp();
        if (timeout)
            clearTimeout(timeout);
        timeout = setTimeout(function() {
            ajax_update("?cmd=module&module=ipam&" + $(ActSet.leftform).find('input, textarea, select').not('input[name=action]').serialize(), {
                action: ActSet.search,
                str: that.val(),
                opt: that.parent().next().find('input').serialize()
            }, ActSet.treecontener);
            timeout = false;
        }, 400);

    });

    $('.ipam-search input[name="stemp"]').click(function() {
        var that = $(this);
        that.parent().next().slideDown().find('input').click(function() {
            that.focus();
        });
        $(document).bind('mouseover', slideUp);
    });

    $('.pagecont').hide().eq(0).show();
    console.log('bind1')
    $('#bodycont > .blu').removeClass('actv').eq(0).addClass('actv');
    $('#bodycont > .blu').each(ipamMenuNav);
    $(document).ajaxStart(function() {
        $('#bodycont > .blu').unbind('click');
    });
    $(document).ajaxStop(function() {
        $('#bodycont > .blu').each(ipamMenuNav);
    });
    refreshipamlogs();
});
var ajax_loader = "<img src='../includes/modules/Other/ipam/admin/img/ajax-loader3.gif' alt='loading..' />";

function ipamMenuNav(x) {
    var that = $(this),
        act = that.attr('data-action') || 'ipam';
    that.click(function() {
        if (act == 'logs')
            ActSet = LOGSActions;
        else if (act == 'vlan')
            ActSet = VLANActions;
        else
            ActSet = IPActions;

        $('.pagecont').hide().eq(x).show();
        $('#bodycont > .blu').removeClass('actv').eq(x).addClass('actv');
    });
}

function refreshipamlogs(){
    $('#logsright').addLoader();
    ajax_update("?cmd=module&module=ipam&action=logs", false, function(data) {
        $('#logsright').replaceWith(parse_response(data));
        multipaginate();
    });
}

function slideUp(event) {
    if (event == undefined ||
            $('.ipam-filters:visible').length && (
            !$(event.target).is('.ipam-search') &&
            !$(event.target).parents('.ipam-search').length &&
            !$(event.target).is('.ipam-filters') &&
            !$(event.target).parents('.ipam-filters').length)
            )
    {
        $('.ipam-filters').slideUp('fast');
        $('.ipam-filters input').unbind();
        $(document).unbind('mouseover', slideUp);
    }
}

function editAssign(id) {
    var sid = $('input[name=sub]').length ? $('input[name=sub]').val() : $('input[name=group]').val();
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=editassignment&ip_id=" + id + '&server_id=' + sid,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}
function splitIP(id) {
    if (!confirm('您确定吗?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam', {
        action: 'splitlist',
        id: id
    }, function(data) {
        var r = parse_response(data);
        refreshView();
        refreshTree($('input[name=group]').val());
    });
    return false;
}

function joinIP(id) {
    if (!confirm('您确定吗?')) {
        return false;
    }
    $.post('?cmd=module&module=ipam', {
        action: 'joinlist',
        id: id
    }, function(data) {
        var r = parse_response(data);
        groupDetails($('input[name=group]').val());
        refreshTree();
    });
    return false;
}
var newid = 0;
function addIP() {
    $('#updater ').append('<tr><td ><a name="a' + newid + '"></a><input name="new[' + newid + '][0]" value="" /></td><td ><input name="new[' + newid + '][2]" value="" /></td><td ><textarea name="new[' + newid + '][6]"></textarea></td><td ><textarea name="new[' + newid + '][3]"></textarea></td><td ><textarea name="new[' + newid + '][4]"></textarea></td><td colspan="5" ></td></tr>');
    //$('input[name="new['+newid+'][1]"]').focus(function(){
    //    if($('input[name="new['+newid+'][0]"]').val() != '' && $(this).val() == '')
    //        $(this).val('255.255.255.0');
    //});
    $('body').slideToElement('a' + newid);
    newid = newid + 1;
    return false;
}
function addIPRange() {
    var g = $('input[name=sub]').length ? $('input[name=sub]').val() : $('input[name=group]').val();
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=addiprange&group=" + g,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}
function editList(id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=listdetails&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}

function changename(id) {
    if (!$('#' + id + ' input').length) {
        $('#' + id).html('<input name="group_name" value="' + $('#' + id).text() + '" />')
        $('#' + id).next('a.editbtn').text('Save');
    } else {
        if (id == 'list')
            var gid = $('#ipform input[name="group"]').val();
        else
            var gid = $('#ipform input[name="sub"]').val();

        ajax_update("?cmd=module&module=ipam", {
            action: 'changename',
            name: $('#' + id + ' input').val(),
            group: gid
        }, function(data) {
            $('#' + id).text($('#' + id + ' input').val());
            $('#' + id).next('a.editbtn').text('Edit');
            refreshTree();
        });
    }
}
function edit_client(e, client_id, ip, server_id) {
    var div = $(e).parents('td').eq(0).find('div');
    div.html(ajax_loader);
    $.post('?cmd=module&module=ipam', {
        action: 'listclients',
        selected: client_id,
        ip: ip
    }, function(data) {
        var r = parse_response(data);
        if (r) {
            div.hide().after(r);
        }
    });
    $(e).replaceWith('<span onclick="save(this,' + server_id + ')" class="editbtn">Save</span>');
    return false;
}

function toggleFlag(e, id) {
    var name = 'edit[' + $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text() + '][' + $(e).parent().prevAll().length + ']';
    ajax_update("?cmd=module&module=ipam", {
        action: 'singlesave',
        name: name,
        group: id,
        value: $(e).hasClass('active') ? 0 : 1
    }
    );
    $(e).toggleClass('active');
}

function delsublist() {
    if (!confirm('您确定要删除该子网吗?'))
        return false;
    ajax_update("?cmd=module&module=ipam", {
        action: 'dellist',
        group: $('#ipform input[name="sub"]').val()
    }, "#ipamright");
    refreshTree();
}

function expand(a) {
    if ($(a).parent('.open').length)
        $(a).siblings('ul').slideUp('fast', function() {
            $(a).parent().removeClass('open').children('input').val('0');
        });
    else
        $(a).siblings('ul').slideDown('fast', function() {
            $(a).parent().addClass('open').children('input').val('1');
        });
}

function subDetails(subid, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: 'details',
        group: id,
        sub: subid
    }, function(data) {
        $('#ipamright').html(data);
        bindEvents();
        multipaginate();
    });
}

function submitIPRange(form) {
    ajax_update("?cmd=module&module=ipam", form.serializeObject(), function(data) {
        refreshTree();
        refreshView();
        $(document).trigger('close.facebox');
    });
}

function addReservationRule(that) {
    that = $(that);
    var index = that.prevAll('p').length;
    $(['<p>',
        'IP数字: <input name="reservations[', index, '][ip]" type="text" class="inp" value="n" /> 保留 <input name="reservations[', index, '][descr]" type="text" value="" />',
        '<a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >移除</a>',
        '</p>'].join(' ')).insertBefore(that);
}

function delReservationRule(that) {
    $(that).parent('p').remove();
}

function multipaginate() {
    $('div.pagination').each(function() {
        var that = $(this),
                total = that.parents('.pagecont').eq(0).find('input[name=totalpages2]').val(),
                current = that.data('lastpage') || 0;

        that.pagination(total, {
            current_page: current,
            callback: function(index) {

                if (!that.parents(ActSet.target).length)
                    return false;

                that.data('lastpage', index);
                $(ActSet.updater).addLoader();
                $('#checkall').attr('checked', false);

                $.post($(ActSet.sorter.list).attr('href'), {page: index}, function(data) {
                    var resp = parse_response(data);
                    if (resp) {
                        $(ActSet.updater).html(resp);
                        $('.check', ActSet.target).unbind('click');
                        $('.currentpage', ActSet.target).val(index);
                        $('.check', ActSet.target).click(checkEl)
                    }
                });
                return false
            }
        });
    });
    
    $("a.sortorder", ActSet.target).unbind('click').click(function() {
        var that = $(this),
            href = that.attr('href');
        $(ActSet.updater).addLoader();
        $('a.sortorder', ActSet.target).removeClass('asc');
        $('a.sortorder', ActSet.target).removeClass('desc');
        $('#checkall', ActSet.target).attr('checked', false);
        $(ActSet.sorter.list).attr('href', href);

        if (href.substring(href.lastIndexOf('|')) == '|ASC') {
            that.addClass('asc');
            that.attr('href', href.substring(0, href.lastIndexOf('|')) + '|DESC');
        }
        else {
            that.addClass('desc');
            that.attr('href', href.substring(0, href.lastIndexOf('|')) + '|ASC');
        }

        $.post($(ActSet.sorter.list).attr('href'), {page: (parseInt($('.pagination span.current', ActSet.target).eq(0).html()) - 1)}, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $(ActSet.updater).html(resp);
                $('.check', ActSet.target).unbind('click').click(checkEl);
            }
        });

        return false;
    });
}

function sorterUpdate(low, high, total) {
    if (typeof(low) != 'undefined') {
        $(ActSet.sorter.low).html(low);
    }
    if (typeof(high) != 'undefined') {
        $(ActSet.sorter.high).html(high);
    }
    if (typeof(total) != 'undefined') {
        $(ActSet.sorter.records).html(total);
    }
}

function submitForm(form) {
    ajax_update("?cmd=module&module=ipam&action=" + ActSet.get_list, $(form).serializeObject(), ActSet.target);
    refreshTree();
    return false;
}
function refreshTree(expand) {
    ajax_update("?cmd=module&module=ipam&refresh=1", $(ActSet.leftform).serializeObject(), function(data) {
        $(ActSet.treecontener).html(data);
        if (typeof(expand) != 'undefined') {
            $('#expandable_' + expand).click();
        }
    });
}

function refreshView() {
    var id = $('input[name=group]', ActSet.target).val();
    if ($('input[name=sub]', ActSet.target).length) {
        subDetails($('input[name=sub]', ActSet.target).val(), id)
    } else {
        groupDetails(id)
    }
}

function details(a, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.get_list,
        ip: $(a).text(),
        group: id
    }, function(data) {
        $(ActSet.target).html(data);
        bindEvents();
        multipaginate();
    });
}

function groupDetails(id) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.get_list,
        group: id
    }, function(data) {
        $(ActSet.target).html(data);
        bindEvents();
        multipaginate();
    });
}

var newid = 0;
function add() {
    var htadd = []
    var anchor = '<a name="a' + newid + '"></a>'
    $.each(ActSet.add_template, function(i) {
        var name = 'new[' + newid + '][' + i + ']';
        switch (this.toString()) {
            case 'textarea':
                htadd.push('<td>' + anchor + '<textarea name="' + name + '"></textarea></td>');
                break;
            case 'input':
                htadd.push('<td>' + anchor + '<input type="text" name="' + name + '" /></td>');
                break;
            default:
                htadd.push('<td>' + anchor + '</td>');
        }
        anchor = '';
    })
    var len = $(ActSet.updater).parent('table').find('tr').eq(0).children().length;
    var inlen = htadd.length;
    //for(var i = inlen; i<len; i++)
    htadd.push('<td colspan="' + (len - inlen) + '"></td>');
    $(ActSet.updater).append('<tr>' + htadd.join('') + '</tr>');
    $('body').slideToElement('a' + newid);
    newid = newid + 1;
    return false;
}

function edit(e, id) {
    var ip = $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text();
    var pos = $(e).parent().prevAll().length;
    var text = $(e).prev('div:first-child').text();
    if (pos == 5)
        return edit_client(e, text.replace('#', ''), ip, id);
    $(e).prev().hide();
    if (pos < 2)
        $('<input name="edit[' + ip + '][' + pos + ']" value="' + text + '" />').insertBefore(e).keypress(function(e) {
            return e.which != 13
        });
    else {
        $('<textarea name="edit[' + ip + '][' + pos + ']" >' + text + '</textarea>').insertBefore(e).elastic();
    }
    $(e).replaceWith('<span onclick="save(this,' + id + ')" class="editbtn">保存</span>');
}

function save(e, id) {
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.save,
        name: $(e).prev('input, textarea, select').attr('name'),
        group: id,
        value: $(e).prev('input, textarea, select').val()
    },
    function(data) {
        $(e).prev().remove();
        $(e).prev().html(data.substr(data.indexOf('-->') + 3)).show();
        $(e).replaceWith('<span onclick="edit(this, ' + id + ')" class="editbtn">编辑</span>');
    });
}

function del(e, id) {
    if (!confirm('您确定要删除该IP地址吗?'))
        return false;
    ajax_update("?cmd=module&module=ipam", {
        action: ActSet.del,
        group: id,
        ip: $(e).parent().prevAll().andSelf().eq(0).find('div:first-child').text()
    },
    function(data) {
        $(e).parent().parent().remove();
        refreshTree();
    });
    return false;
}

function addlist(type, sub) {
    var req = "&list=" + type;
    if (sub > 0)
        req = req + "&sub=" + sub;
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=" + ActSet.add_list + req,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}

function editlist(id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=" + ActSet.edit_list + "&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}

function dellist() {
    if (!confirm('您确定要删除该列表吗?'))
        return false;
    $.post("?cmd=module&module=ipam", {
        action: ActSet.del_list,
        group: $(ActSet.form + ' input[name="group"]').val()
    }, function(data) {
        data = parse_response(data);
        $(ActSet.target).html($(data).filter(ActSet.target).html());
    });
    refreshTree();
}

function advEdit(sid, id) {
    $.facebox({
        ajax: "?cmd=module&module=ipam&action=editip&server=" + sid + "&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8
    });
    return false;
}
