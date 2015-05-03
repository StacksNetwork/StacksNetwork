{if $action != 'fastban' && $action != 'iplog' && $action != 'password'} 
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <input value="{$action}" id="newaction" type="hidden" style="display:none"></a>

{if $security_rules}
    {foreach from=$security_rules item=rule}	
        <tr>
            <td>{$rule.rule}</td>
            <td>{if $rule.action == 'allow'}{$lang.allow}{else}{$lang.deny}{/if}</td>
            <td>
                {if $rule.action == 'allow'}
                    <a href="?cmd=security&make=toggle_rule&id={$rule.id}" onclick="return toggle_rule(this)" class="editbtn" data-enabled="{if $rule.options & 2}true{/if}"
                       title="{if $rule.options & 2}Enable{else}Disable{/if} automatic bans for users coming from this address">
                        {if $rule.options & 2}禁用{else}启用{/if}
                    </a>
                {else}-
                {/if}
            </td>
            <td>
                <a href="?cmd=security&make=remove_rule&id={$rule.id}" onclick="{literal}return remove_rule($(this).attr('href')){/literal}" class="delbtn" title="{$lang.Remove}">{$lang.Remove}</a>
            </td>
        </tr>
    {/foreach}
{elseif $banned_ips}
    {foreach from=$banned_ips item=ban_ip}
        <tr>
            <td>{$ban_ip.ip}</td>
            <td>{if $ban_ip.expires == '2999-01-01 00:00:00'}从未{else}{$ban_ip.expires|dateformat:$date_format}{/if}</td>
            <td>{$ban_ip.reason}</td>
            <td><a href="?cmd=security&action=ipban&make=remove_ipban&id={$ban_ip.id}" onclick="{literal}return remove_bannedip($(this).attr('href')){/literal}" class="delbtn">{$lang.Remove}</a>
            </td>
        </tr>
    {/foreach}

{elseif $banned_emails}
    {foreach from=$banned_emails item=ban_mail}
        <tr>
            <td>{$ban_mail.domain}</td>
            <td>{$ban_mail.count}</td>
            <td>{if $ban_mail.expires == '2999-01-01 00:00:00'}{$lang.never}{else}{$ban_mail.expires|dateformat:$date_format}{/if}</td>
            <td>{$ban_mail.reason}</td>
            <td><a href="?cmd=security&action=emails&make=remove_emailban&id={$ban_mail.id}" onclick="{literal}return remove_bannedemail($(this).attr('href')){/literal}" class="delbtn">{$lang.Remove}</a>
            </td>
        </tr>
    {/foreach}
{elseif $api_access}
    {foreach from=$api_access item=apia}
        <tr>
            <td>{$apia.ip}</td>
            <td>{$apia.api_id}</td>
            <td>{$apia.api_key}</td>
            <td><a href="?cmd=security&action=apiacl&id={$apia.id}">允许函数</a></td>
            <td></td>
            <td width="20"><a href="?cmd=security&action=apiaccess&make=remove_api&id={$apia.id}" onclick="{literal}return removeAPI($(this).attr('href')){/literal}" class="delbtn">{$lang.Remove}</a>
            </td>
        </tr>
    {/foreach}
{else}
    <tr><td colspan="5" style="font-weight: bold">{$lang.nothingtodisplay}</td></tr>
    {/if}
{elseif $action == 'iplog'}
    {if $admin_list}
        {foreach from=$admin_list item=admin}	
        <tr>
            <td><span title="{$admin.username}">{$admin.lastname} {$admin.firstname}</span> {*lastname, firstname, email, emails(1|0)*}</td>
            <td style="width:20%" >{$admin.email}</td>
            <td><input type="radio" name="a[{$admin.id}]" value="1" {if $admin.emails}checked="checked"{/if} onClick="changestatus({$admin.id}, 1)"/>{$lang.Enable} <input style="padding-right:6em" type="radio" name="a[{$admin.id}]" value="1" {if !$admin.emails}checked="checked"{/if} onClick="changestatus({$admin.id}, 0)" />{$lang.Disable} </td>
        </tr>
    {/foreach}
{else}
    <tr><td colspan="5" style="font-weight: bold">{$lang.nothingtodisplay}</td></tr>
{/if}
{elseif $action == 'password'}{if $pass_test}{$pass_test}{/if}
{/if}