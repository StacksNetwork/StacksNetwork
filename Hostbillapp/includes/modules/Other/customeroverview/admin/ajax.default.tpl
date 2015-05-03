<div class="profile">
    <strong>{$client.lastname} {$client.firstname}</strong>{if $client.companyname}, {$client.companyname}{/if}<br />
    {$client.email}<br />
    <div class="separator"></div>
    <strong>{$lang.Income}</strong>: {$stats.income|price:$stats.currency_id}<br />
    <strong>{$lang.Credit}</strong>: {$stats.credit|price:$stats.currency_id}<br />
    <strong>{$lang.invoicesdue}</strong>: {$stats.invoice_unpaid|price:$stats.currency_id} <br />
    <strong>{$lang.supptickets}</strong>: {$stats.ticket}<br />
    <div class="separator"></div>
    {if $notes}
        <strong>Client notes ({$notes})</strong>
        <div class="note">{$last_note.note}</div>
        <div class="separator"></div>
    {/if}
    
    {if $admindata.access.loginAsClient}<a href="{$system_url2}?action=adminlogin&id={$client.id}">已用户身份登录</a> | {/if} 
    <a href="?cmd=clients&action=show&id={$client.id}">客户配置文件</a>
</div>