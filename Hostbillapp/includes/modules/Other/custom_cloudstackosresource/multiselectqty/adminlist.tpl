{$field.name} {if $field.items}:
<ul style="padding-left:15px;list-style: disc;clear:both">
    {foreach from=$field.items item=i}
       <li>{$i.name}</li>
    {/foreach}
</ul>


{/if}