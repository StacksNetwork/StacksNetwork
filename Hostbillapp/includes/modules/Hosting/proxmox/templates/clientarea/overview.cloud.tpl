{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3>{$lang.cloudlabel1}</h3>
<div class="clear"></div>
</div>
<div class="content-bar">

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="tonapp" style="margin:10px 0px;">

    <thead>
        <tr>
            <th width="66"></th>
            <th>{$lang.hostname}</th>
            <th width="70">{$lang.diskspace}</th>
            <th width="70">{$lang.memory}</th>
            <th width="70">Cores</th>
            <th width="70">Uptime</th>
            <th width="60"></th>
        </tr>
    </thead>
    <tbody id="updater">
        {if $MyVMs}
        {foreach from=$MyVMs item=vm name=foo}
        <tr >
             <td >{if $vm.built=='true'}{if $vm.power=='true'}
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweroff&vpsid={$vm.id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_on" onclick="return powerchange(this,'Are you sure you want to Power OFF this VM?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

		{else}
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron&vpsid={$vm.id}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this,'Are you sure you want to Power ON this VM?');"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

		{/if}{else}
                <a  class="iphone_switch_container iphone_switch_container_pending"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

                 {/if}

            </td>
            <td><a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}&vpsdo=vmdetails" ><b>{$vm.hostname}</b></a> {if $vm.ipam}{foreach from=$vm.ipam item=ip name=f}{$ip} {if !$smarty.foreach.f.last},{/if}{/foreach}{/if}</td>
            <td>{$vm.disk} GB</td>
            <td>{$vm.memory} MB</td>
            <td>{$vm.cpu}</td>
            <td>{$vm.uptime}</td>
            <td class="fs11">
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}&vpsdo=vmdetails"  class="ico ico_wrench" title="{$lang.edit}">{$lang.edit}</a>
                <a  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=destroy&vpsid={$vm.id}&security_token={$security_token}" onclick="return  confirm('{$lang.sure_to_destroy}?')" class="ico ico_cross" title="{$lang.delete}">{$lang.delete}</a>
            </td>
        </tr>
        {/foreach}
        {else}
        <tr >
            <td colspan="7" align="center">{$lang.nomachinesnote}, <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=createvm">{$lang.addservernote}</a>.</td>
        </tr>

        {/if}
    </tbody>

</table>

</div>
{include file="`$onappdir`footer.cloud.tpl"}