<link media="all" type="text/css" rel="stylesheet" href="templates/common/cloudhosting/styles.css" />
<script type="text/javascript" src="templates/common/cloudhosting/js/scripts.js"></script>

{if $widget.appendtpl }
    {include file=$widget.appendtpl}
{/if}
<div id="nav-onapp">
    <h1 class="left os-logo {if $s_vm}{$s_vm.distro}{/if}">{$s_vm.hostname}</h1>
    <ul class="level-1">
        <li class="{if $vmsection=='vmdetails'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}"><span class="list-servers">{$lang.Overview}</span></a></li>
        <li class="{if $vmsection=='billing'}current-menu-item{/if}"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=billing&vpsid={$vpsid}"><span class="addserver">{$lang.Billing}</span></a></li>
    </ul>
    <div class="clear"></div>
</div>
<div class="clear"></div>
<div id="content-cloud">
