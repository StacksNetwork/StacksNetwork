<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.Console}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $console}

        <div class="onapp_console" style="text-align: center;">
            <table class="table table-striped" style="margin: auto; text-align: left; width: 640px;" cellpadding=4>
                <tr>
                    <td align="right">{$lang.username}:</td>
                    <td><strong>{$console.username}</strong></td>
                </tr>
                <tr>
                    <td align="right">{$lang.password}:</td> 
                    <td><strong>{$console.password}</strong>
                        {foreach from=$widgets item=widg key=wkey}
                            {if $widg.name == 'solus_pass'}
                                <a class="key-solid fs11 small_control" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}&console">{$lang.changepass}</a>
                            {/if}
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td align="right">{$lang.rootpassword}:</td> 
                    <td><strong>{$console.rootpass}</strong>
                        {foreach from=$widgets item=widg key=wkey}
                            {if $widg.name == 'solus_pass'}
                                <a class="key-solid fs11 small_control" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}&root">{$lang.changepass}</a>
                            {/if}
                        {/foreach}
                    </td>
                </tr>
            </table>
            <applet width="640" height="480" 
                    archive="SSHTermApplet-signed.jar,SSHTermApplet-jdkbug-workaround-signed.jar,SSHTermApplet-jdk1.3.1-dependencies-signed.jar" 
                    code="com.sshtools.sshterm.SshTermApplet" 
                    codebase="includes/libs/sshterm-applet/" 
                    style="display: block; border:1px solid #d0d5e4; padding: 0px; margin: 24px auto 24px auto;">
                <param name="sshapps.connection.host" value="{$console.ip}">
                <param name="sshapps.connection.port" value="{$console.port}">
                <param name="sshapps.connection.userName" value="{$console.username}">
                <param name="sshapps.connection.showConnectionDialog" value="false">
                <param name="sshapps.connection.authenticationMethod" value="password">
                <param name="sshapps.connection.connectImmediately" value="true">
            </applet>
        </div>

    {elseif $vnc}
        <div  class="onapp_console" style="text-align: center;">
            <div style="margin: 24px">: <strong></strong></div>
            <table class="table table-striped" style="margin: auto; text-align: left; width: 724px;" cellpadding=4>
                <tr>
                    <td align="right">VNC {$lang.password}:</td> 
                    <td>
                        <strong>{$vnc.password}</strong> 
                        {foreach from=$widgets item=widg key=wkey}
                            {if $widg.name == 'solus_pass'}
                                <a class="key-solid fs11 small_control" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&vpsid={$vpsid}&vpsdo=vmdetails&widget={$widg.name}{if $widg.id}&wid={$widg.id}{/if}&vnc">{$lang.changepass}</a>
                            {/if}
                        {/foreach}
                    </td>
                </tr>
            </table>
            <applet archive="{if $vnc.version == 2}tightvnc-jviewer.jar{elseif $vnc.version==1}VncViewer.jar{else}/java/vnc/VncViewer.jar{/if}"
                    code="{if $vnc.version == 2}com.glavsoft.viewer.Viewer{else}VncViewer.class{/if}"
                    codebase="{$vnc.vncpath}" 
                    height="428" width="724">
                <param name="Host" value="{$vnc.ip}" /> <!-- Host to connect. Default:  the host from which the applet was loaded. -->
                <param name="Port" value="{$vnc.port}" /> <!-- Port number to connect. Default: 5900 -->
                <param name="Password" value="{$vnc.password}" /> <!-- Password to the server (not recommended to use this parameter here) -->
                <param name="OpenNewWindow" value="no" /> <!-- yes/true or no/false. Default: yes/true -->
            </applet>

        </div>
    {else}
        <center><br><br><br><b>{$lang.consoleunavailable}</b><br><br><br><br></center>

    {/if}
</div>