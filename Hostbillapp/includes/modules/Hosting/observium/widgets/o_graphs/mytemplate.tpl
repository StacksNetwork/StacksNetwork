{if $observium_datasources}
 {foreach from=$observium_datasources item=ds}
     {$ds.name}
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}" alt="每日流量 " /></div>
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=weekly" alt="每周流量 " /></div>
 <div class="lgraph"><img src="?cmd=observium&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=monthly" alt="每月流量 " /></div>
 {/foreach}
 {literal}
 <style type="text/css">
        .lgraph {
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
 {/literal}
{/if}