<link type="text/css" href="{$moduledir}stylesheet.css" rel="stylesheet" />
<link type="text/css" href="{$template_dir}js/gui.elements.css" rel="stylesheet" />
<script type="text/javascript" src="{$template_dir}js/gui.elements.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.source.js"></script>
<script type="text/javascript" src="{$moduledir}scripts.js"></script>
<div class="blu" data-action="vlan"><h1>VLANs</h1></div>
<div class="blu"><h1>选项</h1></div>
<div class="blu"><h1>反向DNS解析</h1></div>
<div class="blu" data-action="logs"><h1>审核日志</h1></div>

<div style="background:#E0ECFF;height: 2.5em;width: 100%;"></div>
<div class="pagecont" >
    {include file="ajax.default.tpl"}
</div><!-- main -->
<div class="pagecont" style="display:none">
    {include file="ajax.vlan.tpl" servers=$vlangroups}
</div><!-- main -->
<div class="pagecont lighterblue" style="display:none">
    <form action="?cmd=module&module={$moduleid}&setting=save" method="post" id="optform">
        <div style="padding:10px 1em">
            <div style="margin-bottom: 0px; font-weight: bold">
                <input name="emails" type="checkbox" value="1" {if $settings.email}checked="checked"{/if} /> 
                IP列表的更新时发送邮件.
            </div>
            <div style="padding:10px 1em">
                通知下述管理员:
                {if $adminlist}<br />
                    {foreach from=$adminlist item=admin}
                        <input name="admins[{$admin.id}]" {if $admin.id|in_array:$settings.admins}checked="checked"{/if}type="checkbox" value="{$admin.id}" /> {$admin.username}
                    {/foreach}
                {/if}
            </div>
            
            <div style="margin: 10px 0 ; font-weight: bold">
                <input name="reservation" type="checkbox" value="1" {if $settings.reservation}checked="checked"{/if} />
                保留规则
                <a href="#" class="vtip_description" title="当整个IP列表指定此选项会自动保留IPS基于以下的规则. 您可以使用 'n' 和 'm' 变量的定义列表的开始和结束点, 例如: <br/>&nbsp;&bull;&nbsp;&nbsp;'n+1' 将保留第二个IP<br/>&nbsp;&bull;&nbsp;&nbsp;'m' 将保留最后一个IP" ></a>
            </div>
                
            {foreach from=$settings.reservations item=reserve key=kk}
            <p>
                IP数字: <input name="reservations[{$kk}][ip]" type="text" class="inp" value="{$reserve.ip}" /> 
                保留给 <input name="reservations[{$kk}][descr]" type="text" class="inp" value="{$reserve.descr}" />
                <a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >移除</a>
            </p> 
            {/foreach}
            <a href="#addRule" class="editbtn" onclick="addReservationRule(this); return false" />添加新规则</a>
        </div>
        <div style="padding:10px 10px"> 
            <a class="new_dsave new_menu" href="#" onclick="$('#optform').submit();
                    return false;">
                <span>{$lang.savechanges}</span>
            </a>
            <div class="clear"></div>
        </div>
    </form>
</div><!-- opt -->

<!-- reverse DNS -->
<div class="pagecont" style="display:none">
    <div style="padding:10px 1em">


        <div id="add_pdu" {if !$rdnsid}style="display:none"{/if}>
            <form action="?cmd=module&module={$moduleid}&rdns=save" method="post" id="optform2">
                <table border="0" cellpadding="6" cellspacing="0">
                    <tr>
                        <td>DNS应用: </td>
                        <td><select name="rdnsid" class="inp">
                                <option value="0">无 - 禁用rDNS</option>
                                {foreach from=$rdnsapps item=app}

                                    <option value="{$app.id}" {if $app.id==$rdnsid}selected="selected"{/if}>{$app.groupname} - {$app.name}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>

                </table>
                <a onclick="$('#optform2').submit();
                    return false;" href="#" class="new_dsave new_menu">
                    <span>保存修改</span>
                </a>
                {securitytoken}
            </form>
            <div class="clear"><br/></div>
        </div><div class="clear"></div>


        <div class="blank_state_smaller blank_forms" id="blank_pdu">
            <div class="blank_info">
                <h1>为您的客户启用自动rDNS管理</h1>
                IPAM模块可以与PowerDNS模块一起使用, 让您的托管/专用服务器客户管理能在用户控制台直接管理他们的PTR记录.
                <br/><br/>
                <b>在系统中启用rDNS反向域名解析管理</b>
                <ol>
                    <li>进入菜单 设置->模块 启用PowerDNS模块</li>
                    <li>连接到您的DNS服务器配置 设置->应用</li>
                    <li>在产品中启动反向解析 产品/服务->客户端功能 在托管/专用服务器等产品中.</li>
                    <li>刷新该部分选取将使用的应用程序</li>
                    <li>在托管/专用服务器等产品的产品设置中, 启用rDNS反向域名解析管理</li>
                    <li>创建通用DNS区域 <b>in-addr.arpa</b> 或者 /24 的特定子网 (如 3.2.1.in-addr.arpa for 1.2.3.0/24)</li>
                    <li>有套餐业务包含IP地址的客户会在 (账户详情)->IPAM选项卡内出现rDNS记录管理功能</li>
                    <li>此外, 任何时候你会在IPAM插件编辑RDNS栏目, 它将发送更新DNS记录模块</li>
                </ol>

                <div class="clear"></div>
                {if !$rdnsid}
                    {if  $rdnsapps}<br>
                        <a onclick="$('#blank_pdu').hide();
                    $('#add_pdu').show();
                    return false;" class="new_control" href="#"><span class="addsth"><strong>选择与反向解析一同使用的DNS应用程序</strong></span></a>
                    {/if}
                    <div class="clear"></div>            
                {/if}

            </div>
        </div>
    </div>
</div><!-- reverse DNS -->
<div class="pagecont" style="display:none">
    {include file="ajax.auditlogs.tpl" }
</div>
{if $action=='default' && $showall && $group}
    {literal}
        <script>$(document).ready(function() {{/literal}
                    groupDetails('{$group.id}')
        {literal}  });</script>{/literal}
    {/if}