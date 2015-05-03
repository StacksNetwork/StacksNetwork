<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>Flavor List</span></a>
            </li>
            <li class="{if $action == 'storage'}active{/if}">
                <a {if $action != 'storage'} href="?cmd={$modulename}&action=storage"{/if}><span>Storage Flavor List</span></a>
            </li>
            <li class="{if $action == 'add' || $action == 'edit'}active{/if} last">
                <a {if $action != 'add' && $action == 'edit'}href="?cmd={$modulename}&action=add"{/if}>
                    <span>
                        {if $action == 'edit'}{$entry.name|truncate} - {if $entry.type == 0}VM Flavor{else}Storage Flavor{/if}
                        {else}New Flavor
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
                    <li class="picked"><a href="#VM"><span>VM Flavor</span></a></li>
                    <li ><a href="#STORAGE"><span>Storage Flavor</span></a></li>
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
                <label><b>Name</b></label>
                <a class="vtip_description" title="Customer will see this flavor name"></a>
            </td>
            <td><input type="text" value="{$entry.name}" name="name" class="inp" /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right">
                <label>
                    <b class="tabs VM">Price per hour</b>
                    <b class="tabs STORAGE">Price for 1GB/hour</b>
                </label>
                <a class="vtip_description" title="Monthly charge will be automatically calculated based on this setting"></a></td>
            <td><input type="text" value="{$entry.price_on}" name="price" class="inp" /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right"><label><b>Enable </b> </label><a class="vtip_description" title="Tick for clients to see this flavor"></a></td>
            <td><input type="checkbox" value="1" name="enabled" {if $entry.enabled}checked="checked"{/if} /></td>
        </tr>
        <tr>
            <td style="width: 140px; text-align: right"><label><b>Description</b></label><a class="vtip_description" title="Clients will see this description, use this to describe flavor values as clients will not see variable values below"></a></td>
            <td><textarea name="description" style="width:500px;height:100px;">{$entry.description}</textarea></td>
        </tr>

        <tr >
            <td style="width: 140px; text-align: right"><label>Show settings for module:</label></td>
            <td>
                <select id="module" name="module">
                    <option value="0">-- All --</option>
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
        <span>Save Changes</span>
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