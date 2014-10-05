var order = {
    cmd: 'order',
    action: 'createdraft',
    update_price: function(price) {
        $('.order_price').text(price.cost);
        gtprice = '';
        for (c in price.recurring) {
            gtprice += order.cycle[c] + ': ' + price.recurring_cost[c] + '<br />';
        }
        $('.order_price_r').html(gtprice);
    },
    save_details: function() {
        $('#order_details form').addLoader();
        ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=savedetails", $('#order_details form').serializeObject(), "#order_details");
        order.get_service($('.order_items').parents('form')[0]);
    },
    list_items: function(select) {
        $(select).parents('form').addLoader();
        ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=listitems", $(select).parents('form').serializeObject(), function(data) {
            $("#order_item").html(data);
            $('#preloader').remove();
        });
    },
    get_service: function(form) {
        if (order.delayAction == null) {
            $('#loadingindyk').show();
            order.delayAction = setTimeout(function() {
                //$('.order_items').addLoader();
                ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=getservice", $.extend({id: $('.draft_id').eq(0).val()}, $(form).serializeObject()), function(data) {
                    var resp = parse_response(data);
                    $(form).find('.order_items').html(resp);
                    $('#loadingindyk').hide();
                });
            }, 700);
        } else {
            clearTimeout(order.delayAction);
            order.delayAction = null;
            order.get_service(form);
        }
    },
    get_product: function(select) {
        var self = $(select);
        if (self.val() == 'new') {
            window.location = "?cmd=services&action=addcategory";
            self.val(($("option:first", self).val()));
        } else {
            var form = self.parents('form').eq(0),
                link = self.next();
            
            link.hide();
            if(self.val() != '-')
                link.attr('href','?cmd=services&action=product&id=' + self.val()).show()
            
            form.addLoader();
            ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=getproduct", form.serializeObject(),
                function(data) {
                    var resp = parse_response(data);
                    $(".product_config", form).html(resp);
                    $('#preloader').remove();
                });
        }
    },
    get_domain: function(select) {
        $('#loadingindyk_add').show();
        var self = $(select),
            form = self.parents('form').eq(0),
            link = self.next();
        
        link.hide();
        if(self.val() != '-')
            link.attr('href','?cmd=services&action=product&id=' + self.val()).show()
        
        form.addLoader();
        ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=getdomain", form.serializeObject(), function(data) {
            var resp = parse_response(data);
            $("#domain_config").html(resp);
            $('#preloader').remove();
            $('#loadingindyk_add').hide();
        });
    },
    initFormValues: function() {
        $('.like-table-row div[default] input[name^=custom]').each(function() {
            var initval = $(this).parent().attr('default');
            if (initval) {
                $(this).val(initval);
            }
        });
    },
    additem: function(form) {
        $(form).addLoader();
        ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=add", $(form).serializeObject(), function(data) {
            order.get_service($('.order_items').parents('form')[0]);
            $('#preloader').remove();
        });
        if (typeof($().slideToElement) == 'function')
            $('body').slideToElement('order_items');
        $('#product_config input:not([type="hidden"])').each(function() {
            $(this).val('')
        });
        $('#product_config select').each(function() {
            if ($(this).attr('name') != 'hidden')
                $(this).val($(this).children(':first').val())
        });
        order.initFormValues();
    },
    edit: function(form) {
        $('.order_items').addLoader();
        ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=editservice", $(form).serializeObject(), ".order_items");
    },
    fold: function(el) {
        var rel = $(el).attr('rel')
        $('.' + rel + '.foldable').fadeToggle();
        $('.' + rel + ' .foldable').toggle();
        $('.' + rel + ' input.fold').val($('.' + rel + ' .foldable').eq(0).is(':visible') ? 0 : 1);
    },
    new_gateway: function(elem) {
        if ($(elem).val() == 'new') {
            window.location = "?cmd=managemodules&action=payment";
            $(elem).val(($("option:first", +$(elem)).val()));
        }
    },
    check_availability: function() {
        if ($('#domain_name').is(':visible'))
            ajax_update('?cmd=orders&action=whois', {domain: $('#domain_name').val()}, '#avail_field', true);
        else
            ajax_update('?cmd=orders&action=whois', {domain: $('#domain_sld').val() + $('#domain_tld option[value=' + $('#domain_tld').val() + ']').text(), type: $("input[name='domain_action']:checked").val()}, '#avail_field', true);
    },
    confirm_unsaved: function(msg) {
        if ($('#unsaved').length || $('.saved:visible').filter(function() {
            return $(this).css('visibility') != 'hidden'
        }).length)
            return confirm(msg);
        return true;
    },
    update_services: function(data) {
        var select = $('.client_services'),
            selected = select.val();
        $('#client_service').html('');
        select.children().eq(0).nextAll().remove();
        for(var i in data){
            select.append('<option value="'+i+'">#'+i+' '+data[i]+'</option>');
        }
        select.val(select);
    },
    load_service: function(select) {
        $(select).parents('form').addLoader();
        if ($(select).val() != '0')
            ajax_update("?cmd=" + order.cmd + "&action=" + order.action + "&make=getclientservice", {id: $('.draft_id').eq(0).val(), service: $(select).val()}, function(data){
                $("#client_service").html(data);
                $('#preloader').remove();
            });
    },
    edit_back: function(that){
        $(that).prev().show().focus().prevAll().remove();
        $(that).remove(); 
        return false;
    },
    delayAction: null,
    cycle: {}
};