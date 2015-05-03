<form id="submitform" action="" method="post">
    <input type="hidden" name="make" value="save" />
    {if $action=='edit'}
    <input type="hidden" name="id" value="{$slider.id}" />
    {/if}
<h2>1. Choose your slider style</h2>
<div class="well form-inline">
    <select name="settings[style]" onchange="eff(this,'#style-descr')" id="style">
        {foreach from=$styles item=style key=k}
            <option value="{$k}" {if $slider.settings.style==$k}selected="selected"{/if} rel="{$style.description}">{$style.name}</option>
        {/foreach}
    </select>
    <a class="btn" onclick="preview(); return false"><i class="icon-search"></i> Preview</a>
    <div id="style-descr">{foreach from=$styles item=style key=k name=fl}{if !$slider.settings.style && $smarty.foreach.fl.first}{$style.description}{break}{/if}
       {if $slider.settings.style==$k}{$style.description}{/if}
        {/foreach}</div>
</div>

<h2>2. Select slides transition effect</h2>
<div class="well form-inline">
    <select name="settings[effect]" onchange="eff(this,'#effect-descr')" id="effect">
        {foreach from=$effects item=style key=k}
            <option value="{$k}" {if $slider.settings.effect==$k}selected="selected"{/if} rel="{$style.description}">{$style.name}</option>
        {/foreach}
    </select>
    <a class="btn" onclick="preview(); return false"><i class="icon-search"></i> Preview</a>
    <div id="effect-descr">{foreach from=$effects item=style key=k name=fl}{if !$slider.settings.effect && $smarty.foreach.fl.first}{$style.description}{break}{/if}
       {if $slider.settings.effect==$k}{$style.description}{/if}
        {/foreach}</div>
</div>


<h2>3. Customize your slideshow</h2>
<div id="configarea" style="margin-bottom:20px;">
                {include file="`$tpldir`ajax.config.tpl"}
</div>


<h2>4. Name your slider:</h2>
<div style="margin-bottom:20px;">
<input type="text" style="font-size:17px;font-weight:bold" class="span4" placeholder="My slider" name="name" value="{if $slider.name}{$slider.name}{else}My slider{/if}" />
</div>

<a class="btn btn-large btn-primary" onclick="savechanges(); return false">Save{if $action!='edit'} &amp; define slides{/if}</a>
{if $action=='edit'}
<a class="btn btn-large btn-primary" onclick="savechanges(true); return false">Save &amp; get HTML code</a>
{/if}
<a class="btn btn-large" onclick="preview(); return false">Preview</a>
{securitytoken}
</form>
<form action="{$system_url}?cmd=hbslider&action=preview" method="post"  target="_blank" id="formpreview">
    <input type="hidden" value="" name="settings" id="style-hidden" />
</form>
{literal}
<script>
    function eff(sel,target) {
        var v = $('option:selected',sel).attr('rel');
        $(target).text(v);
        ajax_update('?cmd=hbslider&action=changesth',{settings:$('input,select','#submitform').serialize()},'#configarea',true);
    }
    function savechanges(e) {
        if(e===true) {
            $('#submitform').append('<input type="hidden" name="redirect" value="true" />');
        }
        $('#submitform').submit();

    }
    function preview() {
        $('#style-hidden').val($('input,select','#submitform').serialize());
        $('#formpreview').submit();
    }
</script>
{/literal}