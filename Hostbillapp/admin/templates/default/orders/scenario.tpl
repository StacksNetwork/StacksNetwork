{if $steps}
<h1>Order lifecycle</h1>
<div style="margin:10px 0px;" id="tabcontainer">

    <ul class="breadcrumb-nav mod" style="">
        {foreach from=$steps item=step}
        <li><a id="tab_{$step.name}" href="#" class="{if $step.next}active {/if}{if $step.status=='Pending'}pending{/if} {if $step.status=='Completed'}disabled{/if}" onclick="return show_tab_el('{$step.name}')">{$lang[$step.name]} <em class="label {$step.status}">{$lang[$step.status]}</em></a></li>
        {/foreach}

    </ul>
    <div id="tabs_order" style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;background:#fff">

        {foreach from=$steps item=step}
        <div id="{$step.name}" class="subtab" {if !$step.next}style="display:none"{/if}>
            {include file="orders/step_`$step.name`.tpl"}
            <div class="clear"></div>
            <div class="right"><img src="templates/default/img/question-small-white.png" alt="" class="left"><a href="#" class="fs11" onclick="$('#description_{$step.name}').toggle();return false;">Learn more about {$lang[$step.name]}</a></div>
            <div class="clear"></div>
            <div style="display: none" id="description_{$step.name}">{$step.description}</div>  
        </div>
        {/foreach}

</div>
</div>
{literal}
<script>
    function show_tab_el(tab) {
        $('.subtab','#tabs_order').hide();
        $('#'+tab,'#tabs_order').show();

        $('.breadcrumb-nav a','#tabcontainer').removeClass('active');
        $('#tab_'+tab,'#tabcontainer').addClass('active');

        return false;
    }
</script>
{/literal}
{/if}