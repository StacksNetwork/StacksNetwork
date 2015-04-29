{if $part=='itemconfig'}
    <div>
        <b>{$item.name}</b>
    </div>
    <br>
    <form action="" method="post" class="table-vtop">
        <table cellspacing="0" cellpadding="3">
            <tbody>
                <tr>
                    <td colspan="2" width="70%"><h3>常规属性</h3></td>
                    <td rowspan="9"><img src="../includes/modules/Other/Dedimgr/admin/images/server1u_3d.png" style="margin: 0 10px"/></td>
                    <td width="30%"><h3>额外属性</h3></td>
                </tr>
                <tr>
                    <td width="10%"> 物品名称: </td>
                    <td width="60%"><input type="text" value="{if $item.name}{$item.name}{else}{/if}" name="name" class="inp"  size="50" /></td>
                    <td rowspan="8" >
                        {if $ftypes}
                            <select name="x" class="inp" id="new_additional_{$item.id}_select">
                                {foreach from=$ftypes item=field}
                                    <option value="{$field.id}">{$field.name}</option>
                                {/foreach}
                            </select>
                            <input type="button" value="分配" onclick="assignnew('#new_additional_{$item.id}');
                                    return false;" />
                        {/if}

                        <div id="new_additional_{$item.id}">
                            {if $item}
                                {foreach from=$item.fields item=f}
                                    <div style='padding:3px 5px'>
                                        <input type='hidden' name='fields[]' value='{$f.id}'/>{$f.name} 
                                        <span class='orspace'>
                                            <a href='#' onclick='return remaddopt(this);'>删除</a>
                                        </span>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </td>
                </tr>
                <tr>
                    <td> 高度:</td>
                    <td> 
                        <input type="number" step="1" value="{if $item.units}{$item.units}{else}1{/if}" name="units" class="inp u-size" size="4" /> 
                        <span class="mount_ mount_Front" {if $item.orientation!='Front'}style="display:none"{/if}>U</span> 
                        <span class="mount_ mount_Side" {if $item.orientation!='Side'}style="display:none"{/if}>U 高度</span>
                    </td>
                </tr>
                <tr>
                    <td> 方向:</td>
                    <td> 
                        <select name="orientation" class="inp mount_type">
                            <option {if $item.orientation=='Front'}selected="selected"{/if}>正面</option>
                            <option {if $item.orientation=='Side'}selected="selected"{/if}>侧面</option>
                        </select> 
                    </td>
                </tr>
                <tr>
                    <td> 电流:</td>
                    <td> <input type="text" value="{if $item.current}{$item.current}{else}0.00{/if}" name="current" class="inp" size="4" /> Amps </td>
                </tr>
                <tr>
                    <td> 功率:</td>
                    <td> <input type="text" value="{if $item.power}{$item.power}{else}0.00{/if}" name="power" class="inp" size="4" /> W</td>
                </tr>
                <tr>
                    <td> 承重: </td>
                    <td><input type="text" value="{if $item.weight}{$item.weight}{else}1.00{/if}" name="weight" class="inp" size="4" /> KG</td>
                </tr>
                <tr>
                    <td> 月租:</td>
                    <td> <input type="text" value="{if $item.monthly_price}{$item.monthly_price|price:$currency:false}{else}{0.00|price:$currency:false}{/if}" name="monthly_price" class="inp" size="4" /> {$currency.code}</td>
                </tr>
                <tr>
                    <td> 供应商:</td>
                    <td> 
                        <select class="inp" name="vendor_id">
                            {foreach from=$vendors item=v}
                                <option value="{$v.id}" {if $item.vendor_id==$v.id}selected="selected"{/if}>{$v.name}</option>
                            {/foreach}
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>图标:</td>
                    <td colspan="3">
                        {include file='class_selector.tpl'} 
                        <div class="preview">
                            <table cellspacing="0" cellpadding="0">
                                <tr  class="have_items dragdrop">
                                    <td  class=" contains">
                                        <div class="im_del"></div>
                                        <div class="rackitem server{$item.units}u default_1u" {if $item.css}style="background-image: url({$moduledir}images/hardware/{$item.css})"{/if}>
                                            <div class="lbl">预览</div>
                                        </div>
                                        <div class="im_edit"></div>
                                        <div class="im_sorthandle"></div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td colspan="2">
                        {if $item.id}
                            <input type="hidden" name="make" value="edititem">
                            <input type="hidden" name="id" value="{$item.id}">
                            <input type="submit" style="font-weight:bold" value="保存修改">
                        {else}
                            <input type="hidden" name="make" value="additem">
                            <input type="submit" style="font-weight:bold" value="添加该物品">
                        {/if}
                        <span class="orspace">或者</span> 
                        <a class="editbtn" onclick="return toggleTypeEdit('{$item.id}');" href="#">取消</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
{elseif !$subdo}
    {if $categories}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list" id="grab-sorter" >
                    <tbody>
                        {foreach from=$categories item=category}
                            <tr>
                                <td>
                                    <a title="编辑" class="menuitm menuf" href="#" onclick="return editCategory('{$category.id}')"><span class="editsth"></span></a><!--
                                    --><a onclick="return confirm('您确定需要删除该分类吗? 这将会同时删除所属所有物品')" title="删除" class="menuitm menul"
                                          href="?cmd=module&module={$moduleid}&do=inventory&make=removecat&id={$category.id}"><span class="delsth"></span></a>
                                </td>
                                <td>
                                    <a href="?cmd=module&module={$moduleid}&do=inventory&subdo=category&category_id={$category.id}"><b>{$category.name}</b></a>
                                </td>

                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        未发现物品分类
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
                                        return false;" class="new_control" href="#">
            <span class="addsth"><strong>添加新分类</strong></span>
        </a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                <tbody>
                    <tr>
                        <td>
                            分类名称: <input type="text" value="" name="name" class="inp"/>
                        </td>
                        <td>
                            <input type="hidden" name="make" value="addcat">
                            <input type="submit" style="font-weight:bold" value="添加分类">
                            <span class="orspace">或者</span> 
                            <a class="editbtn" onclick="$('#addcategory').hide();
                                        return false;" href="#">取消</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
{elseif $subdo=='category'}
    <script type="text/javascript">
                                    var hardwareurl = '{$moduledir}images/hardware/';
    </script>
    <script src="{$template_dir}js/fileupload/vendor/jquery.ui.widget.js"></script>
    <script src="{$template_dir}js/fileupload/jquery.iframe-transport.js"></script>
    <script src="{$template_dir}js/fileupload/jquery.fileupload.js"></script>
    <script src="{$moduledir}inventory.js"></script>
    <h3>分类: {$category.name}</h3><br />

    {if $items}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list inventory-list-tdetails" id="grab-sorter" >
                    <tbody>
                        {foreach from=$items item=item}
                            <tr>
                                <td>
                                    <a onclick="return toggleTypeEdit('{$item.id}', this);" title="编辑" class="menuitm menuf" href="#"><span class="editsth"></span></a>{*}
                                    {*}<a title="复制" class="menuitm menuc" href="?cmd=module&module=dedimgr&do=inventory&subdo=category&category_id={$category.id}&make=duplicate&id={$item.id}"><span class="duplicatesth"></span></a>{*}
                                    {*}<a onclick="return confirm('您确定需要删除该物品吗? 这将会导致在所有机架内删除该物品!.')" title="删除" class="menuitm  menul" 
                                       href="?cmd=module&module={$moduleid}&do=inventory&subdo=category&category_id={$category.id}&make=removeitem&id={$item.id}"><span class="delsth"></span></a>
                                </td>
                                <td>
                                    <div id="fname_{$item.id}"><b>{$item.name}</b></div>
                                    <div id="fform_{$item.id}" {if $expand_id!=$item.id}style="display:none"{/if}>
                                        {include file="inventory.tpl" part='itemconfig'}
                                    </div>
                                </td>
                                <td>
                                    高度:  {$item.units} U<br/>
                                    电流:   {$item.current} Amps<br/>
                                    功率:   {$item.power} W<br/>
                                    重量:   {$item.weight} KG
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        尚未添加任何物品.
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="return toggleTypeEdit('');" class="new_control" href="#">
            <span class="addsth"><strong>定义新的物品位于分类 {$category.name}</strong></span>
        </a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="fform_">
        {include file="inventory.tpl" part='itemconfig' item=''}
    </div>
{elseif $subdo=='fieldtypes'}
    <script src="{$moduledir}inventory.js"></script>
    {if $ftypes}
        <div id="listform">
            <div id="serializeit">
                <table class="inventory-list inventory-list-tdetails" id="grab-sorter" >
                    <tbody>
                        {foreach from=$ftypes item=field}

                            <tr>
                                <td>
                                    <a onclick="return toggleTypeEdit('{$field.id}', this)" title="编辑" class="menuitm menuf" href="#"><span class="editsth"></span></a><!--
                                    --><a onclick="return confirm('您确定需要删除该字段类型吗? 这将会在所有使用该字段的物品中删除它.')" title="删除" class="menuitm  menul"
                                          href="?cmd=module&module={$moduleid}&do=inventory&subdo=fieldtypes&make=removefield&id={$field.id}"><span class="delsth"></span></a>

                                </td>
                                <td>
                                    <div id="fname_{$field.id}">{$field.name}</div>
                                    <div id="fform_{$field.id}" style="display:none">
                                        <form action="" method="post">
                                            <label>
                                                字段名称: <input type="text" value="{$field.name}" name="name" class="inp"/>
                                            </label> &nbsp;
                                            <label>
                                                类型: <select name="field_type" class="inp">
                                                    <option value="input" {if $field.field_type=='input'}selected="selected"{/if}>文本输入</option>
                                                    <option value="text" {if $field.field_type=='text'}selected="selected"{/if}>只读文本</option>
                                                    <option value="select" {if $field.field_type=='select'}selected="selected"{/if}>下拉菜单</option>
                                                    <option value="switch_app" {if $field.field_type=='switch_app'}selected="selected"{/if}>交换机应用脚本</option>
                                                    <option value="pdu_app" {if $field.field_type=='pdu_app'}selected="selected"{/if}>PDU应用脚本</option>
                                                </select>
                                            </label> &nbsp;
                                            <label>
                                                默认值: <input type="text" value="{$field.default_value}" name="default_value" class="inp" size="40" />
                                            </label> &nbsp;
                                            <label>
                                                检索可见: 
                                                <a href="#" class=" vtip_description" title="使您可以通过该字段搜索物品"></a>
                                                <input type="checkbox" value="1" name="options[1]" {if $field.options & 1}checked="checked"{/if} style="vertical-align: middle;" />
                                            </label> &nbsp;
                                            <input type="hidden" name="make" value="editfield">
                                            <input type="hidden" name="id" value="{$field.id}">

                                            <input type="submit" style="font-weight:bold" value="保存">
                                            <span class="orspace">或者</span> 
                                            <a class="editbtn" onclick="return toggleTypeEdit('{$field.id}')" href="#">取消</a>
                                        </form>
                                    </div>
                                </td>
                                <td>
                                    类型: {$ftt[$field.field_type]}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    {else}
        无任何字段
    {/if}
    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" onclick="$('#addcategory').toggle();
                                        return false;" class="new_control" href="#"><span class="addsth"><strong>定义新字段</strong></span></a>
    </div>
    <div class="p6" style="margin-bottom: 15px;display:none;" id="addcategory"><form action="" method="post">
            <table cellspacing="0" cellpadding="3" style="margin-bottom:5px;">
                <tbody><tr>
                        <td>
                            字段名称: <input type="text" value="" name="name" class="inp"/>
                        </td>

                        <td>
                            类型: <select name="field_type" class="inp">
                                <option value="input">文本输入</option>
                                <option value="text">只读文本</option>
                                <option value="select">下拉菜单</option>
                                <option value="switch_app" >交换机应用脚本</option>
                                <option value="pdu_app" >PDU应用脚本</option>
                            </select>
                        </td>
                        <td>
                            默认值: <input type="text" value="" name="default_value" class="inp" size="40" />

                        </td>
                        <td>
                            <input type="hidden" name="make" value="addfield">
                            <input type="submit" style="font-weight:bold" value="添加新字段">
                            <span class="orspace">或者</span> <a class="editbtn" onclick="$('#addcategory').hide();
                                        return false;" href="#">取消</a>
                        </td>
                    </tr>
                </tbody></table>
        </form></div>
    <small>
        注意: 位于机架上的所有物品. 您可以定义不同类型的字段进行编辑, 如'服务器名称' 只是显示.<br>
        在下拉框中用逗号分隔值 ","

    </small>
{else}

{/if}