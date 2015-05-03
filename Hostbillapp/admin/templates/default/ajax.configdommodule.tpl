 {if $product.app_id}<input type="hidden" value="{$product.app_id}" name="app_id" />
 {elseif $product.module}
<div id="prod_serverform" {if $modconfig &&  !$modconfig.config}style="display: none"{/if}  class="sectionheadblue prod_serverform">
                             <div style="font-size: 14px"><strong>输入应用简介</strong></div>
                             <input name="addserver" value="{if $server_values.addserver || !$servers}1{else}0{/if}" type="hidden" />

                        <table border="0" cellpadding="0" cellspacing="6" width="100%" style="margin-bottom:10px;">

                            {foreach from=$modconfig.config item=conf key=k}
                        <tr >

                            {assign var="name" value=$k}
                            {assign var="name2" value=$modconfig.module}
                            {assign var="baz" value="$name2$name"}
                             <td align="right" width="165"><strong>{if $lang.$baz}{$lang.$baz}{elseif $lang.$name}{$lang.$name}{else}{$name}{/if}:</strong></td>
                            {if $conf.type=='input'}

                                     <td ><input type="text" name="option[{$k}]" value="{$conf.value}" class="inp toserialize"/></td>
                            {elseif $conf.type=='password'}
                                   <td ><input type="password" autocomplete="off" name="option[{$k}]" value="{$conf.value}"  class="inp toserialize"/></td>
                            {elseif $conf.type=='check'}
                                  <td ><input name="option[{$k}]" type="checkbox" value="1" class="toserialize" {if $conf.value == "1"}checked="checked"{/if} style="margin:0px"  /></td>
                            {elseif $conf.type=='select'}
                                <td ><select name="option[{$k}]"  class="inp toserialize" >
                                    {foreach from=$conf.default item=selectopt}
                                            <option {if $conf.value == $selectopt}selected="selected" {/if}>{$selectopt}</option>
                                    {/foreach}
                                    </select> </td>
                            {elseif $conf.type=='textarea'}
                                 <td >
 <span style="vertical-align:top"><textarea name="option[{$k}]" rows="5" cols="60" style="margin:0px" class="toserialize">{$conf.value}</textarea></span></td>
                            {/if}

                        </tr>
                    {/foreach}
                            <tr><td></td><td>
                           <a href="#" class="new_control greenbtn" onclick="return saveProductFull();" ><span class="disk" >保存应用设置</span></a>
                                <span style="margin-left: 30px"><a onclick="return testDomConnection()" id="testing_button" href="#" class="new_control"><span class="wizard">{$lang.test_configuration}</span></a></span>
                                </td></tr>
                        </table>
                        </div>
 <div id="loadable" style="text-align:center;padding:5px 0px;display: none"></div>
 <script type="text/javascript">
            {literal}
                function testDomConnection() {
                    $('#loadable').html('<img src="ajax-loading.gif" />').show();
                    var fields = $('form#productedit .toserialize').serialize();
                    ajax_update('index.php?cmd=servers&action=test_connection&'+fields,{module_id:$('#modulepicker').val()},'#loadable');
                    return false;
                }
            {/literal}
            </script>
{/if}