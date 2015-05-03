<!--HBSlider 1.: Place code below between <HEAD></HEAD> -->
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/slider/defaults.css" />
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/slider/styles/{$style}/{$style}.css" />
{if $effectcss}<link rel="stylesheet" href="{$system_url}templates/slider/effects/{$effect}/{$effect}.css">{/if}
<script type="text/javascript" src="{$system_url}?/hbslider/getjs/{$slider_id}/"></script>


<!--HBSlider 2.: Place code below on your webiste, in <BODY> tag - in place you wish slider to appear:-->
<div id="hb-slider" class="hbs-slider">
    {foreach from=$slider.slides item=slide}<div title="{$slide.title}" class="hbs-slide">
        {if $slide.image}<img src="{$system_url}slider/{$slide.image}" />{if $slide.caption}<div class="hbs-caption">{$slide.caption}</div>{/if}{else}<div class="hbs-text-only">{$slide.content}</div>{/if}
        
    </div>
    {/foreach}
</div>




<!--HBSlider 3.: Place code below before </BODY> tag-->
<script type="text/javascript">
        {literal}
        $(window).load(function(){
            $('#hb-slider').hbslider({{/literal}
                {foreach from=$settings item=s key=k name=f}{$k}: {if $s=='true' || $s=='false' || is_numeric($s)}{$s}{else}"{$s}"{/if} {if !$smarty.foreach.f.last},{/if}

                {/foreach}
        {literal}
            });
        });{/literal}
</script>
