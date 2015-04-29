<script type="text/javascript">loadelements.clients = true;</script>
<script type="text/javascript" src="{$template_dir}js/clients.js?v={$hb_version}"></script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td >
            <h3>{$lang.Clients}</h3>
        </td>
        {if $action=='default' || $action=='_default' || $action=='show'}
            <td  class="searchbox">
                <div id="hider2" style="text-align:right">
                    &nbsp;&nbsp;&nbsp; 
                    <a href="?cmd=clients&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
                </div>
                <div id="hider" style="display:none"></div></td>
            {else}
            <td>

            </td>
        {/if}
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=clients"  class="tstyled {if $action!='fields' && $action!='editfield' && !$currentlist}selected{/if}">{$lang.managecustomers} <span>({$cstats.All})</span></a>

            <a href="?cmd=clients&list=active"  class="tstyled tsubit {if $currentlist=='Active'}selected{/if}">{$lang.Active} <span>({$cstats.Active})</span></a>
            <a href="?cmd=clients&list=closed"  class="tstyled tsubit {if $currentlist=='Closed'}selected{/if}">{$lang.Closed} <span>({$cstats.Closed})</span></a>
            {foreach from=$groups item=group}
                <a href="?cmd=clients&list={$group.id}"  class="tstyled tsubit {if $currentlist==$group.id}selected{/if}" style="color:{$group.color}">{$group.name} <span>({$group.count})</span></a>
            {/foreach}

            <br />
            <a href="?cmd=clients&action=groups"  class="tstyled {if $action=='groups' || $action=='editgroup' || $action=='addgroup'}selected{/if}">{$lang.clientgroups}</a>
            <a href="?cmd=clients&action=fields"  class="tstyled {if $action=='fields' || $action=='editfield'}selected{/if}">{$lang.customerfields}</a>
            <br />
            <a href="?cmd=affiliates"  class="tstyled">{$lang.Affiliates}</a>
            <a href="?cmd=affiliates&action=configuration"  class="tstyled">{$lang.affconfig}</a> </td>
        <td  valign="top"  class="bordered"><div id="bodycont">

                {if $action=='groups' || $action=='addgroup' || $action=='editgroup'}
                    {include file='configuration/clientgroups.tpl'}
                {elseif $action=='fields'}
                    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js?v={$hb_version}"></script>
                    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
                    {include file='ajax.clientfields.tpl'}
                {elseif $action=='default'}

                    <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                        <div id="confirm_cacc_delete" style="display:none" class="confirm_container">

                            <div class="confirm_box">
                                <h3>{$lang.deleteheading}</h3>
                                {$lang.deletedescr}<br />
                                <br />

                                <input type="radio" checked="checked" name="harddelete" value="1" id="cl_hard"/> {$lang.deleteopt1}<br />
                                <input type="radio"  name="harddelete" value="0" id="cl_soft"/> {$lang.deleteopt2}<br />

                                <br />
                                <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold" name="delete" class="submiter" {if $enablequeue}queue='push'{/if} onclick="cancelsubmit1()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="return cancelsubmit1()"/></center>

                            </div>

                        </div>
                        <div class="blu">
                            <div class="right">
                                <div class="pagination"></div>
                            </div>
                            <div class="left menubar">

                                <a href="#new" class="menuitm clDropdown menu" id="newmenu">新的 ..<span class="morbtn"></span></a> 
                                <a href="#withselected" class="menuitm clDropdown menu" id="withselected">选择与 ..<span class="morbtn"></span></a> 
                                <a href="#clientarea" class="menuitm clDropdown menu" id="clientarea">客户中心 <span class="morbtn"></span></a> 
                                <a href="#listing&search" class="menuitm clDropdown menu" id="listing">监听 & 搜索<span class="morbtn"></span></a> 
                                <a href="#other" class="menuitm clDropdown menu" id="other">设置 ..<span class="morbtn"></span></a> 
                               
                                <ul class="ddmenu" id="newmenu_m">
                                    <li><a href="?cmd=newclient" class="directly">{$lang.registernewcustomer}</a></li>
                                    <li><a href="?cmd=csv" class="directly">从CSV导入</a></li>
                                </ul>

                                <ul class="ddmenu" id="withselected_m">
                                    {if !$forbidAccess.deleteClients}
                                        <li>
                                            <a href="#" name="deleteclients" onclick="deleteClients();
                                                    return false;" >{$lang.Delete}</a>
                                        </li>
                                    {/if}
                                    <li><a href="#" onclick="return send_msg('clients')">{$lang.SendMessage}</a></li>
                                </ul>

                                <ul class="ddmenu" id="clientarea_m">
                                    <li><a href="?cmd=clients&action=groups" class="directly">{$lang.clientgroups}</a></li>
                                    <li><a href="?cmd=clients&action=fields" class="directly">{$lang.customerfields}</a></li>
                                    <li><a href="?cmd=affiliates" class="directly">{$lang.Affiliates}</a></li>
                                    <li><a href="?cmd=affiliates&action=configuration" class="directly">{$lang.affconfig}</a></li>
                                </ul>

                                <ul class="ddmenu" id="listing_m">
                                    <li><a href="?cmd=clients&action=getadvanced" class="fadvanced">{$lang.filterdata}</a></li>
                                    <li><a href="?cmd=clients&list=active" class="directly">{$lang.Active}</a></li>
                                    <li>
                                        <a href="?cmd=clients&list=closed" class="directly">{$lang.Closed}</a>
                                    </li>
                                    {foreach from=$groups item=group}
                                        <li>
                                            <a href="?cmd=clients&list={$group.id}" class="directly" 
                                               style="color:{$group.color}">{$group.name}</a>
                                        </li>
                                    {/foreach}
                                </ul>

                                <ul class="ddmenu" id="other_m">
                                    <li><a href="#" onclick="return sendtoall_show()">{$lang.sendmassemail}</a></li>
                                </ul>
                            </div>
                            <div class="clear"></div>
                            {include file="clients/massemail.tpl"}
                        </div>
                        <a href="?cmd=clients&list={$currentlist|strtolower}" id="currentlist" style="display:none"></a>
                        <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                            <tbody>
                                <tr>
                                    <th width="20"><input type="checkbox" id="checkall"/></th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.clienthash}</a></th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.lastname}</a></th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=firstname|ASC"  class="sortorder">{$lang.firstname}</a></th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=email|ASC"  class="sortorder">{$lang.email}</a></th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=companyname|ASC"  class="sortorder">{$lang.company}</a></th>

                                    <th>{$lang.Services}</th>
                                    <th><a href="?cmd=clients&list={$currentlist}&orderby=datecreated|ASC"  class="sortorder">{$lang.Created}</a></th>
                                    <th></th>
                                </tr>
                            </tbody>
                            <tbody id="updater">

                                {include file='ajax.clients.tpl'}
                            </tbody>
                            <tbody id="psummary">
                                <tr>
                                    <th></th>
                                    <th colspan="10">
                                        {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                                    </th>
                                </tr>
                            </tbody>

                        </table>
                        {literal}<script type="text/javascript">function tagColumnShrink() {
                                var a = $("#updater").find(".inlineTags").width();
                                $("#updater").parent().find("tr:first th:last-child").width(a)
                            }
                            tagColumnShrink(), $("#updater").ajaxComplete(tagColumnShrink)</script>{/literal}
                            <div class="blu">
                                <div class="right"><div class="pagination"></div></div>
                                <div class="left menubar">
                                    {$lang.withselected}
                                    {if !$forbidAccess.deleteClients}
                                        <a class="menuitm menuf" href="#"  name="deleteclients"  onclick="deleteClients();
                                                    return false;" ><span style="color: red">{$lang.Delete}</span></a>{*
                                            *}{/if}{*
                                            *}<a class=" menuitm menu{if !$forbidAccess.deleteServices}l{/if}" href="#" onclick="return send_msg('clients')" ><span >{$lang.SendMessage}</span></a>

                                    </div>
                                    <div class="clear"></div>
                                </div>

                                {securitytoken}</form>
                            {elseif $action=='showprofile' || $action=='newprofile'}

                            {include file="clientprofile.tpl"}

                        {elseif $action=='show'}
                            <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js?v={$hb_version}"></script>
                            <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
                            <div id="confirm_cacc_close" style="display:none" class="confirm_container">

                                <div class="confirm_box">
                                    <h3>{$lang.closeheading}</h3>
                                    {$lang.closedescr}<br />
                                    <br />

                                    <input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.closeopt1}<br />
                                    <input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.closeopt2}<br />

                                    <br />
                                    <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="confirmsubmit2()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit2()"/></center>

                                </div>
                                <script type="text/javascript">
                                    {literal}
                                        function confirmsubmit2() {
                                            var add = '';
                                            if ($('#cc_hard').is(':checked'))
                                                add = '&hardclose=true';
                                            window.location.href = '?cmd=clients&make=close{/literal}&security_token={$security_token}{literal}&id=' + $('#client_id').val() + add;
                                        }
                                        function cancelsubmit2() {
                                            $('#confirm_cacc_close').hide().parent().css('position', 'inherit');
                                        }
                                    {/literal}
                                </script>
                            </div>

                            <div id="confirm_cacc_delete" style="display:none" class="confirm_container">

                                <div class="confirm_box">
                                    <h3>{$lang.deleteheading}</h3>
                                    {$lang.deletedescr}<br />
                                    <br />

                                    <input type="radio" checked="checked" name="cl_" value="1" id="cl_hard"/> {$lang.deleteopt1}<br />
                                    <input type="radio"  name="cl_" value="0" id="cl_soft"/> {$lang.deleteopt2}<br />

                                    <br />
                                    <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="confirmsubmit1()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit1()"/></center>

                                </div>
                                <script type="text/javascript">
                                    {literal}
                                        function confirmsubmit1() {
                                            var add = '';
                                            if ($('#cl_hard').is(':checked'))
                                                add = '&harddelete=true';
                                            window.location.href = '?cmd=clients&make=delete{/literal}&security_token={$security_token}{literal}&id=' + $('#client_id').val() + add;
                                        }
                                        function cancelsubmit1() {
                                            $('#confirm_cacc_delete').hide().parent().css('position', 'inherit');
                                        }
                                    {/literal}
                                </script>
                            </div>

                            <div id="confirm_curr_change" style="display:none" class="confirm_container">

                                <div class="confirm_box">
                                    <h3>{$lang.currheading}</h3>
                                    {$lang.currdescr}<br />
                                    <br />

                                    <div id="conf_c_b_1">
                                        <input type="radio" checked="checked" name="curchange" value="recalculate" /> {$lang.curropt1}<br />
                                        <input type="radio"  name="curchange" value="change"/> {$lang.curropt2}<br />
                                    </div>

                                    <br />
                                    <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="confirmsubmit()"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit()"/></center>

                                </div>
                                <script type="text/javascript">
                                    {literal}
                                        function confirmsubmit() {
                                            $('#clientform').append($('#conf_c_b_1').clone().hide());
                                            $('#clientform').unbind('submit');
                                            $('#clientsavechanges').click();
                                        }
                                        function cancelsubmit() {
                                            $('#confirm_curr_change').hide().parent().css('position', 'inherit');
                                        }
                                    {/literal}
                                </script>
                            </div>
                            <div class="blu">
                                <div class="menubar">
                                    <a href="?cmd=clients" ><strong>&laquo; {$lang.backtoallcl}</strong></a>

                                    <a onclick="$('.nav_el').eq(0).click();
                                            $('#tdetail a').click();
                                            return false;" class="menuitm" href="#" ><span >{$lang.editclientdetails}</span></a>

                                    {if $admindata.access.loginAsClient} <a   class=" menuitm menuf"  href="{$system_url2}?action=adminlogin&id={$client.client_id}" target="_blank"><span ><strong>{$lang.loginasclient}</strong></span></a>{/if}<a   class="menuitm menuc"   onclick="$('#ccinfo').toggle();
                                            return false" href="#" ><span >{$lang.ccard}</span></a><a   class="menuitm clDropdown menul" id="hd1" onclick="return false"  href="#" ><span class="morbtn">{$lang.moreactions}</span></a>

                                    <ul id="hd1_m" class="ddmenu">
                                        <li ><a href="EditNotes">{$lang.editclientnotes}</a></li>
                                        <li ><a href="OpenTicket">{$lang.opennewticket}</a></li>
                                        <li ><a href="PlaceOrder">{$lang.PlaceOrder}</a></li>
                                        <li ><a href="CreateInvoice">{$lang.CreateInvoice}</a></li>
                                            {if !$client.affiliate_id}
                                            <li ><a href="EnableAffiliate">{$lang.EnableAffiliate}</a></li>
                                            {/if}
                                        <li ><a href="SendNewPass">{$lang.SendNewPass}</a></li>
                                        <li ><a href="CloseAccount">{$lang.CloseAccount}</a></li>
                                        <li ><a href="DeleteAccount" style="color:#ff0000">{$lang.DeleteProfile}</a></li>
                                    </ul>
                                </div>
                            </div>
                            <form action='' method='post' id="clientform" enctype="multipart/form-data">
                                <input type="hidden" value="{$client.currency_id}" name="old_currency_id" id="old_currency_id"/>

                                <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>

                                <div class="lighterblue" style="padding:5px;display:none" id="ccinfo">
                                    {if !$admindata.access.viewCC && !$admindata.access.editCC}
                                        {$lang.lackpriviliges}
                                    {else}
                                        {if $client.cardnum!=''}
                                            <div id="cc_cont" style="min-height: 2em">
                                                {include file='ajax.clients.tpl' action=ccshow cmake=ccshow cardcode=$client verify=1}

                                                <div class="o1" style="padding: 5px 0">
                                                    {if $admindata.access.editCC}
                                                        <a href="#" onclick="return load_cc_verify();" class="menuitm">{$lang.editcardnumber}</a>
                                                    {elseif $admindata.access.viewCC}
                                                        <a href="#" onclick="return load_cc_verify();" class="menuitm">{$lang.viewcardnumber}</a>
                                                    {/if}
                                                </div>
                                                <div class="o2" style="display:none; padding: 5px 0">
                                                    {$lang.provideyourpassword} 
                                                    <input  type="password" name="admin_pass" id="admin_pass" />
                                                    <input type="button" id="ccbutton" onclick="return verify_pass({if $admindata.access.editCC}'ccadd'{else}'ccshow'{/if})" value="{$lang.submit}" style="font-weight:bold" />
                                                </div>
                                            </div>
                                        {else}
                                            <div id="cc_cont" style="min-height: 2em">
                                                <div class="o1">
                                                    {$lang.nocreditcard} 
                                                    {if $admindata.access.editCC}<a href="#" onclick="return add_cc();">{$lang.clicktoadd}</a>{/if}
                                                </div>
                                                {if $admindata.access.editCC}<div class="o2" style="display:none"></div>{/if}
                                            </div>
                                        {/if}
                                    {/if}

                                    <script type="text/javascript">
                                        {literal}
                                            function verify_pass(act) {
                                                act = act || 'ccard';
                                                if ($('#admin_pass').val() == '')
                                                    $('#admin_pass').val('none');
                                                $('#cc_cont').addLoader();
                                                ajax_update('?cmd=clients', {action: act, client_id: $('#client_id').val(), passprompt: $('#admin_pass').val()}, '#cc_cont');
                                                return false;
                                            }
                                            function edit_cc() {
                                                return add_cc();
                                            }
                                            function load_cc_verify() {
                                                $('#cc_cont .o1').hide();
                                                $('#cc_cont .o2').show();
                                                return false;
                                            }
                                            function view_cc() {

                                            }
                                            function add_cc() {
                                                $('#cc_cont .o1').hide();
                                                $('#cc_cont').addLoader();
                                                ajax_update('?cmd=clients&action=ccadd', {client_id: $('#client_id').val()}, '#cc_cont');
                                                return false;
                                            }
                                            $(document).on('keydown', '#admin_pass', function(e) {
                                                if (e.keyCode == 13) {
                                                    verify_pass();
                                                    return false;
                                                }
                                            })
                                        {/literal}
                                    </script>
                                </div>
                                {if $picked_tab}
                                    <script type="text/javascript">
                                        {literal}
                                            function fireme() {
                                                $('#{/literal}{$picked_tab}{literal}_tab').click();
                                            }
                                            appendLoader('fireme');
                                        {/literal}
                                    </script>
                                {/if}
                                <div id="ticketbody">
                                    <h1>#{$client.client_id} {$client.lastname} {$client.firstname}</h1>
                                    <div id="client_nav">
                                        <!--navigation-->
                                        <a class="nav_el nav_sel left" href="#">{$lang.clientprofile}</a>
                                        {include file="_common/quicklists.tpl"}

                                        <div class="clear"></div>
                                    </div>

                                    <div class="ticketmsg ticketmain" id="client_tab">
                                        <div class="slide" style="display:block">

                                            <div class="right replybtn tdetail" id="tdetail"><strong><a href="#"><span class="a1">{$lang.editdetails}</span><span class="a2">{$lang.hidedetails}</span></a></strong></div>

                                            <div id="detcont">
                                                <div class="tdetails">
                                                    <table border="0" width="90%" cellspacing="5" cellpadding="0">

                                                        {foreach from=$fields item=field key=k name=floop}
                                                            {if $smarty.foreach.floop.index%3==0}<tr>{/if}

                                                                <td width="100" align="right" {if $field.type=='Company'}class="iscomp light" style="{if $client.company!='1'}display:none{/if}"
                                                                    {elseif $field.type=='Private'}class="ispr light" style="{if $client.company=='1'}display:none{/if}" {else}class="light"{/if}>{if $k=='type'}
                                                                                    {$lang.clacctype}
                                                                                {elseif $field.options & 1}
                                                                            {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                                                        {else}
                                                                            {$field.name}
                                                                        {/if}:</td>
                                                                    <td width="150" align="left" {if $field.type=='Company'}class="iscomp" style="{if $client.company!='1'}display:none{/if}"
                                                                        {elseif $field.type=='Private'}class="ispr" style="{if $client.company=='1'}display:none{/if}" {else}{/if}><span class="livemode" >
                                                                                    {if $k=='type'}{if $client.company=='0'}{$lang.Private}{/if}
                                                                                    {if $client.company=='1'}{$lang.Company}{/if}

                                                                                {elseif $k=='country'}
                                                                                    {$client.country} - {$client.countryname}
                                                                                {else}
                                                                                    {if $field.field_type=='Password'}
                                                                                    {elseif $field.field_type=='Check'}
                                                                                        {foreach from=$field.default_value item=fa}
                                                                                            {if in_array($fa,$client[$k])}{$fa},{/if}
                                                                                        {/foreach}

                                                                                    {else}
                                                                                        {$client[$k]}

                                                                                    {/if}
                                                                                {/if}</span>{if $field.code=='email'}<span class='copytext' data-clipboard-target="field_live_{$field.code}">复制</span>{/if}</td>

                                                                        {if $smarty.foreach.floop.index%3==5}</tr>{/if}
                                                                        {/foreach}

                                                                        <tr>

                                                                            <td width="100" align="right" class="light">{$lang.clacctype}:</td>
                                                                            <td width="150" align="left">
                                                                                <span class="livemode">{if $client.company=='0'}{$lang.Private}{/if}
                                                                                {if $client.company=='1'}{$lang.Company}{/if}</span>
                                                                        </td>

                                                                        {if count($currencies)>1}
                                                                            <td width="100" align="right" class="light">{$lang.currency}:</td>
                                                                            <td width="150" align="left" <span class="livemode">
                                                                                    {foreach from=$currencies item=curre}
                                                                                    {if $client.currency_id==$curre.id}{$curre.code}{/if}
                                                                                {/foreach}
                                                                            </span></td>
                                                                        {else}
                                                                        <td colspan="2"></td>
                                                                    {/if}

                                                                    <td width="100" align="right" class="light">{$lang.Status}:</td>
                                                                    <td width="150" align="left"><span class="{$client.status} livemode">{$lang[$client.status]}</span></td>
                                                                </tr>

                                                                {if $groups}
                                                                    <tr>
                                                                        <td width="100" align="right" class="light">{$lang.Group}:</td>
                                                                        <td width="150" align="left" ><span style="color:{$client.group_color}" class="livemode">{$client.group_name}</span></td>

                                                                        <td colspan="2"></td>
                                                                        <td colspan="2"></td>
                                                                        </td>
                                                                    </tr>
                                                                {/if}

                                                            </table>
                                                        </div>
                                                        <div class="secondtd" style="display:none">

                                                            <table border="0" width="100%" cellspacing="5" cellpadding="0">

                                                                {foreach from=$fields item=field key=k name=floop}
                                                                    {if $smarty.foreach.floop.index%3==0}<tr>{/if}

                                                                        <td  width="100" align="right" {if $field.type=='Company'}class="iscomp light" style="{if $client.company!='1'}display:none{/if}"
                                                                             {elseif $field.type=='Private'}class="ispr light" style="{if $client.company=='1'}display:none{/if}" {else}class="light"{/if}>{if $k=='type'}
                                                                                            {$lang.clacctype}
                                                                                        {elseif $field.options & 1}
                                                                                    {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                                                                {else}
                                                                                    {$field.name}
                                                                                {/if}:</td>
                                                                            <td {if $field.type=='Company'}class="iscomp" style="{if $client.company!='1'}display:none{/if}"
                                                                                                           {elseif $field.type=='Private'}class="ispr" style="{if $client.company=='1'}display:none{/if}" {else}{/if}>
                                                                                            {if $k=='type'}
                                                                                            {elseif $k=='country'}<select name="country"  id="field_live_{$field.code}">
                                                                                                    {foreach from=$countries key=k item=v}
                                                                                                        <option value="{$k}" {if $k==$client.country} selected="Selected"{/if}>{$v}</option>

                                                                                                    {/foreach}
                                                                                                </select>
                                                                                            {else}
                                                                                                {if $field.field_type=='Password'}
                                                                                                {elseif $field.field_type=='Input'}
                                                                                                    <input  value="{$client[$field.code]}"   id="field_live_{$field.code}" name="{$field.code}" style="width: 80%;"/>
                                                                                                {elseif $field.field_type=='Check'}
                                                                                                    {foreach from=$field.default_value item=fa}
                                                                                                        <input type="checkbox" name="{$field.code}[{$fa}]" value="1" {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>{$fa}<br />
                                                                                                    {/foreach}
                                                                                                {else}
                                                                                                    <select name="{$field.code}" id="field_live_{$field.code}"  style="width: 80%;">
                                                                                                        {foreach from=$field.default_value item=fa}
                                                                                                            <option {if $client[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
                                                                                                        {/foreach}
                                                                                                    </select>
                                                                                                {/if}
                                                                                            {/if}</td>

                                                                                        {if $smarty.foreach.floop.index%3==5}</tr>{/if}
                                                                                        {/foreach}

                                                                                        <tr>

                                                                                            <td width="100" align="right" class="light">{$lang.clacctype}:</td>
                                                                                            <td width="150" align="left" ><select  name="type"  onchange="{literal}if ($(this).val() == 'Private') {
                                                                                                        $('.iscomp').hide();
                                                                                                        $('.ispr').show();
                                                                                                    } else {
                                                                                                        $('.ispr').hide();
                                                                                                        $('.iscomp').show();
                                                                                                    }{/literal}">
                                                                                                    <option value="Private" {if $client.company=='0'}selected="selected"{/if}>{$lang.Private}</option>
                                                                                                    <option value="Company" {if $client.company=='1'}selected="selected"{/if}>{$lang.Company}</option>
                                                                                                </select></td>

                                                                                            {if count($currencies)>1}
                                                                                                <td width="100" align="right" class="light">{$lang.currency}:</td>
                                                                                                <td width="150" align="left" >
                                                                                                    <select name="currency_id" id="currency_id">
                                                                                                        {foreach from=$currencies item=curre}
                                                                                                            <option value="{$curre.id}" {if $client.currency_id==$curre.id}selected="selected"{/if}>{if $curre.iso}{$curre.iso}{else}{$curre.code}{/if}</option>
                                                                                                        {/foreach}
                                                                                                    </select></td>
                                                                                                {else}
                                                                                                <td colspan="2"><input type="hidden" id="currency_id" value="{$client.currency_id}" /></td>
                                                                                                {/if}

                                                                                            <td width="100" align="right" class="light">{$lang.Status}:</td>
                                                                                            <td width="150" align="left" >
                                                                                                <select name="status">
                                                                                                    <option value="Active" {if $client.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                                                                                                    <option value="Closed"{if $client.status=='Closed'}selected="selected"{/if}>{$lang.Closed}</option>
                                                                                                </select>
                                                                                            </td>

                                                                                        </tr>
                                                                                        {if $groups}
                                                                                            <tr>
                                                                                                <td width="100" align="right" class="light">{$lang.Group}:</td>
                                                                                                <td width="150" align="left" ><select  name="group_id" >
                                                                                                        <option value="0" {if $client.group_id=='0'}selected="selected"{/if}>{$lang.none}</option>
                                                                                                        {foreach from=$groups item=group}
                                                                                                            <option value="{$group.id}" style="color:{$group.color}" {if $client.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
                                                                                                        {/foreach}
                                                                                                    </select></td>

                                                                                                <td colspan="2"></td>
                                                                                                <td colspan="2"></td>
                                                                                                </td>
                                                                                            </tr>
                                                                                        {/if}
                                                                                        <tr></tr>
                                                                                    </table>

                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        {include file="_common/quicklists.tpl" _placeholder=true}
                                                                    </div>

                                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <td width="50%" valign="top">
                                                                                <div class="ticketmsg ticketmain" id="client_tab">

                                                                                    <div id="detcont">
                                                                                        <div class="tdetails">
                                                                                            <table border="0" width="100%" cellspacing="5" cellpadding="0">
                                                                                                <tr>
                                                                                                    {if $enabletax}
                                                                                                        <td width="25%" align="right" class="light">{$lang.taxexempt}:</td>
                                                                                                        <td width="25%" align="left"><span class="livemode">{if $client.taxexempt=='' || $client.taxexempt=='0'}{$lang.No}{else}{$lang.Yes}{/if}</span></td>
                                                                                                        {else}
                                                                                                        <td colspan="2"></td>
                                                                                                    {/if}
                                                                                                    {if $latefee}
                                                                                                        <td width="25%" align="right" class="light">{$lang.latefees}:</td>
                                                                                                        <td width="25%" align="left"><span class="livemode">{if $client.latefeeoveride=='' || $client.latefeeoveride=='0'}{$lang.Yes}{else}{$lang.No}{/if}</span></td>
                                                                                                        {else}
                                                                                                        <td colspan="2"></td>
                                                                                                    {/if}

                                                                                                </tr>
                                                                                                <tr>
                                                                                                    {if $overdue}
                                                                                                        <td width="25%" align="right" class="light">{$lang.oveduenotices}:</td>
                                                                                                        <td width="25%" align="left"><span class="livemode">{if $client.overideduenotices=='' ||  $client.overideduenotices=='0'}{$lang.Yes}{else}{$lang.No}{/if}</span></td>

                                                                                                    {else}
                                                                                                        <td colspan="2"></td>
                                                                                                    {/if}
                                                                                                    {if $enabletax}
                                                                                                        <td width="25%" align="right" class="light">{$lang.taxrateoverride}:</td>
                                                                                                        <td width="25%" align="left"><span class="livemode">{if $client.taxrateoverride!='1'}{$lang.No}{else}{$lang.Yes} {$client.taxrate} % {/if}</span></td>
                                                                                                    {else}
                                                                                                        <td colspan="2"></td>
                                                                                                    {/if}
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td width="25%" align="right" class="light">防止自动暂停/终止:</td>
                                                                                                    <td width="25%" align="left"><span class="livemode">{if $client.overideautosusp=='1'}{$lang.Yes}{else}{$lang.No}{/if}</span></td>

                                                                                                    <td width="25%" align="right" class="light">{$lang.defaultlanguage}:</td>
                                                                                                    <td width="25%" align="left"><span class="livemode">{$client.language}</span></td>

                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td width="25%" align="right" class="light">{$lang.password}:</td>
                                                                                                    <td width="25%" align="left"><span class="livemode">**********</span></td>

                                                                                                    <td width="25%" align="right" class="light"></td>
                                                                                                    <td width="25%" align="left"></td>

                                                                                                </tr>

                                                                                            </table>
                                                                                        </div>
                                                                                        <div class="secondtd" style="display:none">

                                                                                            <table border="0" width="100%" cellspacing="5" cellpadding="0">
                                                                                                <tr>
                                                                                                    {if $enabletax}
                                                                                                        <td width="25%" align="right" class="light">{$lang.taxexempt}:</td>
                                                                                                        <td width="25%" align="left"><select name="taxexempt">
                                                                                                                <option value="0" {if $client.taxexempt=='0' || $client.taxexempt==''}selected="selected"{/if}>否</option>
                                                                                                                <option value="1"{if $client.taxexempt=='1'}selected="selected"{/if}>是</option>

                                                                                                            </select></td>
                                                                                                        {else}
                                                                                                        <td colspan="2">
                                                                                                            <input type="hidden" value="{$client.taxexempt}" name="taxexempt" />
                                                                                                        </td>
                                                                                                    {/if}
                                                                                                    {if $latefee}
                                                                                                        <td width="25%" align="right" class="light">{$lang.latefees}:</td>
                                                                                                        <td width="25%" align="left"><select name="latefeeoveride">
                                                                                                                <option value="1" {if $client.latefeeoveride=='1' || $client.latefeeoveride==''}selected="selected"{/if}>否</option>
                                                                                                                <option value="0"{if $client.latefeeoveride=='0'}selected="selected"{/if}>是</option>
                                                                                                            </select></td>
                                                                                                        {else}
                                                                                                        <td colspan="2">
                                                                                                            <input type="hidden" name="latefeeoveride" value="{$client.latefeeoveride}" />
                                                                                                        </td>
                                                                                                    {/if}

                                                                                                </tr>
                                                                                                <tr> 
                                                                                                    {if $overdue}
                                                                                                        <td width="25%" align="right" class="light">{$lang.oveduenotices}:</td>
                                                                                                        <td width="25%" align="left"><select name="overideduenotices">
                                                                                                                <option value="1" {if $client.overideduenotices=='1' || $client.overideduenotices==''}selected="selected"{/if}>否</option>
                                                                                                                <option value="0"{if $client.overideduenotices=='0'}selected="selected"{/if}>Yes</option>
                                                                                                            </select></td>
                                                                                                        {else}
                                                                                                        <td colspan="2"><input type="hidden" name="overideduenotices" value="{$client.overideduenotices}"/></td>
                                                                                                        {/if}

                                                                                                    {if $enabletax}
                                                                                                        <td width="25%" align="right" class="light">{$lang.taxrateoverride}:</td>
                                                                                                        <td width="25%" align="left">
                                                                                                            <select name="taxrateoverride">
                                                                                                                <option value="1" {if $client.taxrateoverride=='1'}selected="selected"{/if}>是</option>
                                                                                                                <option value="0" {if $client.taxrateoverride!='1'}selected="selected"{/if}>否</option>
                                                                                                            </select>
                                                                                                            <input value="{$client.taxrate}"  name="taxrate" style="width: 30px;"> %
                                                                                                        </td>
                                                                                                    {else}
                                                                                                        <td colspan="2">
                                                                                                            <input type="hidden" value="{$client.taxrateoverride}" name="taxrateoverride" />
                                                                                                            <input type="hidden" value="{$client.taxrate}" name="taxrateoverride" />
                                                                                                        </td>
                                                                                                    {/if}
                                                                                                <tr/>
                                                                                                <tr>
                                                                                                    <td width="25%" align="right" class="light">防止自动暂停/终止:</td>
                                                                                                    <td width="25%" align="left">
                                                                                                        <select name="overideautosusp">
                                                                                                            <option value="0" {if !$client.overideautosusp || $client.overideautosusp=='0'}selected="selected"{/if}>否</option>
                                                                                                            <option value="1" {if $client.overideautosusp=='1'}selected="selected"{/if}>是</option>
                                                                                                        </select>
                                                                                                    </td>
                                                                                                    <td width="25%" align="right" class="light">{$lang.defaultlanguage}:</td>
                                                                                                    <td width="25%" align="left">
                                                                                                        <select name="language">
                                                                                                            {foreach from=$client_languages key=k item=v}
                                                                                                                <option {if $v==$client.language} selected="selected"{/if}>{$v}</option>

                                                                                                            {/foreach}
                                                                                                        </select>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td width="25%" align="right" class="light">{$lang.newpass}:</td>
                                                                                                    <td width="25%" align="left"><input name="password" /></td>

                                                                                                    <td width="25%" align="right" class="light">{$lang.repeatpass}:</td>
                                                                                                    <td width="25%" align="left"><input name="password2" /></td>

                                                                                                </tr>

                                                                                            </table>

                                                                                        </div>
                                                                                    </div>

                                                                                </div>
                                                                            </td>
                                                                            <td width="50%" valign="top" style="padding-left:5px;">
                                                                                <div class="ticketmsg ticketmain" >

                                                                                    <div id="detcont">

                                                                                        <table border="0" width="100%" cellspacing="5" cellpadding="0">
                                                                                            <tr>
                                                                                                <td width="25%" align="right" class="light">{$lang.signupdate}:</td>
                                                                                                <td width="75%" align="left">{$client.datecreated|dateformat:$date_format}</td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <td width="25%" align="right" class="light">{$lang.clientlastlogin}:</td>
                                                                                                <td width="75%" align="left">{if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|dateformat:$date_format}{/if}</td>
                                                                                            </tr>

                                                                                            <tr>
                                                                                                <td width="25%" align="right" class="light">{$lang.From}:</td>
                                                                                                <td width="75%" align="left">{$client.ip} {$lang.Host}: {$client.host}</td>
                                                                                            </tr>

                                                                                        </table>

                                                                                    </div>

                                                                                </div>

                                                                            </td>

                                                                        </tr>

                                                                        <tr>
                                                                            <td colspan="2">
                                                                                <div class="p6 secondtd" style="display:none;text-align:center;margin-bottom:7px;padding:15px 0px;">
                                                                                    <a class="new_control greenbtn" href="#" onclick="$('#clientsavechanges').click();
                                                                                            return false;"><span>{$lang.savechanges}</span></a>
                                                                                    <span class="orspace fs11">{$lang.Or}</span> <a href="#" class="editbtn" onclick="$('#tdetail a').click();
                                                                                            return false;">{$lang.Cancel}</a>
                                                                                    <input type="submit" value="{$lang.savechanges}" id="clientsavechanges" style="display:none" name="save"/>
                                                                                    <input type="hidden" value="1" name="save"/>
                                                                                </div>
                                                                            </td>
                                                                        </tr>

                                                                        <tr><td>
                                                                                <div class="ticketmsg ticketmain" >
                                                                                    <div id="client_stats">
                                                                                        {$lang.LoadingStats}
                                                                                    </div>

                                                                                </div>

                                                                            </td>
                                                                            <td style="padding-left:5px" valign="top">
                                                                                <div class="blu" >
                                                                                    {$lang.SendMessage}: <select name="mail_id" id="mail_id">
                                                                                        <option value="1">Details:Signup</option>
                                                                                        {foreach from=$client_emails item=send_email}
                                                                                            <option value="{$send_email.id}">{$send_email.tplname}</option>
                                                                                        {/foreach}
                                                                                        <option value="custom" style="font-weight:bold">{$lang.newmess}</option>

                                                                                    </select>
                                                                                    <input type="button" name="sendmail" value="{$lang.Send}" id="sendmail"/>
                                                                                </div>
                                                                                <div style="margin-top:10px" id="itemqueue">
                                                                                    {literal}<script>
                                                                                        appendLoader('load_itemqueue');
                                                                                        var load_itemqueue = function() {
                                                                                            ajax_update('?cmd=clients&action=itemqueue&client_id=' + $('#client_id').val(), {}, '#itemqueue');
                                                                                        }</script>{/literal}
                                                                                    </div>
                                                                                    <div style="margin-top:10px" id="clientfiles">
                                                                                        {literal}<script>
                                                                                            appendLoader('load_clientfiles');
                                                                                            var load_clientfiles = function() {
                                                                                                ajax_update('?cmd=clients&action=listclientfiles&client_id=' + $('#client_id').val(), {}, '#clientfiles');
                                                                                            }</script>{/literal}
                                                                                        </div>

                                                                                        <div style="margin-top:10px" id="clienthistory">
                                                                                            {literal}<script>
                                                                                                appendLoader('load_clienthistory');
                                                                                                var load_clienthistory = function() {
                                                                                                    ajax_update('?cmd=clients&action=history&client_id=' + $('#client_id').val(), {}, '#clienthistory');
                                                                                                }</script>{/literal}
                                                                                            </div>

                                                                                            {include file='_common/noteseditor.tpl'}
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>

                                                                                {securitytoken}
                                                                        </form>

                                                                        {/if}
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>