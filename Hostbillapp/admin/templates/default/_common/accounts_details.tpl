
<input type="hidden" name="submit" value="1" />


<table width="100%" cellpadding="0" cellspacing="0">
    <tr>
        <td width="50%" valign="top">


            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>

            {if $allowsynchronize}<tr {if $details.manual == '1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if} {if $details.status != 'Pending' || $details.status=='Terminated'}class="livemode"{/if}>
                    <td width="150">{$lang.lastsync}</td>
                    <td>{if $details.synch_date == '0000-00-00 00:00:00'}{$lang.None}{else}{if $details.synch_error}<font style="color:#990000; font-weight: bold; margin-right: 10px;">{$lang.Failed}</font>{else}<font style="color:#006633; font-weight: bold; margin-right: 10px;">{$lang.Successful}</font>{/if}{$details.synch_date|dateformat:$date_format}{/if} <button type="submit" name="synchronize">{$lang.Synchronize}</button></td>
                </tr>
            {/if}
            <tr>
                <td width="150">{$lang.Package}</td>
                <td >
                    <select name="product_id" id="product_id" onchange="sh1xa(this,'{$details.product_id}')">
                        {foreach from=$packages item=package}

                            <option {if $package.id==$details.product_id}selected="selected" def="def"{/if} value="{$package.id}" {if $package.simmilar=='0'}class="h_manumode"{/if} {if $package.simmilar=='0' && $details.manual=='0'}disabled="disabled"{/if}>{$package.catname} - {$package.name}</option>
                        {/foreach}

                    </select>
                    <div style="display:none;padding:3px;" id="upgrade_opt" class="lighterblue">

                        <input type="submit" name="charge_upgrade" value="{$lang.orderupgrade}" {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>
                {if $allowpckgchange}<input type="submit" name="changepackage" onclick="return checkup()" value="{$lang.changepackage}" class="livemode" {if  $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}/>{/if}
            </div>

        </td>
    </tr>



    <tr>
        <td >{$lang.Server} / App</td>
        <td>
            <div  id="serversload">
                <select name="server_id" id="server_id" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}" {if $details.manual != '1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}>
                    <option value="0" {if $server.id=='0'}selected="selected" def="def"{/if}>{$lang.none}</option>
                    {if $servers}
                        {foreach from=$servers item=server}
                            <option value="{$server.id}" {if $details.server_id==$server.id}selected="selected" def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)</option>
                        {/foreach}
                    {else}
                        <option value="0">{$lang.noservers}</option>
                    {/if}
                </select></div>

            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $details.server_name}{$details.server_name}{else}{$lang.none}{/if}</span>

        </td>
    </tr>
    {if !$details_fields && $details.domain!=''}
        <tr>
            <td >{$lang.Hostname}</td>
            <td >
                <input type="text" value="{$details.domain}" name="domain" id="domain_name"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.domain}</span>
                <a style="color: rgb(204, 0, 0);" target="_blank" href="http://{$details.domain}">www</a> <a target="_blank" href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false">whois</a>
            </td>
        </tr>
        {if $details.ptype=='Dedicated' || $details.ptype=='Server'}
            <tr>
                <td >{$lang.Username}</td>
                <td >{if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}<strong style="color: red">{$lang.userdiff}</strong><br />{/if}
                    <input type="text" value="{$details.username}" name="username" size="20" id="username" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                    <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.username}</span>
                </td>
            </tr>
            <tr>
                <td >{$lang.Password}</td>
                <td ><input type="text" value="{$details.password}" name="password" size="20" id="password"/>  {if $allowpasschange}<input type="submit" name="changepassword" value="{$lang.changepassword}" />{/if}</td>
            </tr>
            <tr>
                <td >{$lang.rootpass}</td>
                <td ><input type="text" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/></td>
            </tr>
        {/if}
    {elseif $details_fields}
        {foreach from=$details_fields item=field key=field_key}
            {if $field.name == 'domain'}
                {if $field.type == 'hidden'}
                <input value="{$details.domain}" name="domain" id="domain_name" type="hidden"/>
            {else}
                <tr>
                    <td >{if $details.ptype=='Dedicated' || $details.ptype=='Server'}{$lang.Hostname}{else}{$lang.Domain}{/if}</td>
                    <td >
                        <input type="text" value="{$details.domain}" name="domain" id="domain_name"  class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                        <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.domain}</span>
                        <a style="color: rgb(204, 0, 0);" target="_blank" href="http://{$details.domain}">www</a> <a target="_blank" href="{$system_url}?cmd=checkdomain&action=whois&domain={$details.domain}" onclick="window.open(this.href,'WHOIS','width=500, height=500, scrollbars=1'); return false">whois</a>
                    </td>
                </tr>
            {/if}
        {elseif $field.name == 'username'}
            {if $field.type == 'hidden'}
                <input type="hidden" value="{$details.username}" name="username" size="20" id="username" />
            {else}
                <tr>
                    <td >{$lang.Username}</td>
                    <td >{if $details.user_error == '1' && $details.status != 'Pending' && $details.status != 'Terminated' && $details.manual != '1'}<strong style="color: red">{$lang.userdiff}</strong><br />{/if}

                        <input type="text" value="{$details.username}" name="username" size="20" id="username" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                        <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$details.username}</span>
                    </td>
                </tr>
            {/if}
        {elseif $field.name == 'password'}
            {if $field.type == 'hidden'}
                <input type="hidden" value="{$details.password}" name="password" size="20" id="password"/>
            {else}
                <tr>
                    <td >{$lang.Password}</td>
                    <td ><input type="text" value="{$details.password}" name="password" size="20" id="password"/>  {if $allowpasschange}<input type="submit" name="changepassword" value="{$lang.changepassword}" />{/if}</td>
                </tr>
            {/if}
        {elseif $field.name == 'rootpassword'}
            {if $field.type == 'hidden'}
                <input type="hidden" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/>
            {else}
                <tr>
                    <td >{$lang.rootpass}</td>
                    <td ><input type="text" value="{$details.rootpassword}" name="rootpassword" size="20" id="password"/></td>
                </tr>
            {/if}
        {elseif $field.name}

            {if $field.type == 'hidden'}
                <input type="hidden" value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}" name="extra_details[{$field_key}]" />
            {else}
                <tr>
                    <td>{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}</td>
                    <td>
                        {if $field.type == 'input'}
                            <input type="text" value="{if $details.extra_details.$field_key}{$details.extra_details.$field_key|escape:'html':'utf-8'}{/if}" name="extra_details[{$field_key}]" size="20" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>

                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $details.extra_details.$field_key}{$details.extra_details.$field_key}{/if}</span>
                        {elseif $field.type == 'check'}

                        {/if}
                    </td>
                </tr>
            {/if}
        {/if}
    {/foreach}
{/if}



{if ($details.status=='Active' || $details.status=='Suspended') && $custom.GetStatus}
    <tr>
        <td >{$lang.Status}</td>
        <td ><a href="" onclick="getStatus({$details.id}, this); return false;">获取状态</a></td>
    </tr>
{/if}
{literal}
    <script type="text/javascript">
        function getStatus(id, elem) {
            var field=$(elem).parent();
            $(field).html('{/literal}{$lang.Loading}...{literal}');
            ajax_update('?cmd=accounts&action=getstatus&id='+id,{},field);
            return false;
        }
    </script>
{/literal}

<tr {if !$allowterminate && !$allowsuspend && !$allowcreate && !$allowunsuspend}class="manumode" {if $details.manual!='1'}style="display:none"{/if}{/if}>
    <td >{$lang.availactions}</td>
    <td >


        <input type="submit" onclick="$('body').addLoader();"  name="create" value="Create" {if !$allowcreate}class="manumode"{/if} {if !$allowcreate && $details.manual!='1'}style="display:none"{/if}/>

        <input type="submit"  name="suspend" value="Suspend" {if !$allowsuspend} class="manumode"{/if} {if !$allowsuspend && $details.manual!='1'}style="display:none"{/if}  onclick="return confirm('{$lang.suspendconfirm}')"/>
        <input type="submit" name="unsuspend" value="Unsuspend" {if !$allowunsuspend} class="manumode"{/if} {if !$allowunsuspend && $details.manual!='1'}style="display:none"{/if}/>

        <input type="submit" name="terminate"  value="Terminate" {if !$allowterminate}class="manumode"{/if} {if !$allowterminate && $details.manual!='1'}style="display:none;color:#ff0000;"{else} style="color:#ff0000"{/if} onclick="return confirm('{$lang.terminateconfirm}')"/>


        <input type="submit" name="renewal"  value="Renewal" {if !$allowrenewal}style="display:none"{/if}/>


        {foreach from=$custom item=btn}
            {if $btn!='GetOsTemplates' && $btn!='GetNodes' && $btn!='GetStatus' && $btn!='restoreBackup' && $btn!='createBackup' && $btn!='deleteBackup'}
                <input type="submit" name="customfn" value="{$btn}" class="{if $details.status!='Active'}manumode{/if} {if $loadable[$btn]}toLoad{/if}" {if $details.status!='Active' && $details.manual!='1'}style="display:none"{/if} />
            {/if}
        {/foreach}

    </td>
</tr>
<tr {if !$allowautosuspend}style="display:none"{/if}>
    <td>{$lang.overridesus}
    </td>
    <td><input type="checkbox"  name="autosuspend" value="1" {if $details.autosuspend==1}checked="checked"{/if} onclick="autosus(this)" style="float:left"/>
        <div id="autosuspend_date" {if $details.autosuspend!=1}style="display:none"{/if} >
            <input  name="autosuspend_date" value="{$details.autosuspend_date|dateformat:$date_format}" class="haspicker" size="12"/></div>
    </td>
</tr>
<tr><td>{$lang.sendacce}</td>
    <td><select name="mail_id" id="mail_id">
            {foreach from=$product_emails item=send_email}
                <option value="{$send_email.id}">{$send_email.tplname}</option>
            {/foreach}
            <option value="custom" style="font-weight:bold">{$lang.newmess}</option>
        </select>
        <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"/>
    </td>
</tr>
</tbody>
</table>

</td>
<td width="50%" valign="top">
    {if $details.status!='Pending'}
        <strong>{$lang.automationqueue}</strong>
        <div style="margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#F5F9FF;padding:10px;" class="fs11">
            <div id="autoqueue" style="max-height:100px;overflow:auto">{$lang.Loading}
                <script type="text/javascript">
                    appendLoader('getAccQueue');
                    function getAccQueue() {literal}{{/literal}
                        ajax_update("?cmd=accounts&action=getqueue&id={$details.id}",false,'#autoqueue');
                {literal}}{/literal}
            </script></div>
    </div>
    <div class="fs11" style="text-align: right">
        <div class="left">
            <a href="?cmd=services&action=product&id={$details.product_id}&picked_tab=2" target="_blank">{$lang.schedulenewtask}</a>
        </div>
        <div class="right">{$lang.currservertime} {$currentt|dateformat:$date_format}</div>
        <div class="clear"></div></div>
    {/if}
</td>

</tr>
</table>

{if $details.custom}
    <input type="hidden" name="arecustom" value="1"/>
    <table cellspacing="2" cellpadding="3" border="0" width="100%" >
        {foreach from=$details.custom item=c key=kk}
            {if $c.items}
                <tr>
                    <td style="vertical-align: top" width="150" >{$c.name} </td>
                    <td>
                        {include file=$c.configtemplates.accounts currency=$details.currency forcerecalc=true}
                    </td>
                </tr>
            {/if}
        {/foreach}

    </table>
{/if}

