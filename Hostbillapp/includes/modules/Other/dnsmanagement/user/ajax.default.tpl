{if $act=='default'}
{if $dnsdomains}
{foreach from=$dnsdomains item=domain name=foo}
 <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
       <td><a href="?cmd=module&amp;module={$module_id}&amp;act=editdomain&amp;id={$domain.id}">{$domain.domain}</a></td>
       <td  align="center"><a href="?cmd=module&amp;module={$module_id}&amp;deletedomain={$domain.id}" onclick="return confirm('{$lang.confirm_deldomain}')">{$lang.delete}</a></td>
    </tr>
{/foreach}

  {/if}
{/if}