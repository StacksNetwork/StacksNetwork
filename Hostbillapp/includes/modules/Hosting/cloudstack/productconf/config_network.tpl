<table border="0" cellspacing="0" cellpadding="6" width="100%" >
    <tr><td colspan="2" class="onapp-preloader" style=""><img src="templates/default/img/ajax-loader3.gif"> Fetching data from CloudStack, please wait...</td></tr>
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
        <td width="160"><label >Network  <a class="vtip_description" title="Advanced networking only - Client VMs will be able to use selected zones"></a></label></td>
        <td id="option22container" class="tofetch">
            <select name="options[option22][]" id="option22" multiple="multiple" class="multi">
                <option value="Auto-Assign" {if in_array('Auto-Assign',$default.option22)}selected="selected"{/if}>Auto-Assign</option>
                <option value="0" {if in_array('0',$default.option22)}selected="selected"{/if}>None (advanced only) - Auto create network </option>
                {foreach from=$default.option22 item=vx}
                    {if $vx=='Auto-Assign'}{continue}
                    {/if}
                    <option value="{$vx}" selected="selected">{$vx}</option>
                {/foreach}
            </select>
        </td>
    </tr>
    <tr>
        <td width="160"><label >Network type <a class="vtip_description" title="Select networking type you've configured your Cloudstack with"></a></label></td>
        <td ><div id="option30container" ><select name="options[option30]" id="option30" >
                    <option value="Basic" {if $default.option30=='Basic'} selected="selected" {/if} >Basic</option>
                    <option value="Advanced" {if $default.option30=='Advanced'} selected="selected" {/if} >Advanced</option>
                </select></div><div class="clear"></div>
        </td>
    </tr>
    <tr class="odesc_ odesc_cloud_vm">
        <td width="160"><label >Advanced networking options <a class="vtip_description" title="Those options applies only if you're using advanced networking for cloud customers"></a></label></td>
        <td >
            <div id="option30container" >
                <select name="options[option31]" id="option31" >
                    <option value="a3" {if $default.option31=='a3'} selected="selected" {/if} >Use one network for all VM client creates under one account</option>
                    <option value="a1" {if $default.option31=='a1'} selected="selected" {/if} >Create separate network per each VM created by client</option>
                    <option value="a2" {if $default.option31=='a2'} selected="selected" {/if} >Create separate network per each VM and connect other client's networks</option>

                </select>
            </div>
            <div class="clear"></div>
        </td>
    </tr>
</table>
<div class="nav-er"  id="step-5">
    <a href="#" class="prev-step">Previous step</a>
    <a href="#" class="next-step">Next step</a>
</div>