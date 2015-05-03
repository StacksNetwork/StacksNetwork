<table width="100%" cellspacing="0" cellpadding="0" border="0" id="content_tb">
<tbody><tr>
<td><h3>Order Quotes</h3></td>
<td></td>
</tr>
<tr>
<td class="leftNav">

</td>
<td valign="top" class="bordered"><div style="" id="bodycont">
{if !$backups}
    <div class="blank_state blank_kb">
                    <div class="blank_info">
                        <h1>No order quotes has been submitted yet</h1>
                        
                        <div class="clear"></div>
                       
                        <div class="clear"></div>
                    </div>
                </div>
    {else}
      <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
        <tbody>
            <tr>
                <th align="left">Id</th>
                <th align="left">Date</th>
                <th align="left">Url</th>
                <th align="left">Type</th>
            </tr>
            {foreach from=$backups item=l name=b}
                <tr class="{if $smarty.foreach.b.iteration%2==0}even{/if}">
                    <td>{$l.id}</td>
                    <td>{$l.created|dateformat:$date_format}</td>
                    <td><a href="{$l.url}" target="_blank">{$l.url}</a></td>
                    <td>{$l.type}</td>
                </tr>    
            {/foreach}
        </tbody>
    </table>
{/if}


</div>
</td>
</tr>
</tbody></table>