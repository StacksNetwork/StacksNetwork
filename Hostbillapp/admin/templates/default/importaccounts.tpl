<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td  colspan="2"><h3>{$lang.impaccounts}</h3></td>

    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=importaccounts"  class="tstyled selected">{$lang.impaccounts}</a>
        </td>
        <td  valign="top"  class="bordered"><div id="bodycont" style="">

                {if $action=='step3'}

                    <div class="blu" style="padding: 5px;">
                        <a href="?cmd=importaccounts" ><strong>&laquo; Back to server selection</strong></a>
                    </div>
                    <div class="lighterblue" style="padding:20px">
                        <strong>{$lang.importlog}:</strong> <br />
                        {if $logs}
                            <div class="fs11" style="margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#F5F9FF;padding:10px;">
                                <div style="max-height:300px;min-height:300px;height:300px;overflow:auto" >

                                    {foreach from=$logs item=log_line}
                                        {if $log_line.error}
                                            <font style="color:red">{$lang.Error}: {$log_line.text}</font><br />
                                        {else}
                                            {$log_line.text}<br />
                                        {/if}
                                    {/foreach}
                                </div>
                            </div>

                        {else}
                            {$lang.nothingtodisplay}.
                        {/if}
                    </div>


                {elseif $action=='step2'}

                    <script type="text/javascript">
                        {literal}
                            function importaccs() {
                                if ($("input[class=check]:checked").length == 0) {
                                    alert('{/literal}{$lang.notselectedtoimp}{literal}');
                                    return false;
                                }
                                return true;
                            }
                        {/literal}
                    </script>

                    <form action="" method="post" onsubmit="return importaccs()" >
                        <input type="hidden" value="{$server_id}" name="server_id" />
                        <input type="hidden" name="action" value="step3" />
                        <div class="blu">
                            <a href="?cmd=importaccounts" ><strong>&laquo; Back to server selection</strong></a>
                            <input type="submit" name="submit" style="font-weight:bold" value="Import selected" />

                        </div>

                        <div class="lighterblue" style="padding:10px;">
                            <b> Note:</b> Importing accounts is resource &amp; time consuming process. To avoid timeouts, consider importing few accounts at a time, rather than all at once.
                        </div>
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                            <tr>
                                <th><input type="checkbox" id="checkall" /></th>
                                <th>{$lang.Username}</th>
                                <th>{$lang.Email}</th>
                                <th>{$lang.Status}</th>
                                <th>{$lang.Domain}</th>
                                <th>{$lang.Package}</th>
                                <th>{$lang.productassigned}</th>
                            </tr>

                            {if $accounts.not_in_hb}
                                {if $import_type == '2' || $import_type == '3'}
                                    {foreach from=$accounts.not_in_hb item=acc}
                                        <tr>
                                            <td><input type="checkbox" class="check" value="{$acc.username}" name="selected[]" /><input type="hidden" name="product_id[{$acc.username}]" value="{$acc.product_id}" /></td>
                                            <td>{$acc.username}</td>
                                            <td>{$acc.email}</td>
                                            <td {if $acc.status == 'Suspended'}style="color: red"{/if}>{$acc.status}</td>
                                            <td>{$acc.domain}</td>
                                            <td>{if $acc.product_name}{$acc.product_name}{else}-{/if}</td>
                                            <td><select name="product_id[{$acc.username}]">
                                                    {foreach from=$pnames item=category }
                                                        {if $category.products}
                                                            <optgroup label="&nbsp;{$category.name}">
                                                                {foreach from=$category.products item=product}
                                                                    <option value="{$product.id}">{$product.name}</option>
                                                                {/foreach}
                                                            </optgroup>
                                                        {/if}
                                                    {/foreach}
                                                </select>

                                            </td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    {foreach from=$accounts.not_in_hb item=acc}
                                        <tr>
                                            <td><input type="checkbox" class="check" value="{$acc.username}" name="selected[]" /><input type="hidden" name="product_id[{$acc.username}]" value="{$acc.product_id}" /></td>
                                            <td>{$acc.username}</td>
                                            <td>{$acc.email}</td>
                                            <td {if $acc.status == 'Suspended'}style="color: red"{/if}>{$acc.status}</td>
                                            <td>{$acc.domain}</td>
                                            <td>{$acc.package}</td>
                                            <td>{$acc.product_name}</td>
                                        </tr>
                                    {/foreach}
                                {/if}
                            {else}
                                <tr><td colspan="7">{$lang.noaccountstoimport}</td></tr>
                                {/if}

                            {if $accounts.in_hb}
                                <tbody class="lighterblue_td">
                                    <tr><th colspan="7" style="text-align: center">{$lang.accalreadyinhb}</th></tr>
                                            {foreach from=$accounts.in_hb item=acc2}
                                        <tr>
                                            <td><input type="checkbox" disabled="disabled" /></td>
                                            <td>{$acc2.username}</td>
                                            <td>{$acc2.email}</td>
                                            <td>{$acc2.status}</td>
                                            <td>{$acc2.domain}</td>
                                            <td>{$acc2.package}</td>
                                            <td>{$acc2.product_name}</td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                            {/if}

                        </table>

                        <script type="text/javascript">
                            {literal}
                                setTimeout(function() {
                                    $('.check').unbind('click');
                                    $('.check').click(checkEl);
                                }, 40);
                            {/literal}
                        </script>


                        <div class="blu">
                            <input type="submit" name="submit" style="font-weight:bold" value="Import selected" />

                        </div>
                        {securitytoken}</form>

                {else}
                    {if $servers}
                        <script type="text/javascript">
                            {literal}
                                function getpackages() {
                                    var value = $('#server_id').find(":selected").val();
                                    ajax_update('?cmd=importaccounts&action=getpackages', {id: value}, '#packages', true);
                                    return false;
                                }
                            {/literal}
                        </script>

                        <div class="blu" style="padding: 10px;">

                            <form action="" method="post" onsubmit="return getpackages();">
                                {$lang.pleasechooseserv}:
                                <select name="server_id" id="server_id" class="inp">
                                    {foreach from=$servers item=group}
                                        <optgroup label="{$group.name}">
                                            {foreach from=$group.servers item=srvr}
                                                <option value="{$srvr.id}">{$srvr.name}{if $srvr.ip} - {$srvr.ip}{elseif $srvr.host} - {$srvr.host}{/if}</option>
                                            {/foreach}
                                        </optgroup>
                                    {/foreach}
                                </select>
                                <br />
                                <input type="submit" style="font-weight: bold" value="Continue" />
                                {securitytoken}</form>

                        </div>
                        <div id="packages" class="lighterblue" style="padding: 10px">
                        </div>
                    {else}
                        <div class="blu"> {$lang.firstaddserver} <a href="?cmd=servers&action=add">{$lang.clickhere}</a> {$lang.toadd}</div>
                    {/if}
                {/if}

            </div></td></tr></table>