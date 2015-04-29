function change_css(select) {
    var p = $(select).parent().find('div.preview').find('.rackitem'),
        form = p.parents('form').eq(0),
        u = parseInt(form.find('.u-size').val()) || 1,
        sidemount = form.find('.mount_type').val() == 'Side';
    p.attr('class', "")
    .addClass('rackitem')
    .css('background-image', 'url(' + hardwareurl + $(select).val() + ')');
    if(!sidemount)
        p.addClass('server' + u + 'u').height(20 * u).width('')
    else
        p.width(20 * u).height('')
    return false;
}

function assignnew(target) {
    var id = $(target + '_select').val();
    var n = $(target + '_select option:selected').text();
    $(target).append("<div style='padding:3px 5px'><input type='hidden' name='fields[]' value='" + id + "'/>" + n + " <span class='orspace'><a href='#' onclick='return remaddopt(this);'>Remove</a></span></div>");
    return false;
}

function assignnew_current(it) {

}

function toggleTypeEdit(id, btn) {
    if (!$('#fform_' + id).is(':visible')) {
        $('#fname_' + id).hide();
        $('#fform_' + id).show();
        if (btn)
            $(btn).addClass('activated');
    } else {
        $('#fname_' + id).show();
        $('#fform_' + id).hide();
        $('.activated').removeClass('activated');
    }

    return false
}

function remaddopt(el) {
    $(el).parents('div').eq(0).remove();
    return false;
}

$(function() {
    $('.fileupload').each(function() {
        var that = $(this),
                target = that.prev();
        that.fileupload({
            dataType: 'json',
            url: '?cmd=module&module=dedimgr&do=uploadicon',
            done: function(e, data) {
                var lists = $('.hardwareicon');

                $.each(data.result, function(x) {
                    console.log('<option>' + this.name + '</option>', lists, target);
                    lists.append('<option>' + this.name + '</option>');
                    target.val(this.name).change();
                });
            },
            fail: function(e, data) {

            },
        });
    });
    $('.u-size').bind('keyup change', function(e){
        change_css($(this).parents('table').eq(0).find('.hardwareicon')[0]);
    });
    $('.mount_type').change(function(){
        var select = $(this),
            form = select.parents('form').eq(0);
        $('.mount_', form).hide().filter('.mount_'+select.val()).show();
        change_css($(this).parents('table').eq(0).find('.hardwareicon')[0]);
    });
    $('.hardwareicon').change();
});