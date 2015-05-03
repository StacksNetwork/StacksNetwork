<table class="tonapp"  width="100%" cellspacing=0>
    <thead>
        <tr>
            <td width="40"></td>
            <td width="100">Size</td>
            <td width="100">Used</td>
            <td >Storage</td>
            <td ></td>

        </tr>
    </thead>
    {foreach item=disk from=$disks}
    <tr>
        <td >{if $disk.cdrom}<img src="templates/common/cloudhosting/images/icons/disc-case-label.png" alt="" />{else}<img src="templates/common/cloudhosting/images/icons/drive-network.png" alt="" />{/if}</td>
        <td >{$disk.size} GB</td>
        <td >{$disk.used} GB</td>
        <td >{$disk.zone}</td>
        <td >{$disk.id}</td>
        
    </tr>
    {foreachelse}
    <tr>
        <td colspan="4">{$lang.nothing}</td>
    </tr>
    {/foreach}
</table>