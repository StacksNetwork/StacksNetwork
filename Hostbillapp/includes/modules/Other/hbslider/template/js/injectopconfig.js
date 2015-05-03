$(document).ready(function(){

        $('body').ajaxStop(function() {
                  scanForSlider();
         });
});

function scanForSlider() {
    if($('#opconfig_selectslider').length<1 || $('#opconfig_selectedslider').length>0) {
        return;
    }
    var s = $('#opconfig_selectslider').val();

$.post('?cmd=hbslider&action=opconfig',{selected:s},function(data) {
   if(data) {
       $('#opconfig_selectslider').after(data);
       selectedSlider();
   } 
});
}
function selectedSlider() {
if($('#opconfig_selectedslider').length) {
    $('#opconfig_selectslider').val($('#opconfig_selectedslider').val());
}
}
