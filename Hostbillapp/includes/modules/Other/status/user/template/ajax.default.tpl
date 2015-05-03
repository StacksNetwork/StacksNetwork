
{foreach from=$statuses item=status}
    <div class="dotted-line-m separator-line"></div>
    <div class="status">
        <h3><a href="{$ca_url}status/{$status.id}/{$status.slug}/">{$status.name}</a></h3>
        <span class="status-line">
            <i class="icon-calendar"></i>
            {$lang.scheduledon} {if $status.startdate && $status.startdate!='0000-00-00 00:00:00' }{$status.startdate|dateformat:$date_format}{else}{$status.date|dateformat:$date_format}{/if}
        </span>
        <span class="status-line">
            <i class="icon-align-left"></i>
            {$lang.status} {if $lang[$status.status]}{$lang[$status.status]}{else}{$status.status}{/if}
        </span>
        {if $status.enddate && $status.enddate!='0000-00-00 00:00:00'}
        <span class="status-line">
            <i class="icon-time"></i>
            {$lang.estimatedfinish} {$status.enddate|dateformat:$date_format}
        </span>
        {/if}
        <p style="margin-top: 20px;">{$status.description}</p>
        <h4>{$lang.relatedserversservices}</h4>
        <p>{$status.relatedinfo}</p>
    </div>
        
{/foreach}

