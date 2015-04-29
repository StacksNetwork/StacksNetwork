{if !$client_id}
<input type="hidden" name="account_id" id="account_id" value="0" />
{else}
<label class="nodescr">相关服务</label>
                            <select class="w250" name="account_id" id="account_id">
                                <option value="0" {if $selected=='0'}selected="selected"{/if}>无</option>
                                {foreach from=$services item=service}
                                <option value="{$service.id}" {if $selected==$service.id}selected="selected"{/if}>#{$service.id} {$service.pname} {if $service.domain}- {$service.domain}{/if}</option>

                                {/foreach}
                            </select>
                            <div class="clear"></div>
{/if}