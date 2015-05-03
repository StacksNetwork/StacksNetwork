<div class="header-bar">
    <h3 class="resources hasicon">{$lang.updownlabel}</h3>

    <div class="clear"></div>
</div>
<div class="content-bar">
    {if $provisioning_type=='single'}
    <div class="notice">
       {$lang.upsinglenotice}
    </div>

    {elseif $fieldupgrades}
    <div class="notice">
       {$lang.upcloudnotice}
    </div>
    {/if}
     {if $fieldupgrades}
    <h3 class="summarize">{$lang.resuplabel}</h3>
    <form action="" method="post">
        <input type="hidden" value="upgradeconfig" name="make" />
        <table border="0" cellspacing="0" cellpadding="0" width="100%" class="ttable">
              <thead><tr>
                 <th width="160"></th>
                 <th width="160" align="center">{$lang.oldsetting}</th>
                 <th align="center" style="padding-left:20px">{$lang.newsetting}</th>
                </tr></thead>
            {foreach from=$fieldupgrades item=cf key=k}

            {include file=$cf.configtemplates.upgrades}

            {/foreach}

            <tr>
                <td colspan="3" align="right" style="border-bottom:none;background:none;"> <input type="submit" value="{$lang.continue}" class="blue"/></td>
            </tr>
        </table> {foreach from=$fieldupgrades item=cf key=k}<input type="hidden" name="fupgrade[{$k}][old_qty]" value="{$cf.qty}" />
        {foreach from=$cf.data item=it key=kk}<input type="hidden" name="fupgrade[{$k}][old_config_id]" value="{$kk}" />{/foreach}{/foreach}
        {securitytoken}</form>

    {/if}

    {if $upgrades && $upgrades!=-1}
    <h3 class="summarize">{$lang.uppckg}</h3>
    <div id="addon_bar" style="padding: 20px 10px;">
    <form action="" method="post">
        <input type="hidden" value="upgrade" name="make" />

        <table border="0" cellspacing="0" cellpadding="0" width="100%" style="margin-bottom:10px">

            <tr>
                <td>{$lang.updownto}</td>
                <td><select name="upgrades" onchange="sss(this)" >
		  {foreach from=$upgrades item=up}
                        <option value="{$up.id}">{$up.catname}: {$up.name}</option>
		  {/foreach}</select></td>

                <td>
                    <div id="billing_options">
          	{foreach from=$upgrades item=i key=k}
                        <div {if $k!=0}style="display:none"{/if} class="up_desc">
                            {if $i.paytype=='Free'}
                            <input type="hidden" name="cycle[{$i.id}]" value="Free" />
    			 {$lang.price}: <strong> {$lang.Free}</strong>
                            {elseif $i.paytype=='Once'}
                            <input type="hidden" name="cycle[{$i.id}]" value="Once" />
    	 {$lang.price}: {$i.m|price:$currency:true:true} {$lang.once}
                            {else}
	  {$lang.pickcycle}
                            <select name="cycle[{$i.id}]">
                                {if $i.h!=0}<option value="h" {if $i.cycle=='h'}selected="selected"{/if}>{$i.h|price:$currency:true:true} {$lang.h}</option>{/if}
                                {if $i.d!=0}<option value="d" {if $i.cycle=='d'}selected="selected"{/if}>{$i.d|price:$currency:true:true} {$lang.d}</option>{/if}
                                {if $i.w!=0}<option value="w" {if $i.cycle=='w'}selected="selected"{/if}>{$i.w|price:$currency:true:true} {$lang.w}</option>{/if}
                                {if $i.m!=0}<option value="m" {if $i.cycle=='m'}selected="selected"{/if}>{$i.m|price:$currency:true:true} {$lang.m}</option>{/if}
                                {if $i.q!=0}<option value="q" {if $i.cycle=='q'}selected="selected"{/if}>{$i.q|price:$currency:true:true} {$lang.q}</option>{/if}
                                {if $i.s!=0}<option value="s" {if $i.cycle=='s'}selected="selected"{/if}>{$i.s|price:$currency:true:true} {$lang.s}</option>{/if}
                                {if $i.a!=0}<option value="a" {if $i.cycle=='a'}selected="selected"{/if}>{$i.a|price:$currency:true:true} {$lang.a}</option>{/if}
                                {if $i.b!=0}<option value="b" {if $i.cycle=='b'}selected="selected"{/if}>{$i.b|price:$currency:true:true} {$lang.b}</option>{/if}
                                {if $i.t!=0}<option value="t" {if $i.cycle=='t'}selected="selected"{/if}>{$i.t|price:$currency:true:true} {$lang.t}</option>{/if}
                            </select>
                            {/if}
                        </div>
		 	 {/foreach}
                    </div>
                </td>

                <td> <input type="submit" value="{$lang.continue}" class="blue"/></td>
            </tr>

        </table>



        <div class="fs11" id="up_descriptions" >
		  	{foreach from=$upgrades item=up key=k}
            <span {if $k!=0}style="display:none"{/if} class="up_desc">{$up.description}</span>
		  {/foreach}
        </div>


 

        <script type="text/javascript">
            {literal}
            function sss(el) {
                $('.up_desc').hide();
                var index=$(el).eq(0).prop('selectedIndex');
                $('#up_descriptions .up_desc').eq(index).show();
                $('#billing_options .up_desc').eq(index).show();
            }
            {/literal}
        </script>
        {securitytoken}</form></div>

    {/if}

</div>