<form action="" method="post">
    <div class="lighterblue" style="padding: 10px">
        <a href="" style="font-weight: bold" onclick="{literal}$(this).slideUp(500, function() {$('.howitworks').slideDown(1000);}); return false;{/literal}">它是如何工作的?</a>
        <div style="display: none" class="howitworks">
            <strong>1. 百分比</strong> 已添加到账单, 基于账单总额 (扣除 <strong>金额</strong> 参数如下)<br />
            <strong>2. 金额</strong> 已添加到账单<br/><br/>
            例如. <br/>
            <em>百分比 = 3%</em><br />
            <em>金额 = $ 0.40 USD</em><br />
            <em>合计金额 = $ 7.00 USD</em><br /><br/>
            <font style="text-decoration: underline">最终账单总额</font> = ( 7.00 * 3% ) + 0.40 = $ <strong>7.61</strong> USD
        </div>
        <div style="padding: 10px">
            <input style="font-weight: bold;" type="submit" name="savecharges" value="Save Changes" />
        </div>
    </div>
    <table cellspacing="0" cellpadding="3" border="0" class="glike hover" width="100%">
        <tbody>
            <tr>
                <th width="20"></th>
                <th width="100">接口ID</th>
                <th >接口</th>
                {foreach from=$curx item=ci}
                    <th width="90">Amount {$ci.code}</th>
                {/foreach}
                <th width="90">百分比</th>
                <th></th>
            </tr>
            {if !empty($gateways)}
                {foreach from=$gateways key=gid item=g}
                    <tr>
                        <td></td>
                        <td>#{$gid} <input type="hidden" value="{$names[$gid].modname}" name="gateways[{$gid}][gateway_name]" />
                            <input type="hidden" value="{$names[$gid].filename}" name="gateways[{$gid}][gateway_filename]" /></td>
                        <td><strong>{$names[$gid].modname}</strong></td>
                        {foreach from=$curx item=ci}
                            <td>{$ci.sign} <input size="5" style="text-align: right" value="{$g.amount[$ci.id]}" name="gateways[{$gid}][currencies][{$ci.id}]"/> </td>

                        {/foreach}

                        <td><input size="5" style="text-align: right" value="{$g.percent}" name="gateways[{$gid}][percent]"/> %</td>
                        <td></td>
                    </tr>
                {/foreach}
            {else}
                <tr><td colspan="6" style="text-align: center; padding: 5px;"><strong>没有可显示的内容</strong></td></tr>
            {/if}

        </tbody>
    </table>
    <div class="lighterblue" style="padding: 10px">
        <div style="padding: 10px">
            <input style="font-weight: bold;" type="submit" name="savecharges" value="保存更改" />
        </div>
    </div>
</form>