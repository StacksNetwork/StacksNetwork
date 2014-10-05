function _fileupload_init(){
    $('input[type=file][data-upload]').each(function(){
        var that = $(this),
            url = that.attr('data-upload');
        if(that.data('fileup'))
            return true;
        that.data('fileup', true).fileupload({
            dataType: 'json',
            url: url
        });
    });
}
function fileupload_init(){
    if(typeof jQuery.fn.fileupload != 'function'){
        $.getScript("templates/default/js/fileupload/vendor/jquery.ui.widget.js", function(){
            $.getScript("templates/default/js/fileupload/jquery.iframe-transport.js", function(){
                $.getScript("templates/default/js/fileupload/jquery.fileupload.js", function(){
                    _fileupload_init();
                });
            });
        });
    }else{
        _fileupload_init();
    }
}
fileupload_init();