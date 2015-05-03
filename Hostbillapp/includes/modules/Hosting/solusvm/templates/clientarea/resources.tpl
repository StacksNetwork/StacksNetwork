{if $vpsdo=='upgrade'}
    {include file="`$onappdir`header.cloud.tpl"}
    {include file="`$onappdir`upgrade.tpl"}
    {include file="`$onappdir`footer.cloud.tpl"}

{else}

    {include file="`$onappdir`header.cloud.tpl"}
    <div class="header-bar">
        <h3 class="resources hasicon">{$lang.reslabel}</h3>

        <div class="clear"></div>
    </div>
    <div class="content-bar ">
        {if $provisioning_type=='cloud'}
            <div class="notice">{$lang.resnotice} </div>
            <table cellspacing="0" cellpadding="0" width="100%" class="ttable">
                <thead>
                    <tr>
                        <th></th>
                        <th>{$lang.Usage}</th>
                        <th width="120">{$lang.Totallabel}</th>
                        <th width="120">{$lang.Leftlabel}</th>
                    </tr>
                </thead>
                <tbody><tr>
                        <td width="120"><b>{$lang.memory}</b></td>
                        <td >
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.memory_percent>90}red{else}green{/if}" style="width:{$FastStat.memory_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.memory_avail} MB</td>
                        <td class="bigger">{$FastStat.memory_free} MB</td>
                    </tr>
                    <tr>
                        <td><b>{$lang.storage}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.disk_percent>90}red{else}green{/if}" style="width:{$FastStat.disk_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.disk_avail} GB</td>
                        <td class="bigger">{$FastStat.disk_free} GB</td>
                    </tr>
                    <tr>
                        <td><b>{$lang.cpucores}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.cpu_percent>90}red{else}green{/if}" style="width:{$FastStat.cpu_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.cpu_avail}</td>
                        <td class="bigger">{$FastStat.cpu_free}</td>
                    </tr>
                    <tr>
                        <td><b>{$lang.bandwidth}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.bandwidth_percent>90}red{else}green{/if}" style="width:{$FastStat.bandwidth_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.bandwidth_avail} GB</td>
                        <td class="bigger">{$FastStat.bandwidth_free} GB</td>
                    </tr>
                    <tr>
                        <td><b>{$lang.ipcount}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.ips_percent>90}red{else}green{/if}" style="width:{$FastStat.ips_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.ips_avail}</td>
                        <td class="bigger">{$FastStat.ips_free}</td>
                    </tr>
                    {if $FastStat.burstmem_avail && ($xen || $openvz)}
                    <tr>
                        <td><b>{if $openvz}{$lang.burstable_ram}{/if}{if $openvz && $xen}/{/if}{if $xen}{$lang.swapdisk}{/if}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar green" style="width:{$FastStat.burstmem_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.burstmem_avail}</td>
                        <td class="bigger">{$FastStat.burstmem_free}</td>
                    </tr>
                    {/if}
                    {if $FastStat.vps_avail}
                    <tr>
                        <td><b>{$lang.vpslimit}</b> </td>
                        <td>
                            <div class="progress-bar">
                                <div class="bar {if $FastStat.vps_percent>90}red{else}green{/if}" style="width:{$FastStat.vps_percent}%"></div>
                            </div>
                        </td>
                        <td class="bigger">{$FastStat.vps_avail}</td>
                        <td class="bigger">{$FastStat.vps_free}</td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        {else}
            <table cellspacing="0" cellpadding="0" width="100%" class="ttable">
                <thead>
                    <tr>
                        <th>{$lang.reslabel}</th>
                        <th width="120">{$lang.Totallabel}</th>
                    </tr>
                </thead>
                <tbody><tr>
                        <td width="120"><b>{$lang.memory}</b></td>
                        <td class="bigger">{$FastStat.memory_avail} MB</td>
                    </tr>
                    {if $FastStat.disk_avail}
                    <tr>
                        <td><b>{$lang.storage}</b> </td>
                        <td class="bigger">{$FastStat.disk_avail} GB</td>
                    </tr>
                    {/if}
                    {if $FastStat.cpu_avail}
                    <tr>
                        <td><b>{$lang.cpucores}</b> </td>
                        <td class="bigger">{$FastStat.cpu_avail}</td>
                    </tr>
                    {/if}
                    {if $FastStat.bandwidth_avail}
                    <tr>
                        <td><b>{$lang.bandwidth}</b> </td>
                        <td class="bigger">{$FastStat.bandwidth_avail} GB</td>
                    </tr>
                    {/if}
                    {if $FastStat.ips_avail}
                    <tr>
                        <td><b>{$lang.ipcount}</b> </td>
                        <td class="bigger">{$FastStat.ips_avail}</td>
                    </tr>
                    {/if}
                    {if $FastStat.vps_avail}
                    <tr>
                        <td><b>{$lang.vpslimit}</b> </td>
                        <td class="bigger">{$FastStat.vps_avail}</td>
                    </tr>
                    {/if}
                </tbody>
            </table>
        {/if}
        <div style="padding:0px 10px 10px;text-align: right">
            <input type="submit" value="Upgrade / Downgrade resources" class="blue" onclick="window.location='?cmd=clientarea&action=services&service={$service.id}&vpsdo=upgrade'"/>
        </div>
    </div>
    {include file="`$onappdir`footer.cloud.tpl"}

{/if}