<tr><td id="getvaluesloader">{if $test_connection_result}
                <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                    {$lang.test_configuration}:
                    {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}{else}{$test_connection_result.result}{/if}
                    {if $test_connection_result.error}: {$test_connection_result.error}{/if}
                </span>
        {/if}</td>
    <td id="onappconfig_"><div id="">
        <ul class="breadcrumb-nav" style="margin-top:10px;">
    <li><a href="#" class="active disabled" onclick="load_onapp_section('provisioning')">Provisioning</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('resources')">Resources</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('ostemplates')">OS Templates</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('storage')">Storage / Backups</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('network')">Network</a></li>
    <li><a href="#" class="disabled" onclick="load_onapp_section('finish')">Finish</a></li>
</ul>
<div style="margin-top:-1px;border: solid 1px #DDDDDD;padding:10px;margin-bottom:10px;background:#fff" id="onapptabcontainer">
    <div class="onapptab" id="provisioning_tab">
        To start please configure and select server above.<br/>
        You can configure your HostBill to provision OnApp resources in multiple ways:

        <div class="onapp_opt onapp_active">
            <table border="0" width="500">
                <tr>
                    <td class="opicker"><input type="radio" name="options[option10]" id="single_vm" value="Single Machine, autocreation" checked='checked'/></td>
                    <td class="odescr">
                        <h3>Single VPS</h3>
                        <div class="graylabel">One account in HostBill = 1 Smart server in OnApp</div>
                    </td>
                </tr>
            </table>
        </div>
        {*}
        <div class="onapp_opt {if $default.option10=='Multiple Machines, full management'}onapp_active{/if}">
            <table border="0" width="500">
                <tr>
                    <td  class="opicker"><input type="radio" name="options[option10]"  id="cloud_vm" value="Multiple Machines, full management" {if $default.option10=='Multiple Machines, full management'}checked='checked'{/if} /></td>
                    <td class="odescr">
                        <h3>Cloud Hosting</h3>
                        <div class="graylabel">Your client will be able to create machines by himself in HostBill interface </div>
                    </td>
                </tr>
            </table>
        </div>
        {*}
        <div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="resources_tab">
        <div class="odesc_ odesc_single_vm pdx">Your client Virtual Machine will be provisioned with limits configured here</div>
        <div class="odesc_ odesc_cloud_vm pdx">Your client will be able to use resource with limits configured here</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

            <tr>
                <td width="160"><label >Memory [MB]</label></td>
                <td id="option3container"><input type="text" size="3" name="options[option3]" value="{$default.option3}" id="option3"/>
                    <span class="fs11"/><input type="checkbox" class="formchecker"  rel="memory"> Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >CPU Cores</label></td>
                <td id="option4container"><input type="text" size="3" name="options[option4]" value="{$default.option4}" id="option4"/>
                    <span class="fs11"><input type="checkbox" class="formchecker"  rel="cpu" /> Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr id="cpu_shares_row" {if $default.option50}style="display:none"{/if}>
                <td width="160"><label >CPU Shares [%] <a class="vtip_description" title="Set to total CPU shares, for all cores. I.e.: If you want to limit 2 cores with 30% cpu share each, set this value to 60"></a></label></td>
                <td id="option5container"><input type="text" size="3" name="options[option5]" value="{$default.option5}" id="option5"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="cpu_share" /> Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Enable "vCPU" <a class="vtip_description" title="With this option enabled client won't be presented with CPU Shares sliders/info. You will be able to set fixed share/cpu ratio.<br>With this option enabled client wont see CPU share/priority anywhere in interface"></a></label></td>
                <td id="option50container"><input type="checkbox" size="3" name="options[option50]" {if $default.option50}checked="checked"{/if} value="1" id="option50" onclick="toggle_vcpu(this)" />
                </td>
            </tr>
            <tr id="vcpu_row" {if $default.option50!='1'}style="display:none"{/if}>
                <td width="160"><label >[%] shares / 1 CPU core <a class="vtip_description" title="Set CPU shares you wish to offer per core"></a></label></td>
                <td id="option51container"><input type="text" size="3" name="options[option51]" value="{$default.option51}" id="option51"/>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Hypervisor Zone</label></td>
                <td ><div id="option23container" class="tofetch"><select name="options[option23][]" id="option23" multiple="multiple" class="multi">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option23)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option23 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div><div class="clear"></div>
                    <span class="fs11"> <input type="checkbox" class="formchecker"  rel="hypervisorzone" />Allow to select by client during checkout</span>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >Max Virtual Machines</label></td>
                <td><input type="text" size="3" name="options[option14]" value="{$default.option14}" id="option14"/></td>
            </tr>
            <tr>
                <td width="160"><label >User Role<a class="vtip_description" title="HostBill will create new user for client in onapp using this role."></a></label></td>
                <td id="option1container" class="tofetch"><input type="text" size="3" name="options[option1]" value="{$default.option1}" id="option1"/>
                </td>
            </tr>
        </table>
    <div class="nav-er"  id="step-2">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="ostemplates_tab">
        <div class=" pdx">Limit access to OS templates available in your OnApp, you can also add charge to selected OS templates</div>
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

            <tr>
                <td width="160"><label >Template Groups<a class="vtip_description" title="Select template sets you wish to make available for client to use with his virtual machines"></a></label></td>
                <td  class="tofetch" id="option20container"><select name="options[option20][]" id="option20" multiple="multiple" class="multi">
                        <option value="All" {if in_array('All',$default.option20)}selected="selected"{/if}>All</option>
                        {foreach from=$default.option20 item=vx}{if $vx=='All'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td></td>
                <td><span class="fs11" ><input type="checkbox" rel="os2" class="formchecker osloader" />Set template pricing</span></td>
            </tr>
            <tr class="odesc_ odesc_single_vm">
                <td><label >OS Template <a class="vtip_description" title="Your client VM will be automatically provisioned with this template"></a></label></td>
                <td id="option12container" ><div  class="tofetch"><input type="text" size="3" name="options[option12]" value="{$default.option12}" id="option12"/></div>
                    <span class="fs11" ><input type="checkbox" class="formchecker osloader" rel="os1" />Allow client to select during checkout</span></td>
            </tr>

        </table>
         <div class="nav-er"  id="step-3">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    <div class="onapptab form" id="storage_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>

            <tr>
                <td width="160"><label >Disk size [GB]</label></td>
                <td id="option6container"><input type="text" size="3" name="options[option6]" value="{$default.option6}" id="option6"/>
                    <span class="fs11"  ><input type="checkbox" class="formchecker" rel="disk_size" />Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Backup space [GB]</label></td>
                <td id="option17container"><input type="text" size="3" name="options[option17]" value="{$default.option17}" id="option17"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="storage_disk_size" />Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Max backups</label></td>
                <td><input type="text" size="3" name="options[option15]" value="{$default.option15}" id="option15"/></td>
            </tr>
            <tr>
                <td width="160"><label >Data Store Zone <a class="vtip_description" title="Client VMs will be able to use selected zones for storage"></a></label></td>
                <td id="option21container" ><div  class="tofetch"><select name="options[option21][]" id="option21" multiple="multiple" class="multi">
                       <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option21)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option21 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select></div>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="datastorezone" />Allow client to select during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Swap: Data Store Zone <a class="vtip_description" title="Client VMs swap will be created on selected zones"></a></label></td>
                <td id="option24container"  class="tofetch"><select name="options[option24][]" id="option24" multiple="multiple" class="multi">
                       <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option24)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option24 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>

            <tr class="odesc_ odesc_single_vm">
                <td width="160"><label >Auto disk resize<a class="vtip_description" title="With this option enabled after upgrade/downgrade HostBill will resize virtual machine storage automatically"></label></td>
                <td><input type="checkbox"  name="options[option25]" value="1" {if $default.option25}checked="checked"{/if} /></td>
            </tr>
            <tr class="odesc_ odesc_single_vm">
                <td width="160"><label >Enable VM Auto-Backup</label></td>
                <td><input type="checkbox"  name="options[option52]" value="1" {if $default.option52}checked="checked"{/if} /></td>
            </tr>
        </table>
         <div class="nav-er"  id="step-4">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>

    </div>
    <div class="onapptab form" id="network_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
            <tr>
                <td width="160"><label >IP Address Count</label></td>
                <td id="option13container"><input type="text" size="3" name="options[option13]" value="{$default.option13}" id="option13"/>
                    <span class="fs11"><input type="checkbox"  class="formchecker" rel="ip_address" />Allow client to adjust with slider during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Port Speed [Mbps] <a class="vtip_description" title="Leave blank to unlimited. For cloud hosting this value will be used for each Virtual Machine created by client"></a></label></td>
                <td id="option9container"><input type="text" size="3" name="options[option9]" value="{$default.option9}" id="option9"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="rate"  />Allow client to select during order</span>
                </td>
            </tr>
            <tr>
                <td width="160"><label >Data sent/period [GB] <a class="vtip_description" title="This is total limit for all client's virtual machines usage"></a></label></td>
                <td id="option16container"><input type="text" size="3" name="options[option16]" value="{$default.option16}" id="option16"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="data_sent" /> Allow client to adjust with slider during order</span></td>
            </tr>
            <tr>
                <td width="160"><label >Data recv/period [GB] <a class="vtip_description" title="This is total limit for all client's virtual machines usage"></a></label></td>
                <td id="option18container"><input type="text" size="3" name="options[option18]" value="{$default.option18}" id="option18"/>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="data_recv" /> Allow client to adjust with slider during order</span></td>
            </tr>
            <tr>
                <td width="160"><label >Data transfer period </label></td>
                <td><select name="options[option38]" id="option38">
                        <option value="hourly" {if $default.option38=='hourly' || !$default.option38}selected="selected"{/if}>Hourly</option>
                        <option value="monthly" {if $default.option38=='monthly'}selected="selected"{/if}>Monthly</option>
                    </select></td>
            </tr>
            <tr>
                <td width="160"><label >Network Zone <a class="vtip_description" title="Client VMs will be able to use selected zones"></a></label></td>
                <td id="option22container" class="tofetch"><select name="options[option22][]" id="option22" multiple="multiple" class="multi">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option22)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$default.option22 item=vx}{if $vx=='Auto-Assign'}{continue}{/if}
                         <option value="{$vx}" selected="selected">{$vx}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
        </table>
         <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    {*}
    <div class="onapptab form" id="privnetwork_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
            <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
            <tr class="odesc_ odesc_single_vm">
                <td colspan="2">
                    <div class="graylabel">Private networks feature is available only for Cloud Hosting</div>
                </td>
            </tr>
            {if $ipam}
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >Enable Private Network</label></td>
                <td>
                    <input type="checkbox" size="3" name="options[privnetwork]" value="1" id="privnetwork" {if $default.privnetwork}checked="checked"{/if}/>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >VLAN group <a class="vtip_description" title="Vlan group that will be used while provisioning"></a></label></td>
                <td>
                    <select id="pn_vlangroup" name="options[pn_vlangroup][]" multiple="multiple" class="multi">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.pn_vlangroup)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$vlan item=v}
                            {if $v.autoprovision && $v.private}
                                <option value="{$v.server_id}" {if in_array($v.server_id,$default.pn_vlangroup)}selected="selected"{/if}>{$v.name} ({$v.count_unasigned}/{$v.count})</option>
                            {/if}
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >IPAM list <a class="vtip_description" title="Liss that will be used to create clients subnet"></a></label></td>
                <td>
                    <select id="pn_iplist" name="options[pn_iplist][]" multiple="multiple" class="multi">
                        <option value="Auto-Assign" {if in_array('Auto-Assign',$default.pn_iplist)}selected="selected"{/if}>Auto-Assign</option>
                        {foreach from=$ipam item=i}
                            {assign value=false var=ipparent}
                            {assign value=false var=ipavail}
                            {foreach from=$i.sublist item=ii}
                                {if $ii.autoprovision && $ii.private && !$ii.client_id && $ii.count_unasigned>0}
                                    {assign value=true var=ipavail}
                                {/if}
                            {/foreach}
                            {if $i.autoprovision && $i.private && !$i.client_id && ( $i.count_unasigned>0 || $ipavail )}
                                {assign value=true var=ipparent}
                                <option value="{$i.server_id}" {if in_array($i.server_id,$default.pn_iplist)}selected="selected"{/if}>{$i.name} {if $i.count}({$i.count_unasigned}/{$i.count}){/if}</option>
                            {/if}
                            {foreach from=$i.sublist item=ii name=sublist}
                                {if $ii.autoprovision && $ii.private && !$ii.client_id && $ii.count_unasigned>0}
                                    <option value="{$ii.server_id}" {if in_array($ii.server_id,$default.pn_iplist)}selected="selected"{/if}>
                                        {if $ipparent}{if $smarty.foreach.sublist.last}&#x2514;{else}&#x251C;{/if}{/if}
                                        {$ii.name} ({$ii.count_unasigned}/{$ii.count})
                                    </option>
                                {/if}
                            {/foreach}
                        {/foreach}
                    </select>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >Subnet size </label></td>
                <td>
                    <select id="pn_subnet_size" name="options[pn_subnet_size]">
                        <option value="0" {if $default.pn_subnet_size=='0'}selected="selected"{/if}>None (0 ips)</option>
                        <option value="/32"  {if $default.pn_subnet_size=='/32'}selected="selected"{/if}>/32 (1)</option>
                        <option value="/31" {if $default.pn_subnet_size=='/31'}selected="selected"{/if}>/31 (2)</option>
                        <option value="/30" {if $default.pn_subnet_size=='/30'}selected="selected"{/if}>/30 (4)</option>
                        <option value="/29" {if $default.pn_subnet_size=='/29'}selected="selected"{/if}>/29 (8)</option>
                        <option value="/28" {if $default.pn_subnet_size=='/28'}selected="selected"{/if}>/28 (16)</option>
                        <option value="/27" {if $default.pn_subnet_size=='/27'}selected="selected"{/if}>/27 (32)</option>
                        <option value="/26" {if $default.pn_subnet_size=='/26'}selected="selected"{/if}>/26 (64)</option>
                        <option value="/25" {if $default.pn_subnet_size=='/25'}selected="selected"{/if}>/25 (128)</option>
                        <option value="/24" {if $default.pn_subnet_size=='/24'}selected="selected"{/if}>/24 (256)</option>
                        <option value="/23" {if $default.pn_subnet_size=='/23'}selected="selected"{/if}>/23 (512)</option>
                        <option value="/22" {if $default.pn_subnet_size=='/22'}selected="selected"{/if}>/22 (1024)</option>
                    </select>
                </td>
            </tr>
            <tr class="odesc_ odesc_cloud_vm">
                <td></td>
                <td>
                    <div class="graylabel">
                        To add private network + vlan to your customer cloud resources:<br />
                        &nbsp;- select vlan group from IPAM that vlan in OnApp should be created from<br />
                        &nbsp;- select IPAM subnet and its size that HostBill should split into customer network in OnApp<br />
                    </div>
                </td>
            </tr>
            {else}
                <tr>
                <td colspan="2">
                    <div class="graylabel">IPAM module is required for this feature to work</div>
                </td>
            </tr>
            {/if}
        </table>
        <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    <div class="onapptab form" id="clientgui_tab">
        <table border="0" cellspacing="0" cellpadding="6" width="100%" >
          <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
          <tr class="odesc_ odesc_single_vm">
                <td colspan="2">Options in this tab are only availlable for Cloud Hosting provisioning type</td>
            </tr>
          <tr class="odesc_ odesc_cloud_vm">
                <td colspan="2">You can control access to certain functions in client GUI for this package in Client Functions Tab</td>
            </tr>

            <tr class="odesc_ odesc_cloud_vm">
                <td width="160"><label >Show Autoscale options <a class="vtip_description" title="With this option on your client will gain access to VM Autoscaling menu in clientarea"></a></label></td>
                <td><select name="options[option19]" id="option19" style="margin:0px;">
                        <option value="Yes" {if $default.option19=='Yes'}selected="selected"{/if}>Yes</option>
                        <option value="No" {if $default.option19=='No'}selected="selected"{/if}>No</option>
                    </select></td>
            </tr>
         <tr class="odesc_ odesc_cloud_vm">
                <td colspan="2" ><b>Limit single server primary disk size: <a class="vtip_description" title="You can limit maximum primary disk space client can create for single machine in his cloud"></a></b></td>
            </tr>
             <tr class="odesc_ odesc_cloud_vm">
                <td width="160" align="right">Enable:</td>
                <td><input type="checkbox" name="options[option53]" {if $default.option53=='1'}checked="checked"{/if} value='1' />
                <input type="text" size="3" name="options[option55]" value="{$default.option55}" id="option55"/> GB
                </td>
            </tr>
         <tr class="odesc_ odesc_cloud_vm">
                <td colspan="2" ><b>Limit single server swap space: <a class="vtip_description" title="You can limit swap space client can create for single machine in his cloud"></a></b></td>
            </tr>

             <tr class="odesc_ odesc_cloud_vm">
                <td width="160" align="right">Enable:</td>
                <td><input type="checkbox"  name="options[option54]" {if $default.option54=='1'}checked="checked"{/if} value='1' />
                <input type="text" size="3" name="options[option56]" value="{$default.option56}" id="option56"/> GB
                </td>
            </tr>
            
            <tr class="odesc_ odesc_cloud_vm">
                <td colspan="2" ><b>Limit single server cores per VM: <a class="vtip_description" title="You can limit number cores client can create for single machine in his cloud with"></a></b></td>
            </tr>

             <tr class="odesc_ odesc_cloud_vm">
                <td width="160" align="right">Enable:</td>
                <td><input type="checkbox"  name="options[option57]" {if $default.option57=='1'}checked="checked"{/if} value='1' />
                <input type="text" size="3" name="options[option58]" value="{$default.option58}" id="option58"/> 
                </td>
            </tr>
        </table>
         <div class="nav-er"  id="step-5">
            <a href="#" class="prev-step">Previous step</a>
            <a href="#" class="next-step">Next step</a>
        </div>
    </div>
    {*}
    <div class="onapptab form" id="finish_tab">
        <table border="0" cellspacing="0" width="100%" cellpadding="6">
             <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from OnApp, please wait...</td></tr>
            <tr>
                <td valign="top" width="160" style="border-right:1px solid #E9E9E9">
                    <h4 class="finish">Finish</h4>
                    <span class="fs11" style="color:#C2C2C2">Save &amp; start selling</span>
                </td>
                <td valign="top">
                     Your OnApp Smart server package is ready to be purchased. <br/>
                    </td>

            </tr>
        </table>

    </div>
</div>
 {literal}
 <style type="text/css">
     .nav-er {
         margin:20px 0px 7px;
         text-align:center;
}
     .nav-er a {
         display: inline-block;
         padding:10px;
        background-color:  #F1F1F1;
        background-image: -moz-linear-gradient(center top , #F5F5F5, #F1F1F1);
        border: 1px solid #DDDDDD;
        color: #444444;
        border-radius:4px;
        text-decoration: underline;
        margin:0px 7px;
}
.nav-er a:hover {
    color:#222;
    text-decoration:none;
    background: #F5F5F5;
}
     h4.finish {
         margin:0px;
         color:#262626;
         font-weight: normal;
         font-size:20px;
}
     .onapp-preloader {display:none; color:#7F7F7F;padding-left:178px;font-size:11px;background:#EBEBEB;font-weight:bold;}
.pdx {
margin-bottom:10px;
}
select.multi {
    min-width:120px;
}

.form select {
    margin:0px;
}
.paddedin {
margin: 2px 10px 20px 10px;
}
.odescr {
padding-left:7px;
}
.onapp_opt:hover {
border: solid 1px  #CCCCCC;
background:#f6fafd;
}
.opicker {
width: 25px;
background:#f4f4f4;
-moz-border-radius-topleft: 3px;
-moz-border-radius-topright: 0px;
-moz-border-radius-bottomright: 0px;
-moz-border-radius-bottomleft: 3px;
-webkit-border-radius: 3px 0px 0px 3px;
border-radius: 3px 0px 0px 3px;
}
.onapp_opt {
border: solid 1px #DDDDDD;
padding:4px;
margin:15px;
-webkit-border-radius: 4px;
-moz-border-radius: 4px;
border-radius: 4px;
}
.onapp_active {
border:solid 1px #96c2db;
background:#f5f9fa;
}
.graylabel {
font-size:11px;
padding:2px 3px;
float:left;
clear:both;
background:#ebebeb;
color:#7f7f7f;
-webkit-border-radius: 3px;
-moz-border-radius: 3px;
border-radius: 3px;
}
#testconfigcontainer .dark_shelf {
    display:none;
}

</style>

        <script type="text/javascript">
            function toggle_vcpu(el) {
                if($(el).is(':checked')) {
                    $('#cpu_shares_row').hide();
                    $('#vcpu_row').show();

                } else {
                    $('#cpu_shares_row').show();
                    $('#vcpu_row').hide();
                }
            }
            function onapp_showloader() {
                $('.onapptab:visible').find('.onapp-preloader').slideDown();
            }
            function onapp_hideloader() {
                $('.onapptab:visible').find('.onapp-preloader').slideUp();

            }
            function lookforsliders() {
                var pid = $('#product_id').val();
                $('.formchecker').click(function(){
                    var tr=$(this).parents('tr').eq(0);
                    var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
                    if(!$(this).is(':checked')) {
                        if(!confirm('Are you sure you want to remove related Form element? ')) {
                            return false;
                        }
                        if($('#configvar_'+rel).length) {
                            ajax_update('?cmd=configfields&make=delete',{
                                id:$('#configvar_'+rel).val(),
                                product_id:pid
                            },'#configeditor_content');
                        }
                        //remove related form element
                        tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                        tr.find('input[id], select[id]').eq(0).removeAttr('disabled','disabled').show();
                        load_onapp_section($(this).parents('div.onapptab').eq(0).attr('id').replace('_tab',''));
                        $(this).parents('span').eq(0).find('a.editbtn').remove();
                    } else {
                        //add related form element
                        var el=$(this);
                        var rel=$(this).attr('rel');
                        tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
                        onapp_showloader();
                        $.post('?cmd=services&action=product',{
                             make:'importformel',
                             variableid:rel,
                             cat_id:$('#category_id').val(),
                             other:$('input, select','#onapptabcontainer').serialize(),
                             id:pid,
                             server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                        },function(data){
                            var r = parse_response(data);
                            if(r) {
                                 el.parents('span').eq(0).append(r);
                                 onapp_hideloader();
                                 ajax_update('?cmd=configfields',{product_id:pid,action:'loadproduct'},'#configeditor_content');
                            }
                        });
                    }
                }).each(function(){
                    var rel=$(this).attr('rel').replace(/[^a-z_]/g,'');
                    if($('#configvar_'+rel).length<1)
                        return 1;
                    var fid = $('#configvar_'+rel).val();
                    var tr=$(this).attr('checked','checked').parents('tr').eq(0);
                    tr.find('input[id], select[id]').eq(0).attr('disabled','disabled').hide();
                    tr.find('.tofetch').addClass('disabled');
                    $(this).parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm('+fid+','+pid+')" class="editbtn orspace">Edit related form element</a>');
                }).filter('.osloader').each(function(){
                    if($('#configvar_os').length<1)
                        return 0;
                    var fid = $('#configvar_os').val();
                    $(this).parents('span').eq(0).append(' <a href="#" onclick="return updateOSList('+fid+')" class="editbtn orspace">Update template list from OnApp</a>');
                });

            }
            function updateOSList(fid) {
                onapp_showloader();
                $.post('?cmd=services&action=product&make=updateostemplates',{
                    id:$('#product_id').val(),
                    cat_id:$('#category_id').val(),
                    other:$('input, select','#onapptabcontainer').serialize(),
                    server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
                    fid:fid
                },function(data){
                    parse_response(data);
                    editCustomFieldForm(fid,$('#product_id').val());
                });
                return false;
            }
            function load_onapp_section(section)  {
                if(!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
                    alert('Please configure & select server first');
                    return;
                }


                var tab = $('#'+section+'_tab');
                    if(!tab.length)
                        return false;
                var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
                if(!elements.length)
                    return false;
                tab.find('.onapp-preloader').show();
                elements.each(function(e){
                    var el = $(this);
                    var inp=el.find('input[id], select[id]').eq(0);
                    if(inp.is(':disabled')) {
                        if((e+1)==elements.length) {
                                  tab.find('.onapp-preloader').slideUp();
                                }
                        return 1; //continue;

                    }
                    var vlx=inp.val();
                    var vl=inp.attr('id')+"="+vlx;
                    if(vlx!=null && vlx.constructor==Array) {
                        vl = inp.serialize();
                    }
                    $.post('?cmd=services&action=product&'+vl,
                    {
                        make:'getonappval',
                        id:$('#product_id').val(),
                        cat_id:$('#category_id').val(),
                        opt:inp.attr('id'),
                        server_id:$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                    },function(data){
                            var r=parse_response(data);
                            if(typeof(r)=='string') {
                             $(el).addClass('fetched');
                              el.html(r);
                            }

                      });

                });
                               $("a.vtip_description","#onappconfig_").not('.vtip_applied').vTip();

                return false;
            }
            function singlemulti() {
                $('#step-1').show();
                if($('#single_vm').is(':checked')) {
                    $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
                    $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
                    $('#option14').val(1);
                    $('#option19').val('No');
                } else {
                    $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
                    $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
                }
            }
            function bindsteps() {
                $('a.next-step').click(function(){
                    $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
                    return false;
                });
                $('a.prev-step').click(function(){
                    $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
                    return false;
                });
                $('#serv_picker input[type=checkbox]').click(function(){
                    if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
                    else
                        $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

                });
            }

            function append_onapp() {
                $('#onappconfig_').TabbedMenu({elem:'.onapptab',picker:'.breadcrumb-nav a',aclass:'active',picker_id:'nan1'});
                $('.onapp_opt input[type=radio]').click(function(e){
                    $('.onapp_opt').removeClass('onapp_active');
                    var id=$(this).attr('id');
                    $('.odesc_').hide();
                    $('.odesc_'+id).show();
                    $(this).parents('div').eq(0).addClass('onapp_active');
                    singlemulti();
                });
                $('.onapp_opt input[type=radio]:checked').click();
                lookforsliders();
                $(document).ajaxStop(function() {
                    $('.onapp-preloader').hide();
                });
                bindsteps();


                if($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
                        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
            }
            {/literal}{if $_isajax}setTimeout('append_onapp()',50);{else}appendLoader('append_onapp');{/if}{literal}
        </script>

    {/literal}

</div>{literal}<script type="text/javascript">



if (typeof(HBTestingSuite)=='undefined')
    var HBTestingSuite={};

HBTestingSuite.product_id=$('#product_id').val();
HBTestingSuite.initTest=function(){
    var name = $('form#productedit input[name=name]').val();
    onapp_showloader();
    ajax_update('?cmd=testingsuite&action=beginsimpletest',{product_id:this.product_id,pname:name},'#testconfigcontainer');
    return false;
};

  </script> {/literal}
    </td>
</tr>