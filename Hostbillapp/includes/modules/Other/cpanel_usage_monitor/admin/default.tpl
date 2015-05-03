{if $after_continue}
    <script type="text/javascript">{literal}
        function checkall(elem) {
            if($(elem).is(':checked'))
                $('.tocheck').attr('checked','checked');
            else
                $('.tocheck').removeAttr('checked');
        }
        function run_billing(elem) {
            if($('input:checked.tocheck').length <= 0) {
                alert('There is no accounts selected!');
                return false;
            }
            if(!confirm('Are you sure you want to perform this action?'))
                return false;

            if($('input[name=bill_traffic]').is(':checked')) {
                if($('input[name=feeValueTraffic]').val() <= 0) {
                    alert('Please provide amount for Traffic Overage.');
                    return false;
                }
            }
            if($('input[name=bill_disk]').is(':checked')) {
                if($('input[name=feeValueDisk]').val() <= 0) {
                    alert('Please provide amount for Disk Overage.');
                    return false;
                }
            }
            if($('input[name=create_ticket]').is(':checked') || $('input[name=bill_disk]').is(':checked') || $('input[name=bill_traffic]').is(':checked') || $('input[name=send_notification]').is(':checked')) {
                $('#invoices_generated').show();
                if($('input[name=bill_disk]').is(':checked') || $('input[name=bill_traffic]').is(':checked'))
                    $('#invoices_generated').append('<center id="invoices_generated_loader"><img src="ajax-loading.gif" /></center>');
                ajax_update('?cmd=module&module={/literal}{$module_id}{literal}&runbilling=true&'+$('#overage_form').serialize(),{
                    notify: $('input[name=send_notification]').is(':checked') ? '1' : '0',
                    createTicket: $('input[name=create_ticket]').is(':checked') ? '1' : '0',
                    send_invoice: $('input[name=send_invoice]').is(':checked') ? '1' : '0',
                    generateInvoices: $('input[name=gen_invoices]').is(':checked') ? '1' : '0',
                    billTraffic: $('input[name=bill_traffic]').is(':checked') ? '1' : '0',
                    billDisk: $('input[name=bill_disk]').is(':checked') ? '1' : '0',
                    trafficAmount: $('input[name=feeValueTraffic]').val(),
                    diskAmount: $('input[name=feeValueDisk]').val()
                },'#invoices_generated',true, true);
            }

            $(elem).attr('disabled','disabled');
            if($('input[name=suspend]').is(':checked')) {
                $('.tocheck:checked').each(function() {
                    $(this).parent().parent().find('td:eq(7)').html('<img src="ajax-loading2.gif" />');
                });
                $.post('?cmd=module&module={/literal}{$module_id}{literal}&suspend=true&'+$('.tocheck').serialize(), {
                    stack:'push'
                }, function(data){
                   var resp = parse_response(data);
                        if (resp) {
                            $(elem).removeAttr('disabled');
                        }
                });
            } else
                $(elem).removeAttr('disabled');
        }
        function show_section(elem, sect) {
            if($(elem).is(':checked'))
                $(sect).show();
            else
                $(sect).hide();
        }
    {/literal}</script>
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
    <div class="lighterblue" style="padding: 20px;">
                <div style="margin-bottom: 20px">
                    <div style="float: left;">
                        <a style="font-weight: bold; font-size: 15px;" href="?cmd=module&amp;module={$module_id}"> &laquo; Return to the main</a>
                    </div>
                    <div class="sectionheadblue" style="width: 400px; margin-left: 200px">
                        <h1>Result Overview{if $singleServer} for: #{$server_info.id} {$server_info.name}{else}:{/if}</h1>
                        <div style="padding: 20px">
                            <font style="font-size:14px; color: green; font-weight: bold;">{$summary.overview.normal}</font> accounts of <font style="font-size:14px; font-weight: bold;">{$summary.overview.total}</font> were under their limit. <br />
                            <font style="font-size:14px; color: #CC0000; font-weight: bold;">{$summary.overview.overage}</font> were over their Traffic/Disk threshold <br/>
                            <font style="font-size:14px; color: #CC0000; font-weight: bold;">{$summary.overview.not_exists}</font> accounts were not found on the servers.<br/>
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
        <div  class="sectionheadblue" style="width:660px">
        <div style="padding: 5px 20px; float: left;">
            <strong>With Selected:</strong>
            <div style="padding: 5px 20px;">
                <input type="checkbox" name="gen_invoices" onclick="show_section(this,'#generate_invoices');" /> Create Invoices
                <div style="padding-left: 40px; display: none" id="generate_invoices">
                    <input type="checkbox" name="bill_traffic" onclick="show_section(this,'#fee_traffic');" /> Create invoice for Traffic over-usage <br />
                    <span id="fee_traffic" style="display: none">Amount per 100MB <input size="10" name="feeValueTraffic" value="0.00" /><br /></span>
                    <input type="checkbox" name="bill_disk" onclick="show_section(this,'#fee_disk');" /> Create invoice for Disk over-usage <br />
                    <span id="fee_disk" style="display: none">Amount per 100MB <input size="10" name="feeValueDisk" value="0.00" /><br /></span>
                    <input type="checkbox" name="send_invoice" /> Send Invoice to Client<br />
                </div><br />
                <input type="checkbox" name="send_warning" onclick="show_section(this,'#send_warning');" />Send Warning Notification
                <div style="padding-left: 40px; display: none" id="send_warning">
                    <input type="checkbox" name="create_ticket" /> Open Ticket  {if $email_id2}<a href="?cmd=emailtemplates&action=edit&id={$email_id2}" target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=edit&inline=true&id={/literal}{$email_id2}{literal}' });{/literal} return false;" style="font-size: 10px; font-weight: bold">Edit Email</a>{/if}<br />
                    <input type="checkbox" name="send_notification" /> Email Client {if $email_id}<a href="?cmd=emailtemplates&action=edit&id={$email_id}" target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=edit&inline=true&id={/literal}{$email_id}{literal}' });{/literal} return false;" style="font-size: 10px; font-weight: bold">Edit Email</a>{/if}<br />
                </div><br />
                <input type="checkbox" name="suspend" /> Suspend Accounts <br />
                <input type="submit" value="GO!" style="font-weight: bold" onclick="run_billing()" />
            </div>
        </div>
        <div id="invoices_generated" style="width: 350px; margin-left: 300px; display: none; padding: 10px"></div>
        <div class="clear"></div>
        </div>
    </div>
    <form id="overage_form" method="post" action="" >
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tbody>
              <tr>
                <th width="20"><input type="checkbox" onclick="checkall(this);" /></th>
                <th width="15%">Client</th>
                <th width="8%">Username</th>
                <th width="10%">Domain</th>
                {if !$singleServer}<th width="12%">Server</th>{/if}
                <th width="10%">Disk Usage</th>
                <th width="10%">Traffic Usage</th>
                <th width="10%">Account Status</th>
                <th width="15%">Account</th>
                <th>Status</th>
              </tr>
              {if !empty($summary.accounts)}
              {foreach from=$summary.accounts item=acc_list key=status}
                    {foreach from=$acc_list item=acc}
                      {if $status == 'normal'}
                          <tr>
                              <td style="background-color:#e4ffe4;"><input type="checkbox" disabled="disabled" /></td>
                              <td style="background-color:#e4ffe4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                              <td style="background-color:#e4ffe4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                              <td style="background-color:#e4ffe4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                              {if !$singleServer}<td style="background-color:#e4ffe4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                              <td style="background-color:#e4ffe4; font-weight: bold">{$acc.disk_used} MB / {$acc.disk_limit}{if $acc.disk_limit != 'unlimited'} MB{/if}</td>
                              <td style="background-color:#e4ffe4; font-weight: bold">{$acc.bw_used} MB / {$acc.bw_limit}{if $acc.bw_limit != 'unlimited'} MB{/if}</td>
                              <td style="background-color:#e4ffe4; font-weight: bold; {if $acc.status == 'Active'}color:#00CC00;{/if}">{$acc.status}</td>
                              <td style="background-color:#e4ffe4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
                              <td style="background-color: #e4ffe4;color:#00CC00; font-weight: bold">OK</td>
                          </tr>

                      {elseif $status == 'overage'}
                          <tr class="row{$acc.id}">
                              <td style="background-color:#ffe4e4;"><input type="checkbox" value="{$acc.id}" class="tocheck" name="selected[]" /></td>
                              <td style="background-color:#ffe4e4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                              <td style="background-color:#ffe4e4; font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                              <td style="background-color:#ffe4e4;">{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                              {if !$singleServer}<td style="background-color:#ffe4e4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                              <td style="background-color:#ffe4e4; font-weight: bold; {if $acc.disk_overage>0}color: #CC0000{/if}"><input type="hidden" name="disk_limit[{$acc.id}]" value="{$acc.disk_limit}" /><input type="hidden" name="disk_used[{$acc.id}]" value="{$acc.disk_used}" /><input type="hidden" class="disk_overage_inp" name="disk_overage[{$acc.id}]" value="{$acc.disk_overage}" />{$acc.disk_used} MB / {$acc.disk_limit} MB</td>
                              <td style="background-color:#ffe4e4; font-weight: bold; {if $acc.bw_overage>0}color: #CC0000{/if}"><input type="hidden" name="bw_limit[{$acc.id}]" value="{$acc.bw_limit}" /><input type="hidden" name="bw_used[{$acc.id}]" value="{$acc.bw_used}" /><input type="hidden" name="bw_overage[{$acc.id}]" value="{$acc.bw_overage}" />{$acc.bw_used} MB / {$acc.bw_limit} MB</td>
                              <td style="background-color:#ffe4e4; font-weight: bold; {if $acc.status == 'Active'}color:#00CC00;{/if}">{$acc.status}</td>
                              <td style="background-color:#ffe4e4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
                              <td style="background-color: #ffe4e4;color:#CC0000; font-weight: bold">Limit Exceeded</td>
                          </tr>
                      {else}
                        <tr>
                          <td><input type="checkbox"  disabled="disabled" /></td>
                          <td><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
                          <td style="font-weight: bold">{if $acc.username != ''}{$acc.username}{else}<em>(empty)</em>{/if}</td>
                          <td >{if $acc.domain != ''}{$acc.domain}{else}<em>(empty)</em>{/if}</td>
                          {if !$singleServer}<td ><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>{/if}
                          <td colspan="2" style="text-align: center">Account not found on the server</td>
                          <td style="font-weight: bold; {if $acc.status == 'Active'}color:#00CC00;{/if}">{$acc.status}</td>
                          <td style=" font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
                          <td style="font-weight: bold; color: #cc0000">Failed</td>
                      </tr>
                      {/if}
                      {/foreach}
              {/foreach}
              {else}
              <tr><td colspan="9">Nothing to display.</td></tr>
              {/if}
              </tbody>
        </table>
    </form>
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
                        All <input type="checkbox" onclick="checkAll(this)" /> <a href="" onclick="$(this).parent().find('div').show(); $(this).hide(); return false">显示列表</a>
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
                    <td style="font-weight: bold; padding-top: 5px" align="right" valign="top" width="30%">Send notification to admins:</td>
                    <td valign="top" >
                        All <input type="checkbox" onclick="checkAll(this)" /> <a href="" onclick="$(this).parent().find('div').show(); $(this).hide(); return false">显示列表</a>
                        <div style="display: none; padding: 10px">
                        {foreach from=$admins item=adm}
                            <input type="checkbox" name="admin_list[]" value="{$adm.id}" />  {$adm.lastname} {$adm.firstname} - {$adm.email} <br />
                        {/foreach}
                        </div>

                    </td></tr>
                <tr><td colspan="2" style="padding: 20px; text-align: center"><input onclick="if(check_submit()) return true; else return false;" type="submit" value="Continue &raquo;" style="padding: 5px; font-weight: bold; font-size: 14px" /></td></tr>
            </table>
        </form>
        {else}
        <center>There is no servers using CPanel module.</center>
        {/if}
        </div>
    </div>
{/if}