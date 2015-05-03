<div id="newshelf">
    <a href="?cmd=module&module={$module_id}" class="tchoice {if $action != 'showlog'}picked{/if}">配置</a>
    <a href="?cmd=module&module={$module_id}&act=showlog" class="tchoice {if $action == 'showlog'}picked{/if}">显示日志</a>
</div>
{if $action == 'showlog'}<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div  class="lighterblue">
        <div>
            <div class="right"><div class="pagination"></div></div>

            <div class="clear"></div>
        </div>

        <a href="?cmd=module&module={$module_id}&act=showlog" id="currentlist" style="display:none"  updater="#updater"></a>
        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
            <tbody>
                <tr>
                    <th width="100"><a href="?cmd=module&module={$module_id}&act=showlog&orderby=date|ASC" class="sortorder">{$lang.Date}</a></th>
                    <th width="150"><a href="?cmd=module&module={$module_id}&act=showlog&orderby=lastname|ASC"  class="sortorder">{$lang.Client}</a></th>
                    <th width="150"><a href="?cmd=module&module={$module_id}&act=showlog&orderby=action|ASC"  class="sortorder">{$lang.Action}</a></th>
                    <th width="80"><a href="?cmd=module&module={$module_id}&act=showlog&orderby=result|ASC"  class="sortorder">{$lang.Result}</a></th>
                    <th>{$lang.Data}</th>
                    <th width="20%">{$lang.Error}</th>
                </tr>
            </tbody>
            <tbody id="updater">

                {include file='ajax.default.tpl'}
            </tbody>

        </table>
        <div>
            <div class="right"><div class="pagination"></div></div>
            <div class="clear"></div>
        </div>
    </div>
{else}
    <form action="" method="post" id="serverform">
        <div class="lighterblue" style="padding: 10px;">
            <table cellpadding="6" cellspacing="0">
                <tr>
                    <td colspan="2">
                        <input type="checkbox" name="enable" value="1" {if $submit.enable == 'on'}checked="checked"{/if} /> 
                        <strong>{$lang.enablecpanel}</strong>
                    </td>
                </tr>
                <tr> 
                    <td colspan="2">
                        <input type="checkbox" name="enableautozone" value="1" {if $submit.autozone != 0}checked="checked"{/if} {literal}onclick="if(this.checked){$('.eventtree').slideDown();if($('.eventtree input:checked').length == 0)$('.eventtree input:last').prop('checked',true);  }else{$('.eventtree').slideUp()}" {/literal} /> 
                        使用这个插件自动创建DNS区域具有以下指定域的域名服务器
                        <div>
                        <ul class="treeview eventtree left" style="padding-left:3px; {if $submit.autozone == 0}display:none{/if}">
                            <li style="padding-top:1px"><label><input type="radio" name="autozone" {if $submit.autozone == '1'}checked="checked"{/if} value="1" /> 域名注册之前</label></li>
                            <li class="last" style="padding-top:1px"><label><input type="radio" name="autozone" {if $submit.autozone == '2'}checked="checked"{/if} value="2" /> 域名注册成功之后</label></li>
                        </ul>
                        <label class="left eventtree" style="padding:4px 0 0 20px;{if $submit.autozone == 0}display:none{/if}">
                            对于选定域名
                            <select multiple="multiple" size="3" name="autotld[]" style="min-width:160px; vertical-align: top">
                                <option {if $submit.autotld[0] == 'all'}selected="selected" {/if}value='all'>{$lang.all}</option>
                                {foreach from=$tlds item=tld}
                                    <option {if in_array($tld.tld,$submit.autotld)}selected="selected" {/if}value="{$tld.tld}">{$tld.tld}</option>
                                {/foreach}
                            </select>
                        </label>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td width="120">{$lang.serverip}</td>
                    <td>
                        <input name="ip" value="{$submit.ip}" size="15" class="inp" /> 
                        <input type="checkbox" name="ssl" value="1" {if $submit.ssl >= 1}checked="checked"{/if} /> {$lang.usessl}
                    </td>
                </tr>
                <tr>
                    <td>{$lang.Username}</td><td><input name="username" value="{$submit.username}" size="20" class="inp" /> 
                        <span style="margin-left: 30px">
                            <a onclick="testConfiguration() ;return false;" id="testing_button" href="#" class="new_control">
                                <span class="wizard">测试配置</span>
                            </a>
                        </span>
                        <span id="testing_result" style="margin-left: 30px">
                        </span>
                    </td>
                </tr>
                <tr><td>{$lang.Password}</td><td><input type="password" name="password" value="{$submit.password}" size="20" class="inp" /> {if !$submit.hash}<a href="" onclick="$('#hash').show(); $(this).hide(); return false" style="font-size: small">{$lang.usehash}</a>{/if}</td></tr>
                <tr id="hash" {if !$submit.hash}style="display: none"{/if}>
                    <td valign="top">
                        {$lang.acchash}<br/><small>{$lang.insteadof}</small>
                    </td>
                    <td 
                        ><textarea name="hash" cols="60" rows="8" class="inp">{$submit.hash}</textarea>
                    </td>
                </tr>
                
                <tr><td>{$lang.Nameserver} 1</td><td><input name="ns1" value="{$submit.ns1}" size="30" class="inp" /></td></tr>
                <tr><td>{$lang.Nameserver}  1 IP</td><td><input name="ns1ip" value="{$submit.ns1ip}" size="30" class="inp" /></td></tr>
                <tr><td>{$lang.Nameserver}  2</td><td><input name="ns2" value="{$submit.ns2}" size="30" class="inp" /></td></tr>
                <tr><td>{$lang.Nameserver}  2 IP</td><td><input name="ns2ip" value="{$submit.ns2ip}" size="30" class="inp" /></td></tr>
                <tr><td>{$lang.Nameserver}  3</td><td><input name="ns3" value="{$submit.ns3}" size="30" class="inp" /></td></tr>
                <tr><td>{$lang.Nameserver}  3 IP</td><td><input name="ns3ip" value="{$submit.ns3ip}" size="30" class="inp" /></td></tr>
            </table>

        </div>
        <div class="blu">
            <input type="submit" name="save" value="{$lang.savechanges}" style="font-weight: bold" />
        </div>

    </form>
    <script type="text/javascript">
        {literal}
                    function testConfiguration() {
						$('#testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
						ajax_update('?cmd=module&module={/literal}{$module_id}{literal}&act=test&'+$('#serverform').serialize(),{},'#testing_result');
					} 
        {/literal}
    </script>
{/if}
