$(document).ready(function(){
    $("div.pagination").trigger('nextPage');
    var timeout = false;
			
    $('#lang_search input').keyup(function(){
        if(timeout)
            clearTimeout(timeout);
        timeout = setTimeout(function(){
            $('#search_prop').html('<li class="clear" style="text-align:left"><span>Searching for: "'+$('#lang_search input').val()+'"</span</li>').fadeIn('fast');
            ajax_update("?cmd=langedit",{
                action:"lang_search", 
                lang:Globl.lang, 
                word:$('#lang_search input').val()
                },
            function (a){
                $('#search_prop').html(a);
            }
            );
            timeout = false;
        }, 300);
    });	
    $('#lang_search input').keypress(function(e) {
        if (e.which == '13') {
            $('#lang_search input').keyup();
            return false;
        }
    });
$('#lang_search input').blur(function(){
    setTimeout(function(){
        $('#search_prop').fadeOut('fast');
    }, 300);
});
$('.filter-opt li').click(function(){
    if($(this).attr('rel').length){
        $(this).children().toggle();
        toggleFiltr(parseInt($(this).attr('rel')));
        ajax_update($('#currentlist').attr('href'), 
        {
            page:$('input[name="page"]').val(), 
            pagination:$('input[name="pagination"]').val(), 
            action:'getsection'
        }, 
        function (a){
            $('table.translations').replaceWith(a);
            bindEvents();
            updateFiltr(true);
            $('div.pagination').pagination.setPage($('input[name="page"]').val());
        });
    }
});
});
var proce = false;
function mark_all(swi){
    function saveDE(e){
        var onc="$('#transform').submit(); return false;";
        $('a.new_dsave').css('opacity',e?1:0.3).attr('onclick', e?onc:'');
    }
    var row = null;
    var fdo = null;
    var adar = null;
    if(proce) clearTimeout(proce);
    switch(swi){
        case "edit":
            fdo = editTranslation;
            adar = [$('#updater tr:not(.editable) a:first-child')];
            break;
        case 'del':
            fdo = delTranslation
            adar = [$('#updater tr:not(.delete) a:first-child'), 'clear'];
            break;
        case 'undel':
            fdo = delTranslation
            adar = [$('#updater tr.delete a:first-child'), 'del'];
    }
    saveDE(false);
    function procF(f,arg){
        row = arg[0].eq(0);
        arg[0] = arg[0].not(arg[0].eq(0));
        if(row.length){
            if(arg.length == 2)
                f(row, arg[1]);
            else f(row);
            proce = setTimeout(function(){
                procF(f,arg)
                },10);
        }else{
            clearTimeout(proce);
            proce = false;
            saveDE(true);
        }
    }
    procF(fdo,adar);		
}
function editTranslation(a){
    if($(a).parent().siblings('.valuebox:has(textarea)').length) 
        return false;
    var key = $(a).parent().siblings('.keybox').text().replace(/"/g,'&quot;')
    var htm = $(a).parent().siblings('.valuebox'),
    section = Globl.section == '-1' ? $(a).parent().siblings('.valuebox').attr('rel') : Globl.section;
    htm.html('<textarea name="entrys['+section+']['+key+']" >'+htm.html()+'</textarea>')
    $(a).parent().siblings('.valuebox').find('textarea').elastic();
    $(a).parents('tr').addClass('editable');
    return false;
}
function delTranslation(a, block){
    var key = $(a).parent().siblings('.keybox').text().replace(/"/g,'&quot;'),
    section = Globl.section == '-1' ? $(a).parent().siblings('.valuebox').attr('rel') : Globl.section;
    if($(a).parent().parent('.delete').length && block !='clear'){
        $(a).parent().parent('.delete').removeClass('delete').next('input[value="'+key+'"]').remove();
    } else if(block !='del'){
        $(a).parent().parent().not('.delete').addClass('delete').after('<input type="hidden" value="'+key+'" name="entrys[del]['+section+'][]" />'); 
    }
    return false;
}
function addTranslation(){
    if(Globl.section == '-1')
        return false;
    $('table.translations tbody').prepend('<tr id="new'+Globl.newi+'" class="new"><td class="firstcell"><a class="menuitm" title="'+Globl.cancel+'" onclick="return cancelTranslation('+Globl.newi+')" ><span class="editsth"></span></a></td><td><input name="entrys[new]['+Globl.newi+'][key]" /></td><td {/literal}{if $language_det.parent_name}colspan="2"{/if}{literal}><textarea name="entrys[new]['+Globl.newi+'][val]"></textarea></td></tr>');
    Globl.newi++;
    return false;
}
function cancelTranslation(id){
    $('#new'+id).remove();
    return false;
}
function addSection(){
    $('table.translations tbody').html('');
    $('.pagebuttons').html('');
    $('#sectionselect').replaceWith('<input id="sectionselect" />');
    $('#sectionselect').change(function(){
        $('input[name="section"]').val($(this).val());
    });
}
function saveTranslations(form){
    if($('#transform input[name="entrys[del][]"]').length > 0){ 
        if(!confirm(Globl.confirmline)) return false;
    }
    ajax_update("?cmd=langedit&action=getsectionpage",{
        formdata:$(form).serialize()+'&filtr='+Globl.filtr
        },function (a){
        $('table.translations #updater').html(a);
        bindEvents();
        Globl.section = $(form).find('input[name="section"]').val();
    });
    return false;
}
            
function pagination_toggle(){
    clearTimeout(proce);
    if(Globl.pagination == 'on') {
        if(!confirm(Globl.confirmline2)) return false;
        Globl.pagination = 'off';
        $('.pagination').hide();
    }else{
        Globl.pagination = 'on';
        $('.pagination').show();
    }
    $('.pagebuttons a.menuitm.menul').toggleClass('activated').text(Globl.pagination == 'on' ? Globl.off : Globl.on );
			
    $('table.translations tbody').addLoader();
    ajax_update("?cmd=langedit",{
        action:"getsection", 
        lang:Globl.lang, 
        section:Globl.section, 
        pagination:Globl.pagination, 
        filtr: Globl.filtr
        },function (a){
        $('table.translations').replaceWith(a);
        bindEvents();
        updateFiltr(true);
        Globl.section = $('input[name="section"]').val();;
    });
    return false;
}
function go2page(section, key){
    clearTimeout(proce);
    $('table.translations tbody').addLoader();
    ajax_update("?cmd=langedit",{
        action:"getsection", 
        lang:Globl.lang, 
        section:section, 
        keyword:key, 
        pagination:Globl.pagination
        },function (a){
        $('table.translations').replaceWith(a);
        bindEvents();
        Globl.section = section;
        $('#sectionselect').val(section);
        if(Globl.pagination == 'on')
            $('div.pagination').pagination.setPage($('input[name="page"]').val());
        //window.location.hash="found";
        updateFiltr(true);
        $(document).slideToElement('found');
    });
			
    return false;
}
function changeSection(name) {
    clearTimeout(proce);
    $('table.translations tbody').addLoader();
    ajax_update("?cmd=langedit",{
        action:"getsection", 
        lang:Globl.lang, 
        section:name, 
        pagination:Globl.pagination, 
        filtr: Globl.filtr
        },function (a){
        $('table.translations').replaceWith(a);
        bindEvents();
        updateFiltr(true);
        Globl.section = name
        if(name == '-1')$('.new_add').addClass('disabled'); else $('.new_add').removeClass('disabled');
    });
			
    return false;
}
            
function toggleFiltr(x){
    var prop = updateFiltr();
    Globl.filtr = Globl.filtr ^ x;
    if(typeof prop.filtr == 'boolean' ){
        $('#currentlist').attr('href', 
            $('#currentlist').attr('href')+'&filtr='+x);
    }else{
        $('#currentlist').attr('href',prop.url.join('&')+'&filtr='+Globl.filtr);
    }
}
function updateFiltr(update){
    var filtr = false,
    parts = $('#currentlist').attr('href').split('&');
    $.each(parts, function(i){
        var param = this.split('=');
        if(param[0] == 'filtr'){
            filtr=param;
            parts[i] = '';
        }
    });
    if($('.filter-opt').width() > $('.filter-opt').parent().width()){
        $('.filter-opt').parent().css('position','relative');
        $('.filter-opt').css('right',0);
    }else{
        $('.filter-opt').css('right','');
    }
    if(update != undefined && update==true){
        Globl.filtr = parseInt(filtr[1]);
        $('.filter-opt li').each(function(){
            if(Globl.filtr & parseInt($(this).attr('rel'))) var c = 'on'; else var c = 'off';
            $(this).children().hide().filter('.'+c).show();
        })
    }
    return {
        url:parts, 
        filtr:filtr
    }
}
function openFilters(that){
    $(that).toggleClass('activated').next().fadeToggle();
}