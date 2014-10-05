<script type="text/javascript" src="{$template_dir}js/jqueryui/js/jquery-ui-1.8.23.custom.min.js?v={$hb_version}"></script>
<link href="{$template_dir}js/jqueryui/css/ui-lightness/jquery-ui-1.8.23.custom.css" rel="stylesheet" media="all" />
<div class="blu">
    <table width="100%" cellspacing="0" cellpadding="0" border="0">
        <tbody><tr><td>
                    <a  href="?cmd=reports">
                        <strong>&laquo; 返回所有报告</strong>
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
                    <td> <strong>可用的列</strong>
                        <div class="p5">
                            <ul id="sortablea">
                                {foreach from=$report.available_columns item=column}
                                <li class="ui-state-highlight">{$column}<input type="hidden" name="columns[]" value="{$column}" /></li>
                                {/foreach}
                            </ul><div class="clear"></div>
                        </div>
                        <em>您可以拖动顶部到底部之间的内容来更改要求</em><br/><br/>

                        <strong>列输出报告:</strong>
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
                        <strong>参数:</strong>
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
                            <div class="clear"></div>  {else}<em>无</em>  {/if}

                        </div>
                        <strong>Conditions: <a href="#" onclick="$(this).hide();$('#conditions').slideDown();return false;">点击此处添加</a></strong>
                        <div class="p5" id="conditions" style="display:none">

                            <table border="0" cellspacing="0" cellpadding="3" id="trtable">
                                <tr>
                                    <td width="120">列:</td>
                                    <td width="70">运算符:</td>
                                    <td width="120">值:</td>
                                    <td width="14"></td>
                                </tr>

                                <tr id="tr0">
                                    <td ><select name="conditions[0][column]" class="columner inp">
                                            <option value="">选择列</option>
                                            {foreach from=$report.default_columns item=column}
                                            <option value="{$column}">{$column}</option>
                                            {/foreach}
                                        </select></td>
                                    <td ><select name="conditions[0][operator]" class="inp">
                                            <option value=">">大于 &gt;</option>
                                            <option value="<">小于 &lt;</option>
                                            <option value="=">等于 =</option>
                                            <option value="!=">不等于 !=</option>
                                        </select></td>
                                    <td ><input type="text" name="conditions[0][constant]" value="" class="inp" /></td>
                                    <td><a onclick="tr_remove_row(this); return false" class="rembtn" href="#">删除</a></td>
                                </tr>
                            </table>
                            <a href="#" class="editbtn" onclick="tr_add_row(); return false;">添加新的条件</a>

                        </div>
                    </td></tr>

                <tr>
                    <td class="enum"><h1>3.</h1></td>
                    <td> <strong>输出为:</strong>
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
                            <span>生成报告</span>
                        </a>
                    </td></tr>
            </table>
            {else}
            <h2>查询包含错误: {$exception}</h2>
            请您正确的使用完整的选项更改和保存SQL

            {/if}




    </form>
    <div class="clear"></div>
</div>{literal}
<style>
    .sectioncontent ul { list-style-type: none; margin: 0; padding: 0; margin-bottom: 10px; min-height: 37px;margin:0px;}
    .sectioncontent h2 { margin:0px 0px 16px;}
    .sectioncontent li { margin: 5px 5px 0px; padding: 5px; width: 150px; cursor:move; display:inline-block;}
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