{include file="`$onappdir`header.cloud.tpl"}
<div class="header-bar">
    <h3>{$lang.cloudlabel1}</h3>
    <div class="clear"></div>
</div>
<div class="content-bar">

    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="tonapp" style="margin:10px 0px;">

        <thead>
            <tr>
                <th width="66"></th>
                <th>{$lang.hostname}</th>
                <th width="70">{$lang.diskspace}</th>
                <th width="70">{$lang.memory}</th>
                <th width="70">Cores</th>
                <th width="70">{$lang.bandwidth}</th>
                <th width="60"><a class="btn btn-mini" href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=refresh"><i class="icon icon-refresh" title="{$lang.refresh|capitalize}"></i></a></th>
            </tr>
        </thead>
        <tbody id="updater">
            {if $provisioning_type=='cloud'}
            {if $MyVMs}
                {foreach from=$MyVMs item=vm name=foo}
                    <tr >
                        <td id="vmswitch_{$vm.id}" rel="{$vm.id}">
                            <div style="opacity: 0.4; filter: alpha(opacity = 40)">
                                <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}" class="iphone_switch_container iphone_switch_container_off">
                                    <img src="templates/common/cloudhosting/images/iphone_switch_container_off.png" alt="" />
                                </a>
                            </div>
                        </td>
                        <td><a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}&vpsdo=vmdetails" ><b>{$vm.name}</b></a></td>
                        <td>{$vm.disk_limit} GB</td>
                        <td>{$vm.guaranteed_ram} MB</td>
                        <td>{$vm.extra.cpu}</td>
                        <td>{$vm.bw_limit} GB</td>
                        <td class="fs11">
                            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}&vpsdo=vmdetails"  class="ico ico_wrench" title="{$lang.edit}">{$lang.edit}</a>
                            <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=destroy&vpsid={$vm.id}&security_token={$security_token}" onclick="return  confirm('{$lang.sure_to_destroy}?')" class="ico ico_cross" title="{$lang.delete}">{$lang.delete}</a>
                        </td>
                    </tr>
                {/foreach}
            {else}
                <tr >
                    <td colspan="7" align="center">{$lang.nomachinesnote}, <a href="?cmd=clientarea&action=services&service={$service.id}&vpsdo=createvm">{$lang.addservernote}</a>.</td>
                </tr>

            {/if}
            {else}
                
            {/if}
        </tbody>
        
    </table>
    {literal}
    <script type="text/javascript">
        $('[id^="vmswitch_"]').each(function(){
            var that = this;
            $.post('{/literal}?cmd=clientarea&action=services&service={$service.id}&vpsid={$vm.id}&vpsdo=vmdetails&status{literal}', {vpsid:$(this).attr('rel'), vpsdo:'vmdetails'},  function(data){$(that).html(data)});
        });
    </script>
    {/literal}
</div>
{include file="`$onappdir`footer.cloud.tpl"}