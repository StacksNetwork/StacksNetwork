<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>弹性VM列表</span></a>
            </li>
            <li class="{if $action == 'storage'}active{/if}">
                <a {if $action != 'storage'} href="?cmd={$modulename}&action=storage"{/if}><span>弹性存储列表</span></a>
            </li>
            <li class="{if $action == 'add'}active{/if} last">
                <a {if $action != 'add'}href="?cmd={$modulename}&action=add"{/if}><span>新建弹性资源</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1" style="display: block; height: 20px;">
        </div>
    </div>
</div>
{if $list}
    <form id="serializeit">
        <ul id="grab-sorter" style="border:solid 1px #ddd;border-bottom:none;">
            {foreach from=$list item=field name=fff}<li style="background:#ffffff">
                    <div style="border-bottom:solid 1px #ddd;">
                        <table  cellpadding="0" cellspacing="0"  width="100%" >
                            <tbody> <tr class="havecontrols">
                                        <td width="90" >
                                            <div style="padding:10px 5px;">
                                                <a class="sorter-ha menuitm menuf" style="width:14px;margin-left:4px;" onclick="return false" href="#"><span title="移动" class="movesth">&nbsp;</span></a><!--
                                                --><a class="menuitm menuc" style="width:14px;" href="?cmd=flavormanager&action=edit&id={$field.id}"  title="编辑"  ><span class="editsth"></span></a><!--
                                                --><a class="menuitm menul" title="删除" href="?cmd=flavormanager&action=delete&id={$field.id}&security_token={$security_token}" onclick="return confirm('您确定需要删除该弹性资源?');"><span class="delsth"></span></a>
                                            </div>
                                        </td>
                                        <td   >
                                            <input type="hidden" name="sort[]" value="{$field.id}" />
                                            {if $field.enabled=='0'}<em>{/if}{$field.name} {if !$entry.enabled}</em>{/if}
                                            </td>
                                        <td align='right'>  {$field.price_on|price:$currency:true:false:true:10} / 小时 </td>
                                        <td width='100'>   </td>
                                </tr></tbody>
                        </table>
                    </div>
                </li>	{/foreach}
            </ul>
            {securitytoken}
        </form>
{else}
    <div class="blank_state blank_kb">
        <div class="blank_info">
            <h1>弹性资源管理</h1>
            您可以在这里创建给您用户使用的弹性资源
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=flavormanager&action=add" class="new_add new_menu">
                <span>添加新的弹性资源</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>

{literal}
<script>
    $(document).ready(function(){
         $("#grab-sorter").dragsort({ dragSelector: "a.sorter-ha", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
     
    });
         
  function saveOrder() {
		var sorts = $('#serializeit').serialize();
		ajax_update('?cmd=flavormanager&action=sort&'+sorts,{});
		};
    </script>
{/literal}