{if $_placeholder}
    {if $enableFeatures.profiles=='on'}
        <div class="slide">Loading</div>
    {/if}
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>  
    <div class="slide">Loading</div> <div class="slide">Loading</div>
    <div class="slide">Loading</div> <div class="slide">Loading</div>
{else}

    {if !$_client}
        {if $client.id}{assign value=$client var=_client}
        {elseif $invoice.client.client_id}{assign value=$invoice.client var=_client}
        {elseif $estimate.client.client_id}{assign value=$estimate.client var=_client}
        {elseif $affiliate.client_id}{assign value=$affiliate var=_client}
        {elseif $details.client_id}{assign value=$details var=_client}
        {/if}
    {/if}
    <div class="left">
        <span class="left" style="padding-top:5px;padding-left:5px;"><strong>{$_client.lastname} {$_client.firstname}</strong>&nbsp;&nbsp;</span>

        {if $enableFeatures.profiles=='on'}
            <a class="nav_el  left"  href="?cmd=clients&action=clientcontacts&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false" >{$lang.Contacts}</a>
        {/if}
        <a class="nav_el  left"  href="?cmd=orders&action=clientorders&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Orders}</a>
        <a class="nav_el  left"  href="?cmd=accounts&action=clientaccounts&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Services}</a>
        <a class="nav_el  left" href="?cmd=domains&action=clientdomains&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Domains}</a>
        <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Invoices}</a>
        <a class="nav_el  left" href="?cmd=invoices&action=clientinvoices&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}&currentlist=recurring" onclick="return false">{$lang.Recurringinvoices}</a>

        {if $enableFeatures.estimates=='on'}
            <a class="nav_el  left" href="?cmd=estimates&action=clientestimates&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Estimates}</a>
        {/if}

        <a class="nav_el  left" href="?cmd=transactions&action=clienttransactions&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Transactions}</a>
        <a class="nav_el  left" href="?cmd=tickets&action=clienttickets&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Tickets}</a>
        <a class="nav_el  left" href="?cmd=emails&action=clientemails&id={if $_client.parent_id}{$_client.parent_id}{elseif $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">{$lang.Emails}</a>
        {if $enableFeatures.chat=='on'}
            <a class="nav_el  left" href="?cmd=hbchat&action=clienthistory&id={if $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}" onclick="return false">聊天记录</a>
        {/if}
        <a class="nav_el direct left" href="?cmd=clients&action=show&id={if $_client.client_id}{$_client.client_id}{else}{$_client.id}{/if}">{$lang.Profile}</a>
    </div>
{/if}