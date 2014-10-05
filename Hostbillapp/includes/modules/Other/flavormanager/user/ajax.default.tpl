<link rel="stylesheet" href="{$system_url}{$flavordir}orderpage.css?dasdasd">
<script src="{$system_url}{$flavordir}script.js"></script>
<style>
@import url('{$system_url}templates/webfonts/lato/regular.css');
@import url('{$system_url}templates/webfonts/lato/bold.css');
@import url('{$system_url}templates/webfonts/lato/light.css');
</style>
<div id="orderpage">
    <input type="hidden" name="flavor_id" value="0" id="flavor_id" />
<div class="row plan-list">

{foreach from=$list item=i name=loop}
<div class="span4 {if $smarty.foreach.loop.index%3==0}clear{/if}">
    <div class="plan-box plan-color-{$smarty.foreach.loop.index%6} {if $smarty.foreach.loop.index%3 == 2} left-hover{/if}">
        <div class="plan-header">
            <div class="header-hover op-9"></div>
            <div class="padding">
                <h3>{$i.name}</h3>
                <div class="text-center">
                    <p class="price-format"> 
                        {$i.price_on|price:$currency:true:false:true:3}  <span class="price-cycle">/ 小时</span><br/>
                        {$i.monthly|price:$currency}  <span class="price-cycle">/ 月</span><br/></p>
                </div>
                <div class="text-center">
                    <a href="#" class="btn-select" data-value="{$i.id}">选择</a>
                </div>
            </div>
        </div>
        <div class="plan-body">
            <div class="padding">
                <p class="plan-includes">{$i.description}</p>
               
            </div>
        </div>
        
    </div>
</div>
{/foreach}


</div>
</div>
{if $selected}
    <script>
        var slctd={$selected};
        {literal}
        window.setTimeout(function(){$('#orderpage .btn-select[data-value='+slctd+']').click();},500);
        {/literal}
    </script>
{/if}