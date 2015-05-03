
<div class="onapptab" id="provisioning_tab">
    To start please configure and select server above.<br/>

    <div class="onapp_opt onapp_active">
        <table border="0" width="500">
            <tr>
                <td class="opicker"><input type="radio" name="options[type]" id="single_vm" value="single" {if $default.type=='single' || !$default.type}checked='checked'{/if}/></td>
                <td class="odescr">
                    <h3>Single VPS</h3>
                    <div class="graylabel">One account in HostBill = 1 virtual machine in DigitalOcean</div>
                </td>
            </tr>
        </table>
    </div>
    
    <div class="nav-er" style="{if !$default.option10}display:none{/if}" id="step-1">
        <a href="#" class="next-step">Next step</a>
    </div>

</div>
