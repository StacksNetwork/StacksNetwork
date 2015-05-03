
<form action="" method="post" id="serverform">
    <div class="lighterblue" style="padding: 10px;">

        <input type="checkbox" name="onregister" value="1" {if $submit.onregister != 0}checked="checked"{/if} {literal}onclick="if(this.checked){$('.eventtree input').prop('diabled',false).removeAttr('disabled');if($('.eventtree input:checked').length == 0)$('.eventtree input:last').prop('checked',true);  }else{$('.eventtree input').prop('diabled', true).attr('disabled','disabled')}" {/literal} /> 
        自动创建DNS区域: <a class="vtip_description" title="使用该插件可在新注册域名时创建DNS区域" ></a>
        <div>
            <ul class="treeview eventtree left" style="padding-left:3px;">
                <li style="padding-top:1px">
                    <label>
                        <input type="radio" {if $submit.onregister == 0}disabled="disabled"{/if} name="onregisterevent" {if $submit.onregister == '1'}checked="checked"{/if} value="1" /> 在域名注册/转移之前
                    </label>
                </li>
                <li class="last" style="padding-top:1px">
                    <label>
                        <input type="radio" {if $submit.onregister == 0}disabled="disabled"{/if} name="onregisterevent" {if $submit.onregister == '2'}checked="checked"{/if} value="2" /> 域名成功注册/转移之后
                    </label>
                </li>
            </ul>    

        </div>
        <div class="clear"></div>
        
        
        <input type="checkbox" name="owndomain" value="1" {if $submit.owndomain == 1}checked="checked"{/if} /> 
        为购买主机但域名非我司注册的客户创建DNS区域
        <div class="clear"></div>
        
        <input type="checkbox" name="subdomain" value="1" {if $submit.subdomain == 1}checked="checked"{/if} /> 
        为购买主机但选择了免费子域名的客户创建DNS区域
        <div class="clear"></div>
        
        <br />
        自动创建丢失的区域
        <div>
            <ul class="treeview left" style="padding-left:3px; }">
                <li style="padding-top:1px">
                    <label>
                        <input type="radio" name="onmatch" {if $submit.onmatch == '1'}checked="checked"{/if} value="1" /> 
                        是, 为使用我们DNS服务器的用户创建区域
                    </label>
                </li>
                <li class="last" style="padding-top:1px">
                    <label>
                        <input type="radio" name="onmatch" {if $submit.onmatch == '0'}checked="checked"{/if} value="2" /> 
                        否, 仅对新注册域名创建区域 
                    </label>
                </li>
            </ul>
        </div>
        <div class="clear"></div>
        <br />
        自动移除DNS区域
        <div >
            <ul class="treeview left" style="padding-left:3px; }">
                <li style="padding-top:1px">
                    <label>
                        <input type="radio" name="onmismatch" {if $submit.onmatch == '1'}checked="checked"{/if} value="1" /> 
                        是, 当DNS服务器变更时移除区域
                    </label>
                </li>
                <li class="last" style="padding-top:1px">
                    <label>
                        <input type="radio" name="onmismatch" {if $submit.onmatch == '0'}checked="checked"{/if} value="2" /> 
                        否, 保持区域 
                    </label>
                </li>
            </ul>
        </div>
        <div class="clear"></div>
        <br />
        <div >
            在下列套餐中自动创建DNS区域<br />
            <select name="package" size="4">
                {if $pacakages}
                    {foreach from=$pacakages item=package}
                        <option {if $submit.package == $package.id}selected="selected"{/if} value="{$package.id}">&nbsp;{$package.name}&nbsp;</option>
                    {/foreach}
                {else}
                        <option>无可用的DNS管理App</option>
                {/if}
            </select>
            
        </div>
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
