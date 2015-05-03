{if $action=='newpageextra'}
    <tr>
        <td align="right"  valign="top" style="padding-top:12px;"><strong>{$lang.ordertype}</strong></td>
        <td valign="top">
            <div id="template_wizard">
                <select name="ptype"  class="inp template" onchange="sl(this)"  style="font-weight:bold;font-size:14px !important;">
                    {foreach from=$ptypes item=lptype}
                        <option value="{$lptype.id}" {if $category.ptype_id==$lptype.id || (!$category.ptype_id && $ptype==$lptype.id)}selected="selected"{/if}>
                            {assign var="descr" value="_hosting"}
                            {assign var="bescr" value=$lptype.lptype}
                            {assign var="baz" value="$bescr$descr"}
                            {if $lang.$baz}{$lang.$baz}
                            {else}{$lptype.type}
                            {/if}
                        </option>
                    {/foreach}
                </select>
                {if $countinactive}<div class="fs11 tabb" >注意: 这是 <b>{$countinactive}</b> 非活动状态类型的订单, 您可以通过相关操作激活它们
                        <a href="?cmd=managemodules&action=hosting" target="_blank">主机模块</a>
                    </div>
                {/if}
            </div>
        </td>
        <td rowspan="3" class="gallery" valign="top">
            {foreach from=$templates key=templ item=t name=lop}
                <div id="oo_{$templ}" {if $selected==$templ || (!$selected && ($category.otype==$templ || $category.template==$templ || (!$category.otype && !$category.template && !$checkedx)))}{assign var=checkedx value=true}{else}style="display:none"{/if} class="gal_slide">
                    {if $t.thumb}
                        <div class="gal_itm">
                            <img src="{$system_url}{$t.thumb}" class="thumb" />
                            {if $t.img} <a class="preview" href="{$system_url}{$t.img}" target="_blank">{$lang.Preview}</a>
                            {/if}
                            {if $t.config}<a class="edit" href="{$system_url}{$t.img}" onclick="return HBServices.customize()">Customize</a>
                            {/if}
                        </div>
                    {/if}
                    <h1 class="hh1">
                        {if $templ=='custom'}
                            {if $t.name}{$t.name}
                            {else}{$lang.typespecificcheckout}
                            {/if}
                        {elseif $t.name}{$t.name}
                        {elseif $lang.$templ}{$lang.$templ}
                        {else}{$templ}
                        {/if}
                    </h1>
                    {$t.description}
                </div>
            {/foreach}
        </td>
    </tr>
    {if "config:EnableQuote:on"|checkcondition }
    <tr>
        <td width="160" align="right" valign="top" style="padding-top:12px;">
            <strong>订单句柄</strong>
        </td>
        <td valign="top">
            <select name="options[order_handler]" class="inp" >
                <option value="0">正常秩序 (默认)</option>
                <option {if "config:EnabledQuote:`$category.id`"|checkcondition}selected="selected"{/if} value="2">生成草稿 (隐藏价格)</option>
            </select>
        </td>
    </tr>
    {/if}
    <tr>
        <td width="160" align="right" valign="top" style="padding-top:20px;">
            <strong>{$lang.ordertemplate}</strong>
        </td>
        <td valign="top" style="padding-top:10px;font-size:13px">
            <div class="shownice" style="padding:10px 0px;margin-bottom:5px"> <b> 采购最新模板访问: <a class="external" target="_blank" href="https://hostbillapp.com/apps/" >这里</a> </b></div>
                或者选择现有模板: 
            <div id="wiz_options">
                
                <ul class="opage-list">
                    {foreach from=$templates key=templ item=t name=lop}
                    <li {if $selected==$templ || (!$selected && ($category.otype==$templ || $category.template==$templ || (!$category.otype && !$category.template && !$checked)))}class="activated"{/if}  onclick="$('.opage-list .activated').removeClass();get_descr($(this).children('input')[0])">
                            <input type="radio" name="otype" value="{$templ}" id="o_{$templ}" 
                            {if $selected==$templ || (!$selected && ($category.otype==$templ || $category.template==$templ || (!$category.otype && !$category.template && !$checked)))}checked="checked"{assign var=checked value=true}{/if}/>
                            <img src="{$system_url}{$t.thumb}" class="thumb" />
                            <label for="o_{$templ}" {if $t.custom==true}class="tpl-custom"{/if}>
                                {if $t.custom==true}
                                    {if $t.name}{$t.name}
                                    {else}{$lang.typespecificcheckout}
                                    {/if}
                                {elseif $t.name}{$t.name}
                                {elseif $lang.$templ}{$lang.$templ}
                                {else}{$templ}
                                {/if}
                            </label>
                        </li>
                    {/foreach}
                   
                </ul>
            </div>
        </td>
        
    </tr>
    {if $premade}
        <tr>
            <td align="right"><strong>{$lang.premadeproducts}</strong></td>
            <td colspan="2" id="subwiz_opt">
                <span><input type="radio" name="premade" value="0" id="premade00" onclick="prswitch('x',this);"/> <label for="premade00">{$lang.none}</label> </span>
                    {foreach from=$premade item=pr key=k name=fpremade}
                    <span {if $smarty.foreach.fpremade.first}class="active"{/if}>
                        <input type="radio" name="premade" value="{$pr.file}" id="premade{$k}"  {if $smarty.foreach.fpremade.first}checked="checked"{/if} onclick="prswitch('{$k}',this);"/>
                        <label for="premade{$k}">{$pr.name}</label>
                    </span>
                {/foreach}
            </td>
        </tr>
        <tr>
            <td align="right"></td>
            <td colspan="2">
                {foreach from=$premade item=pr key=k name=fpremade}
                    <div class="pr_desc" {if !$smarty.foreach.fpremade.first} style="display:none" {/if} id="pr_desc{$k}">
                        {$pr.description}
                    </div>
                {/foreach}
            </td>
        </tr>
    {/if}

    {if $server_fields && $server_fields.module}
        <div id="prod_serverform"  class="sectionheadblue prod_serverform">

            <input name="addserver" value="1" type="hidden" />
            <input name="module" value="{$server_fields.module}" type="hidden" />
            <table border="0" cellpadding="0" cellspacing="6" width="100%" style="margin-bottom:10px;">
                {if $server_fields.display.hostname}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="40" value="{$server_values.host}" class="inp"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.ip}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="40" value="{$server_values.ip}" class="inp"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.username}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server_values.username}" class="inp"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.password}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server_values.password}" autocomplete="off"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.field1}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td ><input  name="field1" size="25" value="{$server_values.field1}" class="inp"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.field2}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td><td ><input  name="field2" size="25" value="{$server_values.field2}" class="inp"/></td>
                    </tr>
                {/if}
                {if $server_fields.display.hash}<tr>
                        <td width="100" valign="top" align="right"><strong>{if $server_fields.description.hash}{$server_fields.description.hash}{else}{$lang.accesshash}{/if}</strong></td><td ><textarea name="hash" cols="40" rows="8" value="{$server_values.hash}" class="inp"></textarea></td>
                    </tr>
                {/if}
                {if $server_fields.display.ssl}<tr>
                        <td  align="right" width="100"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server_values.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td>
                    </tr>
                {/if}
                {if $server_fields.display.custom}
                         {foreach from=$server_fields.display.custom item=conf key=k}
                         <tr>
                             <td  align="right" width="165"><strong>{$k}</strong></td>
                                 {if $conf.type=='input'}

                                     <td ><input type="text" name="custom[{$k}]" value="{$server_values.custom.$k}" class="inp"/></td>
                            {elseif $conf.type=='password'}
                                   <td ><input type="password" autocomplete="off" name="custom[{$k}]" value="{$server_values.custom.$k}"  class="inp"/></td>
                              {elseif $conf.type=='textarea'}
                                 <td >
 <span style="vertical-align:top"><textarea name="custom[{$k}]" rows="5" cols="60" style="margin:0px" >{$server_values.custom.$k}</textarea></span></td>
                            {/if}

                         </tr>
                         {/foreach}
                        {/if}
            </table>
        </div>
    {/if}
{elseif $action=='addonseditor'}
    {if $addons.addons || $addons.applied}{if $addons.applied}<div class="p5">

                <table border="0" cellpadding="6" cellspacing="0" width="100%" >

                    {foreach from=$addons.addons item=f}
                        {if $f.assigned}<tr class="havecontrols">
                                <td width="16">
                                    <div class="controls"><a href="#" class="rembtn"  onclick="return removeadd('{$f.id}')">{$lang.Remove}</a></div></td>
                                <td align="left">{$lang.Addon}: <strong>{$f.name}</strong>
                                </td>
                                <td align="right">
                                    <div class="controls fs11">
                                        {$lang.goto}
                                        <a href="?cmd=productaddons&action=addon&id={$f.id}" class="editbtn editgray" style="float:none" target="_blank">{$lang.addonpage}</a>
                                    </div>
                                </td>
                            </tr>
                        {/if}
                    {/foreach}
                </table>
            </div>
            <div style="padding:10px 4px">
                {if $addons.available}
                    <a href="#" class="new_control" onclick="$(this).hide();$('#addnew_addons').ShowNicely();return false;"  id="addnew_addon_btn">
                        <span class="addsth" >{$lang.assign_new_addons}</span>
                    </a>
                {/if}
            </div>
        {else}
            <div class="blank_state_smaller blank_forms">
                <div class="blank_info">
                    <h3>{$lang.offeraddons}</h3>
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

        {if $addons.available}
            <div class="p6" id="addnew_addons" {if $addons.applied}style="display:none"{/if}>
                <table  cellpadding="3" cellspacing="0">
                    <tr>
                        <td>
                            {$lang.Addon}: <select name="addon_id">
                                {foreach from=$addons.addons item=f}
                                    {if !$f.assigned}
                                        <option value="{$f.id}">{$f.name}</option>
                                    {/if}
                                {/foreach}
                            </select>
                        </td>
                        <td >
                            <input type="button" value="{$lang.Add}" style="font-weight:bold" onclick="return addadd()"/>
                            <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#addnew_addons').hide();$('#addnew_addon_btn').show();return false;" class="editbtn">{$lang.Cancel}</a>
                        </td>
                    </tr>

                </table>
            </div>
        {/if}
    {else}

        <div class="blank_state_smaller blank_forms">
            <div class="blank_info">
                <h3>{$lang.noaddonsyet}</h3>
                <div class="clear"></div>
            </div>
        </div>
    {/if}
    {literal}
        <script type="text/javascript">
            $('#addonsditor_content .havecontrols').hover(function(){
                $(this).find('.controls').show();
            },function(){
                $(this).find('.controls').hide();
            });
        </script>
    {/literal}

{elseif ($action=='category' || $action=='editcategory') && $category}
    <div class="nicerblu">
        <div id="cinfo0" {if $action=='editcategory'}style="display:none"{/if}>
            <table border="0" cellpadding="0" cellspacing="0" width="100%" >
                <tr >
                    <td>
                        <table border="0" cellpadding="6" cellspacing="0" width="100%" >
                            <tr >
                                <td class="havecontrols">
                                    <span class="left">
                                        <strong style="font-size:16px">
                                            {$category.name}
                                        </strong>
                                        {if $lang[$category.otype]} {$lang[$category.otype]}
                                        {elseif $category.template=='custom'} {$lang.typespecificcheckout}
                                        {/if}
                                    </span>
                                    <span class="controls">
                                        <a href="#" class="editbtn" onclick="return editcat();">{$lang.Edit}</a>
                                    </span>
                                </td>
                            </tr>
                            {if $category.description!=''}
                                <tr >
                                    <td class="havecontrols"><span class="left">{$category.description|strip_tags}</span><span class="controls"><a href="#" class="editbtn" onclick="return editcat();">{$lang.Edit}</a></span></td>
                                </tr>
                            {/if}
                        </table>
                    </td>
                    <td valign="top" width="30%" style="padding:10px" class="fs11">
                        {*
                        {assign var="descr" value="_descr"}
                        {assign var="bescr" value=$category.otype}
                        {assign var="baz" value="$bescr$descr"}
                        <!-- {$lang[$baz]} -->*}
                    </td>
                    <td valign="top" width="20%" style="padding-left:10px">

                    </td>
                </tr>
            </table>

        </div>

        <div id="cinfo1" {if $action!='editcategory'}style="display:none"{/if}>
            <form action="" name="" method="post" enctype="multipart/form-data">
                <input type="hidden" name="make" value="editcategory"/>
                <input type="hidden" name="cat_id" value="{$category.id}"/>

                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tbody>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Name}:</strong></td>
                            <td width="400">
                                {hbinput value=$category.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name" id="categoryname"}
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tbody id="hints">
                        <tr >
                            <td width="160" align="right" class="fs11">Order page url: </td>
                            <td class="fs11" colspan="2"><a href="{$system_url}{$ca_url}cart/{$category.slug}/" target="_blank">{$system_url}{$ca_url}cart/<span class="changemeurl">{$category.slug}</span></a><input  name="slug" type="text" class="" value="{$category.slug}" id="category_slug_edit" style="display:none" />/ <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a></td>
                        </tr>
                    </tbody>
                    <tbody id="template_descriptions">
                        {include file="ajax.services.tpl" action='newpageextra'}
                    </tbody>
                    <tbody>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Description}:</strong></td>
                            <td colspan="2">
                                {if $category.description!=''}
                                    {hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description"  featureset="simple"}
                                {else}
                                    <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                    <div id="prod_desc_c" style="display:none">{hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="simple"}</div>
                                {/if}
                            </td>
                        </tr>
                        <tr>
                            <td width="160" align="right"><strong>{$lang.Advanced}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$('#advanced_scenarios').show();$(this).hide();return false;">{$lang.show_advanced}</a>
                                <div id="advanced_scenarios" style="display:none">
                                    <strong>{$lang.order_scenario}:</strong> <a class="editbtn" href="?cmd=configuration&action=orderscenarios" target="_blank">[?]</a>
                                    <select name="scenario" class="inp">
                                        {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}" {if $category.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </tbody>

                    
                </table>
                
                <p align="center">
                    <input type="submit" value="{$lang.savechanges}" class="submitme" />
                    <span class="orspace">{$lang.Or}</span> <a href="?cmd=services"  class="editbtn" onclick="$('#cinfo1').toggle();$('#cinfo0').toggle();return false;">{$lang.Cancel}</a>
                </p>
                {securitytoken}
            </form>
        </div>
    </div>
    {literal}
        <script type="text/javascript">

        function sl(el) {
            ajax_update('?cmd=services&action=newpageextra',{ptype:$(el).val(),selected:$('#wiz_options input:checked').val()},function(data){$('#template_descriptions').html(data);if($('#template_descriptions input:checked').length==0){$('#template_descriptions input:first').click()}});
            return false;
        }
        function editcat() {
            $('#cinfo1').toggle();
            $('#cinfo0').toggle();
            return false;
        }
        $(document).ready(function(){
            $('#categoryname').bind('keyup keydown change',function(){
                if($(this).val()!='') {
                    $('#hints').slideDown('fast');
                    var w=$(this).val().replace(/[^a-zA-Z0-9-_\s]+/g,'-').replace(/[\s]+/g,'-').toLowerCase();
                    if(!$('#category_slug_edit').is(':visible')) {
                        $('#category_slug_edit').val(w);
                    }
                    $('#hints .changemeurl').html(w);
                } else {
                    $('#hints').slideUp('fast');
                }
            });
        });
        </script>
    {/literal}
    <div class="blu">
        <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td ><a href="?cmd=services"  class="tload2"><strong>{$lang.orpages}</strong></a> &raquo; <strong>{$category.name}</strong></td>

                <td align="right"><a href="?cmd=services&action=editcategory&id={$category.id}" class="editbtn" onclick="return editcat();">{$lang.editthisorpage}</a></td>
            </tr>
        </table>
    </div>
    {if $products}
        <form id="serializeit">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th >{$lang.Name}</th>

                        <th width="130">{$lang.Accounts}</th>
                        <th width="30"></th>
                        <th width="100">&nbsp;</th>
                    </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {foreach from=$products item=prod name=prods}
                    <li {if $prod.visible=='0'}class="hidden"{/if}  ><div ><table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                <tr  class="havecontrols">
                                    <td width="20"><input type="hidden" name="sort[]" value="{$prod.id}" />
                                        <div class="controls">
                                            <a class="sorter-handle" >{$lang.move}</a>
                                        </div>
                                    </td>
                                    <td ><a href="?cmd=services&action=product&id={$prod.id}">{if $prod.visible=='0'}<em class="hidden">{/if}{$prod.name}{if $prod.visible=='0'}</em>{/if}</a> {if $prod.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}</td>
                                    <td width="130" align="center">{if $prod.accounts}<a  href="?cmd=accounts&filter[product_id]={$prod.id}" target="_blank">{$prod.accounts}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                    <td width="30">{if $prod.stock=='1'}{$lang.qty} {$prod.qty}{/if}</td>
                                    <td width="20"><a href="?cmd=services&action=product&id={$prod.id}" class="editbtn">{$lang.Edit}</a></td>
                                    <td width="30"><a class="editbtn editgray" href="?cmd=services&amp;make=duplicate&id={$prod.id}&security_token={$security_token}">{$lang.Duplicate}</a></td>
                                    <td width="20"><a href="?cmd=services&make=deleteproduct&id={$prod.id}&cat_id={$category.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteproductconfirm}');" class="delbtn">{$lang.Delete}</a> </td>
                                </tr>
                            </table>
                        </div>
                    </li>
                {/foreach}
            </ul>
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                <tbody>
                    <tr>
                        <th width="30"></th>
                        <th width="100"><a class="editbtn" href="?cmd=services&action=product&id=new&cat_id={$category.id}">{$lang.addnewproduct}</a></th>
                        <th ><a class="editbtn" href="?cmd=services&action=updateprices&cat_id={$category.id}">批量价格更新</a></th>
                    </tr>
                </tbody>
            </table>
            {securitytoken}
        </form>

        <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
        {literal}
            <script type="text/javascript">
                $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });

                function saveOrder() {
                var sorts = $('#serializeit').serialize();
                ajax_update('?cmd=services&action=listprods&'+sorts,{});
                };
            </script>
        {/literal}
    {else}
        <div class="blank_state blank_services">
            <div class="blank_info">
                <h1>{$lang.orpage_blank2}</h1>

                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td><a class="new_add new_menu" href="?cmd=services&action=product&id=new&cat_id={$category.id}"  style="margin-top:5px"><span>{$lang.addnewproduct}</span></a>
                        </td>
                        <td></td>
                    </tr>
                </table>

                <div class="clear"></div>

            </div>
        </div>

    {/if}

{elseif $action=='product' }

    <form action="" method="post" name="productedit" id="productedit" onsubmit="selectalladdons()" enctype="multipart/form-data">
        <input type="hidden" name="make" value="editproduct"/>
        <input type="hidden" name="id" value="{$product.id}"/>
        <div class="blu"> <a href="?cmd=services"  class="tload2"><strong>{$lang.orpages}</strong></a> &raquo; <a href="?cmd=services&action=category&id={$product.category_id}"  class="tload2"><strong>{foreach from=$categories item=c}{if $c.id==$product.category_id}{$c.name}{/if}{/foreach}</strong></a> &raquo; <strong>{if !$product.name}{$lang.addnewproduct}{else}{$product.name}{/if}</strong>

        </div>
        <div>
            {if $maintpl}
                {include file=$maintpl}
            {else}
                {include file='newservices.tpl'}
            {/if}
        </div>
        {literal}
            <script type="text/javascript">
                var zero_value = '{/literal}{0|price:$currency:false:false}{literal}';
                 function bindMe() {
             $('#newsetup1').click(function () {
                 $(this).hide();
                 $('#newsetup').show();
                 return false;
             });
             $('#Regular_b .controls .editbtn').click(function () {
                 var e = $(this).parent().parent().parent();
                 e.find('.e1').hide();
                 e.find('.e2').show();
                 return false;
             });
             $('#Regular_b .controls .delbtn').click(function () {
                 var e = $(this).parent().parent().parent();
                 e.find('.e2').hide();
                 e.find('.e1').show();
                 e.find('input').val(zero_value);
                 e.hide();
                 var id = e.attr('id').substr(0, 1);
                 if ($('#tbpricing select option:visible').length < 1) {
                     $('#addpricing').show();
                 }
                 $('#tbpricing select option[value=' + id + ']').show();

                 return false;
             });
             $('#newshelfnav').TabbedMenu({
                 elem: '.sectioncontent',
                 picker: '.list-1 li',
                 aclass: 'active' {/literal}{if $picked_tab},picked:{$picked_tab}{/if} {literal}
             });
             $('#newshelfnav').TabbedMenu({
                 elem: '.subm1',
                 picker: '.list-1 li' {/literal}{if $picked_tab},picked:{$picked_tab}{/if} {literal}
             });
             $('#components_menu').TabbedMenu({
                 elem: '.components_content',
                 picker_id: "picked_subtab",
                 picker: '.list-3 li' {/literal}{if $picked_subtab},picked:{$picked_subtab}{/if} {literal}
             });
             if (typeof latebindme == 'function') {
                 latebindme();
             }
             $(document).on('click','#module_tab_switcher .module_tab_pick',function(){
                var index= $('#module_tab_switcher .module_tab_pick').removeClass('picked').index(this);
                 $(this).addClass('picked');
                 $('#module_config_container .module_config_tab').hide().eq(index).show();
                 return false;
             });
         }
         appendLoader('bindMe');

         function connectMoreApps(el) {
             var a='<a class="module_tab_pick" href="">Additional App</a>';
             var current=[];
             $('.modulepicker').each(function(n){
                 current[n]=$(this).val();
             });
             $('#module_tab_switcher').show();
             //ajax request for table
             var length = $('#module_tab_pick_container .module_tab_pick').length;
             $.get('?cmd=services&action=loadextramodule',{k:length,c:current},function(data){
                $('#module_config_container').append(data);
                $('#module_tab_pick_container').append(a).find('.module_tab_pick:last').click();
             });
             return false;
         }
         function addopt() {
             var e = $('#' + $('#tbpricing select').val() + 'pricing');
             e.find('.inp').eq(0).val($('#newprice').val());
             e.find('.inp').eq(1).val($('#newsetup').val());
             e.find('.pricer_setup').html($('#newsetup').val());
             if ($('#newsetup').val() != zero_value) e.find('.pricer_setup').parent().parent().show();
             e.find('.pricer').html($('#newprice').val());
             e.show();
             $('#tbpricing select option:selected').hide();
             if ($('#tbpricing select option:visible').length < 1) {

             } else {
                 $('#tbpricing select option:visible').eq(0).attr('selected', 'selected');
                 $('#addpricing').show();
             }
             $('#tbpricing').hide();
             $('#newprice').val(zero_value);
             $('#newsetup').val(zero_value).hide();
             $('#newsetup1').show();
             return false;
         }

         function toggle_free1(el) {
             if ($(el).is(':checked')) {
                 $('#freedomopt1').show().find('input').removeAttr('checked');
                 $('#notldsyet').show();
             } else {
                 $('#freedomopt').hide();
                 $('#freedomopt1').hide();
                 $('#notldsyet').hide();
             }
         }

         function toggle_free2(el) {
             $('#freedomopt').toggle();
         }

         function selectalladdons() {
             if ($('#listAlreadyU').length) for (var i = 0; i < $('#listAlreadyU')[0].options.length; i++) {
                 $('#listAlreadyU')[0].options[i].selected = true;
             }


         }

         function addItem(it) {
             var av = it == 'addon' ? '#listAvail' : '#listAvailU';
             var al = it == 'addon' ? '#listAlready' : '#listAlreadyU';
             var selIndex = $(av)[0].selectedIndex;
             if (selIndex < 0) return;
             for (var i = $(av)[0].options.length - 1; i >= 0; i--) {
                 if ($(av)[0].options[i].selected) {
                     $(al)[0].appendChild($(av)[0].options[i]);
                 }
             }

             $(av)[0].selectedIndex = -1;
             $(al)[0].selectedIndex = -1;

         }

         function delItem(it) {
             var av = it == 'addon' ? '#listAvail' : '#listAvailU';
             var al = it == 'addon' ? '#listAlready' : '#listAlreadyU';

             var selIndex = $(al)[0].selectedIndex;
             if (selIndex < 0) return;
             for (var i = $(al)[0].options.length - 1; i >= 0; i--) {
                 if ($(al)[0].options[i].selected) {
                     $(av)[0].appendChild($(al)[0].options[i]);
                 }
             }

             $(av)[0].selectedIndex = -1;
             $(al)[0].selectedIndex = -1;
         }



         function sh(element, showhide) {
             if ($(element).val() != 'text' && $(element).val() != 'checkbox') {
                 $('#' + showhide).show();
             } else {
                 $('#' + showhide).hide();
             }
         }

         function removeadd(which) {
             ajax_update('?cmd=services&action=addonseditor', {
                 addon_id: which,
                 product_id: $('#product_id').val(),
                 module: $('#modulepicker').val(),
                 make: 'removeconf'
             }, '#addonsditor_content');
             return false;
         }
         function addadd() {

             var data = $('#addnew_addons select').serialize();
             ajax_update('?cmd=services&action=addonseditor&' + data, {
                 product_id: $('#product_id').val(),
                 module: $('#modulepicker').val(),
                 make: 'addconfig'
             }, '#addonsditor_content');
             return false;
         }


         function saveProductFull() {
             $('#productedit').submit();
             return false;
         }

         function check_i(element) {
             var td = $(element).parent();
             if ($(element).is(':checked')) $(td).find('.config_val').removeAttr('disabled');
             else $(td).find('.config_val').attr('disabled', 'disabled');
         }

         function add_message(gr, id, msg) {
             var sel = $('#' + gr + '_msg select');
             sel.find('option:selected').removeAttr('selected');
             sel.prepend('<option value="' + id + '">' + msg + '</option>').find('option').eq(0).attr('selected', 'selected');
             return false;

         }

         function check_scat(el, id) {
             if ($(el).is(':checked')) {
                 $(el).parent().parent().find('.cc_' + id).attr('checked', 'checked');
             } else {
                 $(el).parent().parent().find('.cc_' + id).removeAttr('checked');
             }

         }

         function uncheck_scat(el, id) {
             if ($(el).is(':checked')) {} else {
                 $(el).parent().parent().find('.ccc_' + id).removeAttr('checked');
             }
         }

         function closeCpicker(el) {
             $(el).parent().hide().prev().show();
             var paren=$(el).parents('.serv_picker').eq(0);
             var pick = paren.find('.ui-ddown-default').html();
             if (paren.find('input.elcc:checked').length) {
                 pick = '';
                 paren.find('input.elcc:checked').each(function (e) {
                     pick = pick + $(this).parent().find('span').html() + ', ';
                 });
             }

             paren.find('.ui-ddown-default').html(pick);
             return false;

         }

         if(typeof(getFieldValues)!='function') {
                function getFieldValues(prod_id,el,addserver) {
                    var index = $('.module_tab_pick','#module_tab_pick_container').index($('.module_tab_pick.picked','#module_tab_pick_container'));
                    var fields = $('form#productedit').serialize();
                    var add='';
                    if(addserver===true) {
                        add='&saveserver=true';
                    } else {
                    add='&getvalues='+$('.module_config_tab:eq('+index+') input.elcc','#module_config_container').serialize();
                    }
                    ajax_update('index.php?cmd=services&action=showmodule&product_id='+prod_id
                        +''+add
                        +'&id='+$('.module_config_tab:eq('+index+') .modulepicker','#module_config_container').val()
                        +'&'+$('.module_config_tab:eq('+index+') input.elcc','#module_config_container').serialize(),
                        {fields: fields,k:index},'#module_config_container .module_config_tab:eq('+index+') .loadable');
                    $('.module_config_tab:eq('+index+') #getvaluesloader','#module_config_container').html('<center><img src="ajax-loading2.gif" /></center>');
                    return false;
                }
                }
          function addmultifield(elem, name) {
                    $(elem).parent().find('span').append('<input name="options['+name+'][]" value="" /><br />');
                }
         function loadMod(el) {
             var v = $(el).val();
             if (v == 'new') {
                 $(el).val(0);
                 window.location = '?cmd=managemodules&action=hosting&do=inactive';
                 return false;
             }
            var index = $('.modulepicker').index(el);
             var param = {
                 'server_values': {},
                 k:index
             };
             $('#prod_serverform input').each(function (i, e) {
                 if ($(this).attr('type') == 'checkbox') {
                     param['server_values'][$(this).attr('name')] = $(this).is(':checked') ? '1' : '0';
                 } else param['server_values'][$(this).attr('name')] = $(this).val();
                 $(this).attr('disabled', 'disabled');
             });
             $('#getvaluesloader','.loadable:eq('+index+')').html('<center><img src="ajax-loading.gif" /></center>');
             ajax_update('index.php?cmd=services&action=showmodule&product_id={/literal}{$product.id}{literal}&id=' + $(el).val(), param, '.loadable:eq('+index+')');
         }

         function switch_t2(el, id) {
             $('#priceoptions .billopt').removeClass('checked');
             $(el).addClass('checked');

             $('input[name=paytype]').removeAttr('checked').prop('checked', false);
             $('input#' + id).attr('checked', 'checked').prop('checked', true);
             if (id == 'recurx') $('input#recur').attr('checked', 'checked').prop('checked', true);

             $('.boption').hide();
             $('#recurx_b').hide();
             $('#' + id + '_b').show();
             $('#hidepricingadd').click();
             return false;
         }

         function saveOrder() {
             var sorts = $('div#serializeit input.ser').serialize();
             ajax_update('?cmd=configfields&action=changecatorder&' + sorts, {});
         };

            </script>
        {/literal}
        <script type="text/javascript" src="{$template_dir}js/gui.elements.js?v={$hb_version}"></script>
        <link rel="stylesheet" href="{$template_dir}js/gui.elements.css" type="text/css" />
        <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
        <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>

        <div class="blu"> <a href="?cmd=services"  class="tload2"><strong>{$lang.orpages}</strong></a> &raquo; <a href="?cmd=services&action=category&id={$product.category_id}"  class="tload2"><strong>{foreach from=$categories item=c}{if $c.id==$product.category_id}{$c.name}{/if}{/foreach}</strong></a> &raquo; <strong>{if !$product.name}{$lang.addnewproduct}{else}{$product.name}{/if}</strong>

        </div>
        {securitytoken}</form>

{elseif $action=='default' || $action=='addproduct' || $action=='addcategory'}

    <div  id="addcategory" style="{if $action!='addcategory'}display:none{/if}">
        <div class="blu"><strong>{$lang.addneworpage}</strong></div>

        <div class="nicerblu">
            <form action="" name="" method="post" enctype="multipart/form-data">
                <input type="hidden" name="make" value="addcategory"/>

                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                    <tbody>
                        <tr class="step0">
                            <td width="160" align="right"><strong>{$lang.Name}:</strong></td>
                            <td width="400">{hbinput value=$category.tag_name style="font-size: 16px !important; font-weight: bold;" class="inp" size="60" name="name" id="categoryname"}</td>
                            <td></td>
                        </tr>
                    </tbody>
                    <tbody id="hints" style="display:none">
                        <tr >
                            <td width="160" align="right" class="fs11">{$lang.orderpageurl} </td>
                            <td class="fs11" colspan="2">{$system_url}{$ca_url}cart/<span class="changemeurl">{$category.slug}</span><input  name="slug" type="text" class="" value="{$category.slug}" id="category_slug_edit" style="display:none" />/ <a class="editbtn" onclick="return editslug(this)" href="#">{$lang.Edit}</a></td>
                        </tr>
                    </tbody>
                    <tbody id="template_descriptions" class="step1">
                        <tr>
                            <td width="160" align="right" valign="top" style="padding-top:12px;">
                                <strong>{$lang.ordertype}</strong>
                            </td>
                            <td>
                                <div id="template_wizard">
                                    <select name="ptype"  class="inp template " onchange="sl(this)"  style="font-weight:bold;font-size:14px !important;" id="ptypechange">
                                        <option value="0" selected="selected">{$lang.selectone}</option>
                                        {foreach from=$ptypes item=ptype name=lop}
                                            <option value="{$ptype.id}">
                                                {assign var="descr" value="_hosting"}{assign var="bescr" value=$ptype.lptype}{assign var="baz" value="$bescr$descr"}
                                                {if $lang.$baz}{$lang.$baz}
                                                {else}{$ptype.type}
                                                {/if}
                                            </option>
                                        {/foreach}
                                    </select> {if $countinactive}<div class="fs11 tabb" >注意: 这是 <b>{$countinactive}</b> 非活动状态类型的订单, 您可以通过激活相关的 <a href="?cmd=managemodules&action=hosting" target="_blank">主机模块</a> 启用它们</div>{/if}
                                </div>
                                <div id="wiz_options"></div>
                            </td>
                            <td valign="top"></td>
                        </tr>
                    </tbody>
                    <tbody>
                        <tr class="step1">
                            <td width="160" align="right"><strong>{$lang.Description}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                <div id="prod_desc_c" style="display:none">{hbwysiwyg wrapper="div" value=$category.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="simple"}</div>
                            </td>
                        </tr>
                         <tr class="step1">
                            <td width="160" align="right"><strong>{$lang.Advanced}:</strong></td>
                            <td colspan="2">
                                <a href="#" onclick="$('#advanced_scenarios').show();$(this).hide();return false;">{$lang.show_advanced}</a>
                                <div id="advanced_scenarios" style="display:none">
                                    <strong>{$lang.order_scenario}:</strong> <a class="editbtn" href="?cmd=configuration&action=orderscenarios" target="_blank">[?]</a>
                                    <select name="scenario" class="inp">
                                        {foreach from=$scenarios item=scenario name=scloop}
                                            <option value="{$scenario.id}" {if $category.scenario_id==$scenario.id}selected="selected"{/if}>{$scenario.name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                    
                </table>

                <p align="center">
                    <input type="submit" value="{$lang.addneworpage}" class="submitme" disabled="disabled" id="submitbtn"/>
                    <span class="orspace">{$lang.Or}</span> <a href="?cmd=services"  class="editbtn">{$lang.Cancel}</a>

                </p>

                {securitytoken}
            </form>
            {literal}
                <script type="text/javascript">
                function prswitch(id,el) {
                    $('#subwiz_opt span').removeClass('active');
                    $(el).parent().addClass('active');
                    $('.pr_desc').hide();
                    $('#pr_desc'+id).show();
                }
                function sl(el) {
                    ajax_update('?cmd=services&action=newpageextra',{
                        ptype:$(el).val(),
                        selected:$('#wiz_options input:checked').val(),
                        addcategory:true},
                    function(data){
                        $('#template_descriptions').html(data);
                        if($('#template_descriptions input:checked').length==0){
                            $('#template_descriptions input:first').click()}});
                    $('#submitbtn').removeAttr('disabled');
                    return false;
                }
                $(document).ready(function(){
                    $('.step1').css('opacity',0.2);

                    $('#categoryname').bind('keyup keydown change',function(){
                        if($(this).val()!='') {
                        if($('select[name=ptype]').val()!='0')
                            $('#submitbtn').removeAttr('disabled');
                            $('.step1').css('opacity',1);
                            $('#hints').slideDown('fast');
                            var w=$(this).val().replace(/[^a-zA-Z0-9-_\s]+/g,'-').replace(/[\s]+/g,'-').toLowerCase();
                            if(!$('#category_slug_edit').is(':visible')) {
                                $('#category_slug_edit').val(w);
                            }
                            $('#hints .changemeurl').html(w);
                        } else {
                            $('.step1').css('opacity',0.2);
                                                        $('#hints').slideUp('fast');
                            $('#submitbtn').attr('disabled','disabled');
                        }
                    });

                });
                </script>
            {/literal}
        </div>
    </div>
    <div id="listproducts" {if $action!='default'}style="display:none"{/if}>
        {if $categories}
            <div class="blu"><strong>{$lang.orpages}</strong></div>

            <form id="serializeit" method="post">

                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                    <tbody>
                        <tr>
                            <th width="20"></th>
                            <th width="20%">{$lang.Name}</th>
                            <th width="120" >{$lang.numofprod}</th>
                            <th >{$lang.ordertype}</th>
                            <th width="100">&nbsp;</th>
                        </tr>
                    </tbody>
                </table>
                <ul id="grab-sorter" style="width:100%">
                    {foreach from=$categories item=i name=cat}
                        <li {if $i.visible=='0'}class="hidden"{/if}  >
                            <div >
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                    <tr  class="havecontrols">
                                        <td width="20">
                                            <input type="hidden" name="sort[]" value="{$i.id}" /><div class="controls"><a class="sorter-handle" >{$lang.move}</a></div>
                                        </td>
                                        <td width="20%"><a href="?cmd=services&action=category&id={$i.id}" class="direct">{if $i.visible=='0'}<em class="hidden">{/if}{$i.name}{if $i.visible=='0'}</em>{/if}</a> {if $i.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}</td>
                                        <td width="120"><a href="?cmd=services&action=category&id={$i.id}" class="direct">{$i.products}</a></td>
                                        <td >{*{assign var="descr" value="_hosting"}{assign var="bescr" value=$i.lptype}{assign var="baz" value="$bescr$descr"}
                                            {if $lang.$baz}
                                            {$lang.$baz}
                                            {else}
                                            {$i.ptype}
                                            {/if}*}
                                            {if $lang[$i.otype]} {$lang[$i.otype]}
                                            {elseif $i.template=='custom'}{$lang.typespecificcheckout}
                                            {else}{$i.otype}
                                            {/if}
                                        </td>
                                        <td width="20"><a href="?cmd=services&action=editcategory&id={$i.id}" class="editbtn">{$lang.Edit}</a></td>
                                        <td width="33">{if $i.visible=='0'}<a href="?cmd=services&make=showcat&id={$i.id}&security_token={$security_token}" class="editbtn editgray">{$lang.Show}</a>{else}<a href="?cmd=services&make=hidecat&id={$i.id}&security_token={$security_token}" class="editbtn editgray">{$lang.Hide}</a>{/if}</td>
                                        <td width="20"><a href="?cmd=services&make=deletecat&id={$i.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletecategoryconfirm}');" class="delbtn">{$lang.Delete}</a> </td>
                                    </tr>
                                </table>
                            </div>
                        </li>
                    {/foreach}
                </ul>
                <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                    <tbody>
                        <tr>
                            <th width="20"></th>
                            <th ><a class="editbtn" href="?cmd=services&action=addcategory">{$lang.addneworpage}</a></th>

                        </tr>
                    </tbody>
                </table>
                <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
                {literal}
                    <script type="text/javascript">
                        $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });

                        function saveOrder() {
                        var sorts = $('#serializeit').serialize();
                        ajax_update('?cmd=services&action=listcats&'+sorts,{});
                        };
                    </script>
                {/literal}
                {securitytoken}
            </form>
        {else}
            <div class="blank_state blank_services">
                <div class="blank_info">
                    <h1>{$lang.orpage_blank1}</h1>
                    <div class="clear">{$lang.orpage_blank1_desc}</div>

                    <a class="new_add new_menu" href="?cmd=services&action=addcategory"  style="margin-top:10px">
                        <span>{$lang.addneworpage}</span></a>
                    <div class="clear"></div>

                </div>
            </div>
        {/if}
    </div>
 {elseif $action=='updateprices'}
     <div class="blu">
         <table border="0" cellpadding="0" cellspacing="0" width="100%">
             <tr>
                 <td ><a href="?cmd=services"  class="tload2"><strong>{$lang.orpages}</strong></a> &raquo; <strong>{$category.name}</strong></td>
             </tr>
         </table>
     </div>
     <div id="newshelfnav" class="newhorizontalnav">
        <div class="list-1">
            <ul>
                <li class="active picked">
                    <a href="#"><span class="ico money">提高/降低价格</span></a>
                </li>
                <li class="last">
                    <a href="#"><span class="ico plug">设置新价格</span></a>
                </li>
            </ul>
        </div>
         <div class="list-2"><div class="haveitems" style="height: 0px;"></div></div>
    </div>
    <div class="nicerblu"  style="height: 10px;"></div>
    <form id="serializeit" action="" method="post">
        <input type="hidden" name="make" value="bulk" />
        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
            <tbody>
                <tr>
                    <th width="20"><input type="checkbox" id="product_check"/></th>
                    <th >{$lang.Name}</th>    
                    <th width="130">{$lang.Accounts}</th>
                    <th width="30"></th>
                    <th width="100">&nbsp;</th>
                </tr>
            </tbody>
        </table>
        <ul id="grab-sorter" style="width:100%">
            {foreach from=$products item=prod name=prods}
                <li {if $prod.visible=='0'}class="hidden"{/if}  >
                    <div >
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                            <tr class="havecontrols">
                                <td width="20">
                                    <input type="checkbox" name="product[{$prod.id}]" value="{$prod.id}" class="product_check"/>
                                </td>
                                <td ><a href="?cmd=services&action=product&id={$prod.id}">{if $prod.visible=='0'}<em class="hidden">{/if}{$prod.name}{if $prod.visible=='0'}</em>{/if}</a> {if $prod.visible=='0'}<em class="hidden fs11">{$lang.hidden}</em>{/if}</td>
                                <td width="130" align="center">{if $prod.accounts}<a  href="?cmd=accounts&filter[product_id]={$prod.id}" target="_blank">{$prod.accounts}</a>{elseif $prod.domains}<a  href="?cmd=domains&filter[tld_id]={$prod.id}" target="_blank">{$prod.domains}</a>{else}0{/if}</td>
                                <td width="30">{if $prod.stock=='1'}{$lang.qty} {$prod.qty}{/if}</td>
                                <td width="20"><a href="?cmd=services&action=product&id={$prod.id}" class="editbtn">{$lang.Edit}</a></td>
                            </tr>
                        </table>
                    </div>
                </li>
            {/foreach}
        </ul>
            
        <div class="nicerblu">
            <table width="100%" cellspacing="0" cellpadding="6">
                <tbody class="section">
                    <tr>
                        <td width="60" align="right"><strong>类型</strong></td>
                        <td>
                            <select class="inp" name="multip">
                                <option value="1">涨价</option>
                                <option value="-1">降价</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>金额</strong></td>
                        <td>
                            <input class="inp" type="text" size="5" name="amount"/> 
                            <select class="inp" name="type">
                                <option value="1">整数</option>
                                <option value="2">百分比</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">分配给:</td>
                        <td>
                            {if in_array('DomainRegular', $supported_billingmodels) }
                                <label><input type="checkbox" name="include[]" checked="checked" value="register"/> 注册人</label>
                                <label><input type="checkbox" name="include[]" checked="checked" value="transfer"/> 转入</label>
                                <label><input type="checkbox" name="include[]" checked="checked" value="renew"/> 续费</label>
                            {else}
                                <label><input type="checkbox" name="include[]" checked="checked" value="recurring"/> 周期</label>
                                <label><input type="checkbox" name="include[]" checked="checked" value="setup"/> 设置</label>
                            {/if}
                        </td>
                    </tr>
                </tbody>
                <tbody class="section">
                <td valign="top" width="60" align="right"><strong>{$lang.Price}</strong></td>
                <td id="priceoptions">
                    {foreach from=$supported_billingmodels item=bm name=boptloop}
                        {if $bm == 'Metered'}{continue}{/if}
                        <a href="#" class="billopt {if $smarty.foreach.boptloop.first && $bm == 'Free'}bfirst{/if}"  onclick='return switch_t2(this,"{$bm}");' id="bma_{$bm}">
                            {if $lang[$bm]}{$lang[$bm]}
                            {elseif $bm == "DomainRegular"}{$lang.Regular}
                            {else}{$bm}
                            {/if}
                        </a>
                        <input type="radio" value="{$bm}" name="paytype" {if $product.paytype==$bm}checked="checked"{/if}  id="{$bm}" style="display:none"/>
                    {/foreach}
                    <div id="bmcontainer">
                    {foreach from=$supported_billingmodels item=bm name=boptloop}
                        {if $bm == 'Metered'}{continue}{/if}
                        {include file="productbilling_`$bm`.tpl" product=$billing_product[$bm]}
                    {/foreach}
                    </div>
                </td>
                </tbody>
                <tbody>
                    <tr>
                        <td align="right"></td>
                        <td>
                            <input type="checkbox" name="accountupdate" value="1"/> 
                            更新相关域名/账户的重复价格
                        </td>
                    </tr>
                </tbody>
            </table>
             <div style="padding: 6px;">
                 <a class="new_dsave new_menu" href="#" onclick="return updatePrices();"  >
                     <span>更新价格</span>
                 </a>
                 <div class="clear"></div>
             </div>
        </div>
       
        {securitytoken}
        {literal}
            <script type="text/javascript">
                {/literal}
                lang['Register']='{$lang.Register}';
                lang['Transfer']='{$lang.Transfer}';
                lang['Renew']='{$lang.Renew}';
                lang['Years']='{$lang.Years}';
                var zero_value = '{0|price:$currency:false:false}';
                {literal}

                function switch_t2(el,id) {
                    $('#priceoptions .billopt').removeClass('checked');
                    $(el).addClass('checked');

                    $('input[name=paytype]').removeAttr('checked').prop('checked', false);
                    $('input#'+id).attr('checked','checked').prop('checked', true);
                    $('#bmcontainer').children().hide();
                    $('#'+id+'_b').show();
                    $('#hidepricingadd').click();
                    return false;
                }
                function addopt() {
                    var e=$('#'+$('#tbpricing select').val()+'pricing');
                    e.find('.inp').eq(0).val($('#newprice').val());
                    e.find('.inp').eq(1).val($('#newsetup').val());
                    e.find('.pricer_setup').html($('#newsetup').val());
                    if($('#newsetup').val()!=zero_value)
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
                    $('#newprice').val(zero_value);
                    $('#newsetup').val(zero_value).hide();
                    $('#newsetup1').show();
                    return false;
                }
                function updatePrices(){
                    if($('.product_check:checked').length == 0){
                        alert('You have to select some products to update');
                        return false;
                    }
                    $('#serializeit').append('<input type="hidden" name="action_type" value="'+ ( $('.list-1 li.active').index() == 0 ? 'update': 'new' ) +'" />').submit();
                    return false;
                }
                $('#Regular_b .controls .editbtn').click(function () {
                    var e = $(this).parent().parent().parent();
                    e.find('.e1').hide();
                    e.find('.e2').show();
                    return false;
                });
                $('#Regular_b .controls .delbtn').click(function () {
                    var e = $(this).parent().parent().parent();
                    e.find('.e2').hide();
                    e.find('.e1').show();
                    e.find('input').val(zero_value);
                    e.hide();
                    var id = e.attr('id').substr(0, 1);
                    if ($('#tbpricing select option:visible').length < 1) {
                        $('#addpricing').show();
                    }
                    $('#tbpricing select option[value=' + id + ']').show();
                    return false;
                }); 
                $('#product_check').click(function(){
                    if(this.checked){
                        $('.product_check').attr('checked', 'checked').prop('checked', true);
                    }else
                        $('.product_check').removeAttr('checked').prop('checked', false);
                });
                $('.product_check').click(function(){
                    if($('.product_check:not(:checked)').length == 0){
                        $('#product_check').attr('checked', 'checked').prop('checked', true);
                    }else
                        $('#product_check').removeAttr('checked').prop('checked', false);
                });
                $('#newshelfnav').TabbedMenu({
                    elem: '.section',
                    picker: '.list-1 li',
                    aclass: 'active'
                }); 
                if($('#bma_Regular').length)
                    $('#bma_Regular').click();
                else $('#priceoptions a:first').click();
                    
                $('#addpricingrow td:last-child:not(:first-child)').remove();
            </script>
        {/literal}
    </form>  
{/if}

{if $action=='default' || $action=='addcategory' || $action=='editcategory' || $action=='category'}
    <script type="text/javascript" src="{$template_dir}js/tinymce/tiny_mce.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/tinymce/jquery.tinymce.js?v={$hb_version}"></script>
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js?v={$hb_version}"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
    {literal}
        <script type="text/javascript">
        function get_descr(el) {
            $('#wiz_options li').removeClass('activated');
            $(el).prop('checked', true).parent().addClass('activated');
            $('.gallery .gal_slide').hide();
            $('#o' + $(el).attr('id')).show();

        }

        function editslug(el) {
            $(el).hide();
            $('#category_slug_edit').show();
            $('.changemeurl').hide();
            return false;

        }

        var HBServices = {
            customize: function () {
                var op = $('input[name=otype]:checked').val();
                if (!op) return false;
                var cid = $('input[name=cat_id]').val();
                if (!cid) {
                    alert('Please add your orderpage first');
                    return false;
                }

                $.facebox({
                    ajax: "?cmd=services&action=opconfig&tpl=" + op + "&id=" + cid,
                    width: 600,
                    nofooter: true,
                    opacity: 0.8,
                    addclass: 'modernfacebox'
                });
                return false;
            }
        };
        </script>
    {/literal}
{/if}
