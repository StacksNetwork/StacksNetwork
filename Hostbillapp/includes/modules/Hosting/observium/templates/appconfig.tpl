 <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
     <tr>
         <td></td>
         <td>确认位于 /includes/modules/Hosting/observium 目录中的文件 <b>hb_api.php</b> 已经复制到您的 Observium html目录(可以从Web访问).</td>
     </tr>
        {if $server_fields.display.hostname}<tr><td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
         {if $server_fields.display.ssl}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td></tr>{/if}
       
    </table>
<script>
    $("a.vtip_description").vTip();
</script>