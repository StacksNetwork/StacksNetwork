<h1>设备供应商: </h1>
<ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter">

    {foreach from=$vendors item=colo}

    <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
            <table width="100%" cellspacing="0" cellpadding="5" border="0">
                <tbody><tr>
                        <td width="120" valign="top"><div style="padding:10px 0px;">
                                <a style="width:14px;" title="编辑" class="menuitm menuf" href="#" onclick="return editVendor('{$colo.id}')"><span class="editsth"></span></a><!--
                                --><a  onclick="return confirm('您确定需要删除该供应商??');" title="删除" class="menuitm menul" href="?cmd=module&module={$moduleid}&do=vendors&make=deletevendor&security_token={$security_token}&vendor_id={$colo.id}"><span class="delsth"></span></a>
                            </div></td>
                        <td  style="line-height:20px">
                            <h3><a href="#"  onclick="return editVendor('{$colo.id}')">{$colo.name}</a></h3>
                            {$colo.items} 件物品在仓库中, 采购自该供应商
                        </td>
                        <td width="350" valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">
                            <strong>注释:</strong> {$colo.comments}
                        </td>
                    </tr>
                </tbody></table></div></li>


    {/foreach}
</ul>


<div style="padding:10px 4px">
    <a id="addnew_conf_btn" onclick="return addVendor();" class="new_control" href="#"><span class="addsth"><strong>添加新供应商</strong></span></a>
</div>