$(document).ready(function(){

    $(document).ajaxComplete(function(event, XMLHttpRequest, ajaxOptions){
        if(ajaxOptions.data && ajaxOptions.data.indexOf('make=poll')<0 && ajaxOptions.url.indexOf('cmd=tickets')>0) {
             loadNotes();
        }
    });
});

function loadNotes() {
    if(!$('.hasnotes','#updater').length)
        return;
    if($('#notecontainer').length<1) {
         $('body').append('<div id="notecontainer"></div>');
    }
    var container = $('#notecontainer');
    var toupdate={};
    $('.hasnotes','#updater').each(function(n){
        toupdate[n]= $(this).parents('tr').eq(0).find('a[rel]').attr('rel');
    }).tipsy({
        live: true,
        html: true,
        gravity: 'e',
        title:function(){
            return container.data($(this).parents('tr').eq(0).find('a[rel]').attr('rel'));
    }});
    $.post('?cmd=ticketnotespreview&action=showit', {notes:toupdate}, function(data) {
        if(data && data.notes) {
            for(n in data.notes) {
                container.data(n,data.notes[n]);
            }
        }
    });

}

