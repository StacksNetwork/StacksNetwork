{literal}<style>
    .power_ok {font-weight:bold;background:#BBDD00;}
    .power_no {font-weight:bold;background:#AAAAAA;}
</style>{/literal}
服务器托管 &amp; 数据中心管理 包括辅助模块越来越多, 在下面您可以检查它们的每一个配置的状态
<br/><br/>
<ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

    {foreach from=$conf item=itm key=mod}
    <li style="background:#ffffff" class="power_row" ><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="80" valign="middle" align="center"  class="{if $itm.active && ($itm.noapp || $itm.server)}power_ok{else}power_no{/if}" ><b>{if $itm.active && ($itm.noapp || $itm.server)}OK{else}CHECK{/if}</b></td>

                        <td>
                            <h3>{$itm.name}</h3>
                            {if !$itm.active}模块已启用, 了解更多内容请访问 <a href="?cmd=managemodules">设置->模块</a> 部分
                            {elseif !$itm.noapp && !$itm.server} 模块已启用, 但没有定义连接 <a href="?cmd=servers">设置->应用</a> 该模块相关的设备/服务
                            {else}
                            模块已激活并已启用
                            {/if}

                        </td>
                    </tr>
                </tbody></table></div></li>
    {/foreach}
</ul>

