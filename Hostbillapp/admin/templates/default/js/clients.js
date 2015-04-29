function sendtoall_show() {
    if ($('#sendtoall').hasClass('visible')) {
        $('#sendtoall').removeClass('visible');
        $('#sendtoall').hide();
    }
    else {
        $('#sendtoall').addClass('visible');
        $('#sendtoall').show();
    }
    return false;
}
function specifictypes_show() {
    if ($("input[name='sendtype']:checked").val() == 'specific')
        $('#specifictypes').show();
    else
        $('#specifictypes').hide();
}
function getCriterias(item, type) {
    var show = $(item).val();
    var item_id = '#show_' + type;
    if (show == 'select') {
        $(item_id).show();
        if (!$(item_id).hasClass('shown')) {
            ajax_update('?cmd=clients&action=sendmailcriterias', {type: type}, item_id, false);
            $(item_id).addClass('shown');
        }
    }
    else
        $(item_id).hide();
}
function checkAllItems(item, type) {
    var item_class = '.check_' + type;
    if ($(item).attr('checked')) {
        $(item_class).attr('checked', true);
        $(item_class).parent().parent().addClass('checkedRow');
    } else {
        $(item_class).attr('checked', false);
        $(item_class).parent().parent().removeClass('checkedRow');
    }
}
function deleteClients() {
    if ($("input[class=check]:checked").length < 1) {
        alert('Nothing checked.');
        return false;
    }
    else {
        $('#bodycont').css('position', 'relative');
        $('#confirm_cacc_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
    }
}
function confirmsubmit1() {
    var add = '';
    if ($('#cl_hard').is(':checked'))
        add = '&harddelete=true';

    $('#testform').removeAttr('action');
    $('#testform').attr('action', '?cmd=clients&make=delete' + add);
    $('#testform').submit();
}
function cancelsubmit1() {
    $('#confirm_cacc_delete').parent().parent().css('position', 'inherit');
    $('#confirm_cacc_delete').hide();
    return false;
}