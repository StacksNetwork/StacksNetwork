{if $after_synchronize}
    <script type="text/javascript">{literal}
        function show_import(elem) {
            $(elem).parent().append({/literal}'{if $products}<strong>Choose product:</strong><br /><select name="imp_product">{foreach from=$products item=prod_cat key=cat_name}<optgroup label="{$cat_name}">{foreach from=$prod_cat item=prod}<option value={$prod.id}>{$prod.name}</option>{/foreach}</optgroup>{/foreach}</select> <input type="submit" value="Import" onclick="import_account(this); return false;" />{else}There is no products using CPanel module.{/if}'{literal});
            $(elem).remove();
        }
        function import_account(elem) {
            ajax_update('?cmd=module&module={/literal}{$module_id}{literal}&import=true',{
                username: $(elem).parent().find('input[name=imp_username]').val(),
                domain: $(elem).parent().find('input[name=imp_domain]').val(),
                server_id: $(elem).parent().find('input[name=imp_serverid]').val(),
                server_name: $(elem).parent().find('input[name=imp_servername]').val(),
                product: $(elem).parent().find('select[name=imp_product] option:selected').val(),
                email: $(elem).parent().find('input[name=imp_email]').val()
            },$(elem).parent().parent());
            $(elem).parent().html('<img src="ajax-loading2.gif" />');
        }
    {/literal}</script>
    <div class="lighterblue" style="padding: 20px;">
                <div style="margin-bottom: 20px">
                    <div style="float: left;">
                        <a style="font-weight: bold; font-size: 15px;" href="?cmd=module&amp;module={$module_id}"> &laquo; Return to the main</a>
                    </div>
                    <div class="sectionheadblue" style="width: 400px; margin-left: 200px">
                        <h1>Result Overview{if $singleServer} for: #{$server_info.id} {$server_info.name}{else}:{/if}</h1>
                        <div style="padding: 20px">
                            <font style="font-size:14px; color: green; font-weight: bold;">{$summary.overview.success}</font> accounts of <font style="font-size:14px; font-weight: bold;">{$summary.overview.total}</font> were successfully synchronized. <br />
                            <font style="font-size:14px; color: #CC0000; font-weight: bold;">{$summary.overview.not_exists}</font> were not found on the servers. <br/>
                            <font style="font-size:14px; color: #CC0000; font-weight: bold;" font-weight: bold;">{$summary.overview.wrong_domain}</font> have different domain.<br/>
                            <font style="font-size:14px; color: #CC0000; font-weight: bold;" font-weight: bold;">{$summary.overview.not_in_hb}</font> do not exist in the HostBill.<br/>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
        {if !empty($summary.connection_error)}
        <div style="padding: 20px; color: #CC0000">
            <h3>Connection errors: </h3>
            <ul>
            {foreach from=$summary.connection_error item=conerr}
                {if $singleServer}
                    <li>Connection Failed ({$conerr.ip}): {$conerr.error}</li>
                {else}
                    <li><strong>Server <a href="?cmd=servers&amp;action=edit&amp;id={$conerr.id}">#{$conerr.id}</a> {$conerr.name}</strong> ({$conerr.ip}): {$conerr.error}</li>
                {/if}
            {/foreach}
            </ul>
        </div>
        {/if}
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tbody>
              <tr>
                <th width="15%">Client</th>
                <th width="10%">Username</th>
                <th width="10%">Domain</th>
                {if !$singleServer}<th width="15%">Server</th>{/if}
                <th width="25%"></th>
                <th width="20%">Account</th>
                <th>Status</th>
              </tr>
              {foreach from=$summary.accounts item=acc_list key=status}
                    {foreach from=$acc_list item=acc}
                      {if $status == 'success'}
                          <tr>
                              <td style="background-color:#e4ffe4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                              <td style="background-color:#e4ffe4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                              <td style="background-color:#e4ffe4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                              {if !$singleServer}<td style="background-color:#e4ffe4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                              <td style="background-color:#e4ffe4; font-weight: bold">{$acc.result}</td>
                              <td style="background-color:#e4ffe4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
                              <td style="background-color: #e4ffe4;color:#00CC00; font-weight: bold">OK</td>
                          </tr>

                      {else}
                          <tr>
                              <td style="background-color:#ffe4e4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                              <td style="background-color:#ffe4e4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                              <td style="background-color:#ffe4e4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                              {if !$singleServer}<td style="background-color:#ffe4e4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                              <td style="background-color:#ffe4e4; font-weight: bold">{$acc.result}</td>
                              <td style="background-color:#ffe4e4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
                              <td style="background-color: #ffe4e4;color:#CC0000; font-weight: bold">Failed</td>
                          </tr>
                      {/if}
                      {/foreach}
              {/foreach}
              {if !empty($summary.accounts_notinhb)}
                <tr><th colspan="7" style="padding: 5px;">Accounts not in the HostBill</th></tr>
                  {foreach from=$summary.accounts_notinhb item=acc}
                      <tr>
                          <td>-</td>
                          <td style="font-weight: bold">{$acc.username}</td>
                          <td>{$acc.domain}</td>
                          {if !$singleServer}<td><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                          <td>{$acc.result}</td>
                          <td>
                              <input type="hidden" name="imp_username" value="{$acc.username}" />
                              <input type="hidden" name="imp_domain" value="{$acc.domain}" />
                              <input type="hidden" name="imp_serverid" value="{$acc.server_id}" />
                              <input type="hidden" name="imp_servername" value="{$acc.server_name}" />
                              <input type="hidden" name="imp_email" value="{$acc.email}" />
                              <a href="" onclick="show_import(this); return false;" >Import Account</a>
                          </td>
                          <td> </td>
                      </tr>
                  {/foreach}
              {/if}
            </tbody>
        </table>

    </div>
{else}
    <script type="text/javascript">{literal}
        function checkAll(elem) {
            if($(elem).is(':checked'))
                $(elem).parent().find('input[type=checkbox]').attr('checked','checked');
            else
                $(elem).parent().find('input[type=checkbox]').removeAttr('checked');
        }
        function check_submit() {
            if($("input[name='server_list[]']:checked").length > 0)
                return true;
            alert('You have to select at least one server!');
            return false;
        }
    {/literal}</script>
    <div class="lighterblue" style="padding:20px;">
        <div class="sectionheadblue" style="padding: 10px; width: 550px">
        {if $servers}
        <form action="" method="post">
            <input type="hidden" name="submit" value="1" />
            <table cellpadding="0" cellspacing="10" width="100%">
                <tr><td style="font-weight: bold; padding-top: 5px" align="right" valign="top">Choose servers:</td><td>
                        All <input type="checkbox" onclick="checkAll(this)" /> <a href="" onclick="$(this).parent().find('div').show(); $(this).hide(); return false">show list</a>
                        <div style="display: none; padding: 10px">
                        {foreach from=$servers item=server_list key=group_name}
                            <h3>{$group_name}</h3>
                            <div style="padding-left: 20px">
                            {foreach from=$server_list item=server}
                                <input type="checkbox" name="server_list[]" value="{$server.id}" /> <a href="?cmd=servers&amp;action=edit&amp;id={$server.id}">#{$server.id}</a> {$server.name} <br />
                            {/foreach}
                            </div>
                        {/foreach}
                        </div>
                    </td></tr>
                <tr>
                    <td style="font-weight: bold; padding-top: 5px" align="right" valign="top" width="30%">Send notification to admins:
                    </td>
                    <td valign="top" >
                        All <input type="checkbox" onclick="checkAll(this)" /> <a href="" onclick="$(this).parent().find('div').show(); $(this).hide(); return false">show list</a>
                        <div style="display: none; padding: 10px">
                        {foreach from=$admins item=adm}
                            <input type="checkbox" name="admin_list[]" value="{$adm.id}" />  {$adm.lastname} {$adm.firstname} - {$adm.email} <br />
                        {/foreach}
                        </div>

                    </td></tr>
                <tr><td colspan="2" style="padding: 20px; text-align: center"><input onclick="if(check_submit()) return true; else return false;" type="submit" value="Run Synchronization" style="padding: 5px; font-weight: bold; font-size: 14px" /></td></tr>
            </table>
        </form>
        {else}
        <center>There is no servers using CPanel module.</center>
        {/if}
        </div>
    </div>
{/if}