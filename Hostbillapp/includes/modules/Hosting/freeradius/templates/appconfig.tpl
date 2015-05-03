 <table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
     <tr>
         <td></td>
         <td>确保数据库用户将使用下面是特权的远程连接从您的HostBill IP.</td>
     </tr>
       <tr><td  align="right" width="165"><strong>FreeRadius IP</strong></td><td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td></tr>
       <tr><td  align="right" width="165"><strong>数据库名称</strong></td><td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td></tr>
       <tr><td  align="right" width="165"><strong>数据库用户名</strong></td><td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td></tr>
       <tr><td  align="right" width="165"><strong>数据库密码</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>
       <tr><td  align="right" width="165"><strong>数据库端口</strong></td><td ><input  name="field2" size="4" value="{if $server.field2}{$server.field2}{else}3306{/if}" class="inp"/></td></tr>
        
    </table>
<script>
    $("a.vtip_description").vTip();
</script>