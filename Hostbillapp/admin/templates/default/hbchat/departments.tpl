<div class="newhorizontalnav clear">
    <div class="list-2">
        <div class="haveitems">
            <ul>
                <li {if !$do}class="picked"{/if}><a href="?cmd=hbchat&action=departments">部门列表</a></li>
                <li {if $do=='add'}class="picked"{/if}><a  href="?cmd=hbchat&action=departments&do=add">添加新部门</a></li>
            </ul>
        </div>
    </div>
</div>
<div  class="nicerblu">
    {if $do=='add' || $do=='edit'}
    <form action="" method="post" id="submitform">
        <input type="hidden" name="make" value="{$do}"/>
<table width="100%" cellspacing="0" cellpadding="6">
                <tbody  class="sectioncontent">

                    <tr >
                        <td width="160" align="right"><strong>名称</strong></td>
                        <td class="editor-container">
                            <input type="text"  style="font-size: 16px !important; font-weight: bold;" size="50" value="{$department.name}" class="inp" name="name">
                        </td>
                    </tr>
                    <tr>
                        <td width="160" align="right" valign="top" ><strong>说明</strong></td>
                        <td class="editor-container">
                            {if $product.description!=''}
                                <textarea id="prod_desc" style="width:99%;" rows="6" cols="100" class="inp wysiw_editor" name="description">{$department.description}</textarea>
                            {else}
                                <a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                                <div id="prod_desc_c" style="display:none"> <textarea id="prod_desc" style="width:99%;" rows="6" cols="100" class="inp wysiw_editor" name="description">{$department.description}</textarea></div>
                           {/if}
                        </td>
                    </tr>
                     <tr >
                        <td width="160" align="right"><strong>指定人员</strong></td>
                        <td class="editor-container">
                            {foreach from=$staff item=s}
                                <input type="checkbox" name="admins[]" value="{$s.id}" {if $department.admins[$s.id]}checked="checked"{/if} /> {$s.firstname} {$s.lastname} <br/>
                            {/foreach}
                        </td>
                    </tr>
                    <tr >
                        <td width="160" align="right"><strong>界面语言</strong></td>
                        <td class="editor-container">
                            <select name="language_id" class="inp styled" style="text-transform:capitalize">
                               {foreach from=$langs item=td}{if $td.status!='1' || $td.target!='user'}{continue}{/if}
                               <option value="{$td.id}" {if $td.id==$department.language_id}selected="selected"{/if} style="text-transform:capitalize">{$td.name}</option>
                               {/foreach}
                           </select>
                        </td>
                    </tr>
                     <tr >
                         <td width="160" align="right" valign="top"><strong>显示离线状态 <a title="这个选项和部门离线聊天图标将显示允许留言" class="vtip_description"></a></strong></td>
                        <td class="editor-container">
                           <input type="checkbox" name="options[]" value="1" {if $department.options & 1 || !$department}checked="checked"{/if} /> <br/>
                           {if $tdepts}留下信息将开启服务工单:
                           <select name="ticket_dept_id" class="inp styled">
                               {foreach from=$tdepts item=td}
                               <option value="{$td.id}" {if $td.id==$department.ticket_dept_id}selected="selected"{/if}>{$td.name}</option>
                               {/foreach}
                           </select>
                           {else}
                           <input type="hidden" name="ticket_dept_id" value="0" />
                           Please configure <a href="?cmd=ticketdepts&action=add">ticket department</a> 留下离线信息
                           {/if}
                        </td>
                    </tr>
                    <tr><td colspan="2"></td></tr>
                    <tr><td colspan="2"><a onclick="$('#submitform').submit();return false;" href="#" class="new_dsave new_menu">
                        <span>保存修改</span>
                        </a></td></tr>
                </tbody>
</table>
        {securitytoken}

    </form>

    {else}


      {if !$departments}
                <div class="blank_state blank_news">
                    <div class="blank_info">
                        <h1>首先建立部门</h1>
                        聊天的员工可以被分配到部门- 创建一个部门在使用LiveChat之前.
                        <div class="clear"></div>
                        <a style="margin-top:10px" href="?cmd=hbchat&action=departments&do=add" class="new_add new_menu">
                            <span>添加新的聊天部门</span></a>
                        <div class="clear"></div>
                    </div>
                </div>
            {else}

            <table cellspacing="0" cellpadding="3" width="100%" class="whitetable">
                <tbody>
                    <tr>
                        <th>部门</th>
                        <th width="20"></th>
                        <th width="20"></th>
                    </tr>
                    {foreach from=$departments item=d name=fl}
                     <tr class="{if $smarty.foreach.fl.index%2==0}even{/if} havecontrols">
                        <td><a href="?cmd=hbchat&action=departments&do=edit&id={$d.id}">{$d.name}</a></td>
                        <td >
                            <a class="editbtn" href="?cmd=hbchat&action=departments&do=edit&id={$d.id}">编辑</a></td>
                        <td class="lastitm">
                            <a onclick="return confirm('您确定需要删除该部门吗?');" class="delbtn" href="?cmd=hbchat&action=departments&make=delete&id={$d.id}&security_token={$security_token}">删除</a>
                        </td>
                    </tr>
                    {/foreach}
                </tbody>
            </table>

            {/if}

    {/if}
</div>