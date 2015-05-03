<div class="lighterblue" style="padding:20px;">
With every cron run this module will connect to every selected server from list below to check if there are accounts
that meets local threshold for ticket warning or suspension for high CPU usage, and perform necessary action.
HostBill will perform suspend/send ticket actions only on accounts that are provisioned with HostBill.
<br />
<br />
For configuration guide, visit <a href="http://wiki.hostbillapp.com/index.php?title=CPanel_CPU_Suspend">http://wiki.hostbillapp.com/index.php?title=CPanel_CPU_Suspend</a>

<br />

<strong>Note:</strong> 
Custom cPanel module file (SuspendCheck.pm) needs to be in place on all of your cPanel servers you wish to monitor, and cron job for each module (SuspendCheck.cron.pl) needs to be added to gather data. You can set threshold levels individually per server by editing SuspendCheck.pm file. Please refer to README file for installation instructions.<br /><br />



        <div class="sectionheadblue" style="padding: 10px; width: 550px">
        {if $servers}
        <form action="" method="post">
            <input type="hidden" name="do" value="updateconfig" />
			<input type="checkbox" name="suspend" value="on" {if $suspend}checked="checked"{/if} /> <strong>Suspend accounts</strong><br />
<input type="checkbox" name="tickets" value="on" {if $tickets}checked="checked"{/if} /> <strong>Send warning tickets</strong>
	<span id="predrep"  {if !$tickets}style="display:none"{/if}>Using this predefined reply message for ticket body: <select name="predefined_msg">{foreach from=$predefined item=reply}<option value="{$reply.id}" {if $reply.id==$ticket_id}selected="selected"{/if}>{$reply.catname}: {$reply.name}</option>{/foreach}</select> <span class="orspace">Or</span> <a href="?cmd=predefinied&action=new" target="_blank" class="new_control"><span class="addsth">Create new message</span></a></span>
<br />
			
            <table cellpadding="0" cellspacing="10" width="100%">
                <tr><td style="font-weight: bold; padding-top: 5px" align="right" valign="top">Choose servers:</td><td>
                        <div >
                        {foreach from=$servers item=server_list key=group_name}
                            <h3>{$group_name}</h3>
                            <div style="padding-left: 20px">
                            {foreach from=$server_list item=server}
                                <input type="checkbox" name="server_list[]" value="{$server.id}" {if $monit_servers[$server.id]}checked="checked"{/if}/> <a href="?cmd=servers&amp;action=edit&amp;id={$server.id}">#{$server.id}</a> {$server.name} <a href="#" onclick="return testConfiguration({$server.id});" class="editbtn">Test for module presence</a> <span id="stat_{$server.id}"></span><br />
                            {/foreach}
                            </div>
                        {/foreach}
                        </div>
                    </td></tr>
                
                <tr><td colspan="2" style="padding: 20px; text-align: center"><input type="submit" value="Save Configuration" style="padding: 5px; font-weight: bold; font-size: 14px" /></td></tr>
            </table>
        </form>
        {else}
        <center>There are no servers using cPanel module defined yet.</center>
        {/if}
        </div>
    </div>
	<script type="text/javascript">
		{literal}
		function testConfiguration(sid){
		ajax_update('?cmd=module&module=cpanel_cpu_suspend&do=testconfig',{server_id:sid},'#stat_'+sid);
		return false;
		}
		
		{/literal}
	</script>