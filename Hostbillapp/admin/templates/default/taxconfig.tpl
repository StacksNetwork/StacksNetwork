<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled selected">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
            <a href="?cmd=security"  class="tstyled">{$lang.securitysettings}</a>
            <a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a> 
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                <div class="newhorizontalnav"  id="newshelfnav">
                    <div class="list-1">
                        <ul>
                            <li><a href="?cmd=configuration&picked_tab=0">{$lang.generalconfig}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=1">{$lang.Ordering}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=2">{$lang.Support}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=3">{$lang.Billing}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=5">{$lang.Mail}</a></li>
                            <li class="active picked"><a href="?cmd=configuration&picked_tab=5">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=7">{$lang.Other}</a></li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems">
                            <ul >
                                <li><a href="?cmd=configuration&picked_tab=5&picked_subtab=0"><span>{$lang.maincurrency}</span></a></li>
                                <li><a href="?cmd=configuration&picked_tab=5&picked_subtab=1"><span>{$lang.addcurrencies}</span></a></li>
                                <li class="picked"><a href="?cmd=taxconfig"><span>{$lang.taxes}</span></a></li>
                                <li><a href="?cmd=currencytocountry"><span>国家货币</span></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nicerblu" id="ticketbody">
                    <div id="newtab">
                        <div class="tabb">
                            {if !$enabletax}<div class="imp_msg"><strong>{$lang.taxdisabled}</strong> </div>{/if}
                            <form action="" method="post">
                                <input type="hidden" name="make" value="changeconfig" />
                                <table width="100%" cellpadding="10" cellspacing="0">
                                    <tr class="bordme">
                                        <td width="205" align="right">
                                            <strong>{$lang.enabletax}</strong></td>
                                        <td>
                                            <input type="radio" name="EnableTax" {if $enabletax}checked="checked"{/if} value="on" 
	onclick="{literal}if($(this).is(':checked')) {$('.rest').show();} else {$('.rest').hide();}{/literal}"/>
                                                   <strong>{$lang.yes}, </strong> {$lang.EnableTax1}
                                            <br />

                                            <input type="radio" name="EnableTax" {if !$enabletax}checked="checked"{/if} value="off" 
	onclick="{literal}if($(this).is(':checked')) {$('.rest').hide();} else {$('.rest').show();}{/literal}"/>
                                                   <strong>{$lang.no}, </strong> {$lang.EnableTax2}
                                        </td>
                                        </td>
                                    </tr>
                                    <tr class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                        <td width="205" align="right"><strong>{$lang.compoundl2}</strong></td>
                                        <td >
                                            <input type="radio" name="CompoundL2" {if $compoundl2}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> {$lang.CompoundL21}
                                            <br />
                                            <input type="radio" name="CompoundL2" {if !$compoundl2}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> {$lang.CompoundL22}
                                        </td>

                                    </tr>
                                    <tr  class="rest bordme" {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>{$lang.addtolatefee}</strong></td>
                                        <td >
                                            <input type="radio" name="TaxLateFee" {if $taxlatefee}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> {$lang.TaxLateFee1}<br />
                                            <input type="radio" name="TaxLateFee" {if !$taxlatefee}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> {$lang.TaxLateFee2}
                                        </td>

                                    </tr>
                                    <tr  class="rest bordme"  {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>{$lang.applytodomains}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxDomains" {if $taxdomains}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> {$lang.TaxDomains1}<br />
                                            <input type="radio" name="TaxDomains" {if !$taxdomains}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> {$lang.TaxDomains2}

                                        </td>

                                    </tr>
                                    {if $taxtrackingstore}
                                    <tr  class="rest bordme"  {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>{$lang.TaxTimetracking}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxTimetracking" {if $taxtracking}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> {$lang.TaxTimetracking}<br />
                                            <input type="radio" name="TaxTimetracking" {if !$taxtracking}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> {$lang.TaxTimetracking1}

                                        </td>

                                    </tr>
                                    {/if}
                                    <tr  class="rest bordme"  {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>信用消费税收</strong></td>
                                        <td>
                                            <input type="radio" name="TaxCredited" {if $taxcredited}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> 
                                            仅从支付金额计算纳税不包括信用<br />
                                            <input type="radio" name="TaxCredited" {if !$taxcredited}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> 
                                            以净值金额计算纳税
                                        </td>
                                    </tr>
                                    <tr  class="rest bordme"  {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>计算负值税收</strong></td>
                                        <td>
                                            <input type="radio" name="AllowNegativeTax" {if $AllowNegativeTax}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> 
                                            计算所有负值账单中的税收<br />
                                            <input type="radio" name="AllowNegativeTax" {if !$AllowNegativeTax}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> 
                                            允许负值税收仅限于信用消费账单
                                        </td>
                                    </tr>
                                    <tr  class="rest bordme"  {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>{$lang.applytofunds}</strong></td>
                                        <td>
                                            <input type="radio" name="TaxClientFunds" {if $taxclientfunds=='gross'}checked="checked"{/if} value="gross" /><strong>{$lang.yes}, </strong> {$lang.TaxFunds3}<br />
                                            <input type="radio" name="TaxClientFunds" {if $taxclientfunds=='on'}checked="checked"{/if} value="on" /><strong>{$lang.yes}, </strong> {$lang.TaxFunds1}<br />
                                            <input type="radio" name="TaxClientFunds" {if !$taxclientfunds || $taxclientfunds=='off'}checked="checked"{/if} value="off" /><strong>{$lang.no}, </strong> {$lang.TaxFunds2}
                                        </td>

                                    </tr>
                                    <tr  class="rest" {if !$enabletax}style="display:none"{/if}>
                                         <td width="205" align="right"><strong>{$lang.taxtype}</strong> </td>
                                        <td>

                                            <select name="TaxType" class="inp"><option {if $taxtype=='inclusive'}selected="selected"{/if} value="inclusive" >{$lang.inclusive}</option><option {if $taxtype=='exclusive'}selected="selected"{/if} value="exclusive">{$lang.exclusive}</option></select></td>

                                    </tr>
                                    <tr><td colspan="2" align="center">
                                            <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme"/>
                                        </td>
                                    </tr>






                                </table>
                                {securitytoken}</form>
                            <br />
                            <br />






                            <div class="rest" style="{if !$enabletax}display:none;{/if}">
                                {if $taxes}

                                <h3>{$lang.taxrules}</h3>
                                <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                                    <tbody>
                                        <tr>	
                                            <th>{$lang.taxname}</th>
                                            <th>{$lang.country}</th>
                                            <th>{$lang.State}</th>
                                            <th>{$lang.Level}</th>
                                            <th>{$lang.Rate}</th>
                                            <th width="20"></th>
                                        </tr>

                                        {foreach from=$taxes item=tax}
                                        <tr>
                                            <td>{$tax.name}</td>
                                            <td>{if $tax.country!='0'}{$countries[$tax.country]}{else}{$lang.Allcountries}{/if}</td>
                                            <td>{if $tax.state!='0'}{$tax.state}{else}{$lang.Allstates}{/if}</td>
                                            <td>{$tax.type}</td>
                                            <td>{$tax.rate}%</td>
                                            <td><a href="?cmd=taxconfig&make=deletetax&id={$tax.id}&security_token={$security_token}" onclick="return confirm('{$lang.removetaxconfirm}')" class="delbtn">{$lang.Delete}</a></td></tr>
                                        {/foreach}



                                        <tr id="adtax_bt">	
                                            <th colspan="6" align="left">
                                                <a href="#" class="editbtn" onclick="$('#adtax_bt').hide();$('#addnewtax').show();return false;">{$lang.addnewtax}</a>&nbsp;
                                                <a href="#" class="editbtn" onclick="$('#adtax_bt').hide();$('#addpremadetax').show();return false;">{$lang.addpremadetax}</a>&nbsp;
                                                <a href="?cmd=taxconfig&make=removealltaxes&security_token={$security_token}" class="editbtn" onclick="return confirm('{$lang.confirmtaxremove}');">{$lang.removealltaxes}</a>&nbsp;
                                            </th>
                                        </tr>
                                    </tbody>

                                </table>
				{else}
                                <div id="adtax_bt">
                                    <div class="blank_state_smaller blank_forms">
                                        <div class="blank_info">
                                            <h3>{$lang.notaxrules}</h3>
                                            <span>{$lang.taxfewclicks}</span>
                                            <div class="clear"></div>
                                            <br>
                                            <a href="#" class="new_control" onclick="$('#adtax_bt').hide();$('#addnewtax').show();return false;">
                                                <span class="addsth">
                                                    <strong>{$lang.addnewtax}</strong>
                                                </span>
                                            </a>&nbsp;{$lang.Or}&nbsp;
                                            <a href="#" class="new_control" onclick="$('#adtax_bt').hide();$('#addpremadetax').show();return false;">
                                                <span class="addsth">
                                                    <strong>{$lang.usepremadetax}</strong>
                                                </span>
                                            </a>
                                            <div class="clear"></div>
                                        </div>
                                    </div>
                                </div>
                                <!--<input type="button" style="font-weight: bold" value="{$lang.addnewtax}" class="submitme" id="adtax_bt" onclick="$('#adtax_bt').hide();$('#addnewtax').show();return false;"/>-->
				{/if}	
                                <div class="blu" id="addnewtax" style="display:none">
                                    <form action="" method="post">
                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td>{$lang.Level}:</td><td> <select name="type" class="inp"><option>1</option><option>2</option></select></td>

                                                <td>{$lang.Name}:</td><td> <input type="text" size="30" name="name"  class="inp"/></td>

                                                <td class="fieldlabel">{$lang.taxrate}</td><td> <input type="text" value="0.00" size="10" name="rate"  class="inp"/> %</td>
                                            </tr>
                                        </table>
                                        <table cellspacing="2" cellpadding="3" border="0">
                                            <tr>
                                                <td valign="middle"><strong>{$lang.country}:</strong></td>
                                                <td><input type="radio" checked="" value="0" name="countrypick" onclick="$('#ct_').attr('disabled','disabled');"/> {$lang.applytoallcountries}<br/><input type="radio" value="1" name="countrypick" onclick="$('#ct_').removeAttr('disabled');"/> {$lang.applytospecificc} 
                                                    <select name="country" id="ct_" disabled="disabled" class="inp" >
                                                        {foreach from=$countries key=k item=v}
                                                        <option value="{$k}">{$v}</option>
                                                        {/foreach}
                                                    </select></td>
                                            </tr>

                                            <tr>
                                                <td valign="middle"><strong>{$lang.State}:</strong></td>
                                                <td><input type="radio" checked="" value="0" name="statepick" onclick="$('#stat_').attr('disabled','disabled');"/> {$lang.applytoallstates}<br/>
                                                    <input type="radio" value="1" name="statepick"  onclick="$('#stat_').removeAttr('disabled');"/> {$lang.applytospecifics} <input type="text" size="25" name="state" id="stat_" disabled="disabled"  class="inp"/></td>
                                            </tr>
                                        </table>

                                        <input type="hidden" value="addtax" name="make"/>
                                        <center> <input type="submit" style="font-weight: bold" value="{$lang.addnewtax}" class="submitme"/> <span class="orspace">{$lang.Or} <a href="#" charset=" editbtn" onclick="$('#adtax_bt').show();$('#addnewtax').hide();return false;">{$lang.Cancel}</a> </span></center>
                                        {securitytoken}</form>
                                </div>

                                <div class="blu" id="addpremadetax" style="display:none">
                                    <form action="" method="post">{$lang.choosecountry}&nbsp;
                                        <select name="country" id="ct_" class="inp" >
                                            {foreach from=$premade item=v}
                                            {if $countries.$v || $lang.$v}<option value="{$v}">{if $countries.$v}{$countries.$v}{else}{$lang.$v}{/if}</option>{/if}
                                            {/foreach}
                                        </select>

                                        <input type="hidden" value="addpremadetax" name="make"/>
                                        <center> <input type="submit" style="font-weight: bold" value="{$lang.addpremadetax}" class="submitme"/> <span class="orspace">{$lang.Or} <a href="#" charset=" editbtn" onclick="$('#adtax_bt').show();$('#addpremadetax').hide();return false;">{$lang.Cancel}</a> </span></center>
                                        {securitytoken}</form>
                                </div>
                            </div>

                        </div>


                    </div>

                </div>








            </div>	
            </div>
        </td></tr></table>