{if $cacti_datasources}
 {foreach from=$cacti_datasources item=ds}
       {$ds.name}
 <div class="lgraph"><img src="?cmd=cacti&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}" alt="Daily usage " /></div>
 <div class="lgraph"><img src="?cmd=cacti&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=weekly" alt="Weekly usage " /></div>
 <div class="lgraph"><img src="?cmd=cacti&action=showgraph&account_id={$service.id}&switch_id={$ds.c_switch_id}&port_id={$ds.c_port_id}&type=monthly" alt="Monthly usage " /></div>
 {/foreach}
 {literal}
 <style type="text/css">
        .lgraph {
            background: url('ajax-loading.gif') no-repeat center center;
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
 {/literal}
{/if}