<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td>
            <h3>{$lang.bantitle}</h3>
        </td>
        <td>

        </td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
            <a href="?cmd=bans"  class="tstyled  {if $action == 'default'}selected{/if}">{$lang.bannedips}</a>
            <a href="?cmd=bans&action=emails"  class="tstyled {if $action == 'emails'}selected{/if}">{$lang.bannedemails}</a>
			<a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a> 
        </td>
        <td  valign="top"  class="bordered"><div id="bodycont" style="">
                {include file='ajax.bans.tpl'}
            </div>
        </td>
    </tr>
</table>