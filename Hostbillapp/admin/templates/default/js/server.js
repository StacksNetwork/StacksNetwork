function testConnectionList(data, el) {
    var sid = typeof data == 'object' ? '' : data,
        target = $('#testing_result' + sid),
        generalmsg = 'Test did not compleate, check your error logs for more information. ',
        gif = el ? '<img src="templates/default/img/ajax-loader3.gif" />' : '<img style="height: 16px" src="ajax-loading.gif" />',
        throwError = function(msg) {
            target.html($('<span></span>').css({fontWeight: 'bold', color: ' #990000'}).text(msg))
        }

    data = typeof data == 'object' ? data : {'server_id': data};
    target.html(gif)

    $.ajax('?cmd=servers&action=test_connection', {
        data: data,
        type: 'post',
        error: function(xhr, status, error) {
            throwError(xhr.status + ' ' + error + '. ' + generalmsg);
        },
        success: function(data) {
            if (!data || !data.length)
                throwError(generalmsg);
            else
                target.html(parse_response(data));
        },
    });
    return false;
}

function setDefault(server_id, group_id) {
    window.location = '?cmd=servers&action=group&group=' + group_id + '&make=changedef&server_id=' + server_id + '&security_token=' + $('input[name=security_token]').val();
    return false;
}

function loadMod(el) {
    var v = $(el).val();
    if (v == 'new') {
        $(el).val(0);
        window.location = '?cmd=managemodules';
        return false;
    }
    var param = {'module_id': $(el).val()};
    $('#config_contain input').each(function(i, e) {
        if ($(this).attr('type') == 'checkbox') {
            param[$(this).attr('name')] = $(this).is(':checked') ? '1' : '0';
        }
        else
            param[$(this).attr('name')] = $(this).val();
        $(this).attr('disabled', 'disabled');
    });
    ajax_update('?cmd=servers&action=get_fields',
        param, '#config_contain', false, false);
    if ($(el).val() == 0)
        $('#testing_button').hide();
    else
        $('#testing_button').show();
}

function testConfiguration() {
    var data = $.extend({}, $('#serverform').serializeObject(), {
        'module_id': ($('#default_module').length) ? $('#default_module').val() : $('#modulepicker').val(),
        'hash': $('textarea[name="hash"]').val(),
        'secure': $('input[name="secure"]').is(':checked')
    });
    return testConnectionList(data, null)
}

function loadStatuses() {
    if ($('.toloads').length < 1)
        return;
    var id = $('.toloads').eq(0).attr('id');
    $.post('?cmd=servers&action=getstatus', {server_id: id}, function(data) {
        var resp = parse_response(data);
        if (resp.length > 4) {
            $('.toloads').eq(0).html(resp);
            $('.toloads').eq(0).removeClass('toloads');
            loadStatuses();
        }

    });
}