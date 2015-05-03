{if $do=='st'}

{else}

 {if $fields.active}
        <table width="100%" cellspacing="0" cellpadding="3" class="whitetable">
		<tbody><tr>
			<th>字段名称</th>
			<th>部门</th>
			<th>后续动作</th>
			<th width="20"></th>
			<th width="20"></th>
		</tr>

                {foreach from=$fields.active item=field  name=fr}
		<tr class="{if $smarty.foreach.fr.index%2==0}even{/if} havecontrols">
			<td style="padding-left: 10px;">{$field.name}</td>
			<td>{foreach from=$depts item=dept}{if $field.depts[$dept.id]}{$dept.name}, {/if}{/foreach}</td>
			<td>{if $field.action=='ticket'}保存在工单内{else}保存在客户配置文件中{/if}</td>
			<td><a onclick="{literal}$.facebox({ ajax: $(this).attr('href')}); return false;{/literal}" class="editbtn" href="?cmd=module&module={$moduleid}&do=field&fid={$field.id}">编辑</a></td>
			<td class="lastitm"><a onclick="return confirm('您确定要删除该字段吗?');" class="delbtn" href="?cmd=module&module={$moduleid}&do=deletefield&fid={$field.id}">删除</a></td>
		</tr>
                {/foreach}

                <tr>
			<th colspan="5">
                            <a  onclick="{literal}$.facebox({ ajax: $(this).attr('href')}); return false;{/literal}"
                            class="editbtn" href="?cmd=module&module={$moduleid}&do=newfield" class="editbtn">创建新的字段</a>
                            {if $fields.predefined}&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" class="editbtn" onclick="$('#addnewgroup_btn').toggle();return false">使用预先定义的字段</a>{/if}
                        </th>
		</tr>
                </tbody>
        </table>
    {/if}

{if $fields.predefined || !$fields.active}
    <div class="blank_state blank_news" id="addnewgroup_btn" {if $fields.active}style="display:none"{/if}>
			<div class="blank_info">
				<h1>预先定义的服务支持字段</h1>
                                支持激活预先定义的字段, 当新开工单后可以有更多收集信息的方式. 
				<div class="clear"></div>

                                {foreach from=$fields.predefined item=field}
			 <a class="new_add new_menu" onclick="{literal}$.facebox({ ajax: $(this).attr('href')}); return false;{/literal}"
                            class="editbtn" href="?cmd=module&module={$moduleid}&do=field&fid={$field.id}"   style="margin-top:10px">
			<span>{$field.name}</span></a>
                                {/foreach}
                                <div class="clear" ></div><div style="margin-top:10px;">或者</div><div class="clear"></div>

                                 <a class="new_add new_menu" onclick="{literal}$.facebox({ ajax: $(this).attr('href')}); return false;{/literal}"
                            class="editbtn" href="?cmd=module&module={$moduleid}&do=newfield"   style="margin-top:10px">
			<span>创建新的字段</span></a>
		<div class="clear"></div>

		</div>
	</div>

{/if}
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
{/if}