<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2"><h3>{$lang.sysconfig}</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled {if $cmd=='configuration' && $action=='default'}selected{/if}">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled {if $cmd=='configuration' && ($action=='cron' || $action=='profile' || $action=='addprofile')}selected{/if}">{$lang.cronprofiles}</a>
            <a href="?cmd=security"  class="tstyled">{$lang.securitysettings}</a>
			<a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a> 
        </td>
        <td  valign="top"  class="bordered"><div id="bodycont"> 
		{include file='ajax.configuration.tpl'}
            </div>
        </td>
    </tr>
</table>