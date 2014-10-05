{if $query && $qty>0}

    {foreach from=$results item=a key=b}
        {$b}
       <table border=1 cellspacing=1>
       <tr>
        {foreach from=$a.fields item=i}
        <td>{$i}</td>
        {/foreach}
        </tr>

        {foreach from=$a.data item=i}
       <tr>
       {foreach from=$i item=o}
         <td>{$o}</td>
        {/foreach}
       </tr>

        {/foreach}


        </table>
    {/foreach}


{elseif $query}

    {$lang.nothingwasfound}

{/if}


