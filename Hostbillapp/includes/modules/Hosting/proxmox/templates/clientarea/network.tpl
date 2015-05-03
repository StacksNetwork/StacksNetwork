{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{if $vpsdo=='ips'}{$lang.ips} {if $subdo=='assignip'}&raquo; {$lang.assign_new_ip}{/if}{elseif $vpsdo=='interfaces'}{$lang.networkinterfaces} {if $subdo=='addinterface'}&raquo; {$lang.addnewnetwork}{elseif $subdo=='edit'}&raquo; {$interface.label}{/if}{else}{$lang.Firewall}{/if}</h3>
{*<ul class="sub-ul">
    <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=interfaces&vpsid={$vpsid}" class="{if $vpsdo=='interfaces'}active{/if}" ><span>{$lang.interfaces}</span></a></li>
    <li ><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}" class="{if $vpsdo=='ips'}active{/if}" ><span>{$lang.ips}</span></a></li>
    {if $o_sections.o_firewall}<li ><a  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=firewall&vpsid={$vpsid}" class="{if $vpsdo=='firewall'}active{/if}"><span>{$lang.Firewall}</span></a></li>{/if}
</ul>*}
<div class="clear"></div>
</div>
<div class="content-bar {if $subdo=='addinterface' || $subdo=='edit' || $subdo=='assignip'}nopadding{/if}">
    {include file="`$onappdir``$vpsdo`.tpl"}
</div>
{include file="`$onappdir`footer.cloud.tpl"}