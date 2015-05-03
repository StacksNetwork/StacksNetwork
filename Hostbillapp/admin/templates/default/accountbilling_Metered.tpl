 <ul class="accor">
                                                <li><a href="#">{if $lang[$billingmodel_name]}{$lang[$billingmodel_name]}{else}{$billingmodel_name}{/if}</a>
                                                    <div class="sor" >
                                                         
                <!--metered billing start-->
                {if !$metered_enable}
                    该套餐不适用流量计费, <a href="?cmd=services&action=product&id={$details.product_id}" target="_blank">点击这里管理流量计费价格.</a>
                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                     {if $details.metered_type!='PrePay'}<tr class="odd">
                        <td width="16%" align="right"><b>计费周期</b></td>
                        <td width="16%">{$details.previous_invoice|dateformat:$date_format} - {$details.next_invoice|dateformat:$date_format}</td>
                   
                        <td width="16%" align="right"><b>下一次账单总额</b></td>
                        <td width="16%"><b>{$details.metered_total|price:$details.currency}</b></td>
                    
                        <td width="16%" align="right"></td>
                        <td width="16%"></td>
                    </tr>
                    {else}
                    {/if}
                     <tr class="odd">
                        <td colspan="6">
                           {if $details.metered_type!='PrePay'} <b>下一次账单详情</b> <span class="fs11">每小时更新</span><br/>{/if}
                            <div class="report">
                              {if $details.total>0}
                               <div class="button">
                                    <span class="attr">{$lang[$details.billingcycle]}:</span>
                                    <span class="value">{$details.total|price:$details.currency_id}</span>
                                </div>
                              {/if}

                              {foreach from=$metered_summary item=vr}
                                <div class="button">
                                    <span class="attr">{$vr.name}:</span>
                                    <span class="value">{$vr.charge|price:$details.currency_id:true:false:true:4}</span>
                                </div>
                              {/foreach}
                            </div>
                        </td>
                    </tr>
                    <tr class="even">
                        <td colspan="4"></td>
                        <td colspan="2" style="text-align:right">
                            时间间隔: <select name="metered_interval" id="metered_interval" onchange="metteredBillinghistory()">
                                <option value="1h">1 小时</option>
                                <option value="1d">1 天</option>

                            </select>
                            月 (yyyy-mm): <select name="metered_period" id="metered_period" onchange="metteredBillinghistory()">
                                {foreach from=$metered_periods item=p}
                                    <option value="{$p}">{$p}</option>
                                {/foreach}
                            </select></td>
                    </tr>
                </table>
                {if $metered_usage_log}<div id="meteredusagelog" style="width:100%">
                   {include file="ajax.accountbilling_Metered.tpl"}

                </div>
                <div class="clear"></div>
                <br/><b>图例</b>
                <table class="whitetable fs11" width="100%" cellspacing="0" cellpadding="3">
                    {foreach from=$metered_usage_log.variables item=vr}
                        <tr class="even">
                            <td width="150"><b>{$vr.name}</b></td>
                            <td>{$vr.description}</td>

                        </tr>
                    {/foreach}
                </table>

                {else}
                <table class="whitetable" width="100%" cellspacing="0" cellpadding="3">
                    <tr class="odd havecontrols">
                        <td align="center"><b>尚无数据报告</b></td>
                    </tr>

                </table>

                {/if}
              
               
                {/if}
                <!--eof: metered billing -->
                                                    </div>
                                                    </li>
                                                </ul>
<br />
{literal}
<link rel="stylesheet" href="../includes/types/widgets/meteredwidget/demo_table.css" type="text/css" />
<script type="text/javascript" src="../includes/types/widgets/meteredwidget/jquery.dataTables.min.js?v={$hb_version}"></script> 
<script type="text/javascript">
    var bPaginate={
        "bFilter": false,
        "sPaginationType": "full_numbers",
        "bLengthChange":false,
        "iDisplayLength": 24,
        "aaSorting": []
    };
	function metteredBillinghistory() {
                $('#meteredusagelog').addLoader();
		var url={/literal}'?cmd=accounts&action=edit&id={$details.id}&service={$details.id}&do=metered_history';{literal};
                $.post(url,{metered_period:$('#metered_period').val(),metered_interval:$('#metered_interval').val()},function(data){
                    var r = parse_response(data);
                    if(r) {
                       var c=$('#meteredusagelog').empty().html(r).find('th');
                       c.width(Math.floor(100/c.length)+'%');
                      $('#meteredusagelog table').eq(0).dataTable(bPaginate);
                    }
                });
		return false;
	}
    function bindMe() {
        $('#tabbedmenu').TabbedMenu({elem:'.tab_content',picker:'li.tpicker',aclass:'active'});
        $('#meteredusagelog table').eq(0).dataTable(bPaginate);
    }
    appendLoader('bindMe');
 </script>
   {/literal}