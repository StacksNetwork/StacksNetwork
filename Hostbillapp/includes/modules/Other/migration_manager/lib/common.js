function parseSubmit(response,postdata) {
    var data = response.responseText;
    var codes = eval('(' + data.substr(data.indexOf('<!-- ') + 4, data.indexOf('-->') - 4) + ')');
    var pass=true;
    var msg="";
    for (var i = 0; i < codes.ERROR.length; i++) {
        msg+=codes.ERROR[i];
        pass=false;
    }
    
    return [pass,msg] 
}
    
function helptoggle() {
    $('#helpcontainer > .menuitm').toggle();
    $('#helpcontainer .blank_state_smaller').eq(0).toggle();
        
    return false;
}
    
    
   function getportdetails(url) {
        $('.spinner').show();
        $('#porteditor').hide().html('');
        $.get(url,function(data) {
            $('.spinner').hide();
            $('#porteditor').html(data).show();
        });

    }   
function showFacebox(url) {
    $.facebox({
        ajax: url,
        width:900,
        nofooter:true,
        opacity:0.8,
        addclass:'modernfacebox'
    });
    return false;
}