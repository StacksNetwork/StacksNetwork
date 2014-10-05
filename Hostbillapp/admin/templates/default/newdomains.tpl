<input type="hidden" name="type" value="{$product.type}">

<input type="hidden" value="1" name="visible" id="prod_visibility" />
<input type="hidden" value="{$product.category_id}" name="category_id" />
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
						<a href="#"><span class="ico plug">{$lang.registrar_tab}</span></a>
					</li>
					<li>
						<a href="#"><span class="ico gear">{$lang.automation_tab}</span></a>
					</li>
                                        <li>
                                            <a href="#"><span class="ico gear">{$lang.Emails}</span></a>
                                        </li>
					<li>
						<a href="#" ><span class="ico ">{$lang.forms_tab}</span></a>
					</li>
					<li class="last">
						<a href="#"><span class="ico formn">{$lang.widgets_tab}</span></a>
					</li>
					
				</ul>
			</div>
			<div class="list-2">
				<div class="subm1 haveitems">
					<ul >
						<li >
						<a href="#" onclick="$(this).hide();$('#change_orderpage').ShowNicely().show();return false"><span >{$lang.change_orderpage}</span></a></li>
						
						
					</ul>
					<div class="right" style="color:#999999;padding-top:5px">
					</div>
					<div class="clear"></div>
				</div>
				<div class="subm1" style="display:none"></div>
				<div class="subm1 haveitems" style="display:none">
					<ul >
						<li><a  href="#"  onclick="return assignNewTask({$product_id},'domains');" ><span class="addsth" ><strong>{$lang.addcustomautomation}</strong></span></a></li>
                                               {if $otherproducts} <li><a  href="#"   id="premadeautomationswitch" onclick="$('#premadeautomation').show();$(this).hide();return false"><span class="addsth" >{$lang.copyautomation}</span></a></li>{/if}

					</ul>
				</div>
				<div class="subm1" style="display:none"></div>
				<div class="subm1 {if $product.id!='new'}haveitems{/if}" style="display:none">{if $product.id!='new'}
				<ul >
						<li><a  href="#"  onclick="return addCustomFieldForm({$product_id});" ><span class="addsth" ><strong>{$lang.assign_custom_opt}</strong></span></a>
				</li>
					<li ><a href="?cmd=configfields&product_id={$product_id}&action=previewfields"  onclick="return previewCustomForm($(this).attr('href'))" {if !$config}style="display:none"{/if} id="preview_forms_shelf"><span class="zoom">{$lang.Preview}</span></a></li>
                                        <li><a href="#" onclick="$(this).hide();$('#importforms').show();return false" id='importformsswitch' >{$lang.importformfields}</a></li>
					</ul>
				{/if}</div>
				
				
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

			</div>
		</div>
	</td>
</tr>
<tr>

	<td valign="top" class="nicers" style="border:none;" colspan="2">
		<table width="100%" cellspacing="0" cellpadding="6">
          <tbody  class="sectioncontent">
 
		  <tr >
              <td width="160" align="right"><strong>{$lang.dom_ext}</strong> {if $product.id=='new'}<a href="#" class="vtip_description" title="To add multiple TLD with same options & pricing at once, just enter extensions separated by comma, like:<br /> .com, .net, .eu, .co.uk<br />HostBill will automaticaly create multiple products"></a>{/if}</td>
              <td class="editor-container">
			 {if $product.id!='new'}
			  <div class="org-content havecontrols" ><span style=" font-size: 16px !important; font-weight: bold;" class="iseditable">{$product.name}</span> <a href="#" class="editbtn controls iseditable">{$lang.Edit}</a></div>
			  <div class="editor"><input type="text" class="inp" style=" font-size: 16px !important; font-weight: bold;" name="name" size="50" value="{$product.name}">
			  </div>
			  {else}
			  <input type="text" class="inp" style=" font-size: 16px !important; font-weight: bold;" name="name" size="50" value="{$product.name}">
			 {/if}
                         <input type="hidden" name="description" value="" />
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

		 
		  <tr>
              <td valign="top" width="160" align="right"><strong>{$lang.Price}</strong></td>
              <td id="priceoptions">
  		 {foreach from=$supported_billingmodels item=bm name=boptloop}
                <a href="#" class="billopt {if $bm=='Free'}bfirst{/if} {if $product.paytype==$bm}checked{/if}"  {if $product.paytype!=$bm}style="display:none"{/if} onclick='return switch_t2(this,"{$bm}");'>{if $lang[$bm]}{$lang[$bm]}{else}{$bm}{/if}</a>
                <input type="radio" value="{$bm}" name="paytype" {if $product.paytype==$bm}checked="checked"{/if}  id="{$bm}" style="display:none"/>
                {/foreach}

                <a href="#" class="editbtn" onclick="$(this).hide();$(this).parent().find('.billopt').show();return false;">{$lang.Change}</a>


                  {foreach from=$supported_billingmodels item=bm name=boptloop}{include file="productbilling_`$bm`.tpl"}{/foreach}

	
              </td>


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


		     </tbody>

                     <tbody class="sectioncontent" style="display:none">

                         <tr>
                             <td colspan="2" style="padding:0px !important">
                                 <table border="0" width="100%" cellpadding="6" cellspacing="0">



                                     <tr>
                                         <td align="right" width="160"><strong>{$lang.third_party_app}</strong><br />
                                         </td>
                                         <td>
                                             <select name="module" onchange="loadDomainModule(this)" id="modulepicker" class="inp modulepicker" style="width:200px;">
                                                 <option value="0" {if $product.module=='0'}selected="selected" {/if}>{$lang.none}</option>
                                               {foreach from=$modules item=mod}{if $mod.id!='-1'}
                                                 <option value="{$mod.id}" {if $product.module==$mod.id}selected="selected" {/if}>{$mod.module}</option>{/if}
                                              {/foreach}
                                                 <option value="new" style="font-weight:bold">Show non-activated registrars</option>
                                             </select>


                                         </td>
                                     </tr>
                                     <tr><td ></td><td id="app_picker">{include file='ajax.configdommodule.tpl'}                                        
                                      </td></tr>
                                     <tr>

                                         <td align="right" width="160" valign="top"></td>
                                         <td align="left" >

                                             <table border="0" cellspacing="0" cellpadding="6" width='800' >

                                                 <tbody  id='doma-settings' >
                                                     <tr>
                                                         <td width="160"><strong>{$lang.Nameserver} 1</strong></td>
                                                         <td>
                                                             <input class="inp" value="{$product.ns[0]}"  name='ns[0]'/>
                                                         </td>
                                                         <td><strong>{$lang.Nameserver} IP 1</strong> {$lang.optional}</td>
                                                         <td>
                                                             <input class="inp" value="{$product.nsip[0]}"  name='nsip[0]'/>
                                                         </td>

                                                     </tr>
                                                     <tr>
                                                         <td><strong>{$lang.Nameserver} 2</strong></td>
                                                         <td>
                                                             <input class="inp" value="{$product.ns[1]}"  name='ns[1]'/>
                                                         </td>
                                                         <td><strong>{$lang.Nameserver} IP 2</strong> {$lang.optional}</td>
                                                         <td>
                                                             <input class="inp" value="{$product.nsip[1]}"  name='nsip[1]'/>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td><strong>{$lang.Nameserver} 3</strong></td>
                                                         <td>
                                                             <input class="inp" value="{$product.ns[2]}"  name='ns[2]'/>
                                                         </td>
                                                         <td><strong>{$lang.Nameserver} IP 3</strong> {$lang.optional}</td>
                                                         <td>
                                                             <input class="inp" value="{$product.nsip[2]}"  name='nsip[2]'/>
                                                         </td>
                                                     </tr>
                                                     <tr>
                                                         <td><strong>{$lang.Nameserver} 4</strong></td>
                                                         <td>
                                                             <input class="inp" value="{$product.ns[3]}"  name='ns[3]'/>
                                                         </td>
                                                         <td><strong>{$lang.Nameserver} IP 4</strong> {$lang.optional}</td>
                                                         <td>
                                                             <input class="inp" value="{$product.nsip[3]}"  name='nsip[3]'/>
                                                         </td>
                                                     </tr>

                                                 </tbody>

                                             </table>
                                             <div style="padding:10px 5px;" class="fs11">
                                                Those NS will be used during registration unless client provides own settings. Nameservers can also be overidden by purchasing hosting+domain.
                                             </div>
                                         </td>
                                     </tr>

                                     <tr>
                                         <td align="right" width="160"><strong>{$lang.requireepp}</strong></td>
                                         <td align="left"><input type="checkbox" name="epp" value="1" {if $product.epp=='1'}checked="checked"{/if}/></td>
                                     </tr>
                                     <tr>
                                         <td align="right" width="160"><strong>Remove accented characters</strong> <a href="#" class="vtip_description" title="Checking this option will remove accented characters from contact data during registration or transfers"></a></td>
                                         <td align="left"><input type="checkbox" name="asciimode" value="1" {if $product.asciimode=='1'}checked="checked"{/if}/></td>
                                     </tr>
                                 </table>
                             </td>
                         </tr>

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
                                                                     Copy from: <select name="copy_from" class="submitme">
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
                                                     <span class="pdescriptions fs11" >{$lang.configspeedup}. It will also copy registrar settings</span>

                                                 </div>{/if}
                                             </td>
                                         </tr>
                                         <tr>
                                             <td colspan="2" id="tasklistloader">
                                                 {include file='ajax.tasklist.tpl'}
                                             </td>
                                         </tr>

                                         <tr> <td align="right" valign="top" width="200"><strong>{$lang.auto_register}</strong></td>

                                             <td id="automateoptions">
                                                 <input type="radio" value="0" name="autosetup" {if $product.autosetup=='0'}checked="checked"{/if} id="autooff" onclick="$('#autosetup_opt').hide();"/><label for="autooff"><b>{$lang.no}</b></label>
                                                 <input type="radio"  value="2" name="autosetup" {if $product.autosetup!='0'}checked="checked"{/if} id="autoon" onclick="$('#autosetup_opt').ShowNicely();"/><label for="autoon"><b>{$lang.yes}</b></label>

                                                 <div class="p5" id="autosetup_opt" style="{if $product.autosetup=='0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                                                     {$lang.new_EnableAutoRegisterDomain1}
                                                 </div>
                                             </td>
                                         </tr>
                                         <tr class="odd">
                                             <td width="200"  valign="top" align="right"><strong>{$lang.auto_transfer}</strong></td>
                                             <td>

                                                 <input type="radio" {if $configuration.EnableAutoTransferDomain == 'off'}checked="checked"{/if} name="config[EnableAutoTransferDomain]" value="off" onclick="$('#unsuspension_options').hide();" id="unsuspend_off"/><label  for="unsuspend_off"><b>{$lang.no}</b></label>
                                                 <input type="radio" {if $configuration.EnableAutoTransferDomain == 'on'}checked="checked"{/if} name="config[EnableAutoTransferDomain]" value="on" onclick="$('#unsuspension_options').ShowNicely();" id="unsuspend_on"/><label  for="unsuspend_on"><b>{$lang.yes}</b></label>

                                                 <div class="p5" id="unsuspension_options" style="{if $configuration.EnableAutoTransferDomain == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                                                     {$lang.new_EnableAutoTransferDomain1}
                                                     <div class="clear"></div>
                                                 </div>
                                             </td>
                                         </tr>
                                         <tr >
                                             <td width="200" style="vertical-align: top; text-align: right"><strong>{$lang.auto_renew}</strong></td>
                                             <td>
                                                 <input type="radio" {if $product.not_renew == '1'}checked="checked"{/if} name="donotrenew" value="1" onclick="$('#renewal_options').hide();" id="renew_off"/>
                                                 <label  for="renew_off"><b>{$lang.no}</b></label>
                                                 <input type="radio" {if  $product.not_renew != '1'}checked="checked"{/if} name="donotrenew" value="0" onclick="$('#renewal_options').ShowNicely();" id="renewa_on"/>
                                                 <label  for="renewa_on"><b>{$lang.yes}</b></label>

                                                 <div class="p5" id="renewal_options" style="{if  $product.not_renew == '1'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                                                     Attempt to renew domains automatically after receiving payment 
                                                     <div class="clear"></div>
                                                 </div>
                                             </td>
                                         </tr>
                                         <tr >
                                             <td width="200" style="vertical-align: top; text-align: right"><strong>{$lang.InvoiceGeneration}</strong></td>
                                             <td>
                                                 <input type="radio" {if  $configuration.RenewInvoice == 0}checked="checked"{/if} name="config[RenewInvoice]" value="0" onclick="$('#_InvoiceGeneration').hide();" id="igen_off"/>
                                                 <label  for="igen_off"><b>{$lang.no}</b></label>
                                                 <input type="radio" {if $configuration.RenewInvoice == 1}checked="checked"{/if} name="config[RenewInvoice]" value="1" onclick="$('#_InvoiceGeneration').ShowNicely();" id="igen_on"/>
                                                 <label  for="igen_on"><b>{$lang.yes}</b></label>

                                                 <div class="p5" id="_InvoiceGeneration" style="{if  $configuration.RenewInvoice == 0}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >
                                                    {$lang.InvoiceGeneration}
                                                    <input type="text" size="3" value="{$configuration.InvoiceGeneration}" name="config[InvoiceGeneration]" class="inp"/> 
                                                    {$lang.InvoiceGenerationDomains2}
                                                    <div class="clear"></div>
                                                 </div>
                                             </td>
                                         </tr>
                                         <tr class="odd">
                                             <td style="vertical-align: top; text-align: right"><strong>Advanced due date settings </strong></td>          
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
                                         {if $custom_automation}
                                             <tr >
                                                 <td colspan="2">
                                                     {include file=$custom_automation}
                                                 </td>
                                             </tr>
                                         {/if}

                                         <tr class="odd"><td  align="right" valign="top">
                                                 <strong>{$lang.domrenewal_notice}</strong></td>
                                             <td >
                                                 <input type="radio" {if $product.email_reminder=='0'}checked="checked"{/if} name="c_12" value="off" onclick="$('#reminder_options').hide();$('#email_reminder_mail').val(0);" id="reminder_off"/><label  for="reminder_off"><b>{$lang.no}</b></label>
                                                 <input type="radio" {if $product.email_reminder!='0'}checked="checked"{/if} name="c_12" value="on" onclick="$('#reminder_options').ShowNicely();" id="reminder_on"/><label  for="reminder_on"><b>{$lang.yes}</b></label>
                                                 <div class="p5" id="reminder_options" style="{if $product.email_reminder=='0'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >

                                                     <strong>{$lang.domain_expiring_mail}</strong>
                                                     <div class="clear"></div>
                                                     <table border="0" cellspacing="0" cellpadding="3" style="margin-top:5px;">
                                                         <tr><td> <input type="checkbox" value="1" {if $configuration.1DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/>
                                                                 <input type="text" size="3" class="config_val  inp" {if $configuration.1DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.1DomainReminder}"{/if} name="config[1DomainReminder]" />{$lang.daysbeforerenewal}</td></tr>

                                                         <tr class="reminder2" ><td ><input type="checkbox" value="1" {if $configuration.2DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.2DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.2DomainReminder}"{/if} name="config[2DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                                         <tr class="reminder3" ><td ><input type="checkbox" value="1" {if $configuration.3DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.3DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.3DomainReminder}"{/if} name="config[3DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                                         <tr class="reminder4" ><td ><input type="checkbox" value="1" {if $configuration.4DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val  inp" {if $configuration.4DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.4DomainReminder}"{/if} name="config[4DomainReminder]"/> {$lang.daysbeforerenewal}</td></tr>
                                                         <tr class="reminder5" ><td ><input type="checkbox" value="1" {if $configuration.5DomainReminder>0}checked="checked"{/if} onclick="check_i(this)"/> <input type="text" size="3" class="config_val inp" {if $configuration.5DomainReminder<=0}value="0" disabled="disabled"{else}value="{$configuration.5DomainReminder}"{/if} name="config[5DomainReminder]" /> {$lang.daysbeforerenewal}</td></tr>
                                                     </table>
                                                 </div>
                                             </td>
                                         </tr>
                                         <tr class="odd">
                                             <td width="200" align="right" valign="top"><strong>{$lang.new_SendPaymentReminderEmails}</strong></td>
                                             <td>
                                                 <input type="radio" {if $configuration.SendPaymentReminderEmails == 'off'}checked="checked"{/if}   name="config[SendPaymentReminderEmails]" value="off"  onclick="$('#remindere_options').hide();" id="remindere_off"/><label  for="remindere_off"><b>{$lang.no}</b></label>
                                                 <input type="radio" {if $configuration.SendPaymentReminderEmails == 'on'}checked="checked"{/if}  name="config[SendPaymentReminderEmails]" onclick="$('#remindere_options').ShowNicely();" id="remindere_on"/><label  for="remindere_on"><b>{$lang.yes}</b></label>

                                                 <div class="p5" id="remindere_options" style="{if $configuration.SendPaymentReminderEmails == 'off'}display:none;{/if}margin-top:10px;border:#ccc 1px solid;" >


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
                                 </table>
                             </td>
                         </tr>
                     </tbody>
<tbody  style="display:none" class="sectioncontent" >

     {if !$custom_automation}
        {foreach from=$supported_emails item=em key=event}
        <tr>
            <td width="200" align="right"><strong>{if $lang.$event}{$lang.$event}{else}{$event}{/if}</strong></td>
            <td><div class="editor-container" id="{$event}_msg">
                    <div class="no org-content " ><span class=" iseditable"><em>{if $product.emails.$event =='0' }{$lang.none}{else}
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




                <tbody id="configfields" style="display:none" class="sectioncontent" >

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
                                 {if $alerttab.eq==4}
                                    <div style="margin:0px 0px 15px;" class="imp_msg">
                                        <strong>This domain extension requires additional attributes to be entered by customer - <a href="?cmd=services&action=product&id={$product.id}&make=addextendedform">click here to add them</a></strong>
                                    </div>
                                {/if}

                                    {include file='ajax.configfields.tpl'}

                             </td>
                         </tr>
			{/if}




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
<script type="text/javascript">
    lang['Register']='{$lang.Register}';
    lang['Transfer']='{$lang.Transfer}';
    lang['Renew']='{$lang.Renew}';
    lang['Years']='{$lang.Years}';
    {if $alerttab}
    $('#newshelfnav li').eq({$alerttab.eq}).find('span').addClass('notification');
{/if}
    {literal}

        function loadDomainModule(sel) {
            var v = $(sel).val();
                if(v=='new') {
                    $(sel).val(0);
                    window.location='?cmd=managemodules&action=domain&do=inactive';
                    return false;
                } else {
                    ajax_update('?cmd=services&action=showdomainmodule',{id:v,product_id:$('#product_id').val()},'#app_picker');
                }
                    return false;
        }
            function activateDomainModule(frm) {
                 $('#facebox .spinner').show();
                 $('#picked_tab').val(1);
               var m= $(frm).find('input[name=modulename]').val();
                   if(m) {
                      $(document).bind('close.facebox',function(){window.location='?cmd=services&action=product&picked_tab=1&id='+$('#product_id').val()});
                     $.post('?cmd=managemodules&action=quickactivate&type=domain',{fname:m,product_id:$('#product_id').val()},function(data){
                     $('#facebox .spinner').hide();
                        var resp = parse_response(data);
                            if(typeof(resp)!='boolean') {
                                $('#facebox .content').html(resp);
                            } else {
                               window.location='?cmd=services&action=product&picked_tab=1&id='+$('#product_id').val();
                                   return false;
                            }
                    });
                    } else {
                            $(document).trigger('close.facebox');
                        }
                return false;
            }

       
        {/literal}
    </script>