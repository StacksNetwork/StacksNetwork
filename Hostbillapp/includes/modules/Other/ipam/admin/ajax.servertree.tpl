{if $servers}
    {foreach from=$servers item=server}
        <li class="extendable  {if $tree[$server.id] == 1}open{/if} {if $server.private}private{/if}">
            <input type="hidden" name="tree[{$server.id}]" value="{$tree[$server.id]}" />
            <span class="extb" onclick="expand(this)" id="expandable_{$server.id}"></span>
            <span class="extt" onclick="groupDetails({$server.id})" >{$server.name}</span>
            <ul>
                {if is_array($server.sublist)}
                    {foreach from=$server.sublist item=entry}
                        <li class="extendable {if $tree[$entry.id] == 1}open{/if}">
                            <input type="hidden" name="tree[{$entry.id}]" value="{$tree[$entry.id]}" />
                            <span class="extb" onclick="expand(this)" id="expandable_{$entry.id}"></span>
                            <span class="extt" onclick="subDetails({$entry.id},{$server.id})">{$entry.name}</span>
                            <ul>
                                {foreach from=$entry.list item=ip}
                                    <li onclick="details(this,{$entry.id})">
                                        <span>{$ip}</span>
                                    </li>
                                {/foreach}
                            </ul>
                        </li>
                    {/foreach}
                {/if}
                {if is_array($server.list)}
                    {foreach from=$server.list item=entry}
                        <li onclick="details(this,{$server.id})">
                            <span>{$entry}</span>
                        </li>
                    {/foreach}
                {/if}
            </ul>
        </li>
    {/foreach}
{else}
    <li class="nothing">{$lang.nothingtodisplay}</li>
    <li class="nothing">Serched in:
        <ul>
            {foreach from=$options item=o key=name}
                <li>
                    {if $name == 'name'}列表名称
                    {elseif $name == 'ipaddress'}IP地址
                    {elseif $name == 'mask'}子网掩码
                    {elseif $name == 'domains'}标识
                    {elseif $name == 'revdns'}反向DNS解析
                    {elseif $name == 'descripton'}说明
                    {elseif $name == 'lastupdate'}最后一次登录
                    {elseif $name == 'changedby'}修改人
                    {elseif $name == 'flag'}包含旗标
                    {/if}
                </li>
            {/foreach}
        </ul>
    </li>
{/if}