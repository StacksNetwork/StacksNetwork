<div id="lock" {if $VMDetails.locked}style="display:block"{/if}>
    <img src="includes/types/onappcloud/images/ajax-loader.gif" alt=""> {$lang.server_performing_task} 
    <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=vmdetails&vpsid={$vpsid}">
        <b>{$lang.refresh}</b>
    </a>
</div>
<ul id="vm-menu" class="right">
    {if $VMDetails.status=='online'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=console&vpsid={$vpsid}">
                <img alt="Console" src="templates/common/cloudhosting/images/icons/24_terminal.png"><br>{$lang.console}
            </a>
        </li>
        {if $o_sections.o_reboot}
            <li>
                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reboot&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('{$lang.sure_to_reboot}?');">
                    <img alt="Reboot" src="templates/common/cloudhosting/images/icons/24_arrow-circle.png"><br>{$lang.reboot}
                </a>
            </li>
        {/if}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=shutdown&vpsid={$vpsid}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to shutdown this VM?');">
                <img alt="Shutdown" src="templates/common/cloudhosting/images/icons/poweroff.png"><br>{$lang.Shutdown}
            </a>
        </li>
    {else}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=startup&vpsid={$vpsid}&security_token={$security_token}" >
                <img alt="Shutdown" src="templates/common/cloudhosting/images/icons/poweroff.png"><br>{$lang.Startup}
            </a>
        </li>
    {/if}
    {if $o_sections.o_rebuild &&  $VMDetails.type!='xenhvm'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=reinstall&vpsid={$vpsid}&security_token={$security_token}" >
                <img alt="Rebuild" src="includes/types/onappcloud/images/icons/24_blueprint.png"><br>{$lang.rebuild}
            </a>
        </li>
    {/if}
    {if $provisioning_type=='single'}
        <li>
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=upgrade">
                <img alt="Scale" src="templates/common/cloudhosting/images/icons/24_equalizer.png"><br>{$lang.upgrade1}
            </a>
        </li>
    {/if}
    <li>
        <a {if $provisioning_type=='single'}href="{$ca_url}clientarea&action=services&service={$service.id}&cid={$service.category_id}&cancel"{else} href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=destroy&vpsid={$vpsid}&security_token={$security_token}" onclick="return  confirm('{$lang.sure_to_destroy}?')" {/if}>
            <img alt="Delete" src="templates/common/cloudhosting/images/icons/24_cross.png"><br>{if $provisioning_type=='single'}{$lang.cancelvps}{else}{$lang.delete}{/if}
        </a>
    </li>
    {foreach from=$widgets item=widg key=wkey}
        {if $provisioning_type!='single' && $widg.name == 'solus_pass'}
            {continue}
        {/if}
        <li class="widget">
            <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}">
                <img src="{$widg.config.bigimg}" alt=""><br/>{if $lang[$widg.name]}{$lang[$widg.name]}{elseif $widg.fullname}{$widg.fullname}{else}{$widg.name}{/if}
            </a>
        </li>
    {/foreach}
</ul>
<div class="clear"></div>
{if !$VMDetails.locked || $VMDetails.locked == 'refresh'}
    {literal}
        <script type="text/javascript">
            var wx=setTimeout(function(){
                $.post('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}{literal}',{vpsdo:'vmactions'},function(data){
                    var r=parse_response(data);
                    if(r)
                        $('#lockable-vm-menu').html(r);
                });
            }, 4000);
        </script>
    {/literal}
{/if}