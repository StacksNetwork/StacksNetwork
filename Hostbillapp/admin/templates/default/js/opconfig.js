var HBOpConfig = {
    category: null,
    template: null,
    init: function(c,t){HBOpConfig.category = c;HBOpConfig.template=t},
    callback: [],
    fsubmit:function(){
        $('.spinner').show();
        for(var i =0; i< HBOpConfig.callback.length; i++){
            if(typeof HBOpConfig.callback[i] == 'function')
                HBOpConfig.callback[i]();
        }
        $.get('?cmd=services&action=opconfig&do=saveconfig&'+$('#sform1').serialize(),function(data){
            parse_response(data);
            $(document).trigger('close.facebox');
        });
        return false;
    }
};
var premade = {
    filelock: false,
    recheck: null,
    save:function(){
        $('[id^=old_premade_], #new_premade').hide();
        $('input,textarea,select','#sform1').filter(function(){return $(this).val() ? $(this).val().length == 0 : true}).prop('disable',true);
        var recheck=false;
        $('[id^="file_"]').each(function(i){
            var ukey = $(this).attr('id');
            var key = ukey.replace(/file_(.+)_\d+/,'$1');

            if(premade.filelock || $(this).val().length > 0){
                premade.filelock = true;
                if(premade.icons[ukey] != undefined && premade.icons[ukey] === 0){
                    recheck = true;
                }else if(premade.icons[ukey] === undefined){
                    premade.icons[ukey] = 0;
                    premade.update(key, ukey,false);
                    recheck = true;
                }else if(typeof premade.icons[ukey] == 'string'){
                    clearTimeout(premade.recheck);
                   // console.log('got '+premade.icons[ukey]);
                    $('input[rel="'+ukey+'"]').val(premade.icons[ukey]);
                }
            }
        });
        if(recheck){
            //console.log('recheck ');
            clearTimeout(premade.recheck);
            premade.recheck = setTimeout(function(){
                premade.save()
            },200);
            return false;
        }
        //console.log('save ');
        $.post('?cmd=services&action=opconfig&do=saveconfig&cat_id='+HBOpConfig.category, $('input,textarea,select','#sform1').serializeArray(), function(){
            ajax_update('?cmd=services&action=opconfig&tpl='+HBOpConfig.template+'&id='+HBOpConfig.category, {}, '#facebox .content');
        });  
        return false;
    },

    update:function(key,ukey,preview){
        if(preview){
            $('<div style="position:absolute;top:0px;left:0px;width:250px;" id="preloader"></div>').height($('#icon_'+key).outerHeight()).appendTo($('#icon_'+key));
            old = 0;
        }else{
            old = $('input[name="opconfig['+key+']['+(ukey.replace(/^[^\d]+/,''))+'][icon]"]').val();
            if(old == undefined) old= 0;
        }
        $.ajaxFileUpload({
            url:'?cmd=services&action=opconfig&id='+HBOpConfig.category+'&do=ajaxupload', 
            fileElementId: ukey, 
            data: {
                preview:preview,
                old: old
            }, 
            dataType: 'json',
            success: function(data, status){
                if($('#'+ukey).length)
                    $('[id^=jUploadFile]').detach().replaceAll('#'+ukey).attr('id', ukey);
                if(!data.status){
                    $('#icon_'+key).html(data.errors); 
                    if(!preview){
                        premade.icons[ukey] = -1;
                    }
                    return false;
                }
                if(preview){
                    var stamp = Date.now();
                    $('#icon_'+key).html('<img src="../'+data.url+'?'+stamp+'" alt="icon" />'); 
                }else premade.icons[ukey] = data.url;
                console.log(data.url);
            },
            error: premade.up_error
        });
        return false;
    },
    addnew:function(key){
        $('[id^="old_'+key+'_"]').hide();
        $('#new_premade').show();
        $('#itool_'+key).show();
        $('#btn_'+key).text('Add');
        return false;
    },
    edit:function(key, index){
        $('[id^="old_'+key+'_"]').hide();
        $('#old_'+key+'_'+index).show();
        $('#itool_'+key).show();
        $('#new_premade').hide();
        $('#btn_'+key).text('Change');
        $('#icon_'+key).html('<img src="../'+$('input[name="opconfig['+key+']['+index+'][icon]"]').val()+'" alt="icon" /></div>'); 
        return false;
    },
    del:function(key, index){
        if($('#old_'+key+'_'+index).is(':visible')){
            $('#itool_'+key).hide();
        }
        $('#old_'+key+'_'+index).remove();
        $('#plist_premade li').eq(index-1).remove();
        return false;
    },
    up_error:function(){},
    icons : {}
}
HBOpConfig.callback.push(premade.save);
