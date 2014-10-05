{if $action=='pricepreview'}<span><b>{$testprice}</b></span>
{elseif $action=='gettask'}{if $task}
<h2 style="margin-bottom:5px">{if $lang[$task.taskname]}{$lang[$task.taskname]}{else}{$task.taskname}{/if}</h2>
{assign var="name" value="_desc"}
{assign var="name2" value=$task.task}
{assign var="baz" value="$name2$name"}
{$lang.$baz}
<form method="post" action=""><input type="hidden" name="make" value="updatetask" />
    <input type="hidden" name="task" value="{$task.task}" />
    <table border="0">
        <tr>
            <td style="padding:6px">
                <strong>{$lang.calledevery}</strong>:
            </td>		
            <td style="padding:6px;">		
		{if $task.task=='sendCronResults'}{$lang.evd}<input type="hidden" name="run_every" value="Time" />{else}
                <input type="hidden" name="run_every" value="{$task.run_every}" />
                <b>{if $task.run_every=='Run'}{$lang.croncall}
                {elseif $task.run_every=='Hour'}{$lang.evh}
                {elseif $task.run_every=='Time'}{$lang.evd}
                {elseif $task.run_every=='Week'}{$lang.evw}
                {elseif $task.run_every=='Month'}{$lang.evm}{/if}</b>

                {/if}
            </td>
            <td id="e_evd1" {if $task.run_every!='Time'}style="display:none"{/if} class="e_evd" style="padding:6px"><input size="2"  name="run_every_time_hrs" class="inp" value="{$task.run_every_time_hrs}"/> : <input size="2" name="run_every_time_min" class="inp" value="{$task.run_every_time_min}"/> </td>
            <td id="e_evd2"  {if $task.run_every!='Week'}style="display:none"{/if} class="e_evd" style="padding:6px">
                <select name="run_every_time_week" class="inp">
                    <option value="2" {if $task.run_every_time==2}selected="selected"{/if}>{$lang.monday}</option>
                    <option value="3" {if $task.run_every_time==3}selected="selected"{/if}>{$lang.tuesday}</option>
                    <option value="4" {if $task.run_every_time==4}selected="selected"{/if}>{$lang.wednesday}</option>
                    <option value="5" {if $task.run_every_time==5}selected="selected"{/if}>{$lang.thursday}</option>
                    <option value="6" {if $task.run_every_time==6}selected="selected"{/if}>{$lang.friday}</option>
                    <option value="7" {if $task.run_every_time==7}selected="selected"{/if}>{$lang.saturday}</option>
                    <option value="1" {if $task.run_every_time==1}selected="selected"{/if}>{$lang.sunday}</option>			
                </select>
            </td>
            <td id="e_evd3" {if $task.run_every!='Month'}style="display:none"{/if}  class="e_evd" style="padding:6px">
                <select name="run_every_time_month" class="inp">
			{section name=foo loop=31}
                    <option {if $smarty.section.foo.iteration==$task.run_every_time}selected="selected"{/if}>{$smarty.section.foo.iteration}</option>	
                    {/section}	
                </select>
            </td>


            <td style="padding:6px">
              {if $task.run_every!='Run'}  <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme" />{/if}</td>

        </tr>
    </table>{securitytoken}</form><script type="text/javascript">{literal}
        function shia1(el) {
		
            var cls=$(el).find('option:selected').attr('class');
            $('.e_evd').hide();
            $('#e_evd'+cls).show();
			
			
		
        }
        {/literal}
</script>
{/if}

{elseif $action == 'test_connection'}
{if $result}

<span style="font-weight: bold; color: {if $result.result == 'Success'}#009900{else}#990000{/if}">
    {if $lang[$result.result_text]}{$lang[$result.result_text]}{else}{$result.result_text}{/if}{if $result.error}: {$result.error}{/if}
</span>

{/if}

{elseif $action=='currency'}

{if $curr} 
<td colspan="7"  style="border:solid 2px #d6d6d6;border-top:0px;padding:5px;">
    <form action="" method="post">
        <input type="hidden" value="update" name="make" />
        <input type="hidden" value="{$curr.id}" name="id" />
        <table border="0" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <td width="130" style="border:none;">{$lang.currcode}</td>
                <td style="border:none;"><input size="4" name="code"  value="{$curr.code}"/></td>

                <td width="130" style="border:none;">{$lang.currsign}</td>
                <td style="border:none;"><input size="4" name="sign"  value="{$curr.sign}"/></td>

                <td width="130" style="border:none;">{$lang.currrate}</td>
                <td style="border:none;"><input size="4" name="rate"   value="{$curr.rate}"/></td>				
            </tr>
            <tr>
                <td width="130" style="border:none;">{$lang.curriso}</td>
                <td style="border:none;"><input size="4" name="iso"  value="{$curr.iso}"/></td>	

                <td width="130" style="border:none;">{$lang.currupdate}</td>
                <td style="border:none;"><input type="checkbox" name="update" value="1" {if $curr.update=='1'}checked="checked"{/if}/></td>

                <td width="130" style="border:none;">{$lang.currdisplay}</td>
                <td style="border:none;"><input type="checkbox" name="enable" value="1" {if $curr.enable=='1'}checked="checked"{/if}/></td>		
            </tr>
            <tr>
                <td width="130" style="border:none;">{$lang.CurrencyFormat}</td>
                <td style="border:none;" colspan="5">
                    <select  name="format" >
                        <option {if $curr.format=='1,234.56'}selected="selected"{/if}>1,234.56</option>
                        <option {if $curr.format=='1.234,56'}selected="selected"{/if}>1.234,56</option>
                        <option {if $curr.format=='1 234.56'}selected="selected"{/if} value="1 234.56">1 234.56</option>
                        <option {if $curr.format=='1 234,56'}selected="selected"{/if} value="1 234,56">1 234,56</option>
                    </select>
                </td>	
            </tr>
            <tr>
                <td colspan="6" style="border:none;"><center><input type="submit" style="font-weight:bold" value="{$lang.submit}"/></center></td>				
            </tr>
        </table>
    {securitytoken}</form>
</td>
{/if}

{elseif $action=='ticketrelated'}



<div class="blu">
    <form name="" action="?cmd=configuration&action=ticketrelated" method="post">
        <input name="make" type="hidden" value="save_configuration"/>
        {foreach from=$configuration item=v key=k}
        {assign var="name" value=$k}
        {assign var="descr" value='_descr'}
        {assign var="baz" value="$name$descr"}

        {if $v=='on' or $v=='off'}

        {$lang.$k} :<strong>On: </strong>
        <input type="radio" name="{$k}" value="on" {if $v=='on'}checked="checked"{/if} />
               <strong>Off: </strong>
        <input type="radio" name="{$k}" value="off" {if $v=='off'}checked="checked"{/if}/>
               {$lang.$baz} <br />
        {else}

        {$lang.$k} :
        <input name="{$k}" value="{$v}"/>
        {$lang.$baz}<br />
        {/if}

        {/foreach}
        <input type="submit" value="submit" />
    {securitytoken}</form>
</div>

{elseif $action=='cron'}

 {include file='configuration/cron.tpl'}

{elseif $action=='default'}
<form name="" action="" method="post"  id="saveconfigform">
    <input name="cmd" type="hidden" value="configuration"/>
    <input name="postform" type="hidden" value="save_configuration"/>
    <div class="newhorizontalnav"  id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="list-1elem"><a href="#">{$lang.generalconfig}</a></li>
                <li class="list-1elem"><a href="#">{$lang.Ordering}</a></li>
                <li class="list-1elem"><a href="#">{$lang.Support}</a></li>
                <li class="list-1elem"><a href="#">{$lang.Billing}</a></li>
                <li class="list-1elem"><a href="#">{$lang.Mail}</a></li>
                <li class="list-1elem"><a href="#">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                <li class="list-1elem"><a href="#">{$lang.Other}</a></li>
            </ul>
        </div>

        <div class="list-2">
            <div class="subm1"></div>
            <div class="subm1 haveitems" style="display:none">
                <ul >
                    <li class="picked"><a href="#"><span>{$lang.General}</span></a></li>
                    <li class=""><a href="?cmd=configuration&action=orderscenarios"><span>{$lang.orderscenarios}</span></a></li>
                </ul>
            </div>
            <div class="subm1 haveitems" style="display:none">
                <ul >
                    <li class="picked"><a href="#"><span>{$lang.General}</span></a></li>
                    <li class=""><a href="?cmd=configuration&action=ticketstatuses"><span>{$lang.ticketstatuses}</span></a></li>
                </ul></div>
            <div class="subm1 haveitems" style="display:none">
                <ul >
                    <li>
                        <a  href="?action=download&invoice=preview" onclick="return invoicePreview(this)"><span><b>{$lang.previewinvoice}</b></span></a>
                        <script type="text/javascript">
                            {literal}
                            function invoicePreview(l) {
                                ajax_update('?cmd=configuration',$('#saveconfigform').serializeObject(),function(){
                                    window.location=$(l).attr('href');
                                });
                                return false;
                            }
                            {/literal}
                        </script>
                    </li>
                    <li class="list-2elem"><a href="#"><span>{$lang.invmethod}</span></a></li>
                    <li class=""><a href="?cmd=configuration&action=invoicetemplates"><span>{$lang.invcustomize}</span></a></li>
                    <li class=""><a href="?cmd=configuration&action=estimatetemplates"><span>预期定制</span></a></li>
                    <li class="list-2elem"><a href="#"><span>{$lang.creditcards}</span></a></li>
                    <li class="list-2elem"><a href="#"><span>{$lang.clbalance}</span></a></li>
                    <li class="list-2elem"><a href="#"><span>信用记录</span></a></li>
                </ul>
            </div>
            <div class="subm1 haveitems" style="display:none">
                    <ul > <li class="list-4elem"><a href="#"><span>{$lang.mailmethod}</span></a></li>
                    <li class="list-4elem"><a href="#"><span>{$lang.mailcustomize}</span></a></li>  </ul>
            </div>
            <div class="subm1 haveitems" style="display:none">
                <ul >
                    <li class="list-3elem"><a href="#"><span>{$lang.maincurrency}</span></a></li>
                    <li class="list-3elem"><a href="#"><span>{$lang.addcurrencies}</span></a></li>
                    <li><a href="?cmd=taxconfig"><span>{$lang.taxes}</span></a></li>
                </ul>
            </div>
            <div class="subm1" style="display:none"></div>
        </div>
    </div>




    <div class="nicerblu" id="ticketbody">

        <div id="newtab">


            <div class="sectioncontent">

                <script type="text/javascript">{literal}
                    function c_reload(sel) {
                        switch($(sel).val()) {
                            case '-1': $('#currency_edit').show(); break;
                            case 'USD': 
                                $('#ISOCurrency').val('USD');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val('USD'); 
                                $('#CurrencySign').val('$'); break;
                                break;
                            case 'GBP': 
                                $('#ISOCurrency').val('GBP');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val('GBP'); 
                                $('#CurrencySign').val('£'); break;
                            case 'EUR': 
                                $('#ISOCurrency').val('EUR');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val('EUR'); 
                                $('#CurrencySign').val('€');
                                break;
                            case 'BRL': 
                                $('#ISOCurrency').val('BRL');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val(''); 
                                $('#CurrencySign').val('R$ ');
                                break;
                            case 'INR': 
                                $('#ISOCurrency').val('INR');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val('INR'); 
                                $('#CurrencySign').val('');
                                break;
                            case 'CAD': 
                                $('#ISOCurrency').val('CAD');
                                $('#CurrencyFormat').val('1,234.56'); 
                                $('#CurrencyCode').val('CAD'); 
                                $('#CurrencySign').val('$'); 
                                break;
                            case 'ZAR': 
                                $('#ISOCurrency').val('ZAR');
                                $('#CurrencyFormat').val('1 234.56');
                                $('#CurrencyCode').val('ZAR'); 
                                $('#CurrencySign').val('R'); 
                                break;
                        }
                        return false;
                    }
                    function checkdefault(el) {
                        if($(el).val()=='default') {
                            alert("Please note: Default clientarea is DEPRECATED and left only for backwards compatibility");
                        }
                    }
                    function shx() {
                        $('.cart_d').hide().eq($('#template').eq(0).prop("selectedIndex")).show();
                    }/*		
$(document).ready(function(){
$('a.colorbox').colorbox({width:"80%", height:"80%", iframe:true,opacity:0.5});
});*/
		
                    {/literal}</script>
                <table border="0" cellpadding="10" width="100%" cellspacing="0">
                    <tr class="bordme">
                        <td width="205" align="right"><strong>{$lang.MaintenanceMode}</strong></td><td><input name="MaintenanceMode" type="checkbox" value="on" {if $configuration.MaintenanceMode=='on'}checked="checked"{/if}  class="inp"/> {$lang.MaintenanceMode_descr}</td></tr>
                    <tr class="bordme"><td width="205" align="right"><strong>{$lang.BusinessName}</strong></td><td><input style="width:50%" name="BusinessName" value="{$configuration.BusinessName}"  class="inp"/></td></tr>
                    <tr  class="bordme"><td width="205" align="right"><strong>{$lang.UserTemplate}</strong></td><td><select style="width:40%" name="UserTemplate"  class="inp" onchange="shx();checkdefault(this);"  id="template">{foreach from=$templates item=t}<option {if $configuration.UserTemplate==$t}selected="selected"{/if}>{$t}</option>{/foreach}</select>{foreach from=$templates item=t}
                            <span {if $configuration.UserTemplate!=$t}style="display:none"{/if} class="cart_d"> <a href="{$system_url}?systemtemplate={$t}" target="_blank" class="colorbox editbtn" title="{$t} template">{$lang.clicktopreview}</a></span>
		{/foreach}

                        </td></tr>
                    <tr  class="bordme">
                        <td width="205" align="right"><strong>{$lang.UserLanguage}</strong></td>
                        <td><select style="width:40%" name="UserLanguage"  class="inp">{foreach from=$user_languages item=t}<option {if $configuration.UserLanguage==$t}selected="selected"{/if} value="{$t}">{$t|ucfirst}</option>{/foreach}</select>
						<span><a href="?cmd=langedit" class="colorbox editbtn" title="{$lang.languages}">{$lang.languages}</a></span></td></tr>

                    <tr  class="bordme"><td width="205" align="right"><strong>{$lang.UserCountry}</strong></td><td>
                            <select style="width:50%" name="UserCountry" class="inp">
                                {foreach from=$countries key=k item=v}
                                <option value="{$k}" {if $k==$configuration.UserCountry} selected="selected"{/if}>{$v}</option>

                                {/foreach}
                            </select>
                        </td></tr>


                        <tr  class="bordme"><td width="205" align="right"><strong>{$lang.DefaultTimezone}</strong></td><td>
                            <select style="width:50%" name="DefaultTimezone" class="inp">
                               {foreach from=$timezones item=zone key=code}
                                    <option value="{$code}" {if $code==$configuration.DefaultTimezone}selected="selected"{/if}>{$zone}</option>
                               {/foreach}
                            </select>
                        </td></tr>

                    <tr >
                        <td align="right"><strong>{$lang.DateFormat}</strong></td><td><select style="width:50%" name="DateFormat" class="inp">
                                <option value="YYYY-MM-DD" {if $configuration.DateFormat=='YYYY-MM-DD'}selected="selected"{/if}>YYYY-MM-DD ({''|dateformat:'Y-m-d'})</option>
                                <option value="MM/DD/YYYY" {if $configuration.DateFormat=='MM/DD/YYYY'}selected="selected"{/if}>MM/DD/YYYY ({''|dateformat:'m/d/Y'})</option>
                                <option value="DD/MM/YYYY" {if $configuration.DateFormat=='DD/MM/YYYY'}selected="selected"{/if}>DD/MM/YYYY ({''|dateformat:'d/m/Y'})</option>
                                <option value="DD.MM.YYYY" {if $configuration.DateFormat=='DD.MM.YYYY'}selected="selected"{/if}>DD.MM.YYYY ({''|dateformat:'d.m.Y'})</option>
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="sectioncontent" style="display:none">

                <table border="0" cellpadding="10" width="100%" cellspacing="0">
                    <tr class="bordme"><td width="205" align="right"><strong>{$lang.ApplyTermsURL}</strong></td><td><input type="checkbox" value="1" {if $configuration.ApplyTermsURL!=''}checked="checked"{/if} onclick="check_i(this)"/><input style="width:50%" name="ApplyTermsURL" value="{$configuration.ApplyTermsURL}" class="config_val inp" {if $configuration.ApplyTermsURL==''}disabled="disabled"{/if}/></td></tr>

                    <tr >
                        <td width="205" align="right" valign="top"><strong>多商品购物车</strong></td><td>
                            <input type="radio" name="ShopingCartMode" value="1" {if $configuration.ShopingCartMode=='1'} checked="checked"{/if}/> <strong>{$lang.Enable}</strong>, 允许购物车内放置一个以上的服务<br />
                            <input type="radio" name="ShopingCartMode" value="0" {if $configuration.ShopingCartMode=='0'} checked="checked"{/if}/> <strong>{$lang.Disable}</strong>, 购物车仅能放置一个服务<br />
                        </td>
                    </tr>

                    <tr ><td width="205" align="right" valign="top"><strong>{$lang.AfterOrderRedirect}</strong></td><td>

                            <input type="radio" name="AfterOrderRedirect" value="0" {if $configuration.AfterOrderRedirect=='0'} checked="checked"{/if}/> {$lang.AfterOrderRedirect0}<br />
                            <input type="radio" name="AfterOrderRedirect" value="1" {if $configuration.AfterOrderRedirect=='1'} checked="checked"{/if}/> {$lang.AfterOrderRedirect1}<br />
                            <input type="radio" name="AfterOrderRedirect" value="2" {if $configuration.AfterOrderRedirect=='2'} checked="checked"{/if}/> {$lang.AfterOrderRedirect2}<br />
                        </td></tr>					

                </table>
            </div>

            <div class="sectioncontent" style="display:none">
                <table border="0" cellpadding="10" width="100%" cellspacing="0">
                    <tr  class="bordme"><td align="right" width="205"><strong>{$lang.AllowedAttachmentExt}</strong></td><td><input style="width:50%" name="AllowedAttachmentExt" value="{$configuration.AllowedAttachmentExt}" id="extensions" class="inp"/>&nbsp;<a href="" onclick="add_extension(); return false;">{$lang.addext}</a></td></tr>
                    <tr  class="bordme">
                        <td align="right"><strong>{$lang.MaxAttachmentSize}</strong></td>
                        <td>
                            <input style="width:50px" name="MaxAttachmentSize" value="{$configuration.MaxAttachmentSize}" class="inp"/>&nbsp;{$lang.MaxAttachmentSize_descr}
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.CaptchaUnregTickets}</strong></td>
                        <td>
                            <input name="CaptchaUnregTickets" type="radio" value="on_all" {if $configuration.CaptchaUnregTickets=='on_all'}checked="checked"{/if}  /> <strong>{$lang.yes}</strong>, {$lang.CaptchaAllTickets_descr}<br />
                            <input name="CaptchaUnregTickets" type="radio" value="on" {if $configuration.CaptchaUnregTickets=='on'}checked="checked"{/if}  /> <strong>{$lang.yes}</strong>, {$lang.CaptchaUnregTickets_descr}<br />
                            <input name="CaptchaUnregTickets" type="radio" value="off" {if $configuration.CaptchaUnregTickets=='off'}checked="checked"{/if}  /> <strong>{$lang.no}</strong>, {$lang.CaptchaUnregTickets_descr1}
                        </td>
                    </tr>
                    
                    <tr>
                        <td align="right"><strong>导入工单中的HTML</strong> </td>
                        <td>
                            <input name="TicketHTMLTags" type="radio" value="on" {if $configuration.TicketHTMLTags=='on'}checked="checked"{/if}  /> <strong>{$lang.yes}</strong>, HTML标签将显示在工单信息中 <br />
                            <input name="TicketHTMLTags" type="radio" value="off" {if $configuration.TicketHTMLTags=='off' || !$configuration.TicketHTMLTags }checked="checked"{/if}  /> <strong>{$lang.no}</strong>, HTML标签将在工单信息中被完全屏蔽
                        </td>
                    </tr>
                </table>
            </div>

            <!-- invoices -->


            <div class="sectioncontent" style="display:none">
                <table border="0" cellpadding="10" width="100%" cellspacing="0"  class="sectioncontenttable">

                    <tr>
                        <td colspan="4" align="center">
                            <div style="width:70%">
                                <div class="left" style="padding:5px;margin-right:5px;width:46%;border-right:solid 1px #c0c0c0;text-align:left">
                                    <input type="radio" name="InvoiceModel" value="default" checked="checked" onclick="$('.definvoices').show();$('.euinvoices').hide();" {if $configuration.InvoiceModel=='default'}checked="checked"{/if} id="nom_invmodel"/>	<label  for="nom_invmodel" style="font-size:16px !important;font-weight:bold">{$lang.def_invmethod}</label><br />
								{$lang.def_invmethod_descr}

                                </div>
                                <div  class="left" style="width:46%;padding:5px;margin-left:5px;text-align:left;">
                                    <input type="radio" name="InvoiceModel" value="eu" onclick="$('.definvoices').hide();$('.euinvoices').show();" {if $configuration.InvoiceModel=='eu'}checked="checked"{/if} id="eu_invmodel"/>	<label for="eu_invmodel" style="font-size:16px !important;font-weight:bold">{$lang.eu_invmethod}</label><br />
								{$lang.eu_invmethod_descr}
                                </div>
                                <div class="clear"></div></div>
                        </td>
                    </tr>

                    <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}><td align="right" ><strong>{$lang.InvoiceNumerationFrom}</strong></td><td colspan="3"><input style="width:80px" name="InvoiceNumerationFrom" value="{$configuration.InvoiceNumerationFrom}" class="inp"/></td></tr>


                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                        <td align="right"><strong>{$lang.InvoiceNumerationFrom}</strong></td><td  width="305"><input style="width:100px" name="InvoiceNumerationPaid" value="{$configuration.InvoiceNumerationPaid}" class="inp"/></td>
                        <td align="right" width="205"><strong>{$lang.ProFormaNumerationFrom}</strong></td><td><input style="width:100px" name="InvoiceNumerationFrom_eu" value="{$configuration.InvoiceNumerationFrom}" class="inp"/></td>


                    </tr>

                    <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}>
                        <td align="right"><strong>{$lang.InvoicePrefix}</strong></td><td colspan="3">
                            <select class="inp" name="InvoicePrefix_list" id="InvoicePrefix_list" onchange="if($(this).val()=='0') $('#InvoicePrefix_custom').show(); else  $('#InvoicePrefix').val($(this).val());">
                                <option value="" {if $configuration.InvoicePrefixdc==""}selected="selected"{/if}>{$lang.none}</option>
                                <option value="{literal}{$m}{/literal}" {if $configuration.InvoicePrefixdc=="m"}selected="selected"{/if}>MM</option>
                                <option value="{literal}{$y}{/literal}" {if $configuration.InvoicePrefixdc=="y"}selected="selected"{/if}>YYYY</option>
                                <option value="{literal}{$y}{$m}{/literal}" {if $configuration.InvoicePrefixdc=="ym"}selected="selected"{/if}>YYYYMM</option>
                                <option value="0"  
                                        {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}selected="selected"{/if}>{$lang.other}</option>

                            </select>
                            <a class="editbtn" href="#" onclick="$('#InvoicePrefix_custom').toggle();return false;">{$lang.customize}</a>
                            <div id="InvoicePrefix_custom" style="margin-top:10px;
                                 {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}{else}display:none{/if}"><input style="width:100px" name="InvoicePrefix" id="InvoicePrefix"  value="{$configuration.InvoicePrefix}" class="inp"/>
                                <br /><small>{$lang.InvoicePrefix_desc}</small>
                            </div>

                        </td></tr>

                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                        <td align="right"><strong>{$lang.InvoiceNumerationFormat}</strong></td>
                        <td width="305">

                            <select class="inp" name="InvoiceNumerationFormat_list" id="InvoiceNumerationFormat_list" onchange="if($(this).val()=='0') $('#InvoiceNumerationFormat_custom').show(); else  $('#InvoiceNumerationFormat').val($(this).val());">
                                <option value="{literal}{$number}{/literal}" {if $configuration.InvoiceNumerationFormatdc=="number"}selected="selected"{/if}>number</option>
                                <option value="{literal}{$m}/{$number}{/literal}" {if $configuration.InvoiceNumerationFormatdc=="m/number"}selected="selected"{/if}>MM/number</option>
                                <option value="{literal}{$y}/{$number}{/literal}" {if $configuration.InvoiceNumerationFormatdc=="y/number"}selected="selected"{/if}>YYYY/number</option>
                                <option value="{literal}{$y}/{$m}/{$number}{/literal}" {if $configuration.InvoiceNumerationFormatdc=="y/m/number"}selected="selected"{/if}>YYYY/MM/number</option>
                                <option value="0"  
                                        {if $configuration.InvoiceNumerationFormatdc!='number' && $configuration.InvoiceNumerationFormatdc!='m/number' && $configuration.InvoiceNumerationFormatdc!='y/number' && $configuration.InvoiceNumerationFormatdc!='y/m/number'}selected="selected"{/if}>{$lang.other}</option>

                            </select>
                            <a class="editbtn" href="#" onclick="$('#InvoiceNumerationFormat_custom').toggle();return false;">{$lang.customize}</a>
                            <div id="InvoiceNumerationFormat_custom" style="margin-top:10px;
                                 {if $configuration.InvoiceNumerationFormatdc!='number' && $configuration.InvoiceNumerationFormatdc!='m/number' && $configuration.InvoiceNumerationFormatdc!='y/number' && $configuration.InvoiceNumerationFormatdc!='y/m/number'}{else}display:none{/if}">
                                <input style="width:100px" name="InvoiceNumerationFormat" id="InvoiceNumerationFormat"  value="{$configuration.InvoiceNumerationFormat}" class="inp"/>
                                <br /><small>{$lang.InvoicePrefix2_desc}</small>
                            </div>

                        </td>
                        <td align="right" width="205"><strong>{$lang.ProFormaPrefix}</strong></td>
                        <td >
                            <select class="inp" name="InvoicePrefix_eu_list" id="InvoicePrefix_eu_list" onchange="if($(this).val()=='0') $('#InvoicePrefix_eu_custom').show(); else  $('#InvoicePrefix_eu').val($(this).val());">
                                <option value="" {if $configuration.InvoicePrefixdc==""}selected="selected"{/if}>{$lang.none}</option>
                                <option value="{literal}{$m}{/literal}" {if $configuration.InvoicePrefixdc=="m"}selected="selected"{/if}>MM</option>
                                <option value="{literal}{$y}{/literal}" {if $configuration.InvoicePrefixdc=="y"}selected="selected"{/if}>YYYY</option>
                                <option value="{literal}{$y}{$m}{/literal}" {if $configuration.InvoicePrefixdc=="ym"}selected="selected"{/if}>YYYYMM</option>
                                <option value="0"  
                                        {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}selected="selected"{/if}>{$lang.other}</option>

                            </select>
                            <a class="editbtn" href="#" onclick="$('#InvoicePrefix_eu_custom').toggle();return false;">{$lang.customize}</a>
                            <div id="InvoicePrefix_eu_custom" style="margin-top:10px;
                                 {if $configuration.InvoicePrefixdc!='' && $configuration.InvoicePrefixdc!='m' && $configuration.InvoicePrefixdc!='y' && $configuration.InvoicePrefixdc!='ym'}{else}display:none{/if}"><input style="width:100px" name="InvoicePrefix_eu" id="InvoicePrefix_eu"  value="{$configuration.InvoicePrefix}" class="inp"/>
                                <br /><small>{$lang.InvoicePrefix_desc}</small>
                            </div>

                        </td>

                    </tr>

                    <tr class="bordme" ><td align="right"><strong>{$lang.InvoiceStoreClient}</strong></td><td colspan="3">
                            <input name="InvoiceStoreClient" type="radio" value="off" {if $configuration.InvoiceStoreClient=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong> {$lang.InvoiceStoreClient_descr}<br />
                            <input name="InvoiceStoreClient" type="radio" value="on" {if $configuration.InvoiceStoreClient=='on'}checked="checked"{/if}  class="inp"/>  <strong>{$lang.yes}, </strong>{$lang.InvoiceStoreClient1_descr}

                        </td></tr>

                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}>
                        <td align="right"><strong>{$lang.InvoicePaidAutoReset}</strong></td>
                        <td colspan="3">
                            <input name="InvoicePaidAutoReset" type="radio" value="0" {if $configuration.InvoicePaidAutoReset=='0'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong> {$lang.InvoicePaidAutoReset_descr}<br />
                            <input name="InvoicePaidAutoReset" type="radio" value="1" {if $configuration.InvoicePaidAutoReset=='1'}checked="checked"{/if}  class="inp"/>  <strong>{$lang.yes}, </strong>{$lang.InvoicePaidAutoReset1_descr}<br />
                            <input name="InvoicePaidAutoReset" type="radio" value="2" {if $configuration.InvoicePaidAutoReset=='2'}checked="checked"{/if}  class="inp"/>  <strong>{$lang.yes}, </strong>{$lang.InvoicePaidAutoReset2_descr}

                        </td>
                    </tr>

                    <tr class="bordme">
                        <td align="right"><strong>{$lang.ContinueInvoices}</strong></td>
                        <td colspan="3">
                            <input name="ContinueInvoices" type="radio" value="on" {if $configuration.ContinueInvoices=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong> {$lang.ContinueInvoices_descr}<br />
                            <input name="ContinueInvoices" type="radio" value="off" {if $configuration.ContinueInvoices=='off'}checked="checked"{/if}  class="inp"/>  <strong>{$lang.no}, </strong>{$lang.ContinueInvoices_descr1}
                        </td>
                    </tr>
                    
                    <tr class="bordme">
                        <td align="right"><strong>自动合并</strong></td>
                        <td colspan="3">
                            <input name="GenerateSeparateInvoices" type="radio" value="off" {if $configuration.GenerateSeparateInvoices!='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong> 自动合并生成账单到同一日期<br />
                            <input name="GenerateSeparateInvoices" type="radio" value="on" {if $configuration.GenerateSeparateInvoices=='on'}checked="checked"{/if}  class="inp"/>  <strong>{$lang.no}, </strong> 生成每个服务的单独账单
                        </td>
                    </tr>

                    <tr class="bordme definvoices" {if $configuration.InvoiceModel=='eu'}style="display:none"{/if}>
                        <td align="right" width="205"><strong>{$lang.AttachPDFInvoice}</strong>{if $memorywarn}<br/><b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="AttachPDFInvoice" type="radio" value="on" {if $configuration.AttachPDFInvoice=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.AttachPDFInvoice_descr}<br />
                            <input name="AttachPDFInvoice" type="radio" value="off" {if $configuration.AttachPDFInvoice=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.AttachPDFInvoice_descr1}
                        </td>
                    </tr>
                     <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.AttachProFormaInvoice}</strong>{if $memorywarn}<br/><b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="AttachPDFInvoiceUnpaid" type="radio" value="on" {if $configuration.AttachPDFInvoice=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.AttachPDFInvoice_descr3}<br />
                            <input name="AttachPDFInvoiceUnpaid" type="radio" value="off" {if $configuration.AttachPDFInvoice=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.AttachPDFInvoice_descr4}
                        </td>
                    </tr>
                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu' || $configuration.InvoiceDelay=='on'}style="display:none"{/if}" id="attachpaid">
                        <td align="right" width="205"><strong>{$lang.AttachPDFInvoice}</strong>{if $memorywarn}<br/><b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="AttachPDFInvoicePaid" type="radio" value="on" {if $configuration.AttachPDFInvoicePaid=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.AttachPDFInvoicePaid_descr}<br />
                            <input name="AttachPDFInvoicePaid" type="radio" value="off" {if $configuration.AttachPDFInvoicePaid=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.AttachPDFInvoicePaid_descr1}
                        </td>
                    </tr>
                    
                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.InvoiceDelay}</strong></td>
                        <td colspan="3">
                            <input name="InvoiceDelay" type="radio" value="off"  onclick="$('#attachpaid').fadeIn();" {if $configuration.InvoiceDelay=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.InvoiceDelay_descr}<br />
                            <input name="InvoiceDelay" type="radio" value="on"  onclick="$('#attachpaid').fadeOut();" {if $configuration.InvoiceDelay=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.InvoiceDelay_descr1} <input class="inp" value="{$configuration.InvoiceDelayDays}" name="InvoiceDelayDays" size="2" > {$lang.InvoiceDelay_descr2}
                        </td>
                    </tr>
                    
                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.StorePDFInvoice}</strong>{if $memorywarn}<br/><b style="color:red">{$lang.memory_limit_low}</b>{/if}</td>
                        <td colspan="3">
                            <input name="StorePDFInvoice" type="radio" value="on" {if $configuration.StorePDFInvoice=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.StorePDFInvoice_descr} <input class="inp" value="{if $configuration.StorePDFPath}{$configuration.StorePDFPath}{else}{$maindir}{/if}" name="StorePDFPath" style="width:205px"> <a class="vtip_description" title="{$lang.StorePDFInvoice_descr2}"></a><br />
                            <input name="StorePDFInvoice" type="radio" value="off" {if $configuration.StorePDFInvoice!='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.StorePDFInvoice_descr1}
                        </td>
                    </tr>
                    <tr class="bordme euinvoices" {if $configuration.InvoiceModel!='eu'}style="display:none"{/if}">
                        <td align="right" width="205"><strong>{$lang.AttachPDFCopy}</strong></td>
                        <td colspan="3">
                            <input name="AttachPDFCopy" type="radio" value="on" {if $configuration.AttachPDFCopy=='on'}checked="checked"{/if}  class="inp"/> <strong>{$lang.yes}, </strong>{$lang.AttachPDFCopy_descr}<br />
                            <input name="AttachPDFCopy" type="radio" value="off" {if $configuration.AttachPDFCopy=='off'}checked="checked"{/if}  class="inp"/> <strong>{$lang.no}, </strong>{$lang.AttachPDFCopy_descr1}
                        </td>
                    </tr>

                     <tr class="bordme" >
                        <td align="right"><strong>{$lang.BCCInvoiceEmails}</strong></td>
                        <td colspan="3"><input name="BCCInvoiceEmails_on" type="radio" value="off" {if $configuration.BCCInvoiceEmails==''}checked="checked"{/if}  /> {$lang.BCCInvoiceEmails1}<br />
                            <input name="BCCInvoiceEmails_on" type="radio" value="on" {if $configuration.BCCInvoiceEmails!=''}checked="checked"{/if}  /> {$lang.BCCInvoiceEmails2} <input class="inp" value="{$configuration.BCCInvoiceEmails}" name="BCCInvoiceEmails" style="width:160px"><br />
                        </td>
                     </tr>

                    <tr class="bordme">
                        <td align="right"><strong>{$lang.DontSendSubscrInvNotify}</strong></td>
                        <td colspan="3"><input name="DontSendSubscrInvNotify" type="radio" value="on" {if $configuration.DontSendSubscrInvNotify=='on'}checked="checked"{/if}  /> {$lang.DontSendSubscrInvNotify_descr}<br />
                            <input name="DontSendSubscrInvNotify" type="radio" value="off" {if $configuration.DontSendSubscrInvNotify=='off'}checked="checked"{/if}  /> {$lang.DontSendSubscrInvNotify_descr1}<br />
                        </td>
                    </tr>
                    <tr >
                        <td align="right"><strong>自动取消账单</strong></td>
                        <td colspan="3">
                            <input name="CancelInvoicesOnExpire" type="hidden"  value="off"/>
                            <input name="CancelInvoicesOnTerminate" type="hidden"  value="off"/>
                            <input name="CancelInvoicesOnExpire" type="checkbox" value="on" {if $configuration.CancelInvoicesOnExpire=='on'}checked="checked"{/if}  /> 当相关域名到期时取消续费账单<br />
                            <input name="CancelInvoicesOnTerminate" type="checkbox" value="on" {if $configuration.CancelInvoicesOnTerminate=='on'}checked="checked"{/if}  /> 相关账户被终止时取消过期的账单<br />
                        </td>
                    </tr>
                </table>
                

                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable" style="display:none">


                    <tr class="bordme" ><td align="right"><strong>{$lang.SupportedCC}</strong></td>
                        <td colspan="3"><input class="inp" value="{$configuration.SupportedCC}" name="SupportedCC" style="width:260px" /><br/><small>允许使用的信用卡类型,用逗号分开</small>
                        </td></tr>

                    <tr class="bordme">
                        <td  align="right" valign="top"><strong>允许存储信用卡信息</strong></td>
                        <td colspan="3">
                            <input type="radio" name="CCAllowStorage" value="on" {if $configuration.CCAllowStorage=='on'}checked="checked"{/if} />
                            <strong>是</strong>, 允许保存信用卡供以后使用<br />
                                
                            <input type="radio" name="CCAllowStorage" value="token" {if $configuration.CCAllowStorage=='token'}checked="checked"{/if} />
                            <strong>是</strong>, 不过只有通过支付接口 <strong>认证</strong> 的信用卡<br />
                                
                            <input type="radio" name="CCAllowStorage" value="off" {if $configuration.CCAllowStorage=='off'}checked="checked"{/if} />
                            <strong>不</strong>, 不要在数据库内保存信用卡信息<br />
                        </td>
                    </tr>
                    
                    <tr class="bordme"><td  align="right" valign="top"><strong>{$lang.CCAllowRemove}</strong></td>
                        <td colspan="3">
                            <input type="radio"
                                   name="CCAllowRemove"
                                   value="off"
                                   {if $configuration.CCAllowRemove=='off'}checked="checked"{/if} /><strong>{$lang.no}, </strong> {$lang.CCAllowRemove_dscr1}<br />

                            <input type="radio" name="CCAllowRemove"
                                   value="on"
                                   {if $configuration.CCAllowRemove=='on'}checked="checked"{/if} /> <strong>{$lang.yes}, </strong> {$lang.CCAllowRemove_dscr2}
                        </td>
                    </tr>

                    <tr>
                        <td  align="right" valign="top"><strong>{$lang.CCChargeAuto}</strong></td>
                        <td colspan="3">
                            <input type="radio"
                                   name="CCChargeAuto" 
                                   value="off" 
                                   {if $configuration.CCChargeAuto=='off'}checked="checked"{/if} 
                                   onclick="$('.chargefew').hide();"/>
                            <strong>{$lang.no}, </strong> {$lang.CCChargeAuto_dscr1}
                            <br />

                            <input type="radio" name="CCChargeAuto"
                                   value="on" 
                                   {if $configuration.CCChargeAuto=='on'}checked="checked"{/if} 
                                   onclick="$('.chargefew').show();"/> 
                            <strong>{$lang.yes}, </strong> {$lang.CCChargeAuto_dscr} 
                            <input type="text" size="3" {if $configuration.CCChargeAuto!='on'}value="0"{else}value="{$configuration.CCDaysBeforeCharge}"{/if} name="CCDaysBeforeCharge"/> {$lang.CCChargeAuto2}
                            <br />

                            <div class="chargefew" {if $configuration.CCChargeAuto!='on'}style="display:none"{/if}> <br />
                                <input type="radio" name="CCAttemptOnce" value="on" {if $configuration.CCAttemptOnce=='on'}checked="checked"{/if}/> {$lang.CCAttemptOnce}<br />
                                <input type="radio" name="CCAttemptOnce" value="off" {if $configuration.CCAttemptOnce=='off'}checked="checked"{/if}/> {$lang.CCAttemptOnce2}
                                <input type="text" size="3" name="CCRetryForDays" value="{$configuration.CCRetryForDays}" /> {$lang.days}
                            </div>
                            <div class="chargefew" {if $configuration.CCChargeAuto!='on'}style="display:none"{/if}> <br />
                                <input type="radio" name="CCForceAttempt" value="off" {if !$configuration.CCForceAttempt || $configuration.CCForceAttempt=='off'}checked="checked"{/if}/> <strong>{$lang.no}</strong>, 使用支付模块捕获相关账单支付 <br />
                                <input type="radio" name="CCForceAttempt" value="on" {if $configuration.CCForceAttempt=='on'}checked="checked"{/if}/> <strong>{$lang.Yes}</strong>, 使用信用卡模块, 无论账单关联的是信用卡或者非信用卡支付方式 
                            </div>
                        </td>

                    </tr>

                </table>

                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable" style="display:none">

                    <tr class="bordme"><td align="right"><strong>{$lang.OfferDeposit}</strong></td>
                        <td colspan="3"><input name="OfferDeposit" type="radio" value="off" {if $configuration.OfferDeposit=='off'}checked="checked"{/if}  onclick="$('#offerdeposit').hide();"/> <strong>{$lang.no}, </strong>{$lang.OfferDeposit_descr1}<br />
                            <input name="OfferDeposit" type="radio" value="on" {if $configuration.OfferDeposit=='on'}checked="checked"{/if}   onclick="$('#offerdeposit').show();"/> <strong>{$lang.yes}, </strong>{$lang.OfferDeposit_descr}<br />

                            <div id="offerdeposit" {if $configuration.OfferDeposit!='on'}style="display:none"{/if}>
                                {$lang.MinDeposit}:  <input name="MinDeposit" class="inp" value="{$configuration.MinDeposit}" size="4"/>  &nbsp;&nbsp;
                                {$lang.MaxDeposit}:  <input name="MaxDeposit" class="inp" value="{$configuration.MaxDeposit}" size="4"/> 
                            </div>

                        </td></tr>
                     <tr><td align="right"><strong>{$lang.AllowBulkPayment}</strong></td>
                        <td colspan="3"><input name="AllowBulkPayment" type="radio" value="off" {if $configuration.AllowBulkPayment=='off'}checked="checked"{/if} /> <strong>{$lang.no}, </strong>{$lang.AllowBulkPayment_descr1}<br />
                            <input name="AllowBulkPayment" type="radio" value="on" {if $configuration.AllowBulkPayment=='on'}checked="checked"{/if}   /> 
                            <strong>{$lang.yes}, </strong>{$lang.AllowBulkPayment_descr}<br />
                        </td>
                     </tr>
                </table>
                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable" style="display:none">
                    <tr class="bordme">
                        <td width="205" align="right"><strong>信用记录</strong></td>
                        <td >
                            <input type="radio" name="CnoteEnable" value="off" {if $configuration.CnoteEnable !='on'}checked="checked"{/if} onchange="c_note()" /> 禁用 <br />
                            <input type="radio" name="CnoteEnable" value="on" {if $configuration.CnoteEnable =='on'}checked="checked"{/if} onchange="c_note()"/> 启用
                        </td>
                    </tr>
                    <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                        <td width="205" align="right"><strong>{$lang.CNoteNumerationFrom}</strong></td>
                        <td >
                            <input style="width:100px" name="CNoteNumerationPaid" value="{$configuration.CNoteNumerationPaid}" class="inp"/>
                        </td>
                    </tr>

                    <tr class="bordme cnote" {if $configuration.CnoteEnable !='on'}style="display:none"{/if}>
                        <td width="205" align="right"><strong>{$lang.CNoteNumerationFormat}</strong></td>
                        <td >
                            <select class="inp" name="CNoteNumerationFormat_list" id="CNoteNumerationFormat_list" 
                                    onchange="if($(this).val()=='0') $('#CNoteNumerationFormat_custom').show(); else  $('#CNoteNumerationFormat').val($(this).val());">
                                <option value="{literal}{$number}{/literal}" {if $configuration.CNoteNumerationFormatdc=="number"}selected="selected"{/if}>number</option>
                                <option value="{literal}{$number}/{$m}{/literal}" {if $configuration.CNoteNumerationFormatdc=="number/m"}selected="selected"{/if}>number/MM</option>
                                <option value="{literal}{$number}/{$y}{/literal}" {if !$configuration.CNoteNumerationFormat || $configuration.CNoteNumerationFormatdc=="number/y"}selected="selected"{/if}>number/YYYY</option>
                                <option value="{literal}{$number}/{$m}/{$y}{/literal}" {if $configuration.CNoteNumerationFormatdc=="number/m/y"}selected="selected"{/if}>number/MM/YYYY</option>
                                <option value="0"  
                                {if $configuration.CNoteNumerationFormatdc && $configuration.CNoteNumerationFormatdc!='number' && $configuration.CNoteNumerationFormatdc!='number/m' 
                                    && $configuration.CNoteNumerationFormatdc!='number/y' && $configuration.CNoteNumerationFormatdc!='number/m/y'}selected="selected"{/if}>{$lang.other}</option>

                            </select>
                            <a class="editbtn" href="#" onclick="$('#CNoteNumerationFormat_custom').toggle();return false;">{$lang.customize}</a>
                            <div id="CNoteNumerationFormat_custom" style="margin-top:10px;
                                 {if $configuration.CNoteNumerationFormatdc && $configuration.CNoteNumerationFormatdc!='number' && $configuration.CNoteNumerationFormatdc!='number/m' 
                                    && $configuration.CNoteNumerationFormatdc!='number/y' && $configuration.CNoteNumerationFormatdc!='number/m/y'}{else}display:none{/if}">
                                <input style="width:100px" name="CNoteNumerationFormat" id="CNoteNumerationFormat"  value="{$configuration.CNoteNumerationFormat}" class="inp"/>
                                <br /><small>{$lang.InvoicePrefix2_desc}</small>
                            </div>

                        </td>
                    </tr>
                </table>
            </div>

            <div class="sectioncontent" style="display:none">
                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable4" >
                    <tr class="bordme"><td width="205" align="right"><strong>{$lang.sendeme}</strong></td><td>

                            <input name="EmailSwitch" type="radio" value="on" {if $configuration.EmailSwitch=='on'}checked="checked"{/if}/> <strong>{$lang.EmailSwitchd1}</strong><br />

                            <input name="EmailSwitch" type="radio" value="off" {if $configuration.EmailSwitch=='off'}checked="checked"{/if}/> <strong>{$lang.EmailSwitchd2}</strong>
                            <br />	
                        </td></tr>

                        <tr class="bordme"><td width="205" align="right"><strong>{$lang.SystemMail}</strong></td><td><input  style="width:50%" name="SystemMail" value="{$configuration.SystemMail}" class="inp"/></td></tr>

                       

                        <tr><td width="205" align="right"><strong>{$lang.MailerMethod}</strong></td><td>
                                <div class="left"><input type="radio" name="MailUseSMTP" value="off" {if $configuration.MailUseSMTP=='off'}checked="checked"{/if}  onclick="$('.smtp').hide();"/><strong>{$lang.MailUsePHP}</strong><br />

                                <input type="radio" name="MailUseSMTP" value="on" {if $configuration.MailUseSMTP=='on'}checked="checked"{/if} onclick="$('.smtp').show();"/><strong>{$lang.MailUseSMTP}</strong>
                                </div><div class="left" style="padding:10px 20px;">
<a class="new_control" href="#"   onclick="$(this).hide();$('#testmailsuite').show();return false;"><span class="wizard">{$lang.sendtestmail}</span></a>
<div id="testmailsuite" style="display:none">
<span id="testmailsuite2">
    Enter email address: <input type="text" name="testmail" id="testmailaddress" /> <a class="new_control" href="#"   onclick="testConfiguration() ;return false;"><span ><b>{$lang.Send}</b></span></a>
    </span><span  id="testing_result"></span>
</div>

</div>
                                <div class="clear"></div>
                            </td></tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP=='off'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPHost}</td>
                            <td><input class="inp" name="MailSMTPHost" value="{$configuration.MailSMTPHost}" /> {$lang.MailSMTPPort} <input class="inp" name="MailSMTPPort" value="{$configuration.MailSMTPPort}" size="3" /></td>				
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP=='off'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPUsername}</td>
                            <td><input class="inp" name="MailSMTPUsername" value="{$configuration.MailSMTPUsername}" /> </td>				
                        </tr>

                        <tr class="smtp" {if $configuration.MailUseSMTP=='off'}style="display:none"{/if}>
                            <td width="205" align="right">{$lang.MailSMTPPassword}</td>
                            <td><input class="inp" name="MailSMTPPassword" value="{$configuration.MailSMTPPassword}" type="password" /> </td>				
                        </tr>

                </table>
                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="sectioncontenttable4" style="display:none" >
                    <tr>
                        <td width="205" align="right"><strong>使用纯文本邮件</strong><br /> <small>(这将会把它们转换为HTML)</small> </td>
                        <td><input type="checkbox" name="ForceWraperOnPlaintext" value="on" {if $configuration.ForceWraperOnPlaintext=='on'}checked="checked"{/if} /> </td>
                    </tr>
                    <tr class="bordme">
                        <td width="205" align="right" valign="top">
                            <strong>{$lang.htmlwrapper}</strong>
                            <br><br> 
                            <a onclick="$(this).attr('href',$(this).attr('rel')+'&EmailHTMLWrapper='+$('#EmailHTMLWrapper').val());return true" class="new_control" href="?cmd=emailtemplates&action=preview&security_token={$security_token}&body=Your message will be placed here" rel="?cmd=emailtemplates&action=preview&security_token={$security_token}&body=Your message will be placed here" target="_blank">
                                <span class="zoom">{$lang.Preview}</span>
                            </a>
                        </td>
                        <td>
                            <textarea  style="width:50%;height:100px;" name="EmailHTMLWrapper" class="inp" id="EmailHTMLWrapper">{$configuration.EmailHTMLWrapper}</textarea><br/>
                            <small>{$lang.htmlwrapper_desc}</small>
                        </td>
                    </tr>
				
                 <tr class="bordme">
                     <td width="205" align="right" valign="top"><strong>{$lang.EmailSignature}</strong></td><td>
                         <textarea  style="width:50%;height:55px;" name="EmailSignature" class="inp">{$configuration.EmailSignature}</textarea><br />
                         <small>注意: HTML标签将从附加到纯文本的电子邮件签名里删除</small>
                     </td>
                 </tr>

                </table>
            </div>



            <div class="sectioncontent" style="display:none">
                <table border="0" cellpadding="10" width="100%" cellspacing="0" class="list-3content">
                    <tr class="bordme">
                        <td width="205px" align="right">
                            <strong>{$lang.CurrencyName}</strong>
                        </td>
                        <td>
                            <select style="width:25%" class="inp" onchange="c_reload(this)">
                                <option {if $configuration.ISOCurrency=='USD'}selected="selected"{/if}>USD</option>
                                <option {if $configuration.ISOCurrency=='GBP'}selected="selected"{/if}>GBP</option>
                                <option {if $configuration.ISOCurrency=='EUR'}selected="selected"{/if}>EUR</option>
                                <option {if $configuration.ISOCurrency=='BRL'}selected="selected"{/if}>BRL</option>
                                <option {if $configuration.ISOCurrency=='INR'}selected="selected"{/if}>INR</option>
                                <option {if $configuration.ISOCurrency=='CAD'}selected="selected"{/if}>CAD</option>
                                <option {if $configuration.ISOCurrency=='ZAR'}selected="selected"{/if}>ZAR</option>
                                <option value="-1" {if
                                        !( $configuration.ISOCurrency=='USD' || $configuration.ISOCurrency=='GBP' ||  $configuration.ISOCurrency=='BRL'
                                        ||  $configuration.ISOCurrency=='EUR' ||  $configuration.ISOCurrency=='INR'||  $configuration.ISOCurrency=='CAD'  ||  $configuration.ISOCurrency=='ZAR')}selected="selected"{/if}>{$lang.other}...</option>
                            </select>
                            <a class="editbtn" href="#" onclick="$('#currency_edit').toggle(); return false;">{$lang.customize}</a>
                        </td>
                    </tr>
                    <tbody id="currency_edit" {if $configuration.ISOCurrency=='USD' || $configuration.ISOCurrency=='GBP' ||  $configuration.ISOCurrency=='BRL'
                           ||  $configuration.ISOCurrency=='EUR' ||  $configuration.ISOCurrency=='INR'||  $configuration.ISOCurrency=='CAD'  ||  $configuration.ISOCurrency=='ZAR'}style="display:none"{/if} >
                        <tr class="bordme">
                            <td width="205px" align="right">
                                <strong>{$lang.Preview}</strong>
                            </td>
                            <td id="pricepreview">
                                <span></span>
                            </td>

                        </tr>
                        <tr class="bordme">
                            <td width="205px" align="right">
                                <strong>{$lang.CurrencyFormat}</strong>
                            </td>
                            <td>
                                <select style="width:25%" name="CurrencyFormat" id="CurrencyFormat" class="inp">
                                    <option value="1,234.56" {if $configuration.CurrencyFormat=="1,234.56"}selected="selected"{/if}>1,234.56</option>
                                    <option value="1.234,56" {if $configuration.CurrencyFormat=="1.234,56"}selected="selected"{/if}>1.234,56</option>
                                    <option value="1 234.56" {if $configuration.CurrencyFormat=="1 234.56"}selected="selected"{/if}>1 234.56</option>
                                    <option value="1 234,56" {if $configuration.CurrencyFormat=="1 234,56"}selected="selected"{/if}>1 234,56</option>
                                </select>
                            </td>
                        </tr>
                        
                        <tr class="bordme">
                            <td width="205px" align="right">
                                <strong>{$lang.ISOCurrency}</strong>
                            </td>
                            <td>
                                <input style="width:50px" name="ISOCurrency" id="ISOCurrency" value="{$configuration.ISOCurrency}"  class="inp"/>
                            </td>
                        </tr>
                        <tr class="bordme">
                            <td width="205px" align="right">
                                <strong>{$lang.CurrencyCode}</strong>
                            </td>
                            <td>
                                <input style="width:50px" name="CurrencyCode" id="CurrencyCode" value="{$configuration.CurrencyCode}"  class="inp"/>
                            </td>
                        </tr>
                        <tr>
                            <td width="205px" align="right">
                                <strong>{$lang.CurrencySign}</strong>
                            </td>
                            <td>
                                <input style="width:50px" name="CurrencySign" id="CurrencySign" value="{$configuration.CurrencySign}"  class="inp"/>
                            </td>
                        </tr>
                    </tbody>
                    <tbody>
                        <tr class="bordme">
                            <td align="right">
                                <strong>保存小数点后几位 <a href="#" class="vtip_description" title="在管理员区设置定价策略中小数点后的位数."></a></strong>
                            </td>
                            <td><span>{$configuration.DecimalPlaces} - <a class="editbtn" href="#" onclick="return confirm('注意: 减少小数点后的位数值将导致截断误差所有价格以适应新的格式.') && $(this).parent().hide() && $('#DecimalPlaces').show();">编辑</a></span>
                                {*}<select style="width:25%; display: none;" name="DecimalPlaces" id="DecimalPlaces" class="inp">
                                    <option value="0" {if $configuration.DecimalPlaces=="0"}selected="selected"{/if}>0</option>
                                    <option value="2" {if $configuration.DecimalPlaces=="2"}selected="selected"{/if}>2</option>
                                    <option value="3" {if $configuration.DecimalPlaces=="3"}selected="selected"{/if}>3</option>
                                    <option value="4" {if $configuration.DecimalPlaces=="4"}selected="selected"{/if}>4</option>
                                </select>
                                {*}
                                <input style="display: none;" size="3" type="number" step="2" name="DecimalPlaces" max="20" id="DecimalPlaces" class="inp" value="{$configuration.DecimalPlaces}"
                                       onkeyup="if(parseInt($(this).val().replace(/\D/g,'')) > 20) $(this).val(20);"/>
                            </td>
                        </tr>
                         <tr class="bordme">
                            <td align="right">
                                <strong>显示小数点后几位 <a href="#" class="vtip_description" title="小数点后显示位数, 在账单和订单中小数将自动四舍五入显示."></a></strong>
                            </td>
                            <td><span>{$configuration.DisplayDecimalPlaces} - <a class="editbtn" href="#" onclick="return $(this).parent().hide() && $('#DisplayDecimalPlaces').show();">编辑</a></span>
                                {*}<select style="width:25%; display: none;" name="DisplayDecimalPlaces" id="DisplayDecimalPlaces" class="inp">
                                    <option value="0" {if $configuration.DisplayDecimalPlaces=="0"}selected="selected"{/if}>0</option>
                                    <option value="2" {if $configuration.DisplayDecimalPlaces=="2"}selected="selected"{/if}>2</option>
                                    <option value="3" {if $configuration.DisplayDecimalPlaces=="3"}selected="selected"{/if}>3</option>
                                    <option value="4" {if $configuration.DisplayDecimalPlaces=="4"}selected="selected"{/if}>4</option>
                                </select>{*}
                                <input style="display: none;" size="3" type="number" step="2" name="DisplayDecimalPlaces" max="20" id="DisplayDecimalPlaces" class="inp" value="{$configuration.DisplayDecimalPlaces}"
                                       onkeyup="if(parseInt($(this).val().replace(/\D/g,'')) > 20) $(this).val(20);"/>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <script type="text/javascript">
                    {literal}
                        function pricepreview() {
                                
                            var sign = $('#CurrencySign').val();
                            var format = $('#CurrencyFormat option:selected').val();
                            var dp = $('#DecimalPlaces option:selected').val();
                            ajax_update('?cmd=configuration&action=pricepreview&sign='+sign+'&dp='+dp+'&format='+format,false,'#pricepreview');
                        }
                        $(document).ready(function(){
                            pricepreview();
                        });
                        $(document).on('change','#saveconfigform',function(){
                            pricepreview();
                        });
                    {/literal}    
                </script>
                <div class="list-3content" style="display: none;">

                    <div class="blu">
                        <input type="button"  value="{$lang.addnewcurrency}" style="font-weight:bold" onclick="$('#newcurr').toggle(); makeadd();"/> &nbsp;&nbsp;
                        <!--{$lang.ISOCurrency}: <strong>{$main.iso}</strong> {$lang.CurrencyCode}: <strong>{$main.code}</strong> {$lang.CurrencySign}: <strong>{$main.sign}</strong>-->
                    </div>
                    <div class="lighterblue" style="padding:5px;display:none;" id="newcurr">
                        <input type="hidden" value="" name="make" />

                        <table border="0" cellpadding="3" cellspacing="0" width="100%">
                            <tr> 
                                <td width="130"><strong>{$lang.currcode}</strong></td>
                                <td><input size="4" name="code"/><br /><small>{$lang.ccodedescr}</small></td>

                                <td width="130"><strong>{$lang.currsign}</strong></td>
                                <td><input size="4" name="sign"/><br /><small>{$lang.csigndescr}</small></td>

                                <td width="130"><strong>{$lang.currrate}</strong></td>
                                <td><input size="4" name="rate" value="1.0000"/><br /><small>{$lang.cratedescr}{$currency.code}</small></td>				
                            </tr>
                            <tr>
                                <td width="130" style="border:none;"><strong>{$lang.curriso}</strong></td>
                                <td style="border:none;"><input size="4" name="iso" /></td>	

                                <td width="130"><strong>{$lang.currupdate}</strong></td>
                                <td><input type="checkbox" name="update" value="1"/></td>

                                <td width="130"><strong>{$lang.CurrencyFormat}</strong></td>
                                <td>
                                    <select name="format" >
                                        <option>1,234.56</option>
                                        <option>1.234,56</option>
                                        <option>1 234.56</option>
                                        <option>1,234</option>
                                    </select>
                                </td>				
                            </tr>
                            <tr>

                                <td colspan="6"><center><input type="submit" style="font-weight:bold" value="{$lang.submit}"/> <input type="button" value="{$lang.Cancel}" onclick="$('#newcurr').hide()"/></center></td>				
                            </tr>
                        </table>


                    </div>
	{if $currencies}
                    <table class="glike" cellpadding="3" cellspacing="0"  width="100%">
                        <tr>
                            <th>{$lang.curriso}</th>
                            <th>{$lang.currsign}</th>
                            <th>{$lang.currcode}</th>				
                            <th>{$lang.currrate}</th>
                            <th>{$lang.currlastupdate}</th>		
                            <th>{$lang.currdisplay}</th>

                            <th width="60"></th>	
                        </tr>
		{foreach from=$currencies item=curr}
                        <tr id="curr_{$curr.id}">
                            <td><strong>{$curr.iso}</strong></td>
                            <td>{$curr.sign}</td>
                            <td>{$curr.code}</td>				
                            <td>{$curr.rate}</td>
                            <td>{$curr.last_changes|dateformat:$date_format}</td>		
                            <td><input type="checkbox" value="1" name="enable" {if $curr.enable}checked="checked"{/if} onclick="updateEnable(this,{$curr.id})"/></td>

                            <td><a href="?cmd=configuration&action=currency&getdetails={$curr.id}" class="editbtn" onclick="return showeditform(this,{$curr.id});"s>{$lang.Edit}</a>
                                <a href="?cmd=configuration&action=currency&make=delete&id={$curr.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.confirmCurrRemove}');">{$lang.remove}</a>
                            </td> 
                        </tr>

		{/foreach}
                    </table>
	{/if}
                    <script type="text/javascript"> {literal}
                        function makeadd() {
                            var make = $('#newcurr input[name=make]').val();
                            if (make == '') {
                                $('#newcurr input[name=make]').val('add')
                            } else {
                                $('#newcurr input[name=make]').val('')
                            }
                        }
                        function updateEnable(el,id) {
                            var vis=($(el).is(':checked'))?'1':'0';
                            ajax_update('?cmd=configuration&action=currency&make=upenable&enable='+vis+'&id='+id,false);return false;
                        } 
                        function showeditform(el,id) {
                            ajax_update($(el).attr('href'),false,'#curr_'+id);return false;
                        }
                        {/literal}
                    </script>
                </div>
            </div>
            <div class="sectioncontent" style="display:none">
                <table border="0" cellpadding="10" width="100%" cellspacing="0">
                    <tr class="bordme">
                        <td align="right" width="205">
                            <strong>{$lang.RecordsPerPage}</strong>
                        </td>
                        <td>
                            <select name="RecordsPerPage" class="inp">
                                <option value="25" {if $configuration.RecordsPerPage=='25'}selected="selected"{/if}>25</option>
                                <option value="50" {if $configuration.RecordsPerPage=='50'}selected="selected"{/if}>50</option>
                                <option value="75" {if $configuration.RecordsPerPage=='75'}selected="selected"{/if}>75</option>
                                <option value="100" {if $configuration.RecordsPerPage=='100'}selected="selected"{/if}>100</option>
                            </select> 
                        </td>
                    </tr>
                    <tr class="bordme">
                        <td align="right" width="205">
                            <strong>{$lang.EnableProfiles}</strong>
                        </td>
                        <td>
                            <input name="EnableProfiles" type="radio" value="on" {if $configuration.EnableProfiles=='on'}checked="checked"{/if}  /> <strong>{$lang.yes} </strong><br />
                            <input name="EnableProfiles" type="radio" value="off" {if $configuration.EnableProfiles=='off'}checked="checked"{/if}  /> <strong>{$lang.no} </strong>
                        </td>
                    </tr>
                    <tr class="bordme">
                        <td align="right" width="205">
                            <strong>{$lang.EnableClientScurity}</strong>
                        </td>
                        <td>
                            <input name="EnableClientScurity" type="radio" value="on" {if $configuration.EnableClientScurity=='on'}checked="checked"{/if}  /> <strong>{$lang.yes} </strong><br />
                            <input name="EnableClientScurity" type="radio" value="off" {if $configuration.EnableClientScurity=='off'}checked="checked"{/if}  /> <strong>{$lang.no} </strong>
                        </td>
                    </tr>
                     <tr class="bordme">
                         <td align="right" width="205" valign="top">
                            <strong>{$lang.SEOUrlMode}</strong>
                        </td>
                        <td>
                            <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();" value="index.php?/" {if $configuration.SEOUrlMode=='index.php?/'}checked="checked"{/if} class="left" id="seo_1" /> <label class="w150 left" for="seo_1">Default</label> <div class="code left">{$system_url}index.php?/cart/</div><br />
                            <div class="clear"></div>
                            <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();" value="index.php/" {if $configuration.SEOUrlMode=='index.php/'}checked="checked"{/if} class="left" id="seo_2"  /> <label class="w150 left" for="seo_2">Basic</label> <div class="code left">{$system_url}index.php/cart/</div> <br />
                             <div class="clear"></div>
                            <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideUp();" value="?/" {if $configuration.SEOUrlMode=='?/'}checked="checked"{/if}  class="left" id="seo_3"  /> <label class="w150 left" for="seo_3">Advanced</label> <div class="code left">{$system_url}?/cart/</div><br />
                            <div class="clear"></div>
                            <input name="SEOUrlMode" type="radio" onclick="$('#htacode').slideDown();" value="" {if $configuration.SEOUrlMode==''}checked="checked"{/if} class="left" id="seo_4" /> <label class="w150 left" for="seo_4">Apache Mod Rewrite</label> <div class="code left">{$system_url}cart/</div><br />
                             <div class="clear"></div>
                             <div id="htacode" class="code" style="{if $configuration.SEOUrlMode!=''} display:none;{/if}font-size:10px;width:500px;margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;padding:10px;">## create .htaccess file in main HostBill directory with contents below<br>
&lt;IfModule mod_rewrite.c&gt;<br>
    RewriteEngine On <br>
    RewriteBase {$rewritebase}<br>
    RewriteRule ^downloads/?$ ?cmd=downloads [NC,L]<br>
    {literal}RewriteCond %{REQUEST_FILENAME} !-f<br>
    RewriteCond %{REQUEST_FILENAME} !-d<br>
    RewriteRule ^(.*)$ index.php?/$1 [L]<br>
&lt;/IfModule&gt;{/literal}
                             </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div class="nicerblu" style="text-align:center">
        <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme"/>
    </div>
{securitytoken}</form>

<script type="text/javascript">
    {literal}
				
    function loadMod(el) {
   
        $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
        ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&parentid='+$(el).val(),{},'#loadable');

    }

    function changeFunction(el) {
        $('.mdesc').hide().eq(el.selectedIndex).ShowNicely();
        $('#subloader').html('<center><img src="ajax-loading.gif" /></center>');
        ajax_update('index.php?cmd=productaddons&action=showparentmod&addon_id={/literal}{$addon.id}{literal}&id='+$(el).val(),{},'#loadable');return false;
    }
    function switch_t3(el,id) {
        $('#automateoptions .billopt').removeClass('checked');
        $(el).addClass('checked');		
        if(id=="on1")
            $(el).removeClass('bfirst');
        $('input[name=autosetup]').removeAttr('checked');
        $('input#'+id).attr('checked','checked');
        $('#off1_a').hide();
        $('#on1_a').hide();
        $(el).parents('tbody.sectioncontent').find('.savesection').show();
        $('#'+id+'_a').show();
        return false;
    }
    function check_i(element) {
        var td = $(element).parent();
        if ($(element).is(':checked'))
            $(td).find('.config_val').removeAttr('disabled');
        else
            $(td).find('.config_val').attr('disabled','disabled');
    }
    function check_fee(elem){
        if($(elem).val() == '0')
            $('#fee_amount').hide();
        else
            $('#fee_amount').show();
    }
    function add_extension() {
        var ext=prompt("{/literal}{$lang.enterext}{literal}","");
        if(!ext)
            return false;
        if(ext.substr(0,1) == '.')
            ext = ext.substr(1);
        $('#extensions').val( $('#extensions').val()+';.'+ext);
    }
    function testConfiguration() {
        $('#testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
        ajax_update('?cmd=configuration&action=test_connection',
        {
             'SystemMail': $('input[name="SystemMail"]').val(),
             'testmailaddress': $('#testmailaddress').val(),
            'MailUseSMTP': $('input[name="MailUseSMTP"]:checked').val(),
            'MailSMTPHost': $('input[name="MailSMTPHost"]').val(),
            'MailSMTPPort': $('input[name="MailSMTPPort"]').val(),
            'MailSMTPUsername': $('input[name="MailSMTPUsername"]').val(),
            'MailSMTPPassword': $('input[name="MailSMTPPassword"]').val()
        },'#testing_result', false);
    }
    function bindMe() {
        $('#newshelfnav').TabbedMenu({elem:'.sectioncontent',picker:'.list-1elem',aclass:'active'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
        $('#newshelfnav').TabbedMenu({elem:'.subm1',picker:'.list-1elem'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});
        $('#newshelfnav').TabbedMenu({elem:'.sectioncontenttable',picker:'.list-2elem',picktab:true,{/literal}{if $picked_subtab}picked:{$picked_subtab}{/if}{literal}});
        $('#newshelfnav').TabbedMenu({elem:'.sectioncontenttable4',picker:'.list-4elem',picktab:true,{/literal}{if $picked_subtab}picked:{$picked_subtab}{/if}{literal}});
        $('#newshelfnav').TabbedMenu({elem:'.list-3content',picker:'.list-3elem',picktab:true,{/literal}{if $picked_subtab}picked:{$picked_subtab}{/if}{literal}});
        $('#newsetup1').click(function(){
            $(this).hide();		
            $('#newsetup').show();	
            return false; 
        });
        $('#recur_b .controls .editbtn').click(function(){
            var e=$(this).parent().parent().parent();
            e.find('.e1').hide();
            e.find('.e2').show();
            return false;
        });
        $('#recur_b .controls .delbtn').click(function(){
            var e=$(this).parent().parent().parent();
            e.find('.e2').hide();
            e.find('.e1').show();
            e.find('input').val('0.00');
            e.hide();						
            var id = e.attr('id').substr(0,1);						
            if($('#tbpricing select option:visible').length<1) { 
                $('#addpricing').show();
            }
            $('#tbpricing select option[value='+id+']').show();
						
            return false;
        });
    }
    function add_message(gr,id,msg) {
        var sel=$('#'+gr+'_msg select');
        sel.find('option:selected').removeAttr('selected');
        sel.prepend('<option value="'+id+'">'+msg+'</option>').find('option').eq(0).attr('selected','selected');
        return false;

    }
    appendLoader('bindMe');
    function addopt() {
        var e=$('#'+$('#tbpricing select').val()+'pricing');
        e.find('.inp').eq(0).val($('#newprice').val());
        e.find('.inp').eq(1).val($('#newsetup').val());
        e.find('.pricer_setup').html($('#newsetup').val());
        if($('#newsetup').val()!='0.00')
            e.find('.pricer_setup').parent().parent().show();
        e.find('.pricer').html($('#newprice').val());
        e.show();
        $('#tbpricing select option:selected').hide();
        if($('#tbpricing select option:visible').length<1) {
				 	
        } else {
            $('#tbpricing select option:visible').eq(0).attr('selected','selected');
            $('#addpricing').show();
        }
        $('#tbpricing').hide();
        $('#newprice').val('0.00');
        $('#newsetup').val('0.00').hide();$('#newsetup1').show();
				
        return false;
    }
    function switch_t2(el,id) {
        $('.billopt').removeClass('checked');
        $(el).addClass('checked');
		
        $('input[name=paytype]').removeAttr('checked').prop('checked', false);
        $('input#'+id).attr('checked','checked').prop('checked', true);
        $('#once_b').hide();
        $('#recur_b').hide();
        $('#'+id+'_b').show();
        $('#hidepricingadd').click();
	
        return false;
    }
    function c_note(){
        var val = $('input[name=CnoteEnable]:checked').val();
        if(val == 'on')
            $('.cnote').show()
        else
            $('.hide').show()
    }
    {/literal}
</script>
{/if}