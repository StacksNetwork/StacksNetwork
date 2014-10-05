<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td colspan="2"><h3>{if $modname}{$modname}{else}{$lang.modulemanagement}{/if}</h3></td>
    </tr>
    <tr>
        <td class="leftNav">
            {if !$moduleid}
                <a href="?cmd=managemodules&action=default" class="tstyled {if ($cmd=='managemodules' && $action=='default') || $cmd!='managemodules'}selected{/if}"><strong>{$lang.Home}</strong></a><br />
                <a href="?cmd=managemodules&action=other" class="tstyled {if $cmd=='module' ||  $action=='other' }selected{/if}">{$lang.Plugins}</a>
                <a href="?cmd=managemodules&action=payment" class="tstyled {if $cmd=='managemodules' && $action=='payment'}selected{/if}">{$lang.paymentmodules}</a>
                <a href="?cmd=managemodules&action=domain" class="tstyled {if $cmd=='managemodules' &&  $action=='domain'}selected{/if}">{$lang.domainmodules}</a>
                <a href="?cmd=managemodules&action=fraud" class="tstyled {if $cmd=='managemodules' && $action=='fraud'}selected{/if}">{$lang.fraudmodules}</a>
                <a href="?cmd=managemodules&action=hosting" class="tstyled {if $cmd=='managemodules' && $action=='hosting'}selected{/if}">{$lang.hostingmodules}</a>
                <a href="?cmd=managemodules&action=notification" class="tstyled {if $cmd=='managemodules' && $action=='notification'}selected{/if}">{$lang.notificationmodules}</a>
            {else}
                <script type="text/javascript">
                    var module_id = {$moduleid};
                </script>
                <a href="?cmd=module&module={$moduleid}" class="tstyled selected"><strong>{$lang.Home}</strong></a><br />
            {/if}
        </td>
        <td  valign="top"  class="bordered" rowspan="2">
            <div id="bodycont">    
                {if $modname}
                    <div class="blu"><h1>{$modname}</h1></div>
                        {elseif $modulename}
                    <div class="blu"><h1>{$modulename} {if $moduleversion}v.{$moduleversion}{/if}</h1></div>  
                {/if}

