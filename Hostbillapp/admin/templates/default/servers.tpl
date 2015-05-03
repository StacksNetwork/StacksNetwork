<script type="text/javascript" src="{$template_dir}js/server.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2"><h3>{$lang.apps}</h3></td>    
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=servers"  class="tstyled {if $action == 'default' || $action == 'edit'  || $action == 'group'}selected{/if}">{$lang.manapps}</a>
            <a href="?cmd=servers&action=add"  class="tstyled {if $action == 'add'}selected{/if}">{$lang.addnewapp}</a>
            <a href="?cmd=servers&action=monitor"  class="tstyled {if $action == 'monitor'}selected{/if}">{$lang.servermonitor}</a>
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                {if $action=='add'}
                    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js?v={$hb_version}"></script>
                    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
                    <form method="post" action="" id="serverform">
                        <input type="hidden" value="add" name="make"/>
                        {if $group} <input type="hidden" value="{$group.id}" name="group_id"/>{/if}
                        <div class="blu"> 
                            <a href="?cmd=servers" ><strong>{$lang.manapps}</strong></a> {if $group}&raquo; <a href="?cmd=servers&action=group&group={$group.id}"><strong>{$group.name}</strong></a>{/if} &raquo; <strong>{$lang.addnewapp}</strong>

                        </div>
                        {if $group}<input type="hidden" name="default_module" value="{$group.module}" id="default_module"  />{/if}
                        <div class="lighterblue" style="padding: 5px 20px">
                            <table border="0" cellpadding="0" cellspacing="6" width="100%">
                                <tr>
                                    {if !$group}
                                        <td width="165" align="right" >
                                            <strong>{$lang.application}:</strong></td>
                                        <td>
                                            <select name="default_module" onchange="loadMod(this)" id="modulepicker" class="inp" style="width:200px;">
                                                <option value="0" {if !$setmodule}selected="selected"{/if} >{$lang.none}</option>
                                                {foreach from=$modules item=mod}{if $mod.id!='-1'}
                                                        <option value="{$mod.id}" {if $setmodule==$mod.id}selected="selected"{/if}>{$mod.module}</option>
                                                    {/if}
                                                {/foreach}
                                                <option value="new" style="font-weight:bold">显示未激活模块</option>
                                            </select>
                                        </td>
                                    {/if}
                                </tr>
                                <tr>
                                    <td align="right" width="165"><strong>{$lang.Name}</strong></td>
                                    <td style="white-space: nowrap; width: 500px">
                                        <input style="font-size: 16px ! important; font-weight: bold;" name="name" size="40" class="inp"/> 
                                        <span style="margin-left: 30px">
                                            <a class="new_control" href="#" id="testing_button" {if !$group && !$setmodule}style="display: none"{/if} onclick="testConfiguration();
                                                    return false;">
                                                <span class="wizard">{$lang.test_configuration}</span>
                                            </a>
                                        </span>
                                    </td>
                                    <td id="testing_result">

                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div id="config_contain" class="lighterblue" style="padding: 5px 20px;">
                            {include file='ajax.servers.tpl' action='get_fields'}		
                        </div>

                        <div class="lighterblue" style="padding:10px;">
                            <center>
                                <input type="submit" class="submitme" value="{$lang.addnewapp}"/> <span class="orspace">或 <a href="?cmd=servers" class="editbtn">{$lang.Cancel}</a></span>
                            </center>
                        </div>
                        {securitytoken}
                    </form>
                {elseif $action=='edit' && $server}
                    <form method="post" action="" id="serverform">
                        <input type="hidden" value="update" name="make"/>
                        <input type="hidden" id="default_module" name="default_module" value="{$server.default_module}"/>
                        <input type="hidden" name="oldgroup" value="{$server.group_id}"/>
                        <div class="blu"> 
                            <a href="?cmd=servers" ><strong>{$lang.manapps}</strong></a> &raquo; <a href="?cmd=servers&action=group&group={$server.group_id}"><strong>{$server.group_name}</strong></a> &raquo; <strong>{$server.name}</strong>

                        </div>
                        <div  class="lighterblue" style="padding: 5px 20px;">
                            <table border="0" cellpadding="6" cellspacing="0" width="100%">           
                                <tr>
                                    <td align="right" width="165">
                                        <strong>{$lang.Name}</strong>
                                    </td>
                                    <td style="white-space: nowrap; width: 500px">
                                        <input style="font-size: 16px ! important; font-weight: bold;" value="{$server.name}" name="name" size="40" class="inp"/> 
                                        <span style="margin-left: 30px">{*
                                            *}<a class="new_control" href="#" id="testing_button"  onclick="testConfiguration();
                                                    return false;">{*
                                                *}<span class="wizard">{$lang.test_configuration}</span>{*
                                                *}</a>
                                        </span>
                                    </td>
                                    <td id="testing_result">

                                    </td>
                                </tr>			
                            </table>
                        </div>
                        <div id="config_contain" class="lighterblue" style="padding: 5px 20px;">
                            {include file='ajax.servers.tpl' action='get_fields'}

                            {if $server.type=='Domain'}
                                <input type="hidden" name="group_id" value="{$server.group_id}" />
                            {else}
                                <div class="sectionhead" style="margin-top:10px;">{$lang.moreoptions}  <a href="" class="editbtn" onclick="$(this).hide();
                                        $('#mo-settings').show();
                                        return false;">{$lang.expand}</a></div>
                                <div id="mo-settings" style="display:none">

                                    <table border="0" cellpadding="6" width="100%">
                                        <tr><td width="165" align="right">
                                                <strong>{$lang.Category}</strong>
                                            </td>
                                            <td>
                                                <select name="group_id" class="inp">
                                                    {foreach from=$groups item=gr}
                                                        <option value="{$gr.id}" {if $gr.id==$server.group_id}selected="selected"{/if}>{$gr.name}</option>
                                                    {/foreach}
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            {/if}
                        </div>


                        <div class="lighterblue" style="padding:5px">
                            <center>
                                <input type="submit" style="font-weight:bold" value="{$lang.savechanges}" class="submitme"/>
                                <span class="orspace">{$lang.Or} <a href="?cmd=servers&action=group&group={$server.group_id}" class="editbtn">{$lang.Cancel}</a></span>
                            </center>
                        </div>
                        {securitytoken}
                    </form>

                {elseif $action=='monitor'}
                    <script type="text/javascript">
                        {literal}
                            function hidme(el) {
                                if ($(el).is(':checked')) {
                                    $('.hidme').show();
                                }
                                else
                                    $('.hidme').hide();
                            }
                        {/literal}
                    </script>
                    <div class="blu">
                        <form action="" method="post">
                            <table border="0" cellpadding="6" cellspacing="0">
                                <tr>
                                    <td><input type="checkbox" name="NETSTAT" value="1" {if $config.NETSTAT} checked='checked'{/if} onclick="hidme(this);"/> <strong>{$lang.NETSTAT}	</strong>	<br />
                                    </td>
                                    <td rowspan="2" valign="top"> <input type="submit" value="{$lang.changeconfig}" style="font-weight:bold;padding:5px;"/></td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="hidme" {if !$config.NETSTAT}style="display:none"{/if}>
                                            <input type="hidden" name="make" value="updateconfig" />				

                                            <input type="checkbox" name="FTP" value="1" {if $config.FTP} checked='checked'{/if} /> {$lang.FTP}
                                            <input type="checkbox" name="HTTP" value="1" {if $config.HTTP} checked='checked'{/if} /> {$lang.HTTP}
                                            <input type="checkbox" name="SSH" value="1" {if $config.SSH} checked='checked'{/if} /> {$lang.SSH}
                                            <input type="checkbox" name="POP3" value="1" {if $config.POP3} checked='checked'{/if} /> {$lang.POP3}
                                            <input type="checkbox" name="MYSQL" value="1" {if $config.MYSQL} checked='checked'{/if} /> {$lang.MYSQL}
                                            <input type="checkbox" name="IMAP" value="1" {if $config.IMAP} checked='checked'{/if} /> {$lang.IMAP}
                                            <input type="checkbox" name="LOAD" value="1" {if $config.LOAD} checked='checked'{/if} /> {$lang.LOAD}
                                            <input type="checkbox" name="UPTIME" value="1" {if $config.UPTIME} checked='checked'{/if} /> {$lang.UPTIME}<br />
                                        </div>
                                    </td>
                                </tr>

                            </table>

                            {securitytoken}
                        </form>
                    </div>
                    {if $servers}
                        <div class="lighterblue hidme" style="padding:5px;{if !$config.NETSTAT}display:none{/if}">

                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                <tr>
                                    <th width="30%">{$lang.Name}</th>               
                                    {if $config.FTP}<th>{$lang.FTP}</th>{/if}
                                    {if $config.SSH}<th>{$lang.SSH}</th>{/if}
                                    {if $config.HTTP}<th>{$lang.HTTP}</th>{/if}
                                    {if $config.POP3}<th>{$lang.POP3}</th>{/if}
                                    {if $config.IMAP}<th>{$lang.IMAP}</th>{/if}
                                    {if $config.MYSQL}<th>{$lang.MYSQL}</th>{/if}
                                    {if $config.LOAD}<th>{$lang.LOAD}</th>{/if}
                                    {if $config.UPTIME}<th>{$lang.UPTIME}</th>{/if}
                                </tr>
                                {foreach from=$servers item=server}
                                    <tr class="toloads" id="{$server.id}">
                                        <td width="30%"><img src="{$template_dir}img/ajax-loading2.gif" /><strong><a href="?cmd=servers&action=edit&id={$server.id}">{$server.name}</a></strong></td>
                                        {if $config.FTP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.SSH}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.HTTP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.POP3}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.IMAP}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.MYSQL}<td><img src="{$template_dir}img/bullet_white.gif" /></td>{/if}
                                        {if $config.LOAD}<td>-</td>{/if}
                                        {if $config.UPTIME}<td>-</td>{/if}

                                    </tr>
                                {/foreach}
                            </table>
                            <script type="text/javascript">appendLoader('loadStatuses');</script>
                        </div>
                    {/if}
                {elseif $action=='group'}
                    <div class="blu">
                        <div class="right">
                            <div class="pagination"></div>
                        </div>
                        <form action="" method="post" id="editgr">
                            <input type="hidden" name="make" value="editgroup" />

                            <a href="?cmd=servers" ><strong>{$lang.manapps}</strong></a> &raquo; <span id="orgline"><strong>{$group.name}</strong> <a href="#" class="editbtn" onclick="$('#orgline').hide();
                                    $('#editline').show();
                                    return false">{$lang.Edit}</a></span>
                            <span class="editline" style="display:none" id="editline">
                                <span class="editor-line">
                                    <input name="name" style="height: 15px;width:150px;background:#ffffff;" value="{$group.name}" class="inp"/>
                                    <a href="#" class="savebtn" onclick="$('#editgr').submit();
                                            return false;"  style="top:0px;right:6px;">保存更改</a>
                                </span>
                                <a href="#" class="editbtn" onclick="$('#orgline').show();
                                        $('#editline').hide();
                                        return false">{$lang.Cancel}</a>
                            </span>
                            {securitytoken}
                        </form>            
                    </div>

                    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                    <a href="?cmd={$cmd}&action={$action}&group={$group.id}" id="currentlist" style="display:none" updater="#updater"></a>

                    {if $servers}
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                            <thead>
                                <tr>
                                    <th width="20" style="display:none" class="frow_"></th>
                                    <th width="30%"><a href="?cmd={$cmd}&action=group&group={$group.id}&orderby=name|ASC"  class="sortorder">{$lang.Name}</a></th>
                                    <th width="10%">{if $group.type=='Domain'}{$lang.Domains}{else}{$lang.Users}{/if}</th>
                                    <th width="25%">{if $group.type!='Domain'}<a href="?cmd={$cmd}&action=group&group={$group.id}&orderby=ip|ASC"  class="sortorder">IP</a>{/if}</th>
                                    <th>{if $group.type!='Domain'}<a href="?cmd={$cmd}&action=group&group={$group.id}&orderby=host|ASC"  class="sortorder">{$lang.Host}</a>{/if}</th>
                                    <th></th>
                                    <th width="100"></th>
                                    <th width="20"></th><th width="20"></th>
                                </tr>
                            </thead>
                            <tbody id="updater">
                                {include file='ajax.servers.tpl'}
                            </tbody>
                            <tbody id="psummary">
                                <tr>
                                    <th>
                                        {if $group.type!='Domain'}		
                                            <a href="?cmd=servers&action=add&group={$group.id}" class="editbtn">{$lang.addnewserver}</a>
                                            &nbsp;&nbsp;<a href="#" class="editbtn editgray" onclick="$('.frow_').toggle();
                                                    return false;" style="font-weight:normal">{$lang.changedefault}</a>

                                        {/if}
                                    </th>
                                    <th colspan="7" style="text-align: right">
                                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span> 
                                    </th>
                                </tr>
                            </tbody>
                        </table>
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    {else}
                        <div class="blank_state blank_news">
                            <div class="blank_info">
                                <h1>{$lang.bs3}</h1>
                                <div class="clear"></div>

                                <a class="new_add new_menu" href="?cmd=servers&action=add&group={$group.id}" style="margin-top:10px">
                                    <span>{$lang.addnewapp}</span></a>
                                <div class="clear"></div>
                            </div>
                        </div>
                    {/if}
                {elseif $action=='default'}
                    {if !$servers}
                        <div class="blank_state blank_news">
                            <div class="blank_info">
                                <h1>{$lang.bs1}</h1>
                                {$lang.bs2}
                                <div class="clear"></div>

                                <a class="new_add new_menu" href="?cmd=servers&action=add" style="margin-top:10px">
                                    <span>{$lang.addnewapp}</span></a>
                                <div class="clear"></div>
                            </div>
                        </div>
                    {else}
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <strong>{$lang.manapps}</strong>
                        </div>
                        <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                        <a href="?cmd={$cmd}" id="currentlist" style="display:none" updater="#updater"></a>
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                            <thead>
                                <tr>
                                    <th ><a href="?cmd={$cmd}&orderby=name|ASC"  class="sortorder">{$lang.Name}</a></th>
                                    <th ><a href="?cmd={$cmd}&orderby=module|ASC"  class="sortorder">{$lang.application}</a></th>
                                    <th >{$lang.Servers}</th>
                                    <th width="20"></th>
                                    <th width="20"></th>
                                </tr>
                            </thead>
                            <tbody id="updater">
                                {include file='ajax.servers.tpl'}
                            </tbody>
                            <tbody id="psummary">
                                <tr>
                                    <th><a href="?cmd=servers&action=add" class="editbtn">{$lang.addnewapp}</a></th>
                                    <th colspan="4" style="text-align: right">
                                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                    </th>
                                </tr>
                            </tbody>
                        </table>
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <div class="clear"></div>
                        </div>
                    {/if}
                {/if}
            </div>
        </td>
    </tr>
</table>
