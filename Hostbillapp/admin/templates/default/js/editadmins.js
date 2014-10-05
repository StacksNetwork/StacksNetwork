var premade_e = {
    none: [],
    full: ['all']
};
var premade_p = {
    none: [],
    accounting: ['viewInvoices', 'viewEstimates', 'viewTransactions', 'viewOrders', 'viewAccounts', 'listClients', 'emailClient', 'manageAffiliates'],
    staff: ['viewInvoices', 'viewEstimates', 'viewTransactions', 'viewOrders', 'viewAccounts', 'listClients', 'emailClient', 'viewTickets', 'viewLogs', 'editKBase', 'accessChat', 'viewDomains', 'manageAffiliates'],
    full: ['all']
};

$(function() {
    check_groups();
    $('.sectionbody fieldset > label input').click(check_groups);
    $('.sectionbody fieldset > legend label input').click(function() {
        var el = $(this).parents('fieldset').find('> label input');
        if ($(this)[0].checked)
            el.prop('checked', true).attr('checked', 'checked');
        else
            el.prop('checked', true).removeAttr('checked');
    });
    $('#emnotify .subhead a').click(function() {
        if (premade_e[$(this).attr('href').substr(1)] != undefined) {
            var elm = premade_e[$(this).attr('href').substr(1)];
            $('input[name="emails[]"]').removeAttr('checked').prop('checked', false);
            if (elm.length > 0) {
                if (elm[0] == 'all')
                    $('input[name="emails[]"]').attr('checked', 'checked').prop('checked', true);
                else
                    for (var i = 0; i < elm.length; i++)
                        $('input[name="emails[]"][value="' + elm[i] + '"]').attr('checked', 'checked').prop('checked', true);
            }
        }
        check_groups();
        return false;
    });
    $('#privileges .subhead a').click(function() {
        if (premade_p[$(this).attr('href').substr(1)] != undefined) {
            var elm = premade_p[$(this).attr('href').substr(1)];
            $('input[name="access[]"]').removeAttr('checked').prop('checked', false);
            if (elm.length > 0) {
                if (elm[0] == 'all')
                    $('input[name="access[]"]').attr('checked', 'checked').prop('checked', true);
                else
                    for (var i = 0; i < elm.length; i++)
                        $('input[name="access[]"][value="' + elm[i] + '"]').attr('checked', 'checked').prop('checked', true);
            }
        }
        check_groups();
        return false;
    });
});

function check_groups() {
    $('.sectionbody fieldset').each(function() {
        $(this).find('legend label input').attr('checked', !$(this).find('> label input:not(:checked)').length);
    });
}