$(document).ready(function() {

    $('#smarts2').SmartSearch({
        target: '#smartres2',
        url: '?cmd=module&module=dedimgr&action=searchdedimgr&lightweight=1',
        submitel: '#search_submiter2',
        results: '#smartres-results2',
        container: '#search_form_container2'
    });

    $('#newtype').change(function() {
        $('#addnewitem div').hide();
        $('#type_' + $(this).val()).show();
        if ($(this).val() == "server2") {
            $('#used_slots option:last').hide();
        } else {
            $('#used_slots option:last').show();
        }

    });

    $('.wall').children().hide().end().width($('.wall').width()).children().show();
    $('#floorview_switch').children().each(function(x) {
        $(this).click(function() {
            var that = $(this);
            that.addClass('activated')
            if (x == 0) {
                that.next().removeClass('activated');
                $('.wall').removeClass('list');
            } else {
                that.prev().removeClass('activated');
                $('.wall').addClass('list');
            }
            if (that.is('.activated'))
                $.get(that.attr('href'));
            return false;
        })
    }).filter('.activated').click();
    
});

function editRackItem(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + '&do=itemeditor&item_id=' + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}
var monitoringtimeout;
function loadMonitoring(data) {
    var display = function(data) {
        $('#monitoringdata').html('');
        $('#monitoringbtn i').removeClass('fa-spin');
        $('#statuscol').addClass('extended');
        for (var i in data) {
            var ri = $('.have_items[label=' + data[i].hash + ']');
            if (ri.length) {
                var p = ri.attr('data-position'),
                    d = $('#statuscol td[pos=' + p + ']').attr('class', 'monitoring_' + data[i].status).text(data[i].status).popover('getData');
                if (typeof(d) != 'undefined') {
                    $('#statuscol td[pos=' + p + ']').popover('destroy');
                }
                var row = buildMonitoring(data[i].hash, data[i]);
                $('#statuscol td[pos=' + p + ']').popover({
                    title: ri.find('.lbl').text(),
                    content: row,
                    position: 'right',
                    trigger: 'hover'
                });
            }
        }
    };

    if (data)
        return display(data);

    clearTimeout(monitoringtimeout);
    $('#monitoringbtn i').addClass('fa-spin');
    var url = '?cmd=module&module=' + $('#module_id').val() + "&do=loadmonitoring";
    $.getJSON(url, function(data) {
        if (data && data.status) {
            display(data.status);
        }
        monitoringtimeout = setTimeout(loadMonitoring, 30000);
    });
}
function buildMonitoring(item, data) {
    var h = Mustache.to_html(MUSTACHE.status.join("\n"), data);
    $('#monitoringdata').append('<div id="status_' + item + '">' + h + '</div>');
    return h;
}

function unlockAdder() {
    $('.canadd').removeClass('disabled');
    $('#addnewitem').html('').hide();
    $('.newitem').hide();
    return false;
}

function addColocation() {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=coloform",
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addVendor() {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=vendorform",
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editVendor(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=vendoreditform&vendor_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editColocation(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=coloeditform&colo_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editCategory(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=categoryeditform&id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addFloor(colo_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=floorform&colo_id=" + colo_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editFloor(id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=flooreditform&floor_id=" + id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function addRack(floor_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=rackform&floor_id=" + floor_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function editRack(rack_id) {
    $.facebox({
        ajax: '?cmd=module&module=' + $('#module_id').val() + "&do=rackeditform&rack_id=" + rack_id,
        width: 900,
        nofooter: true,
        opacity: 0.8,
        addclass: 'modernfacebox'
    });
    return false;
}

function removeCPU(id) {
    $.post('?cmd=module&module=' + $('#module_id').val() + '&do=removecpu', {
        itemid: id
    }, function(data) {
        var r = parse_response(data);
    });
    return false;
}

function removeMem(id) {
    $.post('?cmd=module&module=' + $('#module_id').val() + '&do=removehdd', {
        itemid: id
    }, function(data) {
        var r = parse_response(data);
    });
    return false;
}

function closeRack(el) {
    $(el).parent().parent().slideUp().parent().removeClass('opened');
}


function getportdetails(id) {
    var url = '?cmd=module&module=dedimgr&do=getport&id=' + id;
    if ($('#facebox #saveform:visible').length) {
        $('.spinner:last').show();
        if (typeof closePortEditor == 'function')
            closePortEditor();
        $.get(url, function(data) {
            $('.spinner:last').hide();
            $('#porteditor').html(data).show();
        });
    } else {
        if (typeof closePortEditor == 'function')
            closePortEditor();
        $.facebox({
            ajax: url,
            width: 900,
            nofooter: true,
            opacity: 0.8,
            addclass: 'modernfacebox'
        });
    }
}
var MonitoringData = {},
        MUSTACHE = {
    status: [
        '<table border="0" cellspacing="0" cellpadding="3" width="730" class="statustable">',
        '  <tr>',
        '    <th>Service</th>',
        '    <th>Status</th>',
        '    <th>Last Check</th>',
        '    <th>Duration</th>',
        '    <th>Attempt</th>',
        '    <th>Info</th>',
        '  </tr>',
        '  {{#services}}',
        '  <tr class="rowstatus-{{status}}">',
        '    <td>{{service}}</td>',
        '    <td>{{status}}</td>',
        '    <td>{{lastcheck}}</td>',
        '    <td>{{duration}}</td>',
        '    <td>{{attempt}}</td>',
        '    <td>{{info}}</td>',
        '    </tr>',
        '  {{/services}}',
        '</table>'
    ]}