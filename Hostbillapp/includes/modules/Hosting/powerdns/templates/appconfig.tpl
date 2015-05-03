<table border="0" cellpadding="6" cellspacing="0" width="100%" style="margin-bottom:10px;">
    <tr>
        <td  align="right" width="165"><strong>数据库类型</strong></td>
        <td >
            <select name="custom[backend]">
                <option {if $server.custom.backend=='MySQL'}selected="selected"{/if}>MySQL</option>
                <option {if $server.custom.backend=='PostgreSQL'}selected="selected"{/if}>PostgreSQL</option>
            </select>
        </td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td>
        <td ><input  name="host" size="60" value="{$server.host}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td>
        <td ><input  name="ip" size="60" value="{$server.ip}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td>
        <td ><input  name="username" size="25" value="{$server.username}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td>
        <td ><input type="password" name="password" size="25" class="inp" value="{$server.password}" autocomplete="off"/></td></tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td>
        <td ><input  name="field1" size="25" value="{$server.field1}" class="inp"/></td>
    </tr>
    <tr>
        <td  align="right" width="165"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td>
        <td ><input  name="field2" size="25" value="{$server.field2}" class="inp"/></td>
    </tr>
</table>