
				  {if $vpsaddons.backupspace.available}<div id="addon_bar" style="display:none; padding:20px 10px;">
									{foreach from=$alladdons item=i}
									{if $i.module=='class.onapp_backupspace.php'}

    <form name="" action="?cmd=cart&cat_id=addons" method="post">
        <input name="action" type="hidden" value="add">
        <input name="id" type="hidden" value="{$i.id}">
        <input name="account_id" type="hidden" value="{$service.id}">

        <table width="100%" cellspacing=0 cellpadding=5>
            <tbody>
                <tr>
                    <td >
                        <strong>{$i.name}</strong>{if $i.description!=''}<br />{$i.description}{/if}
                    </td><td>
                        {if $i.paytype=='Free'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="free" />
                        {$lang.price}:<strong> {$lang.Free}</strong>

                        {elseif $i.paytype=='Once'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="once" />
                        {$lang.price}: {$i.m|price:$currency} {$lang.once} / {$i.m_setup|price:$currency} {$lang.setupfee}
                        {else}
                        <select name="addon_cycles[{$i.id}]" >
	 {if $i.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        </select>
                        {/if}
                        <br />	  </td>   
                    <td width="25%" align="right">
                        <input type="submit" value="{$lang.ordernow}" style="font-weight:bold;" class="blue"/>
                        <span class="fs11">{$lang.or} <a href="#" onclick="$('#addon_bar').hide();return false" class="fs11" >{$lang.cancel}</a></span>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

			{/if}
		{/foreach}</div>{/if}

<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.date}</td>
            <td>{$lang.Disk}</td>
            <td>{$lang.status}</td>
            <td>{$lang.size}</td>
            <td>{$lang.type}</td>
            <td>&nbsp;</td> <td>&nbsp;</td>
        </tr>
    </thead>
    {foreach item=backup from=$backups}
    <tr>
        <td>{$backup->_created_at|regex_replace:"/[TZ]/":' '}</td>
        <td>#{$backup->_disk_id}</td>
        <td>
            {if $backup->_built == "true" }
            {$lang.Built}
            {else}
            {$lang.Pending}
            {/if}
        </td>
        <td>
            {if $backup->_built != "true"}
            {$lang.notbuilt}
            {elseif $backup->_backup_size gt 1024}
            { $backup->_backup_size/1024|round } MB
            {else}
            { $backup->_backup_size} K
            {/if}
        </td>
        <td>
            {if $backup->_built != "true"}
            &nbsp;
            {else}
            { $backup->_backup_type }
            {/if}
        </td>
        <td>
            {if $backup->_built != "true"}
            &nbsp;
            {else}
             <a href="#" onclick="$('.backup_labels').hide();$('#backup_label_{$backup->_id}').show();return false;" class="small_control small_backup_convert fs11">Convert to template</a><br />
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=backups&vpsid={$vpsid}&do=restore&backupid={$backup->_id}&security_token={$security_token}" onclick="return confirm('{$lang.suretorestorebkp}');" class="small_control small_backup_restore fs11">{$lang.restore}</a>
            {/if}
        </td>
        <td width="60" style="text-align: right">
            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vpsid}&vpsdo=backups&do=delete&backupid={$backup->_id}&security_token={$security_token}" onclick="return confirm('{$lang.suretodeletebkp}')" class="small_control small_delete fs11">{$lang.delete}</a>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="7">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>
{if $vpsaddons.backupspace.available}
<div style="padding:10px 0px;text-align:right">
    <input type="button" class="gray" onclick="$('#addon_bar').toggle();return false;" value="Order extra backup space"/>
</div>
{/if}



{foreach item=backup from=$backups}
<div id="backup_label_{$backup->_id}" style="display:none" class="backup_labels">
    <form method="post" action="">
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="data-table backups-list" style="margin-top:10px;">
            <tr><td colspan="2">
                    Backup conversion lets you create a Template from an existing Virtual Machine configuration, which you can then use to redeploy new Virtual Machines. To convert your Backup, enter a Label name for your new template and click the Convert Backup button.

                    <input type="hidden" name="do" value="convert" />
                    <input type="hidden" name="backupid" value="{$backup->_id}" />
                </td></tr>
            <tr class="lastone">
                <td colspan="2"><span class="slabel">{$lang.label}</span><input type="text" size="30"  name="label"  class="styled" />
                    <input type="submit" value="Convert Backup" class="blue" /></td>
            </tr>


        </table>  {securitytoken}</form>
</div>
{/foreach}
