<script type="text/javascript" src="{$template_dir}js/jqueryui/js/jquery-ui-1.8.23.custom.min.js?v={$hb_version}"></script>
<link href="{$template_dir}js/jqueryui/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" media="all" />
<div class="blu">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody><tr><td>
                    <a  href="?cmd=reports">
                        <strong>&laquo; Back to all reports</strong>
                    </a>
                </td><td align="right"></td></tr>
        </tbody></table>
</div>
<div style="padding:15px;background:#F5F9FF;">
    {if $report.custom}
    {include file='reports/editor.tpl'}
    {/if}
    <form action="?cmd=reports&action=show&report={$report.id}" method="post" id="reportform" target="_blank" >
        <div class="sectioncontent">
            {if !$report.custom}
            <h2>{$report.name}</h2>
            {/if}

            {if !$exception}

            <table border="0" cellspacing="6" cellpadding="0" width="100%">
                <tr>
                    <td  class="enum"><h1>1.</h1></td>
                    <td> <strong>Available columns</strong>
                        <div class="p5">
                            <ul id="sortablea">
                                {foreach from=$report.available_columns item=column}
                                <li class="ui-state-highlight">{$column}<input type="hidden" name="columns[]" value="{$column}" /></li>
                                {/foreach}
                            </ul><div class="clear"></div>
                        </div>
                        <em>You can drag items between top/bottom list and change order</em><br/><br/>

                        <strong>Columns to export in report:</strong>
                        <div class="p5">
                            <ul id="sortableb">

                                {foreach from=$report.default_columns item=column}
                                <li class="ui-state-highlight">{$column}<input type="hidden" name="export[]" value="{$column}" /></li>
                                {/foreach}
                            </ul>
                            <div class="clear"></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="enum"><h1>2.</h1></td>
                    <td>
                        <strong>Parameters:</strong>
                        <div class="p5"> {if $report.params}
                            <table border="0" cellspacing="0" cellpadding="5" width="100%">
                                {foreach from=$report.params item=pr key=kr}
                                <tr>
                                    <td width="160"><b>{$defaults.$kr.name}</b></td>
                                    <td>
                                        {if $defaults.$kr.type=='date'}
                                        <input name="params[{$kr}]" class="haspicker" value="{$defaults.$kr.value|dateformat:$date_format}" />
                                        {/if}
                                    </td>
                                </tr>
                                {/foreach}
                            </table>
                            <div class="clear"></div>  {else}<em>none</em>  {/if}

                        </div>
                        <strong>Conditions: <a href="#" onclick="$(this).hide();$('#conditions').slideDown();return false;">Click here to add</a></strong>
                        <div class="p5" id="conditions" style="display:none">

                            <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                <tr>
                                    <td width="120">Column:</td>
                                    <td width="70">Operator:</td>
                                    <td width="120">Value:</td>
                                    <td width="14"></td>
                                </tr>

                                <tr id="tr0">
                                    <td ><select name="conditions[0][column]" class="columner inp">
                                            <option value="">Select column</option>
                                            {foreach from=$report.default_columns item=column}
                                            <option value="{$column}">{$column}</option>
                                            {/foreach}
                                        </select></td>
                                    <td ><select name="conditions[0][operator]" class="inp">
                                            <option value=">">Bigger than &gt;</option>
                                            <option value="<">Less than &lt;</option>
                                            <option value="=">Equals =</option>
                                            <option value="!=">Other than !=</option>
                                        </select></td>
                                    <td ><input type="text" name="conditions[0][constant]" value="" class="inp" /></td>
                                    <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">Remove</a></td>
                                </tr>
                            </table>
                            <a href="#" class="editbtn" onclick="tr_add_row(); return false;">Add new condition</a>

                        </div>
                    </td></tr>

                <tr>
                    <td class="enum"><h1>3.</h1></td>
                    <td> <strong>Export as:</strong>
                        <div id="subwiz_opt" class="p5">
                            {foreach from=$outputs item=out name=fr key=k}
                            <span {if $smarty.foreach.fr.first}class="active"{/if}>
                                <input type="radio" onclick="$('.opt_settings').hide();$('#premade{$k}_html').show();prswitch(this);"  id="premade{$k}" value="{$out.name}" name="output" {if $smarty.foreach.fr.first}checked="checked"{/if}>
                                   <label >{$out.name}</label>
                            </span>
                            {/foreach}
                        </div>
                        <div id="settingshtml">
                            {foreach from=$outputs item=out name=fr key=k}
                            <div {if !$smarty.foreach.fr.first}style="display:none"{/if} id="premade{$k}_html" class="opt_settings">
                                {$out.config}
                            </div>
                            {/foreach}
                        </div>
                        <a  href="#" class="new_dsave new_menu" onclick="$('#reportform').submit();return false;">
                            <span>Generate report</span>
                        </a>
                    </td></tr>
            </table>
            {else}
            <h2>Query contains errors: {$exception}</h2>
            Please correct your SQL and save changes to get full options

            {/if}




    </form>
    <div class="clear"></div>
</div>{literal}
<style>
    .sectioncontent ul { list-style-type: none; margin: 0; padding: 0; margin-bottom: 10px; min-height: 37px;margin:0px;}
    .sectioncontent h2 { margin:0px 0px 16px;}
    .sectioncontent li { margin: 5px 5px 0px; padding: 5px;  cursor:move; display:inline-block;}
    #subwiz_opt span {text-transform: uppercase;}
    #subwiz_opt span.active {font-weight: bold;}
    .p5 {margin-bottom:20px;}
    .enum {
        vertical-align: top;
        border-right:solid 1px #ddd;
        width:50px;
    }
    .enum h1 {
        font-size:26px;
        color:#666;
    }

</style>
<script>
    $(function() {
        $( "#sortablea" ).sortable({
            connectWith: ['#sortableb'],
            update: sortablestop
        }).disableSelection();
        $( "#sortableb" ).sortable({
            connectWith: ['#sortablea']
        }).disableSelection();
		
		
    });
    function sortablestop(event,ui) {
        $('#sortableb input').attr('name','export[]');
        $('#sortablea input').attr('name','columns[]');


        $('#sortablea input').each(function(){
            var v = $(this).val();
            if($('#trtable tr select.columner option:selected[value="'+v+'"]').length) {
                $('#trtable tr select.columner option:selected[value="'+v+'"]').parent().parent().parent().find('a.rembtn').click();
            }
            $('#trtable tr select.columner option[value="'+v+'"]').remove();
        });
        $('#sortableb input').each(function(){
            var v = $(this).val();
            if($('#trtable tr select.columner option[value="'+v+'"]').length<1) {
                $('#trtable tr select.columner').append('<option value="'+v+'">'+v+'</option>');
            }
        });
      
    }
    function prswitch(el) {
        $('#subwiz_opt span').removeClass('active');
        $(el).parent().addClass('active');
    }

    function tr_remove_row(el) {
        if ($('#trtable tr').length>2) {
            $(el).parents('tr').eq(0).remove();
        } else {
            $(el).parents('tr').eq(0).find('input, select').val('');
        }

    }
    function tr_add_row() {
        var t = $('#trtable tr:last');
        if(!t.attr('id')) {
            return false;
        }
        var prev = t.attr('id').replace(/[^0-9]/g,'');
        next = parseInt(prev)+1;
        var nw = t.clone();
        nw.attr('id','tr'+next);
        nw.find('input, select').each(function(){
            var n =$(this).attr('name');
            n=n.replace("["+prev+"]","["+next+"]");
            $(this).attr('name',n).val('');
        });

        $('#trtable').append(nw);
        return false;
    }

</script>
{/literal}