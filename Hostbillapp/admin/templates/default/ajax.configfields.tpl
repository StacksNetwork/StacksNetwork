{if $action=='getaddform' || $action=='field' ||  $action=='getduplicateform'  ||  $action=='addconfig' || $action=='previewfields'}{literal}
<style type="text/css">

.pricingtable input {
float:none !important;
margin:0px !important;
}
.formbilling-head{
    text-align: left;
    clear:both;
    line-height: 23px;
    border-bottom: 1px solid #d9d9d9;
    margin: 0 0 15px 0;
}
.formbilling-head a{
    padding: 4px 15px;
    text-transform: capitalize;
}
.formbilling-head a.active{
    border-bottom: 3px solid #C2C3C4/*#3491DF*/;
    text-decoration: none;
    color: black;
    
}

</style>
{/literal}
<script type="text/javascript">
    var configfields_lang = {literal}{}{/literal};
    configfields_lang['premade_over'] = "{$lang.premade_over}";
    configfields_lang['delconf2'] = "{$lang.delconf2}";
</script>
<script type="text/javascript" src="{$template_dir}js/configfields.js"></script>
{/if}
{if $action=='loadpremade_field'}
{if $fields}
<div class="clear"></div><label>{$lang.premade}<small>{$lang.premade_desc}</small></label>
                  <select name="premade" style="width:120;margin-right:10px;" id="premade_val" onchange="if($(this).val()=='1')$('#loadurl').show();else $('#loadurl').hide()">
				  <option value="0">{$lang.none}</option>
				 <option value="1" style="font-weight:bold">Load from URL</option>
				 
				 {foreach from=$fields item=f}
					<option>{$f}</option>
				  {/foreach}</select>
				  
				  <div style="padding: 2px " class="fs11"> 
					<strong>You can also find dozen of premade &amp; easy to use fields here:</strong>
					<a href="http://hostbillapp.com/fastconfig/forms/" target="_blank" class="external">http://hostbillapp.com/fastconfig/forms/</a>
				  </div>
                  <div class="clear"></div>
<div id="loadurl" style="display:none">
<label>Step 1. <small>Paste <a href="http://hostbillapp.com/fastconfig/forms/" target="_blank">config url</a></small></label>
<input class="w250" type="text" name="premadeurl" id="premadeurl_val"/><div class="clear"></div>
<label>Step 2. <small>Submit and verify setup</small></label>
 <div style="margin:2px 10px" class="left">
 <span style="" class="bcontainer dhidden"><a onclick="return createField()" href="#" class="new_control greenbtn"><span>{$lang.createnewcfield}</span></a></span>
 </div>
</div>				  
{/if}
{elseif ($cmd=='services' && $action=='product') || ($cmd=='configfields' && $loadproduct)}

	  
			<div ><script type="text/javascript">  $('body').unbind('ajaxComplete');</script>
				  {if $config}
                                 
				
                	<div id="listform">
			<div id="serializeit"><ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
					{foreach from=$config item=field}
						<li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
						<table border="0" width="100%" cellspacing="0" cellpadding="5">
						<tr>
							<td valign="top" width="120"><div style="padding:10px 0px;"><input type="hidden" name="sortc[]" value="{$field.id}" class="ser"/><a name="f{$field.id}"></a>
							<a href="#"  class="sorter-ha menuitm menuf" onclick="return false"><span class="movesth" title="{$lang.move}"></span></a><!--
							--><a href="#"  class="menuitm menuc" title="{$lang.Edit}" onclick="return editCustomFieldForm({$field.id},{$product_id});" style="width:14px;"><span class="editsth"></span></a><!--
							--><a  href="#" class="menuitm menuc" title="{$lang.Duplicate}"  onclick="return duplicateCustomFieldForm({$field.id},{$product_id});"><span class="duplicatesth"></span></a><!-- 
							--><a href="?cmd=configfields&make=delete&id={$field.id}&product_id={$product_id}" class="menuitm menul" title="{$lang.delete}" onclick="return deleteItemConfCat(this)" ><span class="delsth"></span></a>
							
							
							</div></td>
							<td >
								{include file=$field.configtemplates.adminlist}
								{if $field.variable}<input type="hidden" id="configvar_{$field.variable}" value="{$field.id}"/>
								<script type="text/javascript"> 
								{literal}
								$('body').ajaxComplete(function() {
								{/literal}
									$('#config_{$field.variable}').html('<em class="fs11">Set by client using <a href="#"   title="{$lang.Edit}" onclick="return editCustomFieldForm({$field.id},{$product_id});" >Forms: {$field.name}</a> (<a href="?cmd=configfields&make=delete&id={$field.id}&product_id={$product_id}" class="editbtn" onclick=" if(!deleteItemConfCat(this))$(\'#modulepicker\').change();return false;">remove</a>)</em>');
									$('#config_{$field.variable}_descr').remove();
								{literal}
									});
									{/literal}
									
								</script>
								{/if}
							</td>
							<td width="150" style="background:#F0F0F3;color:#767679;font-size:11px" valign="top">Field type: <strong>{if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} </strong></td>
						</tr>
						</table></div></li>
						
		
				
					{/foreach}
				</ul>
				
			</div>	
			</div>

                        {else}

        <div class="blank_state_smaller blank_forms">
			<div class="blank_info">
				<h3>{$lang.formsbs}</h3>
                                <span class="fs11">{$lang.bsdescription}</span>
				<div class="clear"></div>
                                <br/>
                                <a  href="#" class="new_control"  onclick="return addCustomFieldForm({$product_id});" ><span class="addsth" ><strong>{$lang.assign_custom_opt}</strong></span></a> <span class="orspace">{$lang.Or}</span> <a href="#"  class="new_control" onclick="$('#importforms').show(); return false"><span class="disk-import">Import</span></a>
		<div class="clear"></div>

		</div>
	</div>
                                 
                {/if}
            
  <script type="text/javascript">{literal}
  function saveOrder2() {
		var sorts = $('#customitemseditor input.ser2').serialize();
		ajax_update('?cmd=configfields&action=changeorder&'+sorts,{});
		};
		function latebindme() {
			$("#grab-sorter").dragsort({ dragSelector: "a.sorter-ha", dragBetween: false, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
			$("#customitemseditor").dragsort({ dragSelector: "a.sorter-ha", dragBetween: false, dragEnd: saveOrder2,  placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
			}
		if(typeof $("#customitemseditor").dragsort == 'function') {
						latebindme();
						 
	   }
	   
function refreshConfigView(pid) {
		if(pid)
			ajax_update("?cmd=configfields",{action:"loadproduct",product_id:pid},'#configeditor_content');
			return false;
		}
	   function addCustomFieldForm(pid) {
		$.facebox({ ajax: "?cmd=configfields&action=addconfig&product_id="+pid,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
		return false;
	   }
	   function previewCustomForm(url) {
		$.facebox({ ajax: url,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
		return false;
		
	   }
	   function editCustomFieldForm(id,pid) {
	   $.facebox({ ajax: "?cmd=configfields&action=field&id="+id+"&product_id="+pid+'&paytype='+$('input[name=paytype]:checked').val(),width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
	   return false;
	   }
	   function duplicateCustomFieldForm(id,pid) {
	   ajax_update("?cmd=configfields&action=duplicatefield&id="+id+"&product_id="+pid,{},function(){
		refreshConfigView(pid);
		});
	  
	   return false;
	   }
		function deleteItemConf(el) {
			if(confirm('{/literal}{$lang.delconf2}{literal}')) {
				ajax_update($(el).attr('href'),{},'#configeditor_content');
				
			}
			return false;
		}
		function deleteItemConfCat(el) {
			if(confirm('{/literal}{$lang.delconf1}{literal}')) {
				ajax_update($(el).attr('href'),{},'#configeditor_content');
			}
			return false;
		}	
                
		{/literal}
	</script>
     
				
					{if $config}<div style="padding:10px 4px">
					<a  href="#" class="new_control"  onclick="return addCustomFieldForm({$product_id});" id="addnew_conf_btn"><span class="addsth" ><strong>{$lang.assign_custom_opt}</strong></span></a>
					<script type="text/javascript">$('#preview_forms_shelf').show();</script><a href="?cmd=configfields&product_id={$product_id}&action=previewfields" class="new_control" onclick="return previewCustomForm($(this).attr('href'))"><span class="zoom">{$lang.Preview}</span></a>
                                        <a href="?cmd=configfields&action=export&id={$product_id}"  class="new_control" target="_blank"><span class="disk-export">Export</span></a>
                                        <a href="#"  class="new_control" onclick="$('#importforms').show(); return false"><span class="disk-import">Import</span></a>
					</div>
					{/if}
				</div>
				
{elseif $action=='previewfields'}
<div id="formloader" style="background:#fff;padding:10px;">
<script type="text/javascript" src="{$template_dir}js/jqueryui/js/jquery-ui-1.8.12.custom.min.js"></script>
<link href="{$template_dir}js/jqueryui/css/ui-lightness/jquery-ui-1.8.12.custom.css" rel="stylesheet" media="all" />
{if $custom}
<table border="0" width="100%" cellspacing="0" cellpadding="3">
	{foreach from=$custom item=cf} 
	{if $cf.items}
	
	<tr>
		<td colspan="2" class="{$cf.key} cf_option">
		
			<label for="custom[{$cf.id}]" class="styled"><b>{$cf.name} {if $cf.options &1}*{/if}</b></label><br/>
			{if $cf.description!=''}<div class="fs11 descr" style="color:#808080">{$cf.description}</div>{/if}
			
				{include file=$cf.configtemplates.cart}
				
		</td>
	</tr>
	{/if}
	{/foreach}
</table>
{/if}
</div>{if $ajax}
	<div class="dark_shelf dbottom">
      
        <div class="right">
  <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
    </div>	
	{/if}
{elseif $action=='field' || $action=='getaddform' || $action=='duplicatefield'}
<div id="formloader">
<form id="saveform" method="post" action="">
<input type="hidden" name="type" value="{if $type}{$type}{else}{$field.type.type}{/if}"/>
<input type="hidden" name="id" value="{$field.id}" id="field_category_id"/>
<input type="hidden" name="make" value="{if $field.id=='new'}addfield{else}editfield{/if}"/>
<input type="hidden" name="action" value="field"/>
<input type="hidden" name="product_id" value="{$product_id}"/>


        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                        <a class="tchoice" href="#">Basic settings</a>
                        {if $field.type.info.subitems}<a class="tchoice" href="#">Values</a>{/if}
                        {if $field.type.info.pricing && !$field.type.info.subitems}<a class="tchoice" href="#">Pricing</a>{/if}
                        {if $field.type.info.validation}<a class="tchoice" href="#">Validation</a>{/if}
						 <a class="tchoice" href="#">Advanced</a>
						{foreach from=$field.type.templates item=tp key=tpname}
						<a class="tchoice" href="#">{$tpname}</a>
						{/foreach}
                       
                </div>
            </td>
            <td class="conv_content form"  valign="top">
               <div class="tabb">
                   <h3 style="margin-bottom:0px;"><img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  />  {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; Basic settings</h3>
                   <div class="clear"><small>{$lang[$field.type.description]}</small></div>
                   <div style="padding:10px 3px;border:solid 2px red;background:#FFFED1;margin:5px 0px 15px;display:none;" class="clear" id="lengthwarning">Your php.ini setting <b>max_input_vars</b> is too low to properly save this form element. <a href="http://wiki.hostbillapp.com/index.php?title=Forms:_Fix_not_saving_forms_configuration" target="_blank">How to fix this.</a></div>
                    <div class="clear"></div><label class="nodescr">Field name</label>

                    {hbinput value=$field.tag_name  class="w250" name="name" style="margin:0px;"  wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}

                    <div class="clear"></div><label for="check-required">Required field</label>
                    <input id="check-required" type="checkbox" name="options[]" value="1" {if $field.options & 1}checked="checked"{/if}/>
                    <div class="clear"></div><label >Description</label>
                    {if $field.description!=''}
                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" blockwysiwyg="true" class="w250"  name="description" wrapper_id="prod_desc_cx" wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                    {else}
                        <a href="#" onclick="$(this).hide();$('#prod_desc_cx').show();return false;" style="padding-left:10px;"><strong>{$lang.adddescription}</strong></a>
                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" class="inp wysiw_editor"  name="description" blockwysiwyg="true" wrapper_id="prod_desc_cx" wrapper="div"  wrapper_class="w250 left" wrapper_style="display:none;clear:right;margin: 2px 0 10px 10px;"}
                   {/if}
               </div>
              
               {if $field.type.info.subitems}<div class="tabb" style="display:none">
                <h3><img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  /> {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; Values</h3>
			   
			   <div id="subitems_editor">
				{include file='ajax.configdrawsort.tpl'}
			   </div>
			   
			   </div>

			   {else}
			   {/if}
			   
               {if $field.type.info.pricing && !$field.type.info.subitems}
                   <div class="tabb" style="display:none">
                        <h3>
                            <img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  /> 
                            {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; Pricing
                        </h3>
                        
                        <label >{$lang.enablepricing}</label>
                        <input  type="checkbox" name="items[{$k}][pricing]" value="1" {if $field.items[0].pricing_enabled}checked="checked"{/if} onclick="$('.formbilling, .pricingtable','#facebox').toggle()"/> 
                        <small>&nbsp;&nbsp;&nbsp;{$lang.chargeforvalue}</small>
                        
                        {foreach from=$field.items item=item key=k}
                        <div class="formbilling formbilling-head" {if !$field.items[0].pricing_enabled}style="display: none"{/if}>
                            <a href="#{$paytypeform}" {if !$item.paytype || $item.paytype == $paytypeform}class="active"{/if} onclick="formbilling(this); return false">Regular</a>
                            {foreach from=$field.type.info.adformbilling item=formbilling}
                                 <a href="#{$formbilling}" {if $item.paytype == $formbilling}class="active"{/if} onclick="formbilling(this); return false" >{if $lang[$formbilling]}{$lang[$formbilling]}{else}{$formbilling}{/if}</a>
                            {/foreach}
                        </div>
                        <div class="clearfix formbilling" id="formbilling" {if !$field.items[0].pricing_enabled}style="display: none"{/if}>
                            
                            <input type="hidden" name="items[{$k}][id]" value="{$item.id}"/>
                            <input class="formbilling-paytype" type="hidden" name="items[{$k}][paytype]" value="{$item.paytype}"/>
                            <div id="formbilling_{$paytypeform}" {if $item.paytype && $item.paytype != $paytypeform}style="display: none"{/if}>
                            {if $paytypeform}
                                {include file="formbilling_`$paytypeform`.tpl"}
                            {else}
                                {include file='formbilling_Regular.tpl'}
                            {/if}
                            </div>
                                
                            {if $field.type.info.adformbilling}
                                {foreach from=$field.type.info.adformbilling item=formbilling}
                                    <div id="formbilling_{$formbilling}" {if $item.paytype != $formbilling}style="display: none"{/if}>
                                        {include file="formbilling_`$formbilling`.tpl"}
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                        {/foreach}
                    </div>
                    <script type="text/javascript">updatePricingForms();</script>
                {/if}
                {if $field.type.info.validation}
                    <div class="tabb" style="display:none">
                        <h3><img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  /> {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; Validation</h3>
                        <div class="clear"></div><label >Minimum value<small>must be greater than or equal to this value</small></label>
                        <input type="text" size="2" name="config[minvalue]" id="configMinvalue" value="{$field.config.minvalue}" />
                        <div class="clear"></div><label >Maximum value<small>Leave blank for no limit</small></label>
                        <input type="text" size="2" name="config[maxvalue]" id="configMaxvalue" value="{$field.config.maxvalue}" />
                    </div>
                {/if}
                <div class="tabb" style="display:none">
                    <h3><img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  /> {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; Advanced settings</h3>
                    <div class="clear"></div><label for="text-key">CSS Class<small>Field container will be displayed with this css class</small></label>
                    <input id="text-key" type="text" class="w250" name="key" value="{$field.key|escape}" />
                    <div class="clear"></div><label for="text-category">Group<small>Supported by some order pages to group options</small></label>
                    <input id="text-category" type="text" class="w250" name="category" value="{$field.category|escape}" />
                    <div class="clear"></div><label for="text-variable">Variable name<small>To use in emails, custom modules</small></label>
                    <input id="text-variable" type="text" class="w250" name="variable" value="{$field.variable|escape}" />

                    <div class="clear"></div>

                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr>
                            <td width="40%">
                                <label for="check-admin" >Admin only<small>Only admin can see this field</small></label>
                                <input id="check-admin" type="checkbox" name="options[]" value="4" {if $field.options & 4}checked="checked"{/if} onclick="if($(this).is(':checked'))$('#check-show, #check-edit, #check-invoice, #check-upgrade, #check-down, #check-charge').removeAttr('checked').attr('disabled','disabled');else $('#check-show, #check-edit, #check-invoice, #check-upgrade, #check-down, #check-charge').removeAttr('disabled');"/>
                                <div class="clear"></div>
                            </td>
                            <td>
                                {if $field.type.info.upgrades}<label for="check-upgrade" >Allow Upgrades<small>Can client upgrade after order</small></label>
                                    <input id="check-upgrade" type="checkbox" name="options[]" value="16" {if $field.options & 16 || ($field.options=='')}checked="checked"{/if}/>
                                {/if}
                            </td>
                            <td>
                                {if $field.type.info.upgrades}<label for="check-charge" >Upgrade setup fee<small>Charge setup fee on upgrades&nbsp;or&nbsp;downgrades</small></label>
                                    <select id="check-charge" class="inp" name="options[]" style="padding: 0; width: 60px; margin-left: 5px;" >
                                        <option value="" {if !($field.options & 64) && !($field.options & 128) }selected="selected"{/if}>No</option>
                                        <option value="64" {if $field.options & 64 }selected="selected"{/if}>Price difference</option>
                                        <option value="192" {if ($field.options & 192) == 192 }selected="selected"{/if}>Full</option>
                                    </select>
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td width="40%">
                                <label for="check-show" >Show in cart<small>Display this option during order</small></label>
                                <input id="check-show" type="checkbox" name="options[]" value="2" {if $field.options & 2 || ($field.options=='')}checked="checked"{/if}/>
                                <div class="clear"></div> 
                            </td>
                            <td>
                                <div class="clear"></div><label for="check-invoice" >Force show in Invoice<small>Include it in invoice even when&nbsp;it's&nbsp;empty or free</small></label>
                                <input id="check-invoice" type="checkbox" name="options[]" value="256" {if $field.options & 256}checked="checked"{/if}/>
                            </td>
                            <td>
                                {if $field.type.info.upgrades}
                                    <div class="clear"></div><label for="check-down" >Allow Downgrades<small>Can client downgrade this field</small></label>
                                    <input id="check-down" type="checkbox" name="options[]" value="32" {if $field.options & 32 || ($field.options=='')}checked="checked"{/if}/>
                                {/if}
                            </td>
                        </tr>
                    </table>
               </div>
			   
			   {foreach from=$field.type.templates item=tp key=tpname}
						<div class="tabb" style="display:none">
                <h3><img src="../includes/libs/configoptions/{$field.type.type}/{$field.type.type}_thumb2.png" alt="" style="margin-right:5px" class="left"  /> {if $lang[$field.type.langid]}{$lang[$field.type.langid]}{else}{$field.type.type}{/if} &raquo; {$tpname}</h3>
                {include file=$tp}
				</div>
						{/foreach}

            </td>
        </tr>
    </table>
   {securitytoken}</form> </div>
<script type="text/javascript">
    {if $max_input_vars}
    var inputvars={$max_input_vars};
    var inputs = $('input,select','#facebox').length;
    if(inputs>inputvars) 
        $('#lengthwarning').show();
    {/if}
{literal}$('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});{/literal}
    </script>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            {if $field.id!='new'}<span class="bcontainer " ><a href="?cmd=configfields&product_id={$product_id}&action=previewfields&highlight={$field.id}" class="new_control" target="_blank"><span class="zoom">{$lang.Preview}</span></a></span>{/if}
            <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="saveChangesField(); return false"><span>{$lang.savechanges}</span></a></span>
            <span >{$lang.Or}</span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
    </div>

{elseif $action=='getduplicateform'}
<div id="formloader">
    <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="180" id="s_menu" style="padding-top:40px;" valign="top">
                <div id="initial-desc">To save time you can use one fields you've configured before</div>

            </td>
            <td class="conv_content"  valign="top">
                <h3>Duplicate existing field</h3>
                {if $fields}
                 <div class="form"><form id="duplicatefield" action="" method="post">
					<input type="hidden" name="product_id" value="{$product_id}"/>
					<input type="hidden" name="action" value="duplicatefield"/>
					<input type="hidden" name="cmd" value="configfields"/>
					<input type="hidden" name="type" value="{$type}"/>
                    <div class="clear"></div><label class="nodescr">Field to duplicate</label>
                    <select name="id" class="w250">
                    {foreach from=$fields item=f}
                        <option value="{$f.id}">{$f.catname|escape} - {$f.pname|escape}: {$f.name|escape}</option>
                      {/foreach}
                  </select>
                {securitytoken}</form></div>
                {else} <form id="addform" method="post" action="">
        <input type="hidden" name="product_id" value="{$product_id}"/>
        <input type="hidden" name="type" value="{$type}"/>
        <input type="hidden" name="cmd" value="configfields"/>
        <input type="hidden" name="action" value="getaddform"/>
    {securitytoken}</form>
                    <center>There is no field of this type added yet<br/><a href="#" onclick="return createField()">{$lang.createnewcfield}</a></center>
                {/if}
               



            </td>
        </tr>
    </table>
    </div>
<div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            {if $fields}<span class="bcontainer" ><a href="#" class="new_control greenbtn" onclick="return duplicateFieldSubmit()"><span>{$lang.Duplicate}</span></a></span>
            <span class="">{$lang.Or}</span>{/if}
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
    </div>
{elseif $action=='addconfig'}
<div id="formcontainer">
    <form id="addform" method="post" action="">
        <input type="hidden" name="product_id" value="{$product_id}"/>
        <input type="hidden" name="type" value=""/>
        <input type="hidden" name="cmd" value="configfields"/>
        <input type="hidden" name="action" value="getaddform"/>
        <input type="hidden" name="premade" value="" id="premade_to_fill"/>
        <input type="hidden" name="premadeurl" value="" id="premadeurl_to_fill"/>
    {securitytoken}</form>
 <form id="duplicateform" method="post" action="">
        <input type="hidden" name="product_id" value="{$product_id}"/>
        <input type="hidden" name="type" value=""/>
        <input type="hidden" name="cmd" value="configfields"/>
        <input type="hidden" name="action" value="getduplicateform"/>
 {securitytoken}</form>
    <div id="formloader">
    <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="180" id="s_menu" style="" valign="top">
                <div id="initial-desc">Start by selecting field type, you will be able to configure it, add pricing, validation etc. in next steps.</div>
                {foreach from=$fields item=f key=ft}{foreach from=$f item=field}
                    <div style="display:none" class="description" id="{$field.type}-description">{$lang[$field.description]}</div>
{/foreach}{/foreach}
{foreach from=$fields item=f key=ft}{foreach from=$f item=field}
                    <div class="descr_image" id="{$field.type}-descr_image" style="display:none;background:url('{$field.image}') no-repeat top left;"></div>
{/foreach}{/foreach}
            </td>
            <td class="conv_content"  valign="top">
                <h3>
                    Select field type
                </h3>
                {foreach from=$fields item=f key=ft}
                <fieldset>
                    <legend>{$lang[$ft]}</legend>
                    {foreach from=$f item=field}
                         <div class="fselect"><input type="radio" value="{$field.type}" name="type" id="field{$field.type}" onclick="fieldclick('{$field.type}');"/> <label for="field{$field.type}">{if $lang[$field.langid]}{$lang[$field.langid]}{else}{$field.type}{/if}</label></div>
                    {/foreach}
                    <div class="clear"></div>
                </fieldset>
                {/foreach}

              <div class="form shownice tabb" id="premadeloader" style="display:none"></div>

            </td>
        </tr>
    </table>
    </div>
    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer dhidden" style="display:none"><a class="new_control greenbtn" href="#" onclick="return createField()"><span>{$lang.createnewcfield}</span></a></span>
            <span class="bcontainer dhidden" style="display:none"><a href="#" class="submiter menuitm" onclick="return duplicateField()"><span>Duplicate existing field</span></a></span>
            <span class="dhidden" style="display:none">{$lang.Or}</span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>

            
        </div>
        <div class="clear"></div>
    </div>
</div>




{elseif $action=='helper'}
    {if $do=='getotherfields'}
                  {if $fields}
           <select style="margin: 26px 0px 0px;;float:left;" id="condition_field_target"  name="config[conditional][new][target]" onchange="$('#condition_field_targetname').val($('#condition_field_target option[value='+$(this).val()+']').text());">
                     {foreach from=$fields item=f}
               <option value="{$f.id}">{$f.name}</option>
               {/foreach}
                    </select>
                  <input type="hidden" name="config[conditional][new][targetname]" id="condition_field_targetname" value="{$fields[0].name|escape}" />

                  {else}
                  Add other fields first.
                  {/if}
                  {if $fields && $setval}
                  <div class="padding:5px 2px;float:left">To</div>
                    <input type="text" size="3" id="condition_field_value" style="margin:0px;float:left;"  name="config[conditional][new][targetval]"/>

                  {/if}

                  {/if}
					
{/if}