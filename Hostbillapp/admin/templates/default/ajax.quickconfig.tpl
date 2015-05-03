{if $qc_features.admin_pass}
<div class="tabb" {if $qc_page != 'Admin_Pass'}style="display:none"{/if}>
    <div class="blu" style="padding: 10px 30px;">
        {if $qc_passchanged}<strong class="clientmsg">{$lang.passwordchanged}</strong>{else}
        <form action="" method="post">
            <table cellspacing="0" cellpadding="3" border="0">
                <tr><td colspan="2" align="center"><p style="font-weight: bold">{$lang.changeadminpass}</p></td></tr>
                <tr><td>{$lang.Password}:</td><td><input type="password" autocomplete="off" name="password1" value="" /></td></tr>
                <tr><td>{$lang.repeatpass}:</td><td><input type="password" autocomplete="off" name="password2" value="" /></td></tr>
                <tr><td colspan="2" align="center"><input type="button" id="change_pass" value="{$lang.changepassword}" style="width: 150px; font-weight: bold;" /></td></tr>
            </table>
        {securitytoken}</form>
        {/if}
    </div>
</div>
{/if}
{if $qc_features.payment}
<div class="tabb" {if $qc_page != 'Payment'}style="display:none"{/if}>
    <div class="blu" style="padding: 10px 30px;">
    {if $qc_features.payment.avail}
    <form action="" method="post">
        <strong>{$lang.activatepaymod}:</strong>  &nbsp;<select name="modulename">
            {foreach from=$qc_features.payment.avail item=a}
                <option value="{$a.filename}">{$a.name} {$a.version}</option>
            {/foreach}
        </select>&nbsp;
        <input type="hidden" name="type" value="Payment" />
        <input type="button" value="{$lang.Activate}" class="activate_item" style="width: 100px; font-weight: bold;" />
    {securitytoken}</form>
    {else}
        {$lang.nomodulestoact}
    {/if}
    </div>
    <div>
        {if $qc_features.payment.active}

                    {foreach from=$qc_features.payment.active item=b}
                     <form name="" action="" method="post" style="text-align:right;">
                        <input type="hidden" name="id" value="{$b.id}" />
                        <input type="hidden" name="type" value="Payment" />
                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike"><tr>

                    <td>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="gnoborder">
                            <tr>
                                <th style="padding: 5px" width="250"><strong style="font-size: 14px">{$b.modname} </strong>&nbsp;<a href="" class="deactivatemod" onclick="return false" style="color: red; font-weight: normal;">{$lang.Deactivate}</a>
                                </th><th>{if !empty($b.config)}<a href="" style="font-weight: normal;" onclick="return false" class="getconfig">{if $qc_openconfig == $b.id && $qc_page == 'Payment'}{$lang.hideconfig}{else}{$lang.showconfig}{/if}</a>&nbsp;&nbsp;&nbsp;<input type="button" value="{$lang.savechanges}" class="savemod payconfig_{$b.id}{if $qc_openconfig == $b.id && $qc_page == 'Payment'} shown{/if}" style="padding: 1px !important; font-size:11px !important; {if $qc_openconfig != $b.id || $qc_page != 'Payment'}display:none;{/if}" />{/if}</th>
                            </tr>
                            <tbody class="payconfig_{$b.id} {if $qc_openconfig == $b.id && $qc_page == 'Payment'}shown"{else}" style="display: none"{/if}>
                                {if !empty($b.config)}
                                {foreach from=$b.config item=conf key=k name=checker}
                                    {if $smarty.foreach.checker.iteration%2=='1'}
                                        <tr class="systememail">
                                    {/if}
                                        <td>
                                        {assign var="name" value=$k}
                                        {assign var="name2" value=$b.module}
                                        {assign var="baz" value="$name2$name"}
                                        {$lang.$baz}:
                                        {if $conf.type=='input'}
                                                <input name="option[{$k}]" value="{$conf.value}" />
                                        {elseif $conf.type=='password'}
                                                <input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}" />
                                        {elseif $conf.type=='check'}
                                                <input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} />
                                        {elseif $conf.type=='select'}
                                                <select name="option[{$k}]">
                                                {foreach from=$conf.default item=selectopt}
                                                        <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                                {/foreach}
                                                </select>
                                        {elseif $conf.type=='textarea'}
                                                <span><textarea name="option[{$k}]" rows="5" cols="60">{$conf.value}</textarea></span>
                                        {/if}
                                        </td>
                                    {if $smarty.foreach.checker.iteration%2=='0'}
                                        </tr>
                                    {/if}
                                {/foreach}
                            {/if}
            {if $b.description}<tr  class="systememail"><td colspan="2" style="font-size:11px">{$b.description}</td></tr>{/if}

                            </tbody>
                            </table>
                    </td>

                    </tr></table>

              {securitytoken}</form>
            {/foreach}
            {/if}
    </div>
</div>
{/if}


{if $qc_features.domain}
<div class="tabb" {if $qc_page != 'Domain'}style="display:none"{/if}>
    <div class="blu" style="padding: 10px 30px;">
    {if $qc_features.domain.avail}
    <form action="" method="post">
        <strong>{$lang.activatedommod}:</strong>  &nbsp;<select name="modulename">
            {foreach from=$qc_features.domain.avail item=a}
                <option value="{$a.filename}">{$a.name} {$a.version}</option>
            {/foreach}
        </select>&nbsp;
        <input type="hidden" name="type" value="Domain" />
        <input type="button" value="{$lang.Activate}" class="activate_item" style="width: 100px; font-weight: bold;" />
    {securitytoken}</form>
    {else}
        {$lang.nomodulestoact}
    {/if}
    </div>
    <div>
        {if $qc_features.domain.active}

                    {foreach from=$qc_features.domain.active item=b}
                     <form name="" action="" method="post" style="text-align:right;">
                        <input type="hidden" name="id" value="{$b.id}" />
                        <input type="hidden" name="type" value="Domain" />

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike"><tr>

                    <td>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="gnoborder">
                            <tr>
                                <th style="padding: 5px" width="250"><strong style="font-size: 14px">{$b.modname} </strong>&nbsp;<a href="" class="deactivatemod" onclick="return false" style="color: red; font-weight: normal;">{$lang.Deactivate}</a>
                                </th><th>{if !empty($b.config)}<a href="" style="font-weight: normal;" onclick="return false" class="getconfig">{if $qc_openconfig == $b.id && $qc_page == 'Domain'}{$lang.hideconfig}{else}{$lang.showconfig}{/if}</a>&nbsp;&nbsp;&nbsp;<input type="button" value="{$lang.savechanges}" class="savemod domconfig_{$b.id}{if $qc_openconfig == $b.id && $qc_page == 'Domain'} shown{/if}" style="padding: 1px !important; font-size:11px !important; {if $qc_openconfig != $b.id || $qc_page != 'Domain'}display:none;{/if}" />{/if}</th>
                            </tr>
                            <tbody class="domconfig_{$b.id} {if $qc_openconfig == $b.id && $qc_page == 'Domain'}shown"{else}" style="display: none"{/if}>
                                {if !empty($b.config)}
                                {foreach from=$b.config item=conf key=k name=checker}
                                    {if $smarty.foreach.checker.iteration%2=='1'}
                                        <tr class="systememail">
                                    {/if}
                                        <td>
                                        {assign var="name" value=$k}
                                        {assign var="name2" value=$b.module}
                                        {assign var="baz" value="$name2$name"}
                                        {$lang.$baz}:
                                        {if $conf.type=='input'}
                                                <input name="option[{$k}]" value="{$conf.value}" />
                                        {elseif $conf.type=='password'}
                                                <input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}" />
                                        {elseif $conf.type=='check'}
                                                <input name="option[{$k}]" type="checkbox" value="1" {if $conf.value == "1"}checked="checked"{/if} />
                                        {elseif $conf.type=='select'}
                                                <select name="option[{$k}]">
                                                {foreach from=$conf.default item=selectopt}
                                                        <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                                {/foreach}
                                                </select>
                                        {elseif $conf.type=='textarea'}
                                                <span><textarea name="option[{$k}]" rows="5" cols="60">{$conf.value}</textarea></span>
                                        {/if}
                                        </td>
                                    {if $smarty.foreach.checker.iteration%2=='0'}
                                        </tr>
                                    {/if}
                                {/foreach}
                            {/if}
            {if $b.description}<tr  class="systememail"><td colspan="2" style="font-size:11px">{$b.description}</td></tr>{/if}

                            </tbody>
                            </table>
                    </td>

                    </tr></table>

              {securitytoken}</form>
            {/foreach}
            {/if}
    </div>
</div>
{/if}

{if $qc_features.servers}
<div class="tabb" {if $qc_page != 'Servers'}style="display:none"{/if}>

    <div class="blu" style="padding: 10px 30px;">
    <form action="" method="post">
        <strong>{$lang.addnewserver}</strong>&nbsp;<input name="name" size="40" class="inp" value="Name" />
        <input type="hidden" name="type" value="Servers" />
        <input type="button" value="{$lang.Activate}" class="activate_item" style="width: 100px; font-weight: bold;" />
    {securitytoken}</form>
    </div>

    <div>
        {if $qc_features.servers.servers}

                    {foreach from=$qc_features.servers.servers item=b}
                     <form name="" action="" method="post" style="text-align:right;">
                        <input type="hidden" name="id" value="{$b.id}" />
                        <input type="hidden" name="type" value="Servers" />

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike"><tr>

                    <td>
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="gnoborder">
                            <tr>
                                <th style="padding: 5px" colspan="2" width="30%"><strong style="font-size: 14px">{$b.name} </strong><a href="" class="removeserver" onclick="return false" style="color: red; font-weight: normal;">{$lang.removeserver}</a>
                                </th><th colspan="2"><a href="" style="font-weight: normal;" onclick="return false" class="getconfig">{if $qc_openconfig == $b.id && $qc_page == 'Servers'}{$lang.hideconfig}{else}{$lang.showconfig}{/if}</a>&nbsp;&nbsp;&nbsp;<input type="button" value="{$lang.savechanges}" class="saveserver srvconfig_{$b.id}{if $qc_openconfig == $b.id && $qc_page == 'Servers'} shown{/if}" style="padding: 1px !important; font-size:11px !important; {if $qc_openconfig != $b.id || $qc_page != 'Servers'}display:none;{/if}" /></th>
                            </tr>
                            <tbody class="srvconfig_{$b.id} {if $qc_openconfig == $b.id && $qc_page == 'Servers'}shown"{else}" style="display: none"{/if}>

                                <tr>
                                    <td>{$lang.Name}:</td><td><input  name="server[name]" size="20" value="{$b.name}" class="inp"/></td>
                                    <td width="80">{$lang.Type}:</td><td>
                                        {if $qc_features.servers.modules}
                                        <select name="server[default_module]" class="inp" onchange="{literal}if($(this).val() == '{/literal}{$qc_features.servers.cpmod}{literal}') $('.en_ah{/literal}{$b.id}{literal}').show(); else {$('.en_ah{/literal}{$b.id}{literal}').hide(); $('.accesshash{/literal}{$b.id}{literal}').hide();}{/literal} ">
                                            
                                                {foreach from=$qc_features.servers.modules item=m}
                                                    <option value='{if $m.id==-1}{$m.filename}{else}{$m.id}{/if}'  {if $m.id == $b.default_module}selected="selected"{/if}>{$m.module}</option>
                                                {/foreach}
                                      </select>
                                      {else}
                                        <input type="hidden" name="server[default_module]" value="0" />
                                        {$lang.none} <em style="font-size:11px;">({$lang.addhostmod1st})</em>
                                      {/if}</td>

                                      </tr>
                                <tr>
                                    <td>IP:</td><td ><input  name="server[ip]" size="20" class="inp" value="{$b.ip}"/></td>
                                    <td>{$lang.Hostname}:</td><td><input  name="server[host]" size="20" class="inp" value="{$b.host}"/></td>
                                </tr>
                                <tr>
                                    <td>{$lang.Username}:</td><td ><input  name="server[username]" size="20" class="inp" value="{$b.username}"/></td>
                                    <td>{$lang.Password}:</td><td><input type="password" autocomplete="off"  name="server[password]" size="20" class="inp" value="{$b.password}"/> <a class="en_ah{$b.id}" onclick="{literal}$(this).hide(); $('.accesshash{/literal}{$b.id}{literal}').show(); return false;{/literal}" {if $b.default_module != $qc_features.servers.cpmod || $b.hash != ''}style="display: none"{/if}>{$lang.usehash}</a></td></tr></td>
                                </tr>
                                <tr class="accesshash{$b.id}" {if  $qc_features.servers.cpmod == 0 || $b.default_module != $qc_features.servers.cpmod || $b.hash == ''}style="display: none"{/if}>
                                    <td style="vertical-align: top;">{$lang.accesshash}:</td><td colspan="3"><textarea rows="5" cols="30" name="server[hash]">{$b.hash}</textarea></td>
                                </tr>
                            </tbody>
                            </table>
                        </td>

                        </tr></table>

                  {securitytoken}</form>
                  {/foreach}
            {/if}
    </div>
</div>
{/if}
{literal}
    <script type="text/javascript">
        bindQConfigEvents();
    </script>
{/literal}