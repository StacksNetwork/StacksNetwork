{if $action=='getvariables'}
    {include file='ajax.emailvariables.tpl'}
{elseif $action=='adds'}
   
{elseif $action == 'edit' || $action=='add'}
    {literal}
        <script type="text/javascript">
                function submitform(el) {
                ajax_update("?cmd=emailtemplates&action={/literal}{if $action=='add'}add{else}edit&id={$email.id}{/if}{literal}&inline=true", $(el).serialize());
                    return false;
                }
        </script>   
    {/literal}
    <form method="post" {if $action=='add'}action="?cmd=emailtemplates&action=add"{else}action="?cmd=emailtemplates&action=edit&id={$email.id}"{/if}  {if $inline} onsubmit="return submitform(this)"{/if}>

        {if !$inline}
            <div class="blu"> 
                {if $email.group=='Mobile'}
                    <a href="?cmd=notifications" class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>&nbsp;
                {else}
                    <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;
                {/if}
                <input type="submit" name="submit" style="font-weight:bold" value="{if $action=='add'}{$lang.addtemplate}{else}{$lang.savechanges}{/if}" />
                <input type="button" onclick="window.location = '?cmd=emailtemplates'" value="{$lang.Cancel}"/>
                {if $email.system=='0'}
                    <input type="button" onclick="{literal}if (confirm('{/literal}{$lang.deletetemplateconfirm}{literal}')){window.location = '?cmd=emailtemplates{/literal}&security_token={$security_token}{literal}&make=delete&id={/literal}{$email.id}{literal}'} else {return false; }{/literal}" style="color:red" value="{$lang.Delete}"/>
                {/if}
            </div>
        {/if}
        <div class="lighterblue" style="padding:5px;">
            {if $email.send=='0'}
                <div class="imp_msg" id="disablednote">
                    <strong>{$lang.disablednote}</strong> 
                    <a href="#" onclick="$('#disablednote').hide(); ajax_update('?cmd=emailtemplates&make=enable&id={$email.id}'); return false;" class="editbtn">{$lang.Enable}</a>
                </div>
            {/if}
            {if $action=='add'}
                <input type="hidden" name="make" value="add" />
            {else}
                <input type="hidden" name="make" value="edit" />
            {/if}
            {if $to}<input type="hidden" name="to" value="{$to}" />{/if}
            {if $dontclose}<input type="hidden" name="dontclose" value="true" />{/if}
            <input type="hidden" name="group"  value="{$email.group}"/>
            <input type="hidden" name="send"  value="{$email.send}"/>
            <input type="hidden" name="tplname"  value="{$email.tplname}"/>
            <input type="hidden" name="system"  value="{$email.system}"/>
            {foreach from=$langs item=lgname key=lgid name="loop"}
                {if !is_array($email.message)}
                    {assign var=send_as value=$email.sendas}
                    {assign var=tpl_subject value=$email.subject}
                    {assign var=tpl_message value=$email.message}
                    {assign var=alt_message value=$email.altmessage}
                {else}
                    {assign var=send_as value=$email.sendas.$lgid}
                    {assign var=tpl_subject value=$email.subject.$lgid}
                    {assign var=tpl_message value=$email.message.$lgid}
                    {assign var=alt_message value=$email.altmessage.$lgid}
                {/if}
                <table width="100%" cellspacing="0" cellpadding="6" {if !$smarty.foreach.loop.first}style="display:none"{/if} id="langform_{$lgid}">
                    <tr>
                        <td width="160">
                            <input type="hidden" value="{$lgid}" name="language_id[{$lgid}]"/>
                            <input type="hidden" value="{$lgname}" name="language_name[{$lgid}]"/>
                            <strong>{$lang.Subject}:</strong>
                            {if $language_tabs }<br />
                                <small>({$lgname|capitalize})</small>
                            {/if}
                        </td>
                        <td >
                            {hbinput value=$tpl_subject style="" class="inp" size="50" name="subject[`$lgid`]"}
                        </td>
                    </tr>
                    <tr>
                        <td width="160">
                            <strong>Send as:</strong>
                        </td>
                        <td >
                            <select name="sendas[{$lgid}]" class="inp form-sendas" >
                                <option {if $send_as == 'plain'}selected="selected"{/if} value="plain">Plain text</option>
                                <option {if $send_as == 'html'}selected="selected"{/if} value="html">HTML</option>
                                <option {if $send_as == 'both'}selected="selected"{/if} value="both">HTML + Plain text (Alternative content)</option>
                            </select>
                        </td>
                    </tr>
                    <tbody id="mbody">
                        <tr class="message-form">
                            <td  valign="top">
                                <strong>{$lang.Body}:</strong>
                                <br><small class="body-type"></small>
                            </td>
                            <td valign="top" >
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs 
                                    value=$tpl_message  class="inp wysiw_editor message" cols="100" rows="15"  
                                    name="message[`$lgid`]" featureset="ace" editortag="HTML" editortype="ace"}
                            </td>
                        </tr>
                        <tr class="altmessage-form hidden">
                            <td  valign="top">
                                <strong>Alternative Body:</strong>
                                <br /><small>(Plain text)</small>
                            </td>
                            <td valign="top" >
                                {hbwysiwyg wrapper="div" style="width:99%;" additionaltabs=$language_tabs 
                                    value=$alt_message  class="inp wysiw_editor altmessage" cols="100" rows="15"  
                                    name="altmessage[`$lgid`]" featureset="ace" editortag="HTML" editortype="ace"}
                            </td>
                        </tr>
                    </tbody>
                </table>
                {literal}
                    <script type="text/javascript">
                            (function(){
                            var id = {/literal}'{$lgid}'{literal},
                                index = $('#langform_' + id).prevAll('table').length;
                                $('#langform_' + id + ' .message-form .additional').eq(index).addClass('active');
                                $('#langform_' + id + ' .altmessage-form .additional').eq(index).addClass('active');
                            })()
                    </script>
                {/literal}
            {/foreach}

            {literal}
                <script type="text/javascript">
                    var sendas = $('.form-sendas');
                    sendas.on('change update',function(){
                        var self = $(this),
                            value = self.val();
                        sendas.val(value);
                        
                        if(value == 'both'){
                            $('.altmessage-form').show();
                        }else{
                            $('.altmessage-form').hide();
                        }
                        if(value == 'plain'){
                            $('.body-type').text('(Plain text)')
                        }else{
                            $('.body-type').text('(HTML)')
                        }
                    }).trigger('update');
                    $('.tabs_wysiw li a').click(function(){
                        var index = $(this).parent().index();
                        var el = $('table[id^="langform"]').hide().eq(index).show();
                        $('.tabs_wysiw li select').val(index);
                        return false;
                    });   
                </script>
            {/literal}
            {include file='ajax.emailvariables.tpl'}
        </div>
        <div class="blu"> {if !$inline}
            {if $email.group=='Mobile'}
                <a href="?cmd=notifications" class="tload2"><strong>&laquo; {$lang.backto} {$lang.Notifications}</strong></a>&nbsp;
            {else}
                <a href="?cmd=emailtemplates" class="tload2"><strong>&laquo; {$lang.backtoemailtpl}</strong></a>&nbsp;
            {/if}
        {/if}
        <input type="submit" name="submit" style="font-weight:bold" value="{$lang.savechanges}" />
        {if !$inline}<input type="button" onclick="window.location = '?cmd=emailtemplates'" value="{$lang.Cancel}"/>{/if}
    {if !$inline}{if $email.system=='0'}<input type="button" onclick="{literal}if (confirm('{/literal}{$lang.deletetemplateconfirm}{literal}')){window.location = '?cmd=emailtemplates{/literal}&security_token={$security_token}{literal}&make=delete&id={/literal}{$email.id}{literal}'} else {return false; }{/literal}" style="color:red" value="{$lang.Delete}"/>{/if}{/if}
</div>
{securitytoken}</form>
<form id="previewform" target="_blank" method="post" action="?cmd=emailtemplates&action=preview">
    <input type="hidden" name="body" id="prevbody" value=""/>
    {securitytoken}</form>
{/if}