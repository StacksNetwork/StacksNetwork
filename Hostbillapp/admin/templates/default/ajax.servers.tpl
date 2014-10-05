{if $action == 'get_fields'}
{if $server_fields &&  $server.type!='Domain'}
{if $custom_template}
    {include file=$custom_template}
{else}
    <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
        {if $server_fields.display.hostname}<tr><td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.maxaccounts}<tr><td  align="right" width="165"><strong>{if $server_fields.description.maxaccounts}{$server_fields.description.maxaccounts}{else}{$lang.maxnoofaccounts}{/if}</strong></td><td ><input  name="max_accounts" size="6" value="{$server.max_accounts}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.status_url}<tr><td  align="right" width="165">{if $server_fields.description.status_url}{$server_fields.description.status_url}{else}{$lang.serverstatusaddress}{/if}</td><td ><input  name="status_url" size="60" value="{$server.status_url}" class="inp" /></td></tr>{/if}
        {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
        {if $server_fields.display.field1}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.field2}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td><td ><input  name="field2" size="25" value="{$server.field2}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.hash}<tr><td valign="top" align="right" width="165"><strong>{if $server_fields.description.hash}{$server_fields.description.hash}{else}{$lang.accesshash}{/if}</strong></td><td ><textarea name="hash" cols="60" rows="8"  class="inp">{$server.hash}</textarea></td></tr>{/if}
        {if $server_fields.display.ssl}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td></tr>{/if}
        {if $server_fields.display.custom}
            {foreach from=$server_fields.display.custom item=conf key=k}
                <tr>
                    <td  align="right" width="165"><strong>{$k}</strong></td>
                            {if $conf.type=='input'}
                        <td ><input type="text" name="custom[{$k}]" value="{$server.custom.$k}" class="inp"/></td>
                        {elseif $conf.type=='password'}
                        <td ><input type="password" name="custom[{$k}]" value="{$server.custom.$k}"  class="inp"/></td>
                        {elseif $conf.type=='textarea'}
                        <td >
                            <span style="vertical-align:top"><textarea name="custom[{$k}]" rows="5" cols="60" style="margin:0px" >{$server.custom.$k}</textarea></span>
                        </td>
                    {/if}
                </tr>
            {/foreach}
        {/if}
    </table>
{/if}
{elseif $server.type=='Domain' && $modconfig}
    <table border="0" width="100%" cellpadding="5" cellspacing="0">
        {foreach from=$modconfig.config item=conf key=k}
            <tr >

                {assign var="name" value=$k}
                {assign var="name2" value=$modconfig.module}
                {assign var="baz" value="$name2$name"}
                <td align="right" width="165"><strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong></td>
                {if $conf.type=='input'}

                    <td ><input type="text" name="option[{$k}]" value="{$conf.value}" class="inp"/></td>
                    {elseif $conf.type=='password'}
                    <td ><input type="password" name="option[{$k}]" value="{$conf.value}"  class="inp"/></td>
                    {elseif $conf.type=='check'}
                    <td ><input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} style="margin:0px"  /></td>
                    {elseif $conf.type=='select'}
                    <td ><select name="option[{$k}]"  class="inp" >
                            {foreach from=$conf.default item=selectopt}
                                <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                            {/foreach}
                        </select> </td>
                    {elseif $conf.type=='textarea'}
                    <td >
                        <span style="vertical-align:top"><textarea name="option[{$k}]" rows="5" cols="60" style="margin:0px" >{$conf.value}</textarea></span>
                    </td>
                {/if}
            </tr>
        {/foreach}
    </table>
{/if}

{if $server_fields.display.nameservers || $server.type=='Domain'}
    <div class="sectionhead">{$lang.Nameservers}  <a href="" class="editbtn" onclick="$(this).hide();$('#ns-settings').show();return false;">{$lang.expand}</a></div>
    <div id="ns-settings" style="display: none">
        <table cellspacing="0" cellpadding="6" border="0" width="100%" >
            <tbody>
                <tr><td width="165"  align="right"><strong>{$lang.primaryns}</strong></td><td ><input  name="ns1" size="40" value="{$server.ns1}" class="inp"/></td></tr>
                <tr><td  align="right"><strong>{$lang.primarynsip}</strong></td><td ><input  name="ip1" size="20" value="{$server.ip1}" class="inp"/></td></tr>
                <tr class="addns2" {if $server.ns2 || $server.ip2}style="display:none"{/if}><td colspan="2">
                        <a href="" onclick="$('.newns2').show(); $('.addns2').hide(); return false;" style="font-size:11px">{$lang.addnewns}</a>
                    </td></tr>

                <tr class="newns2" {if !$server.ns2 && !$server.ip2}style="display:none"{/if}><td  align="right"><strong>{$lang.secondaryns}</strong></td><td ><input  name="ns2" size="40" value="{$server.ns2}" class="inp"/></td></tr>
                <tr class="newns2" {if !$server.ns2 && !$server.ip2}style="display:none"{/if}><td align="right"><strong>{$lang.secondarynsip}</strong></td><td ><input  name="ip2" size="20" value="{$server.ip2}" class="inp"/></td></tr>
                <tr class="newns2 addns3" {if $server.ns3 || $server.ip3 || (!$server.ns2 && !$server.ip2)}style="display:none"{/if}><td colspan="2">
                        <a href="" onclick="$('.newns3').show(); $('.addns3').hide(); return false;" style="font-size:11px">{$lang.addnewns}</a>
                    </td></tr>

                <tr class="newns3" {if !$server.ns3 && !$server.ip3}style="display:none"{/if}><td align="right" ><strong>{$lang.tertiaryns}</strong></td><td ><input  name="ns3" size="40" value="{$server.ns3}" class="inp"/></td></tr>
                <tr class="newns3" {if !$server.ns3 && !$server.ip3}style="display:none"{/if}><td  align="right"><strong>{$lang.tertiarynsip}</strong></td><td ><input  name="ip3" size="20" value="{$server.ip3}" class="inp"/></td></tr>
                <tr class="newns3 addns4" {if $server.ns4 || $server.ip4  || (!$server.ns2 && !$server.ip2) || (!$server.ns3 && !$server.ip3)}style="display:none"{/if}><td colspan="2">
                        <a href="" onclick="$('.newns4').show(); $('.addns4').hide(); return false;" style="font-size:11px">{$lang.addnewns}</a>
                    </td></tr>

                <tr class="newns4" {if !$server.ns4 && !$server.ip4}style="display:none"{/if}><td align="right" ><strong>{$lang.quatenaryns}</strong></td><td ><input  name="ns4" size="40" value="{$server.ns4}" class="inp"/></td></tr>
                <tr class="newns4" {if !$server.ns4 && !$server.ip4}style="display:none"{/if}><td align="right" ><strong>{$lang.quatenarynsip}</strong></td><td ><input  name="ip4" size="20" value="{$server.ip4}" class="inp"/></td></tr>
            </tbody></table>
    </div>
{/if}
{elseif $action == 'test_connection'}
    {if $result}
        {if $result.result == 'not_supported'}
            {$lang.test_not_supported}
        {else}
            <span style="font-weight: bold; color: {if $result.result == 'Success'}#009900{else}#990000{/if};">
                {if $lang[$result.result]}{$lang[$result.result]}{else}{$result.result}{/if}{if $result.error}: {$result.error}{/if}
            </span>
        {/if}
    {/if}
{elseif $action=='monitor'}
    {if $status}
    <td width="30%"><strong><a href="?cmd=servers&action=edit&id={$status.id}">{$status.name}</a></strong></td>
        {if $config.FTP}<td>{if $status.status.FTP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.SSH}<td>{if $status.status.SSH=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.HTTP}<td>{if $status.status.HTTP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.POP3}<td>{if $status.status.POP3=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.IMAP}<td>{if $status.status.IMAP=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working"/>{/if}</td>{/if}
        {if $config.MYSQL}<td>{if $status.status.MYSQL=='1'}<img src="{$template_dir}img/bullet_green.gif" alt="working"/>{else}<img src="{$template_dir}img/bullet_red.gif" alt="not-working" />{/if}</td>{/if}
        {if $config.LOAD}<td>{if $status.status.LOAD}{$status.status.LOAD}{else}{$lang.Unavailable}{/if}</td>{/if}
        {if $config.UPTIME}<td>{if $status.status.UPTIME}{$status.status.UPTIME}{else}{$lang.Unavailable}{/if}</td>{/if}
    {/if}
{elseif $action=='group'}
    {foreach from=$servers item=serv}
        <tr class="product">
            <td width="20" style="display:none" class="frow_"><input type="radio" {if $serv.default=='1'}checked="checked"{/if} onclick="setDefault({$serv.id},{$group.id})" value="{$server.id}" name="defse"/></td>
            <td><a href="?cmd=servers&action=edit&id={$serv.id}">{if $serv.name}{$serv.name}{else}<em>({$lang.emptyname})</em>{/if}</a> {if $serv.default=='1'} <em class="fs11 editgray">({$lang.default})</em>{/if}</td>
            <td><a href="{if $group.type!='Domain'}?cmd=accounts&filter[server_id]={$serv.id}{else}?cmd=domains&filter[reg_module]={$serv.default_module}{/if}" target="_blank">{$serv.accounts}</a>{if $group.type!='Domain'} / {$serv.max_accounts}{/if}</td>
            <td>{if $group.type!='Domain'}{$serv.ip}{/if}</td>
            <td>{if $group.type!='Domain'}{$serv.host}{/if}</td>
            <td class="fs11" id="testing_result{$serv.id}"></td>
            <td><a href="#" class="editbtn editgray" onclick="return testConnectionList('{$serv.id}', this);">{$lang.test_configuration}</a></td>
            <td><a href="?cmd=servers&action=edit&id={$serv.id}" class="editbtn">{$lang.Edit}</a></td>
            <td><a href="?cmd=servers&make=delete&action=group&group={$group.id}&id={$serv.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteserverconfirm}')" class="delbtn">Delete</a></td>
        </tr>
    {/foreach}
{else}
    {foreach from=$servers item=cat}
        <tr>
            <td ><a href="?cmd=servers&group={$cat.id}&action=group">{$cat.name}</a></td>
            <td >{$cat.modulename}</td>
            <td >{$cat.servers}</td>
            <td ><a href="?cmd=servers&group={$cat.id}&action=group" class="editbtn">{$lang.Edit}</a></td>
            <td ></td>
        </tr>
    {/foreach}
{/if}