<div class="blu" style="padding-bottom:0px;">
    <center>
        <table border="0" cellpadding="15" cellspacing="0">

            <tr>
                <td align="center" {if $do=='invoice-export'}class="lighterblue"{/if}>
                    <a href="?cmd=module&module={$moduleid}&do=invoice-export"><img src="{$moduledir}csv.png" /></a><br />
                    <a href="?cmd=module&module={$moduleid}&do=invoice-export"><strong>导出账单</strong></a>
                </td>

                <td align="center" {if $do=='transaction-export'}class="lighterblue"{/if}>
                    <a href="?cmd=module&module={$moduleid}&do=transaction-export"><img src="{$moduledir}csv.png" /></a><br />
                    <a href="?cmd=module&module={$moduleid}&do=transaction-export"><strong>导出转账记录</strong></a>
                </td>

                <td align="center" {if $do=='accounts-export'}class="lighterblue"{/if}>
                    <a href="?cmd=module&module={$moduleid}&do=accounts-export"><img src="{$moduledir}csv.png" /></a><br />
                    <a href="?cmd=module&module={$moduleid}&do=accounts-export"><strong>导出账号</strong></a>
                </td>

                <td align="center" {if $do=='clients-export'}class="lighterblue"{/if}>
                    <a href="?cmd=module&module={$moduleid}&do=clients-export"><img src="{$moduledir}csv.png" /></a><br />
                    <a href="?cmd=module&module={$moduleid}&do=clients-export"><strong>导出用户</strong></a>
                </td>

                <td align="center" {if $do=='domains-export'}class="lighterblue"{/if}>
                    <a href="?cmd=module&module={$moduleid}&do=domains-export"><img src="{$moduledir}csv.png" /></a><br />
                    <a href="?cmd=module&module={$moduleid}&do=domains-export"><strong>导出域名</strong></a>
                </td>
            </tr>
        </table>
    </center>	
</div>
{if $do=='invoice-export'}
<form action="?cmd=module&module={$moduleid}&do=invoices" method="post">
    <div class="lighterblue" style="padding:5px;">
        <center>
            <style>{literal}
                #fieldstable {
                    margin: 12px;
                }
                #fieldstable td {
                    text-align: left;
                    line-height: 10pt;
                    width: 150px;
                }
                #fieldstable input, label {
                    vertical-align: middle;
                }
                {/literal}</style>
            <table id="fieldstable">
                <tr>
                    <td><label><input name="fields[]" checked="checked" type="checkbox" value="invoice_id" />{$lang.invoice_id}</label></td>
                    <td><label><input name="fields[]" checked="checked" type="checkbox" value="clientname" />{$lang.clientname}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="address1" />{$lang.address1}</label></td>
                    <td><label><input name="fields[]" checked="checked" type="checkbox" value="gateway" />{$lang.paymethod}</label></td>
                    <td><label class="inv-items"><input name="fields[]" type="checkbox" value="taxed" />{$lang.Taxed}</label></td>
                    <td><label class="inv-items"><input name="fields[]" type="checkbox" value="position" />{$lang.position}</label></td>
                </tr>
                <tr>
                    <td><label class="inv-det"><input checked="checked" name="fields[]" type="checkbox" value="status" />{$lang.Status}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="email" />{$lang.email}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="address2" />{$lang.address2}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="subtotal" />{$lang.subtotal}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="tax1rate" />{$lang.tax}1 {$lang.rate}</label></td>
                    <td><label class="inv-items"><input checked="checked" name="fields[]" type="checkbox" value="qty" />{$lang.quantity}</label></td>
                </tr>
                <tr>
                    <td><label class="inv-det"><input checked="checked" name="fields[]" type="checkbox" value="total" />{$lang.total}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="phonenumber" />{$lang.phonenumber}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="postcode" />{$lang.postcode}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="credit" />{$lang.credit}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="tax2rate" />{$lang.tax}2 {$lang.rate}</label></td>
                    <td><label class="inv-items"><input checked="checked" name="fields[]" type="checkbox" value="price" />{$lang.price}</label></td>
                </tr>
                <tr>
                    <td><label class="inv-items"><input name="fields[]" type="checkbox" value="description" />{$lang.Description}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="company" />{$lang.company}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="city" />{$lang.city}</label></td>
                    <td><label><input name="fields[]" checked="checked" type="checkbox" value="duedate" />{$lang.duedate}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="tax1amount" />{$lang.tax}1 {$lang.amount}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="currency" />{$lang.currency}</label></td>
                </tr>
                <tr>
                    <td><label><input name="fields[]" checked="checked" type="checkbox" value="date" />{$lang.Date}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="country" />{$lang.country}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="state" />{$lang.state}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="datepaid" />{$lang.datepaid}</label></td>
                    <td><label class="inv-det"><input name="fields[]" type="checkbox" value="tax2amount" />{$lang.tax}2 {$lang.amount}</label></td>
                    <td><label><input name="fields[]" type="checkbox" value="exchangerate" />{$lang.excurrency}</label></td>
                </tr>
				<tr>
					 <td colspan="6"><label class="inv-det"><input name="fields[]" type="checkbox" value="trans_id" />{$lang.trans_id}</label></td>
				</tr>	
            </table>
            <script type="text/javascript">{literal}
                $(document).on('change','select[name=type]', function(e){
                    var val = $('select[name=type]').val();
                    if (val == 'invoice') {
                        $('.inv-items input').attr('disabled','disabled');
                        $('.inv-det input').removeAttr('disabled');
                    } else {
                        $('.inv-items input').removeAttr('disabled');
                        $('.inv-det input').attr('disabled','disabled');
                    }
                });
                $(document).ready(function(){
                    var val = $('select[name=type]').val();
                    if (val == 'invoice') {
                        $('.inv-items input').attr('disabled','disabled');
                        $('.inv-det input').removeAttr('disabled');
                    } else {
                        $('.inv-items input').removeAttr('disabled');
                        $('.inv-det input').attr('disabled','disabled');
                    }
                });
                {/literal}</script>
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">客户</td>
                    <td align="left">
                        <select name="client">
                            <option value="0">任意</option>
				{foreach from=$clients item=client}
                            <option value="{$client.id}">#{$client.id} {$client.lastname} {$client.firstname}</option>
				{/foreach}
                        </select>
                    </td>
                    <td width="160" align="right"> 账单状态</td>
                    <td align="left">
                        <select name="status">
                            <option value="Any">任意</option>
                            <option value="Paid">已支付</option>
                            <option value="Unpaid">未支付</option>
                            <option value="Cancelled">已取消</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="160" align="right">日期从</td>
                    <td align="left">
                        <input name="date_from" class="haspicker" />
                    </td>
                    <td width="160" align="right"> 日期到</td>
                    <td align="left">
                        <input name="date_to" class="haspicker" />
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">导出类型</td>
                    <td align="left">
                        <select name="type">
                            <option value="invoice" selected="selected">通用账单信息, 无内容</option>
                            <option value="items">账单信息与账单内容</option>
                        </select>
                    </td>
                    <td width="160" align="right">分隔符</td>
                    <td align="left">
                        <select name="delim">
                            <option value=",">, 逗号</option>
                            <option value=";">; 分号</option>
                        </select>
                    </td>
                </tr>
            </table>
            <input type="submit" value="下载CSV"  style="font-weight:bold;"/>
        </center>
</div>
</form>

{elseif $do=='transaction-export'}
<form action="?cmd=module&module={$moduleid}&do=transactions" method="post">
    <div class="lighterblue" style="padding:5px;">
        <center>
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">网关</td>
                    <td align="left">
                        <select name="gateway">
                            <option value="0">Any</option>
				{foreach from=$gateways item=gateway}
                            <option value="{$gateway.id}">{$gateway.modname}</option>
				{/foreach}
                        </select>
                    </td>
                    <td width="160" align="right">分隔符</td>
                    <td align="left">
                        <select name="delim">
                            <option value=",">, 逗号</option>
                            <option value=";">; 分号</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td width="160" align="right">日期从</td>
                    <td align="left">
                        <input name="date_from" class="haspicker" />
                    </td>
                    <td width="160" align="right"> 日期到</td>
                    <td align="left">
                        <input name="date_to" class="haspicker" />
                    </td>
                </tr>
            </table>
            <input type="submit" value="下载CSV"  style="font-weight:bold;"/>
        </center>
</div>
</form>
{elseif $do=='accounts-export'}
<form action="?cmd=module&module={$moduleid}&do=accounts" method="post">
    <div class="lighterblue" style="padding:5px;">
        <center>
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">分隔符</td>
                    <td align="left">
                        <select name="delim">
                            <option value=",">, 逗号</option>
                            <option value=";">; 分号</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>

            </table>
            <input type="submit" value="下载CSV"  style="font-weight:bold;"/>
        </center>
</div>
</form>
{elseif $do=='domains-export'}
<form action="?cmd=module&module={$moduleid}&do=domains" method="post">
    <div class="lighterblue" style="padding:5px;">
        <center>
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">分隔符</td>
                    <td align="left">
                        <select name="delim">
                            <option value=",">, 逗号</option>
                            <option value=";">; 分号</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>

            </table>
            <input type="submit" value="下载CSV"  style="font-weight:bold;"/>
        </center>
</div>
</form>
{elseif $do=='clients-export'}
<form action="?cmd=module&module={$moduleid}&do=clients" method="post">
    <div class="lighterblue" style="padding:5px;">
        <center>
            <table border="0" cellpadding="3" cellspacing="0">
                <tr>
                    <td width="160" align="right">分隔符</td>
                    <td align="left">
                        <select name="delim">
                            <option value=",">, 逗号</option>
                            <option value=";">; 分号</option>
                        </select>
                    </td>
                    <td width="160" align="right"> </td>
                    <td align="left">

                    </td>
                </tr>
                <tr>
                    <td width="160" align="right">注册来自</td>
                    <td align="left">
                        <input name="date_from" class="haspicker" />
                    </td>
                    <td width="160" align="right">注册登记</td>
                    <td align="left">
                        <input name="date_to" class="haspicker" />
                    </td>
                </tr>
            </table>
            <input type="submit" value="下载CSV"  style="font-weight:bold;"/>
        </center></div>
</form>

{/if}

<div class="blu"></div>