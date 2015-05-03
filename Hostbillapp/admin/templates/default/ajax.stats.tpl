{if $showall}
    <script src="{$template_dir}js/statistics.js?v={$hb_version}" type="text/javascript"></script>
    {literal}
        <style type="text/css">

            #graph1 {background:#fff; padding:5px 1%; }

            #graph1div {width:100%; overflow: hidden;}
            #graph1div table{
                width: 100%;
                text-align: right;
            }
            #graph1div table td{
                white-space: nowrap;
                padding: 1px 5px;
            }
            #graph1div table td:last-child{
                padding-right: 100px;
            }
            #graph1div table td div{
                background: #444;
                height: 15px;
                position: relative;
                box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.56) inset, 1px 1px;
            }
            #graph1div table td div span{
                position: absolute;
                left:100%;
                padding-left: 5px;
            }
            #graph1div table tr:last-child td{
                padding-bottom: 10px;
            }
            #graph1div table td div:hover {
                box-shadow: 0 0 0 8px rgba(255, 255, 255, 0.2) inset, 1px 1px;
            }
            #graph-total{
                border-top: 1px solid #000000;
                line-height: 20px;
                text-align: right;
                padding: 10px;
            }
            #graph2 { height:200px; margin-top:15px; background:#fff; float:left; width:40%}
            .stat-result {background:#fff;}
            .bc#graph2{	height:270px;  width:38%}
            .stat-result , .stat-result li ul {list-style:none; margin: 0; padding:0; }
            .stat-result li {padding: 10px 5px 10px 30px; border-bottom: 1px solid #eee }
            .stat-result li li {border:none; clear:left; padding: 5px 20px}
            .stat-result li li span {float:left; display:block; width: 150px}
            .stat-result li.odd { background:#F4F4F4 }
            .stat-result li.first {  font-size:15px;}
            #interval{
                background: url("{/literal}{$template_dir}{literal}img/bg_pag.gif") repeat-x scroll left top #eee;
                border: 1px solid #B0B0B0;
                border-radius: 2px 2px 2px 2px;
                font-size: 11px;
                padding-left: 5px;
                height: 21px;
                margin: 0 0 2px;
                vertical-align: middle;
                text-shadow: 0 1px 0 #FFFFFF;
            }
            .list-2{margin-bottom:20px;}
            .list-2 .subm1.haveitems {padding: 10px 0 7px 16px; display:none;  background:#fff}
            .newhorizontalnav .datetab {}
            li.datetab span{border: 1px solid #CCCCCC; padding: 4px;}
            li.datetab span.picker{border-left:none; padding-left:28px; background: url('{/literal}{$template_dir}{literal}img/calendar-month.png') no-repeat center center #f5f5f5}
            li.datetab.active span{border:none; background:none; padding-left: 5px;}
            a.dp-choose-date{padding:1px 10px; float:none;display:inline}
            .data-point-label{text-align :center; position:absolute; color:#999}
            div.subm1.haveitems a{display:inline-block; vertical-align: middle;}
            div.ui-daterangepicker-arrows{ display: inline-block; padding: 1px 0;    vertical-align: middle; border:none}
            input#daterange {font-family: Tahoma}
            select#daterange,select#daterangem{min-width:100px; padding:3px}
        </style>
        <script type="text/javascript">

            var p2jq = [['d', 'dd'], ['j', 'd'], ['l', 'DD'], ['m', 'mm'], ['n', 'm'], ['F', 'MM'], ['Y', 'yy']];
            var dateformat ={/literal} '{$date_format}'{literal};
            for (var i = 0; i < p2jq.length; i++)
                dateformat = dateformat.replace(p2jq[i][0], p2jq[i][1])

            $(function() {
                $('.datetab').click(function() {
                    if ($('li.datetab').hasClass('active')) {
                        $('li.datetab').removeClass('active');
                        $('.subm1').hide();
                    } else {
                        $(this).addClass('active');
                        $('.subm1').show();
                    }
                    return false;
                });
            });
        </script> 
    {/literal}
{/if}{*END SHOWALL*}
    {if $action=="default" || $action=="report" ||  $action=="orders" || $action=="transactions" || $action=="singup" || $action=="tickets" || $action=="supportreply" || $action=="ticketsgen" || $make=='byservice' || $make=='bycountry' || $action=='income'}
        {if $showall}
            <div id="newshelfnav" class="newhorizontalnav">
                <div class="list-1">
                    <ul>
                        <li>
                            <a href="#"><span class="ico money">{if $action=='default'}年度营收{elseif $lang[$action]}{$lang[$action]}{else}状态{/if}</span></a>
                        </li>
                        <li class="datetab last">
                            <a href="#"><span>{$dateFrom|dateformat:$date_format} - {$dateTo|dateformat:$date_format}</span><span class="picker"></span></a>
                        </li>
                    </ul>
                </div>
                <div class="list-2">
                    <div class="subm1 haveitems" >
                        <select type="text" id="daterange" >{foreach from=$dates item=y key=v}<option {if $selectedyear == $v}selected="selected"{/if} value="{$y}">{$v}</option>{/foreach}</select>
            {if $months}<select type="text" id="daterangem" >{foreach from=$months item=y key=v}<option {if $selectedmonth == $v}selected="selected"{/if} value="{$v}">{$y}</option>{/foreach}</select>{/if}
            <a href="#" onclick="submitdate('{$action}')" class="new_control greenbtn"><span>{$lang.submit}</span></a> 
            <a href="#" class="new_control datetab" onclick="">{$lang.Cancel}</a>
        </div>
    </div>

    <div class="niecers" style="border:none; padding:10px 0">
        {if $action=="ticketsgen"}
            <ul class="stat-result">
                <li>
                    <h3>{$lang.avg_rp_time} <a href="#" class="vtip_description" title="{$lang.avg_rp_time_dscr}"></a> </h3> 
                    {if $data.avg_response}
                    {if $data.avg_response.4}{$data.avg_response.4} {$lang.weeks}{/if}
                {if $data.avg_response.3}{$data.avg_response.3} {$lang.days}{/if}
            {if $data.avg_response.2}{$data.avg_response.2} {$lang.hours}{/if}
        {if $data.avg_response.1}{$data.avg_response.1} {$lang.minutes}{/if}
    {if $data.avg_response.0}{$data.avg_response.0} {$lang.seconds}{/if} 
{else}
    {$lang.avg_rp_none}
{/if}
</li>
<li>
    <h3>{$lang.avg_rs_time} <a href="#" class="vtip_description" title="{$lang.avg_rs_time_dscr}"></a> </h3>
    {if $data.avg_resolve}
    {if $data.avg_resolve.4}{$data.avg_resolve.4} {$lang.weeks}{/if}
{if $data.avg_resolve.3}{$data.avg_resolve.3} {$lang.days}{/if}
{if $data.avg_resolve.2}{$data.avg_resolve.2} {$lang.hours}{/if}
{if $data.avg_resolve.1}{$data.avg_resolve.1} {$lang.minutes}{/if}
{if $data.avg_resolve.0}{$data.avg_resolve.0} {$lang.seconds}{/if} 
{else}
    {$lang.avg_rs_none}
{/if}
</li>
<li>
    <h3>{$lang.status_brk}</h3>
    <ul>
        {assign value="Client-Reply" var=clientreply}
        {assign value="In-Progress" var=inprogress}
        <li><span class="Open">{$lang.opentickets}</span> {$data.Open} </li> 
        <li><span class="Answered">{$lang.answtickets} </span>{$data.Answered} </li>
        <li><span class="Client-Reply">{$lang.clientrtickets} </span>{$data.$clientreply} </li>
        <li><span class="In-Progress">{$lang.inprogresstickets} </span>{$data.$inprogress} </li>
        <li><span class="Closed">{$lang.closedtickets} </span>{$data.Closed}</li>
    </ul>
</li>
<li>
    <h3>{$lang.support_brk}</h3>
    <ul>
        <li><span>{$lang.rp_line1}</span> {$data.rp_single} {$lang.ticket_s} ({$data.rp_percent1}%)</li>
        <li><span>{$lang.rp_line2}</span> {$data.rp_morthanone} {$lang.ticket_s} ({$data.rp_percent2}%)</li>
    </ul>
</li>
</ul>
{elseif $action=="report"}
    <table style="width: 100%" cellspacing="0" cellpadding="5" class="glike hover">
        <tr>
            <th>类型</th>
            <th>内容</th>
            <th>周期</th>
            <th>开始日期</th>
                {foreach from=$data.timeline item=items key=period}
                <th>{$period}</th>
                {/foreach}
        </tr>
        {foreach from=$data.items item=item key=itemkey}
            <tr>
                <td>{*
                    {if $item.invoice_type & 1}Recurring{/if}
                    {if $item.invoice_type & 4}Mettered{/if}
                    *}
                {if $item.is_refnud}Refund{/if}
            </td>
            {*<td>{$item.item_id}</td>*}
            <td>
                {if $item.type=='Hosting' || $item.type=='Addon' }
                    <a href="?cmd=accounts&action=edit&id={$item.rel_id}&list=all" >{$item.item_name}</a>
                {elseif $item.type=='Domain Register' || $item.type=='Domain Transfer'}
                    <a href="?cmd=domains&action=edit&id={$item.rel_id}&list=all" >{$item.item_name}</a>
                {else}
                    {$item.item_name}
                {/if}
            </td>
            <td>{if $item.cycle && is_numeric($item.cycle)}{$item.cycle} {$lang.Year}{elseif $item.cycle}{$lang[$item.cycle]}{else}{$lang.once}{/if}</td>
            <td>{$item.date|dateformat:$date_format}</td>
            {foreach from=$data.timeline item=items key=period}
                <td style="white-space: nowrap; border-left: 1px solid #ddd;{if $items[$itemkey] < 0}color:#500;{/if}">
            {if $items[$itemkey]}{$items[$itemkey]|price:$item.currency_id:true:false:true:2:false}{else}-{/if}
        </td>
    {/foreach}
</tr>
{/foreach}
</table>
{else}
    <div id="graph1"  {if $make=="bycountry"}class="bc"{/if}>
        <div id="graph1div" data-max="{$graph_max}" data-min="{$graph_min}">
            {if $mchart}
                <table>
                    {foreach from=$tick item=tickgroup key=indx}
                        <tbody>
                            {foreach from=$tickgroup item=tick key=tidx}
                                <tr>
                                    {foreach from=$tick item=label}
                                        <td style="width:1%">{$label}</td>
                                    {/foreach}
                                    <td>
                                        <div style="width:{if $bar_width[$tidx][$indx]}{$bar_width[$tidx][$indx]}{else}0%{/if}; background-color:#{$bar_color[$tidx]}">
                                            <span>
                                                {if $bar_currency[$tidx]}
                                                    {$mchart[$tidx][$indx]|price:$bar_currency[$tidx]}
                                                {else}
                                                    {if $mchart[$tidx][$indx]}
                                                        {$mchart[$tidx][$indx]}
                                                    {else}0
                                                    {/if}
                                                {/if}
                                            </span>
                                        </div>
                                    </td>
                                </tr>
                            {/foreach}
                        </tbody>
                    {/foreach}
                </table>
            {elseif $chart}
                <table>
                    {foreach from=$tick item=label key=indx}
                        <tr>
                            <td style="width:1%">{$label}</td>
                            <td>
                                <div style="width:{if $bar_width[$indx]}{$bar_width[$indx]}{else}0%{/if}; background-color:#5F8BBF"><span>{$chart[$indx]}</span></div>
                            </td>
                        </tr>
                    {/foreach}
                </table>
            {else}
                <div class="blank_state" style="text-align: center">
                    <h1>无数据可显示</h1>
                </div>
            {/if}
            {if $total}
                <div id="graph-total">
                    <span>{$total.prefix}</span> 
                    <strong>
                        {if $total.money}
                            {if $total.value}
                                {$total.value|price:$currency}
                            {else}
                                {$total_value|price:$currency}
                            {/if}
                        {else}
                            {if $total.value}
                                {$total.value}
                            {else}
                                {$total_value}
                            {/if}{$total.sufix}
                        {/if}
                    </strong>
                </div>
            {/if}
        </div>
        <div id="graph1div">

        </div>
    {/if}
</div>
{/if}{*END SHOWALL*}
{/if}