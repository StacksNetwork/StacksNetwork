<link type="text/css" href="{$moduledir}stylesheet.css" rel="stylesheet" />
<link type="text/css" href="{$template_dir}js/gui.elements.css" rel="stylesheet" />
<script type="text/javascript" src="{$template_dir}js/gui.elements.js"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.elastic.source.js"></script>
<script type="text/javascript" src="{$moduledir}scripts.js"></script>
<div class="blu" data-action="vlan"><h1>VLANs</h1></div>
<div class="blu"><h1>Options</h1></div>
<div class="blu"><h1>Reverse DNS</h1></div>
<div class="blu" data-action="logs"><h1>Audit Log</h1></div>

<div style="background:#E0ECFF;height: 2.5em;width: 100%;"></div>
<div class="pagecont" >
    {include file="ajax.default.tpl"}
</div><!-- main -->
<div class="pagecont" style="display:none">
    {include file="ajax.vlan.tpl" servers=$vlangroups}
</div><!-- main -->
<div class="pagecont lighterblue" style="display:none">
    <form action="?cmd=module&module={$moduleid}&setting=save" method="post" id="optform">
        <div style="padding:10px 1em">
            <div style="margin-bottom: 0px; font-weight: bold">
                <input name="emails" type="checkbox" value="1" {if $settings.email}checked="checked"{/if} /> 
                Send emails on IP list updates.
            </div>
            <div style="padding:10px 1em">
                For following admins:
                {if $adminlist}<br />
                    {foreach from=$adminlist item=admin}
                        <input name="admins[{$admin.id}]" {if $admin.id|in_array:$settings.admins}checked="checked"{/if}type="checkbox" value="{$admin.id}" /> {$admin.username}
                    {/foreach}
                {/if}
            </div>
            
            <div style="margin: 10px 0 ; font-weight: bold">
                <input name="reservation" type="checkbox" value="1" {if $settings.reservation}checked="checked"{/if} />
                Reservation rules 
                <a href="#" class="vtip_description" title="When assigning whole IP list this option will automatically reserve IPs based on rules below. You can use 'n' and 'm' variables to define list starting & end points, example: <br/>&nbsp;&bull;&nbsp;&nbsp;'n+1' will reserve second ip<br/>&nbsp;&bull;&nbsp;&nbsp;'m' will reserve last ip" ></a>
            </div>
                
            {foreach from=$settings.reservations item=reserve key=kk}
            <p>
                IP number: <input name="reservations[{$kk}][ip]" type="text" class="inp" value="{$reserve.ip}" /> 
                Reserved for <input name="reservations[{$kk}][descr]" type="text" class="inp" value="{$reserve.descr}" />
                <a href="#delRule" class="editbtn fs11" onclick="delReservationRule(this); return false" >remove</a>
            </p> 
            {/foreach}
            <a href="#addRule" class="editbtn" onclick="addReservationRule(this); return false" />Add new rule</a>
        </div>
        <div style="padding:10px 10px"> 
            <a class="new_dsave new_menu" href="#" onclick="$('#optform').submit();
                    return false;">
                <span>{$lang.savechanges}</span>
            </a>
            <div class="clear"></div>
        </div>
    </form>
</div><!-- opt -->

<!-- reverse DNS -->
<div class="pagecont" style="display:none">
    <div style="padding:10px 1em">


        <div id="add_pdu" {if !$rdnsid}style="display:none"{/if}>
            <form action="?cmd=module&module={$moduleid}&rdns=save" method="post" id="optform2">
                <table border="0" cellpadding="6" cellspacing="0">
                    <tr>
                        <td>DNS App to use: </td>
                        <td><select name="rdnsid" class="inp">
                                <option value="0">None - disable rDNS</option>
                                {foreach from=$rdnsapps item=app}

                                    <option value="{$app.id}" {if $app.id==$rdnsid}selected="selected"{/if}>{$app.groupname} - {$app.name}</option>
                                {/foreach}
                            </select>
                        </td>
                    </tr>

                </table>
                <a onclick="$('#optform2').submit();
                    return false;" href="#" class="new_dsave new_menu">
                    <span>Save Changes</span>
                </a>
                {securitytoken}
            </form>
            <div class="clear"><br/></div>
        </div><div class="clear"></div>


        <div class="blank_state_smaller blank_forms" id="blank_pdu">
            <div class="blank_info">
                <h1>Enable automatic rDNS management for your customers</h1>
                IPAM module can work with  PowerDNS module, allowing your colocation/dedicated customers to manage their PTR records directly from clientarea.
                <br/><br/>
                <b>To enable rDNS management in HostBill</b>
                <ol>
                    <li>Go to Settings->Modules and enable PowerDNS module</li>
                    <li>Configure connection to your DNS server in Settings->Apps</li>
                    <li>Enable Reverse DNS in Product->Client functions for your Colo/Dedi packages</li>
                    <li>Refresh this section to select App you will be using</li>
                    <li>Under your dedicated servers/colocation products enable Reverse DNS client function in product configuration</li>
                    <li>Create general DNS zone for <b>in-addr.arpa</b> or /24 subnet specific (like 3.2.1.in-addr.arpa for 1.2.3.0/24)</li>
                    <li>Clients that have packages with IPs assigned in (Account details)->IPAM tab will now be able to manage their rDNS records</li>
                    <li>Additionally, anytime you'll edit rDNS column in IPAM plugin, it will send updated record to DNS module</li>
                </ol>

                <div class="clear"></div>
                {if !$rdnsid}
                    {if  $rdnsapps}<br>
                        <a onclick="$('#blank_pdu').hide();
                    $('#add_pdu').show();
                    return false;" class="new_control" href="#"><span class="addsth"><strong>Select DNS App to use with rDNS</strong></span></a>
                    {/if}
                    <div class="clear"></div>            
                {/if}

            </div>
        </div>
    </div>
</div><!-- reverse DNS -->
<div class="pagecont" style="display:none">
    {include file="ajax.auditlogs.tpl" }
</div>
{if $action=='default' && $showall && $group}
    {literal}
        <script>$(document).ready(function() {{/literal}
                    groupDetails('{$group.id}')
        {literal}  });</script>{/literal}
    {/if}