{if !$vms}
<tr><td colspan="8"><b>No virtual machines found</b></td></tr>
{else}

{foreach from=$vms item=vm}
<tr>
    <td class="power-status">{if $vm.power=='true'}<span class="yes">Yes</span>{else}<span class="no">No</span>{/if}</td>
    <td><a href="https://{$serverurl}:8006/#v1:0:=qemu%2F{$vm.id}:4::::::" target="_blank" class="external"><strong>{$vm.id} ({$vm.hostname})</strong></a>  {if $vm.ipam}{foreach from=$vm.ipam item=ip name=f}{$ip} {if !$smarty.foreach.f.last},{/if}{/foreach}{/if}</td>
    <td>{$vm.node}</td>
    <td>{$vm.mac}</td>
    <td>{$vm.memory} MB</td>
    <td>{$vm.disk} GB</td>
    <td>{$vm.cpu}</td>
    <td>{$vm.uptime}</td>

</tr>
{/foreach}
{/if}