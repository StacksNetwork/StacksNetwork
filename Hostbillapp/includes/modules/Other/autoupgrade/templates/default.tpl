<link href="{$template_dir}hbchat/media/settings.css?v={$hb_version}" rel="stylesheet" media="all" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td colspan="2"><h3>Auto Upgrade</h3></td>
        </tr>
        <tr>
            <td rowspan="2" style="line-height:20px;" class="leftNav"></td>
            <td  valign="top"  class="bordered" ><div id="bodycont">
                                {if $warning} 
                                
                                    <div class="chatbg_1" style="padding:50px;text-align:center">
                                        <h1 style="color:red;font-size:32px">Your PHP version is {$phpversion}, HostBill requires PHP 5.3 or higher</h1>
                                        <h2>Update is not possible, manual update will result in errors, please update your PHP version first</h2>
                                    </div>
                                {else}
                                    
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr><td valign="top" width="800" class="chatbg_1" >
                    
                                   
                    <div >
                        {if $upgraded}
                        <div style="margin:24px;">
                            {if $upgrade_result}
                                <h2 style="color:green">{if $action=='performpatch'}Patch{else}Upgrade{/if}: Success</h2>
                            {else}
                                <h2 style="color:blue">{if $action=='performpatch'}Patch{else}Upgrade{/if}: failed</h2>
                                <strong style="color:red">{$upgrade_errors}</strong>
                            {/if}
                        </div>
                        {/if}
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" style="margin-bottom:10px;">
                            <tbody>
                                <tr>
                                    <td valign="top" width="200">
                                        <table border="0" cellspacing="0" cellpadding="4"  class="introduce">
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td width="150">Your version:</td>
                                                <td width="150" {if $current_version!=$latest_version}style="border-right:none;"{/if}>Latest version:</td>
                                                {if $current_version==$latest_version}
                                                <td  width="150" style="border-right:none;">Patch available:</td>
                                                <td  width="150" style="border-right:none;">Plugin updates:</td>
                                                
                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td width="150"><b {if $current_version!=$latest_version}style='color:red'{/if}>{$current_version}</b></td>
                                                <td {if $current_version!=$latest_version}style="border-right:none;"{/if}><b>{$latest_version}</b></td>
                                                {if $current_version==$latest_version}
                                                <td style="border-right:none;"><b>{if $patch_available}Yes{else}No{/if}</b></td>
                                                <td style="border-right:none;"><b>{if $plugin_updates}Yes{else}No{/if}</b></td>
                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td></td>
                                                <td  style="border-right:none;" {if $current_version!=$latest_version}colspan="3"{/if}>
                                                     <em class="fs11">Last checked: {if $latest_version_check}{$latest_version_check|dateformat:$date_format}{/if} <a href="?cmd=autoupgrade&action=checkversion" class="editbtn">check now</a></em>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>

                            </tbody></table>

                        {if $current_version!=$latest_version}
                        <div style="padding-bottom:20px">
                           
                            <div style="padding:20px">
                            <a  href="?cmd=autoupgrade&action=performupgrade&security_token={$security_token}" onclick="return confirm('Are you sure you wish to perform upgrade?')" class="new_add new_menu">
                                <span>Upgrade Now</span>
                            </a>
                                <span class="orspace left" style="padding-top:7px"><a href="http://hostbillapp.com/changelog/" target="_blank">Get more info about this release</a></span>
     <div class="clear"></div>
                                </div>
                        </div>

                        {elseif $patch_available}
 <div style="padding:20px">
      <a  href="?cmd=autoupgrade&action=performpatch&security_token={$security_token}" onclick="return confirm('Are you sure you wish to apply this patch?')" class="new_add new_menu">
                                <span>Auto-Apply Patch Now</span>
                            </a>
      <a  href="https://hostbillapp.com/clientarea/patches/{$patch_file}" class="new_dsave new_menu">
                                <span>Apply Patch Manually</span>
                            </a>
     <span class="orspace right" style="padding-top:7px"><a href="#" onclick="patchInfo();$(this).hide();return false;">Get more info about this patch</a></span>
     <div class="clear"></div>
     <div id="patchinfo" style="margin-top:10px"></div>
     {literal}
     <script>
         function patchInfo() {
            $('#patchinfo').load('?cmd=autoupgrade&action=patchinfo');
         }
         </script>
     {/literal}
  </div>
  
  {elseif $plugin_updates}
      <div style="padding:20px">
      <a  href="?cmd=autoupgrade&action=performpluginup&security_token={$security_token}" onclick="return confirm('Are you sure you wish to update your plugins?')" class="new_add new_menu">
                                <span>Update plugins Now</span>
                            </a>
   
     <div class="clear"></div>
     <div id="patchinfo" style="margin-top:10px">
     <strong>New plugin versions found:</strong><br/>
     {foreach from=$plugin_updates item=p}
         <strong>{$p.name}</strong> ({$p.filename}) - local version: {$p.local}, new version: {$p.remote} <br/>
     {/foreach}
     </div>
    
  </div>
                        {/if}
                    </div>

                                <div style="margin-top:20px"> <form action="" method="post" >
                                        <input type="hidden" name="make" value="send" />
                                    <b>List of files/folders to exclude:</b> <a class="vtip_description" title="Provide list of files/folders you wish to prevent
                                                                     from being overwritten by upgrade or patch. <br/><b>Use relative paths</b>, one per line, like:<br/>
                                                                     templates/orderpages/*  <em>will prevent any file from templates/orderpages from being overwritten</em><br/>
                                                                     includes/core/class.events.php <em>Will prevent one file from being overwritten</em>"></a>

                                    <textarea style="width:100%;height:100px" name="exclusions">{$exclusions}</textarea>
                                    <input type="submit" name="submit" value="Save list" />
                                    {securitytoken}
                                    </form>
                    </div>
                                </td>
                                <td style="background:#f1f1f1;-webkit-box-shadow: inset 8px 0px 6px -6px #c0c0c0;
	   -moz-box-shadow:  inset 8px 0px 6px  -6px #c0c0c0;
	        box-shadow:  inset 8px 0px 6px  -6px #c0c0c0;" valign="top" >
                                    <div style="padding:20px">
                                       
                                        <b>Before applying any patch or performing upgrade make sure to create backup of your HostBill files and database (using control-panel or manual backup)</b>
                                        <br/> <br/>
                                       <h3>Auto-upgrade FAQ</h3>
                                        <b>Q:</b> Do I need to download anything?<br/>
                                        <b>A:</b> No, this tool will download, extract & apply patch/upgrade automatically.<br/><br/>

                                        <b>Q:</b> Will upgrade overwrite my custom clientarea templates?<br/>
                                        <b>A:</b> No, as long as you keep your custom templates in separate folder under /templates, <br>
                                        if you've modified some files its safe to make custom folder under /templates and keep your entire look there.<br/><br/>

                                        <b>Q:</b> Auto-upgrade/patch fails, what can be wrong?<br/>
                                        <b>A:</b> Please make sure that:
                                        <ul>
                                            <li>Your current HostBill files have valid file owner/group (i.e. if you're using suPHP your files should belong to your user, not root)</li>
                                            <li>You have high memory_limit set (default for PHP 5.3 is 128M, we recommend even higher values)</li>
                                        </ul>

                                        <b>Q:</b> How to apply manually downloaded patch?<br/>
                                        <b>A:</b> Please extract patch file in main HostBill directory ({$maindir})
                                        
                                        <br/>
                                        <br/>
                                        For up-to-date faq visit <a href="http://wiki.hostbillapp.com/index.php?title=Auto-Upgrade_plugin" target="_blank">http://wiki.hostbillapp.com/index.php?title=Auto-Upgrade_plugin</a>
                                    </div>
                                    
                                    
                                </td>
                        </tr>
                    </table> {/if}
                </div>

            </td>
        </tr>
</table>