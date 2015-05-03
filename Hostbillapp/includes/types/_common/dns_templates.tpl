 {if $product.id=='new'}
<center>
    <strong>{$lang.save_product_first}</strong>
</center>
{else}

{literal}
<style type="text/css">
	#dns_list {border:solid 1px #ddd; border-bottom:none; margin:10px; background:#fff}
	#dns_list li {border-bottom:solid 1px #ddd}
	#dns_list li > div {padding:13px 5px; float:left;min-width:60px;text-align:left;}
	#dns_list .clear {float:none; padding:0; }
	.dns_template {}
	.dns_template th {border-bottom:1px solid #ddd}
	.dns_template td{border-left:1px solid #ddd; border-top:1px solid #ddd}
	.dns_template tr.first td{border-top:none}
	.dns_template td.first {border-left:none}
	#dns_list .menuitm span.zoom {background-position:center center; padding-left:12px}
	#dns_list li > div.tab_sllider {display:none; float:none; padding:0; margin:0; clear:both}
	#dns_list .controls {border-left:none; width:40px; display:table-cell}
	#dns_list tr:hover .controls a {display:block;}
	#dns_list .controls a , #template_scheme, #dns_list .template_name .editbtn, #dns_list .template_name input{display:none;}
	#dns_list .template_name:hover .editbtn {display:inline;}
	#dns_list input, #dns_list select {  border: 1px solid #DDD; border-radius: 4px; box-shadow: 0px 3px 7px #EEEEEE inset; width: 96%;}

</style>

<script type="text/javascript">
	var start = false;
	$(function(){
		dnstemplates_bind();
	});
	var record_i = 0;
	var template_i = 0;
	function addTemplate(){
		$('#template_scheme').before($('#template_scheme').clone()).attr('id','tpl_n'+template_i);
		$('#dns_list li#tpl_n'+template_i+' .template_name').prepend('<input name="dt_template[n'+template_i+']" value="Default template">');
		template_i++;
		dnstemplates_bind();
		return false;
	}

	function addRecord(tplid){
		var name = ['name','ttl','prio','type','content'];
		$('#tpl_'+tplid+' table tr:last')
		.before('<tr id="rec_n'+record_i+'"><td><td><td><td><td><td class="controls"><a href="#" onclick="return removeRecord(\'n'+record_i+'\',1)" class="delbtn">');
		//editRecord(tplid,'n'+record_i);
		$('tr#rec_n'+record_i+' td').not('.controls').each(function(x){
			var txt = $(this).text();
			if(x!=3)
			$(this).html('<input name="dt_records['+tplid+'][n'+record_i+']['+name[x]+']" value="'+txt+'" >');
			else{
				$(this).html('<select name="dt_records['+tplid+'][n'+record_i+']['+name[x]+']" >{/literal}{foreach from=$supported_types item=st}<option value="{$st}">{$st}{/foreach}{literal}');
				$(this).find('option[value="'+txt+'"]').attr('selected',true);
			}
		});
		$('#tpl_'+tplid+' table tr.empty').hide();
		record_i++;
		return false;
	}
	function editRecord(tplid,rid){

		$('tr#rec_'+rid+' td span').hide();
		$('tr#rec_'+rid+' td input, tr#rec_'+rid+' td select').show();
		$('tr#rec_'+rid+' td.controls a.editbtn').hide();
		return false;
	}
	function removeRecord(rid,soft){
		if(!soft){
			$('#dns_list').after('<input type="hidden" name="dt_remove[]" value="'+rid+'">');
		}
		$('tr#rec_'+rid).remove();
		return false;
	}
	function editTemplateName(ths){
		$(ths).prevAll('input').val($(ths).prev().text()).show().nextAll().hide();
		return false;
	}
	function dnstemplates_bind(){
		$('#dns_list div > a').unbind();
		$('#dns_list div:first-child > a:first-child').click(function(){
			if($(this).hasClass('activated')){
				$('#dns_list .tab_sllider').slideUp('fast');
				$(this).removeClass('activated');
			}
			else{
				$('#dns_list .tab_sllider').slideUp('fast');
				$('#dns_list div > a:first-child').removeClass('activated');
				$(this).addClass('activated').parent().nextAll('.tab_sllider').slideDown('fast');
			}
			return false;
		});
		$('#dns_list div:first-child > a:nth-child(2)').not('.menul').click(function(){
			var htm='';
			$(this).parents('li').eq(0).find('tbody tr').each(function(x){
				htm+='<tr>';
				$(this).find('input, select').each(function(y){
					htm+='<td>'+$(this).val().replace(/{domain}/g, "example.com").replace(/{ip}/g, "127.0.0.1")+'</td>';
				});
				htm+='</tr>';
			});
			$('#dt_prev table tbody:last').html(htm);
			$.facebox({div:'#dt_prev', width:900, nofooter:true, opacity:0.8, addclass:'modernfacebox' });
			return false;
		});

		$('#dns_list div:first-child > a:last-child').click(function(){
			var tplid= $(this).parents('li').eq(0).attr('id');
			if(tplid.substr(4,1)!='n')
				$('#dns_list').after('<input type="hidden" name="dt_remove_tpl[]" value="'+tplid.substr(4)+'">');
			$(this).parents('li').remove();
			if($('#dns_list li').length < 2){
				$('#dns_template_box').hide();
				$('#dns_templates_blank').show();
			}
			return false;
		});
	}
</script>
{/literal}

<div class="p6" style="margin-bottom: 15px;display:none" id="importdnszones">
    <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
        <tbody><tr>
                <td>
                    <input type="file" name="importdnszones">
                </td>
                <td>
                    <input type="button" onclick="return saveProductFull();" style="font-weight:bold" value="Import">
                    <span class="orspace">Or</span> <a class="editbtn" onclick="$('#importdnszones').hide();return false;" href="#">{$lang.Cancel}</a>
                </td>
            </tr>
        </tbody></table>
    <span class="pdescriptions fs11">Note: You can import yml file generated from other HostBill product to speed up configuration process</span>
</div>

<div id="dns_template_box" {if !$dns_templates}style="display:none"{/if}>
     <ul id="dns_list" class="grab-sorter" style="margin:0px;">
	{foreach from=$dns_templates item=template key=name}
	<li id="tpl_{$template[0].id}">
		<div>
			<a href="#" class="menuitm menuf" title="{$lang.Edit}" >
				<span class="editsth"></span>
			</a>
			<a href="#" class="menuitm menuc" title="{$lang.Preview}" >
				<span class="zoom"></span>
			</a>
			<a href="#" class="menuitm menul" title="{$lang.Delete}" >
				<span class="delsth"></span>
			</a>
		</div>
		<div class="template_name"><input name="dt_template[{$template[0].id}]" value=""><span>{$template[0].template}</span> <a class="editbtn" href="#" onclick="return editTemplateName(this)" >Edit</a></div>
		<div class="tab_sllider">
		<table cellspacing="0" cellpadding="6" border="0" width="100%" class="styled dns_template">
			<thead ><tr><th>{$lang.Name}</th>	<th>TTL</th>	<th>Priority</th>	<th>{$lang.Type}</th>	<th>Content</th> <th></th></tr></thead>
			<tbody>
				{if $template[0].name}
				{foreach from=$template item=record key=row}
				<tr {if $row==0}class="first"{/if} id="rec_{$record.record_id}">
					<td class="first"><span>{$record.name}</span> <input class="none" type="text" name="dt_records[{$record.id}][{$record.record_id}][name]" value="{$record.name}"></td>
					<td><span>{$record.ttl}</span> <input class="none" type="text" name="dt_records[{$record.id}][{$record.record_id}][ttl]" value="{$record.ttl}"></td>
					<td><span>{$record.prio}</span> <input class="none" type="text" name="dt_records[{$record.id}][{$record.record_id}][prio]" value="{$record.prio}"></td>
					<td><span>{$record.type}</span>
						<select class="none" name="dt_records[{$record.id}][{$record.record_id}][type]" >
						{foreach from=$supported_types item=st}<option {if $record.type==$st}selected="selected"{/if} value="{$st}">{$st}</option>{/foreach}
						</select>
					</td>
					<td><span>{$record.content}</span> <input class="none" type="text" name="dt_records[{$record.id}][{$record.record_id}][content]" value="{$record.content}"></td>
					<td class="controls" >
						<a href="#" class="editbtn" title="{$lang.Edit}" onclick="return editRecord('{$record.id}','{$record.record_id}')">
						{$lang.Edit}</a>
						<a href="#" class="delbtn" title="{$lang.Delete}"onclick="return removeRecord('{$record.record_id}')" >
						</a>
					</td>
				</tr>
				{/foreach}
				{else}
				<tr class="first empty">	<td class="first" style="text-align:center" colspan="6">No records</td>	</tr>
				{/if}
				<tr>	<td class="first" colspan="6">	<a href="#" onclick="return addRecord('{$template[0].id}')">Add template record</a>	</td>	</tr>
			</tbody>
		</table>
		</div>
		<div class="clear"></div>
	</li>
	{/foreach}
	<div id="dt_prev" style="display:none">
		<table class="fcbx" width="100%" style="background:#fff; padding: 10px" cellpadding="8">
			<thead>
				<tr><th>Name</th><th>TTL</th><th>Priorty</th><th>Type</th><th>Content</th></tr>
			</thead>
			<tbody>
				<tr style="vertical-align:top">
				<td>example.com</td>
				<td>7200</td>
				<td>0</td>
				<td>SOA</td>
				<td align="left" style="padding-left:1em">ns1.example.com client@email.com (<br>
				<div class="clear left" style="min-width: 90px; padding-right: 0.5em;text-align: right;">2011102600;</div><div> Serial</div>
				<div class="clear left" style="min-width: 90px; padding-right: 0.5em;text-align: right;">10800;</div><div> Refresh</div>
				<div class="clear left" style="min-width: 90px; padding-right: 0.5em;text-align: right;">3600;</div><div> Retry</div>
				<div class="clear left" style="min-width: 90px; padding-right: 0.5em;text-align: right;">1814400;</div><div> Expire</div>
				<div class="clear left" style="min-width: 90px; padding-right: 0.5em;text-align: right;">7200</div><div> Minimum TTL</div>
				&nbsp;&nbsp;&nbsp;)
				</td>
				<td align="right">
				</td>
				</tr>
			</tbody>
			<tbody>
			</tbody>
		</table>
		<div class="dark_shelf dbottom">
		<div class="right">
			<span class="bcontainer"><a onclick="$(document).trigger('close.facebox');return false;" class="submiter menuitm" href="#"><span>Close</span></a></span>
		</div>
		</div>
	</div>
	<li id="template_scheme" >
		<div>
			<a href="#" class="menuitm menuf" title="{$lang.Edit}" >
				<span class="editsth"></span>
			</a>
			<a href="#" class="menuitm menul" title="{$lang.Delete}" >
				<span class="delsth"></span>
			</a>
		</div>
		<div class="template_name"><span>Default template</span> <a class="editbtn" href="#" onclick="return editTemplateName(this)" >Edit</a></div>
		<div class="tab_sllider">
		<table cellspacing="0" cellpadding="6" border="0" width="100%" class="styled dns_template">
			<thead ><tr><th>{$lang.Name}</th>	<th>TTL</th>	<th>Priority</th>	<th>{$lang.Type}</th>	<th>Content</th> <th></th></tr></thead>
			<tbody>
			<tr class="first empty">	<td class="first" style="text-align:center" colspan="6">No records</td>	</tr>
			<tr>	<td class="first" colspan="6">	<a href="#"  onclick="return addRecord($(this).parents('li').attr('id').substr(4))">Add template record</a>	</td>	</tr>
			</tbody>
		</table>
		</div>
		<div class="clear"></div>
	</li>
</ul>
     <div style="padding:15px 0px;"><div class="left"><a  href="#" class="new_control">
            <span class="addsth" onclick="return addTemplate()" >
                <strong>Add  Template</strong>
            </span>
        </a>&nbsp;
        <a target="_blank" class="new_control" href="?cmd=dnstpl&action=export&product_id={$product.id}"><span class="disk-export">Export</span></a>
        &nbsp;<a onclick="$('#importdnszones').show(); return false" class="new_control" href="#"><span class="disk-import">Import</span></a>
    </div>
     <div class="left" style="margin-left:20px;padding-top:4px;">
         Note: <b>{literal}{domain}{/literal}</b> used in entries will be replaced with client's domain name. <br />
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>{literal}{ip}{/literal}</b> used in entries will be replaced with dns server ip, or client account ip if used with DomainDNS plugin
     </div>
     <div class="clear"></div>
</div></div>
<div id="dns_templates_blank" {if $dns_templates}style="display:none"{/if} class="blank_state_smaller blank_forms">
    <div class="blank_info">
        <h3>DNS Templates</h3>
        <div class="clear"></div>
        DNS Templates allows you to create custom, re-usable DNS records that your clients can use with DNS packages.
		<div class="clear"></div><br>
		<a style="margin-top:10px" href="#" class="new_control">
		<span class="addsth" onclick="$('#dns_template_box').show(); $('#dns_templates_blank').hide(); return addTemplate()">
			<strong>Add  Template</strong>
		</span>
		</a><span class="orspace">Or</span>
                <a onclick="$('#importdnszones').show(); return false" class="new_control" href="#"><span class="disk-import">Import</span></a>
    </div>
</div>
{/if}