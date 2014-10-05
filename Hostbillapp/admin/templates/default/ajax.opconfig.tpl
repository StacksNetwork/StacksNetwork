<script type="text/javascript" src="{$template_dir}js/opconfig.js"></script>
<script type="text/javascript">
    HBOpConfig.init('{$category_id}','{$template_name}');                
</script>
<div class="form conv_content" style="background:#fff;">
    <form method="post" action="" id="sform1"> <h3 >{$spec.name}</h3><div style="max-height: 320px;overflow: auto;">
            <input type="hidden" name="cat_id" value="{$category_id}" />
            <div class="clear"></div>

            {foreach from=$opconfig item=c key=k}
            {if $k=='productfeatures'}{continue}{/if}
            <label for="{$k}" class="nodescr">{$c.name} </label>
            {if $c.type=='input'}
                <input type="text" class="w250" name="opconfig[{$k}]" value="{$c.value|htmlspecialchars}" style="margin-bottom:5px"/>
            {elseif $c.type=='hidden'}
                <input type="hidden" id="opconfig_{$k}" name="opconfig[{$k}]" value="{$c.value|htmlspecialchars}" />
            {elseif $c.type=='link'}
                <div class="w250 winput" style="padding-top:7px !important"><a href="{$c.value}" target="_blank" class="external"><b>{$c.name}</b></a></div>
            {elseif $c.type=='textarea'}
                <textarea class="w250" name="opconfig[{$k}]" style="margin-bottom:5px">{$c.value|htmlspecialchars}</textarea>

            {elseif $c.type=='checkbox'}
                <input type="checkbox" {if $c.value=='1'}checked="checked"{/if} name="opconfig[{$k}]" value="1" style="margin-bottom:5px" />
                <input type="hidden" name="opconfig[checkboxes_][]" value="{$k}" />
            {elseif $c.type=='featurelist'}
                <input type="hidden" id="list_{$k}" name="opconfig[{$k}]" value="{$c.value|htmlspecialchars}" />
                <div class="w250 winput" style="padding-top:7px !important; margin-bottom: 2px;">
                    <ul id="ulist_{$k}" style="margin: 0; padding-left:25px"></ul>
                    <input type="text" id="listn_{$k}" style="margin-bottom:5px"/><button id="btn_{$k}" style="padding: 3px 6px;margin: 2px;">{$lang.Add}</button>
                </div>
                <script type="text/javascript">
                    function list_{$k}(){literal}{{/literal}
                    $('#ulist_{$k}').html($($('#list_{$k}').val()).filter('li').each(function(){literal}{{/literal}$(this).append('<a class="fs11 editbtn" style="margin-left:5px" href="#" onclick="remol_{$k}(this); return false;">{$lang.delete}</a>'){literal}}{/literal}));
                    {literal}}{/literal}
                    function remol_{$k}(el){literal}{{/literal}
                        var pp = $(el).parent().parent();
                        $(el).parent().remove()
                        $('#list_{$k}').val(pp.clone().find('a.fs11.editbtn').remove().end().html());
                    {literal}}{/literal}
                    list_{$k}();
                    $('#btn_{$k}').click(function(){literal}{{/literal}$('#list_{$k}').val($('#list_{$k}').val()+'<li>'+$('#listn_{$k}').val()+'</li>'); list_{$k}(); return false;{literal}}{/literal});
                </script>
            {elseif $c.type=='premade'}
                {if !$premadeinit}
                    <script type="text/javascript" src="{$template_dir}js/ajaxfileupload.js"></script>
                    
                    {assign var=premadeinit value=true}
                {/if}
                
                {*<input type="hidden" id="list_{$k}" name="opconfig[{$k}]" value="{$c.value|htmlspecialchars}" />*}
                    <div class="w250 winput" style="padding-top:7px !important; margin-bottom:5px">
                        <ul id="plist_{$k}" style="margin: 0; padding-left:25px">
                            {counter name=premades start=0 print=false assign=premades}
                            {foreach from=$c.value item=premade}
                                {if $premade.name}
                                <li>
                                    {counter name=premades}
                                    {$premade.name} 
                                    <a href="#" class="editbtn fs11" onclick="return premade.edit('{$k}','{$premades}');"> edit</a> 
                                    <a href="#" class="fs11" onclick="return premade.del('{$k}','{$premades}');"> delete</a> 
                                </li>
                                {/if}
                            {/foreach}
                            <li>
                                <a href="#" class="editbtn fs11" onclick="return premade.addnew('{$k}');"> add</a> 
                            </li>
                        </ul>
                    </div>
                    
                    {counter name=premades start=0 print=false assign=premades}
                    {foreach from=$c.value item=premade key=index}
                        {if $premade.name}
                        {counter name=premades}
                        <div id="old_{$k}_{$premades}" style="display: none;"> 
                            <label style="font-weight: normal">Name</label><input type="text" value="{$premade.name}" name="opconfig[{$k}][{$premades}][name]" class="w250" style="margin-bottom:5px"/>
                            <label style="font-weight: normal">Description</label><textarea  name="opconfig[{$k}][{$premades}][description]"  class="w250" style="margin-bottom:5px">{$premade.description}</textarea>
                            <label style="font-weight: normal">Target package</label><input  value="{$premade.package}" type="text" name="opconfig[{$k}][{$premades}][package]" class="w250" style="margin-bottom:5px"/>
                            <div class="fs11" style="padding-left:170px;clear:both;margin-bottom:10px;color:#666">Package number, starting from one (eg. 2 will select second package<br /> when clicking on this pre-made configuration)</div>
                            <label style="font-weight: normal">Icon</label>
                            <input type="hidden" name="opconfig[{$k}][{$premades}][icon]"  value="{$premade.icon}" rel="file_{$k}_{$premades}" />
                            <input type="file" id="file_{$k}_{$premades}" name="image" onchange="premade.update('{$k}', 'file_{$k}_{$premades}',true); return true;" style="margin-bottom:5px" />
                        </div>
                        {/if}
                    {/foreach}
                    
                    <div id="new_{$k}" style="display: none;">
                        {counter name=premades}
                        <label style="font-weight: normal">Name</label><input type="text" name="opconfig[{$k}][{$premades}][name]" class="w250" style="margin-bottom:5px"/>
                        <label style="font-weight: normal">Description</label><textarea  name="opconfig[{$k}][{$premades}][description]"  class="w250" style="margin-bottom:5px"></textarea>
                        <label style="font-weight: normal">Target package</label><input type="text" name="opconfig[{$k}][{$premades}][package]" class="w250" style="margin-bottom:5px"/>
                        <div class="fs11" style="padding-left:170px;clear:both;margin-bottom:10px;color:#666">Package number, starting from one (eg. 2 will select second package<br /> when clicking on this pre-made configuration)</div>
                        <label style="font-weight: normal">Icon</label>
                        <input type="hidden" name="opconfig[{$k}][{$premades}][icon]" rel="file_{$k}_{$premades}" />
                        <input type="file" id="file_{$k}_{$premades}" name="image" onchange="premade.update('{$k}', 'file_{$k}_{$premades}',true);" style="margin-bottom:5px" />
                    </div>
                    <div id="itool_{$k}" style="display: none;">
                        <div id="icon_{$k}" class="w250 winput" style="padding-top: 7px!important; margin-bottom: 2px; margin-left: 170px; text-align: center; min-height: 20px; position: relative"></div>
                        <label><button id="btn_{$k}" onclick="return premade.save('{$k}', '{$premades}');">{$lang.Add}</button></label>
                    </div>
                    <div class="clear:both"></div>
                    
            {elseif $c.type=='colorpicker'}
                {if !$colorpickerinit}
                    <link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css" />
                    <script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js"></script>
                    {assign var=colorpickerinit value=true}
                {/if}
                <input id="colorSelector_{$k}_i" type="hidden" class="w250" size="7" name="opconfig[{$k}]" value="{$c.value}" style="margin-bottom:5px"/>
                <div id="colorSelector_{$k}" style="border: 2px solid #ddd; cursor: pointer; float: left; height: 15px;margin: 6px 0 5px 8px;position:relative; width: 40px; background: #{$c.value};" onclick="$('#colorSelector_{$k}_i').click()">
                    <div style="position:absolute; bottom:0; right: 0; color:white; background:url('{$template_dir}img/imdrop.gif') no-repeat 3px 4px #ddd; height:10px; width:10px"></div>
                </div>
                <script type="text/javascript">$('#colorSelector_{$k}').ColorPicker({literal}{onSubmit: function(hsb, hex, rgb, el) {
                    $(el).val(hex);
                    $(el).ColorPickerHide();
                    },onChange: function (hsb, hex, rgb) {
                        {/literal}
                            $('#colorSelector_{$k}').css('backgroundColor', '#' + hex);
                            $('#colorSelector_{$k}_i').val(hex);
                        {literal}
                    },
                    livePreview:true, color:{/literal}'{$c.value}'{literal}}{/literal});</script>
            {/if}
            <div class="clear"></div>
        {if $c.description}<div class="fs11" style="padding-left:170px;clear:both;margin-bottom:10px;color:#666">{$c.description}</div>{/if}
    {/foreach}</div>
</form>
</div><div class="dark_shelf dbottom">
    <div class="left spinner"><img src="ajax-loading2.gif" alt=""></div>
    <div class="right">
        <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="HBOpConfig.fsubmit();return false"><span>{$lang.savechanges}</span></a></span>
        <span >{$lang.Or}</span>
        <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
    </div>
    <div class="clear"></div>
</div>

