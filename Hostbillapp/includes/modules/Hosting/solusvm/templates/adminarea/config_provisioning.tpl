
<div class="onapptab" id="provisioning_tab">
    To start please configure and select server above.<br/>
    You can configure your HostBill to provision SolusVM resources in multiple ways:

    <div class="onapp_opt {if $default.type=='single' || !$default.type}onapp_active{/if}">
        <table border="0" width="500">
            <tr>
                <td class="opicker"><input type="radio" name="options[type]" id="single_vm" value="single" {if $default.type=='single' || !$default.type}checked='checked'{/if}/></td>
                <td class="odescr">
                    <h3>Single VPS</h3>
                    <div class="graylabel">One account in HostBill = 1 virtual machine in SolusVM</div>
                </td>
            </tr>
        </table>
    </div>
    <div class="onapp_opt {if $default.type=='multi'}onapp_active{/if}">
        <table border="0" width="500">
            <tr>
                <td class="opicker"><input type="radio" name="options[type]"  id="cloud_vm" value="multi" {if $default.type=='multi'}checked='checked'{/if} /></td>
                <td class="odescr">
                    <h3>Cloud Hosting</h3>
                    <div class="graylabel">Your client will be able to create machines by himself in HostBill interface </div>
                </td>
            </tr>
        </table>
    </div>
    <div class="onapp_opt {if $default.type=='reseller'}onapp_active{/if}">
        <table border="0" width="500">
            <tr>
                <td class="opicker"><input type="radio" name="options[type]"  id="reseller" value="reseller" {if $default.type=='reseller'}checked='checked'{/if} /></td>
                <td class="odescr">
                    <h3>Reseller</h3>
                    <div class="graylabel">Your client will be able to create their own users </div>
                </td>
            </tr>
        </table>
    </div>

    <div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
        <a href="#" class="next-step">Next step</a>
    </div>

</div>
