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
                    <td width="90" align="right">{$lang.memory}</td>
                    <td ><b {if $CreateVM.limits.mem<1}style="color:red"{/if}>{$CreateVM.limits.mem} MB</b></td>
                </tr>
                <tr>
                    <td width="90" align="right">{$lang.storage}</td>
                    <td ><b {if $CreateVM.limits.disk<1}style="color:red"{/if}>{$CreateVM.limits.disk} GB</b></td>
                </tr>
                <tr>
                    <td width="90" align="right">{$lang.cpucores}</td>
                    <td ><b {if $CreateVM.limits.cpu<1}style="color:red"{/if}>{$CreateVM.limits.cpu}</b></td>
                </tr>
                <tr>
                    <td width="90" align="right">{$lang.bandwidth}</td>
                    <td ><b {if $CreateVM.limits.baw<1}style="color:red"{/if}>{$CreateVM.limits.baw}</b></td>
                </tr>
                <tr>
                    <td width="90" align="right">{$lang.ipcount}</td>
                    <td ><b {if $CreateVM.limits.ips<1}style="color:red"{/if}>{$CreateVM.limits.ips}</b></td>
                </tr>
                {if $CreateVM.limits.swap}
                 <tr>
                    <td width="90" align="right">{$lang.vpslimit}</td>
                    <td ><b>{$CreateVM.limits.swap}</b></td>
                </tr>
                {/if}
                {if $CreateVM.limits.vps !== false}
                 <tr>
                    <td width="90" align="right">{$lang.vpslimit}</td>
                    <td ><b {if $CreateVM.limits.vps<1}style="color:red"{/if}>{$CreateVM.limits.vps}</b></td>
                </tr>
                {/if}

            </tbody></table>
        <div style="text-align: right"><a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=resources" class="fs11">Increase limits</a></div>
    </div>
    
    <form method="post" action="">
        <input type="hidden" value="createmachine" name="make" />
        {if $CreateVM.types && count($CreateVM.types) < 2}
            <input type="hidden" value="{$CreateVM.types[0]}" name="CreateVM[type]" id="virtual_machine_type" />
        {/if}
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="checker">
            <tr>
                <td colspan="2"><span class="slabel">{$lang.hostname}</span><input type="text" size="30" required="required" name="CreateVM[hostname]"  class="styled" value="{$submit.CreateVM.hostname}"/></td>
            </tr>
            {if $CreateVM.types && count($CreateVM.types) > 1}
                <tr>
                    <td colspan="2">
                        <span class="slabel">{$lang.type}</span>
                        <select style="min-width:250px;" required="required" name="CreateVM[type]" onchange="opt_changeos();" id="virtual_machine_type"  >
                            {foreach from=$CreateVM.types item=type}
                                <option value="{$type}" {if $submit.CreateVM.type==$type}selected="selected"{/if}>{if $type == 'openvz'}OpenVZ{elseif $type=='xen'}Xen PV{elseif $type=='kvm'}KVM{else}Xen HVM{/if}</option>     
                            {/foreach}
                        </select>
                    </td>
                </tr>
            {/if}
            <tr>
                <td colspan="2">
                    <span class="slabel">{$lang.ostemplate}</span>
                    <select style="min-width:250px;" required="required" name="CreateVM[ostemplate]" id="virtual_machine_ostemplate"  >
                        {foreach from=$CreateVM.ostemplates item=templaes key=type}
                            {foreach from=$templaes item=templa}
                                <option class="type_{$type}" value="{$templa[0]}" {if $submit.CreateVM.ostemplate==$templa[0]}selected="selected"{/if}>{$templa[1]} {if $templa[2] && $templa[2]>0}( {$templa[2]|price:$currency} ){/if}</option>
                            {/foreach}
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><span class="slabel">{$lang.password}</span><input type="text" size="30" name="CreateVM[rootpwd]" class="styled" value="{$submit.CreateVM.rootpwd}"/></td>
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
            {if $CreateVM.limits.burstmem}
                <tr>
                    <td colspan="2">
                        <div class='input-with-slider'>
                            <span class="slabel opt_ opt_xen">{$lang.swapdisk}</span>
                            <span class="slabel opt_ opt_openvz">{$lang.burstable_ram}</span>
                            <input type="text" size="4" name="CreateVM[burstmem]" class="styled" value="{if $submit.CreateVM.burstmem}{$submit.CreateVM.burstmem}{else}{$CreateVM.limits.burstmem}{/if}" id="virtual_machine_burstmem"/>
                            MB
                            <div class='slider' max='{$CreateVM.limits.burstmem}' min='0' step='4' target='#virtual_machine_burstmem'></div>
                            <script type="text/javascript">$('[name="CreateVM[type]"]').change({literal}function(){$('.opt_').hide(); if($('[name="CreateVM[type]"]').val() == 'openvz') $('.opt_openvz').show(); else $('.opt_xen').show();}{/literal}).change();</script>
                        </div>
                    </td>
                </tr>
            {/if}
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
                        <input type="text" size="4" required="required" name="CreateVM[disk_size]" class="styled" value="{if $submit.CreateVM.disk_size}{$submit.CreateVM.disk_size}{else}{$CreateVM.limits.disk}{/if}" id="virtual_machine_cpu_disk_size"/>
                        GB
                        <div class='slider' max='{$CreateVM.limits.disk}' total='{$CreateVM.limits.disk}' min='1' step='1' target='#virtual_machine_cpu_disk_size'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class='input-with-slider'>
                        <span class="slabel">{$lang.bandwidth}</span>
                        <input type="text" size="4" required="required" name="CreateVM[bandwidth]" class="styled" value="{if $submit.CreateVM.bandwidth}{$submit.CreateVM.bandwidth}{else}{$CreateVM.limits.baw}{/if}" id="virtual_machine_bandwidth"/>
                        GB
                        <div class='slider' max='{$CreateVM.limits.baw}' total='{$CreateVM.limits.baw}' min='1' step='1' target='#virtual_machine_bandwidth'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div class='input-with-slider'>
                        <span class="slabel">{$lang.ipcount}</span>
                        <input type="text" size="4" required="required" name="CreateVM[ip_address]" class="styled" value="{if $submit.CreateVM.ip_address}{$submit.CreateVM.ip_address}{else}{$CreateVM.limits.ips}{/if}" id="virtual_machine_ip_address"/>
                        <div class='slider' max='{$CreateVM.limits.ips}' total='{$CreateVM.limits.ips}' min='1' step='1' target='#virtual_machine_ip_address'></div>
                    </div>
                    <div class="clear"></div>
                </td>
            </tr>
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
                        total+=(parseInt($('#virtual_machine_disk_size').val()) + parseInt($('#virtual_machine_swap_disk_size').val())) * mvar.disk_size;
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
        function opt_changeos(){
            
            var typ = $('#virtual_machine_type').val();
            if(!typ.length)
                return;
            var reg = new RegExp(typ),
                select = false;
            $('#virtual_machine_ostemplate option').each(function(){
                var a="";
                    a.ma
                if( !$(this).val().match(reg) ){
                    $(this).hide();
                    if($(this).is(':selected'))
                        select = true;
                }else{
                    if(select){
                        select = false;
                        $(this).prop('selected',true).attr('selected','selected');
                    }
                    $(this).show();
                }
            });
            if(select){
                $('#virtual_machine_ostemplate option:first:visible').prop('selected',true).attr('selected','selected');
            }
        }
        {/literal}
    </script>



    {securitytoken}
</form>
</div>
{include file="`$onappdir`footer.cloud.tpl"}