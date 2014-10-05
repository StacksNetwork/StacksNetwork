<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>弹性资源列表</span></a>
            </li>
            <li class="{if $action == 'storage'}active{/if}">
                <a {if $action != 'storage'} href="?cmd={$modulename}&action=storage"{/if}><span>弹性存储列表</span></a>
            </li>
            <li class="{if $action == 'add' || $action == 'edit'}active{/if} last">
                <a {if $action != 'add' && $action == 'edit'}href="?cmd={$modulename}&action=add"{/if}>
                    <span>
                        {if $action == 'edit'}{$entry.name|truncate} - {if $entry.type == 0}弹性VM{else}弹性存储{/if}
                        {else}新建弹性资源
                        {/if}
                    </span>
                </a>
            </li>
        </ul>
    </div>
    {if $action!="edit"}
        <div class="list-2">
            <div class="subm1 haveitems">
                <ul id="typepick">
                    <li class="picked"><a href="#VM"><span>弹性VM</span></a></li>
                    <li ><a href="#STORAGE"><span>弹性存储</span></a></li>
                </ul>
            </div>
        </div>
    {/if}
</div>
<form method="post" action="?cmd={$modulename}&action={$action}" id="status_plugin"  style="padding: 10px 0;">
    {if $action=="edit"}
        <input type="hidden" name="id" value="{$entry.id}"/>
        <input type="hidden" name="edit" value="1"/>
    {else}
        <input type="hidden" name="add" value="1"/>
    {/if}
    <table cellpadding="5" style="width: 100%">
        <tr>
            <td style="width: 140px; text-align: right">
                <label><b>名称</b></label>
                <a class="vtip_description" title="客户将可以看到该弹性资源"></a>
            </td>
            <td><input type="text" value="{$entry.name}" name="name" class="inp" /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right">
                <label>
                    <b class="tabs VM">按小时计费</b>
                    <b class="tabs STORAGE">按每1GB/小时计费</b>
                </label>
                <a class="vtip_description" title="基于这个设置每月费用会自动计算"></a></td>
            <td><input type="text" value="{$entry.price_on}" name="price" class="inp" /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right"><label><b>启用 </b> </label><a class="vtip_description" title="勾选使客户能够看到该弹性资源"></a></td>
            <td><input type="checkbox" value="1" name="enabled" {if $entry.enabled}checked="checked"{/if} /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right"><label><b>说明</b></label><a class="vtip_description" title="客户会看到该说明, 使用这个弹性值作为客户将不会看到变量值低于描述"></a></td>
            <td><textarea name="description" style="width:500px;height:100px;">{$entry.description}</textarea></td>
        </tr>

        <tr >
            <td style="width: 140px; text-align: right"><label>显示模块的配置:</label></td>
            <td>
                <select id="module" name="module">
                    <option value="0">-- 所有 --</option>
                    {foreach from=$modules item=modulename key=moduleid}
                        <option value="{$moduleid}" {if $entry.limits.$key}selected="selected"{/if}>{$modulename}</option> 
                    {/foreach}
                </select>
            </td>
        </tr>
        <input type="hidden" id="typepicked" name="type" value="{if $entry.type == 0}VM{else}STORAGE{/if}"/>
        {if $action!="edit" || $entry.type == 0 }
            <tbody class="tabs VM">
                {foreach from=$variables.VM item=mods key=key} 
                    <tr class="modframe {foreach from=$mods item=n key=mid}mod_{$mid} {/foreach}">
                        <td style="width: 140px; text-align: right">
                            {foreach from=$mods item=data key=mid}
                                <label class="modframe mod_{$mid}">{$data.name}</label>
                            {/foreach}
                        </td>
                        <td>
                    {if $data.tpl_path}{include file=$data.tpl_path}{elseif $data.tpl_source}{$data.tpl_source}{else}
                        <input type="text" value="{$entry.limits.$key}" name="limits[{$key}]" class="inp" />
                    {/if}
                </td>
            </tr>
        {/foreach}
    </tbody>
{/if}
{if $action!="edit" || $entry.type == 1 }
    <tbody class="tabs STORAGE">
        {foreach from=$variables.STORAGE item=mods key=key} 
            <tr class="modframe {foreach from=$mods item=n key=mid}mod_{$mid} {/foreach}">
                <td style="width: 140px; text-align: right">
                    {foreach from=$mods item=data key=mid}
                        <label class="modframe mod_{$mid}">{$data.name}</label>
                    {/foreach}
                </td>
                <td>
            {if $data.tpl_path}{include file=$data.tpl_path}{elseif $data.tpl_source}{$data.tpl_source}{else}
                <input type="text" value="{$entry.limits.$key}" name="limits[{$key}]" class="inp" />
            {/if}
        </td>
    </tr>
{/foreach}
</tbody>
{/if}
</table>
<div class="clearfix" style="padding: 0 10px;">
    <a class="new_dsave new_menu" href="#" onclick="$('#status_plugin').submit(); return false;">
        <span>保存更改</span>
    </a>
</div>
{securitytoken}
</form>
{literal}
    <script type="text/javascript">
        $(function() {
            $('#module').change(function() {
                var val = $(this).val();
                if (val == '0') {
                    $('tr.modframe').show().find('label:first-child').show();
                } else {
                    $('.modframe').hide();
                    $('.mod_' + val).show();
                }
            });//.change();
            function switchType(to) {
                var type = $('#typepicked');
                to = to || type.val();
                type.val(to);
                $('.tabs').hide().find('input, select, textarea').prop('disabled', true);
                $('.' + to).show().find('input, select, textarea').prop('disabled', false);
            }
            $('#typepick a').click(function() {
                var self = $(this),
                    href = self.attr('href');

                self.parent().siblings().removeClass('picked').end().addClass('picked');

                switchType(href.substr(1));
                return false;
            });
            switchType();
        })

    </script>
{/literal}