<div class="tabbable tabs-left"><ul class="nav nav-tabs " id="myTab">
    <li class="active"><a href="#home" data-toggle="tab">General settings</a></li>
    <li><a href="#profile" data-toggle="tab">Effect configuration</a></li>
    <li><a href="#messages" data-toggle="tab">Slider style settings</a></li>
</ul>
    <div class="tab-content" id="myTabContent" style="width:auto">
    <div id="home" class="tab-pane fade active in">
        <div class="form-horizontal">
    {foreach from=$settings.settings.general item=s key=k}
 {if $s.type=='hidden'}
  <input type="hidden"  name="settings[{$k}]" value="{$settings.values[$k]}" />
 {else}

        <div class="control-group">
            <label class="control-label" for="inp{$k}">{$s.name}</label>
            <div class="controls {if $s.unit}input-append{/if}">
                {if $s.type=='input'}
                <input type="text"  class="span1" id="inp{$k}" placeholder="{$s.def}" name="settings[{$k}]" value="{$settings.values[$k]}" />{if $s.unit}<span class="add-on">{$s.unit}</span>{/if}
                {elseif $s.type=='select'}
                <select  name="settings[{$k}]" class="span2">
                    {foreach from=$s.values item=va}
                     <option value="{$va}" {if $va==$settings.values[$k]}selected="selected"{/if}>{$va}</option>
                    {/foreach}
                </select>
                {/if}
                <span class="help-inline">{$s.description}</span>
            </div>
        </div>
   {/if}
    {/foreach}
    </div>
    
    </div>
    <div id="profile" class="tab-pane fade">
    <div class="form-horizontal">
    {foreach from=$settings.settings.effect item=s key=k}
 {if $s.type=='hidden'}
  <input type="hidden"  name="settings[{$k}]" value="{$settings.values[$k]}" />
 {else}

        <div class="control-group">
            <label class="control-label" for="inp{$k}">{$s.name}</label>
            <div class="controls {if $s.unit}input-append{/if}">
                {if $s.type=='input'}
                <input type="text"  class="span1" id="inp{$k}" placeholder="{$s.def}" name="settings[{$k}]" value="{$settings.values[$k]}" />{if $s.unit}<span class="add-on">{$s.unit}</span>{/if}
                {elseif $s.type=='select'}
                <select  name="settings[{$k}]" class="span2">
                    {foreach from=$s.values item=va}
                     <option value="{$va}" {if $va==$settings.values[$k]}selected="selected"{/if}>{$va}</option>
                    {/foreach}
                </select>
                {/if}
                <span class="help-inline">{$s.description}</span>
            </div>
        </div>
   {/if}
    {/foreach}
    </div>
    </div>
    <div id="messages" class="tab-pane fade">
        <div class="form-horizontal">
    {foreach from=$settings.settings.style item=s key=k}
 {if $s.type=='hidden'}
  <input type="hidden"  name="settings[{$k}]"value="{$settings.values[$k]}" />
 {else}

        <div class="control-group">
            <label class="control-label" for="inp{$k}">{$s.name}</label>
            <div class="controls {if $s.unit}input-append{/if}">
                {if $s.type=='input'}
                <input type="text" class="span1" id="inp{$k}" placeholder="{$s.def}"  name="settings[{$k}]" value="{$settings.values[$k]}" />{if $s.unit}<span class="add-on">{$s.unit}</span>{/if}
                {elseif $s.type=='select'}
                <select   name="settings[{$k}]" class="span2">
                    {foreach from=$s.values item=va}
                     <option value="{$va}" {if $va==$settings.values[$k]}selected="selected"{/if}>{$va}</option>
                    {/foreach}
                </select>
                {/if}
                <span class="help-inline">{$s.description}</span>
            </div>
        </div>
   {/if}
    {/foreach}
    </div>
    </div>

</div></div>
{literal}
<script>
    $('#myTab a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    })
</script>

{/literal}