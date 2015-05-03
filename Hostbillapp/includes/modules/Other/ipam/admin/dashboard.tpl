{if !$servers}<div class="blank_state_smaller blank_forms" id="blank_pdu">
        <div class="blank_info">
            <h1>欢迎使用IPAM</h1>
            感谢您使用我们的IP管理插件. 开始添加您的 <a href="#" onclick="addlist('server');
                    return false;">首个IP列表</a>

        </div>
    </div>
{else}

    <h3>概述: </h3>
    <table class="clear" width="100%" cellspacing="0" cellpadding="0" >

        <tbody>
            <tr>
                <th >列表数量:</th>
                <th >合计IPv4:</th>
                <th >闲置IPv4:</th>
                <th >合计IPv6:</th>
                <th >闲置IPv6:</th>
            </tr>

            <tr>
                <td>{$stats.lists}</td>
                <td>{$stats.ipv4}</td>
                <td>{$stats.ipv4_free}</td>
                <td>{$stats.ipv6}</td>
                <td>{$stats.ipv6_free}</td>
            </tr>

        </tbody>
    </table>
    <br/>

    <table class="clear" width="100%" cellspacing="0" cellpadding="0" >

        <tbody>
            <tr>
                <th width="220">列表名称</th>
                <th width="200">所有人</th>
                <th width="80">自动分配</th>
                <th width="80">IP数量</th>
                <th width="100">闲置IPs</th>
                <th width="100">使用率</th>
                <th width="80">子网列表数量</th>
                <th >说明</th>
            </tr>
            {foreach from=$servers item=server}

                <tr>
                    <td><a href="#" onclick="groupDetails({$server.id});
                    return false;">{$server.name}</a></td>
                    <td >{if $server.client_id}<a href="?cmd=clients&action=show&id={$server.client_id}" target="_blank">#{$server.client_id} {$server.client}</a>{else}-{/if}</td>
                    <td >{if $server.autoprovision=='1'}是{else}否{/if}</td>
                    <td>{$server.count}</td>
                    <td>{$server.count_unasigned}</td>
                    <td>
                        <div class="usage {if $server.count_percent > 75}red{elseif $server.count_percent>50}yelow{elseif $server.count_percent>25}green{/if}">
                            <div style="width: {$server.count_percent}%"><span class="inverted">{$server.count_percent}%</span></div>
                            <span>{$server.count_percent}%</span>
                        </div>
                    </td>
                    <td>{$server.count_sub}</td>
                    <td>{$server.description}</td>
                </tr>

                {if is_array($server.sublist)}

                    {foreach from=$server.sublist item=entry name=fl}
                        <tr>
                            <td>&nbsp;{if $smarty.foreach.fl.last}'{else}|{/if}-&nbsp;<a href="#" onclick="subDetails({$entry.id},{$server.id});return false;">{$entry.name}</a></td>
                            <td >{if $entry.client_id}<a href="?cmd=clients&action=show&id={$entry.client_id}" target="_blank">#{$entry.client_id} {$entry.client}</a>{else}-{/if}</td>
                            <td >{if $entry.autoprovision=='1'}是{else}否{/if}</td>
                            <td>{$entry.count}</td>
                            <td>{$entry.count_unasigned}</td>
                            <td>
                        <div class="usage {if $entry.count_percent > 75}red{elseif $entry.count_percent>50}yelow{elseif $entry.count_percent>25}green{/if}">
                            <div style="width: {$entry.count_percent}%"><span class="inverted">{$entry.count_percent}%</span></div>
                            <span>{$entry.count_percent}%</span>
                        </div>
                    </td>
                            <td>-</td>
                            <td>{$entry.description}</td>
                        </tr>
                    {/foreach}
                {/if}
            {/foreach}
        </tbody>
    </table>
{/if}