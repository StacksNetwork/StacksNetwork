{if $action=="default"}
{if $agreements}
    <form>
    <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
    <div class="blu">
        <div class="right"><div class="pagination"></div></div>
        <a href="?cmd={$cmd}&action=invite" class="new_control">
            <span class="addsth">
                <strong>{$lang.add_new_invite}</strong>
            </span>
        </a>
        
        <div class="clear"></div>
    </div>   
    <a href="?cmd={$cmd}&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
    </form>
    <table cellspacing="0" cellpadding="7" border="0" width="100%" class="glike hover">
        <thead><tr>
                <th>{$lang.name}</th>
                <th>{$lang.tag}</th>
                <th>{$lang.url}</th>
                <th>{$lang.status}</th>
                <th>{$lang.actions}</th>
            </tr>
        </thead>
        <tbody id="updater">
            {foreach from=$agreements item=agreement}
                <tr>
                    <td>{$agreement.name}</td>
                    <td>{$agreement.tag}</td>
                    <td>{$agreement.sharing_url}</td>
                    <td>{$lang[$agreement.status]}</td>
                    <td>
                    {assign value="0" var=showaccept} 
                    {foreach from=$agreement.actions item=status name=actions}{*
                        *}{assign value="to_`$status`" var=prefact}{*
                       
                        *}<a class="menuitm {if $smarty.foreach.actions.first && $smarty.foreach.actions.last}" style="margin-left: 4px;{elseif $smarty.foreach.actions.first}menuf{elseif $smarty.foreach.actions.last}menul{/if}" 
                        {if $status =='accepted'}{assign value="1" var=showaccept} onclick="$('#h{$agreement.uuid}').fadeToggle();$(this).toggleClass('activated'); return false;" {elseif $status =='delete'}onclick="return confirm('{$lang.areyousure}')"{/if}
                           href="?cmd={$cmd}&action={$action}&changestatusto={$status}&uuid={$agreement.uuid}&security_token={$security_token}">{$lang.$prefact}</a>{*
                    *}{/foreach}
                    </td>
                </tr>
            {if $showaccept =='1'}
                <tr id="h{$agreement.uuid}" style="display:none">
                    <td colspan="20" style="text-align: right">
                        <form action="?cmd={$cmd}&action=accept" method="post">
                            <input type="hidden" name="uuid" value="{$agreement.uuid}" />
                            <div style="padding-right: 40px">
                                <label style="margin-right: 10px">
                                    {$lang.tag}<a class="vtip_description" title="{$lang.tag_desc}" ></a>&nbsp;
                                    <input type="text" name="tag" value="{if $submit.tag}{$submit.tag}{elseif $agreement.tag}{$agreement.tag}{else}{$tag}{/if}" />
                                </label> 
                                <label style="margin-right: 10px">
                                    {$lang.department}<a class="vtip_description" title="{$lang.dept_desc}" ></a>&nbsp;
                                    <select name="department_id">
                                    {foreach from=$departments item=dept}
                                        <option {if $submit.department_id == $dept.id }selected="selected"{elseif $agreement.department_id ==$dept.id }selected="selected{/if} value="{$dept.id}">{$dept.name}</option>
                                    {/foreach}
                                    </select>
                                </label>
                                    
                                <input type="submit" name="save" value="{$lang.Accept}" />
                            </div>
                        {securitytoken}
                        </form>
                        
                    </td>
                </tr>
            {/if}
            {/foreach}
        </tbody>
        <tbody id="psummary">
            <tr>
                <th colspan="92">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
    </table>
    <div class="nicerblu">
        <div class="shownice tabb" style="margin:2em 10px; padding:1em"> 
        <strong>Sharing url:</strong>
        <input type="text" value="{$sharing_url}" readonly="readonly" style="background:none;border:none; width:50%" onclick="this.select();"></br>
        <small>您的服务器没有开启 mod_rewrite 让你可以接收任何URL 或 接受协议 <a target="_blank" class="external" href="http://wiki.hostbillapp.com/index.php?title=Ticket_Sharing_requirements">工单共享要求</a></small>
        </div>
    </div>  
    {* <strong>{$lang.nothingtodisplay}</strong> *}
{else}
    <div class="blank_state blank_services">
        <div class="blank_info">
            <h1>连接多家厂商 & 协助部门</h1>
           您可以通过系统轻松简单的连接多个供应商或者服务协助部门.<br />
            如果你想邀请您的协助部门请共享下面的链接 {$sharing_url}
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd={$cmd}&action=invite" class="new_add new_menu">
                <span>邀请其它协助部门</span>
            </a>
            <div class="clear"></div>
        </div>
    </div>
{/if}
{elseif $action=='accept'}
    <form action="" method="post">
        <div class="lighterblue2">
            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                <tr> 
                    <td style="width: 160px" align="right">{$lang.tag} <a class="vtip_description" title="{$lang.tag_desc}" ></a></td>
                    <td> <input type="text" name="tag" value="{if $submit.tag}{$submit.tag}{else}{$tag}{/if}" /> </td>
                </tr>
                <tr>
                    <td align="right">{$lang.department} <a class="vtip_description" title="{$lang.dept_desc}" ></a></td>
                    <td>
                        <select name="department_id">
                        {foreach from=$departments item=dept}
                            <option {if $submit.department_id == $dept.id}selected="selected"{/if} value="{$dept.id}">{$dept.name}</option>
                        {/foreach}
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="blu">	
            <table border="0" cellpadding="2" cellspacing="0" >
                <tr>
                    <td><a href="?cmd={$cmd}"><strong>&laquo; {$lang.backto} {$lang.agreements}</strong></a>&nbsp;</td>
                    <td><input type="submit" name="save" value="{$lang.Accept}" style="font-weight:bold;"/></td>                            
                </tr>
            </table>
            {securitytoken}
        </div>
    </form>
{elseif $action=='invite'}
    <form action="" method="post">
        <div class="lighterblue2" style="min-height: 240px">
            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                <tr>
                    <td align="right" width="15%"><strong>{$lang.name}:</strong></td>
                    <td><input type="text" value="{if $submit.name}{$submit.name}{else}{$business_name}{/if}" name="name"/> </td>
                </tr>
                <tr>
                    <td align="right">{$lang.shareurl} <a class="vtip_description" title="{$lang.sharingurl_desc}" ></a></td>
                    <td><input type="text" name="sharing_url" size="64" value="{$submit.sharing_url}" /></td>
                </tr>
                <tr> 
                    <td align="right">{$lang.tag} <a class="vtip_description" title="{$lang.tag_desc}" ></a></td>
                    <td> <input type="text" name="tag" value="{if $submit.tag}{$submit.tag}{else}{$business_name|truncate:8:''}{/if}" /> </td>
                </tr>
                <tr>
                    <td align="right">{$lang.department} <a class="vtip_description" title="{$lang.dept_desc}" ></a></td>
                    <td>
                        <select name="department_id">
                        {foreach from=$departments item=dept}
                            <option {if $submit.department_id == $dept.id}selected="selected"{/if} value="{$dept.id}">{$dept.name}</option>
                        {/foreach}
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="blu">	
            <table border="0" cellpadding="2" cellspacing="0" >
                <tr>
                    <td><a href="?cmd={$cmd}"><strong>&laquo; {$lang.backto} {$lang.agreements}</strong></a>&nbsp;</td>
                    <td><input type="submit" name="save" value="{$lang.invite}" style="font-weight:bold;"/></td>                            
                </tr>
            </table>
        </div>
        {securitytoken}
    </form>
{/if}