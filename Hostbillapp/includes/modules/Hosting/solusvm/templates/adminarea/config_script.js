var solusvm = {
    showloader : function() {
        $('.onapptab:visible').find('.onapp-preloader').slideDown();
    },
    hideloader : function() {
        $('.onapptab:visible').find('.onapp-preloader').slideUp();

    },
    lookforsliders : function() {
        var pid = $('#product_id').val();
        $('.formchecker').click(function(){
            var tr=$(this).parents('tr').eq(0);
            var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
            if(!$(this).is(':checked')) {
                if(!confirm('Are you sure you want to remove related Form element? ')) {
                    return false;
                }
                if($('#configvar_'+rel).length) {
                    ajax_update('?cmd=configfields&make=delete',{
                        id:$('#configvar_'+rel).val(),
                        product_id:pid
                    },'#configeditor_content');
                }
                //remove related form element
                tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                tr.find('input[id], select[id]').eq(0).removeAttr('disabled','disabled').show();
                that.load_section($(this).parents('div.onapptab').eq(0).attr('id').replace('_tab',''));
                $(this).parents('span').eq(0).find('a.editbtn').remove();
            } else {
                //add related form element
                var el=$(this);
                var rel=$(this).attr('rel');
                tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
                that.showloader();
                $.post('?cmd=services&action=product',{
                    make:'importformel',
                    variableid:rel,
                    cat_id:$('#category_id').val(),
                    other:$('input, select','#onapptabcontainer').serialize(),
                    id:pid,
                    server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                },function(data){
                    var r = parse_response(data);
                    if(r) {
                        el.parents('span').eq(0).append(r);
                        that.hideloader();
                        ajax_update('?cmd=configfields',{
                            product_id:pid,
                            action:'loadproduct'
                        },'#configeditor_content');
                    }
                });
            }
        }).each(function(){
            if(!$(this).css('display') == 'none')
                return;
            var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
            if($('#configvar_'+rel).length<1)
                return 1;
            var fid = $('#configvar_'+rel).val();
            var tr=$(this).attr('checked','checked').parents('tr').eq(0);
            tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
            tr.find('.tofetch').addClass('disabled');
            $(this).parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm('+fid+','+pid+')" class="editbtn orspace">Edit related form element</a>');
        }).filter('.osloader').each(function(){
            if($('#configvar_os').length<1)
                return 0;
            var fid = $('#configvar_os').val();
            $(this).parents('span').eq(0).append(' <a href="#" onclick="return solusvm.updateOSList('+fid+')" class="editbtn orspace">Update template list from SolusVM</a>');
        });
    },
    updateOSList : function(fid) {
        that.showloader();
        $.post('?cmd=services&action=product&make=updateostemplates',{
            id:$('#product_id').val(),
            cat_id:$('#category_id').val(),
            other:$('input, select','#onapptabcontainer').serialize(),
            server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
            fid:fid
        },function(data){
            parse_response(data);
            editCustomFieldForm(fid,$('#product_id').val());
        });
        return false;
    },
    load_section : function(section)  {
        
        if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
            alert('Please configure & select server first');
            return;
        }
        var tab = $('#'+section+'_tab');
        if(!tab.length)
            return false;
        var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
        if(!elements.length)
            return false;
        if($('#product_id').val() == 'new' || isNaN(parseInt($('#product_id').val())) || $('#saved_module').val() == '0'){
            alert('You have to save this product before you can continue to the next step');
            return false;
        }
        
        elements.each(function(e){
            var el = $(this);
            var inp=el.find('input[id], select[id]').eq(0);
            if(inp.is(':disabled')) {
                if($('[name^="'+inp.attr('name')+'"]').length < 2){
                    if((e+1)==elements.length) {
                        tab.find('.onapp-preloader').slideUp();
                    }
                    return 1; //continue;
                }
            }
            if($('[name^="'+inp.attr('name')+'"]').length < 2){
                var vlx = inp.val();
                var vl=inp.attr('id')+"="+vlx;
                if(vlx!=null && vlx.constructor==Array) {
                    vl = inp.serialize();
                }
            }else var vl = $('[name^="'+inp.attr('name')+'"]').serialize();
            tab.find('.onapp-preloader').show();
            $.post('?cmd=services&action=product&'+vl,
            {
                make:'loadoptions',
                id:$('#product_id').val(),
                cat_id:$('#category_id').val(),
                opt:inp.attr('id'),
                server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
                types: $('#single_vm').is(':checked') ? $('#option1').val() : $('#allowedvpstypes').val()
            },function(data){
                var r=parse_response(data);
                if(typeof(r)=='string') {
                    $(el).addClass('fetched');
                    var id = $('.onapp_opt input[type=radio]:checked').attr('id');
                    el.html(r).find('.odesc_').hide().end().find('.odesc_'+id, r).show();
                    filter_types();
                    $(document).trigger('provisionchange', id);
                }
            });
        });
        return false;
    },
    singlemulti : function(ini, root) {
        $('#step-1').show();

        if($('#single_vm').is(':checked')) {
            $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
            $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
        } else {
            $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
            $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
        }
    },
    bindsteps : function() {
        $('a.next-step').click(function(){
            $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
            return false;
        });
        $('a.prev-step').click(function(){
            $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
            return false;
        });
        $('#serv_picker input[type=checkbox]').click(function(){
            if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val() && $('#product_id').val() != 'new' && !isNaN(parseInt($('#product_id').val())) && $('#saved_module').val() == '1')
                $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
            else
                $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

        });
    },
    append : function() {
        $('#onappconfig_').TabbedMenu({
            elem:'.onapptab',
            picker:'.breadcrumb-nav a',
            aclass:'active',
            picker_id:'nan1'
        });
        $('.onapp_opt input[type=radio]').click(function(e){
            $('.onapp_opt').removeClass('onapp_active');
            var id=$(this).attr('id');
            $('.odesc_').hide();
            $('.odesc_'+id).show();
            $(this).parents('div').eq(0).addClass('onapp_active');
            filter_types();
            $(document).trigger('provisionchange', id);
        });
        $('.onapp_opt input[type=radio]:checked').click();
        this.lookforsliders();
        $(document).ajaxStop(function() {
            $('.onapp-preloader').hide();
        });
        that.bindsteps();
        if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val() && $('#product_id').val() != 'new' && !isNaN(parseInt($('#product_id').val())) && $('#saved_module').val() == '1'){
            $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
        }
    }
}
var that = solusvm;


if (typeof(HBTestingSuite)=='undefined')
    var HBTestingSuite={};

HBTestingSuite.product_id=$('#product_id').val();
HBTestingSuite.initTest=function(){
    solusvm.showloader();
    ajax_update('?cmd=testingsuite&action=beginsimpletest',{
        product_id:this.product_id,
        pname: $('form#productedit input[name=name]').val()
    },'#testconfigcontainer');
    //$.facebox({ ajax: "?cmd=testingsuite&action=beginsimpletest&product_id="+this.product_id+"&pname="+name,width:700,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
    return false;
};

function filter_types(){ 
    $('[class^="opt_"]').hide(); 
    if($('#single_vm').is(':checked')){
        var type = $('#option1').val();
        
        $('.opt_'+type).show();

        $('.opt_'+type).each(function(){
            if($(this).parent().is('#option2') && $('#option2 option:first').is(':selected'))
                return;
            if(!$(this).find('option:visible:selected').length){
                $(this).find('option:visible:first').prop('selected', true);
            }
        });
        if(!$('#option4 .opt_'+type+' option:selected').length){
            $('#option4 .opt_'+type+' option:first').prop('selected', true);
        }
                
        if($('[class^="opt_"] option', '#option5, #option2').length > 0){
            $('#option1 option').each(function(){
                if(!$('.opt_'+$(this).val()+' option', '#option5, #option2').length){
                    $(this).attr('disabled','disabled').prop('disabled',true);
                }else if($(this).is(':disabled')){
                    $(this).removeAttr('disabled').prop('disabled',false);
                }
                if(!$('#option5 .opt_'+$(this).val()).length && $('#option2 .opt_'+$(this).val()).length>0){
                        switch($(this).val()){
                            case 'openvz': var label = 'OpenVZ'; break;
                            case 'xen': var label = 'Xen PV'; break;
                            case 'xenhvm': var label = 'Xen HVM'; break;
                            case 'kvm': var label = 'KVM'; break;
                        }
                        $('#option5').append('<optgroup label="'+label+'" class="opt_'+$(this).val()+'"><option value="">--none--</option></optgroup>');
                    }
            });
        }
    }else{
        $('#vpstypeplanscontainer, #nodegroup2container').children().hide();
        $('#allowedvpstypes option').each(function(i){
            if($(this).is(':selected')) {
                $('#vpstypeplanscontainer').children().eq(i).show();
                $('#nodegroup2container').children().eq(i).show();
                $('.opt_'+$(this).val()).show();

                $('.opt_'+$(this).val()).each(function(){
                    if($(this).parent().is('#option2') && $('#option2 option:first').is(':selected'))
                        return;
                    if(!$(this).find('option:visible:selected').length){
                        $(this).find('option:visible:first').prop('selected', true);
                    }
                });
                
            }
        });
    }
}
$(document).bind('provisionchange', function(e, id){
    $('select.disable_').prop('disabled', true).attr('disabled', 'disabled');
    if(!$('.formchecker[rel="'+id+'"]:checked').length)
        $('select.disable_'+id).prop('disabled', false).removeAttr('disabled');
    else $('select.disable_'+id).hide();
    $('.disable_ select').prop('disabled', true).attr('disabled', 'disabled');
    $('.disable_'+id+' select').prop('disabled', false).removeAttr('disabled');
});
