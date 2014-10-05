<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td ><h3>{$lang.SendMessage}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=sendmessage"  class="tstyled {if $action == 'default'}selected{/if}">{$lang.SendMessage}</a>
            <a href="?cmd=sendmessage&action=asticket"  class="tstyled {if $action == 'asticket'}selected{/if}">Create Tickets</a>
        </td>

        <td  valign="top"  class="bordered">
            <div id="bodycont">
                {literal}
                    <script type="text/javascript">
                    
                function save_tpl() {
                    if($("input[name='save']:checked").val() == 1) {
                        $('#tpl_name').show();
                    } else {
                        $('#tpl_name').hide();
                    }
                }
                function send_email() {
                    if($('#to').val() == '') {
                        alert('{/literal}{$lang.tofieldempty}{literal}');
                            return false;
                    }
                    if($('#msg_body').val() == '') {
                        if(!confirm('{/literal}{$lang.withoutbody}{literal}'))
                            return false;
                    }
                    if($('#subject').val() == '') {
                        if(!confirm('{/literal}{$lang.withoutsubject}{literal}'))
                            return false;
                    }
                    return true;
                }
                    
                    </script>
                {/literal}
                {if $sent}
                    <div class="blu" style="padding: 5px;">
                        <a href="?cmd=sendmessage" ><strong>&laquo; {$lang.sendanother}</strong></a>
                    </div>
                    <div class="lighterblue" style="padding:10px">
                        {if $logs}
                            {foreach from=$logs item=log}
                                {if $action=='asticket'}
                                    {if $log.success}
                                        Ticket created for
                                    {else}
                                        Could not create ticket for
                                    {/if}
                                {else}
                                    {if $log.success}
                                        {$lang.emailsentto}
                                    {else}
                                        {$lang.cantsendto}
                                    {/if}
                                {/if}
                                {if $log.client_id && $log.client_name}<a href="?cmd=clients&action=show&id={$log.client_id}">{$log.client_name}</a>
                                {else}<strong>{$log.email}</strong>
                                {/if}.
                                <br />
                            {/foreach}
                        {/if}
                    </div>
                    <div class="blu" style="padding: 5px;">
                        <a href="?cmd=sendmessage" ><strong>&laquo; {$lang.sendanother}</strong></a>
                    </div>
                {else}
                    <form action="{if $action=='asticket'}?cmd=sendmessage&action=asticket{else}?cmd=sendmessage{/if}" method="post" id="massform">
                        <input type="hidden" name="type" value="{$sendtype}" />
                        {foreach from=$selected item=item}
                            <input type="hidden" name="selected[]" value="{$item}" />
                        {/foreach}
                        <div class="blu">
                            {if $action=='asticket'}
                                <input type="submit" name="tickets" value="Create Tickets" style="font-weight:bold" onclick="return send_email();"/>
                            {else}
                                <input type="submit" name="send" value="{$lang.SendMessage}" style="font-weight:bold" onclick="return send_email();"/>
                            {/if}
                            {$lang.Or}
                            {if $action=='asticket'}
                                <a href="?cmd=sendmessage" onclick="$('#massform').append('<input type=\'hidden\' name=\'action\' value=\'default\' /><input type=\'hidden\' name=\'make\' value=\'migrate\' />').submit(); return false;">{$lang.SendMessage}</a>
                            {else}
                                <a href="?cmd=sendmessage&action=asticket" onclick="$('#massform').append('<input type=\'hidden\' name=\'action\' value=\'asticket\' /><input type=\'hidden\' name=\'make\' value=\'migrate\' />').submit(); return false;">Create Tickets</a>
                            {/if}
                        </div>
                        <div class="lighterblue"  style="padding:5px">
                            <table width="100%" cellpadding="3" class="email_table">
                                {if $action!='asticket'}
                                    <tr>
                                        <td width="5%" align="right">{$lang.From}:</td>
                                        <td>
                                            <input type="text" name="from1" value="{if $submit.from1}{$submit.from1}{else}{$from1}{/if}" size="30" class="inp" /> 
                                            <input type="text" name="from2" value="{if $submit.from2}{$submit.from2}{else}{if $from2}{$from2}{else}{$lang.youremailempty}{/if}{/if}" size="30" class="inp" />
                                        </td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td width="5%" align="right">{$lang.To}:</td>
                                    <td><textarea name="to" rows="3" style="width: 100%" id="to" class="inp">{if $submit.to}{$submit.to}{else}{$to_list}{/if}</textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">{$lang.Subject}:</td>
                                    <td>
                                        <input name="subject" style="width: 100%" value="{$submit.subject}" id="subject" class="inp" />
                                    </td>
                                </tr>
                                {if $action=='asticket'}
                                    <tr>
                                        <td align="right">Department:</td>
                                        <td>
                                            <select name="dept_id" value="{$submit.subject}" class="inp"> 
                                                {foreach from=$depatments item=dept}
                                                    <option value="{$dept.id}">{$dept.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                    </tr>
                                {else}
                                    <tr>
                                        <td align="right">{$lang.Save}:</td><td><input type="checkbox" name="save" value="1" {if $submit.save}checked="checked"{/if} onclick="save_tpl()" /> 
                                            <span id="tpl_name" style="display:none; font-weight: normal">
                                                {$lang.Templatename}: <input name="tpl_name" size="50" value="{$submit.subject}" class="inp"/> 
                                            </span> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">HTML</td>
                                        <td>
                                            <input type="checkbox" name="html" value="1" {if $submit.html}checked="checked"{/if} style="vertical-align: middle"/> 
                                            <a href="#" class="vtip_description" title="With this option you can use html tags in your messages to clients" />
                                        </td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td colspan="2">
                                        <textarea style="width: 100%" rows="20" name="body" id="msg_body" class="inp">{$submit.body}</textarea>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="blu">
                            {if $action=='asticket'}
                                <input type="submit" name="tickets" value="Create Tickets" style="font-weight:bold" onclick="return send_email();"/>
                            {else}
                                <input type="submit" name="send" value="{$lang.SendMessage}" style="font-weight:bold" onclick="return send_email();"/>
                            {/if}
                            {$lang.Or}
                            {if $action=='asticket'}
                                <a href="?cmd=sendmessage" >{$lang.SendMessage}</a>
                            {else}
                                <a href="?cmd=sendmessage&action=asticket" >Create Tickets</a>
                            {/if}
                        </div>
                        {securitytoken}
                    </form>
                {/if}
            </div>
        </td>
    </tr>
</table>
