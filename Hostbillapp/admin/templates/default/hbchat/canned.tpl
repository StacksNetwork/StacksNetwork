{if !$do}

{if $categories}

<div class="blu"><strong><a href="?cmd=hbchat&action=canned">Canned Responses</a> </strong></div>
<div class="nicerblu">
    <table cellspacing="0" cellpadding="3" width="100%" class="whitetable">
        <tbody>
            <tr>
                <th>Category</th>
                <th width="20"></th>
                <th width="20"></th>
            </tr>
            {foreach from=$categories item=d name=fl}
            <tr class="{if $smarty.foreach.fl.index%2==0}even{/if} havecontrols">
                <td><a href="?cmd=hbchat&action=canned&do=category&id={$d.id}">{$d.name}</a> <em>({$d.cnt} responses)</em> </td>
                <td >
                    <a class="editbtn" href="?cmd=hbchat&action=canned&do=edit_category&id={$d.id}">Edit</a></td>
                <td class="lastitm">
                    <a onclick="return confirm('Are you sure you want to remove this category?');" class="delbtn" href="?cmd=hbchat&action=canned&make=delete&id={$d.id}&security_token={$security_token}">Delete</a>
                </td>
            </tr>
            {/foreach}
            <tr>
                <th colspan="3" align="left">
                    <a href="?cmd=hbchat&action=canned&do=add_category" class="editbtn">Add new category</a>
                </th>
            </tr>
        </tbody>
    </table>
</div>
{else}
<div class="blank_state blank_news">
    <div class="blank_info">
        <h1>Canned responses - add category</h1>
        To make staff work faster - use canned responses. For more convenient usage divide them into categories.
        <div class="clear"></div>
        <a style="margin-top:10px" href="?cmd=hbchat&action=canned&do=add_category" class="new_add new_menu">
            <span>Add canned responses category</span></a>
        <div class="clear"></div>
    </div>
</div>
{/if}
{elseif $do=='category'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">Canned Responses</a> &raquo;{$category.name}</strong></div>

{if $category.responses}
<div class="nicerblu">
    
<table cellspacing="0" cellpadding="3" width="100%" class="whitetable">
        <tbody>
            <tr>
                <th width="20"></th>
                <th width="70">Usability</th>
                <th>Response</th>
                <th width="20"></th>
                <th width="20"></th>
            </tr>
            {foreach from=$category.responses item=d name=fl}
            <tr class="{if $smarty.foreach.fl.index%2==0}even{/if} havecontrols">
                <td><div class="favico_off {if $d.fav!='0'}favico_on{/if}" rel="{$d.id}"></div></td>
                <td>{$d.usable} %</td>
                <td><a href="?cmd=hbchat&action=canned&do=edit&id={$d.id}">{$d.title}</a></td>
                <td >
                    <a class="editbtn" href="?cmd=hbchat&action=canned&do=edit&id={$d.id}">Edit</a></td>
                <td class="lastitm">
                    <a onclick="return confirm('Are you sure you want to remove this response?');" class="delbtn" href="?cmd=hbchat&action=canned&do=category&make=delete&id={$category.id}&response_id={$d.id}&security_token={$security_token}">Delete</a>
                </td>
            </tr>
            {/foreach}
            <tr>
                <th colspan="5" align="left">
                    <a href="?cmd=hbchat&action=canned&do=add&category_id={$category.id}" class="editbtn">Add new response</a>
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
        <h1>Canned responses - add response</h1>
        This category dont have any responses added to it yet.
        <div class="clear"></div>
        <a style="margin-top:10px" href="?cmd=hbchat&action=canned&do=add&category_id={$category.id}" class="new_add new_menu">
            <span>Add new canned response</span></a>
        <div class="clear"></div>
    </div>
</div>
{/if}



{elseif $do=='add' || $do=='edit'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">Canned Responses</a> &raquo;  <a href="?cmd=hbchat&action=canned&do=category&id={$category.id}">{$category.name}</a>&raquo;
        {if $do=='add'}
        Add new response
        {else}
        {$response.name}
        {/if}
    </strong></div>
<div class="nicerblu"><form id="submitform" method="post" action="">
        <input type="hidden" name="make" value="{$do}"/>
        <table width="600" cellspacing="0" cellpadding="6">
            <tbody  class="sectioncontent">

                <tr >
                    <td width="160" align="right"><strong>Subject</strong></td>
                    <td class="editor-container">
                        <input type="text"  style="font-size: 16px !important; font-weight: bold;" size="50" value="{$response.title}" class="inp" name="title">
                    </td>
                </tr>
                <tr>
                    <td width="160" align="right" valign="top" ><strong>Message</strong></td>
                    <td class="editor-container">
                        <textarea id="prod_desc" style="width:99%;" rows="6" cols="100" class="inp wysiw_editor" name="body">{$response.body}</textarea>
                       
                    </td>
                </tr>
               
                <tr >
                    <td width="160" align="right"><strong>Category</strong></td>
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
                            <span>Save Changes</span>
                        </a></td></tr>
            </tbody>
        </table>
        
        {securitytoken}</form></div>

{elseif $do=='add_category' || $do=='edit_category'}
<div class="blu"><strong><a href="?cmd=hbchat&action=canned">Canned Responses</a> &raquo;
        {if $do=='add_category'}
        Add new category
        {else}
        {$category.name}
        {/if}
    </strong></div>

<div class="nicerblu"><form id="submitform" method="post" action="">
        <input type="hidden" name="make" value="{$do}"/>
        <table width="100%" cellspacing="0" cellpadding="6">
            <tbody  class="sectioncontent">
                <tr >
                    <td width="160" align="right"><strong>Name</strong></td>
                    <td class="editor-container">
                        <input type="text"  style="font-size: 16px !important; font-weight: bold;" size="50" value="{$category.name}" class="inp" name="name">
                    </td>
                </tr>

                <tr><td colspan="2"></td></tr>
                <tr><td colspan="2"><a onclick="$('#submitform').submit();return false;" href="#" class="new_dsave new_menu">
                            <span>Save Changes</span>
                        </a></td></tr>
            </tbody>
        </table>
        {securitytoken}</form></div>

{/if}