        <script type="text/javascript">{literal}
            function filterDtaus(num) {
                switch (num) {
                    case 0:
                        $('.dtaus_imported').show();
                        $('.dtaus_notimported').show();
                        break;
                    case 1:
                        $('.dtaus_imported').hide();
                        $('.dtaus_notimported').show();
                        break;
                    case 2:
                        $('.dtaus_imported').show();
                        $('.dtaus_notimported').hide();
                        break;
                }
            }
            $(document).ready(function(){
                $('#checkall').click(function() {
                    if($(this).is(":checked")) $('input[name="selected[]"]').attr('checked', true);
                    else $('input[name="selected[]"]').attr('checked', false);
                });
            });
        {/literal}</script>

<form action="" method="post">
<div class="lighterblue" style="padding: 10px">
    过滤:
    <input type="radio" value="0" name="filter" onchange="filterDtaus(0);" checked="checked" /> 所有 &nbsp;
    <input type="radio" value="1"  name="filter" onchange="filterDtaus(1);" /> 未导入 &nbsp;
    <input type="radio" value="2"  name="filter" onchange="filterDtaus(2);" /> 已导入 &nbsp;
    <div style="padding: 10px">
        与选择的: <input type="submit" name="import" value="导入文件" onclick='setTimeout("window.location.reload()", 2500);' />
        <input type="submit" name="delete" style="color: #cc0000" value="删除" />
        <input type="submit" name="markimported" value="标记为已导入" />
        <input type="submit" name="marknotimported" value="标记为未导入" />
        <input type="submit" style="color: #009900; font-weight: bold;" value="标记为已支付" onclick="return confirm1();" />
        <input type="submit" name="markunpaid" value="标记为未支付" />
    </div>
</div>

    <div id="#bodycont">
	<div id="confirm_ord_delete" style="display:none" class="confirm_container">

	<div class="confirm_box">
		<h3>仅标记为已支付</h3>
                <strong>警告!</strong> 交易标记为已为支付将会无法核算.<br />
<br />


		<input type="radio" checked="checked" name="payinvoices" value="1" id="cc_hard"/> 标记为已支付并 <strong>创建付款到账单</strong><br />
		<input type="radio"  name="payinvoices" value="0" id="cc_soft"/> 仅标记为已支付<br />

		<br />
		<center><input type="submit" name="markpaid" value="{$lang.Apply}" style="font-weight:bold" />&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit2(); return false;"/></center>

	</div>
<script type="text/javascript">
{literal}
function confirm1() {
 $('#bodycont').css('position','relative');
             $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
			 return false;
}
function cancelsubmit2() {
	$('#confirm_ord_delete').hide().parent().css('position','inherit');
}
{/literal}
</script>
</div>
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike hover">
            <tbody>
              <tr>
                <th width="50"><input type="checkbox" id="checkall"/></th>
                <th width="80"></th>
                <th width="100">支付状态</th>
                <th width="100">日期</th>
                <th width="70">客户</th>
                <th width="70">账单ID</th>
                <th width="50">金额</th>
                <th width="100">名称</th>
                <th width="100">银行账户</th>
                <th width="100">银行卡号</th>
                <th width="20"></th>
              </tr>
                {if !empty($transactions)}
                    {foreach from=$transactions item=t}
                    <tr class="{if $t.imported == '1'}dtaus_imported{else}dtaus_notimported{/if}">
                        <td><input type="checkbox" name="selected[]" value="{$t.id}" class="{$transaction.status}" /> #{$t.id}</td>
                        <td>{if $t.imported == '1'}已导入{else}<strong>未导入</strong>{/if}</td>
                        <td>{if $t.paid == '1'}<strong style="color:#00cc00">已支付</strong>{else}<strong style="color:#cc0000">未支付</strong>{/if}</td>
                        <td>{$t.date|dateformat:$date_format}</td>
                        <td><a href="?cmd=clients&amp;action=show&amp;id={$t.client_id}">#{$t.client_id} {$t.client_name}</a></td>
                        <td><a href="?cmd=invoices&amp;action=edit&amp;id={$t.invoice_id}" target="blank">#{$t.invoice_id}</a></td>
                        <td>&euro; {$t.amount} EUR</td>
                        <td>{$t.name}</td>
                        <td>{$t.bank_account}</td>
                        <td>{$t.bank_code}</td>
                        <td><a href="?cmd=module&amp;module={$module_id}&amp;delete=true&selected[]={$t.id}" onclick="if(!confirm('您确定要删除该内容吗?')) return false;" style="font-weight: bold; color:#cc0000">删除</a></td>
                    </tr>
                    {/foreach}
                {else}
                <tr><td colspan="9" style="text-align: center; padding: 5px;"><strong>没有可显示的内容</strong></td></tr>
                {/if}

            </tbody>
</table>
    </div>
<div class="lighterblue" style="padding: 10px">
    <div style="padding: 10px">
        与选择的: <input type="submit" name="import" value="导入文件" onclick='setTimeout("window.location.reload()", 2500);' /> 
        <input type="submit" name="delete" style="color: #cc0000" value="删除" />
        <input type="submit" name="markimported" value="标记为已导入" />
        <input type="submit" name="marknotimported" value="标记为未导入" />
        <input type="submit" style="color: #009900; font-weight: bold;" value="标记为已支付" onclick="return confirm1();" />
        <input type="submit" name="markunpaid" value="标记为未支付" />
    </div>
</div>
</form>