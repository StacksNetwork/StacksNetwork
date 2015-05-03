function onapp_showloader() {
    $('.onapptab:visible').find('.onapp-preloader').slideDown();
}

function onapp_hideloader() {
    $('.onapptab:visible').find('.onapp-preloader').slideUp();
}

function lookforsliders() {
    var pid = $('#product_id').val();
    $('.formchecker').click(function() {
        var self = $(this),
            tr = self.parents('tr, .ftr').eq(0);
        var rel = self.attr('rel').replace(/[^a-z_0-9]/g, '');
        if (rel.match(/^os\d*/))
            rel = 'os';

        if (!self.is(':checked')) {
            if (!confirm('Are you sure you want to remove related Form element? ')) {
                return false;
            }
            var remlist = [];
            if (self.data('rem') && self.data('rem').length) {
                $.each(self.data('rem'), function() {
                    remlist.push('#configvar_' + this.toString())
                })
            } else {
                remlist.push('#configvar_' + rel);
            }

            for (var i = 0; i < remlist.length; i++) {
                var el = $(remlist[i]);
                if (el.length)
                    ajax_update('?cmd=configfields&make=delete', {
                        id: $(remlist[i]).val(),
                        product_id: pid
                    }, '#configeditor_content');
            }
            //remove related form element
            tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
            tr.find('input[id], select[id]').not(self).eq(0).removeAttr('disabled', 'disabled').show();
            tr.find('.formcheckerbox').show().find('input, select').prop('disabled', false);
            load_onapp_section(self.parents('div.onapptab').eq(0).attr('id').replace('_tab', ''));
            self.parents('span').eq(0).find('a.editbtn').remove();
            self.trigger('formdown');
        } else {
            //add related form element
            var self = $(this);
            var rel = self.attr('rel');
            tr.find('input[id], select[id]').not(self).eq(0).attr('disabled', 'disabled').hide();
            tr.find('.formcheckerbox').hide().find('input, select').prop('disabled', true);
            onapp_showloader();
            $.post('?cmd=services&action=product', {
                make: 'importformel',
                variableid: rel,
                cat_id: $('#category_id').val(),
                other: $('input, select', '#onapptabcontainer').serialize(),
                id: pid,
                server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
            }, function(data) {
                var r = parse_response(data);
                if (r) {
                    self.parents('span').eq(0).append(r);
                    onapp_hideloader();
                    ajax_update('?cmd=configfields', {product_id: pid, action: 'loadproduct'}, '#configeditor_content');
                }
            });
            self.trigger('formup');
        }
    }).each(function() {
        var self = $(this),
            rel = self.attr('rel').replace(/[^a-z_0-9]/g, '');
        if (rel.match(/^os\d*/))
            rel = 'os';

        if ($('#configvar_' + rel).length < 1)
            return 1;

        var fid = $('#configvar_' + rel).val();
        var tr = self.attr('checked', 'checked').trigger('change').parents('tr, .ftr').eq(0);
        tr.find('input[id], select[id]').not(self).eq(0).attr('disabled', 'disabled').hide();
        tr.find('.formcheckerbox').hide().find('input, select').prop('disabled', true);
        tr.find('.tofetch').addClass('disabled');

        self.parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm(' + fid + ',' + pid + ')" class="editbtn orspace">Edit related form element</a>');
        self.trigger('formup');

    }).filter('.osloader').each(function() {
        if ($('#configvar_os').length < 1)
            return 0;
        var fid = $('#configvar_os').val();
        $(this).parents('span').eq(0).append(' <a href="#" onclick="return updateOSList(' + fid + ')" class="editbtn orspace">Update template list from CloudStack</a>');
    });

}

function updateOSList(fid) {
    onapp_showloader();
    $.post('?cmd=services&action=product&make=updateostemplates', {
        id: $('#product_id').val(),
        cat_id: $('#category_id').val(),
        other: $('input, select', '#onapptabcontainer').serialize(),
        server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
        fid: fid
    }, function(data) {
        parse_response(data);
        editCustomFieldForm(fid, $('#product_id').val());
    });
    return false;
}

function load_onapp_section(section) {
    if (!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
        alert('Please configure & select server first');
        return;
    }

    var tab = $('#' + section + '_tab');
    if (!tab.length)
        return false;
    var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
    if (!elements.length)
        return false;
    tab.find('.onapp-preloader').show();
    elements.each(function(e) {
        var el = $(this);
        var inp = el.find('input[id], select[id]').filter(function() {
            return !$(this).is(':disabled')
        });
        if (!inp.length) {
            if ((e + 1) == elements.length) {
                tab.find('.onapp-preloader').slideUp();
            }
            return 1; //continue;
        }

        var data = {
            make: 'getonappval',
            id: $('#product_id').val(),
            cat_id: $('#category_id').val(),
            opt: inp.attr('id'),
            server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
        };
        inp.each(function() {
            var inp = $(this);
            data[inp.attr('name')] = inp.val();
        })

        $.post('?cmd=services&action=product', data, function(data) {
            var r = parse_response(data);
            if (typeof (r) == 'string') {
                el.addClass('fetched');
                el.html(r);
            }
        });
    });
    $('[data-disable]').off('change').on('change', function() {
        var self = $(this);
        $('#' + self.data('disable')).prop('disabled', self.is(':checked'))
    }).change();

    return false;
}

function singlemulti() {
    $('#step-1').show();
    if ($('#single_vm').is(':checked')) {
        $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
        $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
        $('#option14').val(1);
        $('#option19').val('No');
    } else {
        $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
        $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
    }
}

function bindsteps() {
    $('a.next-step').click(function() {
        $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
        return false;
    });
    $('a.prev-step').click(function() {
        $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
        return false;
    });
    $('#serv_picker input[type=checkbox]').click(function() {
        if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
            $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
        else
            $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

    });
}

function append_onapp() {
    $('#onappconfig_').TabbedMenu({elem: '.onapptab', picker: '.breadcrumb-nav a', aclass: 'active', picker_id: 'nan1'});

    $('.onapp_opt input[type=radio]').click(function(e) {
        $('.onapp_opt').removeClass('onapp_active');
        var id = $(this).attr('id');
        $('.odesc_').hide();
        $('.odesc_' + id).show();
        $(this).parents('div').eq(0).addClass('onapp_active');
        singlemulti();
    });

    $('.onapp_opt input[type=radio]:checked').click();

    $(document).ajaxStop(function() {
        $('.onapp-preloader').hide();
    });

    if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');

    $('#storage_tier').on('change tierup', function() {
        console.log('tierup')
        var self = $(this),
            tier = $('.tier2storage');
        if (self.is(':checked')) {
            tier.show().find('input, select').prop('disabled', false);
        } else
            tier.hide().find('input, select').prop('disabled', true);
    }).trigger('tierup');

    $('[data-toggle-op]').on('change', function() {
        var self = $(this),
            target = $(self.data('toggle-op'));
        if (self.is(':checked')) {
            target.prop('disabled', 'true').attr('disabled, disabled');
        } else
            target.prop('disabled', false).removeAttr('disabled');
    }).trigger('change');
    
    $('#vcpu').change(function(){
        if ($(this).is(':checked')) {
            //$('.vcpu-disabled').hide();
            $('.vcpu-enabled').show();
            $('.vcpu-disabled').fadeTo(0, 0.5).prop('title', 'This option is disabled if you use vCPU').find('input, select, textarea').prop('disabled', true);
        } else {
            $('.vcpu-disabled').fadeTo(0, 1).prop('title', '').find('input, select, textarea').prop('disabled', false);
            $('.vcpu-enabled').hide();
        }
    }).change();
    
    $(document).on('updatePricinForms', function(){
        var variable = $('#text-variable', '#facebox');
        if(variable.val() != 'storage_tiers')
            return false;
        
        variable.prop('readonly', true).css('cursor', 'not-allowed');
        $('#check-show').prop('disabled',true);
        
        $('#premadeid','#subitems_editor').parent().prev().css({float:'none', width: 'auto', lineHeight:'29px'}).end().remove();
        $('input[name$="[variable_id]"], input[name=new_value_name]','#subitems_editor').each(function(){
            var self = $(this).css({marginLeft: '5px', width: 'auto'}),
                root = self.clone().attr('name','').val(''),
                data = self.clone().attr('name','').val('');
                
            if(self.is('input[name=new_value_name]')){
                self.before('<label>Tier name</label>');
                self.clone().attr('name','cloudstack_storage_tiers').val('1').hide().insertAfter(self);
                self = self.clone().attr('name','variable_id').val('').hide().insertAfter(self);
            }else{
                self.hide().prev().hide();
            }

            $('<label>Data storage (DATA)</label>').css('line-height','28px').insertAfter(self).after(data);
            $('<label>Primary storage (ROOT)</label>').css('line-height','28px').insertAfter(self).after(root);
            
            var opt = {};
            try {
                opt = JSON.parse(self.val());
            }catch (Error){
                //
            }
            root.val(opt.root);
            data.val(opt.data);
            
            function maketags(key){
                opt[key] = $(this).val();
                self.val(JSON.stringify(opt));
            }
            root.change(function(){
                maketags.call(this, 'root');
            })
            data.change(function(){
                maketags.call(this, 'data');
            })
        })
    });

    bindsteps();
    lookforsliders();
}

if (typeof (HBTestingSuite) == 'undefined')
    var HBTestingSuite = {};

HBTestingSuite.product_id = $('#product_id').val();
HBTestingSuite.initTest = function() {
    var name = $('form#productedit input[name=name]').val();
    onapp_showloader();
    ajax_update('?cmd=testingsuite&action=beginsimpletest', {product_id: this.product_id, pname: name}, '#testconfigcontainer');
    //$.facebox({ ajax: "?cmd=testingsuite&action=beginsimpletest&product_id="+this.product_id+"&pname="+name,width:700,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
    return false;
};

$(document).bind('updatePricinForms', function(e, paytype) {
    var varname = $('#text-variable');
    if (varname.val() == 'userstoragetags') {
        varname.clone().prop('type', 'hidden').insertAfter(varname);
        varname.prop('disabled', true);
        $('#check-show').parents('table').eq(0).find('input, select').prop('disabled', true);
        $('#facebox .pricingtable tr').hide().filter('.hpricing').show().find('.sfee').remove();
    }
});