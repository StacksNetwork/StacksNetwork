To start please configure and select server above.<br/>
You can configure your HostBill to provision CloudStack resources in multiple ways:

<div class="onapp_opt {if $default.option10=='Single Machine, autocreation'}onapp_active{/if}">
    <table border="0" width="500">
        <tr>
            <td class="opicker"><input type="radio" name="options[option10]" id="single_vm" value="Single Machine, autocreation" {if $default.option10=='Single Machine, autocreation'}checked='checked'{/if}/></td>
            <td class="odescr">
                <h3>Single VPS</h3>
                <div class="graylabel">One account in HostBill = 1 virtual machine in CloudStack</div>
            </td>
        </tr>
    </table>
</div>
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

<div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
    <a href="#" class="next-step">Next step</a>
</div>