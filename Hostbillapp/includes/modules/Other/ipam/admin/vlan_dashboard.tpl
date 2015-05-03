{if !$servers}
    <div class="blank_state_smaller blank_forms" id="blank_pdu">
        <div class="blank_info">
            <h1>欢迎使用IPAM VLAN</h1>
            感谢您使用我们的IPAM插件. 开始添加您的 <a href="#" onclick="addVlanList();
                    return false;">首个VLAN组</a>

        </div>
    </div>
{else}
    <table class="clear" width="100%" cellspacing="0" cellpadding="0" >

        <tbody>
            <tr>
                <th width="220">列表名称</th>
                <th width="200">范围</th>
                <th width="80">自动分配</th>
                <th width="80">私有</th>
                <th width="80">VLAN数量</th>
                <th width="100">闲置</th>
                <th >说明</th>
            </tr>
            {foreach from=$servers item=server}

                <tr>
                    <td><a href="#" onclick="groupDetails({$server.id});return false;">{$server.name}</a></td>
                    <td >{$server.range_from} - {$server.range_to}</td>
                    <td >{if $server.autoprovision=='1'}是{else}否{/if}</td>
                    <td >{if $server.private=='1'}是{else}否{/if}</td>
                    <td>{$server.count}</td>
                    <td>{$server.count_unasigned}</td>
                    <td>{$server.description}</td>
                </tr>
            {/foreach}
        </tbody>
    </table>
{/if}