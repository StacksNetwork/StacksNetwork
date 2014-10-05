function fieldclick(type) {
    $('.dark_shelf .dhidden').show();
    $('.fselect').removeClass('selected');
    $('#field'+type).parent().addClass('selected');
    $('#initial-desc').hide();
    $('#s_menu div.description').hide();
    $('#s_menu div.descr_image').hide();
    $('#s_menu #'+type+'-description').show();
    $('#s_menu #'+type+'-descr_image').show();
    $('#duplicateform input[name=type]').val(type);
    $('#addform input[name=type]').val(type);
    //loadpremade	  
    $('#premadeloader').hide();
    $('.spinner').show();
    $.post('?cmd=configfields&action=loadpremade_field',{
        type:type
    },function(data){
        var d= parse_response(data);
        $('.spinner').hide();
        if(typeof(d)=='string') {
            $('#premadeloader').html(d).show();
        }
    });	  
}

function saveChangesField() {
    $('.spinner').show();
    ajax_update('index.php?cmd=configfields&x='+Math.random()+'&paytype='+$('input[name=paytype]:checked').val(),$('#saveform').serializeObject(),'.content');
    refreshConfigView($('#saveform').find('input[name=product_id]').val());
}
function createField() {
    //jakis preloader;
    $('.spinner').show();
    if($('#premade_val').length && $('#premade_val').val()!=0) {
        $('#premade_to_fill').val($('#premade_val').val());
    }
    if($('#premade_val').length && $('#premade_val').val()!=0) {
        $('#premadeurl_to_fill').val($('#premadeurl_val').val());
    }
    ajax_update('index.php?x='+Math.random()+'&paytype='+$('input[name=paytype]:checked').val(),$('#addform').serializeObject(),'#formcontainer');

    if($('#premade_val').val()!=0)
        refreshConfigView($('#addform').find('input[name=product_id]').val());

    return false;
}

function duplicateFieldSubmit() {
    $('.spinner').show();
    ajax_update('index.php?cmd=configfields&x='+Math.random(),$('#duplicatefield').serializeObject(),'#formcontainer');
    refreshConfigView($('#duplicatefield').find('input[name=product_id]').val());
    return false;
}

function usePremade() {
    if($('#premadeid').length==0 || $('#premadeid').val()==0)
        return false;

    if(!confirm(configfields_lang['premade_over'])) {
        return false;
    }
    ajax_update('index.php?cmd=configfields&action=overwritepremade',{
        premade:$('#premadeid').val(),
        category_id:$('#field_category_id').val()
        },'#subitems_editor');	
    refreshConfigView($('#saveform').find('input[name=product_id]').val());	
    return false;
}

function deleteItem(btn) {
    if(!confirm(configfields_lang['delconf2'])) {
        return false;
    }

    $(btn).parents('li').remove();
    ajax_update($(btn).attr('href'),{},function(){
        refreshConfigView($('#saveform').find('input[name=product_id]').val());	
    });	

    return false;
}
        
function addNewConfigItemValue() {
    var v = $('input[name=new_value_name]').val();
    if(!v)
        return false;
    $('input[name=new_value_name]').val("");	
    var data = $('input, select, textarea','#config-new-value').serializeObject();
    data.name = v;
    data.category_id = $('#field_category_id').val();
    ajax_update('index.php?cmd=configfields&action=additem&make=addnewitem', data, '#subitems_editor');	
    refreshConfigView($('#saveform').find('input[name=product_id]').val());	

    return false;
}

function duplicateField() {
    //jakis preloader;
    $('.spinner').show();
    ajax_update('index.php?x='+Math.random(),$('#duplicateform').serializeObject(),'#formcontainer');
    return false;
}

var updatepricingform_calbacks = {};
function updatePricingForms() {
    for(var i in updatepricingform_calbacks)
        updatepricingform_calbacks[i]();
    $(document).trigger('updatePricinForms', $('input[name=paytype]:checked').val() 
            || $('#pricing_overide:visible input[name=bundle_paytype]:checked').val()
            || $('input[name=dynamic_paytype]:checked').val())
}

function formbilling(that) {
    that = $(that);
    var id =  that.attr('href').substr(1);
    $('#formbilling > div').hide().find('select,input,textarea').prop('disabled',true).attr('disabled','disabled').end()
    .filter('#formbilling_'+id).show().find('select,input,textarea').prop('disabled',false).removeAttr('disabled').end().trigger('formbilling');
    that.addClass('active').siblings().removeClass('active');
    $('.formbilling-paytype').val(id);
}