$('#priceoptions').children().not('.bundle-capsule').remove();

var bundle_optgroups = 0;
$(function(){
    $('#bundledprodctstype').change(function(){
        switch($(this).val()){
            case 'Domain':var type= 'Domain';break;
            case 'Addon':var type= 'Addon';break;
            default:var type= 'Product';break;
        }
        if(bundle_optgroups==0)
            bundle_optgroups = $('#bundledprodcts').children().detach();
        $('#bundledprodcts').html(bundle_optgroups.filter('#empty_opt, .group_'+type)).val(0);
    }).change();
    
    $('#bundledprodcts').change(function(){
        bundle_add(this)
    });
    $(".bundle-list .loadname").each(function(){
        var val = $(this).parent().prev('input').val(),
        type = $(this).parent().prev('input').prev().val(),
        opt = $('option[value='+val+']', bundle_optgroups.filter('#empty_opt, .group_'+type));
        $(this).text(opt.parent().attr('label')+' - '+opt.text());
    });
    $(".bundle-list").dragsort({ 
        dragSelector: "a.sorter-handle", 
        placeHolderTemplate: '<li class="bundled-item"></li>'
    });
})

function bundle_add(that){
    var wrt = $(that),
    selected = wrt.find('option:selected'),
    text = selected.text(),
    type = $('#bundledprodctstype').val(),
    value = wrt.val(),
    catname = selected.parent().attr('label'),
    bid = $('.bundle-list li').length;
    //wrt.find('option:selected')
    $('.bundle-list .template').clone().removeClass('template')
    .attr('id', 'bundle_'+value+'_'+bid+'_'+type).find('input').each(function(i){
        var name = $(this).attr('name');
        if(name && name.length && name.match(/\[\]$/)){
            $(this).attr('name', name.replace(/\[\]$/,'['+bid+']'))
        }
        switch(i){
            case 1:$(this).val(value);break;
            case 2:$(this).val($('#bundledprodctstype').val());break;
            default:$(this).val(bid);
        }
    })
    .end().find('.loadname').text(catname+' - '+text)
    .end().find('.edit a').attr('href', (type == 'Addon' ? '?cmd=productaddons&action=addon&id=':'?cmd=services&action=product&id=') + value)
    .end().appendTo('.bundle-list');
    wrt.val(0);
}

function bundle_remove(that){
    var item = $(that).parents('.bundled-item'),
    id = item.attr('id').replace(/^bundle_/,'');
    item.remove();
    $('#config'+id).remove();
    var config = $('#bundle_config');
    if(!config.children(':visible').length){
        config.css('min-height','auto');
        $('.bundle-items').css('min-height','auto');
        $('.bundle-list').removeClass('short');
    }
}

function bundle_config(that){
    var item = $(that).parents('.bundled-item'),
    postdata = {
        make:'config',
        id:$('#product_id').val(),
        cat_id:$('#category_id').val()
    },
    bundleid = item.find('.bundle-sort').val();
    
    postdata = $.param(postdata)+'&'+item.find('input,select,textarea').serialize();
    
    var id = $(that).attr('rel');
    if(id && id.length){
        postdata += '&'+ $('#'+id).find('input,select,textarea').serialize();
    }
    $('#bundle_ajax').show();
    $.post('?cmd=services&action=product',postdata,function(data){
        $('#bundle_ajax').hide();
        $('.bundle-list').addClass('short');
        data = $(parse_response(data));
        var id = data.attr('id'),
        container = $('#'+id);

        data.find('input, select, textarea').addClass('inp').each(function(){
            var thatt = $(this);
            thatt.attr('name', thatt.attr('name').replace(/^custom/,'custom['+bundleid+']'));
        });
        if(container.length){
            container.html(data.html()).siblings(':visible').hide().end().show();
        }else{
            data.appendTo('#bundle_config').siblings(':visible').hide().end().show();
        }
        $(that).attr('rel',id);
        var part = $('#bundle_config').css('min-height','auto').height(),
        main = $('.bundle-items').css('min-height','auto').height();
        if(main > part)
            $('#bundle_config').css('min-height',main)
        else
            $('.bundle-items').css('min-height',part);
        $('.form-disabler', '#bundle_config').change();
    });
}

function bundle_pricingopt(){
    var box = $('#pricing_overide'),
    sw = $('#pricing_overide_switch'),
    box2 = $('#pricing_dynamo');
    if(sw.is(':checked')){
        box.show();box2.hide();
        //box2.fadeOut('fast',function(){box.fadeIn('fast')});
    }else{
        //box.fadeOut('fast',function(){box2.fadeIn('fast')});
        box.hide();box2.show();
    }
}

function bundle_optionalconfig(that){
   var form = $(that).parents('.like-table-row').find('input, textarea, select').not(that); 
   if(!$(that).is(':checked'))
       form.removeAttr('disabled').prop('disabled',false);
   else
       form.attr('disabled', 'disabled').prop('disabled',true);
}

function bundle_discount(that){
    var postdata = {
        make:'discount',
        id:$('#product_id').val(),
        cat_id:$('#category_id').val()
    };
    postdata = $.param(postdata)+'&'+$('#bundle_discount').find('input,select,textarea').serialize();
    $.post('?cmd=services&action=product',postdata,function(data){
        data = $(parse_response(data));
        $('#bundle_pricngopt').html(data);
    });
}