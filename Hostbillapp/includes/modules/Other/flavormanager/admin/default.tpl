<div id="newshelfnav" class="newhorizontalnav">
    <div class="list-1">
        <ul>
            <li class="{if $action == 'default'}active{/if}">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>VM Flavor List</span></a>
            </li>
            <li class="{if $action == 'storage'}active{/if}">
                <a {if $action != 'storage'} href="?cmd={$modulename}&action=storage"{/if}><span>Storage Flavor List</span></a>
            </li>
            <li class="{if $action == 'add'}active{/if} last">
                <a {if $action != 'add'}href="?cmd={$modulename}&action=add"{/if}><span>New Flavor</span></a>
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
                                                <a class="sorter-ha menuitm menuf" style="width:14px;margin-left:4px;" onclick="return false" href="#"><span title="move" class="movesth">&nbsp;</span></a><!--
                                                --><a class="menuitm menuc" style="width:14px;" href="?cmd=flavormanager&action=edit&id={$field.id}"  title="edit"  ><span class="editsth"></span></a><!--
                                                --><a class="menuitm menul" title="delete" href="?cmd=flavormanager&action=delete&id={$field.id}&security_token={$security_token}" onclick="return confirm('Are you sure you wish to delete this flavor?');"><span class="delsth"></span></a>
                                            </div>
                                        </td>
                                        <td   >
                                            <input type="hidden" name="sort[]" value="{$field.id}" />
                                            {if $field.enabled=='0'}<em>{/if}{$field.name} {if !$entry.enabled}</em>{/if}
                                            </td>
                                        <td align='right'>  {$field.price_on|price:$currency:true:false:true:10} / hour </td>
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
            <h1>Flavor Manager</h1>
            You can create flavors to be used by clients here
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=flavormanager&action=add" class="new_add new_menu">
                <span>Add new Flavor</span></a>
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