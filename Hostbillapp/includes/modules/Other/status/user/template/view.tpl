<link media="all" rel="stylesheet" href="{$moduleurl}styles.css" />
<div id="status_view" class="padding white-bg">
    <div class="status">
        <h3><a href="{$ca_url}status/{$status.id}/{$status.slug}/">{$status.name}</a></h3>
        <span class="status-line">
            <i class="icon-calendar"></i>
            {$lang.scheduledon} {if $status.startdate && $status.startdate!='0000-00-00 00:00:00'}{$status.startdate|dateformat:$date_format}{else}{$status.date|dateformat:$date_format}{/if}
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
    
    {if $updates}
        <table class="table table-striped status-updates">
            <tr>
                <th><i class="icon-time"></i> {$lang.date}</th>
                <th>{$lang.action}</th>
            </tr>
            {foreach from=$updates item=update}
                <tr>
                    <td>{$update.date|dateformat:$date_format}</td>
                    <td>{$update.description}</td>
                </tr>
            {/foreach}
        </table>
    {/if}
</div>

