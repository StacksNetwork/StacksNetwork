<link media="all" type="text/css" rel="stylesheet" href="templates/common/cloudhosting/styles.css" />
<script type="text/javascript" src="templates/common/cloudhosting/js/scripts.js"></script>

{if $widget.appendtpl }
    {include file=$widget.appendtpl}
{/if}
<div id="nav-onapp">
    {if $vpsid}
    <h1 class="left os-logo {if $s_vm}{$s_vm.distro}{/if}">{$s_vm.hostname}</h1>
    {if $provisioning_type!='single'}
    <a href="?cmd=clientarea&action=services&service={$service.id}" class="left apeded">&laquo; {$lang.allservers}</a>
    {/if}
     <ul class="level-1">
        <li class="{if $vmsection=='vmdetails'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><span class="list-servers">{$lang.Overview}</span></a></li>
        {if $o_sections.o_network}<li class="{if $vmsection=='network'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=interfaces&vpsid={$vpsid}"><span class="resources">{$lang.networkzone}</span></a></li>{/if}
         {if $o_sections.o_storage}<li class="{if $vmsection=='storage'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=disks&vpsid={$vpsid}"><span class="billing">{$lang.storage}</span></a></li>{/if}
        <li class="{if $vmsection=='usage'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=usage&vpsid={$vpsid}"><span class="addserver">{$lang.Usage}</span></a></li>
        {if $provisioning_type=='single'}<li class="{if $vmsection=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing&vpsid={$vpsid}"><span class="addserver">{$lang.Billing}</span></a></li>{/if}
    </ul>
    {else}
    <h1 class="left os-logo">{$service.name}</h1>
    <ul class="level-1">
        {if $provisioning_type=='cloud'}
            <li class="{if !$vpsdo}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}"><span class="list-servers">{$lang.ListServers}</span></a></li>
            {/if}
        <li class="{if $vmsection=='resources'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resources"><span class="resources">{$lang.reslabel}</span></a></li>
        <li class="{if $vpsdo=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing"><span class="billing">{$lang.Billing}</span></a></li>
        {if $provisioning_type=='cloud'}
        <li class="{if $vpsdo=='createvm'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=createvm"><span class="addserver">{$lang.addservernote}</span></a></li>
        {/if}
    </ul>
    {/if}  <div class="clear"></div>
</div>
<div class="clear"></div>
<div id="content-cloud">
