{if !$sliders}
You don't have any sliders configured yet. Go to <a href="?cmd=hbslider" target="_blank">Extras->Slider Generator</a> and configure your slider to use as orderpage
{else}
<select class="w250" style="margin-bottom:5px" id="opconfig_selectedslider" onchange="selectedSlider()">
    {foreach from=$sliders item=slider}
     <option value="{$slider.id}" {if $selected==$slider.id}selected="selected"{/if}>{$slider.name}</option>
    {/foreach}
</select>
{/if}