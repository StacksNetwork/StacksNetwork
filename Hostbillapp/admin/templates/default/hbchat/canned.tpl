{if !$do}

{if $categories}

<div class="blu"><strong><a href="?cmd=hbchat&action=canned">响应回放</a> </strong></div>
<div class="nicerblu">
    <table cellspacing="0" cellpadding="3" width="100%" class="whitetable">
        <tbody>
            <tr>
                <th>分类</th>
                <th width="20"></th>
                <th width="20"></th>
            </tr>
            {foreach from=$categories item=d name=fl}
            <tr class="{if $smarty.foreach.fl.index%2==0}even{/if} havecontrols">
                <td><a href="?cmd=hbchat&action=canned&do=category&id={$d.id}">{$d.name}</a> <em>({$d.cnt} 响应)</em> </td>
                <td >
                    <a class="editbtn" href="?cmd=hbchat&action=canned&do=edit_category&id={$d.id}">编辑</a></td>
                <td class="lastitm">
                    <a onclick="return confirm('您确定需要删除该分类吗?');" class="delbtn" href="?cmd=hbchat&action=canned&make=delete&id={$d.id}&security_token={$security_token}">删除</a>
                </td>
            </tr>
            {/foreach}
            <tr>
                <th colspan="3" align="left">
                    <a href="?cmd=hbchat&action=canned&do=add_category" class="editbtn">添加新分类</a>
                </th>
            </tr>
        </tbody>
    </table>
</div>
{else}
<div class="blank_state blank_news">
    <div class="blank_info">
        <h1>响应回放 - 添加分类</h1>
        为了让员工更效率 - 使用响应回放. 为了更方便的使用进行分类.
        <div class="clear"></div>
        <a style="margin-top:10px" href="?cmd=hbchat&action=canned&do=add_category" class="new_add new_menu">
            <span>添加响应回放分类</span></a>
        <div class="clear"></div>
    </div>
</div>
{/if}
{elseif $do=='category'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">响应回放</a> &raquo;{$category.name}</strong></div>

{if $category.responses}
<div class="nicerblu">
    
<table cellspacing="0" cellpadding="3" width="100%" class="whitetable">
        <tbody>
            <tr>
                <th width="20"></th>
                <th width="70">Usability</th>
                <th>响应</th>
                <th width="20"></th>
                <th width="20"></th>
            </tr>
            {foreach from=$category.responses item=d name=fl}
            <tr class="{if $smarty.foreach.fl.index%2==0}even{/if} havecontrols">
                <td><div class="favico_off {if $d.fav!='0'}favico_on{/if}" rel="{$d.id}"></div></td>
                <td>{$d.usable} %</td>
                <td><a href="?cmd=hbchat&action=canned&do=edit&id={$d.id}">{$d.title}</a></td>
                <td >
                    <a class="editbtn" href="?cmd=hbchat&action=canned&do=edit&id={$d.id}">编辑</a></td>
                <td class="lastitm">
                    <a onclick="return confirm('您确定需要删除该响应内容吗?');" class="delbtn" href="?cmd=hbchat&action=canned&do=category&make=delete&id={$category.id}&response_id={$d.id}&security_token={$security_token}">删除</a>
                </td>
            </tr>
            {/foreach}
            <tr>
                <th colspan="5" align="left">
                    <a href="?cmd=hbchat&action=canned&do=add&category_id={$category.id}" class="editbtn">添加新的响应</a>
                </th>
            </tr>
        </tbody>
    </table>
    
</div>
{literal}
<script type="text/javascript">
    function toggleFav() {
        $('.favico_off').click(function(){
            var t = $(this).hasClass('favico_on') ? 0:1;
            $(this).toggleClass('favico_on');
            ajax_update('?cmd=hbchat&action=updatecannedfav',{id:$(this).attr('rel'),fav:t});
        });
    }
    appendLoader('toggleFav');
</script>
{/literal}
{else}
<div class="blank_state blank_news">
    <div class="blank_info">
        <h1>响应回放 - 添加响应</h1>
        该分类没有任何响应内容被添加.
        <div class="clear"></div>
        <a style="margin-top:10px" href="?cmd=hbchat&action=canned&do=add&category_id={$category.id}" class="new_add new_menu">
            <span>添加响应回放</span></a>
        <div class="clear"></div>
    </div>
</div>
{/if}



{elseif $do=='add' || $do=='edit'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">响应回放</a> &raquo;  <a href="?cmd=hbchat&action=canned&do=category&id={$category.id}">{$category.name}</a>&raquo;
        {if $do=='add'}
        添加新的响应内容
        {else}
        {$response.name}
        {/if}
    </strong></div>
<div class="nicerblu"><form id="submitform" method="post" action="">
        <input type="hidden" name="make" value="{$do}"/>
        <table width="600" cellspacing="0" cellpadding="6">
            <tbody  class="sectioncontent">

                <tr >
                    <td width="160" align="right"><strong>主题</strong></td>
                    <td class="editor-container">
                        <input type="text"  style="font-size: 16px !important; font-weight: bold;" size="50" value="{$response.title}" class="inp" name="title">
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right" valign="top" ><strong>信息</strong></td>
                    <td class="editor-container">
                        <textarea id="prod_desc" style="width:99%;" rows="6" cols="100" class="inp wysiw_editor" name="body">{$response.body}</textarea>
                       
                    </td>
                </tr>
               
                <tr >
                    <td width="160" align="right"><strong>分类</strong></td>
                    <td class="editor-container">
                        <select name="category_id" class="inp styled" >
                            {foreach from=$categories item=td}
                            <option value="{$td.id}" {if $td.id==$category.id}selected="selected"{/if} >{$td.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                
                <tr><td colspan="2"></td></tr>
                <tr><td colspan="2"><a onclick="$('#submitform').submit();return false;" href="#" class="new_dsave new_menu">
                            <span>保存更改</span>
                        </a></td></tr>
            </tbody>
        </table>
        
        {securitytoken}</form></div>

{elseif $do=='add_category' || $do=='edit_category'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">响应回放</a> &raquo;
        {if $do=='add_category'}
        添加新分类
        {else}
        {$category.name}
        {/if}
    </strong></div>

<div class="nicerblu"><form id="submitform" method="post" action="">
        <input type="hidden" name="make" value="{$do}"/>
        <table width="100%" cellspacing="0" cellpadding="6">
            <tbody  class="sectioncontent">
                <tr >
                    <td width="160" align="right"><strong>名称</strong></td>
                    <td class="editor-container">
                        <input type="text"  style="font-size: 16px !important; font-weight: bold;" size="50" value="{$category.name}" class="inp" name="name">
                    </td>
                </tr>

                <tr><td colspan="2"></td></tr>
                <tr><td colspan="2"><a onclick="$('#submitform').submit();return false;" href="#" class="new_dsave new_menu">
                            <span>保存更改</span>
                        </a></td></tr>
            </tbody>
        </table>
        {securitytoken}</form></div>

{/if}