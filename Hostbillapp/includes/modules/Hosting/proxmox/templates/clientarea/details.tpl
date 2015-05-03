<div class="header-bar">
    <h3 class="vmdetails hasicon">{$lang.servdetails}</h3>
</div>
<div class="content-bar" >
   <div class="right" id="lockable-vm-menu"> {include file="`$onappdir`ajax.vmactions.tpl"} </div>
    
    <div class="clear"></div>

    <table border="0" cellspacing="0" cellpadding="0" width="100%">
        <tr>
            <td width="50%" style="padding-right:10px;">
                <table cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    <tr>
                        <td width="120">
                            <b>{$lang.status}</b>
                        </td>
                        <td style="padding:8px 5px 9px;">
                            {if $VMDetails.locked=='false'}
                                {if $VMDetails.power=='true'}
                                <a {if $o_sections.o_startstop}href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweroff&vpsid={$VMDetails.id}&security_token={$security_token}" onclick="return powerchange(this,'Are you sure you want to Power OFF this VM?');"{else}href="#" onclick="return false;"{/if} class="iphone_switch_container iphone_switch_container_on" ><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>

                                {else}
                                <a {if $o_sections.o_startstop}href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=poweron&vpsid={$VMDetails.id}&security_token={$security_token}" onclick="return powerchange(this,'Are you sure you want to Power ON this VM?');"{else}href="#"  onclick="return false;"{/if} class="iphone_switch_container iphone_switch_container_off" ><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>
                                
                                {/if}
                            {else}
                                 <a  class="iphone_switch_container iphone_switch_container_pending left"><img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" /></a>
                                 <a class="fs11" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$VMDetails.id}" style="padding-left:10px;">{$lang.refresh}</a>
                             {/if}

                            </td>
                    </tr>
                    <tr>
                        <td ><b>{$lang.hostname}</b> </td>
                        <td >{$VMDetails.hostname}</td>
                    </tr>
                   {if $VMDetails.ipam} <tr>
                        <td ><b>IP</b> </td>
                        <td >{foreach from=$VMDetails.ipam item=ip name=f}{$ip} {if !$smarty.foreach.f.last},{/if}{/foreach}</td>
                    </tr> {/if}

                    <tr class="lst">
                        <td ><b>Uptime</b> </td>
                        <td >{$VMDetails.uptime}</td>
                    </tr>
                </table>
            </td>
            <td width="50%" style="padding-left:10px;">
                <table  cellpadding="0" cellspacing="0" width="100%" class="ttable">
                    

                    <tr>
                        <td  >
                            <b>{$lang.disk_limit}</b>
                        </td>
                        <td >
                            {$VMDetails.disk} GB

                        </td>
                    </tr>
                    <tr>
                        <td >
                            <b>{$lang.memory}</b>
                        </td>
                        <td >
                            {$VMDetails.memory} MB
                        </td>
                    </tr>

                    <tr class="lst">
                        <td  >
                            <b>{$lang.cpucores}</b>
                        </td>
                        <td valign="top" style="">
                            {$VMDetails.cpu} CPU(s)

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


</div>