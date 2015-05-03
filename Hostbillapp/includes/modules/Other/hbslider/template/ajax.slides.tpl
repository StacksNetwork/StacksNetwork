{foreach from=$slider.slides item=slide name=fff}<li style="background:#ffffff">
    <div style="border-bottom:solid 1px #ddd;">
        <table  cellpadding="0" cellspacing="0"  width="100%" >
            <tbody> <tr class="havecontrols">
                   
                    <td width="90" ><div style="padding:10px 5px;">
                            <a style="width:14px;margin-left:4px;" onclick="return false" class="sorter-ha menuitm menuf" href="#"><span title="move" class="movesth">&nbsp;</span></a><!--
                            --><a class="menuitm menuc"style="width:14px;" href="#" onclick="return slideform('{$slide.id}');" title="edit" ><span class="editsth"></span></a><!--
                            --><a class="menuitm menul" title="delete"  href="#" onclick="return delete_slide('{$slide.id}');"><span class="delsth"></span></a>
                        </div></td>
                    <td ><input type="hidden" name="sort[]" value="{$slide.id}" />{$slide.title}</td>

                </tr></tbody>
        </table>
    </div>
</li>
{foreachelse}
<li style="background:#ffffff">
    <div style="border-bottom:solid 1px #ddd;">
        <table  cellpadding="0" cellspacing="0"  width="100%" >
            <tbody> <tr class="havecontrols">
                   
                    <td ><div style="padding:10px 5px;"><em>This slider dont have any slides created yet, use form below to add new slide</em></div></td>

                 
                </tr></tbody>
        </table>
    </div>
</li>
{/foreach}