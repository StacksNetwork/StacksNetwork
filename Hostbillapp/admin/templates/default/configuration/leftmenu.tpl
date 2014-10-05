
            <a href="?cmd=configuration"  class="tstyled  {if $action!='cron'}selected{/if}">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled {if $action=='cron'}selected{/if}">{$lang.cronprofiles}</a>
            <a href="?cmd=security"  class="tstyled">{$lang.securitysettings}</a>
            <a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a>