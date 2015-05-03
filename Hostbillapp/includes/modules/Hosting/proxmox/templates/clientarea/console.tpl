<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $newconsole}
        {literal}
            <script type="text/javascript">
                PVE_vnc_console_event = function(appletid, action, err) {
                    //console.log("TESTINIT param1 " + appletid + " action " + action);
                    if (action === "error") {
                    }
                    return;
                };
            </script>
        {/literal}
        <div class='onapp_console' style='text-align:center'>
            <applet archive='{$console.asset}' codebase='{$console.asset}'  code='com.tigervnc.vncviewer.VncViewer'  
                    height='426' width='750' style='width: 720px; height: 426px;'>
                <param name='PORT' value="{$console.port}" />
                <param name='PASSWORD' value="{$console.ticket}" />
                <param name='USERNAME' value="{$console.user}" />
                <param name='PVECert' value="{$console.cert}" />
                <param value="No" name="Offer Relogin" />
            </applet>
        </div>
    {else}
        <center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>
    {/if}
</div>