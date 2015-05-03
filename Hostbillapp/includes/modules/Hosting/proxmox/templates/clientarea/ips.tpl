{if $subdo=='assignip'}
<form action="" method="post">
    <input type="hidden" name="make" value="addnewipaddress">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="checker">
        <tbody><tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">{$lang.interface} <a class="vtip_description" title="Select which network interface this IP address should be assigned to. "></a></span>
                        <select style="min-width:250px;" name="assign[network_interface_id]" required="required" id="interface_id" onchange="loadIps()">
                            <option value=""></option>
                            {foreach from=$interfaces item=n}
                            <option value="{$n.id}" >{$n.label}</option>
                            {/foreach}
                        </select>
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <div>
                        <span class="slabel">IP Address</span>
                        <select style="min-width:250px;" name="assign[ip_address_id]" id="ip_address_id">
                            <option value="">Select interface first</option>
                        </select> <img src="includes/types/onappcloud/images/ajax-loader.gif" style="display:none" id="iploader" alt="loading"/>

                    </div>
                </td>
            </tr>


            <tr>
                <td align="center" colspan="2" style="border:none">
                    <input type="submit" class="blue" value="{$lang.assign_new_ip}">
                </td>
            </tr>
        </tbody></table>
    {securitytoken} </form>
{literal}
<script type="text/javascript">
    function loadIps() {
        $('#iploader').show();
        var w=$('#interface_id').val();
        $('#ip_address_id').attr('disabled','disabled').empty();
        if(w=='') {
        $('#iploader').hide();
            $('#ip_address_id').removeAttr('disabled');
            $('#ip_address_id').append('<option value="">Select interface first</option>');
            return;
        }
        $.getJSON('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=fetchips{literal}', {network_interface_id:w}, function(data){
            $('#ip_address_id').removeAttr('disabled');
            $('#iploader').hide();
            if(data && data.ips) {
                for(var i in data.ips) {
                    $('#ip_address_id').append('<option value="'+data.ips[i].id+'">'+data.ips[i].descriptor+'</option>');
                }
            }
        });
    }
</script>
{/literal}
{else}

{if $vpsaddons.ip.available}<div id="addon_bar" style="display:none; padding:20px 10px;">
    {foreach from=$alladdons item=i}
    {if $i.module=='class.onapp_ip.php'}

    <form name="" action="?cmd=cart&cat_id=addons" method="post">
        <input name="action" type="hidden" value="add">
        <input name="id" type="hidden" value="{$i.id}">
        <input name="account_id" type="hidden" value="{$service.id}">

        <table width="100%" cellspacing=0 cellpadding=5>
            <tbody>
                <tr>
                    <td >
                        <strong>{$i.name}</strong>{if $i.description!=''}<br />{$i.description}{/if}
                    </td><td>
                        {if $i.paytype=='Free'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="free" />
                        {$lang.price}:<strong> {$lang.Free}</strong>

                        {elseif $i.paytype=='Once'}
                        <input type="hidden" name="addon_cycles[{$i.id}]" value="once" />
                        {$lang.price}: {$i.m|price:$currency} {$lang.once} / {$i.m_setup|price:$currency} {$lang.setupfee}
                        {else}
                        <select name="addon_cycles[{$i.id}]" >
	 {if $i.d!=0}<option value="d" {if $cycle=='d'} selected="selected"{/if}>{$i.d|price:$currency} {$lang.d}{if $i.d_setup!=0} + {$i.d_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.w!=0}<option value="w" {if $cycle=='w'} selected="selected"{/if}>{$i.w|price:$currency} {$lang.w}{if $i.w_setup!=0} + {$i.w_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.m!=0}<option value="m" {if $cycle=='m'} selected="selected"{/if}>{$i.m|price:$currency} {$lang.m}{if $i.m_setup!=0} + {$i.m_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.q!=0}<option value="q" {if $cycle=='q'} selected="selected"{/if}>{$i.q|price:$currency} {$lang.q}{if $i.q_setup!=0} + {$i.q_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.s!=0}<option value="s" {if $cycle=='s'} selected="selected"{/if}>{$i.s|price:$currency} {$lang.s}{if $i.s_setup!=0} + {$i.s_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.a!=0}<option value="a" {if $cycle=='a'} selected="selected"{/if}>{$i.a|price:$currency} {$lang.a}{if $i.a_setup!=0} + {$i.a_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.b!=0}<option value="b" {if $cycle=='b'} selected="selected"{/if}>{$i.b|price:$currency} {$lang.b}{if $i.b_setup!=0} + {$i.b_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                            {if $i.t!=0}<option value="t" {if $cycle=='t'} selected="selected"{/if}>{$i.t|price:$currency} {$lang.t}{if $i.t_setup!=0} + {$i.t_setup|price:$currency} {$lang.setupfee}{/if}</option>{/if}
                        </select>

                        {/if}
                        <br />
                    </td>
                    <td width="25%" align="right">
                        <input type="submit" value="{$lang.ordernow}" style="font-weight:bold;" class="blue"/>
                        <span class="fs11">{$lang.or} <a href="#" onclick="$('#addon_bar').hide();return false" class="fs11" >{$lang.cancel}</a></span>
                    </td>
                </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>

			{/if}
		{/foreach}
</div>{/if}

<div class="notice">{$lang.networkrebuildnote}</div>

<table class="data-table backups-list"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td>{$lang.ipadd}</td>
            <td>{$lang.netmask}</td>
            <td>{$lang.gateway}</td>
            <td>{$lang.interface}</td>
            <td width="60"></td>
        </tr>
    </thead>
    {foreach item=ip from=$ips}
    <tr>
        <td >{$ip.address}</td>
        <td>{$ip.netmask} </td>
        <td>{$ip.gateway}</td>
        <td>{$ip.interface}</td>
        <td>
            <a title="Delete"  href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=deleteip&ipid={$ip.id}&security_token={$security_token}" onclick="return  confirm('{$lang.suretodeleteip}?')" class="small_control small_delete fs11">{$lang.delete}</a>
        </td>
    </tr>
    {foreachelse}
    <tr>
        <td colspan="4">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>

<div style="padding:10px 0px;text-align:right">

		{if $vpsaddons.ip.available}
    <input type="button" class="gray" onclick="$('#addon_bar').toggle();return false;" value="{$lang.ordernewip}"/>
    {/if}
    <input type="button" class="blue" onclick="if(confirm('{$lang.rebuildconfirm}'))window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=rebuildnetwork&security_token={$security_token}'" value="{$lang.rebuildnetwork}"/>

    {if $allowaddingip}
    <input type="button" class="blue" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=ips&vpsid={$vpsid}&do=assignip'" value="{$lang.assign_new_ip}"/>
    <span class="text">{$lang.freeipleft1} <b>{$allowaddingip}</b> {$lang.freeipleft}</span>

    {/if}
</div>

{/if}
