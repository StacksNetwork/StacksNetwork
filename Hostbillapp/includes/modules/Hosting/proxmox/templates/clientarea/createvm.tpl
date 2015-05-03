{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3 class="{$vpsdo} hasicon">{$lang.createnewserver}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar nopadding" style="position:relative">
    <div class="resources_box">
        <strong><em>{$lang.availableresources}</em></strong>
<table cellspacing="0" cellpadding="0" width="100%" class="ttable">
    <tbody>
        <tr>
            <td width="70" align="right">{$lang.memory}</td>
            <td ><b {if $CreateVM.limits.mem<1}style="color:red"{/if}>{$CreateVM.limits.mem} MB</b></td>
        </tr>
         <tr>
            <td width="70" align="right">{$lang.storage}</td>
            <td ><b {if $CreateVM.limits.disk<1}style="color:red"{/if}>{$CreateVM.limits.disk} GB</b></td>
        </tr>
         <tr>
            <td width="70" align="right">{$lang.cpucores}</td>
            <td ><b {if $CreateVM.limits.cpu<1}style="color:red"{/if}>{$CreateVM.limits.cpu}</b></td>
        </tr>

    </tbody></table>
        <div style="text-align: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resources" class="fs11">Increase limits</a></div>
    </div>

<form method="post" action="">
    <input type="hidden" value="createmachine" name="make" />
    {if !$CreateVM.network_types}<input type="hidden" name="CreateVM[network_type_id]" value="{$CreateVM.network_type_id}"/>{/if}
    {if !$CreateVM.storage_zones}<input type="hidden" name="CreateVM[storage_zone_id]" value="{$CreateVM.storage_zone_id}"/>{/if}
    {if !$CreateVM.bus_types}<input type="hidden" name="CreateVM[bus_type_id]" value="{$CreateVM.bus_type_id}"/>{/if}

    <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
{if $CreateVM.hv_zones}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.Zone}</span>
            <select name="CreateVM[hypervisor_group_id]" id="virtual_machine_hypervisor_zone_id"  style="min-width:250px;" >
                    <option value="0" {if $submit.CreateVM.hypervisor_group_id=='0' || !$submit.CreateVM.hypervisor_group_id}selected="selected"{/if}>{$lang.firstavailable}</option>
                    {foreach from=$CreateVM.hv_zones item=zone}
                        <option value="{$zone[0]}" {if $submit.CreateVM.hypervisor_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                    {/foreach}
                </select></td>
        </tr>
{/if}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.hostname}</span><input type="text" size="30" required="required" name="CreateVM[hostname]"  class="styled" value="{$submit.CreateVM.hostname}"/></td>
        </tr>
        {if $virtualization=='openvz'}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.password}</span><input type="text" size="30" name="CreateVM[initial_root_password]" class="styled" value="{$submit.CreateVM.initial_root_password}"/></td>
        </tr>
        {/if}
       
        <tr>
            <td colspan="2"><span class="slabel">{$lang.ostemplate}</span><select style="min-width:250px;" required="required" name="CreateVM[template_id]" id="virtual_machine_template_id"  >
                   
                    {foreach from=$CreateVM.ostemplates item=templa}
                    <option value="{$templa[0]}" {if $submit.CreateVM.template_id==$templa[0]}selected="selected"{/if}>{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency} ){/if}</option>
                   {/foreach}

                </select></td>

        </tr>

        <tr>
            <td colspan="2">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.RAM}</span>
                    <input type="text" size="4" required="required" name="CreateVM[memory]" class="styled" value="{if $submit.CreateVM.memory}{$submit.CreateVM.memory}{else}{$CreateVM.limits.mem}{/if}" id="virtual_machine_memory"/>
                    MB
                    <div class='slider' max='{$CreateVM.limits.mem}' min='0' step='4' target='#virtual_machine_memory'></div>
                </div>

            </td>

        </tr>

        <tr>
            <td colspan="2">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.cpucores}</span>
                    <input type="text" size="4" required="required" name="CreateVM[cpu]" class="styled" value="{if $submit.CreateVM.cpu}{$submit.CreateVM.cpu}{else}{$CreateVM.limits.cpu}{/if}" id="virtual_machine_cpu"/>

                    <div class='slider' max='{$CreateVM.limits.cpu}' min='1' step='1' total="{$CreateVM.limits.cpu}"  target='#virtual_machine_cpu'></div>
                </div>

            </td>

        </tr>

   
        <tr>
            <td colspan="2" id="disk-row">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.disk_limit}</span>
                    <input type="text" size="4" required="required" name="CreateVM[primary_disk_size]" class="styled" value="{if $submit.CreateVM.primary_disk_size}{$submit.CreateVM.primary_disk_size}{else}{$CreateVM.limits.disk}{/if}" id="virtual_machine_cpu_primary_disk_size"/>
                    GB
                    <div class='slider' {if $virtualization=='openvz'}max='{$CreateVM.limits.disk-1}'{else} max='{$CreateVM.limits.disk}'{/if} total='{$CreateVM.limits.disk}' min='1' step='1' minus='#virtual_machine_swap_disk_size'  target='#virtual_machine_cpu_primary_disk_size'></div>
                </div>
                <div class="clear"></div>


                 {if $CreateVM.bus_types}

                 <span class="slabel">Bus/device</span>
                    <select name="CreateVM[bus_type_id]" id="virtual_machine_bus_type_id"  style="min-width:250px;" >
                            {foreach from=$CreateVM.bus_types item=zone}
                                <option value="{$zone}" {if $submit.CreateVM.bus_type_id==$zone}selected="selected"{/if}>{$zone}</option>
                            {/foreach}
                    </select>

                  {/if}
                 {if $CreateVM.storage_zones}

                <div class="clear"></div>
                 <span class="slabel">{$lang.storagedc}</span>
                    <select name="CreateVM[storage_zone_id]" id="virtual_machine_data_zone_id"  style="min-width:250px;" >
                            {foreach from=$CreateVM.storage_zones item=zone}
                                <option value="{$zone[0]}" {if $submit.CreateVM.storage_zone_id==$zone[0]}selected="selected"{/if}>{$zone[1]}</option>
                            {/foreach}
                    </select>

                  {/if}

               
            </td>

        </tr>
        
        {if $virtualization=='openvz'}
        <tr id="swap-row">
            <td colspan="2">
                <div class='input-with-slider'>
                    <span class="slabel">{$lang.swapdisk}</span>
                    <input type="text" size="4" required="required" name="CreateVM[swap_disk_size]" class="styled" value="0" id="virtual_machine_swap_disk_size"/>
                    GB
                    <div class='slider' max='{$CreateVM.limits.disk-1}' min='1' step='1' total='{$CreateVM.limits.disk}' minus='#virtual_machine_cpu_primary_disk_size'  target='#virtual_machine_swap_disk_size'></div>
                </div>
                <div class="clear"></div>
                
            </td>

        </tr>
        {/if}

        {if $CreateVM.network_types}
        <tr>
            <td colspan="2"><span class="slabel">Network device</span>
            <select name="CreateVM[network_type_id]" id="virtual_machine_network_type_id"  style="min-width:250px;" >
                    {foreach from=$CreateVM.network_types item=zone}
                        <option value="{$zone}" {if $submit.CreateVM.network_type_id==$zone}selected="selected"{/if}>{$ntypes[$zone]}</option>
                    {/foreach}
                </select></td>
        </tr>
{/if}

  
     {if $metered_variables}
        <tr>
            <td colspan="2"><span class="slabel">{$lang.priceperhour}</span>
                <span class="slabel">{$currency.sign}<span id="hourly_price">0.00</span>{$currency.code}</span>
            <script type="text/javascript">
                {literal}  var mvar={}; {/literal}
                {foreach from=$metered_variables item=v}
                    mvar['{$v.variable_name}']=parseFloat('{$v.prices[0].price}');
                {/foreach}

                            {literal}
                function update_metered_totals() {
                    var target=$('#hourly_price');
                    var total=0;
                    if(mvar.memory) {
                        total+=parseInt($('#virtual_machine_memory').val()) * mvar.memory;
                    }
                    if(mvar.cpus) {
                        total+=parseInt($('#virtual_machine_cpus').val()) * mvar.cpus;
                    }
                    if(mvar.cpu_shares) {
                        total+=parseInt($('#virtual_machine_cpu_shares').val()) * mvar.cpu_shares;
                    }
                    if(mvar.ip_addresses) {
                        total+=1 * mvar.ip_addresses;
                    }
                    if(mvar.disk_size) {
                        total+=(parseInt($('#virtual_machine_cpu_primary_disk_size').val()) + parseInt($('#virtual_machine_swap_disk_size').val())) * mvar.disk_size;
                    }
                    target.text(total.toFixed(2));
                }

                if(typeof('appendLoader')=='function') {
                    appendLoader('update_metered_totals');
                } else {
                    $(document).ready(function(){
                          update_metered_totals();
                    });
                }
            </script>
            {/literal}
            </td>
        </tr>
{/if}


        <tr>
            <td align="center" style="border:none" colspan="2">

                <input type="submit" value="{$lang.CreateVM}" style="font-weight:bold" class=" blue" />
            </td>
        </tr>
    </table>


    <script type="text/javascript">
        {literal}
        $(document).ready(function(){
            init_sliders();
        });
        {/literal}
    </script>



{securitytoken}
</form>
</div>
{include file="`$onappdir`footer.cloud.tpl"}