{if $action=='getadvanced'}

    <a href="?cmd=clientcredit&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
    <form class="searchform filterform" action="?cmd=clientcredit" method="post" onsubmit="return filter(this)">  
        <table width="100%" cellspacing="2" cellpadding="3" border="0" >
            <tbody>
                <tr>

                    <td width="15%">{$lang.clientname}</td>
                    <td><input type="text" value="{$currentfilter.lastname}" size="40" name="filter[lastname]"/></td>
                    <td width="15%">Invoice id</td>
                    <td><input type="text" value="{$currentfilter.invoice_id}" size="40" name="filter[invoice_id]"/></td>
                </tr>
                      <tr>

                    <td width="15%">Transaction no</td>
                    <td><input type="text" value="{$currentfilter.trans_id}" size="40" name="filter[trans_id]"/></td>
                    <td width="15%">Staff member</td>
                    <td><input type="text" value="{$currentfilter.admin_name}" size="40" name="filter[admin_name]"/></td>
                </tr>    
                <tr><td colspan="4"><center><input type="submit" value="{$lang.Search}" />&nbsp;&nbsp;&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/></center></td></tr>
            </tbody>
        </table>{securitytoken}</form>

    <script type="text/javascript">bindFreseter();</script>


{elseif $action=='default'}
    {if $emails}
        {if $showall}
            <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <div class="blu">
                    <div class="left">
                       
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                <a href="?cmd=clientcredit" id="currentlist" style="display:none" updater="#updater"></a>
                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" style="table-layout: fixed;">
                    <tbody>
                        <tr>      
                            <th  width="130"><a href="?cmd=clientcredit&orderby=date|ASC"  class="sortorder">{$lang.Date}</a></th>
                            <th  width="150"><a href="?cmd=clientcredit&orderby=lastname|ASC"  class="sortorder">Client</a></th>
                            <th><a href="?cmd=clientcredit&orderby=description|ASC"  class="sortorder">Description</a></th>
                            <th width="90">Increase</th>
                            <th width="90">Decrease</th>
                            <th width="90">Credit after</th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=transaction_id|ASC"  class="sortorder">Trans. id</a></th>
                            <th width="90"><a href="?cmd=clientcredit&orderby=invoice_id|ASC"  class="sortorder">Invoice</a></th>
                            <th width="130"><a href="?cmd=clientcredit&orderby=admin_name|ASC"  class="sortorder">Staff</a></th>
                        </tr>
                    </tbody> 
                    <tbody id="updater"> 
                    {/if}
                    {foreach from=$emails item=email}
                        <tr>
                            <td>{$email.date|dateformat:$date_format}</td>   
                            <td>
                               <a href="?cmd=clients&action=show&id={$email.client_id}" target="_blank">{$email.firstname} {$email.lastname}</a>
                            </td>
                            <td>{$email.description}</td>   
                            <td>{$email.in|price:$email.currency_id}</td>  
                            <td>{$email.out|price:$email.currency_id}</td>  
                            <td>{$email.balance|price:$email.currency_id}</td>  
                            <td>{if $email.transaction_id}<a href="?cmd=transactions&action=edit&id={$email.transaction_id}" target="_blank">{$email.transaction_id}</a>{else}-{/if}</td> 
                            <td>{if $email.invoice_id}<a href="?cmd=invoices&action=edit&id={$email.invoice_id}&list=all" target="_blank">{$email.invoice_id}</a>{else}-{/if}</td> 
                            <td>{if $email.admin_id}<a href="?cmd=editadmins&action=administrator&id={$email.admin_id}" target="_blank">{$email.admin_name}</a>{else}-{/if}</td> 
                        </tr>
                    {/foreach}
                    {if $showall}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th colspan="9">
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="left">
                      
                    </div>
                    <div class="right"><div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
                {securitytoken}</form>

        {/if}
    {else} 
        {if $showall}
            <p class="blu"> {$lang.nothingtodisplay} </p>
        {else}
            <tr>
                <td colspan="4"><p align="center" > {$lang.nothingtodisplay} </p></td>
            </tr>
        {/if}
    {/if}


{/if}
