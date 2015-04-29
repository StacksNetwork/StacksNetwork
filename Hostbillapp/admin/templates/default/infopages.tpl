<link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
<script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td colspan="2"><h3>{$lang.informationpages}</h3></td>

    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=infopages&action=new"  data-pjax class="tstyled {if $action=='new'}selected{/if}">{$lang.addnewpage}</a>
            <a href="?cmd=infopages" data-pjax  class="tstyled {if $action=='default' || $action=='edit'}selected{/if}">{$lang.listpages}</a>

        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">
                {include file='ajax.infopages.tpl'}
                

            </div></td>
    </tr>
</table>