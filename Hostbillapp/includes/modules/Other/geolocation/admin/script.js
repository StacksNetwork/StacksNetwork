$(function(){
    $('#newshelfnav').TabbedMenu({
        elem:'.sectioncontent', 
        picker:'.list-1 li:has([href=#])', 
        aclass:'active'
    });
    $('.load-values:not(:last)').change(function(){
        var postvar = {};
        $(this).parents('label').nextAll('label').find('select option').remove().end().find('select').append('<option value="0">All</option>');
        $.each($('.load-values').serializeArray() ,function(){
            postvar[this.name] = this.value
            });
        $('.ajax-load').show();
        $.post('?cmd=geolocation&action=load', postvar , function(data){
            $('.ajax-load').hide();
            if(data == undefined)
                return false;
            var select = false;
            for( var key in data){
                select = $('.load-values[name='+key+']');
                if(!data){
                    select.attr('disabled','disabled').prop('disabled', true);
                }else{
                    select.removeAttr('disabled').prop('disabled', false).children().remove();
                    select.append('<option value="0">All</option>');
                    $.each(data[key], function(i){
                        select.append('<option>'+ data[key][i] +'</option>');
                    });
                }
            }
        })
    });
})

var geolocation = {
    newform: function(){
        $('#geoform').show();
        $('#addnew_btn').hide();
    },
    cancel:function(){
        $('#geoform').hide();
        $('#addnew_btn').show();
    },
    submit: function(form){
        $('.ajax-load').show();
        var postvar = {};
        $.each($(form).serializeArray(), function(){
            if(this.name.substr(-2)=='[]'){
                if(postvar[this.name] == undefined) postvar[this.name] =[this.value]; else postvar[this.name].push(this.value);
            } else postvar[this.name]=this.value
                });
        $.post($(form).attr('action'), postvar, function(data){
            $('.ajax-load').hide();
            var resp = parse_response(data);
            $('#geo-list ul').html(resp);
        });
        return false;
    },
    copyform: function(a){
        $(a).toggleClass('activated');
        if($(a).parents('li').find('form').length){
            $(a).parents('li').find('form').toggle();
            return;
        }
        var form = $('#geoform').clone().removeAttr('id').attr('action', $(a).attr('href') )
        .find('[name=country], [name=region], [name=city]').attr('disabled', 'diabled').prop('disabled', true).end()
        .find('[type=checkbox], [type=radio]').removeAttr('checked').prop('checked', false).change().end()
        .find('.new_control:first').val('Save').end().find('.new_control:last').removeAttr('oclick').click(function(){$(a).click()}).end()
        .find('.geo-loc').unwrap().end().show();
        var qa = $(a).parents('li').find('select, input').serializeArray(),
        names = {};
        $.each(qa, function(){
            var fitm = this;
            form.find('[name="'+this.name+'"]').each(function(){
                if( fitm.value.length > 0 && (fitm.name == 'region' || fitm.name == 'city' ) ){
                    $(this).append('<option>'+fitm.value+'</option>');
                }else if(  $(this).is('[type=checkbox]') || $(this).is('[type=radio]') ){
                    if(fitm.value.length && fitm.value == $(this).val())
                    $(this).prop('checked', true).change();
                } else {
                    $(this).val(fitm.value);
                }
            });
        });
        $(a).parents('li').find('.edit').html(form);
    },
    gates: function(check){
        if($(check).hasClass('geo-all-gates')){
            if($(check).is(':checked'))
                $(check).parents('.geo-label-lkie').find('.geo-gates').hide();
            else
                $(check).parents('.geo-label-lkie').find('.geo-gates').show();
        }
    },
    descr: function(){
        var w = 0;
        $('#geo-list .description').each(function(){
            w = $(this).width() > w ? $(this).width() : w;
        }).width(w);
    }
}