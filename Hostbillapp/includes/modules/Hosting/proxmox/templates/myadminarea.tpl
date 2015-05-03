{if $showvms}
<div style="margin:15px 0px 20px;">
    <h3>Client's virtual machines</h3>
<table class="data-table backups-list"  width="100%" cellspacing=0 >
   <thead>
        <tr>
            <td width="30"></td>
            <td >Id</td>
            <td width="120">Node</td>
            <td width="180">net0 MAC</td>
            <td width="120">Memory</td>
            <td width="120">Disk Space</td>
            <td width="120">Cores</td>
            <td width="120">Uptime</td>
        </tr>
    </thead>
    <tbody id="uptable">
        <tr>
            <td colspan="8">Loading virtual machines list...</td>
        </tr>
    </tbody>
</table>
</div>



<script type="text/javascript">
var p_service_id = "{$details.id}";
var p_app_id = "{$details.server_id}";
{literal}
    function loadClientVMs() {
        ajax_update('?cmd=proxmox&action=showvms',{id:p_service_id,server_id:p_app_id},'#uptable');
    }
    $(document).ready(function(){
        loadClientVMs();
        window.setInterval(loadClientVMs, 10000);
    });
</script>
<style type="text/css">
    ul.accor li > div.darker {
        background:#e3e2e4 !important;
        border-bottom:1px solid #d7d7d7  !important;
        border-left:1px solid #d7d7d7  !important;
        border-right:1px solid #d7d7d7  !important;
    }
    ul.accor li > a.darker {
        background:url("{/literal}{$template_dir}{literal}img/plus1.gif") no-repeat scroll 6px 50% #444547 !important;
    }
    #lmach {
        padding:10px;
    }
    a.power {
        float: left;
        display: block;
        width: 31px;
        height: 19px;
        margin-left: 3px;
        text-decoration: none;
        text-align: center;
        color: #555 !important;
        cursor: default;
    }
    a.power.on-inactive, a.power.off-inactive, a.power.on-disabled, a.power.off-disabled {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll 0 0;
    }

    a.power.on-inactive:hover {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -32px 0;
    }

    a.power.off-inactive:hover {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -64px 0;
    }

    a.power.on-active {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -96px 0;
    }

    a.power.off-active {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -128px 0;
    }
    .power.pending {
        background: transparent url({/literal}{$system_url}{literal}includes/types/onappcloud/images/power-bg.png) no-repeat scroll -160px 0;
        width: 65px;
        color: #909090 !important;
    }
    .vm-overview a.power {
        margin-left: 0;
        margin-right: 3px;
        text-shadow: none;
    }
    a.power.on-inactive:hover, a.power.off-inactive:hover {
        cursor: pointer;
        color: #fafafa !important;
    }

    a.power.on-active {
        color: #efe !important;
    }

    a.power.off-active {
        color: #fee !important;
    }

    a.power.on-disabled, a.power.off-disabled {
        color: #909090 !important;
        opacity: 0.8;
    }
    .power-status .yes {
        background:url("{/literal}{$system_url}{literal}includes/types/onappcloud/images/vm-on.png") no-repeat scroll 0 0 transparent;
        display:block;
        height:16px;
        text-indent:-99999px;
        width:16px;
    }
    .power-status .no {
        background:url("{/literal}{$system_url}{literal}includes/types/onappcloud/images/vm-off.png") no-repeat scroll 0 0 transparent;
        display:block;
        height:16px;
        text-indent:-99999px;
        width:16px;
    }
    .right-aligned {
        text-align:right;
    }
    .ttable td {
        padding:3px 4px;
    }
    table.data-table.backups-list thead {
        border:1px solid #DDDDDD;
    }
    table.data-table.backups-list thead {
        border-left:1px solid #005395;
        border-right:1px solid #005395;
    }
    table.data-table.backups-list thead {
        font-weight:bold;
        text-transform:uppercase;
    }
    table.data-table.backups-list thead td {
        background:none repeat scroll 0 0 #777777;
        color:#FFFFFF;
        padding:8px 5px;
    }
    table.data-table tbody td {
        background:none repeat scroll 0 0 #FFFFFF;
        border-top:1px solid #DDDDDD;
    }
    table.data-table tbody tr:hover td {
        background-color: #FFF5BD;
    }
    table.data-table tbody tr td {
        border-color:-moz-use-text-color #DDDDDD #DDDDDD;
        border-right:1px solid #DDDDDD;
        border-style:none solid solid;
        border-width:0 1px 1px;
        padding:8px;
    }
</style> {/literal}
{/if}<ul class="accor" style="display:none">
    <li><a href="#">{$lang.vpsdetails}</a>
        <div class="sor">
            <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                <tbody>
                    <tr >
                        <td width="150">VEID</td>
                        <td >
                            <input name="veid" value="{$details.veid}" size="5" />
                    </tr>
                    <tr>
                        <td width="150">{$lang.Node}</td>
                        <td >
                            <div id="node_">
                                <input name="node" value="{$details.node}" size="5"  />

		   {if $custom.GetNodes}
                                <input type="button" name="customfn" value="{$lang.getnodes}" onclick="ajax_update('?cmd=accounts&action=customfn&val=GetNodes&id={$details.id}',{literal}{}{/literal},'#node_',true);return false;" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                        {/if}
                            </div>
                        </td>

                    </tr>
                    <tr>
                        <td>{$lang.virttype}</td>
                        <td><strong>{$details.type}</strong></td>
                    </tr>
                    <tr>
                        <td>{$lang.ostemplate}</td>
                        <td>
                            <div id="ost_">

                                <input value="{$details.os}" name="os"  />

			{if $custom.GetOsTemplates}
                                <input type="button" name="customfn" value="{$lang.getostemplates}" onclick="ajax_update('?cmd=accounts&action=customfn&val=GetOsTemplates&id={$details.id}',{literal}{}{/literal},'#ost_',true);return false;" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>{/if}
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td>{$lang.mainip}</td>
                        <td><input value="{$details.ip}" name="ip" /></td>
                    </tr>

			{if $details.additional_ip}
				{foreach from=$details.additional_ip item=ip}

                    <tr>
                        <td>{$lang.addip}</td>
                        <td><input value="{$ip}" name="additional_ip[]" /></td>
                    </tr>
				{/foreach}
                    <tr>
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" id="addip0" style="display:none" />
                            <a href="#" onclick="$(this).hide();$('#addip0').show();$('#addip00').show();return false;">{$lang.clicktoadd}</a>

                            <a href="#" onclick="$(this).hide();$('#addip1').show();return false;" id="addip00" style="display:none">{$lang.addmoreip}</a></td>
                    </tr>
			{else}

                    <tr>
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" id="addip0" style="display:none" />
                            <a href="#" onclick="$(this).hide();$('#addip0').show();$('#addip00').show();return false;">{$lang.clicktoadd}</a>

                            <a href="#" onclick="$(this).hide();$('#addip1').show();return false;" id="addip00" style="display:none">{$lang.addmoreip}</a></td>
                    </tr>

			{/if}



                    <tr style="display:none" id="addip1">
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" />  <a href="#" onclick="$(this).hide();$('#addip2').show();return false;">{$lang.addmoreip}</a></td>
                    </tr>
                    <tr style="display:none"  id="addip2">
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" />  <a href="#" onclick="$(this).hide();$('#addip3').show();return false;">{$lang.addmoreip}</a></td>
                    </tr>
                    <tr style="display:none"  id="addip3">
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" />  <a href="#" onclick="$(this).hide();$('#addip4').show();return false;">{$lang.addmoreip}</a></td>
                    </tr>
                    <tr style="display:none"  id="addip4">
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" />  <a href="#" onclick="$(this).hide();$('#addip5').show();return false;">{$lang.addmoreip}</a></td>
                    </tr>
                    <tr style="display:none"  id="addip5">
                        <td>{$lang.addip}</td>
                        <td><input value="" name="additional_ip[]" /> </td>
                    </tr>

                    <tr>
                        <td>{$lang.disklimit}</td>
                        <td><input value="{$details.disk_limit}" name="disk_limit"  size="5" /></td>
                    </tr>
                    <tr {if $details.ptype=='Server'}style="display:none"{/if}>
                        <td>{$lang.bwlimit}</td>
                        <td><input value="{$details.bw_limit}" name="bw_limit"  size="5"/></td>
                    </tr>
                    <tr>
                        <td>{$lang.guaranteed_ram}</td>
                        <td><input value="{$details.guaranteed_ram}" name="guaranteed_ram"  size="5"/></td>
                    </tr>
                    <tr {if $details.type=='Xen'}style="display:none"{/if}>
                        <td>{$lang.burstable_ram}</td>
                        <td><input value="{$details.burstable_ram}" name="burstable_ram"  size="5"/></td>
                    </tr>

		{if $details.extra}
                            {foreach from=$details.extra item=ip key=ex}
                                    {if is_array($ip) && isset($ip.type)}
                                        {if $ip.type == 'check'}
                    <tr>
                        <td>{if $lang.$ex}{$lang.$ex}{else}{$ex}{/if}</td>
                        <td><input type="hidden" name="extra[{$ex}][type]" value="check" /><input value="1" {if $ip.value == 1}checked="checked"{/if} name="extra[{$ex}][value]" type="checkbox" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                            <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{if $ip.value == 1}{$lang.Yes}{else}{$lang.No}{/if}</span></td>
                    </tr>
                                        {elseif $ip.type == 'hidden'}
                <input type="hidden" name="extra[{$ex}][type]" value="hidden" />
                <input type="hidden" name="extra[{$ex}][value]" value="{$ip.value}" />
                                        {/if}
                                    {else}
                <tr>
                    <td>{if $lang.$ex}{$lang.$ex}{else}{$ex}{/if}</td>
                    <td><input value="{$ip}" name="extra[{$ex}]" class="{if $details.status!='Pending' && $details.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $details.status!='Pending' && $details.status!='Terminated'}style="display:none"{/if}/>
                        <span class="{if $details.status!='Pending' && $details.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $details.status=='Pending' || $details.status=='Terminated'}style="display:none"{/if}>{$ip}</span></td>
                </tr>
                                    {/if}
                            {/foreach}

			{/if}
                </tbody></table>
        </div>
    </li>
</ul>