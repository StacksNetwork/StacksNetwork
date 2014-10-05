{if $action=='field'}
<div id="formcontainer">
     <div id="formloader" >
<form method="post" action="" id="submitform" >
<input type="hidden" name="make" value="{if $field.id=='new'}add{else}update{/if}" />
<input type="hidden" name="field_id" value="{$field.id}" />
<input type="hidden" name="id" value="{$field.id}" />

	
        <table border="0" cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td width="140" id="s_menu" style="" valign="top">
                <div id="lefthandmenu">
                    <a class="tchoice" href="#">General settings</a>
                    <a class="tchoice" href="#">Advanced</a>
                 </div>
            </td>
            <td class="conv_content form"  valign="top">
                <div class="tabb">
                    <h3 style="margin-bottom:0px;">General field settings</h3>
                    {if $field.options & 1}
                        <div class="clear"><small>This is default HostBill field, it will appear as <b>{$lang[$field.code]}</b>, you can remove it or replace  with custom field</small></div>
                    {/if}
                    <div class="clear"></div>

                    <label class="nodescr">{$lang.fieldname}</label>
                    {if $field.options & 1}
                        {hbinput value=$lang[$field.code]  class="w250" style="margin:0px;" disabled="disabled" pretag=$field.code wrapper="div" wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                        <input type="hidden" value="{$field.name}" name="name" />
                    {else}
                        {hbinput value=$field.tag_name  class="w250" name="name" style="margin:0px;"  wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                    {/if}

                    <div class="clear"></div>

                    {if !($field.options & 1)}
                        <label class="nodescr">{$lang.appliesto}</label>
                        <select name="type"  class="w250">
                            <option value="All" {if $field.type=='All'}selected="selected"{/if}>{$lang.All}</option>
                            <option value="Private" {if $field.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                            <option value="Company" {if $field.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                        </select>
                        <div class="clear"></div>


                        <label class="nodescr">{$lang.fieldtype}</label>
                        <select name="field_type" onchange="shf('def_val_{$field.id}',this)" class="w250">
                            <option value="Input" {if $field.field_type=='Input'}selected="selected"{/if}>{$lang.Input}</option>
                            <option value="Check" {if $field.field_type=='Check'}selected="selected"{/if}>{$lang.Check}</option>
                            <option value="Select" {if $field.field_type=='Select'}selected="selected"{/if}>{$lang.Select}</option>
                        </select>
                        <div class="clear"></div>

                        <div {if !$field.field_type || $field.field_type=='Input'}style="display:none"{/if}  id="def_val_{$field.id}">
                            <label>Values<small>Separate with semicolon (;)</small></label>
                            <input name="default_value" value="{$field.default_value|escape}" type="text" class="w250" />
                        </div>
                    {else}
                        <input type="hidden" name="type" value="{$field.type}" style="display:none" />
                    {/if}

                    {if !($field.options & 256)}
                        <label for="check-required">{$lang.requiredf}</label>
                        <input id="check-required" type="checkbox" name="options[]" value="2" {if $field.options & 2}checked="checked"{/if}/>
                    {else}
                        <input type="hidden" name="options[]" value="2" style="display:none" />
                    {/if}
                    <div class="clear"></div>



                    <label >Description</label>
                    {if $field.description!=''}
                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" blockwysiwyg="true" class="w250"  name="description" wrapper_id="prod_desc_c" wrapper="div"  wrapper_class="w250 left" wrapper_style="clear:right;margin: 2px 0 10px 10px;"}
                    {else}
                        <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;" style="padding-left:10px;">
                            <strong>{$lang.adddescription}</strong>
                        </a>
                        {hbwysiwyg value=$field.tag_description style="margin:0px;width:250px" class="inp wysiw_editor" id="prod_desc" name="description" blockwysiwyg="true" wrapper_id="prod_desc_c" wrapper="div"  wrapper_class="w250 left" wrapper_style="display:none;clear:right;margin: 2px 0 10px 10px;"}
                    {/if}

                </div>
                    
                <div class="tabb" style="display:none">
                    <h3>Advanced configuration</h3>
                    <div class="clear"></div>

                    <label  class="havedescr" >Variable name
                        <small>To be used in email templates, plugins</small></label>
                    <input type="text" class="w250" name="code" value="{$field.code}" {if ($field.options & 1)} disabled="disabled" {/if} />
                    <div class="clear"></div>


                    {if !($field.options & 1)}
                        <label  for="check-invoice" class="havedescr">{$lang.oninvoice}
                            <small >Should field value appear on clients' invoices</small></label>
                        <input id="check-invoice" type="checkbox" name="options[]" value="4" {if $field.options & 4}checked="checked"{/if}/>
                        <div class="clear"></div>

                        <label  for="check-invoice" class="havedescr">Hide for contacts
                            <small >Hide this field during client's contact add/edit</small></label>
                        <input type="checkbox" name="options[]" value="512" {if $field.options & 512}checked="checked"{/if} />
                        <div class="clear"></div>
                    {/if}

                    <label for="check-editable"  class="havedescr">Editable
                        <small>Can client edit this field after signup</small></label>
                    <input id="check-editable" type="checkbox" name="options[]" value="8" {if $field.options & 8}checked="checked"{/if}/>
                    <div class="clear"></div>

                    <label for="check-adminonly"  class="havedescr">Admin only
                        <small>Should this field be visible for staff only</small></label>
                    <input id="check-adminonly" type="checkbox" name="options[]" value="128" {if $field.options & 128}checked="checked"{/if} onclick="{literal}if($(this).is(':checked')){ $('#check-required, #check-editable, #check-invoice').removeAttr('checked');}{/literal}"/>
                    <div class="clear"></div>

                    <table border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td width="160" valign="top"><label for="expression"  class="havedescr">Validation pattern
                                    <small>RegEx to validate this field with</small></label></td>
                            <td align="left" valign="top">
                                <input id="expression" type="text" name="expression" id="expression" value="{$field.expression}" class="w250" style="margin-bottom:2px" />
                                <div class="clear"></div>
                                <span class="right">
                                    <a href="#" class="editbtn" onclick="$(this).hide();$('#premade_pattern').show();return false;">Premade patterns</a>
                                </span><div class="clear"></div>
                                <select name="premade_pattern" id="premade_pattern" onchange="$('#expression').val($(this).val());" class="w250" style="display:none">
                                    <option value="">---select---</option>
                                    <option value="{literal}/^\d{1,3}$/{/literal}">Number 1-3 digits in length</option>
                                    <option value="{literal}/^(0?[1-9]|1[012])[\/](0?[1-9]|[12][0-9]|3[01])[\/](19|20)\d\d$/{/literal}">Date in mm/dd/yyyy</option>
                                    <option value="{literal}/^(19|20)\d\d[\/](0?[1-9]|1[012])[\/](0?[1-9]|[12][0-9]|3[01])$/{/literal}">Date in yyyy/mm/dd</option>
                                    <option value="{literal}/^(0?[1-9]|[12][0-9]|3[01])[\/](0?[1-9]|1[012])[\/](19|20)\d\d$/{/literal}">Date in dd/mm/yyyy</option>
                                    <option value="{literal}/^((\(\d{3}\) ?)|(\d{3}[-\s]))?\d{3}[-\s]\d{4}$/{/literal}">US Phone number</option>
                                    <option value="{literal}/^\d{5}([\-]\d{4}){0,1}$/{/literal}">US Zip Code</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                    <div class="clear"></div>
                </div>
            </td>
        </tr>
    </table>
   {securitytoken}</form> </div>
<script type="text/javascript">
{literal}$('#lefthandmenu').TabbedMenu({elem:'.tabb'{/literal}{if $picked_tab},picked:{$picked_tab}{/if}{literal}});{/literal}
    </script>
   <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">

            <span class="bcontainer" ><a class="new_control greenbtn" href="#" onclick="return createField()"><span>{if $field.id=='new'}{$lang.submit}{else}{$lang.savechanges}{/if}</span></a></span>
            <span class="dhidden" >{$lang.Or}</span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>


        </div>
        <div class="clear"></div>
    </div>
</div>
{elseif $action=='fields'}{if !$ajax}{literal}
<style type="text/css">
.pricingtable input {
float:none !important;
margin:0px !important;
}
</style>
		  {/literal}
<div id="customcontainer">
{/if}
<div class="blu">
    <div class="left menubar">
    <a onclick="addCustomFieldForm();return false;" class="new_control" href="#"><span class="addsth"><strong>{$lang.addnewfield}</strong></span></a>
   {if $premade} <a onclick="$('#premadefields').toggle();return false;" class="new_control" href="#"><span class="dwd"><strong>Premade field profiles</strong></span></a>{/if}

    <a  class="new_control" href="{$system_url}?cmd=signup" target="_blank"><span class="zoom">{$lang.Preview}</span></a>
    </div>
    <div class="clear"></div>
</div>
    
<div style="padding:15px;background:#F5F9FF;">
 {if $premade}
    <div class="p6" id="premadefields" style="margin-bottom:15px;display:none;">
        <form onsubmit="return confirm('Are you sure? It will overwrite your current fields');" method="post" action="">
            <input type="hidden" name="make" value="usepremade"/>
        <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
<tbody><tr>
<td>
Profile: <select class="submitme" name="premade" onchange="$('.pdescriptions').hide();$('#pdescription'+$(this).attr('selectedIndex')).show();">
        {foreach from=$premade item=p}
            <option value="{$p.file}"> {$p.name} </option>
        {/foreach}
    </select>
</td>
<td>
<input type="submit"  style="font-weight:bold" value="Use it">
<span class="orspace">{$lang.Or}</span> <a class="editbtn" onclick="$('#premadefields').hide();return false;" href="#">{$lang.Cancel}</a>
</td>
</tr>

</tbody></table>
{foreach from=$premade item=p name=premadelist key=k}
            <span class="pdescriptions fs11" id="pdescription{$k}" {if $smarty.foreach.premadelist.first}{else}style="display:none"{/if}><b>{$lang.Description}:</b> {$p.description} </span>
        {/foreach}
    {securitytoken}</form></div>
    {/if}

    <form id="serializeit">
        <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
            {foreach from=$fields item=field name=fff}<li style="background:#ffffff">
                    <div style="border-bottom:solid 1px #ddd;">
                        <table  cellpadding="0" cellspacing="0"  width="100%" >
                            <tbody> <tr class="havecontrols">
                                    {if $field.options & 1}
                                        <td width="90" {if ($field.options & 16) || ($field.options & 256)}style="background:#F0F0F3;color:#767679;"{/if} >
                                            <div style="padding:10px 5px;">
                                                <a class="sorter-ha menuitm {if !($field.options & 16) || !($field.options & 64)}menuf{/if}" style="width:14px;margin-left:4px;" onclick="return false" href="#"><span title="move" class="movesth">&nbsp;</span></a><!--
                                                -->{if !($field.options & 16)}<a class="menuitm {if !($field.options & 64)}menuc{else}menul{/if}" style="width:14px;" href="?cmd=clients&action=field&field_id={$field.id}" onclick="return editFieldForm('{$field.id}');" title="edit"  ><span class="editsth"></span></a>{/if}<!--
                                                -->{if !($field.options & 64)}<a class="menuitm menul" title="delete" href="?cmd=clients&action=fields&make=delete&field_id={$field.id}&system=1" onclick="return delete_field('{$field.id}',1);"><span class="delsth"></span></a>{/if}
                                            </div>
                                        </td>
                                        <td  {if ($field.options & 16) || ($field.options & 256)}style="background:#F0F0F3;color:#767679;"{/if} >
                                            <input type="hidden" name="sort[]" value="{$field.id}" />
                                            {if $lang[$field.code]}{$lang[$field.code]}
                                            {else}{$field.name}
                                            {/if}
                                            {if $field.code=='type'} 
                                                <em>(Allow client to choose between Company and No-Company profile) </em>
                                            {/if}
                                                
                                        </td>
                                    {else}
                                        <td width="90" ><div style="padding:10px 5px;">
                                                <a style="width:14px;margin-left:4px;" onclick="return false" class="sorter-ha menuitm {if !($field.options & 16) || !($field.options & 64)}menuf{/if}" href="#"><span title="move" class="movesth">&nbsp;</span></a><!--
                                                -->{if !($field.options & 16)}<a class="menuitm {if !($field.options & 64)}menuc{else}menul{/if}"style="width:14px;" href="?cmd=clients&action=field&field_id={$field.id}" onclick="return editFieldForm('{$field.id}');" title="edit" ><span class="editsth"></span></a>{/if}<!--
                                                -->{if !($field.options & 64)}<a class="menuitm menul" title="delete"  href="?cmd=clients&action=fields&make=delete&field_id={$field.id}" onclick="return delete_field('{$field.id}',0);"><span class="delsth"></span></a>{/if}
                                            </div></td>
                                        <td ><input type="hidden" name="sort[]" value="{$field.id}" />{$field.name}</td>
                                            
                                    {/if}
                                    <td width="150" style="background:#F0F0F3;color:#767679;font-size:11px" >
                                        <div style="padding:5px">
                                            {$lang.fieldtype}: <b>{$lang[$field.field_type]}</b><br/>
                                            {$lang.appliesto}: <b>{$lang[$field.type]}</b><br/>
                                        </div></td>
                                </tr></tbody>
                        </table>
                    </div>
                </li>	{/foreach}
            </ul>
            {securitytoken}
        </form>
    </div>
{if !$ajax}
	</div>	 
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
	 {literal}<script type="text/javascript">
	function bindSortOrder() {
            $("#grab-sorter").dragsort({ dragSelector: "a.sorter-ha", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
            }
                 bindSortOrder();
		function saveOrder() {
		var sorts = $('#serializeit').serialize();
		ajax_update('?cmd=clients&action=listfields&'+sorts,{});
		};
	</script>
		  <script type="text/javascript">
                      function shf(id,el) {
	if ($(el).val()=='Input') {
		$('#dcb').hide();
                $('#'+id).hide();
	}	else {
            $('#'+id).show();
			$('#dcb').show();
                            }
}
    function updateListing() {
        $('#customcontainer').addLoader();
        ajax_update('?cmd=clients&action=fields',{updatecontainer:1},function(){
        $('#customcontainer').html(this.resp);
                 bindSortOrder();
});
           $('#facebox .body .content').html("");
    }
    function createField() {
        ajax_update('?cmd=clients&action=field',$('#submitform').serializeObject(),'#facebox .body .content');
            return false;
    }
         function editFieldForm(id) {
		$.facebox({ ajax: "?cmd=clients&action=field&field_id="+id,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
            return false;
    }
       function addCustomFieldForm() {
		$.facebox({ ajax: "?cmd=clients&action=field&field_id=new",width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
		return false;
	   }
		  	
                            function delete_field(id,system) {
                                if(confirm('{/literal}{$lang.confdelf}{literal}')) {
                            $('#customcontainer').addLoader();
                                    ajax_update('?cmd=clients&action=fields&make=delete&field_id='+id,{updatecontainer:1,system:system},function(){
        $('#customcontainer').html(this.resp);
                 bindSortOrder();
}); }
                                        return false;
			}

		  </script>
		  {/literal}
{/if}{/if}