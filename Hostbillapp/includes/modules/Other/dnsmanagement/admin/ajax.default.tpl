{if $act=='showlog'}
    {if $logs}
    {foreach from=$logs item=log}
        <tr>
              <td>{$log.date|dateformat:$date_format}</td>
              <td><a href="?cmd=clients&action=show&id={$log.client_id}">{$log.lastname} {$log.firstname}</a></td>
              <td>{$log.action}</td>
              <td>{if $log.result=='1'}<font style="color:#006633">{$lang.Success}</font>{else}<font style="color:#990000">{$lang.Failure}</font>{/if}</td>
              <td>{if $log.fields}
                    {foreach from=$log.fields item=field}
                        {if $field.name}<strong style="text-transform: capitalize">{$field.name}:</strong>{/if}
                        {if $field.from}{$field.from}{/if}
                        {if $field.to} <strong>-></strong> {$field.to}{/if}
                        <br />
                    {/foreach}
                  {/if}
              </td>
              <td>{$log.errors}</td>
        </tr>
        {/foreach}
    {else}
    <tr><td colspan="6"><p align="center" >{$lang.nothingtodisplay}</p></td></tr>

      {/if}
{/if}
{if $act=='test'}
<span style="color:{if $status}#090{else}#900{/if}; font-weight:bold">{if $status}{$lang.Success}{else}{$lang.Error}{if $errors}: {foreach from=$errors item=error}{$error}; {/foreach}{/if} {/if}</span>
{/if}