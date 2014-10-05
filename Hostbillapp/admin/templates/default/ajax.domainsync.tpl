{if  !$syncdo || $syncdo=='synclist'}
    {if $logs}

        {foreach from=$logs item=log}
                    <tr  >
                        <td>{$log.id}</td>
                        <td>{$log.date|dateformat:$date_format}</td>
                        <td><a href="?cmd=domains&action=edit&id={$log.domain_id}">{$log.name}</a></td>
                        <td><a href="?cmd=clients&action=show&id={$log.client_id}">{$log.firstname} {$log.lastname}</a></td>
                        <td>{$log.module}</td>
                        <td>{if $log.change}
                        {if $log.change.serialized}
                            <ul class="log_list">
                                {foreach from=$log.change.data item=change}
                                    <li>
                                        {if $change.name}<span class="log_change">{$change.name} :</span>{/if}
                                        {if $change.from == ''}<em>(empty)</em>{else}{$change.from}{/if}
                                        {if $change.to} -> {if $change.to == 'empty'}<em>({$lang.empty})</em>{else}{$change.to}{/if}{/if}
                                    </li>
                                {/foreach}
                            </ul>
                        {else}{$log.change.data}{/if}
                    {/if}</td>
                    </tr>
     {/foreach}

    {else}
        <tr><td colspan="5"><strong>{$lang.nothingtodisplay}</strong></td></tr>
    {/if}


{/if}