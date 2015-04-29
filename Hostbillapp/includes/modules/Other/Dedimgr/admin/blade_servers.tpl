<div class="tabb tabb-big" data-tab="1">
                <h3><i class="fa fa-tasks"></i> 刀片服务器/模块化交换机</h3>
                {if $item.bladeitems}
                    <div>
                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                            <tbody>
                                {foreach from=$item.bladeitems item=blade name=ff}
                                    <tr class="havecontrols man {if $smarty.foreach.ff.index%2==0}even{/if}">
                                        <td>{$blade.category_name}</td>
                                        <td>{$blade.name}</td>
                                        <td>{$blade.label}</td>
                                        <td class="lastitm fa-actions" align="right">
                                            <a href="?cmd=module&module=dedimgr&do=rack&make=delitem&id={$blade.id}{if $backview}&backview=parent&parent_id={$item.id}{/if}&rack_id={$item.rack_id}" 
                                               onclick="return confirm('您确定需要移除该物品吗?')" title="移除物品"><i class="fa fa-trash-o"></i></a>
                                            <a href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$blade.id}" onclick="return editBladeItem('{$blade.id}')"
                                               title="编辑物品"><i class="fa fa-pencil"></i></a>
                                            <a href="?cmd=module&module=dedimgr&do=itemeditor&item_id={$blade.id}"
                                               title="在新窗口中显示详细内容"><i class="fa fa-share"></i></a>
                                        </td>
                                    </tr>
                                {/foreach}

                            </tbody>
                        </table>
                    </div>
                {/if}
                <br/>
                <div class="form-group">
                    <label class="nodescr">新的刀片服务器/箱式交换机分类:</label>
                    <select id="blade_cat_id"  onchange="loadSubitems(this)" class="w250">>
                        <option value="0">选择分类添加物品</option>
                        {foreach from=$categories item=c}
                            <option value="{$c.id}">{$c.name}</option>
                        {/foreach}
                    </select>
                </div>
                <div id="updater1" class="form-group"></div>
                <div class="form-group">
                    <a class="new_control greenbtn" href="#" onclick="createBladeEntry();
                                                return false" id="bladeadd" style="display:none"><span>添加该刀片服务器/交换机板卡</span></a>
                </div>
            </div>