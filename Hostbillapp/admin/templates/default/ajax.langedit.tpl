{*
---------------------------
-------ADD/EDIT/INPUT BOX--------
---------------------------
*}
{if $action=='displaybox'}
{literal}
<style type="text/css">
	#facebox .body,#formcontainer{background:none;border-radius:6px 6px 6px 6px;padding:0}
	.conv_content .tabb{max-height:500px;overflow:auto}
	.conv_content{background:#FFF;border-radius:0 5px 0 0;padding:5px 5px 25px;}
	.conv_content h3{margin-top:0}
	#s_menu{background:#6b6b6b;border-radius:5px 0 0 0;color:#fff;padding:40px 0;vertical-align:top;width:180px}
	#s_menu #initial-desc,#s_menu .description{padding:0 5px}
	#s_menu .descr_image{height:62px;margin:60px 5px 0;width:170px}
	fieldset{border:1px solid #BBB;border-radius:5px 5px 5px 5px;margin-top:10px;padding:10px}
	fieldset legend{font-weight:700;padding:0 10px}
	fieldset label{cursor:pointer}
	.spinner{background:none repeat scroll 0 0 #888;border:1px solid #191919;border-radius:3px;box-shadow:0 1px 0 rgba(255, 255, 255, 0.3);display:none;margin-top:-3px;padding:1px}
	#facebox select,#facebox textarea,#facebox input[type="text"],#facebox input[type="password"],#facebox input[type="email"],#facebox input[type="url"],#facebox input[type="date"],#facebox input[type="number"],#facebox input[type="time"],#facebox input[type="date"],#facebox input.date{border:1px solid #CCC;border-radius:3px 3px 3px 3px;box-shadow:0 1px 3px rgba(0, 0, 0, 0.1) inset;font:13px/16px Arial,sans-serif!important;padding:4px 6px}
	.faceform small{color:#666;font-size:11px}
	.faceform label small{color:#666;display:block;font-size:11px;font-weight:400;line-height:11px;text-align:right;min-width:80px}
	.faceform fieldset > label{clear:left;display:block;float:left;font-size:12px;font-weight:700;padding-top:7px;text-align:right;min-width:80px}
	.faceform .radio {margin:2px 0 10px 10px}
	.faceform .radio label{padding-right:2em}
	.faceform .w250{width:250px}
	.faceform fieldset > input, .faceform select{clear:right;float:left;margin:2px 0 10px 10px}
	.icoselect { border: 1px solid #E0E0E0; color:#8B8E91;   list-style: none outside none;   margin: 0;  padding:0; position:absolute; z-index:1000; background:#fff}
	.icoselect li {display:none; white-space: nowrap; cursor:pointer;  padding: 3px 15px 3px 3px}
	.icoselect li.selected {display:block}
	.icoselect li:hover {background-color:#f0f0f0}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$('#saveform input[name="target"]').change(function(){
			$('#saveform select[name="parent"] option').hide();
			if($(this).val() == 'admin') $('#saveform .otype_admin').show().eq(0).attr('selected','selected');
			else $('#saveform .otype_user').show().eq(0).attr('selected','selected');
		});
		$('input[name="langfile"]').change(function(){
			var lname = $('input[name="langfile"]').val();
			if(lname.indexOf('.') > 0)
				lname = lname.substr(0,lname.indexOf('.'));
			lname = lname.charAt(0).toUpperCase()+lname.slice(1).toLowerCase();
			if($('input[name="name"]').val() == '')
				$('input[name="name"]').val(lname);
		});
		$('.icoselect li').hover(function(){$('.icoselect li').show();},function(){$('.icoselect li:not(.selected)').hide();});
		$('.icoselect li').click(function(){
			$('input[name="icon"]').val($(this).text());
			$('.icoselect li').removeClass('selected').hide();
			$(this).addClass('selected').show();
				$(this).prependTo('.icoselect');
		});
		$('#saveform input[name="target"][value="user"]').click();
	});

</script> 
{/literal}
<form id="saveform" enctype="multipart/form-data" action="?cmd=langedit" method="post">
{if $boxtype == 'addlang'}
<input type="hidden" value="addlang" name="action">
{elseif $boxtype == 'import'} 
<input type="hidden" value="import" name="action">
{/if}
<table width="100%" cellspacing="0" cellpadding="0" border="0">
<tr>
	<td id="s_menu">
		<div id="initial-desc"><strong>{if $lang.Name}{$lang.Name}{else}Name{/if}</strong>
			<br><small>This field lets you specify a name for your new language. {if $boxtype == 'import'}If left empty, file name will be used.{/if}</small>
		</div><br>
		<div id="initial-desc"><strong>{if $lang.lang_icon}{$lang.lang_target}{else}Language icon{/if}</strong>
			<br><small>Icon that will be displayed in client aera next to your language. 
				If you want to upload an icon use 16x11 pixel gif image.</small>
		</div><br>
		<div id="initial-desc"><strong>{if $lang.lang_target}{$lang.lang_target}{else}Target{/if}</strong>
			<br><small>Target option specifies for whom you wish to add new language, as HostBill uses two kinds of translations, one dedicated for user sections, and another only for admin area.</small>
		</div><br>
		{if $boxtype == 'import'}
		<div id="initial-desc"><strong>{if $lang.lang_copyfrom}{$lang.lang_copyfrom}{else}Copy from language{/if}</strong>
			<br><small>When importing new language, HostBill will copy all translation lines from this selected language to your new language, and will update it with translations from your file.</small></div>
		{else}
		<div id="initial-desc"><strong>{if $lang.lang_copyfrom}{$lang.lang_copyfrom}{else}Copy from language{/if}</strong>
			<br><small>When creating new language, HostBill will copy all translation lines from this selected language to your new language.</small></div>
		{/if}
	</td>
	<td class="conv_content faceform">
{if $boxtype == 'addlang'}
		<h3 style="margin-bottom:0px;">
		{if $lang.lang_newlang}{$lang.lang_newlang}{else}New language{/if}
		</h3>
		<fieldset>
			<legend>{if $lang.lang_name}{$lang.lang_name}{else}Language name{/if}</legend>
			<label>{if $lang.Name}{$lang.Name}{else}Name{/if}</label> <input type="text" name="name">
		</fieldset>
{elseif $boxtype == 'import'}
		<h3 style="margin-bottom:0px;" >
		{if $lang.lang_import}{$lang.lang_import}{else}Import language{/if}
		</h3>
		<div class="clear"></div>
		<fieldset>
			<legend>{if $lang.lang_importselect}{$lang.lang_importselect}{else}Select file to import{/if}</legend>
			<label>{if $lang.lang_filename}{$lang.lang_filename}{else}File{/if}</label> <input type="file" name="langfile" size ="28">
			<div class="clear"></div>
			<label>{if $lang.Name}{$lang.Name}{else}Name{/if}</label> <input type="text" name="name">
			<div class="clear"></div>
		</fieldset>
{/if}
		<fieldset>
			<legend>{if $lang.lang_icon}{$lang.lang_icon}{else}Language Icon{/if}</legend>
			<div class="clear"></div>
			<label>{if $lang.lang_iconfile}{$lang.lang_iconfile}{else}Icon file{/if}</label>
			<input type="file" name="iconfile" size ="28">

			<div class="clear"></div>
		</fieldset>
		<fieldset>
			<legend>{if $lang.lang_target}{$lang.lang_target}{else}Target{/if}</legend>
				<div class="radio">
				<input type="radio" value="user" name="target"><label>User</label>
				<input type="radio" value="admin" name="target"><label>Admin</label>
				</div>
		</fieldset>
		<fieldset>
			<legend>{if $lang.lang_copyfrom}{$lang.lang_copyfrom}{else}Copy from language{/if}</legend>
			<label>{if $lang.Language}{$lang.Language}{else}Language{/if}</label> <select name="parent">
			{if $language_count.admin == 0}<option class="otype_admin" value="0">{if $lang.none}{$lang.none}{else}none{/if}</option>{/if}
			{if $language_count.user == 0}<option class="otype_user" value="0">{if $lang.none}{$lang.none}{else}none{/if}</option>{/if}
			{foreach from=$languagelist item=language} 
				<option class="otype_{$language.target}" value="{$language.id}">{$language.name|capitalize}</option>
			{/foreach} 
			</select>
		</fieldset>
	</td>
</tr>
</table>
<div class="dark_shelf dbottom clear" >
	<div class="left spinner">
		<img src="ajax-loading2.gif">
	</div>
		<div class="right">
			<span class="bcontainer ">
				<a class="new_control greenbtn" onclick="$('.spinner').show();$('#saveform').submit();return false;" href="#">
					<span>{if $lang.savechanges}{$lang.savechanges}{else}Save changes{/if}</span>
				</a>
			</span>
		<span>&nbsp;</span>
		<span class="bcontainer">
			<a class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;" href="#">
				<span>{if $lang.Close}{$lang.Close}{else}Close{/if}</span>
			</a>
		</span>
	</div>
	<div class="clear"></div>
</div>{securitytoken}
</form>

{/if}{* END *}
	
{* ----------------------
----TRANSLATION SEARCH---
------------------------- *}
{if $action=='lang_search'}
	{if $found}
		{foreach from=$found item=tr}
			<li class="clear" onclick="go2page('{$tr.section}','{$tr.keyword}'); $('#search_prop').fadeOut('fast');" ><div class="left overflow">{$tr.keyword|truncate:16:".."} <span>{$tr.value|truncate:$tr.lenght:"..":true|regex_replace:"/[><]/":""}</span> </div><div title="{$lang.section}" class="right">in <b>{$tr.section}</b></div></li>
		{/foreach}
	{else}
		<li class="clear"><div class="left"><span>{if $lang.lang_search_no}{$lang.lang_search_no}{else}Sorry, nothing was found.{/if}</span></li>
	{/if}
{/if}
{* ----------------------
--------TRANSLATIONS-----
------------------------- *}
{if $action=='translate' || $action=='bulktranslate'}
	<style type="text/css">{literal}
	#editbox > div.trinfo { margin:10px 10px 0; }
	#editbox > div.trinfo > div.left {display: block; height: 30px; padding: 10px 10px 0}
	#editbox > ul.translations {border:solid 1px #ddd;border-bottom:none; margin:10px}
	table.translations {margin:10px 0;padding:0; width:100%;border-top:solid 1px #ddd}
	table.translations td, table.translations th{padding:10px;border-bottom:solid 1px #ddd; border-left:solid 1px #ddd; margin:0 0; vertical-align:top}
	table.translations th{background:#eee}
	table.translations .firstcell{border-left:none; width:55px; text-align:center}
	table.translations .firstcell a.menuitm span{ padding-left: 14px;}
	.pagebuttons{margin:15px}
	table.translations textarea, table.translations input{padding:0; margin:0; width:100%; height:15px; line-height:15px; border:solid 1px #ddd}
	table.translations textarea {border: 1px solid #DDDDDD;  border-radius: 3px 3px 3px 3px; resize: none;}
	table.translations .editable{background:#ffe}
	table.translations .new{background:#efd}
	table.translations .new td a.menuitm .editsth{background:url('{/literal}{$template_dir}{literal}img/small_close.gif') no-repeat scroll 2px 1px;}
	table.translations .delete{background:#fdd}
	table.translations .delete td a.menuitm .delsth{background:url('{/literal}{$template_dir}{literal}img/small_close.gif') no-repeat scroll 2px 1px;}
	table.translations th a.menuitm .morbtn {background-position:left center; padding-right:0}
	#more_btn {display:none; position: relative;}
	#more_btn > div {left: 55px; position: absolute; top: -14px;}
	#lang_search {float:right; height:2em; vertical-align:center; text-align: right; position: relative;}
	#lang_search input {height: 18px; width: 250px;}
    #lang_search button{
        border: solid 1px #DDD;
        border-top-color: #AAA;
        background-position: 0 0; 
        background-repeat: repeat-x;
        background-image: linear-gradient(top, #ffffff , #E6E6E6 );
        background-image: -o-linear-gradient(top, #ffffff , #E6E6E6 );
        background-image: -moz-linear-gradient(top, #ffffff , #E6E6E6 );
        background-image: -webkit-linear-gradient(top, #ffffff , #E6E6E6 );
        background-image: -ms-linear-gradient(top, #ffffff , #E6E6E6 );
        filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#E6E6E6', GradientType=0);
        filter: progid:dximagetransform.microsoft.gradient(enabled=false);
        width: 60px;background-color: #E6E6E6;border-radius: 0 3px 3px 0;display: inline-block;height: 24px; margin: 0 0 0 -1px; vertical-align: bottom; font-size:12px; line-height: 20px; cursor: pointer;
    }
    #lang_search button:hover, #lang_search button:active{
       -webkit-transition: background-position 0.1s linear;
        -moz-transition: background-position 0.1s linear;
        -ms-transition: background-position 0.1s linear;
        -o-transition: background-position 0.1s linear;
        transition: background-position 0.1s linear;
        background-color: #E9E9E9;
        background-position: 0 -15px; 
    }
	#search_prop{ display:none; background:#FFF; border: 1px solid #DDD; list-style: none;  margin:0; padding: 0; text-align: right;  min-width: 314px; position: absolute; right:0; top:100%}
	#search_prop li , #search_prop a,  #search_prop div{height:1.5em; margin:0; font-size:11px}
	#search_prop li {padding: 2px 7px; color:#2A5DB0; cursor:pointer; line-height: 18px;}
    #search_prop li .overflow{
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
        width: 225px;
        text-align: left;
    }
	#search_prop span {color:#aaa; font-style: italic;}
	#search_prop li:hover {background:#eef}
	.found{background:#FFFeb8}
	.pagebuttons a.menuitm {padding:1px 4px; display:block; float:left}
    a.menuitm.filter .morbtn{
        padding: 0 7px;
    }
    .filter .morbtn.filter-bg{
        background-image: url('{/literal}{$template_dir}/img/filter.png{literal}');
    }
    .filter-opt{
        list-style: none;
        position: absolute;
        box-shadow: 0 1px 6px rgba(0, 0, 0, 0.15) inset, 0 2px 5px rgba(0, 0, 0, 0.15);
        border-radius: 5px 5px 5px 5px;
        display: none;
        margin: 20px 0 0;
        background: #FFFFFF;
        border: solid 1px rgba(0, 0, 0, 0.2);
        min-width: 180px;
        padding: 4px 0;
        z-index: 1000;
    }
    .filter-opt li:hover{
        background-color: #0088CC;
        color: #FFFFFF;
        text-decoration: none;
    }
    .filter-opt li {
        clear: both;
        color: #333333;
        display: block;
        font-weight: normal;
        line-height: 18px;
        padding: 3px 15px;
        white-space: nowrap;
    }
    .filter-opt .on, .filter-opt .off{
        color: #88CCDD;
        display:none;
        float: right;
        padding: 0 0 0 5px;
    }
    .filter-opt .off{
        display: block;
        color: #888888;
    }
    .new_add.disabled{
        opacity: 0.4;
        filter: alpha(opacity = 40);
        cursor: default;
    }
	</style>
	<script type="text/javascript">
		var Globl={};
		Globl.section = {/literal}'{$section}'{literal};
		Globl.lang = '{/literal}{$language_det.id}{literal}';
		Globl.pagination = 'on';
        Globl.filtr = 0;
		Globl.newi = 1;;
        Globl.confirmline = '{/literal}{if $lang.lang_confirmtrans}{$lang.lang_confirmtrans}{else}Are you sure you want to delete those selected translations{/if}{literal}';
        Globl.confirmline2 = '{/literal}{if $lang.lang_confirmpagination}{$lang.lang_confirmpagination}{else}Turning this option On may slow your browser, continue?{/if}{literal}';
        Globl.off = '{/literal}{if $lang.Off}{$lang.Off}{else}Off{/if}{literal}';
        Globl.on = '{/literal}{if $lang.On}{$lang.On}{else}On{/if}{literal}';
        Globl.cancel = '{/literal}{if $lang.Cancel}{$lang.Cancel}{else}Cancel{/if}{literal}';
	</script> 
	{/literal}
	<script type="text/javascript" src="{$template_dir}js/jquery.elastic.min.js"></script>
    <script type="text/javascript" src="{$template_dir}js/langedit.js"></script>
	<form action="" method="post" id="transform" onsubmit="{if $action=='translate'}return saveTranslations(this){/if}">
	{if $action=='translate'}
            <input type="hidden" value="{$language_det.target}" name="target" />
            <input type="hidden" value="{$language_det.id}" name="lang" />
        {elseif $action=='bulktranslate'}
            <input type="hidden" value="bulkupdate" name="make" />
        {/if}
		<div class="blu">
				<a class="tload2" href="?cmd=langedit"><span>{if $lang.lang_languages}{$lang.lang_languages}{else}Languages{/if}</span></a>
                {if $action=='translate'}
				 &raquo;  <strong>{$language_det.name|capitalize}</strong> »
				 <span>{if $lang.lang_section}{$lang.lang_section}{else}Section{/if}</span> 
				 <select id="sectionselect" onchange="changeSection(this.value)">
                     <option selected="selected" value="-1" style="font-weight: bold">All translations</option>
					{if $sections}
					{foreach from=$sections item=section_name}
					 <option {if $section_name == $section }selected="selected"{/if} value="{$section_name}" >{$section_name}</option>
					 {/foreach}
					 {else}<option selected="selected" value="global">global</option>
					 {/if}
				 </select>
				<a class="new_control" onclick="return addSection();" href="#">
					<span class="addsth"><strong>{if $lang.lang_customsection}{$lang.lang_customsection}{else}Custom section{/if}</strong></span>
				</a>
                                 {elseif $action=='bulktranslate'}
                                 &raquo; Tag: <strong>{$tag}</strong>
                                 {/if}
			
		</div>
		 {if $action=='translate'}
		<div class="right pagebuttons">
			<div class="right">
			<div class="pagination"></div>
			</div>
            <a class="menuitm menu filter" href="#" onclick="openFilters(this); return false;" title="{if $lang.filteropt}{$lang.filteropt}{else}Filter options{/if}">
                <span class="morbtn filter-bg"> </span>
				<span class="morbtn"></span>
			</a>
            <ul class="filter-opt">
                <li rel="2"><span class="on">On</span><span class="off">Off</span> Only blank lines</li>
                {if $language_det.parent_name}
                    <li rel="4"><span class="on">On</span><span class="off">Off</span> Same value as parent</li>
                {/if}
            </ul>
			<a class="menuitm menuf" href="#" onclick="return pagination_toggle()">
				{if $lang.showall}{$lang.showall}{else}Show all{/if}
			</a>
			<a class="menuitm menul" href="#" onclick="return pagination_toggle()" >
				{if $lang.Off}{$lang.Off}{else}Off{/if}
			</a>
			<div class="clear"></div>
		</div>{/if}
		
		<div style="padding:10px 5px 0 5px"> 
			<a class="new_dsave new_menu" href="#" onclick="$('#transform').submit(); return false;">
				<span>{if $lang.savechanges}{$lang.savechanges}{else}Save changes{/if}</span>
			</a>
			{if $action=='translate'}<a class="new_add new_menu" href="#" onclick="return addTranslation();">
				<span>{if $lang.lang_newtrans}{$lang.lang_newtrans}{else}New translation{/if}</span>
			</a>
			<div id="lang_search">
                <input type="text" name="lang_search" autocomplete="off"><button onclick="$('#lang_search input').keyup(); return false;">{if $lang.Search}{$lang.Search}{else}Search{/if}</button>
				<ul id="search_prop">
				</ul>
			</div>{/if}
			
			<div class="clear"></div>
		</div>


		{/if}{if $action=='translate' || $action=='getsection' }
		<table class="translations" cellspacing="0">
			<thead>
			<tr>
				<th class="firstcell">
					<input type="hidden" value="{$section}" name="section" />
					<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
					<a href="?cmd=langedit&action=getsectionpage&lang={$language_det.id}&section={$section}{if $filtr}&filtr={$filtr}{/if}" id="currentlist" style="display:none" updater="#updater"></a>
					<a class="menuitm menu" href="#" title="{if $lang.Manage}{$lang.Manage}{else}Manage{/if}" onclick="$('#more_btn').fadeToggle('slow')">
						<small>{if $lang.Manage}{$lang.Manage}{else}Manage{/if}</small>
						<span style="padding:0 7px 0 2px" class="morbtn"></span>
					</a>
				<div id="more_btn">
					<div>
						<a onclick="mark_all('edit');" title="{if $lang.Delete}{$lang.Edit}{else}Edit{/if}" class="menuitm menuc" href="#">
							<span class="editsth"></span>
						</a>
						<a onclick="mark_all('undel'); "  style="padding: 3px 3px 3px 7px;" title="{if $lang.Delete}{$lang.Cancel}{else}Cancel{/if}" class="menuitm menuc" href="#">
							<span class="rmsth"></span>
						</a>
						<a onclick="mark_all('del');" title="{if $lang.Delete}{$lang.Delete}{else}Delete{/if}" class="menuitm menul" href="#">
							<span class="delsth"></span>
						</a>
					</div>
				</div>
				</th>
				<th style="width:20% ; min-width: 190px;">
					<a href="?cmd=langedit&action=getsectionpage&lang={$language_det.id}&section={$section}&orderby=keyword|ASC" title="{$lang.lang_sort} {$lang.lang_keyword}" class="sortorder">
					{if $lang.lang_keyword}{$lang.lang_keyword}{else}Keyword{/if}</a>
				</th>
			<th>
				<a href="?cmd=langedit&action=getsectionpage&lang={$language_det.id}&section={$section}&orderby=value|ASC" title="{$lang.lang_sort} {$lang.lang_value}" class="sortorder" >{if $lang.lang_value}{$lang.lang_value}{else}Value{/if}</a>
			</th>
			{if $language_det.parent_name}
			<th style="min-width:80px">
				<a href="?cmd=langedit&action=getsectionpage&lang={$language_det.id}&section={$section}&orderby=parent_value|ASC" title="Sort by {$language_det.parent_name} Value" class="sortorder">{$language_det.parent_name|capitalize} {if $lang.lang_value}{$lang.lang_value}{else}Value{/if}</a>
			</th>
			{/if}
			</tr>
			</thead>
			<tbody id="updater">
			{/if}{if $action=='translate' || $action=='getsection' || $action=='getsectionpage'}
			<tr style="display:none">
				<td>
					<input type="hidden" value="{$page}" name="page" />
					<input type="hidden" value="{$pagination}" name="pagination" />
				</td>
			</tr>
			{if !empty($translations) }
				{foreach from=$translations item=line}
				<tr id="trans_row_" {if $line.found}class="found"{/if}>
					<td class="firstcell">
						{if $line.found}<a name="found"></a>{/if}
						<a href="#" class="menuitm menuf" title="{if $lang.Edit}{$lang.Edit}{else}Edit{/if}" onclick="return editTranslation(this)" >
							<span class="editsth"></span>
						</a>
						<a href="#" class="menuitm menul" title="{if $lang.Delete}{$lang.Delete}{else}Delete{/if}" onclick="return delTranslation(this)" >
							<span class="delsth"></span>
						</a>
					</td>
					<td class="keybox">{$line.keyword}</td>
					<td class="valuebox" {if $section == '-1'}rel="{$line.section}"{/if}>{$line.value}</td>
					{if $language_det.parent_name}
					<td>{$line.parent_value}</td>
					{/if}
				</tr>
				{/foreach}
			{else}
                <tr id="trans_row_">
                    <td colspan="20">
                        {$lang.nothingtodisplay}
                        {if !$filtr}
                        <script type="text/javascript"> if(Globl.section != 'global') window.location.reload(); </script>
                        {/if}
                    </td>
				</tr>
			{/if}
			</tbody>
			{/if}{if $action=='translate' || $action=='bulktranslate'}
                        {if $action=='bulktranslate'}
                        {include file='ajax.langedit.bulk.tpl'}
                        {elseif $action=='translate'}</table>
		 <div class="right pagebuttons">
			<div class="right">
			<div class="pagination"></div>
			</div>
			<a class="menuitm menuf" href="#" onclick="return pagination_toggle()">
				{if $lang.showall}{$lang.showall}{else}Show all{/if}
			</a>
			<a class="menuitm menul" href="#" onclick="return pagination_toggle()" >
				{if $lang.Off}{$lang.Off}{else}Off{/if}
			</a>
			<div class="clear"></div>
		 </div>{/if}
		
		<div style="padding:10px 5px"> 
			<a class="new_dsave new_menu" href="#" onclick="$('#transform').submit(); return false;">
				<span>{if $lang.savechanges}{$lang.savechanges}{else}Save changes{/if}</span>
			</a>
			<div class="clear"></div>
		</div>
	 </form>
{/if}{* TRANSLATIONS END *}

{*
---------------------------
----------DEFAULT----------
---------------------------
*}
{if $action=='default'}	{literal}
	<script type="text/javascript">
		var target = ['user','admin'];
		var type;
		$(document).ready(function(){
			$('.list-1 li').click(function() {
				type = target[$(this).index()];
				$('.list-1 li').removeClass('active');
				$(this).addClass('active');
				$('#langlist li').hide().filter('.target.'+type).show();
			});
		});
		
		function disableLanguage(id){
			ajax_update("?cmd=langedit",{action:'editlang',lang:id, status:'disable'},function(){
			refreshLang();
			});
		}
		function enableLanguage(id){
			ajax_update("?cmd=langedit",{action:'editlang',lang:id, status:'enable'},function(){
			refreshLang();
			});
		}
		function delLanguage(id){
			if(!confirm('{/literal}{if $lang.lang_confirmlang}{$lang.lang_confirmlang}{else}Are you sure you want to delete this language?{/if}{literal}')) 
				return false;
			ajax_update('?cmd=langedit',{action:'dellang',lang:id},function(){
				refreshLang();
			});
			return false;
		}
		function refreshLang() {
			ajax_update("?cmd=langedit",{action:"refreshlist",type:type},'#langlist');
			$('.list-1 li.active').click();
			return false;
		}
		function displaybox(type){
			$.facebox({ajax:"?cmd=langedit&action=displaybox&type="+type,width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
			return false;
		}
	</script> 
	{/literal}
		<div class="blu" style="padding:7px 5px 10px">
			<a class="new_control" onclick="return displaybox('addlang');" href="#">
				<span class="addsth">
					<strong>{if $lang.lang_newlang}{$lang.lang_newlang}{else}New language{/if}</strong>
				</span>
			</a>&nbsp;
			<a class="new_control" onclick="return displaybox('import');" href="#">
				<span class="dwd">{if $lang.lang_import}{$lang.lang_import}{else}Import language{/if}</span>
			</a>
		</div>
		<div id="newshelfnav" class="newhorizontalnav">
			<div class="list-1">
				<ul>
					<li class="active">
						<a href="#"><span>{if $lang.lang_client}{$lang.lang_client}{else}Client languages{/if}</span></a>
					</li>
					<li class="last">
						<a href="#"><span>{if $lang.lang_admin}{$lang.lang_admin}{else}Admin languages{/if}</span></a>
					</li>
				</ul>
			</div>
		</div>
		<ul id="langlist" class="grab-sorter sectioncontent" style="border:solid 1px #ddd;border-bottom:none; margin:10px" >
	{/if}
	{if $action=='default' || $action=='refreshlist'}
		{if $languagelist}
		{foreach from=$languagelist item=language} 
			<li style="border-bottom:solid 1px #ddd;{if $language.target != $type}display:none{/if}" class="target {$language.target}" >
				<div style="padding:13px 5px; float:left;min-width:90px;text-align:left">
					<a href="?cmd=langedit&action=translate&lang={$language.id}" class="menuitm menuf" title="{if $lang.Edit}{$lang.Edit}{else}Edit{/if}" >
						<span class="editsth"></span>
					</a>
					<a href="?cmd=langedit&action=export&lang={$language.id}" class="menuitm {if !in_array($language.id,$default_langs)}menuc{else}menul{/if}" target="_blank" title="{if $lang.lang_export}{$lang.lang_export}{else}Export{/if}" style="padding-right:2px" >
						<span class="disk-export"></span>
					</a>
					{if !in_array($language.id,$default_langs)}
					<a href="#" class="menuitm menul" onclick="return delLanguage({$language.id})" title="{if $lang.Delete}{$lang.Delete}{else}Delete{/if}" >
						<span class="delsth"></span>
					</a>
					{/if}
				</div>
				<div style="padding:13px 5px;min-width:230px; float:left">{$language.name|capitalize}</div>
				{if $language.target!='admin' || !in_array($language.id,$default_langs)}
				<div style="padding:10px 5px; float:left">
					<input onclick="enableLanguage({$language.id})" type="radio" {if $language.status == 1}checked="checked"{/if} value="1" name="widget[{$language.id}][enable]">
					<label>{if $lang.Enable}{$lang.Enable}{else}Enable{/if}</label>
					<input onclick="disableLanguage({$language.id})" type="radio" {if $language.status == 0}checked="checked"{/if} value="0" name="widget[{$language.id}][enable]">
					<label>{if $lang.Disable}{$lang.Disable}{else}Disable{/if}</label>
				</div>
				{/if}
				<div class="clear"></div>
			</li>
		{/foreach}
		{/if}
		{if $language_count.user == 0}
			<li class="target user"	style="{if 'user' != $type}display:none;{/if}border-bottom:solid 1px #ddd;padding:12px 10px;" >
				<a class="new_control" onclick="return displaybox('addlang');" href="#">
					<span class="addsth"><strong>{if $lang.lang_newlang}{$lang.lang_newlang}{else}New language{/if}</strong></span>
				</a>
			</li>
		{/if}
		{if $language_count.admin == 0}
			<li class="target admin"	style="{if 'admin' != $type}display:none;{/if}border-bottom:solid 1px #ddd;padding:12px 10px;" >
				<a class="new_control" onclick="return displaybox('addlang');" href="#">
					<span class="addsth"><strong>{if $lang.lang_newlang}{$lang.lang_newlang}{else}New language{/if}</strong></span>
				</a>
			</li>
		{/if}
	{/if}
	{if $action=='default'}
		</ul>
		<div style="margin:2em 10px; padding:1em" class="shownice tabb"> 
			<strong>You can download additinal languages for HostBill from <a href="http://cdn.hostbillapp.com/languages/" class="external" target="_blank">Here</a></strong><br>
			<small>To learn how to import or add new languages to HostBill, check this how-to guide on our wiki <a href="http://wiki.hostbillapp.com/index.php?title=Add_new_languages" class="external" target="_blank">How To add new languages</a></small>
		</div>
	{/if}
