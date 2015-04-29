$(function() {

    var cmdUrl = window.location.href.replace(/(id|action)=[^&]*&?/g,'').replace(/&$|&#/,'');
    
    function FormSubmit(e) {
        e.preventDefault();

        if ($('#old_client_id').val() == 0)
            return true;

        var id = $('input[name=invoice_id]').val();
        var form = $('#detailsform').serializeObject();
        
        form.id = id;
        form.action = 'changething';

        $.post(cmdUrl, form, function(data) {
            var resp = parse_response(data);
            if (resp) {
                $('#detcont').html(resp);

                $.post(cmdUrl, {
                    id: id,
                    action: 'updatetotals'
                }, function(data) {
                    var resp = parse_response(data);
                    if (resp && resp.length > 10) {
                        var $resp = $(resp)
                        $('#updatetotals').html($resp.filter('#updatetotals').html());
                        $('#main-invoice').html($resp.filter('#main-invoice').html());
                    }
                });
            }
        });
    }

    function ItemsSubmit() {

        var line = $(this).parent().parent();
        var lineid = $(line).attr('id').replace("line_", "");
        var id = $('input[name=invoice_id]').val();
        var total = (parseFloat($(line).find('.invqty').eq(0).val()) * parseFloat(line.find('.invamount').eq(0).val())).toFixed(2);
        var form = $('#itemsform').serializeObject()

        line.find('#ltotal_' + lineid).html(total);
        form.action = 'updatetotals';
        form.id = id;
        $('#main-invoice').addLoader();

        $.post(cmdUrl, form, function(data) {
            var resp = parse_response(data);
            if (resp && resp.length > 10) {
                var $resp = $(resp)
                $('#updatetotals').html($resp.filter('#updatetotals').html());
                $('#main-invoice').html($resp.filter('#main-invoice').html());
            }
            RefreshDetails()
        });
    }

    function RefreshDetails() {
        var id = $('input[name=invoice_id]').val();

        $.post(cmdUrl, {
            action: 'getdetailsmenu',
            id: id
        }, function(data) {
            var resp = parse_response(data);
            if (resp && resp.length > 10) {
                $('#detcont').html(resp)
            }
        });
    }



    $('#bodycont').on('click', '#addclientcredit', function(){

        var id = $('input[name=invoice_id]').val();
        var form = $('#detailsform').serializeObject();

        form.id = id;
        form.action = 'applycredit';
        $.post(cmdUrl, form, function(data) {
            var resp = parse_response(data);
            RefreshDetails();
        });

        return false;
    });

    $('#bodycont').on('mouseenter', '.editline', function() {
        if (!$(this).hasClass('editable1'))
            $(this).find('.editbtn').show();
    });
    $('#bodycont').on('mouseleave', '.editline', function() {
        $(this).find('.editbtn').hide();
    })

    $('#bodycont').on('click', '.editline .editbtn', function() {
        var p = $(this).parent();
        p.find('textarea').height(p.find('.line_descr').height());
        p.addClass('editable1').children().hide();
        p.find('.editor-line').show().find('textarea').focus();
        //$(this).remove();
        return false;
    });

    $('#bodycont').on('click', '.editline .savebtn', function() {
        var l = $(this).parent().parent();
        l.find('.line_descr').html(l.find('textarea').val().replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1<br/>$2')).show();
        l.removeClass('editable1').find('.editor-line').hide();
        l.parent().find('.invitem').eq(0).change();
        return false;
    });

    $('#bodycont').on('click', '.removeLine', function() {
        var el = $(this);
        $(this).parent().parent().addClass('yellow_bg');
        var answer = confirm("Do you really want to delete this line?");
        if (answer) {
            $('#main-invoice').addLoader();
            $.post($(this).attr('href'), {empty1mc: 'param'}, function(data) {
                var resp = parse_response(data);
                $('#main-invoice').html(resp);
                $('.invitem').eq(0).change();
            });
        }
        $(this).parent().parent().removeClass('yellow_bg');
        return false;
    });

    $('#bodycont').on('change', '.invitem', ItemsSubmit);
    $('#bodycont').on('click', '.invitem2', ItemsSubmit);
    $('#bodycont').on('submit', '#detailsform', FormSubmit);
})