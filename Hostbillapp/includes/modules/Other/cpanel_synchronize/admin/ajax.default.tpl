{if $imported}
  <td style="background-color:#e4ffe4;"><a href="?cmd=clients&amp;action=show&amp;id={$acc.client_id}">#{$acc.client_id} {$acc.client_name}</a></td>
  <td style="background-color:#e4ffe4; font-weight: bold">{$acc.username}</td>
  <td style="background-color:#e4ffe4;">{$acc.domain}</td>
  <td style="background-color:#e4ffe4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>
  <td style="background-color:#e4ffe4; font-weight: bold"><strong style="color: #00CC00">Account Imported</strong></td>
  <td style="background-color:#e4ffe4; font-weight: bold"><a href="?cmd=accounts&action=edit&id={$acc.id}">Manage Account #{$acc.id}</a></td>
  <td style="background-color: #e4ffe4;color:#00CC00; font-weight: bold">OK</td>
{else}
  <td style="background-color:#ffe4e4;">-</td>
  <td style="background-color:#ffe4e4; font-weight: bold">{$acc.username}</td>
  <td style="background-color:#ffe4e4;">{$acc.domain}</td>
  <td style="background-color:#ffe4e4;"><a href="?cmd=servers&amp;action=edit&amp;id={$acc.server_id}">#{$acc.server_id}</a> {$acc.server_name}</td>
  <td style="background-color:#ffe4e4;" colspan="2">
      <strong style="color: #CC0000">Import Failed: {$import_error}</strong>
  </td>
  <td style="background-color: #ffe4e4;color:#CC0000; font-weight: bold">Failed</td>

{/if}