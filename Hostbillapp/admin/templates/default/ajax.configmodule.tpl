{if $cmd=='productaddons'}<tr>
<td align="right" valign="top" width="160"><strong>模块</strong></td>
<td><strong style="font-size: 14px">{$addon.modulename}</strong><br />{$addon.moduledescription}</td>

</tr>
<tr>
    <td></td>
    <td id="subloader">
    {if $options}
    <div >
        
        
        <table border="0"  width="70%" class="editor-container">
        
        {foreach from=$options item=conf key=k name=checker} 
    
        {if $smarty.foreach.checker.iteration%2=='1'}
    <tr>
    {/if}
    
            {assign var="baz" value=$k}
                            <td align="right" width="160" style="vertical-align: top; padding-top: 5px;"><strong>{if $lang.$baz}{$lang.$baz}{else}{$baz}{/if}:</strong></td>
                                        <td style="" width="">
                {if $conf.type=='input'}
                <input name="options[{$k}]" value="{if $default.$k != ''}{$default.$k}{elseif $conf.default}{$conf.default}{/if}" /></div>
                
                    
                    
                {elseif $conf.type=='loadable'}            
                    {if is_array($conf.default)}
                        <select name="options[{$k}]" {if $conf.reload}onchange=""{/if}>
                            {foreach from=$conf.default item=cs}
                               {if $cs|is_array}
                               <option {if $default.$k==$cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                               {else}
                                <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                                {/if}
                            {/foreach}
                        </select>
                    {else}
                        <input name="options[{$k}]" value="{if $default.$k != ''}{$default.$k}{/if}" />
                    {/if}
                {elseif $conf.type=='loadablecheck'}
                                
                    {if is_array($conf.default)}
                        {foreach from=$conf.default item=cs}
                           {if $cs|is_array}
                              <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs[0],$default.$k)}checked="checked"{/if} value="{$cs[0]}" /> {$cs[1]} <br />
                           {else}
                              <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs,$default.$k)}checked="checked"{/if} value="{$cs}" /> {$cs} <br />
                           {/if}
                       {/foreach}
                                                
                    {else}
                                            <span>
                                            {if $default.$k|is_array}
                                                {foreach from=$default.$k item=opt name=multicheck}
                                                    {if $opt != '' || $smarty.foreach.multicheck.iteration == 1}
                                                        <input name="options[{$k}][]" value="{$opt}" /><br />
                                                    {/if}
                                                {/foreach}
                                            {else}
                                                <input name="options[{$k}][]" value="" /><br />
                                            {/if}
                                            </span>
                                            <a href="" onclick="addmultifield(this, '{$k}');return false;" style="font-size:9px;" >添加下一个值</a>
                    {/if}
                {elseif $conf.type=='check'}                        
                    <input type="checkbox" value="1" name="options[{$k}]" {if $default.$k=='1' || (!$default && $conf.default)}checked='checked'{/if}  {if $conf.reload}onchange=""{/if} />
                    
                {elseif $conf.type=='select'}    
                    <select name="options[{$k}]" >
                            {foreach from=$conf.default item=cs}
                                {if $cs|is_array}
                                                                   <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                                                                {else}
                                                                    <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                                                                {/if}
                            {/foreach}

                    </select>
                {/if}
                        </td>
            {if $smarty.foreach.checker.index%2=='1' && $smarty.foreach.checker.iteration!= '1'}
                            </tr>
                        {/if}
        {/foreach}
        </table>
        </div>
    {/if}
    </td>
</tr>





{else}
<tr>
                      <td align="right" valign="top" style="padding-top:15px;"><strong>{$lang.Server}</strong></td>
                      <td><div style="width: 70%;">
                         {if $servers || $server_values}
                          <div id="use_added_servers" {if $server_values.addserver}style="display:none"{/if}>
                          <table border="0" cellpadding="2" cellspacing="0" >
                              <tr>
                                <td> <div class="ui-ddown serv_picker" id="serv_picker"  >
                              <div class="ui-ddown-default" onclick="$(this).hide();$(this).parent().find('.ui-ddown-list').show();">
                                {if ($product.server && $product.server!='' && $product.server!=0) || $newserverid}
									
                                {foreach from=$servers item=gserver}{foreach from=$gserver.servers item=server}{if $product.server[$server.id] || $newserverid==$server.group_id}{$server.name}, {/if}{/foreach}{/foreach}
                                {else}{$lang.pickservers}{/if}
                            </div>    
                            <div class="ui-ddown-list">
                                <ul class="left">
                                    {foreach from=$servers item=gserver key=gname}                                    
                                    
                                    
                                    {if $gserver.qty>1}
                                    <li><input type="checkbox" class="ccc_{$gserver.id}" onclick="check_scat(this,{$gserver.id});" id="gro-{$gserver.id}" /> <label for="gro-{$gserver.id}">{$gname} ({$gserver.qty} {$lang.Servers})</label></li>
                                    {foreach from=$gserver.servers item=server}
                                    <li class="nested"><input type="checkbox" class="elcc cc_{$server.group_id}" onclick="uncheck_scat(this,{$server.group_id})" name="server[{$server.id}]" id="gs-{$server.id}" {if $product.server[$server.id]}checked='checked'{/if} value="{$server.id}"/> <label for="gs-{$server.id}" ><span>{$server.name}</span> ({$server.accounts}/{$server.max_accounts} {$lang.Accounts})</label></li>
                                    
                                    {/foreach}
                                    
                                    {else}
                                        <li><input type="checkbox"  class="elcc" value="{$gserver.servers[0].id}" name="server[{$gserver.servers[0].id}]" id="gs-{$gserver.servers[0].id}" {foreach from=$gserver.servers item=server}{if $product.server[$server.id] || $newserverid==$gserver.id}checked='checked'{/if}{/foreach}/> <label for="gs-{$gserver.servers[0].id}">{$gname}: <span>{$gserver.servers[0].name}</span></label></li>
                                        {/if}
                                    {/foreach}
                                
                                    
                                    
                                </ul>
                                <a href="#" onclick="return closeCpicker(this);" class="editbtn right" id="cpickclose">{$lang.Close}</a>
                            </div>
                          </div></td>
                          <td>
                          <a href="#" class="new_control" onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}',this)" ><span class="{if $loadable}dwd{else}wizard{/if}" ><strong>{if $loadable}{$lang.getvalsfromserver}{else}Test Connection{/if}</strong></span></a>
                          </td>
                          
                                <td> <a href="" class="new_control" onclick="$('#use_added_servers').hide();$('#prod_serverform').show();$('input[name=addserver]').val('1'); return false;"><span class="addsth" >{$lang.addnewserver}</span></a></td>
                                
                            </tr>
                          </table>
                         
                         
                        

                         
                          </div>
                        {/if}
                        <div id="prod_serverform" {if (!$server_values.addserver && $servers) || !$server_fields}style="display: none"{/if}  class="sectionheadblue"> 
                             <div style="font-size: 14px"><strong>新服务器</strong>
                                {if $servers}<a style="font-size: 14px; font-weight: bold;" onclick="$('#prod_serverform').hide();$('#use_added_servers').show();$('input[name=addserver]').val('0'); return false;" class="editbtn" href="">{$lang.Cancel}</a>{/if}
                            </div>
                             <input name="addserver" value="{if $server_values.addserver || !$servers}1{else}0{/if}" type="hidden" />

                        <table border="0" cellpadding="0" cellspacing="6" width="100%" style="margin-bottom:10px;">
                            {if $server_fields.display.hostname}<tr><td  align="right" width="100"><strong>{if $server_fields.description.hostname}{$server_fields.description.hostname}{else}{$lang.Hostname}{/if}</strong></td><td ><input  name="host" size="40" value="{$server_values.host}" class="inp"/></td></tr>{/if}
                            {if $server_fields.display.ip}<tr><td  align="right" width="100"><strong>{if $server_fields.description.ip}{$server_fields.description.ip}{else}{$lang.IPaddress}{/if}</strong></td><td ><input  name="ip" size="40" value="{$server_values.ip}" class="inp"/></td></tr>{/if}
                            {if $server_fields.display.username}<tr><td  align="right" width="100"><strong>{if $server_fields.description.username}{$server_fields.description.username}{else}{$lang.Username}{/if}</strong></td><td ><input  name="username" size="25" value="{$server_values.username}" class="inp"/></td></tr>{/if}
                            {if $server_fields.display.password}<tr><td  align="right" width="100"><strong>{if $server_fields.description.password}{$server_fields.description.password}{else}{$lang.Password}{/if}</strong></td><td ><input type="password" name="password" size="25" class="inp" value="{$server_values.password}" autocomplete="off"/></td></tr>{/if}
                            {if $server_fields.display.field1}<tr><td  align="right" width="100"><strong>{if $server_fields.description.field1}{$server_fields.description.field1}{/if}</strong></td><td ><input  name="field1" size="25" value="{$server_values.field1}" class="inp"/></td></tr>{/if}
                            {if $server_fields.display.field2}<tr><td  align="right" width="100"><strong>{if $server_fields.description.field2}{$server_fields.description.field2}{/if}</strong></td><td ><input  name="field2" size="25" value="{$server_values.field2}" class="inp"/></td></tr>{/if}
                            {if $server_fields.display.hash}<tr><td width="100" valign="top" align="right"><strong>{if $server_fields.description.hash}{$server_fields.description.hash}{else}{$lang.accesshash}{/if}</strong></td><td ><textarea name="hash" cols="40" rows="8" class="inp">{$server_values.hash}</textarea></td></tr>{/if}
                            {if $server_fields.display.ssl}<tr><td  align="right" width="100"><strong>{if $server_fields.description.ssl}{$server_fields.description.ssl}{else}{$lang.Secure}{/if}</strong></td><td align="left"><input type="checkbox" value="1" {if $server_values.secure == '1'}checked="checked"{/if} name="secure"/> {if $server_fields.description.ssl}{else}{$lang.usessl}{/if}</td></tr>{/if}
                            
                            <tr><td></td><td>
                           <a href="#" class="new_control greenbtn" onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}',this,true)" ><span class="disk" >{$lang.addthisserver}</span></a>
                                <span style="margin-left: 30px"><a onclick="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}',this,false)" id="testing_button" href="#" class="new_control"><span class="wizard">{$lang.test_configuration}</span></a></span>
                                </td></tr>
                        </table>
                        </div>
                          </div>
                      </td></tr>
{if !$customconfig}
   <tr>
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
                                <label for="premadeuse1">使用预设值</label>
                            </div>
                        </td>
                    </tr>
                    <tr id="download_premade" {if !empty($default)}style="display:none"{/if}>
                        <td >
                            <div  class="shownice form" style="padding:10px;" >
                                <div >
                                    <label>Step 1. <small>粘贴 <a target="_blank" href="{$download_yml}">配置URL</a></small></label>
                                    <input type="text"  name="premadeurl" style="width:250px;margin:0px 0px 20px 10px;">
                                    <div class="clear"></div>
                                    <label>Step 2. <small>提交并验证设置</small></label>
                                    <div class="left" style="margin:2px 10px">
                                        <span class="bcontainer dhidden" style="">
                                            <a class="new_control greenbtn" href="#" onclick="return saveProductFull()"><span>提交配置</span></a>
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
                                <label for="premadeuse12">手动设置安装</label>
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
                                <a onclick="return loadOStoConfig({if $product_id}{$product_id}{else}{$product.id}{/if})" class="new_control" href="#" id="loadostemplates" {if !$product.ospick}style="display:none"{/if}>
                                    <span class="dwd">加载OS模板到表单字段</span>
                                </a>
            {if $osconfig_id}
                                <script type="text/javascript">
                                    editCustomFieldForm({$osconfig_id},{if $product_id}{$product_id}{else}{$product.id}{/if});
                                    refreshConfigView({if $product_id}{$product_id}{else}{$product.id}{/if});
                                </script>
            {/if}
                                <script type="text/javascript">{literal}
                                    function loadOStoConfig(pid) {
                                        //basically get values from server with extra param - loadosconfig=true
                                        $('input[name=addserver]').after("<input type='hidden' name='loadosconfig' value='true'/>");
                                        return getFieldValues(pid);
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
        {foreach from=$options item=conf key=k name=checker} 
                    <tr {if $smarty.foreach.checker.iteration%2==0}class="odd"{/if} id="{$k}row">
                    
            {assign var="name" value=$conf.name}
            {assign var="baz" value="$modulename$name"}
            
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
                            <input name="options[{$k}]" value="{if $default.$k!==false}{$default.$k}{elseif $conf.default}{$conf.default}{/if}" />
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
                                <select name="options[{$k}]" {if $conf.reload}onchange="return getFieldValues('{if $product_id}{$product_id}{else}{$product.id}{/if}')"{/if}>
                {foreach from=$conf.default item=cs}
                    {if $cs|is_array}
                                    <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                    {else}
                                    <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                    {/if}
                {/foreach}
                                </select>
            {else}
                                <input name="options[{$k}]" value="{if $default.$k}{$default.$k}{/if}" />
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
                        <input name="options[{$k}]" value="1" type="checkbox" {if $conf.default[0]}checked="checked"{/if} />
            {else}
                        <input type="checkbox" value="1" name="options[{$k}]" {if $default.$k=='1'}checked='checked'{/if} />
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
                        <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs[0],$default.$k)}checked="checked"{/if} value="{$cs[0]}" /> {$cs[1]} <br />
                    {else}
                        <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs,$default.$k)}checked="checked"{/if} value="{$cs}" /> {$cs} <br />
                    {/if}
                {/foreach}
            {else}
                        <span>
                {if $default.$k|is_array}
                    {foreach from=$default.$k item=opt name=multicheck}
                        {if $opt != '' || $smarty.foreach.multicheck.iteration == 1}
                            <input name="options[{$k}][]" value="{$opt}" /><br />
                        {/if}
                    {/foreach}
                {else}
                            <input name="options[{$k}][]" value="" /><br />
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
                        <input type="checkbox" value="1" name="options[{$k}]" {if $default.$k=='1' || (!$default.$k && $conf.default)}checked='checked'{/if}  {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$product.id}{/if})"{/if} />
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
                        <select id="conf_opt_{$k}" name="options[{$k}]" {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$product.id}{/if})"{elseif $conf.onchange}onchange="{$conf.onchange}"{/if}>
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
    {if $extended_options}
        {if !$show_extended}
<tr>
    <td></td>
    <td align="left">
        <a href="" onclick="{literal}$('#show_extended').show(); $('#extended').val(1); $(this).hide(); return false;{/literal}" >
            <strong style="font-size:16px">{$lang.morefeatures}</strong><br />
        </a>
    </td>
</tr>
        {/if}
<tr id="show_extended" {if !$show_extended}style="display: none"{/if}>
    <td></td>
    <td >
        <table border="0" cellpadding="2" cellspacing="0" width="100%">
            <input type="hidden" id="extended" name="show_extended" {if $show_extended}value="1"{else}value="0"{/if} />
    {foreach from=$extended_options item=conf key=k name=checker}
        {if $smarty.foreach.checker.iteration%2=='1'}
            <tr>
        {/if}
        
            {assign var="name" value=$conf.name}
            {assign var="baz" value="$modulename$name"}
                <td align="right" width="160" style="vertical-align: top; padding-top: 5px;"><strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong></td>
                <td style="">
        {if $conf.type=='input'}
                    <input name="options[{$k}]" value="{if $default.$k != ''}{$default.$k}{elseif $conf.default}{$conf.default}{/if}" />
        {elseif $conf.type=='loadable'}
            {if is_array($conf.default)}
                        <select name="options[{$k}]" {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$product.id}{/if})"{/if}>
                {foreach from=$conf.default item=cs}
                    {if $cs|is_array}
                            <option {if $default.$k== $cs[0]}selected="selected" {/if} value="{$cs[0]}">{$cs[1]}</option>
                    {else}
                            <option {if $default.$k== $cs}selected="selected" {/if}>{$cs}</option>
                    {/if}
                {/foreach}
                        </select>
            {else}
                        <input name="options[{$k}]" value="{if $default.$k != ''}{$default.$k}{/if}" />
            {/if}
        {elseif $conf.type=='loadablecheck'}
            {if is_array($conf.default)}
                {foreach from=$conf.default item=cs}
                    {if $cs|is_array}
                        <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs[0],$default.$k)}checked="checked"{/if} value="{$cs[0]}" /> {$cs[1]} <br />
                    {else}
                        <input type="checkbox" name="options[{$k}][]" {if is_array($default.$k) && in_array($cs,$default.$k)}checked="checked"{/if} value="{$cs}" /> {$cs} <br />
                    {/if}
                {/foreach}
            {else}
                        <span>
                {if $default.$k|is_array}
                    {foreach from=$default.$k item=opt name=multicheck}
                        {if $opt != '' || $smarty.foreach.multicheck.iteration == 1}
                            <input name="options[{$k}][]" value="{$opt}" /><br />
                        {/if}
                    {/foreach}
                {else}
                            <input name="options[{$k}][]" value="" /><br />
                {/if}
                        </span>
                        <a href="" onclick="addmultifield(this, '{$k}');return false;" style="font-size:9px;" >{$lang.addnextval}</a>
            {/if}
        {elseif $conf.type=='check'}
                        <input type="checkbox" value="1" name="options[{$k}]" {if $default.$k=='1' || (!$default.$k && $conf.default)}checked='checked'{/if}  {if $conf.reload}onchange="alert('E!');" {/if} />
        {elseif $conf.type=='select'}
                        <select name="options[{$k}]" {if $conf.reload}onchange="return getFieldValues({if $product_id}{$product_id}{else}{$product.id}{/if})"{/if}>
            {foreach from=$conf.default item=cs}
                            <option {if $default.$k == $cs}selected="selected" {/if}>{$cs}</option>
            {/foreach}
                        </select>
        {/if}
                </td>
        {if $smarty.foreach.checker.index%2=='1' && $smarty.foreach.checker.iteration!= '1'}
            </tr>
        {/if}
    {/foreach}
        </table>
    </td>
</tr>
{/if}
{else}
	{include file=$customconfig}
{/if}{* cusom module configuration tpl*}

           
{/if}