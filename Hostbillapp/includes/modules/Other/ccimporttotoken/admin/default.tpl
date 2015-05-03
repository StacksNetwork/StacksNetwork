<div class="lighterblue" style="padding: 20px 50px">
    {if $summary}
        <strong>Import Summary:</strong><br />
        Client details attempted to import: {$clients_imported}<br />
        <em>Clients left: {$clients_left}</em><br/><br/>
        <div class="blu" style="padding:10px">
            {foreach from=$summary item=sum}
            <strong>Client #{$sum.client_id}</strong> {$sum.client_name} - {if $sum.result}<font style="color: #00cc00">Success</font>{else}<font style="color: #cc0000">Error: {$sum.error}</font>{/if}<br/>
            {/foreach}
        </div>
        <div style="padding:20px 50px">
            <form action="" method="post" >
                <input type="submit" name="run" value="Run Again" style="font-weight: bold; font-size: 18px; padding: 12px" />
            </form>
        </div>
    {else}
        <strong>Warning!</strong>
        <p style="margin:2px 10px">Please make the backup of DataBase before running!</p>
        {if $checkconfig}
        <div style="padding:30px 70px">
            <form action="" method="post" >
                <input type="submit" name="run" value="Run Import" style="font-weight: bold; font-size: 20px; padding: 15px" />
            </form>
        </div>
        {else}
        <p style="padding: 10px; font-weight: bold; color: #cc0000">The module configuration is not complete! Unable to proceed.</p>
        {/if}
    {/if}
</div>