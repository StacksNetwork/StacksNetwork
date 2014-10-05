 {assign var="default" value=$module.default}

<tr class="multimodule-{$kl}">
    <td align="right" valign="top" style="padding-top:15px;"><strong>{$lang.Server}</strong></td>
    <td><div style="width: 70%;">
            {if $additionalservers.$kl }
            <div>
                 <table border="0" cellpadding="2" cellspacing="0" >
                    <tr>
                        <td> <div class="ui-ddown serv_picker" id="serv_picker"  >
                                <div class="ui-ddown-default" onclick="$(this).hide();$(this).parent().find('.ui-ddown-list').show();">
                                    {if ($module.server && $module.server!='' && $module.server!=0) || $newserverid}

                                    {foreach from=$additionalservers.$kl item=gserver}{foreach from=$gserver.servers item=server}{if $module.server[$server.id] || $newserverid==$server.group_id}{$server.name}, {/if}{/foreach}{/foreach}
                                    {else}{$lang.pickservers}{/if}
                                </div>
                                <div class="ui-ddown-list">
                                    <ul class="left">
                                        {foreach from=$additionalservers.$kl item=gserver key=gname}


                                        {if $gserver.qty>1}
                                        <li><input type="checkbox" class="ccc_{$gserver.id}" onclick="check_scat(this,{$gserver.id});" id="gro-{$gserver.id}" /> <label for="gro-{$gserver.id}">{$gname} ({$gserver.qty} {$lang.Servers})</label></li>
                                        {foreach from=$gserver.servers item=server}
                                        <li class="nested"><input type="checkbox" class="elcc cc_{$server.group_id}" onclick="uncheck_scat(this,{$server.group_id})" name="modules[{$kl}][server][{$server.id}]" id="gs-{$server.id}" {if $module.server[$server.id]}checked='checked'{/if} value="{$server.id}"/> <label for="gs-{$server.id}" ><span>{$server.name}</span> ({$server.accounts}/{$server.max_accounts} {$lang.Accounts})</label></li>

                                        {/foreach}

                                        {else}
                                        <li><input type="checkbox"  class="elcc" value="{$gserver.servers[0].id}" name="modules[{$kl}][server][{$gserver.servers[0].id}]" id="gs-{$gserver.servers[0].id}" {foreach from=$gserver.servers item=server}{if $module.server[$server.id] || $newserverid==$gserver.id}checked='checked'{/if}{/foreach}/> <label for="gs-{$gserver.servers[0].id}">{$gname}: <span>{$gserver.servers[0].name}</span></label></li>
                                        {/if}
                                        {/foreach}



                                    </ul>
                                    <a href="#" onclick="return closeCpicker(this);" class="editbtn right" id="cpickclose">{$lang.Close}</a>
                                </div>
                            </div></td>
                        <td>
                            <a href="#" class="new_control" onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$module.product_id}{/if}',this)" ><span class="{if $loadable}dwd{else}wizard{/if}" ><strong>{if $loadable}{$lang.getvalsfromserver}{else}Test Connection{/if}</strong></span></a>
                        </td>

                        <td> <a href="" class="new_control" onclick="$('#use_added_servers').hide();$('#prod_serverform').show();$('input[name=addserver]').val('1'); return false;"><span class="addsth" >{$lang.addnewserver}</span></a></td>

                    </tr>
                </table>





            </div>
            {else}
            <b>You need to configure your App first in Settings->Apps</b>
            {/if}
           
        </div>
    </td></tr>
{if !$multicustomconfig.$kl}
<tr class="multimodule">
    <td></td>
    <td>
        <div style="padding: 5px;">
           
            {if $loadable || $test_connection}
            {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
                {if $test_connection_result.error}: {$test_connection_result.error}{/if}
            </span>
            {/if}
            {if $newserverid}
            <span style="margin-left: 10px; font-weight: bold; color: #009900;padding:5px" class="shownice">
                {$lang.newappadded}
            </span>
            {/if}
            {/if}
            <span id="getvaluesloader"></span>
        </div>
        <div class="clear"></div>
        <div class="left" id="subwiz_opt">

            {if $download_yml}
            <table border="0"  width="600" class="editor-container" cellpadding="5" cellspacing="0">
                <tr>
                    <td>
                        <div {if empty($default)}class="active"{/if}  style="padding:4px;">
                            <input type="radio" name="unchpremade" value="1" id="premadeuse1" {if empty($default)}checked="checked"{/if}  onclick="$('span.active').removeClass('active');$(this).parent().addClass('active');$('#configoptionstable').hide();$('#download_premade').show();"/>
                               <label for="premadeuse1">Use premade settings</label>
                        </div>
                    </td>
                </tr>
                <tr id="download_premade" {if !empty($default)}style="display:none"{/if}>
                    <td >
                        <div  class="shownice form" style="padding:10px;" >
                            <div >
                                <label>Step 1. <small>Paste <a target="_blank" href="{$download_yml}">config url</a></small></label>
                                <input type="text"  name="premadeurl" style="width:250px;margin:0px 0px 20px 10px;">
                                <div class="clear"></div>
                                <label>Step 2. <small>Submit and verify setup</small></label>
                                <div class="left" style="margin:2px 10px">
                                    <span class="bcontainer dhidden" style="">
                                        <a class="new_control greenbtn" href="#" onclick="return saveProductFull()"><span>Submit config</span></a>
                                    </span>
                                </div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    </td>
                </tr>
            </table>
            {/if}
            <table border="0"  width="600" class="editor-container" cellpadding="5" cellspacing="0">
                {if $download_yml}
                <tr>
                    <td colspan="2">
                        <div style="padding:4px;" {if !empty($default)}class="active"{/if}>
                             <input type="radio" name="unchpremade" value="1" id="premadeuse12" {if !empty($default)}checked="checked"{/if} onclick="$('span.active').removeClass('active');$(this).parent().addClass('active');$('#configoptionstable').show();$('#download_premade').hide();"/>
                               <label for="premadeuse12">Manual settings setup</label>
                        </div>
                    </td>
                </tr>
            </table>
            {/if}
            <table border="0"  width="600" class="editor-container" cellpadding="5" cellspacing="0" {if $download_yml && empty($default)}style="display:none"{/if} id="configoptionstable">
                   {if $loadtemplates || $featurepage }
                   <tr>
                    <td colspan="2">
                        <div style="margin:20px;">
                            {if $loadtemplates}
                            <a onclick="return loadOStoConfig({if $product_id}{$product_id}{else}{$module.product_id}{/if})" class="new_control" href="#" id="loadostemplates" {if !$product.ospick}style="display:none"{/if}>
                               <span class="dwd">Load OS templates into Form field</span>
                            </a>
                            {if $osconfig_id}
                            <script type="text/javascript">
                                editCustomFieldForm({$osconfig_id},{if $product_id}{$product_id}{else}{$module.product_id}{/if});
                                refreshConfigView({if $product_id}{$product_id}{else}{$module.product_id}{/if});
                            </script>
                            {/if}
                            <script type="text/javascript">{literal}
                                if(typeof(getFieldValues)!='loadOStoConfig') {
                                function loadOStoConfig(pid) {
                                    //basically get values from server with extra param - loadosconfig=true
                                    $('input[name=addserver]').after("<input type='hidden' name='loadosconfig' value='true'/>");
                                    return getFieldValues(pid);
                                    }
                               }
                                {/literal}
                            </script>
                            {/if}
                            {if $featurepage}
                            <a target="_blank"  class="new_control left" href="{$featurepage}" id="featurepagelink" style="margin-top:10px;display:block;clear:both">
                                <span class="question">{$featurepage}</span>
                            </a>
                            {/if}
                        </div>

                    </td>
                </tr>
                {/if}
                {foreach from=$module.options item=conf key=k name=checker}
                <tr {if $smarty.foreach.checker.iteration%2==0}class="odd"{/if} id="{$k}row">

                    {assign var="name" value=$conf.name}
                    {assign var="amodulename" value=$module.modulename}
                    {assign var="baz" value="$amodulename$name"}
                
                    <td align="right" width="190">
                        <strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong>{if $conf.description}<br/>
                        <small {if $conf.variable}id="config_{$conf.variable}_descr"{/if}>{$conf.description}</small>{/if}
                    </td>
                    <td {if $conf.variable}id="config_{$conf.variable}"{/if}>
                        {if $conf.type=='input'}
                        {if !$editor}
                        <div class="org-content ">
                            <span>{if $default.$k!==false}{$default.$k}{elseif $conf.default}{$conf.default}{/if} </span>
                            <a href="#" class="editbtn iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {/if}
                            <input name="modules[{$kl}][options][{$k}]" value="{if $default.$k!==false}{$default.$k}{elseif $conf.default}{$conf.default}{/if}" />
                        </div>
                        {if !$editor}
                        </div>
                        {/if}
                        {elseif $conf.type=='loadable'}
                        {if !$editor}
                        <div class="org-content ">
                            <span>
                                {if is_array($conf.default)}
                                {foreach from=$conf.default item=cs}
                                {if $cs|is_array && $default.$k==$cs[0]}{$cs[1]}{elseif $default.$k== $cs}{$cs}{/if}
                                {/foreach}
                                {elseif $default.$k!=''}{$default.$k}{/if}
                            </span>
                            <a href="#" class="editbtn  iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {/if}
                            {if is_array($conf.default)}
                            <select name="modules[{$kl}][options][{$k}]" {if $conf.reload}onchange="return getFieldValues('{if $product_id}{$product_id}{else}{$module.product_id}{/if}')"{/if}>
                                    {foreach from=$conf.default item=cs}
                                    {if $cs|is_array}
                                    <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                                {else}
                                <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                                {/if}
                                {/foreach}
                            </select>
                            {else}
                            <input name="modules[{$kl}][options][{$k}]" value="{if $default.$k}{$default.$k}{/if}" />
                            {/if}
                            {if !$editor}
                        </div>
                        {/if}
                        {elseif $conf.type=='loadablebox'}
                        {if !$editor}
                        <div class="org-content ">
                            {if $default.$k=='1'}{$lang.On}{else}{$lang.Off}{/if}
                            <a href="#" class="editbtn  iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {/if}
                            {if is_array($conf.default)}
                            <input name="modules[{$kl}][options][{$k}]" value="1" type="checkbox" {if $conf.default[0]}checked="checked"{/if} />
                                   {else}
                                   <input type="checkbox" value="1" name="modules[{$kl}][options][{$k}]" {if $default.$k=='1'}checked='checked'{/if} />
                                   {/if}
                                   {if !$editor}
                        </div>
                        {/if}
                        {elseif $conf.type=='loadablecheck'}
                        {if !$editor}
                        <div class="org-content ">
                            {if is_array($conf.default)}
                            {foreach from=$conf.default item=cs}
                            {if $cs|is_array && is_array($default.$k) && in_array($cs[0],$default.$k)}{$lang.On}{elseif is_array($default.$k) && in_array($cs,$default.$k)}{$lang.On}{/if}
                            {/foreach}
                            {elseif $default.$k|is_array}
                            {foreach from=$default.$k item=opt name=multicheck2}
                            {if $opt != '' || $smarty.foreach.multicheck2.iteration == 1}{$opt}<br />{/if}
                            {/foreach}
                            {/if}
                            <a href="#" class="editbtn   iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {/if}
                            {if is_array($conf.default)}
                            {foreach from=$conf.default item=cs}
                            {if $cs|is_array}
                            <input type="checkbox" name="modules[{$kl}][options][{$k}][]" {if is_array($default.$k) && in_array($cs[0],$default.$k)}checked="checked"{/if} value="{$cs[0]}" /> {$cs[1]} <br />
                            {else}
                            <input type="checkbox" name="modules[{$kl}][options][{$k}][]" {if is_array($default.$k) && in_array($cs,$default.$k)}checked="checked"{/if} value="{$cs}" /> {$cs} <br />
                            {/if}
                            {/foreach}
                            {else}
                            <span>
                                {if $default.$k|is_array}
                                {foreach from=$default.$k item=opt name=multicheck}
                                {if $opt != '' || $smarty.foreach.multicheck.iteration == 1}
                                <input name="modules[{$kl}][options][{$k}][]" value="{$opt}" /><br />
                                {/if}
                                {/foreach}
                                {else}
                                <input name="modules[{$kl}][options][{$k}][]" value="" /><br />
                                {/if}
                            </span>
                            <a href="" onclick="addmultifield(this, '{$k}');return false;" style="font-size:9px;" >Add next value</a>
                            {/if}
                            {if !$editor}
                        </div>
                        {/if}
                        {elseif $conf.type=='check'}
                        {if !$editor}
                        <div class="org-content ">
                            {if $default.$k=='1' || (!$default.$k && $conf.default)}{$lang.On}{else}{$lang.Off}{/if}
                            <a href="#" class="editbtn  iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {/if}
                            <input type="checkbox" value="1" name="modules[{$kl}][options][{$k}]" {if $default.$k=='1' || (!$default.$k && $conf.default)}checked='checked'{/if}  {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$module.product_id}{/if})"{/if} />
                                   {if !$editor}
                        </div>
                        {/if}
                        {elseif $conf.type=='select'}
                        {if !$editor}
                        <div class="org-content  ">
                            <span>
                                {foreach from=$conf.default item=cs}
                                {if $cs|is_array && $default.$k== $cs[0]}{$cs[1]}{elseif $default.$k== $cs}{$cs}{/if}
                                {/foreach}
                            </span>
                            <a href="#" class="editbtn iseditable">{$lang.Edit}</a>
                        </div>
                        <div class="editor">
                            {else}
                            <div>
                                {/if}
                                <select id="conf_opt_{$k}" name="modules[{$kl}][options][{$k}]" {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$module.product_id}{/if})"{elseif $conf.onchange}onchange="{$conf.onchange}"{/if}>
                                        {foreach from=$conf.default item=cs}
                                        {if $cs|is_array}
                                        <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                                    {else}
                                    <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                                    {/if}
                                    {/foreach}
                                </select>
                                {if $conf.onchange}
                                <script type="text/javascript">{literal}function lm{/literal}{$k}{literal}() {$('#conf_opt_{/literal}{$k}{literal}').change(); } {/literal}lm{$k}();appendLoader('lm{$k}');</script>
                                {/if}
                                {if !$editor}
                            </div>
                            {else}
                        </div>
                        {/if}
                        {/if}
                    </td>
                </tr>
                {/foreach}
            </table>
        </div>
        <div class="clear"></div>
    </td>
</tr>

{else}
	{include file=$multicustomconfig.$kl}
{/if}
 <tr class="multimodule-{$kl}"></tr>
<tr>
    <td>
        {literal}
            <script type="text/javascript">
                ;(function (mid){
                    var inp = $('.multimodule-'+mid+':first').nextUntil('.multimodule-+mid+').find('input,textrea,select');
                    inp.each(function(){
                        var that = $(this);
                        if(that.parents('.multimodule').length || !that.attr('name') || !that.attr('name').length){
                            return true;
                        }
                        that.attr('name','modules['+mid+']'+that.attr('name').replace(/^([a-z_]*)/,"[$1]"));
                    })                    
                })('{/literal}{$kl}{literal}');
            </script>
        {/literal}
    </td>
</tr>
