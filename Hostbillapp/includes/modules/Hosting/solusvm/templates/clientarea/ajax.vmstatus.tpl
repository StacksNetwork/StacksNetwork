{if $VMDetails.status=='online'}
    <a href="?cmd=clientarea&action=services&service={$service_id}&vpsdo=shutdown&vpsid={$vpsid}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_on" onclick="return powerchange(this,'Are you sure you want to Power OFF this VM?');">
        <img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" />
    </a>
{else}
    <a href="?cmd=clientarea&action=services&service={$service_id}&vpsdo=startup&vpsid={$vpsid}&security_token={$security_token}" class="iphone_switch_container iphone_switch_container_off" onclick="return powerchange(this,'Are you sure you want to Power ON this VM?');">
        <img src="includes/types/onappcloud/images/iphone_switch_container_off.png" alt="" />
    </a>
{/if}