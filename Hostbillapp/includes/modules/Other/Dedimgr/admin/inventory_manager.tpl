<h3 style="margin-bottom:10px;"><img src="../includes/libs/configoptions/select/select_thumb2.png" alt="" style="margin-right:5px" class="left"  />  库存管理</h3>
<div class="clear"></div>

<div style="min-height: 250px">
    <label class="nodescr">调试完成ID</label>
    <select  class="w250" name="build_id" load="builds" default="{$item.build_id}" id="build_id" onchange="reloadInventory($(this).val())"><option value="0" {if $item.build_id=='0'}selected="selected"{/if}>#0: 无</option></select>
    <div class="clear"></div>

    <div id="inventorygrid">
    </div>

</div>

{literal}
    <script>
     function reloadInventory(build_id) {
         if (!build_id) {
             $('#inventorygrid').hide().html('');
             return;
         }
         $('#inventorygrid').html('');
         ajax_update('?cmd=inventory_manager&action=rackitem&build_id=' + build_id, {}, '#inventorygrid');

     }
    {/literal}{if $item.build_id!='0'}
     reloadInventory({$item.build_id});
    {/if}

</script>