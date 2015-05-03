<!DOCTYPE html>
<html xml:lang="en" lang="en">
<head>
<meta charset="utf-8" />
<script src="js/jquery.js"></script>
<script src="js/hbslider.js"></script>
<link rel="stylesheet" href="css/slider.css">
<title>HostBill Slider Preview</title>

</head>

<body id="hbs-demo">


<div id="hb-slider" class="hbs-slider">
    {foreach from=$slider.slides item=slide}<div title="{$slide.title}"  class="hbs-slide">
        {if $slide.image}<img src="slider/{$slide.image}"  />{if $slide.caption}<div class="hbs-caption">{$slide.caption}</div>{/if}{else}<div class="hbs-text-only">{$slide.content}</div>{/if}

    </div>
    {/foreach}
</div>

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

</body>
</html>