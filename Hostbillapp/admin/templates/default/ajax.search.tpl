{if $results}
    {if $results.Clients}
        <li class="choices-header choices-Clients">{$lang.Clients}</li>
            {foreach from=$results.Clients item=re}
            <li class="result"><a href="?cmd=clients&action=show&id={$re.id}">{$re.firstname} {$re.lastname}
                    <span class="second">{$re.email}</span>
                    {if $re.companyname && $re.companyname!=''}
                        <span class="second">{$lang.companyname}: {$re.companyname}</span>
                    {/if}
                </a>
            </li>
        {/foreach}
    {/if}

    {if $results.Accounts}
        <li class="choices-header choices-Accounts">{$lang.Accounts}</li>
            {foreach from=$results.Accounts item=re}
            <li class="result"><a href="?cmd=accounts&action=edit&id={$re.id}&list=all">#{$re.id} {$re.domain} <em>{if $re.username}u: {$re.username}{/if}</em>
                    <span class="second">{$re.firstname} {$re.lastname}</span>
                </a>
            </li>
        {/foreach}
    {/if}

    {if $results.Domains}
        <li class="choices-header choices-Domains">{$lang.Domains}</li>
            {foreach from=$results.Domains item=re}
            <li class="result"><a href="?cmd=domains&action=edit&id={$re.id}">{$re.name}
                    <span class="second">{$re.firstname} {$re.lastname}</span>
                </a>
            </li>
        {/foreach}
    {/if}

    {if $results.Invoices}
        <li class="choices-header choices-Invoices">{$lang.Invoices}</li>
            {foreach from=$results.Invoices item=re}
            <li class="result"><a href="?cmd=invoices&action=edit&id={$re.id}&list=all">{if $proforma && ($re.status=='Paid' || $re.status=='Refunded') && $re.paid_id!=''}{$re.paid_id}{else}{$re.date|invprefix:$prefix:$re.client_id}{$re.id}{/if}
                    <span class="second">{$re.firstname} {$re.lastname}</span>
                </a>
            </li>
        {/foreach}
    {/if}

    {if $results.Tickets}
        <li class="choices-header choices-Tickets">{$lang.Tickets}</li>
            {foreach from=$results.Tickets item=re}
            <li class="result"><a href="?cmd=tickets&action=view&list=all&num={$re.ticket_number}">{$lang.tickethash}{$re.ticket_number} - {$re.subject}
                    <span class="second">{$re.name} <span>{$re.email}</span></span>
                </a>
            </li>
        {/foreach}
    {/if}

    {if $results.Transactions}
        <li class="choices-header choices-Transactions">{$lang.Transactions}</li>
            {foreach from=$results.Transactions item=re}
            <li class="result"><a href="?cmd=transactions&action=edit&id={$re.id}">{$lang.transactionhash}{$re.trans_id}
                    <span class="second">{$re.firstname} {$re.lastname}</span>
                </a>
            </li>
        {/foreach}
    {/if}
    
    {if $results.Orders}
        <li class="choices-header choices-Transactions">{$lang.Orders}</li>
            {foreach from=$results.Orders item=re}
            <li class="result"><a href="?cmd=orders&action=edit&id={$re.id}">#{$re.number}
                    <span class="second">{$re.firstname} {$re.lastname}</span>
                </a>
            </li>
        {/foreach}
    {/if}


    {foreach from=$results item=r key=k}
        {if $k!='Transactions' &&
     $k!='Invoices' &&
     $k!='Tickets' &&
     $k!='Domains' &&
     $k!='Accounts' &&
     $k!='Clients' && 
    $k!='Orders'}
        <li class="choices-header">{$k}</li>
            {foreach from=$results.$k item=re}
            <li class="result">
                <a href="{$re.link}">{$re.text}</a>
            </li>
            {/foreach}
        {/if}
    {/foreach}
{else}
    <li class="choices-header choices-Tickets"><em>{$lang.nothing}</em></li>
{/if}