{if $action=='listdepts'}
    {if $depts}
        {foreach from=$depts item=dept name=cat}
            <tr>
                <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.name}</a></td>
                <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.description}</a></td>
                <td><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.email}</a></td>
                <td>{if $dept.visible=='1'}{$lang.No}{else}{$lang.Yes}{/if}</td>
                <td>
                    <input type="hidden" name="sort[]" value="{$dept.id}" />
                {if !$smarty.foreach.cat.first}<a href="javascript:void(0);" onclick="sortit(this, 'up')"  class="upsorter">Up</a>{/if}</td>
            <td>{if !$smarty.foreach.cat.last}<a href="javascript:void(0);" onclick="sortit(this, 'down')"  class="downsorter">Down</a>{/if}</td>
            <td><a href="?cmd=ticketdepts&make=delete&id={$dept.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletedeptconfirm}');">Delete</a></td>
        </tr>
    {/foreach}
    <script type="text/javascript">bindTicketEvents();</script>
{/if}

{elseif $action=='add' || $action=='edit'}
    {literal}
        <script type="text/javascript">
            $(function() {
                $('#newshelfnav').TabbedMenu({elem: '.sectioncontent', picker: '.list-1 li', aclass: 'active'{/literal}{if $pickedtab}, picked: '{$pickedtab}'{/if}{literal}});
                $("input[name='sendmethod']").each(function(ind) {
                    $(this).change(function() {
                        $('.sendmailform').hide().eq(ind).show();
                        if (ind == 0)
                            $('.sendmailem').hide();
                        else
                            $('.sendmailem').show();
                    });
                });
            });
        </script>
        <style type="text/css">
            .labels {}
            .import-mail .inputs, .import-mail .labels, .import-mail .poptest{
                line-height: 17px;
                min-height: 45px;
            }
            .import-mail .new_control{
                line-height: 17px;
                margin: 0 5px;
                padding: 6px 7px 4px;
            }
            .pipe-label{color: #888888;
                display: block;
                padding: 5px 0;}
            .import-mail .poptest {padding: 1em}
            .poptest .result {padding: 1em}
            .inputs{ padding: 2px 20px 2px 0;}
            .labels label, .inputs input {display:block; margin:5px}

            .inputs label input{display:inline; margin: 0 4px 2px 8px; vertical-align: middle;}
            .inputs input{color:black;}
            .labels label, .inputs div{padding: 4px;}
        </style>
    {/literal}
    <div class="blu"> 
        {if $action=='edit'}
            <a href="?cmd=ticketdepts"  class="tload2"><strong>{$lang.ticketdepts}</strong></a>
            &raquo; <strong>{$submit.name}</strong>
        {else}
            <a href="?cmd=ticketdepts"  class="tload2"><strong>{$lang.ticketdepts}</strong></a>
            &raquo; <strong>{$lang.adddepartment}</strong>
        {/if}
    </div>
    <form method="post" >
        <div class="newhorizontalnav" id="newshelfnav">
            <div class="list-1">
                <ul>
                    <li>
                        <a href="#"><span class="ico money">{$lang.General}</span></a>
                    </li>
                    <li >
                        <a href="#"><span class="ico plug">{$lang.importemails_tab}</span></a>
                    </li>
                    <li>
                        <a href="#"><span class="ico gear">{$lang.sendemail}</span></a>
                    </li>
                    <li>
                        <a href="#"><span class="ico gear">{$lang.slaescalate}</span></a>
                    </li>
                    <li>
                        <a href="#"><span class="ico gear">{$lang.othersettings}</span></a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="nicerblu" style="padding-top:20px;">
            <table width="100%" cellspacing="0" cellpadding="6" border="0">
                <tbody class="sectioncontent">
                    <tr>
                        <td width="160" align="right"><strong>{$lang.departmentname}</strong></td>
                        <td ><input type="text" value="{$submit.name}" size="50" name="name"  class="inp" style="font-weight:bold;"/></td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.Description} asd</strong></td>
                        <td >{if !$submit.description}<a href="#" onclick="$(this).hide();
                $('input[name=\'description\']').show();
                return false;"><strong>{$lang.adddescription}</strong></a>{/if}
                            <input type="text" value="{$submit.description}" size="50" name="description" {if !$submit.description} style="display:none"{/if} class="inp"/>
                        </td>
                    </tr>
                    <tr>
                        <td align="right"><strong>{$lang.assignedadmins}</strong></td>
                        <td class="staff-list">
                            {foreach from=$admins item=adm}
                                <label class="left" style="width:20%">
                                    <input type="checkbox" {if $submit.assigned_admins[$adm.id] || $submit.admins[$adm.id] || ($action!='edit' &&  !$submit.admins)}checked="checked"{/if}
                                    name="admins[{$adm.id}]" value="{$adm.id}"/>{$adm.username}
                                </label>
                            {/foreach}
                        </div>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        <strong>Staff auto-assignment</strong>
                        <a href="#" title="New tickets will be automatically distributed by and assigned to selected staff members." class="vtip_description" ></a>
                    </td>
                    <td class="staff-assign-list">
                        {foreach from=$admins item=adm}
                            <label class="left"  style="width:20%">
                                <input type="checkbox" 
                                {if !( $submit.assigned_admins[$adm.id] || $submit.admins[$adm.id] || ($action!='edit' &&  !$submit.admins) )}disabled="disabled"{/if}       
                                {if $submit.auto_assigment[$adm.id] || $submit.auto_assigment[$adm.id] || ($action!='edit' &&  !$submit.auto_assigment)}checked="checked"{/if}
                                name="auto_assigment[{$adm.id}]" value="{$adm.id}" />{$adm.username}
                            </label>
                        {/foreach}
                        <div class="clear"></div>
                    </td>
                </tr>
                <tr>
                    <td align="right" valign="top">
                        <strong>Aassignment Options</strong>
                    <td>
                    <input id="replyassignment" type="checkbox" 
                            {if $submit.replyassignment==1}checked="checked"{/if}
                            name="replyassignment" value="1" /> <b>Auto-assign first admin to reply</b> 
                    <a href="#" title="Ticket will be assigned to staff members as soon as they reply to a ticket." class="vtip_description" ></a>
                    <br/>
                    <input type="checkbox" 
                            {if $submit.replyreassign==1}checked="checked"{/if}
                            name="replyreassign" value="1" /> <b>Re-assign ticket after staff reply</b> 
                    <a href="#" title="Assigment will be changed to staff member that added last reply. Only for auto-assignment enabled staff members" class="vtip_description" ></a>
                
                <script type="text/javascript">
                    {literal}
                    var staffAssign = $('.staff-assign-list input')
                        checkStaffAssign = function(i){
                            if (this.checked && !staffAssign.eq(i).data('disabled'))
                               staffAssign.eq(i).prop('disabled', false).removeAttr('disabled');
                            else
                               staffAssign.eq(i).prop('disabled', true).attr('disabled', 'disabled');
                        };
                    $('.staff-list input').each(function(i){
                        $(this).change(function(){checkStaffAssign.call(this, i)});
                    });
                    $('#replyassignment').change(function(){
                        if($(this).is(':checked')){ 
                            staffAssign.data('disabled',true); 
                        } else { 
                            staffAssign.data('disabled',false); 
                        }
                        $('.staff-list input').each(checkStaffAssign);
                    }).change();
                    
                    {/literal}
                </script>
            </td>
        </tr>
    </tbody>

    <tbody class="sectioncontent whitetable import-mail" style="display:none">
        <tr>
            <th>{$lang.email}</th>
            <th>{$lang.importemails}</th>
            <th></th>
        </tr>
        {foreach from=$submit.importmails item=mail key=key}
        {if $mail.email}
            <tr>
                <td>{$mail.email}</td>
                <td>{if $mail.method=='POP'}{$lang.popmethod}{else}{$lang.pipemethod}{/if}</td>
                <td>
                    <a href="#" class="editbtn" onclick="editImportMail(this); return false">Edit</a>
                    {if $key>0}<a href="#" class="editbtn" onclick="removeImportMail(this); return false">Delete</a>{/if}
                </td>
            </tr>
        {/if}
        <tr {if $key==0}id="mainImportEmail"{/if} class="import-mail-row" {if $mail.email}style="display: none"{/if}>
            <td  width="460">
                <input type="hidden" value="{$mail.id}" name="importmail[{$key}][id]" />
                <input type="email" value="{$mail.email}" size="50" name="importmail[{$key}][email]" class="inp import-email" placeholder="email@address.com"/>
            </td>
            <td >
                <select name="importmail[{$key}][method]" class="inp import-method">
                    <option value="PIPE">{$lang.pipemethod}</option>
                    <option value="POP" {if $mail.method=='POP'}selected="selected"{/if}>{$lang.popmethod}</option>
                </select>
                <a class="new_control clear" href="#" onclick="testImportConfiguration($(this).prev().val(), this); return false;">
                    <span class="wizard">{$lang.test_configuration}</span>
                </a>
            </td>
            <td>{if $key>0}<a href="#" class="editbtn" onclick="removeImportMail(this); return false">Delete</a>{/if}</td>
        </tr>
        <tr id="popform"  {if $mail.email || $mail.method!='POP' || !$mail.method}style="display:none"{/if}>
            <td colspan="3">
                <div class="labels lighterblue left" >
                    <label for="pop_host">{$lang.Hostname}</label> 
                    <label for="pop_login">{$lang.loginname}</label> 
                </div>
                <div class="inputs lighterblue left">
                    <input type="text" class="pop-host" value="{$mail.host}" size="40" name="importmail[{$key}][host]" class="inp"/>
                    <input type="text" class="pop-login" value="{$mail.login}" size="40" name="importmail[{$key}][login]" class="inp"/> 
                </div>
                <div class="labels lighterblue left" >
                    <label for="pop_port">{$lang.Port|capitalize} 
                        <a class="vtip_description" title="Default ports:<br>&nbsp; 110 - POP3,<br>&nbsp; 143 - IMAP,<br>&nbsp; 993 - POP3+ssl,<br>&nbsp; 995 - POP3+ssl self-signed"></a></label> 
                    <label for="pop_pass">{$lang.Password}</label> 
                </div>
                <div class="inputs lighterblue left">
                    <input type="text" class="pop-port" value="{$mail.port}" size="3" name="importmail[{$key}][port]" class="inp"/>
                    <input type="password" class="pop-pass" value="{$mail.password}" size="20" name="importmail[{$key}][password]" autocomplete="off" class="inp"/>
                </div>
                <div class="lighterblue poptest">
                    <span class="result"></span>
                </div>
            </div>
            </td>
        </tr>
        {if $mail.method != "POP"}{assign var=pipeImportOn value=true}{/if}
        {/foreach}
        <tr>
            <td colspan="1">
                <a href="#" class="editbtn" onclick="addNewImportMail(this);
                return false">Add another import email</a>
            </td>
            <td colspan="2">
                <div id="pipeIportLine" {if !$pipeImportOn}style="display: none"{/if}>
                    <label class="pipe-label" for="pipeIportInput" >For PIPE import you will need to setup your email forwarder using given command</label>
                    <input id="pipeIportInput" readonly="readonly" value=" | php -q {$path}"  style="width:50%" class="inp"/>
                    <div style="display:none" id="pipe_testing">
                        <h2>PIPE Import Test</h2>
                        <div id="pipe_testing_result">
                            <ul>
                            <li {if $action!='edit'}style="color:red"{/if}>Save this department settings before performing import test</li>
                            <li>Make sure that Email forwarder is added in your control panel</li>
                        </ul>
                    </div>
                </div>
            </td>
        </tr>
    </tbody>

    <tbody class="sectioncontent" style="display:none">
        <tr>
            <td align="right" width="160"><strong>{$lang.sendemailusing}</strong></td>
            <td >
                <input type="radio" name="sendmethod" value="1" {if $submit.sendmethod=='1' || !$submit.sendmethod}checked="checked"{/if} /><strong>{$lang.hostbillmail}</strong>
                <br />
                <input type="radio" name="sendmethod" value="2" {if $submit.sendmethod=='2' }checked="checked"{/if} /><strong>{$lang.phpmail}</strong>
                <br />
                <input type="radio" name="sendmethod" value="3" {if $submit.sendmethod=='3' }checked="checked"{/if} /><strong>{$lang.smtpmail}</strong>
            </td>
        </tr>
        <tr class="sendmailem" {if $submit.sendmethod=='1' || !$submit.sendmethod}style="display:none"{/if}>
            <td align="right"><strong>{$lang.senderemail}</strong></td>
            <td>
                <input type="text" value="{$submit.senderemail}" size="50" name="senderemail"  class="inp"/>
            </td>
        </tr>
        <tr class="sendmailform" {if $submit.sendmethod!='1' && $submit.sendmethod}style="display:none"{/if}>
            <td></td>
            <td>
                <div class="lighterblue" style="padding:5px 10px; line-height: 26px;">
                    <a href="?cmd=configuration&picked_tab=4">{$lang.hbemailconf}</a>
                </div>
            </td>
        </tr>
        <tr class="sendmailform" {if $submit.sendmethod!='2'}style="display:none"{/if}>
            <td></td>
            <td>
                <div style="padding:10px 0">
                    <a class="new_control" href="#"   onclick="$(this).hide();
                $('#phpmail_ad').show();
                return false;"><span class="wizard">{$lang.sendtestmail}</span></a>
                    <div id="phpmail_ad" style="display:none">
                        {$lang.enteremail} <input type="text" name="testmail" id="testmailaddressphp" /> <a class="new_control" href="#"   onclick="testConfiguration('PHP');
                return false;"><span ><b>{$lang.Send}</b></span></a>
                        <span  id="php_testing_result"></span>
                    </div>
                </div>
            </td>
        </tr>

        <tr class="sendmailform" {if $submit.sendmethod!='3'}style="display:none"{/if}>
            <td></td>
            <td>
                <div class="labels lighterblue" >
                    <label for="smtp_host">{$lang.Hostname}</label> 
                    <label for="smtp_port">{$lang.Port|capitalize} 
                        <a class="vtip_description" title="Default ports:<br>&nbsp; 25 - SMTP<br>&nbsp; 465 - SMTP SSL<br>&nbsp; 587 - SMTP TLS"></a></label> 
                    <label for="smtp_login">{$lang.loginname}</label> 
                    <label for="smtp_pass">{$lang.Password}</label>
                    {*<label>{$lang.connection}</label>*}
                </div>
                <div class="inputs lighterblue">
                    <input type="text" id="smtp_host" value="{$submit.smtphost}" size="40" name="smtphost" class="inp"/>
                    <input type="text" id="smtp_port" value="{$submit.smtpport}" size="3" name="smtpport" class="inp"/>
                    <input type="text" id="smtp_login" value="{$submit.smtplogin}" size="40" name="smtplogin" class="inp"/> 
                    <input type="password" id="smtp_pass" value="{$submit.smtppassword}" size="20" name="smtppassword" autocomplete="off" class="inp"/>
                    {*<div>
                    <label><input type="radio" value="NO" {if $submit.smtpconn || !$submit.smtpconn}checked="checked"{/if} name="smtpconn" class="inp"/>{$lang.no}</label>
                    <label><input type="radio" value="SSL" {if $submit.smtpconn}checked="checked"{/if} name="smtpconn" class="inp"/>SSL</label>
                    <label><input type="radio" value="TLS" {if $submit.smtpconn}checked="checked"{/if} name="smtpconn" class="inp"/>TLS</label>
                    </div>*}
                </div>
                <div style="padding:10px 0">
                    <a class="new_control" href="#"   onclick="$(this).hide();
                $('#smtpmail_ad').show();
                return false;"><span class="wizard">{$lang.sendtestmail}</span></a>
                    <div id="smtpmail_ad" style="display:none">
                        Enter email address: <input type="text" name="testmail" id="testmailaddresssmtp" /> <a class="new_control" href="#"   onclick="testConfiguration('SMTP');
                return false;"><span ><b>{$lang.Send}</b></span></a>
                        <span  id="testing_result"></span>
                    </div>
                    <span  id="smtp_testing_result"></span>
                </div>
            </td>
        </tr>
    </tbody>

    <tbody class="sectioncontent" style="display:none">
        {if !$submit.sla_level_one && !$submit.sla_level_two && !$submit.sla_level_zero}
            <tr class="blank_sla">
                <td colspan="10">
                    <div class="blank_services">
                        <div class="blank_info">
                            <h1>{$lang.slaescalate}</h1>
                            {$lang.blanksla}
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="#"  onclick="$(this).parents('.blank_sla').hide().nextAll().show();
                return false;" style="margin-top:10px">
                                <span>{$lang.Enable}</span>
                            </a>
                            <div class="clear"></div>
                        </div>
                    </div>
                </td>
            </tr>
            {assign value=1 var=hidesla}
        {/if}
        <tr {if $hidesla}style="display:none"{/if}>
            <td width="190" align="right"><strong>{$lang.escalate_unresponded}:</strong></td>
            <td ><span style="width:190px;display:inline-block" >
                    <span><input type="checkbox" onclick="check_i(this)" {if $submit.sla_level_one}checked="checked"{/if} value="1">
                        <input type="text" value="{$submit.sla_level_one}" size="5" name="sla_level_one" class="inp config_val" {if !$submit.sla_level_one}disabled{/if} />
                    </span>
                    <select class="inp" name="sla_multi">
                        <option {if $submit.sla_multi == 1}selected="selected"{/if} value="1">{$lang.minutes|capitalize}</option>
                        <option {if $submit.sla_multi == 60}selected="selected"{/if} value="60">{$lang.hours|capitalize}</option>
                        <option {if $submit.sla_multi == 1440}selected="selected"{/if} value="1440">{$lang.days|capitalize}</option>
                    </select></span>


                And {$lang.applymacro}
                <select name="macro_sla1_id" class="inp">
                    <option value="0" > -- </option>
                    {foreach from=$macros item=macro}
                        <option {if $submit.macro_sla1_id == $macro.id}selected="selected"{/if} value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr {if $hidesla}style="display:none"{/if}>
            <td align="right"><strong>{$lang.escalate_unresolved}</strong></td>
            <td ><span style="width:190px;display:inline-block" >
                    <span>
                        <input type="checkbox" onclick="check_i(this)" {if $submit.sla_level_two}checked="checked"{/if} value="1" />
                        <input type="text" value="{$submit.sla_level_two}" size="5" name="sla_level_two" class="inp  config_val" {if !$submit.sla_level_two}disabled{/if} /></span>
                    <select class="inp" name="sla_multi2">
                        <option {if $submit.sla_multi2 == 1}selected="selected"{/if} value="1">{$lang.hours|capitalize}</option>
                        <option {if $submit.sla_multi2 == 24}selected="selected"{/if} value="24">{$lang.days|capitalize}</option>
                    </select></span>
                And {$lang.applymacro}
                <select name="macro_sla2_id" class="inp">
                    <option value="0" > -- </option>
                    {foreach from=$macros item=macro}
                        <option {if $submit.macro_sla2_id == $macro.id}selected="selected"{/if} value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
        <tr {if $hidesla}style="display:none"{/if}>
            <td align="right"><strong>Ask to close tickets that are in answered state</strong></td>
            <td ><span style="width:190px;display:inline-block" >
                    <span>
                        <input type="checkbox" onclick="check_i(this)" {if $submit.sla_level_zero}checked="checked"{/if} value="1" />
                        <input type="text" value="{$submit.sla_level_zero}" size="5" name="sla_level_zero" class="inp  config_val" {if !$submit.sla_level_zero}disabled{/if} /></span>
                    <select class="inp" name="sla_multi0">
                        <option {if $submit.sla_multi0 == 1}selected="selected"{/if} value="1">{$lang.hours|capitalize}</option>
                        <option {if $submit.sla_multi0 == 24}selected="selected"{/if} value="24">{$lang.days|capitalize}</option>
                    </select></span>
                And {$lang.applymacro}
                <select name="macro_sla0_id" class="inp">
                    <option value="0" > -- </option>
                    {foreach from=$macros item=macro}
                        <option {if $submit.macro_sla0_id == $macro.id}selected="selected"{/if} value="{$macro.id}">{$macro.catname} - {$macro.name}</option>
                    {/foreach}
                </select>
            </td>
        </tr>
    </tbody>

    <tbody class="sectioncontent" style="display:none">
        <tr class="bordme">
            <td align="right" width="160"><strong>{$lang.tdinca}</strong></td>
            <td >
                <input type="radio" name="visible" value="1" {if $submit.visible=='1' || !$submit}checked="checked"{/if}/> <strong>{$lang.Yes}</strong>, {$lang.yesshowinca}<br />
                <input type="radio" name="visible" value="0" {if $submit.visible=='0'}checked="checked"{/if}/>  {$lang.noshowinca}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.ticketnotifies}</strong></td>
            <td >
                <input type="radio" name="ticketnotifies" value="1" {if $submit.sendmail=='1' || !$submit}checked="checked"{/if}/> 
                <strong>{$lang.Yes}</strong>, Send notification to client and all staff members in this department 
                <a href="#" class="vtip_description" title="Notifications for assigned tickets will be sent only to related support staff, notifications for unassigned tickets will be sent to all staff members"></a> 
                <br />
                <input type="radio" name="ticketnotifies" value="2" {if $submit.sendmail=='1' && $submit.ownernotifyonly=='1'}checked="checked"{/if}/> 
                <strong>{$lang.Yes}</strong>, Send notification to client and only to staff member subscribed to related ticket 
                <a href="#" class="vtip_description" title="Emails to staff members won't be sent if ticket is not assigned"></a>
                <br />
                <input type="radio" name="ticketnotifies" value="0" {if $submit.sendmail=='0'}checked="checked"{/if}/> <strong>{$lang.No}</strong>,  {$lang.nosendnotifyaboutticket}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>Auto-subscribe</strong></td>
            <td >
                <input type="radio" name="autosubscribe"  value="1" {if $submit.autosubscribe=='1' && $submit.autosubscribeempty!='1'}checked="checked"{/if}/>
                <strong>{$lang.Yes}</strong>, Subscribe staff members after they respond to a ticket<br />
                <input type="radio" name="autosubscribe"  value="2" {if $submit.autosubscribe=='1' && $submit.autosubscribeempty=='1'}checked="checked"{/if}/>
                <strong>{$lang.Yes}</strong>, Subscribe after response but only if no one is already subscribed<br />
                <input type="radio" name="autosubscribe"  value="0" {if $submit.autosubscribe=='0' || !$submit.autosubscribe || !$submit }checked="checked"{/if}/>
                <strong>{$lang.No}</strong>, Do not subscribe after response
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.allowedsub}</strong></td>
            <td >
                <input type="radio" name="allowedsub"  value="0" {if $submit.clientsonly=='0' && $submit.staffonly=='0' || !$submit}checked="checked"{/if}/> {$lang.allowedsuball}<br />
                <input type="radio" name="allowedsub"  value="1" {if $submit.clientsonly=='1'}checked="checked"{/if}/> {$lang.deptonlyforregistered}<br />
                <input type="radio" name="allowedsub"  value="2" {if $submit.staffonly=='1'}checked="checked"{/if}/> Only staff members can open new trouble tickets in this department
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.ticketreopen}</strong></td>
            <td >
                <input type="radio" name="clientreopen"  value="1" {if $submit.clientreopen=='1' || !$submit}checked="checked"{/if}/>{$lang.ticketreopenyes}<br />
                <input type="radio" name="clientreopen"  value="0" {if $submit.clientreopen=='0' }checked="checked"{/if}/>{$lang.ticketreopenno}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.staffticketclose}</strong></td>
            <td >
                <input type="radio" name="clientclosestaff"  value="0" {if $submit.clientclosestaff=='0'|| !$submit}checked="checked"{/if}/>{$lang.staffticketcloseyes}<br />
                <input type="radio" name="clientclosestaff"  value="1" {if $submit.clientclosestaff=='1'}checked="checked"{/if}/>{$lang.staffticketcloseno}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.allowedadminsub}</strong></td>
            <td >
                <input type="radio" name="adminreply"  value="1" {if $submit.adminreply=='1' }checked="checked"{/if}/> <strong>{$lang.Yes}</strong>, {$lang.allowedadminsub1}<br />
                <input type="radio" name="adminreply"  value="0" {if $submit.adminreply=='0' || !$submit}checked="checked"{/if}/> <strong>{$lang.No}</strong>, {$lang.allowedadminsub2}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.clientsetpriority}</strong></td>
            <td >
                <input type="radio" name="clientsetpriority"  value="1" {if $submit.clientsetpriority=='1' }checked="checked"{/if}/> {$lang.yesclientsetpriority}<br />
                <input type="radio" name="clientsetpriority"  value="0" {if $submit.clientsetpriority=='0' || !$submit}checked="checked"{/if}/> {$lang.noclientsetpriority}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.ratesupport}</strong></td>
            <td >
                <input type="radio" name="supportrating"  value="1" {if $submit.supportrating=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>, {$lang.supportrating_yes}<br />
                <input type="radio" name="supportrating"  value="0" {if $submit.supportrating=='0' || !$submit}checked="checked"{/if}/><strong>{$lang.No}</strong>, {$lang.supportrating_no}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.avgresptime}</strong></td>
            <td >
                <input type="radio" name="avgresptime"  value="1" {if $submit.avgresptime=='1' }checked="checked"{/if}/><strong>{$lang.Yes}</strong>, {$lang.avgresptime_yes}<br />
                <input type="radio" name="avgresptime"  value="0" {if $submit.avgresptime=='0' || !$submit.avgresptime}checked="checked"{/if}/><strong>{$lang.No}</strong>, {$lang.avgresptime_no}
            </td>
        </tr>
        <tr class="bordme">
            <td align="right"><strong>{$lang.TicketAutoClose}</strong> </td>
            <td>
                <input type="checkbox" value="1" {if $submit.autoclose > 0}checked="checked"{/if} onclick="if (this.checked)
                    $(this).next('input').removeAttr('disabled');
                else
                    $(this).next('input').attr('disabled', true);"/> 
                {$lang.after} 
                <input type="text" size="3" class="config_val inp" {if $submit.autoclose <= 0}value="0" disabled="disabled"{else}value="{$submit.autoclose}"{/if} name="ticketautoclose" />  {$lang.hours}
            </td>
        </tr>
        <tr>
            <td align="right"><strong>{$lang.newticketemail}</strong> </td>
            <td>
                <select class="inp" name="newticketemail"/>
                <option value="0" {if $submit.id && !$submit.newticketemail} selected="selected"{/if}>None, do not send initial notification</option>
                {foreach from=$templates item=temp}
        <option {if (!$submit.id && !$submit.newticketemail && $temp.tplname == 'Ticket:New') || $submit.newticketemail == $temp.id}selected="selected"{/if} value="{$temp.id}">{$temp.tplname}</option>
    {/foreach}
    </select>
    </td>
    </tr>
    </tbody>
    <tbody>
        <tr>
            <td colspan="2" >
                {if $action=='edit'}
                    <input type="submit" value="{$lang.savechanges}" style="font-weight:bold" class="submitme"/> <span class="orspace">{$lang.Or} 
                        <a href="?cmd=ticketdepts" class="editbtn">{$lang.Cancel}</a></span>
                    <input type="hidden" name="make" value="edit"/>
                {else}	
                    <input type="submit" value="{$lang.adddepartment}" style="font-weight:bold" class="submitme"/> <span class="orspace">{$lang.Or} 
                        <a href="?cmd=ticketdepts" class="editbtn">{$lang.Cancel}</a></span>
                    <input type="hidden" name="make" value="add"/>
                {/if}
            </td>
        </tr>
    </tbody>
</table>
</div>
{securitytoken}
</form>
{elseif $action=='editadmins'}

    {if $dept && $admins}
        <div class="left">
            {foreach from=$admins item=adm}
            {if $dept.assigned_admins[$adm.id]}{$adm.username}<br />{/if}
        {/foreach}
    {if !$dept.assigned_admins} <b>No staff member assigned</b>{/if}
</div>
<div class="controls">&nbsp;&nbsp;&nbsp;<a href="#" class="editbtn" onclick="$(this).parents('div.admins_list').hide().next().show();
                return false;">{$lang.Edit}</a></div>
{/if}

{elseif $cmd=='ticketdepts' && $action=='default'}
    {if $depts}
        <div class="blu"><strong>{$lang.ticketdepts}</strong></div>
        <form id="serializeit" method="post">
            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                <tbody>
                    <tr>
                        <th width="20"></th>
                        <th width="28%">{$lang.departmentname}</th>
                        <th width="30%">{$lang.Description}</th>
                        <th width="30%">{$lang.email}</th>
                        <th width="10%">{$lang.hiddendept}</th>
                        <th width="20"></th>
                    </tr>
                </tbody>
            </table>
            <ul id="grab-sorter" style="width:100%">
                {foreach from=$depts item=dept name=cat}
                    <li  >
                        <div ><input type="hidden" name="sort[]" value="{$dept.id}" />
                            <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
                                <tr class="nobordera">
                                    <td valign="top"><a class="sorter-handle" >{$lang.move}</a></td>
                                    <td width="28%" valign="top"><a href="?cmd=ticketdepts&action=edit&id={$dept.id}"><strong>{$dept.name}</strong></a>	
                                    </td>
                                    <td width="30%" valign="top"><a href="?cmd=ticketdepts&action=edit&id={$dept.id}">{$dept.description}</a></td>
                                    <td width="30%" valign="top">{foreach from=$dept.importmails item=mail}{$mail.email}<br />{foreachelse}{$dept.email}{/foreach}</td>
                                    <td width="10%" valign="top">{if $dept.visible=='1'}{$lang.No}{else}{$lang.Yes}{/if}</td>
                                    <td  width="20" valign="top"><a href="?cmd=ticketdepts&make=delete&id={$dept.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.deletedeptconfirm}');">Delete</a></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td colspan="5" class="fs11">
                            {foreach from=$admins item=adm name=adminloop}{if $dept.assigned_admins[$adm.id]}{if !$smarty.foreach.adminloop.first}, {/if}{$adm.username}{/if}{/foreach}
                        {if !$dept.assigned_admins}<b>No staff member assigned</b>{/if}
                    </td>
                </tr>

            </table>
        </div>
    </li>
{/foreach}   
</ul>
<table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
    <tbody>
        <tr>
            <th  align="left">
                <a class="editbtn" href="?cmd=ticketdepts&action=add">{$lang.addnewdepartment}</a>
            </th>


        </tr>
    </tbody>
</table>

{securitytoken}</form>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
<script type="text/javascript">
    {literal}
        $("#grab-sorter").dragsort({dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>"});

        function saveOrder() {
            var sorts = $('#serializeit').serialize();
            ajax_update('?cmd=ticketdepts&action=listdepts&' + sorts, {});
        }
        ;

        function saveAdmOrder(id) {
            var order = $('#admin-order-' + id + ' input:checked').serialize();
            ajax_update('?cmd=ticketdepts&action=editadmins&' + order, {dept_id: id}, $('#admin-order-' + id).parents('div.admins_edit').hide().prev().show());

            return false;

        }

    {/literal} 
</script>	
{else}
    <div class="blank_state blank_news">
        <div class="blank_info">
            <h1>{$lang.tdbs_h}</h1>
            {$lang.tdbs_d}
            <div class="clear"></div>

            <a class="new_add new_menu" href="?cmd=ticketdepts&action=add" style="margin-top:10px">
                <span>{$lang.addnewdepartment}</span></a>
            <div class="clear"></div>

        </div>
    </div>

{/if}
{if $ajax}<script type="text/javascript">bindTicketEvents();</script>{/if}
{elseif $action == 'test_connection' || $action == 'test_phpmail' || $action == 'test_smtp'}
    {if $result}
        <span style="font-weight: bold; text-transform: capitalize; color: {if $result.result == 'Success'}#009900{else}#990000{/if}">
{if $lang[$result.result]}{$lang[$result.result]}{else}{$result.result}{/if}{if $result.error}: {$result.error}{/if}
</span>
{/if}
{elseif $action == 'test_pipe'}
    {if $result}
        Check test status here <a href="?cmd=tickets&action=view&num={$result}">[{$lang.tickethash}{$result}]</a>
    {else}
        {$lang.Error}: {$lang.senderror}
    {/if}
{/if} 
{if $action=='edit' || $action=='add'}
    <script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
    <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
    <script type="text/javascript">
        {literal}
            function testImportConfiguration(type, el){
                var parent = $(el).parents('tr').eq(0);
                if (type === undefined || type == 'POP') {
                    parent = parent.next();
                    $('.result', parent).html('<img src="ajax-loading.gif" />');
                    ajax_update('?cmd=ticketdepts&action=test_connection', {
                        'host': $('.pop-host', parent).val(),
                        'login': $('.pop-login', parent).val(),
                        'password': $('.pop-pass', parent).val(),
                        'port': $('.pop-port', parent).val()
                    }, $('.result', parent), false);
                } else if (type == 'PIPE') {
                    $.facebox({div: '#pipe_testing'});
                    var ctrl = $('<span id="pipebutton"></span>')
                    {/literal}{if $action=='edit'}
                    .append('<a class="new_control clear" href="#">{$lang.Continue}</a>').click(function(){literal}{testImportConfiguration('PIPE2', el)}{/literal})
                    .append(' {$lang.Or} ')
                     {/if}
                    .append('<a class="new_control clear" href="#" onclick="$.facebox.close();">{$lang.Close}</a>')
                    $('#facebox .footer').html(ctrl);
                    {literal}
                } else if (type == 'PIPE2') {
                    console.log(el)
                    $('#facebox #pipe_testing_result').html('<center><img style="height: 16px" src="ajax-loading.gif" /></center>');
                    $('#pipebutton').remove();
                    ajax_update('?cmd=ticketdepts&action=test_pipe', {id: '{/literal}{$submit.id}{literal}', email: $('.import-email', parent).val()}, '#facebox #pipe_testing_result');
                }
            }
            function testConfiguration(type) {
                if (type === undefined || type == 'PHP') {
                    $('#php_testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
                    ajax_update('?cmd=ticketdepts&action=test_phpmail', {'email': $('input[name="senderemail"]').val(), 'address': $('#testmailaddressphp').val()}, '#php_testing_result');
                } else if (type == 'SMTP') {
                    $('#smtp_testing_result').html('<img style="height: 16px" src="ajax-loading.gif" />');
                    ajax_update('?cmd=ticketdepts&action=test_smtp', {
                        'email': $('input[name="senderemail"]').val(),
                        'address': $('#testmailaddresssmtp').val(),
                        'host': $('input[name="smtphost"]').val(),
                        'login': $('input[name="smtplogin"]').val(),
                        'password': $('input[name="smtppassword"]').val(),
                        'port': $('input[name="smtpport"]').val()
                    }, '#smtp_testing_result');
                }
            }
            function check_i(element) {
                var td = $(element).parent();
                if ($(element).is(':checked'))
                    $(td).find('.config_val').removeAttr('disabled');
                else
                    $(td).find('.config_val').attr('disabled', 'disabled').val(0);
            }
            function removeImportMail(el){
                var pr = $(el).parents('tr').eq(0);
                if(pr.is('.import-mail-row'))
                    pr.next().remove();
                else{
                    pr.next().next().remove();
                    pr.next().remove();
                }
                pr.remove();
            }
            function editImportMail(el){
                var main = $(el).parents('tr').eq(0).hide().next().show();
                if(main.find('.import-method').val() == 'POP')
                    main.next().show();
            }
            function addNewImportMail(){
                var x = $('.import-mail-row').length ;
                $('.import-mail tr:last').before($('#mainImportEmail').next().addBack().clone().show().eq(1).hide().end().find('input, select').each(function(){
                    $(this).attr('name','importmail['+x+']['+$(this).attr('name').match(/\[([^\]\[]*)\]$/)[1]+']').val('');
                }).end());
            }
            $(".import-mail").on('change',"select.import-method", function() {
                if ($(this).val() == 'POP') {
                    $(this).parents('tr').eq(0).next().show();
                } else {
                    $(this).parents('tr').eq(0).next().hide();
                }
                if($(".import-mail option[value=PIPE]:selected").length)
                    $("#pipeIportLine").show();
                else
                    $("#pipeIportLine").hide();
            });
        {/literal}
    </script>
{/if} 