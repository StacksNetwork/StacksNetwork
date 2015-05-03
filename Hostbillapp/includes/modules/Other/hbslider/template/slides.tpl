<!--BOF: FILEUPLOAD -->
<script src="{$tplurl}js/fileupload/vendor/jquery.ui.widget.js"></script>
<script src="{$tplurl}js/fileupload/vendor/tmpl.min.js"></script>
<script src="{$tplurl}js/fileupload/jquery.iframe-transport.js"></script>
<script src="{$tplurl}js/fileupload/jquery.fileupload.js"></script>
<script src="{$tplurl}js/fileupload/jquery.fileupload-ui.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$tplurl}js/fileupload/styles.css" />
<!--EOF: FILEUPLOAD -->

<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
<input type="hidden" name="slider_id" id="slider_id" value="{$slider.id}" />


<h3>Current slides:</h3>
<form id="serializeit">
    <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">

        {include file="`$tpldir`ajax.slides.tpl"}
    </ul>
    {securitytoken}
</form>



<div id="addeditform">

</div>

<a class="btn btn-large btn-primary" onclick="slideform('new'); return false">Add new slide</a>

<a class="btn btn-large" onclick="fromdefined(); return false">Create slides from defined Products</a>
<a class="btn btn-large" href="?cmd=hbslider&action=html&id={$slider.id}">Get HTML code</a>

{literal}
<!--BOF: FILEUPLOAD -->
<script type="text/javascript">

    function fromdefined() {
            ajax_update('?cmd=hbslider&action=productform',{slider_id:$('#slider_id').val()},'#addeditform',true);
            return false;

    }
    function slideform(id) {
            ajax_update('?cmd=hbslider&action=slideform&id='+id,{slider_id:$('#slider_id').val()},'#addeditform',true);
            return false;
    }
    function loadslides() {
            ajax_update('?cmd=hbslider&action=loadslides',{id:$('#slider_id').val(),make:'loadslides'},'#grab-sorter',true);
    }
    function delete_slide(id) {
        if(confirm('Are you sure? It will also remove any related image')) {
            ajax_update('?cmd=hbslider&action=loadslides',{id:$('#slider_id').val(),make:'removeslide',slide_id:id},'#grab-sorter',true);
        }
        return false;
    }
     function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=hbslider&action=sortorder&'+sorts,{slider_id:$('#slider_id').val()});
        };
    var bindSorter = function() {
                $("#grab-sorter").dragsort({ dragSelector: "a.sorter-ha", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });

    }
       $(function(){
           bindSorter();
       });
       var bindPform = function() {
           $('#productform').submit( function () {
              $.post(
               '?cmd=hbslider&action=submitproducts',
                $(this).serialize(),
                function(data){
                    parse_response(data);
                    loadslides();
                }
              );
              $('#addeditform').slideUp('fast',function(){$(this).html('').show()});

              return false;
            });

       }
       var bindUploader = function() {
            $("#singleslide").submit( function () {
              $.post(
               '?cmd=hbslider&action=saveslide',
                $(this).serialize(),
                function(data){
                    parse_response(data);
                    loadslides();
                }
              );
              $('#addeditform').slideUp('fast',function(){$(this).html('').show()});

              return false;
            });


        function enablesubmit() {
            $('#submitbutton').addClass('btn-success').removeClass('disabled').removeClass('btn-inverse').removeAttr('disabled');
        }
        function disablesubmit() {
            $('#submitbutton').removeClass('btn-success').addClass('disabled').addClass('btn-inverse').attr('disabled','disabled');
        }
        function showdropzone(e) {
            var dropZone = $('#dropzone').not('.hidden');
            dropZone.show();
            setTimeout(function () {
                hidedropzone()
            }, 6000);
        }
        function hidedropzone() {
            $('#dropzone').hide().addClass('hidden');
        }
        $('#fileupload').fileupload({maxNumberOfFiles:1});
        $('#fileupload').bind('fileuploadsend', disablesubmit)
        .bind('fileuploadalways', enablesubmit)
        .bind('fileuploaddragover', showdropzone)
        .bind('fileuploaddrop', hidedropzone);

    };

</script>
<script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td width="100"></td>
        <td class="name" width="40%"><span>{%=file.name%}</span></td>
        <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
        <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
        <td>            <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>

        </td>
        <td class="start" width="90">{% if (!o.options.autoUpload) { %}
            <button class="btn btn-primary btn-mini">
                <i class="icon-upload icon-white"></i>
                <span>Start</span>
            </button>
            {% } %}</td>
        {% } else { %}
        <td colspan="2"></td>
        {% } %}
        <td class="cancel" width="90" align="right">{% if (!i) { %}
            <button class="btn btn-warning  btn-mini">
                <i class="icon-ban-circle icon-white"></i>
                <span>{/literal}{$lang.cancel}{literal}</span>
            </button>
            {% } %}</td>
    </tr>
    {% } %}
</script><!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
        <td class="name" width="40%" colspan="2"><span>{%=file.name%}</span></td>
        <td class="size" width="90"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else { %}
        <td width="100"><img src="../slider/thumbs/{%=file.name%}" /></td>
        <td class="name" width="40%">{%=file.name%} <input type="hidden" name="image" value="{%=file.name%}" /></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        <td colspan="2"></td>
        {% } %}
        <td class="delete" width="90" align="right">
            <button class="btn btn-danger btn-mini" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}">
                <i class="icon-trash icon-white"></i>
                <span>{/literal}{$lang.delete}{literal}</span>
            </button>
        </td>
    </tr>
    {% } %}
</script>
{/literal}
<!--EOF: FILEUPLOAD -->