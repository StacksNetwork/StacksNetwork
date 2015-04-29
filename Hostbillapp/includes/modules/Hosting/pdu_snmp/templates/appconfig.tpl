<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
    {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
    {if $server_fields.display.field1}<tr><td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td >
            {if $pdu_drivers}
            <select name="field1" class="inp">
                {foreach from=$pdu_drivers item=d key=l}
                <option value="{$l}" {if $l==$server.field1}selected="selected"{/if}>{$d}</option>
                {/foreach}
            </select>
            {else}
            <input  name="field1" size="25" value="{$server.field1}" class="inp"/>
            {/if}
            <a class="vtip_description" title="选择厂商或模式是最接近的进行连接. <br>您可以很容易地定义自己的驱动程序在 /includes/modules/Hosting/pdu_snmp/devices"></a>
        </td></tr>{/if}
</table>
<script>
    $("a.vtip_description").vTip();
</script>