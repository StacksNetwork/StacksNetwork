<link href="{$template_dir}hbchat/media/settings.css?v={$hb_version}" rel="stylesheet" media="all" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td colspan="2"><h3>自动更新</h3></td>
        </tr>
        <tr>
            <td rowspan="2" style="line-height:20px;" class="leftNav"></td>
            <td  valign="top"  class="bordered" ><div id="bodycont">
                                {if $warning} 
                                
                                    <div class="chatbg_1" style="padding:50px;text-align:center">
                                        <h1 style="color:red;font-size:32px">您的PHP版本为 {$phpversion}, 系统需求至少需要5.3以上版本</h1>
                                        <h2>无法进行更新, 手动更新会导致错误, 请更新您的PHP版本</h2>
                                    </div>
                                {else}
                                    
                    <table border="0" cellspacing="0" cellpadding="0" width="100%">
                        <tr><td valign="top" width="800" class="chatbg_1" >
                    
                                   
                    <div >
                        {if $upgraded}
                        <div style="margin:24px;">
                            {if $upgrade_result}
                                <h2 style="color:green">{if $action=='performpatch'}补丁{else}更新{/if}: 成功</h2>
                            {else}
                                <h2 style="color:blue">{if $action=='performpatch'}补丁{else}更新{/if}: 失败</h2>
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
                                                <td width="150">您的版本:</td>
                                                <td width="150" {if $current_version!=$latest_version}style="border-right:none;"{/if}>最新版本:</td>
                                                {if $current_version==$latest_version}
                                                <td  width="150" style="border-right:none;">可用的补丁:</td>
                                                <td  width="150" style="border-right:none;">插件更新:</td>
                                                
                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td width="150"><b {if $current_version!=$latest_version}style='color:red'{/if}>{$current_version}</b></td>
                                                <td {if $current_version!=$latest_version}style="border-right:none;"{/if}><b>{$latest_version}</b></td>
                                                {if $current_version==$latest_version}
                                                <td style="border-right:none;"><b>{if $patch_available}是{else}否{/if}</b></td>
                                                <td style="border-right:none;"><b>{if $plugin_updates}是{else}否{/if}</b></td>
                                                {/if}
                                            </tr>
                                            <tr>
                                                <td width="1" style="border-left:none;"></td>
                                                <td></td>
                                                <td  style="border-right:none;" {if $current_version!=$latest_version}colspan="3"{/if}>
                                                     <em class="fs11">上次检查: {if $latest_version_check}{$latest_version_check|dateformat:$date_format}{/if} <a href="?cmd=autoupgrade&action=checkversion" class="editbtn">立即检查</a></em>
                                                </td>
                                            </tr>
                                        </table>

                                    </td>
                                </tr>

                            </tbody></table>

                        {if $current_version!=$latest_version}
                        <div style="padding-bottom:20px">
                           
                            <div style="padding:20px">
                            <a  href="?cmd=autoupgrade&action=performupgrade&security_token={$security_token}" onclick="return confirm('您确定希望执行升级吗?')" class="new_add new_menu">
                                <span>现在升级</span>
                            </a>
                                <span class="orspace left" style="padding-top:7px"><a href="http://hostbillapp.com/changelog/" target="_blank">获取更多关于该版本的信息</a></span>
     <div class="clear"></div>
                                </div>
                        </div>

                        {elseif $patch_available}
 <div style="padding:20px">
      <a  href="?cmd=autoupgrade&action=performpatch&security_token={$security_token}" onclick="return confirm('您确定想应用这个补丁吗?')" class="new_add new_menu">
                                <span>自动应用补丁现在</span>
                            </a>
      <a  href="https://hostbillapp.com/clientarea/patches/{$patch_file}" class="new_dsave new_menu">
                                <span>手动应用补丁</span>
                            </a>
     <span class="orspace right" style="padding-top:7px"><a href="#" onclick="patchInfo();$(this).hide();return false;">获取更多关于该补丁的信息</a></span>
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
      <a  href="?cmd=autoupgrade&action=performpluginup&security_token={$security_token}" onclick="return confirm('您确定想更新您的插件吗?')" class="new_add new_menu">
                                <span>现在更新插件</span>
                            </a>
   
     <div class="clear"></div>
     <div id="patchinfo" style="margin-top:10px">
     <strong>发现新的插件版本:</strong><br/>
     {foreach from=$plugin_updates item=p}
         <strong>{$p.name}</strong> ({$p.filename}) - 本地版本: {$p.local}, 新的版本: {$p.remote} <br/>
     {/foreach}
     </div>
    
  </div>
                        {/if}
                    </div>

                                <div style="margin-top:20px"> <form action="" method="post" >
                                        <input type="hidden" name="make" value="send" />
                                    <b>排除的文件/文件夹列表:</b> <a class="vtip_description" title="提供文件/文件夹您想保护的列表
                                                                     从被覆盖的升级和补丁. <br/><b>使用相对路径</b>, 每行一个, 例如:<br/>
                                                                     templates/orderpages/*  <em>将阻止改写 templates/orderpages 文件夹下的所有文件</em><br/>
                                                                     includes/core/class.events.php <em>将防止文件被改写</em>"></a>

                                    <textarea style="width:100%;height:100px" name="exclusions">{$exclusions}</textarea>
                                    <input type="submit" name="submit" value="保存列表" />
                                    {securitytoken}
                                    </form>
                    </div>
                                </td>
                                <td style="background:#f1f1f1;-webkit-box-shadow: inset 8px 0px 6px -6px #c0c0c0;
	   -moz-box-shadow:  inset 8px 0px 6px  -6px #c0c0c0;
	        box-shadow:  inset 8px 0px 6px  -6px #c0c0c0;" valign="top" >
                                    <div style="padding:20px">
                                       
                                        <b>在应用任何补丁或执行升级确保创建您的系统件和数据库备份 (使用控制面板或手动备份)</b>
                                        <br/> <br/>
                                       <h3>自动更新FAQ</h3>
                                        <b>Q:</b> 我需要下载所有东西吗?<br/>
                                        <b>A:</b> 不用, 该工具会自动下载, 解压 & 应用补丁/升级.<br/><br/>

                                        <b>Q:</b> 自动更新会覆盖我的自定义模板吗?<br/>
                                        <b>A:</b> 不, 只要您保存您自定义模板在 /templates 目录中的独立文件夹内, <br>
                                        如果您修改了 /templates 目录下的一些默认模板, 请将您需要保留的文件输入在那里.<br/><br/>

                                        <b>Q:</b> 自动更新错误, 问题出在哪儿了?<br/>
                                        <b>A:</b> 请确定下列配置:
                                        <ul>
                                            <li>您当前的系统文件所有人/用户组错误 (i.e. 如果您正在使用 suPHP 您的文件所有人应该是您的Web用户, 而不是root)</li>
                                            <li>您设置的 memory_limit 太低 (默认 PHP 5.3 为 128M, 我们建议使用更高的值)</li>
                                        </ul>

                                        <b>Q:</b> 如何应用手动下载的补丁?<br/>
                                        <b>A:</b> 请解压所有文件到系统主目录 ({$maindir})
                                        
                                        <br/>
                                        <br/>
                                        需要查询自动更新FAQ请访问 <a href="http://wiki.hostbillapp.com/index.php?title=Auto-Upgrade_plugin" target="_blank">http://wiki.hostbillapp.com/index.php?title=Auto-Upgrade_plugin</a>
                                    </div>
                                    
                                    
                                </td>
                        </tr>
                    </table> {/if}
                </div>

            </td>
        </tr>
</table>