{literal}
<style type="text/css">
    a.menuitm, a.greenbtn {
        display: inline-block;
        line-height: 14px;
        height: 14px;
        vertical-align: middle;
        margin: auto 2px auto 2px;
    }
    #mccp tr[href] {
        cursor: pointer;
    }
    #mccp {
        width: 100%;
    }

    #mccp td {
        padding: 3px;
    }
    #mccp th {
        padding: 6px;
    }
    .mdetails {
        margin: 12px;
    }
    .p6 {
        text-align: center;
        height: 36px;
        line-height: 36px;
        margin: 4px;
    }
    .p6 a {
        margin: auto 12px auto 12px;
    }
    #bodycont {
        background: #f5f9ff;
    }
    .mod_desc {
        display: inline-block;
        margin: 7px;
        vertical-align: middle;
        min-height: 325px;
        height: 100%;
        background-color: white;
    }
	.blank_state{
		background: url('{/literal}{$system_url}{literal}includes/modules/Other/manualccprocessing/admin/blank.png') no-repeat white;
		padding: 50px 0;
	}
</style>
<!--[if IE 7]>
<style type="text/css">
    .mod_desc {
        float: left;
    }
</style>
<![endif]-->
{/literal}

<div style="">

	<div class="blank_state" >
    <div class="blank_info">
        <h3>尚无任何转账记录.</h3>
        在这里您会发现标记手动处理的所有事务
        <div class="clear"></div>
    </div>
</div>
    {if $list}
    <table id="mccp" class="glike hover" cellpadding="0" cellspacing="0" border="0">
        <thead>
            <tr>
                <th>{$lang.invoice_id}</th>
                <th>{$lang.clientname}</th>
                <th>{$lang.Total}</th>
                <th>{$lang.Date}</th>
                <th>{$lang.duedate}</th>
                <th>{$lang.Status}</th>
                <th>{$lang.Action} <div style="float:right;font-weight:normal;font-size:11px;color:#535353;">
            <span class="pord"></span>
              Payment received
        </div></th>
        </tr>
        </thead>
        <tbody>
            {foreach from=$list item=inv}
            <tr class="{if $inv.status=='Processed'} compor {/if}">
                <td><a href="?cmd=invoices&action=edit&id={$inv.invoice_id}">{$inv.invoice_id}</a></td>
                <td><a href="?cmd=clients&action=show&id={$inv.client_id}">{$inv.lastname} {$inv.firstname}</a></td>
                <td>{$inv.totalcur}</td>
                <td>{$inv.date}</td>
                <td>{$inv.duedate}</td>
                <td>{$inv.status}</td>
                <td>{if $inv.status=='Unpaid' && $inv.state=='Pending' }<a href="?cmd=module&module={$moduleid}&action=process&id={$inv.id}" class="new_control greenbtn">{$lang.Process}</a>
                    {else}<a href="?cmd=module&module={$moduleid}&action=process&id={$inv.id}" class="menuitm">{$lang.showdetails}</a>{/if}
                    {if $inv.state!='Processed'}<a href="?cmd=module&module={$moduleid}&action=delete&id={$inv.id}" class="menuitm">{$lang.Delete}</a>{/if}
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>

    {elseif $client}
    <div style="text-align: center; min-height: 300px; height: 100%;">
        <div class="mod_desc">
            <div class="headshelf"><strong>{$lang.Client} {$lang.Details}</strong></div>
            <div class="mmdescr">
                <table class="mdetails" border="0" width="300" cellspacing="5" cellpadding="0">
                    <tbody>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.Client} ID</td>
                            <td width="200" align="left">{$client.client_id}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.lastname}</td>
                            <td width="200" align="left">{$client.lastname}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.firstname}</td>
                            <td width="200" align="left">{$client.firstname}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.company}</td>
                            <td width="200" align="left">{$client.companyname}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.address}</td>
                            <td width="200" align="left">{$client.address1}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.address2}</td>
                            <td width="200" align="left">{$client.address2}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.email}</td>
                            <td width="200" align="left">{$client.email}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.phone}</td>
                            <td width="200" align="left">{$client.phonenumber}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.city}</td>
                            <td width="200" align="left">{$client.city}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.postcode}</td>
                            <td width="200" align="left">{$client.postcode}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.state}</td>
                            <td width="200" align="left">{$client.state}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.country}</td>
                            <td width="200" align="left">{$client.country}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="mod_desc">
            <div class="headshelf"><strong>{$lang.Invoice} {$lang.Details}</strong></div>
            <div class="mmdescr">
                <table class="mdetails" border="0" width="300" cellspacing="5" cellpadding="0">
                    <tbody>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.invoice} ID</td>
                            <td width="200" align="left">{$inv.id}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.Status}</td>
                            <td width="200" align="left">{$inv.status}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.trans_gtw}</td>
                            <td width="200" align="left">{$inv.gateway}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.invoice_date}</td>
                            <td width="200" align="left">{$inv.date}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.invoice_due}</td>
                            <td width="200" align="left">{$inv.duedate}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.tax}1 {$lang.rate}</td>
                            <td width="200" align="left">{$inv.taxrate}%</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.tax}1 {$lang.Amount}</td>
                            <td width="200" align="left">{$inv.taxdec}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.tax}2 {$lang.rate}</td>
                            <td width="200" align="left">{$inv.taxrate2}%</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.tax}2 {$lang.Amount}</td>
                            <td width="200" align="left">{$inv.tax2dec}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.subtotal}</td>
                            <td width="200" align="left">{$inv.subtotaldec}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.Credit}</td>
                            <td width="200" align="left">{$inv.creditdec}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light"><strong>{$lang.total}</strong></td>
                            <td width="200" align="left"><strong>{$inv.totaldec}</strong></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="mod_desc">
            <div class="headshelf"><strong>{$lang.Invoice} {$lang.Details}</strong></div>
            <div class="mmdescr">
                <table class="mdetails" border="0" width="300" cellspacing="5" cellpadding="0">
                    <tbody>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.ccardtype}</td>
                            <td width="200" align="left">{$client.cardtype}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.ccardnum}</td>
                            <td width="200" align="left">{$client.cardnum}</td>
                        </tr>
                        <tr>
                            <td width="100" align="right" class="light">{$lang.expdate}</td>
                            <td width="200" align="left">{$client.expdate}</td>
                        </tr>
                        {if $client.cvv !='' && $inv.status=='Pending'}<tr>
                            <td width="100" align="right" class="light">CVV/CVC</td>
                            <td width="200" align="left">{$client.cvv}</td>
                        </tr>{/if}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <div class="p6">&nbsp;
        <a href="?cmd=module&module={$moduleid}" class="menuitm">{$lang.backtomain}</a>
        {if $inv.state=='Pending'}<a href="?cmd=module&module={$moduleid}&action=cancel&id={$reqid}" class="menuitm">{$lang.Cancel}</a>{/if}
        {if $inv.status=='Unpaid'}<a href="?cmd=module&module={$moduleid}&action=accept&id={$reqid}" class="new_control greenbtn">{$lang.Accept}</a>{/if}
    </div>
    {/if}
</div>


{literal}
<script type="text/javascript">
</script>
{/literal}