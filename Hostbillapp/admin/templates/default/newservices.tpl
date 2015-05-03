<input type="hidden" name="type" value="{$product.type}">

<input type="hidden" value="{$product.visible}" name="visible" id="prod_visibility" />
<input type="hidden" value="{$product.category_id}" name="category_id" id="category_id"/>
<input type="hidden" value="{$product.id}" name="product_id_"  id="product_id"/>

<table width="100%" cellspacing="0" cellpadding="10" border="0" >

    <tr>
        <td colspan="2" style="padding:0px;">
            <div class="newhorizontalnav" id="newshelfnav">
                <div class="list-1">
                    <ul>
                        <li>
                            <a href="#"><span class="ico money">{$lang.general_tab}</span></a>
                        </li>
                        <li >
                            <a href="#"><span class="ico plug">{$lang.connectapp_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.automation_tab}</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico gear">{$lang.Emails}</span></a>
                        </li>
                        <li id="components_tab">
                            <a href="#"><span class="ico globe">组件</span></a>
                        </li>
                        <li>
                            <a href="#"><span class="ico formn">{$lang.widgets_tab}</span></a>
                        </li>
                        <li class="last">
                            <a href="#"><span class="ico app">{$lang.other_tab}</span></a>
                        </li>

                    </ul>
                </div>
                <div class="list-2">
                    <div class="subm1 haveitems">
                        <ul >
						{if $product.visible=='1'}
                            <li><a href="#" onclick=" $('#prod_visibility').val('0');$('#hiddenmsg').show();saveProductFull();"><span >{$lang.hide_product}</span></a></li>
                        {/if}
                        <li ><a href="#" onclick="$(this).hide();$('#change_orderpage').ShowNicely().show();return false"><span >{$lang.change_orderpage}</span></a></li>
						{if $product.stock!='1'}
                            <li ><a href="#" onclick="$(this).hide();$('.stockcontrol').ShowNicely().find('input[name=\'stock\']').attr('checked','checked');"><span >{$lang.enable_stock}</span></a></li>
						{/if}
						{if $configuration.EnableProRata != 'on'}
                            <li ><a href="#" onclick="$('#prorated_ctrl').show();$('#prorata_on').click();$(this).hide();return false"><span >{$lang.new_EnableProRata}</span></a></li>
                        {/if}
                        {if $product.timevalidation=='1' && !($product.valid_to && $product.valid_to!='0000-00-00') && !($product.valid_from && $product.valid_from!='0000-00-00')}
                            <li ><a href="#" onclick="$(this).hide();$('.timecontrol').ShowNicely(); return false;"><span >启用基于时间的验证</span></a></li>
						{/if}
                        </ul>
                        <div class="right" style="color:#999999;padding-top:5px">
						{if $product.id!='new'}<strong>{$lang.cartlink}</strong> {$system_url}?cmd=cart&amp;action=add&amp;id={$product.id}{/if}
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="subm1" style="display:none"></div>
                    <div class="subm1 haveitems" style="display:none">
                        <ul >
                            <li><a  href="#"  onclick="return assignNewTask({$product_id},'services');" ><span class="addsth" ><strong>{$lang.addcustomautomation}</strong></span></a></li>
                            {if $otherproducts} <li><a  href="#"   id="premadeautomationswitch" onclick="$('#premadeautomation').show();$(this).hide();return false"><span class="addsth" >{$lang.copyautomation}</span></a></li>{/if}
                        </ul>
                    </div>
                    <div class="subm1" style="display:none"></div>
                
                    <div class="subm1 haveitems" style="display:none" id="components_menu">
                        <ul  class="list-3">
                            <li><a href="#"><span><b>{$lang.forms_tab}</b></span></a></li>
                            <li><a href="#"><span><b>{$lang.addons_tab}</b></span></a></li>
                            <li><a href="#"><span><b>{$lang.domains_tab}</b></span></a></li>
                            <li><a href="#"><span><b>Sub-products</b></span></a></li>
                            {foreach from=$extra_tabs item=etab key=ekey name=tabloop}
                            <li >
                                <a href="#"><span ><b>{if $lang[$ekey]}{$lang[$ekey]}{else}{$ekey}{/if}</b></span></a>
                            </li>
                            {/foreach}
                        </ul>



                    </div>
                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">
                        {if $product.id!='new'}
                        <ul >
                            <li>
                                <a href="#" onclick="return HBWidget.addCustomWidgetForm();"><span ><b>{$lang.assign_custom_widg}</b></span></a></li>

                            {if count($widgets)>1}
                            <li>
                                <a href="#" onclick="return HBWidget.enableAllWidgets();"><span >{$lang.enable_all_widgets}</span></a></li>
                            <li>
                                <a href="#" onclick="return HBWidget.disableAllWidgets();"><span >{$lang.disable_all_widgets}</span></a></li>
                            {/if}
                        </ul>
					{/if}
                    </div>
                    <div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">
					{if $product.id!='new'}
                        <ul >
						{if !$haveupgrades}<li>
                                <a href="#" onclick="$('#upgradesopt').ShowNicely();$(this).hide();return false;"><span >{$lang.enable_upgrades}</span></a></li>{/if}

                        </ul>
					{/if}
                    </div>

                </div>
            </div>
            <div class="imp_msg" style="margin-top:10px;{if $product.visible=='1'}display:none{/if}" id="hiddenmsg"><strong>{$lang.hidden_product_note}.</strong> <a class="editbtn" onclick=" $('#prod_visibility').val('1');$('#hiddenmsg').hide();saveProductFull();return false;" href="#">{$lang.show_product}</a></div>
        </td>
    </tr>
    <tr>

        <td valign="top" class="nicers" style="border:none;" colspan="2">
            <table width="100%" cellspacing="0" cellpadding="6">
                <tbody  class="sectioncontent">

                    <tr >
                        <td width="160" align="right"><strong>{$lang.productname}</strong></td>
                        <td class="editor-container">
                            
			 {if $product.id!='new'}
                            <div class="org-content havecontrols" ><span style=" font-size: 16px !important; font-weight: bold;" class="iseditable">{$product.tag_name}</span> <a href="#" class="editbtn controls iseditable">{$lang.Edit}</a></div>
                            <div class="editor">{hbinput value=$product.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="50" name="name"}
                            </div>
			  {else}			  
                            {hbinput value=$product.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="50" name="name"}
			 {/if}

                        </td>
                    </tr>

                    {if $product.id!='new'}
                    <tr style="display:none" id="change_orderpage"><td align="right"><strong>{$lang.OrderPage}</strong></td><td>
                            <select name="change_orderpage" onchange="this.form.submit()">
                                {foreach from=$categories item=ord_pg}
                                <option value="{$ord_pg.id}" {if $ord_pg.id == $product.category_id}selected="selected"{/if}>{$ord_pg.name}</option>
                                {/foreach}
                            </select>
                        </td></tr>
                    {/if}

                    {include file='service_description.tpl'}
    <tr>
        <td valign="top" width="160" align="right"><strong>{$lang.Price}</strong></td>
        <td id="priceoptions">
            {foreach from=$supported_billingmodels item=bm name=boptloop}
            <a href="#" class="billopt {if $smarty.foreach.boptloop.first}bfirst{/if} {if $product.paytype==$bm}checked{/if}"  {if $product.paytype!=$bm}style="display:none"{/if} onclick='return switch_t2(this,"{$bm}");'>{if $lang[$bm]}{$lang[$bm]}{else}{$bm}{/if}</a>
            <input type="radio" value="{$bm}" name="paytype" {if $product.paytype==$bm}checked="checked"{/if}  id="{$bm}" style="display:none"/>
            {/foreach}

            <a href="#" class="editbtn" onclick="$(this).hide();$(this).parent().find('.billopt').show();return false;">{$lang.Change}</a>


                  {foreach from=$supported_billingmodels item=bm name=boptloop}{include file="productbilling_`$bm`.tpl"}{/foreach}
            

        </td>


    </tr>
    <tr >
         <td valign="top" align="right"><strong>{$lang.taxproduct}</strong></td>
        <td><input type="checkbox" {if $product.tax=='1'}checked="checked"{/if} name="tax" value="1"/></td>
    </tr>
    <tr  class="stockcontrol" {if $product.stock!='1'}style="display:none"{/if}>
         <td valign="top" align="right"><strong>{$lang.stockcontrol}</strong></td>
        <td><input type="checkbox" name="stock" value="1" {if $product.stock=='1'}checked="checked"{/if} onclick="if (this.checked) $('#sstoc').show(); else $('#sstoc').hide();"/></td>
    </tr>
    <tr id="sstoc" class="stockcontrol" {if $product.stock!='1'}style="display:none"{/if}>
        <td align="right">{$lang.quantityinstock}</td>
        <td ><input type="text" value="{$product.qty}" size="4" name="qty" class="inp"/>
        </td>
    </tr>


    <tr {if $configuration.EnableProRata == 'off'}style="display:none"{/if} id="prorated_ctrl">

        <td align="right"><strong>{$lang.new_EnableProRata}</strong></td>
        <td>
            <input type="radio" {if $configuration.EnableProRata == 'off'}checked="checked"{/if} name="config[EnableProRata]" value="off" onclick="$('#prorated').hide();" id="prorata_off"/> <label for="prorata_off"><strong>{$lang.no}</strong></label>
            <input type="radio" {if $configuration.EnableProRata == 'on'}checked="checked"{/if} name="config[EnableProRata]" value="on" onclick="$('#prorated').ShowNicely();" id="prorata_on"/> <label for="prorata_on"><strong>{$lang.yes}</strong></label>
        </td>
    </tr>
    <tr id="prorated" {if $configuration.EnableProRata == 'off'}style="display:none"{/if}>
        <td></td>
        <td>
	{$lang.new_ProRataDay} <input class="inp" size="2" name="config[ProRataDay]" value="{$configuration.ProRataDay}"/>
	{$lang.new_ProRataMonth} <select class="inp" name="config[ProRataMonth]">
                <option value="disabled" {if $configuration.ProRataMonth == 'disabled'}selected="selected"{/if}>{$lang.new_ProRataMonth_disabled}</option>
                <option value="January" {if $configuration.ProRataMonth == 'January'}selected="selected"{/if}>{$lang.January}</option>
                <option value="February" {if $configuration.ProRataMonth == 'February'}selected="selected"{/if}>{$lang.February}</option>
                <option value="March" {if $configuration.ProRataMonth == 'March'}selected="selected"{/if}>{$lang.March}</option>
                <option value="April" {if $configuration.ProRataMonth == 'April'}selected="selected"{/if}>{$lang.April}</option>
                <option value="May" {if $configuration.ProRataMonth == 'May'}selected="selected"{/if}>{$lang.May}</option>
                <option value="June" {if $configuration.ProRataMonth == 'June'}selected="selected"{/if}>{$lang.June}</option>
                <option value="July" {if $configuration.ProRataMonth == 'July'}selected="selected"{/if}>{$lang.July}</option>
                <option value="August" {if $configuration.ProRataMonth == 'August'}selected="selected"{/if}>{$lang.August}</option>
                <option value="September" {if $configuration.ProRataMonth == 'September'}selected="selected"{/if}>{$lang.September}</option>
                <option value="October" {if $configuration.ProRataMonth == 'October'}selected="selected"{/if}>{$lang.October}</option>
                <option value="November" {if $configuration.ProRataMonth == 'November'}selected="selected"{/if}>{$lang.November}</option>
                <option value="December" {if $configuration.ProRataMonth == 'December'}selected="selected"{/if}>{$lang.December}</option>
            </select><br />
            <span>{$lang.new_ProRataNextMonth} <a class="vtip_description" title="{$lang.promonthdesc}"></a> <input type="checkbox" onclick="check_i(this)" {if $configuration.ProRataNextMonth>0}checked="checked"{/if} value="1"/> <input type="text" name="config[ProRataNextMonth]" value="{$configuration.ProRataNextMonth}" class="config_val  inp" size="3" {if $configuration.ProRataNextMonth==0}disabled="disabled"{/if}/></span>

        </td>
    </tr>

</tbody>



<tbody class="sectioncontent" style="display:none">
    <tr id="module_tab_switcher" {if !$product.modules}style="display:none"{/if}>
        <td width="160" style="border-bottom:1px solid #CCCCCC"></td>
        <td style="border-bottom:1px solid #CCCCCC" id="module_tab_pick_container">
            <a class="module_tab_pick picked" href="">核心产品App</a>
            {if $product.modules}
                {foreach from=$product.modules item=module key=kl}
                    <a class="module_tab_pick" href="">增值产品App: {$module.modname}</a>
                {/foreach}
            {/if}
        </td>
    </tr>
    <tr>
        <td colspan="2" style="padding:10px 0px 0px !important" id="module_config_container">
            <table border="0" width="100%" cellpadding="6" cellspacing="0" id="mainmodule" class="module_config_tab">
                <tr>
                    <td align="right"  width="160"><strong>{$lang.third_party_app}</strong></td>
                    <td>
                        <select name="module" onchange="loadMod(this)" id="modulepicker" class="inp left modulepicker" style="width:200px;">
                            <option value="0" {if $product.module=='0'}selected="selected" {/if}>{$lang.none}</option>
                            {foreach from=$modules item=mod}{if $mod.id!='-1'}
                            <option value="{$mod.id}" {if $product.module==$mod.id}selected="selected" {/if}>{$mod.module}</option>{/if}
                            {/foreach}
                            <option value="new" style="font-weight:bold">显示未激活模块</option>
                        </select>
                       {if $showmultimodules} <a onclick="connectMoreApps(this);return false;" class="new_control right" href="#"><span class="addsth">连接更多Apps</span></a> {/if}

                    </td>
                </tr>
                <tbody id="loadable" class="loadable">
                    {if $product.module!=0}
                    {include file='ajax.configmodule.tpl'}
                    {/if}
                </tbody>

            </table>
            {if $product.modules}
                {foreach from=$product.modules item=module key=kl}
                    {include file='services/ajax.multimodules.tpl' options=$module.options default=$module.default}
                {/foreach}
            {/if}
        </td></tr>









</tbody>
<tbody id="billingsopt" class="sectioncontent" style="display:none">
    <tr><td colspan="2" style="padding:0px">
            <table class="editor-container" cellspacing="0" cellpadding="6" width="100%">
                <tr id="premadeautomation" style="display:none">
                    <td colspan="2">
                        {if $otherproducts} <div style="margin-bottom: 15px;"  class="p6">


                            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                <tbody><tr>
                                        <td>
                                            复制于: <select name="copy_from" class="submitme">
                                                {foreach from=$otherproducts item=oth}
                                                <option value="{$oth.id}">{$oth.catname} - {$oth.name}</option>
                                                {/foreach}
                                            </select>
                                        </td>
                                        <td>
                                            <input type="hidden" id="copyautomation" value="0" name="copyautomation" />
                                            <input type="button" value="Use it" style="font-weight:bold" onclick="$('#copyautomation').val(1);return saveProductFull();">
                                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#premadeautomation').hide();$('#premadeautomationswitch').show();return false;" class="editbtn">{$lang.Cancel}</a>
                                        </td>
                                    </tr>
                                </tbody></table>
                            <span class="pdescriptions fs11" >{$lang.configspeedup}</span>

                        </div>{/if}
                    </td>
                </tr>
                <tr>
                    <td colspan="2" id="tasklistloader">
					 {include file='ajax.tasklist.tpl'}
                    </td>
                </tr>

                <tr class="odd"> <td align="right" valign="top" width="200"><strong>{$lang.auto_create}</strong></td>
                    
                    <td id="automateoptions">
                        <input type="radio" value="0" name="autosetup2" {if $product.autosetup=='0'}checked="checked"{/if} id="autooff" onclick="$('#autosetup_opt').hide();$('#autooff_').click();"/><label for="autooff"><b>{$lang.no}</b></label>
                        <input type="radio"  value="1" name="autosetup2" {if $product.autosetup!='0'}checked="checked"{/if} id="autoon" onclick="$('#autosetup_opt').ShowNicely();$('#autoon_').click();"/><label for="autoon"><b>{$lang.yes}</b></label>
                            
                        <div class="p5" id="autosetup_opt" style="{if $product.autosetup=='0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                            <input type="radio" style="display:none" {if $product.autosetup=='0'}checked="checked"{/if} value="0" name="autosetup" id="autooff_"/>
                            <input type="radio" {if $product.autosetup=='3'}checked="checked"{/if} value="3" name="autosetup" id="autosetup3"/> <label for="autosetup3">{$lang.whenorderplaced}</label><br />
                            <input type="radio" {if $product.autosetup=='2'}checked="checked"{/if} value="2" name="autosetup" id="autoon_"/> <label for="autoon_">{$lang.whenpaymentreceived}</label><br />
                            <input type="radio" {if $product.autosetup=='1'}checked="checked"{/if} value="1" name="autosetup" id="autosetup1"/> <label for="autosetup1">{$lang.whenmanualaccept}</label><br />
                            <input type="radio" {if $product.autosetup=='4'}checked="checked"{/if} value="4" name="autosetup" id="autosetup4"/> <label for="autosetup4">{$lang.procesbycron}</label>
                            <div class="clear"></div>
                        </div>
                            
                            
                    </td>
                </tr>
                
                <tr>
                    <td width="200" valign="top" align="right"><strong>自动化升级</strong></td>
                    <td>
                        <input type="radio" {if $configuration.EnableAutoUpgrades == 'off'}checked="checked"{/if} 
                               name="config[EnableAutoUpgrades]" value="off" 
                               onclick="$('#upgrades_options').hide();" 
                               id="upgrades_off"/>
                        <label for="upgrades_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.EnableAutoUpgrades == 'on'}checked="checked"{/if} 
                               name="config[EnableAutoUpgrades]" value="on" 
                               onclick="$('#upgrades_options').ShowNicely();" 
                               id="upgrades_on"/>
                        <label  for="upgrades_on"><b>{$lang.yes}</b></label>
                        <div class="p5" id="upgrades_options" style="{if $configuration.EnableAutoUpgrades == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                            收到转账付款后自动升级账户 
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="200" valign="top" align="right"><strong>{$lang.new_EnableAutoSuspension}</strong></td>
                    <td>
                        <input type="radio" {if $configuration.EnableAutoSuspension == 'off'}checked="checked"{/if} name="config[EnableAutoSuspension]" value="off" onclick="$('#suspension_options').hide();" id="suspend_off"/><label  for="suspend_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.EnableAutoSuspension == 'on'}checked="checked"{/if} name="config[EnableAutoSuspension]" value="on" onclick="$('#suspension_options').ShowNicely()" id="suspend_on"/><label  for="suspend_on"><b>{$lang.yes}</b></label>
                        <div class="p5" id="suspension_options" style="{if $configuration.EnableAutoSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
	{$lang.new_EnableAutoSuspension1} <input type="text" size="3" value="{$configuration.AutoSuspensionPeriod}"  name="config[AutoSuspensionPeriod]" class="inp config_val" /> {$lang.new_EnableAutoSuspension2}

                        </div>

                    </td>
                </tr>

                <tr class="odd">
                    <td width="200"  valign="top" align="right"><strong>{$lang.new_EnableAutoUnSuspension}</strong></td>
                    <td>

                        <input type="radio" {if $configuration.EnableAutoUnSuspension == 'off'}checked="checked"{/if} name="config[EnableAutoUnSuspension]" value="off" onclick="$('#unsuspension_options').hide();" id="unsuspend_off"/><label  for="unsuspend_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.EnableAutoUnSuspension == 'on'}checked="checked"{/if} name="config[EnableAutoUnSuspension]" value="on" onclick="$('#unsuspension_options').ShowNicely();" id="unsuspend_on"/><label  for="unsuspend_on"><b>{$lang.yes}</b></label>



                        <div class="p5" id="unsuspension_options" style="{if $configuration.EnableAutoUnSuspension == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
	{$lang.new_EnableAutoUnSuspension1}

                        </div>


                    </td>

                </tr>

                <tr>
                    <td width="200" valign="top" align="right"><strong>{$lang.new_EnableAutoTermination}</strong></td>
                    <td>
                        <input type="radio" {if $configuration.EnableAutoTermination == 'off'}checked="checked"{/if} name="config[EnableAutoTermination]" value="off" onclick="$('#termination_options').hide();" id="termination_off"/><label  for="termination_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.EnableAutoTermination == 'on'}checked="checked"{/if} name="config[EnableAutoTermination]" value="on" onclick="$('#termination_options').ShowNicely();" id="termination_on"/><label  for="termination_on"><b>{$lang.yes}</b></label>



                        <div class="p5" id="termination_options" style="{if $configuration.EnableAutoTermination == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
	{$lang.new_EnableAutoTermination1} <input type="text" size="3" value="{$configuration.AutoTerminationPeriod}" name="config[AutoTerminationPeriod]"  class="inp config_val" /> {$lang.new_EnableAutoTermination2} 


	

                        </div>


                    </td>

                </tr>
			
                <tr class="odd">
                    <td align="right"><strong>{$lang.InvoiceGeneration} </strong>
                    </td>
                    <td><input type="text" size="3" value="{$configuration.InvoiceGeneration}" name="config[InvoiceGeneration]" class="inp"/> {$lang.InvoiceGeneration2}</td>

                </tr>

        <tr class="odd">
                    <td align="right"><strong>Advanced due date settings </strong>
                    </td>
                    <td>
                        <input type="radio" {if $configuration.AdvancedDueDate == 'off'}checked="checked"{/if}   name="config[AdvancedDueDate]" value="off"  onclick="$('#advanceddue_options').hide();" id="advanceddue_off"/><label  for="advanceddue_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.AdvancedDueDate == 'on'}checked="checked"{/if}  name="config[AdvancedDueDate]" onclick="$('#advanceddue_options').ShowNicely();" id="advanceddue_on"/><label  for="advanceddue_on"><b>{$lang.yes}</b></label>

                        <div class="p5" id="advanceddue_options" style="{if $configuration.AdvancedDueDate == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >

                            {$lang.InvoiceExpectDays} <input type="text" size="3" class="inp" value="{$configuration.InvoiceExpectDays}" name="config[InvoiceExpectDays]"/> {$lang.InvoiceUnpaidReminder2}
                            <br/><br/>

                            {$lang.InitialDueDays} <input type="text" size="3" class="inp" value="{$configuration.InitialDueDays}" name="config[InitialDueDays]"/> {$lang.InitialDueDays2}
                            <br/><br/>


                        </div>
                    </td>
                </tr>





                <tr>
                    <td width="200" align="right" valign="top"><strong>{$lang.new_AutoProcessCancellations}</strong></td>
                    <td>
                        <input type="radio" {if $configuration.AutoProcessCancellations == 'off'}checked="checked"{/if} name="config[AutoProcessCancellations]" value="off" onclick="$('#cancelation_options').hide();" id="cancelation_off"/><label  for="cancelation_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.AutoProcessCancellations == 'on'}checked="checked"{/if} name="config[AutoProcessCancellations]" value="on" onclick="$('#cancelation_options').show();" id="cancelation_on"/><label  for="cancelation_on"><b>{$lang.yes}</b></label>

                        <div id="cancelation_options" style="{if $configuration.AutoProcessCancellations == 'off'}display:none;{/if}margin-top:10px;" class="p5">
                             {$lang.new_AutoProcessCancellations1} <br/>

                             <input type="radio" {if $configuration.AutoCancelUnpaidInvoices == 'off'}checked="checked"{/if} name="config[AutoCancelUnpaidInvoices]" value="off" /> <b>否</b>
                             <input type="radio" value="on" name="config[AutoCancelUnpaidInvoices]" {if $configuration.AutoCancelUnpaidInvoices == 'on'}checked="checked"{/if} /> <b>是</b>
                             自动取消相关的未付账单

                        </div>
                    </td>

                </tr>


                <tr class="odd">
                    <td width="200" align="right" valign="top"><strong>{$lang.new_SendPaymentReminderEmails}</strong></td>
                    <td>
                        <input type="radio" {if $configuration.SendPaymentReminderEmails == 'off'}checked="checked"{/if}   name="config[SendPaymentReminderEmails]" value="off"  onclick="$('#reminder_options').hide();" id="reminder_off"/><label  for="reminder_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.SendPaymentReminderEmails == 'on'}checked="checked"{/if}  name="config[SendPaymentReminderEmails]" onclick="$('#reminder_options').ShowNicely();" id="reminder_on"/><label  for="reminder_on"><b>{$lang.yes}</b></label>

                        <div class="p5" id="reminder_options" style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >

                           
                            {$lang.InvoiceUnpaidReminder} <span><input type="checkbox" value="1" {if $configuration.InvoiceUnpaidReminder>0}checked="checked"{/if} onclick="check_i(this)" />

                                                                       <input type="text" size="3" class="config_val  inp" {if $configuration.InvoiceUnpaidReminder<=0} value="0" disabled="disabled"{else}value="{$configuration.InvoiceUnpaidReminder}"{/if} name="config[InvoiceUnpaidReminder]"/> </span> {$lang.InvoiceUnpaidReminder2}
                            <br/><br/>

                            {$lang.1OverdueReminder}
                            <span>
                                <input type="checkbox" value="1" {if $configuration.1OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val  inp" {if $configuration.1OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.1OverdueReminder}"{/if} name="config[1OverdueReminder]"/>
                            </span>
                            <span>
                                <input type="checkbox" value="1" {if $configuration.2OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val inp" {if $configuration.2OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.2OverdueReminder}"{/if} name="config[2OverdueReminder]"/>
                            </span>
                            <span>
                                <input type="checkbox" value="1" {if $configuration.3OverdueReminder>0}checked="checked"{/if} onclick="check_i(this)" /><input type="text" size="3" class="config_val  inp" {if $configuration.3OverdueReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.3OverdueReminder}"{/if} name="config[3OverdueReminder]"/>
                            </span>
                            {$lang.1OverdueReminder2}


                        </div>
                    </td>
                </tr>

                <tr>
                    <td width="200" align="right" valign="top"><strong>{$lang.new_LateFeeType_on|capitalize}</strong></td>
                    <td>
                        <input type="radio" {if $configuration.LateFeeType == '0'}checked="checked"{/if} name="config[LateFeeType_sw]" value="0"  onclick="$('#latefee_options').hide();" id="latefee_off"/><label  for="latefee_off"><b>{$lang.no}</b></label>
                        <input type="radio" {if $configuration.LateFeeType != '0'}checked="checked"{/if} name="config[LateFeeType_sw]" value="1" onclick="$('#latefee_options').ShowNicely();" id="latefee_on"/><label  for="latefee_on"><b>{$lang.yes}</b></label>

                        <div class="p5" id="latefee_options" style="{if $configuration.LateFeeType == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >


	{$lang.new_LateFeeType_on1} <input size="1" class="inp config_val"  value="{$configuration.LateFeeValue}" name="config[LateFeeValue]"/>
                            <select  class="inp config_val" name="config[LateFeeType]">
                                <option {if $configuration.LateFeeType=='1'}selected="selected"{/if} value="1">%</option>
                                <option {if $configuration.LateFeeType=='2'}selected="selected"{/if}value="2">{if $currency.code}{$currency.code}{else}{$currency.iso}{/if}</option>
                            </select>
	 {$lang.new_LateFeeType_on2}<input type="text" size="3" value="{$configuration.AddLateFeeAfter}" name="config[AddLateFeeAfter]" class="config_val inp" /> {$lang.LateFeeType2x} <br />

                        </div>
                    </td>
                </tr>

                {if $typetemplates.productconfig.automation.append}
                    <tr >
                        <td colspan="2" style="padding:0px;">
                            {include file=$typetemplates.productconfig.automation.append}
                        </td>
                    </tr>
                {/if}


            </table>
        </td>
    </tr>
</tbody>


<tbody  style="display:none" class="sectioncontent editor-container" >

     {if !$custom_automation}
        {foreach from=$supported_emails item=em key=event name=llp}
        <tr {if $smarty.foreach.llp.index%2==0}class="odd"{/if}>
            <td width="200" align="right"><strong>{if $lang.$event}{$lang.$event}{else}{$event}{/if}</strong>{if $em.description}<a class="vtip_description" title="{$em.description}"></a>{/if}</td>
            <td><div class="editor-container" id="{$event}_msg">
                    <div class="no org-content " ><span class=" iseditable"><em>{if $product.emails.$event =='0' || !$product.emails.$event  }{$lang.none}{else}
                                            {foreach from=$emails.All item=emailtpl}{if $product.emails.$event==$emailtpl.id}{$emailtpl.tplname}{/if}{/foreach}{/if}</em>
                            <a href="#" class="editbtn  ">{$lang.Change}</a></span>
                        {if $product.welcome_email_id !='0'}
                        <a href="?cmd=emailtemplates&action=edit&id={$product.emails.$event}" target="blank" class="editbtn directlink editgray orspace">{$lang.Edit}</a>
                        <a href="?cmd=emailtemplates&action=preview&template_id={$product.emails.$event}" target="blank" class="editbtn directlink editgray orspace">{$lang.Preview}</a>
                        {/if}
                    </div>

                    <div class="ex editor" style="display:none"><select name="emails[{$event}]" class="inp">
                            <option value="0">{$lang.none}</option> {foreach from=$emails.All item=emailtpl} <option value="{$emailtpl.id}" {if $product.emails.$event ==$emailtpl.id}selected="selected" {/if}>{$emailtpl.tplname}</option>{/foreach}

                        </select>

                        <span class="orspace">{$lang.Or} </span>
                        <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to={/literal}{$event}{literal}' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>

                    </div>

                </div></td>

        </tr>
        {/foreach}

    {else}
        <tr >
            <td colspan="2">
                {include file=$custom_automation}
            </td>
        </tr>
    {/if}

</tbody>


<tbody  style="display:none" class="sectioncontent" >
    <tr><td colspan="2" style="padding:0px">
            <table border="0" cellspacing="0" cellpadding="6" width="100%">
                <tbody style="display:none" class="components_content" id="configfields">
                    {if $product.id=='new'}
                    <tr>
                        <td  align="center"   colspan="2">
                            <strong>{$lang.save_product_first}</strong>

                        </td>
                    </tr>
                    {else}
                    <tr id="importforms" style="display:none">
                        <td colspan="2">
                            <div style="margin-bottom: 15px;"  class="p6">


                                <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                                    <tbody><tr>
                                            <td>
                                                <input type="file" name="importforms" />
                                            </td>
                                            <td>
                                                <input type="button" value="Import" style="font-weight:bold" onclick="return saveProductFull();">
                                                <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#importforms').hide();$('#importformsswitch').show();return false;" class="editbtn">{$lang.Cancel}</a>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                <span class="pdescriptions fs11" >{$lang.importformsnotice}</span>

                            </div>
                        </td>
                    </tr>
                    <tr id="configeditor" >

                        <td id="configeditor_content" colspan="2">
                            {include file='ajax.configfields.tpl'}

                        </td>
                    </tr>
			{/if}

                </tbody>
                <tbody id="addconfigopt" class="components_content" style="display:none" >

			 {if $product.id=='new'}
                    <tr>
                        <td  align="center"   colspan="2">
                            <strong>{$lang.save_product_first}</strong> <a name="addons"></a>
                        </td>

                    </tr>
			 {else}




                    <tr id="addonseditor" >

                        <td id="addonsditor_content"  colspan="2">

			 {if $addons.addons || $addons.applied}
					{if $addons.applied}<div class="p5">
                                <table border="0" cellpadding="6" cellspacing="0" width="100%" >




					{foreach from=$addons.addons item=f}
				{if $f.assigned}<tr class="havecontrols">
                                        <td width="16">
                                            <div class="controls"><a href="#" class="rembtn"  onclick="return removeadd('{$f.id}')">{$lang.Remove}</a></div></td>
                                        <td align="left">{$lang.Addon}: <strong>{$f.name}</strong>
                                        </td>
                                        <td align="right">
                                            <div class="controls fs11">{$lang.goto} <a href="?cmd=productaddons&action=addon&id={$f.id}" class="editbtn editgray" style="float:none" target="_blank">{$lang.addonpage}</a></div>
                                        </td>
                                    </tr>{/if}{/foreach}


					
                                </table>


                            </div>
                                        <div style="padding:10px 4px">
        {if $addons.available}<a href="#" class="new_control" onclick="$(this).hide();$('#addnew_addons').ShowNicely();return false;"  id="addnew_addon_btn"><span class="addsth" >{$lang.assign_new_addons}</span></a>{/if}
        </div>
                                        {else}
                            <div class="blank_state_smaller blank_forms">
                                <div class="blank_info">
                                    <h3>{$lang.offeraddons}</h3>
                                    <span class="fs11">{$lang.paddonsbsdesc}</span>

                                    <div class="clear"></div>
                    <br/>
			{if $addons.available}
                        <a  href="#" class="new_control"  onclick="$('#addnew_addons').ShowNicely();return false;" ><span class="addsth" ><strong>{$lang.assign_new_addons}</strong></span></a>
                        {else}
                        <a href="?cmd=productaddons&action=addon&id=new"class="new_control"   target="_blank"><span class="addsth" ><strong>{$lang.createnewaddon}</strong></span></a>
                        {/if}
                                    <div class="clear"></div>

                                </div>
                            </div>
				{/if}

					{if $addons.available}<div class="p6" id="addnew_addons" style="display:none">
                                                       <table  cellpadding="3" cellspacing="0">
                                    <tr>
                                        <td>
				   {$lang.Addon}: <select name="addon_id">

					{foreach from=$addons.addons item=f}{if !$f.assigned}
                                                <option value="{$f.id}">{$f.name}</option>
					{/if} {/foreach}
                                            </select>
                                        </td>
                                        <td >
                                            <input type="button" value="{$lang.Add}" style="font-weight:bold" onclick="return addadd()"/>
                                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#addnew_addons').hide();$('#addnew_addon_btn').show();return false;" class="editbtn">{$lang.Cancel}</a>
                                        </td>
                                    </tr>

                                </table></div>{/if}
				{else}
                            <div class="blank_state_smaller blank_forms">
                                <div class="blank_info">
                                    <h3>{$lang.noaddonsyet}</h3>
                                    <div class="clear"></div>

                                    <div class="clear"></div>

                                </div>
                            </div>

		{/if}
                        </td>
                    </tr>
			 	 {/if}
                </tbody>
                <tbody id="domainsopt"  style="display:none" class="components_content" >


                    <tr id="domain_options_blank_state" {if $product.domain_options=='1'}style="display:none"{/if}>
                        <td colspan="2">
                            <div class="blank_state_smaller blank_domains">
                                <div class="blank_info">
                                    <h3>可以提供域名注册, 转移, 子域给该产品.</h3>
                                    <div class="clear"></div>
                                    <br/>
                                    <a  href="#" class="new_control"  onclick="$('#domain_options_container').show();$('#domain_options').eq(0).click();$(this).hide();return false;return false" ><span class="addsth" ><strong>{$lang.offerdomains}</strong></span></a>
                                    <div class="clear"></div>

                                </div>
                            </div>

                        </td>
                    </tr>

                    <tr id="domain_options_container" {if $product.domain_options!='1'}style="display:none"{/if}>
                        <td width="165" align="right"><b>{$lang.offerdomains}</b></td><td>
                            <input type="radio" value="1" {if $product.domain_options=='1'}checked="checked"{/if} name="domain_options" id="domain_options" onclick="$('#domain_options_blank_state').hide();$('.showdomopt').toggle();"/> <label for="domain_options">{$lang.yes}</label>
                            <input type="radio" value="0" {if $product.domain_options=='0'}checked="checked"{/if} name="domain_options" id="domain_options_no" onclick="$('.showdomopt').toggle();"/> <label for="domain_options_no">{$lang.no}</label>
                        </td></tr>

                    <tr {if $product.domain_options!='1'}style="display:none"{/if} class="showdomopt">

                        <td></td>
                        <td>
                            <table  cellpadding="6" cellspacing="0" class="editor-container" width="100%">

                                <tr>
                                    <td colspan="2"> <strong>下面提供域名注册/转移选项:</strong></td>

                                </tr>
                                <tr>
                                    <td colspan="2">
                                        {if !$domain_order}
                                        <div class="blank_state_smaller blank_domains" style="padding:10px 0px;">
                                            <div class="blank_info">
                                                <h3>您目前尚无任何域名订购页面.</h3>
                                                <span class="fs11">您可以配置各种订单页面的字段, 并可作为您套餐产品中的子产品.</span>
                                                <div class="clear"></div>
                                                <br/>
                                                <a  href="?cmd=services&action=addcategory" class="new_control"  target="_blank" ><span class="addsth" ><strong>创建新的域名订单页面</strong></span></a>
                                                <div class="clear"></div>

                                            </div>
                                        </div>
                                        {else}
                                        <select multiple name="domain_op[]" style="width:100%;height:120px;" id="domain_op"  class="multiopt">
                                            {foreach from=$domain_order item=do}
                                            <option value="{$do.id}" {if $product.subproducts.categories[$do.id]}selected="selected"{/if}>{$do.name}</option>
                                            {/foreach}
                                        </select>
                                        <span class="fs11"><a  href="?cmd=services&action=addcategory" class="editbtn"  target="_blank" >Create new domain orderpage</a></span>
                                        {/if}
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td width="160">
                                        <strong>{$lang.allow_own_dom}</strong>
                                    </td>
                                    <td >
                                        <input type="checkbox" name="owndomain" value="1" {if $product.owndomain=='1'}checked="checked"{/if} />
                                    </td>
                                </tr>
                                <tr class="odd">
                                    <td width="160">
                                        <strong>{$lang.require_hostname}</strong>
                                    </td>
                                    <td >
                                        <input type="checkbox" name="hostname" value="1" {if $product.hostname=='1'}checked="checked"{/if} />
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <strong>{$lang.offersubdomain}</strong>
                                        {if $product.subdomain==''}<a href="#" onclick="$(this).hide();$('#off_sub').show();return false;"><strong>{$lang.addsubdomain}</strong></a>{/if}<input type="text"  value="{$product.subdomain}" name="subdomain" style="width:98%;{if $product.subdomain==''}display:none;{/if}"  class="inp" id="off_sub" />
                                    </td>
                                </tr>
                                {if $domain_order} <tr class="odd">
                                    <td>
                                        <strong>{$lang.offerfreedom}</strong>
                                    </td>
                                    <td>
                                        <input type="checkbox"  name="free_domain" value="1" {if $product.free_domain=='1'}checked="checked"{/if} onclick="$('#freedomopt').toggle();"/>
                                    </td>

                                </tr>

                                <tr id="freedomopt" {if $product.free_domain!='1'}style="display:none;"{/if} class="odd"><td colspan="2">
                                        <table width="100%" cellpadding="6">
                                            <tr>
                                                <td valign="top" width="200">
											{$lang.offertlds}<br />
                                                    <select multiple="multiple" name="free_tlds[]" style="height:140px" >
											{foreach from=$tlds item=tld}
                                                        <option {if $product.free_tlds.tlds[$tld.tld]}selected="selected" {/if}>{$tld.tld}</option>
											{/foreach}
                                                    </select>
                                                </td>
                                                <td valign="top" >
											{$lang.offerperiods}<br />
                                                    <select multiple="multiple" name="free_tlds_cycles[]"  style="height:140px;width:70%" >
                                                        <option {if $product.free_tlds.cycles.Once}selected="selected" {/if} value="Once">{$lang.OneTime}</option>
                                                        <option {if $product.free_tlds.cycles.Hourly}selected="selected" {/if} value="Hourly">{$lang.Hourly}</option>
                                                        <option {if $product.free_tlds.cycles.Daily}selected="selected" {/if} value="Daily">{$lang.Daily}</option>
                                                        <option {if $product.free_tlds.cycles.Weekly}selected="selected" {/if} value="Weekly">{$lang.Weekly}</option>
                                                        <option {if $product.free_tlds.cycles.Monthly}selected="selected" {/if} value="Monthly">{$lang.Monthly}</option>
                                                        <option {if $product.free_tlds.cycles.Quarterly}selected="selected" {/if} value="Quarterly">{$lang.Quarterly}</option>
                                                        <option {if $product.free_tlds.cycles.SemiAnnually}selected="selected" {/if} value="SemiAnnually">{$lang.SemiAnnually}</option>
                                                        <option {if $product.free_tlds.cycles.Annually}selected="selected" {/if} value="Annually">{$lang.Annually}</option>
                                                        <option {if $product.free_tlds.cycles.Biennially}selected="selected" {/if} value="Biennially">{$lang.Biennially}</option>
                                                        <option {if $product.free_tlds.cycles.Triennially}selected="selected" {/if}  value="Triennially">{$lang.Triennially}</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </table>
                                    </td></tr>{/if}
                            </table>

                        </td>
                    </tr>



                </tbody>
                  <tbody style="display:none" class="components_content" id="subproducts">
                              <tr id="subprod_options_blank_state" {if $subproducts_applied}style="display:none"{/if}>
                        <td colspan="2">
                            <div class="blank_state_smaller blank_domains">
                                <div class="blank_info">
                                    <h3>对该产品提供其它套餐购买与自动化开通. All in One 订单</h3>
                                    <div class="clear"></div>
                                    <br/>
                                    <a  href="#" class="new_control"  onclick="$('#subproducts_options_container').show();$('#subprod_options_blank_state').hide();return false;return false" ><span class="addsth" ><strong>启用子产品</strong></span></a>
                                    <div class="clear"></div>

                                </div>
                            </div>

                        </td>
                    </tr>
                      <tr id="subproducts_options_container" {if !$subproducts_applied}style="display:none"{/if}>
                        <td colspan="2">
                              <b>Select packages you wish to offer as a sub-product</b>
                              <select multiple name="subproducts[]" style="width:100%;height:180px;margin-top:10px" id="subproducts_op"  class="multiopt">
                                            {foreach from=$subproducts item=do}
                                            <option value="{$do.id}" {if $product.subproducts.products[$do.id]}selected="selected"{/if}>{$do.category_name} - {$do.name}</option>
                                            {/foreach}
                                        </select>
                        </td>
                    </tr>


                </tbody>
                {foreach from=$extra_tabs item=etab key=ekey name=tabloop}
                    <tbody style="display:none" class="components_content"><tr><td colspan="2">{include file=$etab}</td></tr></tbody>
                    {/foreach}
            </table>

        </td></tr>


</tbody>	 


<tbody style="display:none"  class="sectioncontent">

	{if $product.id=='new'}
    <tr>
        <td  align="center"   colspan="2">
            <strong>{$lang.save_product_first}</strong>

        </td>
    </tr>
    {else}
    <tr id="widgeteditor" >

        <td id="widgeteditor_content" colspan="2">
            {include file='ajax.productwidgets.tpl'}

        </td>
    </tr>
			{/if}


</tbody>

<tbody style="display:none"  class="sectioncontent">
 <tr>
                    <td width="200" valign="top" align="right"><strong>每用户限制</strong></td>
                    <td>
                        <input type="radio" {if $product.client_limit == '0'}checked="checked"{/if} name="product_limit_customer" value="off" onclick="$('#limit_options').hide();$('#client_limit_val').val(0)" /><label  ><b>{$lang.no}</b></label>
                        <input type="radio" {if   $product.client_limit != '0'}checked="checked"{/if} name="product_limit_customer" value="on" onclick="$('#limit_options').ShowNicely()" /><label  ><b>{$lang.yes}</b></label>
                        <div class="p5" id="limit_options" style="{if $product.client_limit == '0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
	每个用户被允许购买 <input type="text" size="3" value="{$product.client_limit}"  name="client_limit" id="client_limit_val" class="inp config_val" /> 个该类型的产品

                        </div>

                    </td>
                </tr>

    <tr id="upgradesopt" {if !$haveupgrades}style="display:none"{/if}>
        <td colspan="2">
            <h3>{$lang.Upgrades}</h3>
            <table border="0" cellspacing="0" cellpadding="3" width="100%">
                <tr>
                    <td valign="top" align="center" width="49%">
							{if $upgrades}
							{$lang.aaplicableupgrades} <br />
                        <select multiple="multiple" name="upgrades2[]" style="width:100%;height:400px;" id="listAvailU" class="multiopt">

									{foreach from=$upgrades item=cat}
										{if !$cat.assigned}
                            <option value="{$cat.id}">{$cat.catname}:{$cat.name}</option>
										{/if}
									{/foreach}
                        </select><br />



							{else}
							 {$lang.noupgrades} 
							{/if}
                    </td>
                    <td valign="middle" width="40" align="center">
                        <input type="button" value=">>" onclick="addItem('upd');return false;" name="move" />
                        <input type="button" value="<<"  onclick="delItem('upd');return false;"  name="move" />
                    </td>
                    <td valign="top"  align="center"  width="49%">
							{$lang.appliedupgrades} <br />
                        <select multiple="multiple" name="upgrades[]" style="width:100%;height:400px;" id="listAlreadyU"  class="multiopt">

									{foreach from=$upgrades item=cat}
										{if $cat.assigned}
                            <option value="{$cat.id}">{$cat.catname}:{$cat.name}</option>
										{/if}
									{/foreach}
                        </select>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</tbody>
			  




</table>
</td>

</tr>
<tr>
    <td class="nicers" style="border:0px" colspan="2">
        <a class="new_dsave new_menu" href="#" onclick="return saveProductFull();"  >
            <span>{$lang.savechanges}</span>
        </a>
    </td>

</tr>
</table>



<div class="clear"></div>