 <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
     <tr>
         <td></td>
         <td>请确认 <b>hb_api.php</b> 文件已经从 /includes/modules/Hosting/cacti 目录中复制到 Cacti 主目录.</td>
     </tr>
        {if $server_fields.display.hostname}<tr><td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.ip}<tr><td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.username}<tr><td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>{/if}
        {if $server_fields.display.password}<tr><td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>{/if}
    </table>
<script>
    $("a.vtip_description").vTip();
</script>