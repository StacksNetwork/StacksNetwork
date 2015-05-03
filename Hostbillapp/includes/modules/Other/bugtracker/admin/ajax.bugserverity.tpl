<h3>List of clients who voted for this issue</h3>

<table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
<tbody>
<tr>
<th>统计</th>
<th>客户</th>
</tr>
{foreach from=$bug.votes_list item=vote name=fl}
<tr {if $smarty.foreach.fl.index%2==0}class="odd"{else}class="even"{/if}>
<td>{$vote.vote}</td>
<td class="lastitm"><b><a href="?cmd=clients&action=show&id={$vote.client_id}" target="_blank">{$vote.lastname} {$vote.firstname}</a></b></td>
</tr>
{foreachelse}
    
{/foreach}
</tbody>
</table>