var _optgroups = 0;
$(function(){
    $('#prodctstype').change(function(){
        switch($(this).val()){
            case 'Domain':var type= 'Domain';break;
            case 'Addon':var type= 'Addon';break;
            default:var type= 'Product';break;
        }
        if(_optgroups==0){
            _optgroups = $('#prodcts').children().detach();
            $('#limitslist tr').each(function(){
                var id = $(this).attr('id');
                if(id){
                    var parts =  id.split('_');
                    _optgroups.filter('.group_'+parts[2]).find('option[value='+parts[1]+']').prop('disabled',true);
                }
            });
        }
            
        $('#prodcts').html(_optgroups.filter('#empty_opt, .group_'+type)).val(0);
    }).change();

    $('#prodcts').change(function(){
        limit_add(this)
    });
    
    $(window).delegate('#limitslist a','click',function(){
        $(this).parents('tr').eq(0).remove();
    });
});
function limit_add(that){
    var wrt = $(that),
    selected = wrt.find('option:selected'),
    text = selected.text(),
    type = $('#prodctstype').val(),
    value = wrt.val(),
    catname = selected.parent().attr('label'),
    bid = $('.bundle-list li').length,
    id = 'limit_'+value+'_'+type;
    
    wrt.val(0);
    selected.attr('disabled','disabled').prop('disabled');
    
    if($('#'+id).length)
        return false;
    
    $('.template').clone().removeClass('template')
    .attr('id', id).find('input').attr('name', 'limits['+type+']['+value+']')
    .end().find('td:eq(0)').text(catname+' - '+text).end()
    .appendTo('#limitslist').show();
    
    
    $('.nothing').hide();
}