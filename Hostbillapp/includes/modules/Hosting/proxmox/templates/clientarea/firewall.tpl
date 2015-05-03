
									{if $firewall.interfaces}
										{foreach from=$firewall.interfaces item=int}
<div style="margin:5px 0px 10px">
    <table border="0" cellspacing="0" cellpadding="3">
        <tr><td>{$lang.firewallrule} ({$int.label}): </td>
            <td style="padding-left:10px"><div id="frule_{$int.label}"><b>{$int.default}</b> <a href="#" onclick="$('#frule_{$int.label}').hide();$('#frule_{$int.label}_e').show();return false" class="fs11">{$lang.edit}</a></div>
                <div  id="frule_{$int.label}_e" style="display:none">
                    <form action="" method="post">
                        <input type="hidden" name="do" value="applydefaults" />
                        <input type="hidden" name="network_id" value="{$int.id}"/>
                        <select name="default_firewall_rule" style="font-size:11px;width:auto">
                            <option {if $int.default=='{$lang.ACCEPT}'}selected="selected"{/if}>{$lang.ACCEPT}</option>
                            <option {if $int.default!='{$lang.ACCEPT}'}selected="selected"{/if}>{$lang.DROP}</option>
                        </select>
                        <input type="submit" value="{$lang.savechanges}" style="font-weight:bold;font-size:11px;padding:2px 3px;" class="blue" />
                    {securitytoken}</form>
                </div>
            </td></tr>

    </table>
</div>
										{/foreach}
									{/if}


									{if $ruleedit}
<form method="post" action="" id="formsaverule">
    <input type="hidden" value="editrule" name="do" />
									{/if}
    <table class="data-table backups-list"  width="100%" cellspacing=0>
        <thead>
            <tr>
                <td>{$lang.rule} #</td>
                <td>{$lang.srcaddr}</td>
                <td>{$lang.destport}</td>
                <td>{$lang.protocol}</td>
                <td>{$lang.command}</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </thead>
        {foreach item=rule from=$firewall.rules name=ruleloop}
										{if $ruleedit==$rule._id}
        <tr>
            <td><input type="hidden" name="rule" value="{$rule._id}"/>
                <select name="network_interface_id" style="width:auto">
													{foreach from=$firewall.interfaces item=eth}
                    <option value="{$eth.id}" {if $eth.id==$rule._network_interface_id}selected="selected"{/if}>{$eth.label}</option>
													{/foreach}
                </select>
            </td>
            <td><input name="address" value="{$rule._address}" style="width:auto"/></td>
            <td><input name="port" value="{$rule._port}" size="4" style="width:auto"/></td>
            <td><select name="protocol" style="width:auto">
                    <option {if $rule._protocol=='TCP'}selected="selected"{/if}>TCP</option>
                    <option  {if $rule._protocol=='UDP'}selected="selected"{/if}>UDP</option>
                </select></td>
            <td><select name="command" style="width:auto">
                    <option {if $rule._command=='{$lang.ACCEPT}'}selected="selected"{/if}>{$lang.ACCEPT}</option>
                    <option  {if $rule._command=='{$lang.DROP}'}selected="selected"{/if}>{$lang.DROP}</option>
                </select></td>
            <td colspan="2"  style="text-align:right"><a href="#" class="small_control small_save fs11" onclick="$('#formsaverule').submit(); return false" style="font-size:12px">{$lang.savechanges}</a>
            </td>
        </tr>
										{else}
        <tr>
            <td>{$rule._position} ({$rule.network})</td>
            <td>{$rule._address}</td>
            <td>{$rule._port}</td>
            <td>{$rule._protocol}</td>
            <td>{$rule._command}</td>
            <td>
											{if !$smarty.foreach.ruleloop.first}<a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&rule={$rule._id}&do=move&dir=up&security_token={$security_token}" class="small_control small_up" > </a>{/if}
											{if !$smarty.foreach.ruleloop.last}<a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&rule={$rule._id}&do=move&dir=down&security_token={$security_token}" class="small_control small_down" > </a>{/if}
            </td>
            <td  style="text-align:right">
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&ruleedit={$rule._id}" class="small_control small_pencil fs11" >{$lang.edit}</a>
                <a class="small_control small_delete fs11" onclick="return  confirm('Are you sure you want to remove this rule')" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}&rule={$rule._id}&do=ruledrop&security_token={$security_token}">{$lang.remove}</a>
            </td>
        </tr>
										{/if}
        {foreachelse}
        <tr>
            <td colspan="7">{$lang.nothing}</td>
        </tr>
        {/foreach}
    </table>
									{if $ruleedit}
{securitytoken}</form>
									{/if}

<div class="right" style="margin:5px;"><a style="font-size:12px" onclick="$('#formapplyrules').submit(); return false" class="small_control small_save" href="#"><b>{$lang.applyfirewall}</b></a></div>
<div class="clear"></div>

<form action="" method="post" id="formapplyrules">
    <input type="hidden" name="do" value="apply" />
{securitytoken}</form>

<form action="" method="post" id='formaddrule'>
    <input type="hidden" name="do" value="addrule"/>

    <br/><h3> {$lang.addrule}: </h3>
    <table class="data-table backups-list"  width="100%" cellspacing="0" style="border-top:solid 1px #DDDDDD;">

        <tr>
            <td>
                <b>{$lang.interface}:</b><br/>
                <select name="network_interface_id" style="width:auto">
													{foreach from=$firewall.interfaces item=eth}
                    <option value="{$eth.id}" >{$eth.label}</option>
													{/foreach}
                </select>
            </td>
            <td>
                <b>{$lang.addresss}:</b><br/>
                <input name="address" value="" style="width:auto" /></td>
            <td>
                <b>{$lang.port}:</b><br/>
                <input name="port" value="" size="4" style="width:auto" /></td>
            <td>
                <b>{$lang.protocol}:</b><br/>
                <select name="protocol" style="width:auto">
                    <option selected="selected">TCP</option>
                    <option  selected="selected">UDP</option>
                </select></td>
            <td>
                <b>{$lang.command}:</b><br/>
                <select name="command" style="width:auto">
                    <option >{$lang.ACCEPT}</option>
                    <option  >{$lang.DROP}</option>
                </select></td>
                <td colspan="2" align="center" valign="middle">

                <input type="submit" value="{$lang.submit}" style="font-weight:bold;padding:2px 3px;"  class="blue" />
            </td>
        </tr>


    </table>
{securitytoken}</form>