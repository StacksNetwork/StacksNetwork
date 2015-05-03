<div class="content-cloud">
<div class="header-bar">
<h3 class="ips hasicon">Reverse DNS</h3>
</div>
    <div class="content-bar ">
{if !$ips_a}

rDNS management is not available for your IP addresses at the moment.

{else}
<form action="" method="post">
    <input type="hidden" name="make" value="uprdns" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >
    <tr>
        <th width="120">IP</th>
        <th>Hostname</th>
    </tr>
    {foreach from=$ips_a item=ip}

    <tr>
        <td style="padding-top:15px;font-weight:bold">{$ip.address}</td>
        <td><input type="text" name="rdns[{$ip.address}][ptrcontent]" value="{$ip.ptrcontent}" style="width:350px;"/>
        <input type="hidden" name="rdns[{$ip.address}][oldptrcontent]" value="{$ip.ptrcontent}" />
        <input type="hidden" name="rdns[{$ip.address}][ptrhash]" value="{$ip.ptrhash}" />
        <input type="hidden" name="rdns[{$ip.address}][ptrid]" value="{$ip.ptrid}" />
        <input type="hidden" name="rdns[{$ip.address}][ptrzone]" value="{$ip.ptrzone}" />
    </td>
    </tr>
    {/foreach}
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Update Reverse DNS" class="btn btn-info ">
<div class="clear"></div>
</div>
</form>

{/if}</div></div>