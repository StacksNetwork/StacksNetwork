{if $action=='addadministrator'}
    <form name="" action="" method="post">
        <input name="make" value="addadministrator" type="hidden"/>

        <div class="blu"> <a href="?cmd=editadmins"  ><strong>{$lang.Administrators}</strong></a> &raquo; <strong>{$lang.addadmin}</strong>

        </div>
        <div class="lighterblue2" >
            <table border=0 width="100%" cellpadding="6" cellspacing="0" style="padding:5px"> 
                <tr>
                    <td colspan="4" class="sectionhead_ext" >
                        {$lang.generalsettings}
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:20%"><strong>{$lang.firstname}</strong></td>
                    <td style="width:1px"><input name="firstname" value="{$submit.firstname}" class="inp"/></td>
                    <td align="right" style="width:1px; white-space: nowrap"><strong>{$lang.lastname}</strong></td>
                    <td><input name="lastname" value="{$submit.lastname}" class="inp"/></td>		

                </tr>
                <tr>
                    <td align="right"><strong>{$lang.Email}</strong></td>
                    <td><input name="email" value="{$submit.email}" class="inp"/></td>
                </tr>
                <tr>
                    <td align="right" ><strong>{$lang.Username}</strong></td>
                    <td><input name="username" value="{$submit.username}" class="inp"/></td> 
                </tr>
                <tr>
                    <td align="right"><strong>{$lang.Password}</strong></td>
                    <td><input name="password"  class="inp"/></td>
                    <td style="white-space: nowrap"><strong>{$lang.repeatpass}</strong></td>
                    <td><input name="password2"  class="inp"/></td>
                </tr>
                <tr>
                    <td align="right" ><strong>{$lang.Signature}</strong></td>
                    <td colspan="3">{if !$submit.signature}<a href="#" onclick="$(this).hide();
                            $('#signature').show();
                            return false;"><strong>{$lang.signatureadd}</strong></a>{/if}
                        <textarea name="signature" id="signature" style="height:80px; width:450px {if !$details.signature};display:none;{/if}">{$submit.signature}</textarea>
                    </td> 
                </tr>

                {if $fields}

                    {foreach from=$fields key=f item=fv}
                        <tr>
                            <td align="right"><strong>{$fv.name}</strong></td>
                            <td colspan="3">
                                {if $fv.type=='input'}
                                    <input name="{$f}"  value="{$submit[$f]}" class="inp"/>

                                {elseif $fv.type=='checkbox'}
                                    <input name="{$f}"  type="checkbox" value="1" {if $submit[$f]=='1'} checked="checked"{/if} />
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/if}
                <tr>
                    <td colspan="4" class="sectionhead_ext open">
                        {$lang.privileges}
                    </td>
                </tr>
                <tr id="privileges" > 
                    <td valign="top" class="sectionbody" colspan="4">
                        <div class="subhead"><strong>{$lang.premadepriv}</strong> 
                            &nbsp; &nbsp; &nbsp; <a href="#none">{$lang.none}</a> 
                            &nbsp; &nbsp; &nbsp; <a href="#accounting">{$lang.accounting}</a> 
                            &nbsp; &nbsp; &nbsp; <a href="#staff">{$lang.Administrators}</a> 
                            &nbsp; &nbsp; &nbsp; <a href="#full">{$lang.full_acces}</a>
                        </div>
                        {foreach from=$staff_privs item=privs key=group}
                            <fieldset>
                                <legend><label><input type="checkbox" />{$lang.$group}</label></legend>
                                        {foreach from=$privs item=privopt key=priv name=loop}
                                    <label><input type="checkbox" name="access[]" value="{$privopt}" class="checker" {if $submit.access && $privopt|in_array:$submit.access}checked="checked"{/if}/> {if $lang.$privopt}{$lang.$privopt}{else}{$privopt}{/if}</label>
                                    {/foreach}
                            </fieldset>
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td colspan="4"></td>
                </tr>
                <tr>
                    <td colspan="4"  class="sectionhead_ext open">
                        {$lang.emailnotification}
                    </td>
                </tr>
                <tr id="emnotify" >
                    <td valign="top" class="sectionbody" colspan="4">
                        <div class="subhead"><strong>{$lang.premadesett}</strong> 
                            &nbsp; &nbsp; &nbsp; <a href="#none">{$lang.none}</a> 
                            &nbsp; &nbsp; &nbsp; <a href="#full">{$lang.full_email}</a>
                        </div>
                        <fieldset>
                            <legend><label><input type="checkbox" />{$lang.Accounts}</label></legend>
                            <label><input class="checker1" type="checkbox" name="emails[]" value="createAccount" {if $submit.emails && 'createAccount'|in_array:$submit.emails }checked="checked"{/if}/> {$lang.hbcreateaccount} </label>
                            <label><input class="checker1"  type="checkbox" name="emails[]" value="terminateAccount" {if $submit.emails && 'terminateAccount'|in_array:$submit.emails }checked="checked"{/if} /> {$lang.hbterminateaccount} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="suspendAccount" {if $submit.emails && 'suspendAccount'|in_array:$submit.emails }checked="checked"{/if} /> {$lang.hbsuspendaccount} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="unsuspendAccount" {if $submit.emails && 'unsuspendAccount'|in_array:$submit.emails }checked="checked"{/if} /> {$lang.hbunsuspendaccount} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="accountPasswordReset" {if $submit.emails && 'accountPasswordReset'|in_array:$submit.emails}checked="checked1"{/if} /> {$lang.hbaccpassreset} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="newOrder" {if $submit.emails && 'newOrder'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbneworder} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="cancelOrder" {if $submit.emails && 'cancelOrder'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbordercancel} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="editOrderOwnership" {if $submit.emails && 'editOrderOwnership'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbownershipchange} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="editOrderOwnershipToMe" {if $submit.emails && 'editOrderOwnershipToMe'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbownershipchangetome} </label>
                        </fieldset>
                        <fieldset>
                            <legend><label><input type="checkbox" />{$lang.miscellaneous}</label></legend>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="autoSetup" {if $submit.emails && 'autoSetup'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbautosetup} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="cronResults" {if $submit.emails && 'cronResults'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbcronresults} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="failedLogin" {if $submit.emails && 'failedLogin'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbfailedlogin} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="clientDetailsChanged" {if $submit.emails && 'clientDetailsChanged'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbclientdetailschanged} </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="notesUpdated" {if $submit.emails && 'notesUpdated'|in_array:$submit.emails}checked="checked"{/if} /> Hostbill Admin Notes Changed </label>

                        </fieldset>

                        <fieldset>
                            <legend><label><input type="checkbox" /><a href="?cmd=notifications" target="_blank">{$lang.Notifications}</a></label></legend>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileNewPayment" {if $submit.emails && 'mobileNewPayment'|in_array:$submit.emails}checked="checked"{/if} /> New transaction </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileNewOrder" {if $submit.emails && 'mobileNewOrder'|in_array:$submit.emails}checked="checked"{/if} /> New Order </label>
                            <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileFailedAutomation" {if $submit.emails && 'mobileFailedAutomation'|in_array:$submit.emails}checked="checked"{/if} /> Failed auto provisioning </label>

                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" align="center">
                        <input type="submit" style="font-weight:bold" value="{$lang.addadmin}" class="submitme"/> <span class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
                    </td>
                </tr>

            </table>

        </div>

        {securitytoken}
    </form>

{elseif ($action=='administrator' || $action=='myaccount') AND $details}

    <form name="" action="" method="post">
        <input name="make" value="editadministrator" type="hidden"/>

        <div class="blu"> <a href="?cmd=editadmins"  ><strong>{$lang.Administrators}</strong></a> &raquo; <strong>{$details.firstname} {$details.lastname} - {$details.username}</strong>


        </div>
        <div class="lighterblue2" >
            <table border=0 width="100%" cellpadding="6" cellspacing="0" style="padding:5px"> 
                <tr>
                    <td colspan="4" class="sectionhead_ext" >
                        {$lang.generalsettings}
                    </td>
                </tr>
                <tr>
                    <td align="right" style="width:20%"><strong>{$lang.firstname}</strong></td>
                    <td style="width:1px"><input name="firstname" value="{$details.firstname}" class="inp"/></td>
                    <td align="right" style="width:1px; white-space: nowrap"><strong>{$lang.lastname}</strong></td>
                    <td><input name="lastname" value="{$details.lastname}" class="inp"/></td>		

                </tr>
                <tr>
                    <td align="right"><strong>{$lang.Email}</strong></td>
                    <td><input name="email" value="{$details.email}" class="inp"/></td>
                </tr>
                <tr>
                    <td align="right" ><strong>{$lang.Username}</strong></td>
                    <td><input name="username" value="{$details.username}" class="inp"/></td> 
                </tr>
                <tr>
                    <td align="right"><strong>{$lang.Password}</strong></td>
                    <td><input name="password"  class="inp"/></td>
                    <td style="white-space: nowrap"><strong>{$lang.repeatpass}</strong></td>
                    <td><input name="password2"  class="inp"/></td>
                </tr>
                <tr>
                    <td align="right" ><strong>{$lang.Signature}</strong></td>
                    <td colspan="3">{if !$details.signature}<a href="#" onclick="$(this).hide();
                $('#signature').show();
                return false;"><strong>{$lang.signatureadd}</strong></a>{/if}
                        <textarea name="signature" id="signature" style="height:80px; width:450px {if !$details.signature};display:none;{/if}">{$details.signature}</textarea></td> 
                </tr>

                {if $details.fields}

                    {foreach from=$details.fields key=f item=fv}
                        <tr>
                            <td align="right"><strong>{$fv.name}</strong></td>
                            <td colspan="3">
                                {if $fv.type=='input'}
                                    <input name="{$f}"  value="{$details[$f]}" class="inp"/>

                                {elseif $fv.type=='checkbox'}
                                    <input name="{$f}"  type="checkbox" value="1" {if $details[$f]=='1'} checked="checked "{/if} />
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/if}
                {if $action!='myaccount'}
                    <tr>
                        <td align="right" ><strong>{$lang.Status}</strong></td>
                        <td>
                            <label><input name="status" value="Active" type="radio" {if $details.status == 'Active'}checked="checked"{/if} class="inp"/>{$lang.Active}</label>
                            <label><input name="status" value="Inactive" type="radio" {if $details.status == 'Inactive'}checked="checked"{/if} class="inp"/>{$lang.Inactive}</label>
                        </td> 
                    </tr>
                    <tr>
                        <td colspan="4" class="sectionhead_ext open">
                            {$lang.privileges} 
                        </td>
                    </tr>
                    <tr id="privileges"> 
                        <td valign="top" class="sectionbody" colspan="4">
                            <div class="subhead"><strong>{$lang.premadepriv}</strong> 
                                &nbsp; &nbsp; &nbsp; <a href="#none">{$lang.none}</a> 
                                &nbsp; &nbsp; &nbsp; <a href="#accounting">{$lang.accounting}</a> 
                                &nbsp; &nbsp; &nbsp; <a href="#staff">{$lang.Administrators}</a> 
                                &nbsp; &nbsp; &nbsp; <a href="#full">{$lang.full_acces}</a>
                            </div>
                            {foreach from=$staff_privs item=privs key=group}
                                <fieldset>
                                    <legend><label><input type="checkbox" />{$lang.$group}</label></legend>
                                            {foreach from=$privs item=privopt key=priv name=loop}
                                        <label><input type="checkbox" name="access[]" value="{$privopt}" class="checker" {if $details.access && $privopt|in_array:$details.access}checked="checked"{/if}/> {if $lang.$privopt}{$lang.$privopt}{else}{$privopt}{/if}</label>
                                        {/foreach}
                                </fieldset>
                            {/foreach}
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td colspan="4"  class="sectionhead_ext open">
                            {$lang.emailnotification} 
                        </td>
                    </tr>
                    <tr id="emnotify" >
                        <td valign="top" class="sectionbody" colspan="4">
                            <div class="subhead"><strong>{$lang.premadesett}</strong> 
                                &nbsp; &nbsp; &nbsp; <a href="#none">{$lang.none}</a> 
                                &nbsp; &nbsp; &nbsp; <a href="#full">{$lang.full_email}</a>
                            </div>
                            <fieldset>
                                <legend><label><input type="checkbox" />{$lang.Accounts}</label></legend>
                                <label><input class="checker1" type="checkbox" name="emails[]" value="createAccount" {if $details.emails && 'createAccount'|in_array:$details.emails }checked="checked"{/if}/> {$lang.hbcreateaccount} </label>
                                <label><input class="checker1"  type="checkbox" name="emails[]" value="terminateAccount" {if $details.emails && 'terminateAccount'|in_array:$details.emails }checked="checked"{/if} /> {$lang.hbterminateaccount} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="suspendAccount" {if $details.emails && 'suspendAccount'|in_array:$details.emails }checked="checked"{/if} /> {$lang.hbsuspendaccount} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="unsuspendAccount" {if $details.emails && 'unsuspendAccount'|in_array:$details.emails }checked="checked"{/if} /> {$lang.hbunsuspendaccount} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="accountPasswordReset" {if $details.emails && 'accountPasswordReset'|in_array:$details.emails}checked="checked1"{/if} /> {$lang.hbaccpassreset} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="newOrder" {if $details.emails && 'newOrder'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbneworder} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="cancelOrder" {if $details.emails && 'cancelOrder'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbordercancel} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="editOrderOwnership" {if $details.emails && 'editOrderOwnership'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbownershipchange} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="editOrderOwnershipToMe" {if $details.emails && 'editOrderOwnershipToMe'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbownershipchangetome} </label>
                            </fieldset>
                            <fieldset>
                                <legend><label><input type="checkbox" />{$lang.miscellaneous}</label></legend>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="autoSetup" {if $details.emails && 'autoSetup'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbautosetup} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="cronResults" {if $details.emails && 'cronResults'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbcronresults} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="failedLogin" {if $details.emails && 'failedLogin'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbfailedlogin} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="clientDetailsChanged" {if $details.emails && 'clientDetailsChanged'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbclientdetailschanged} </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="notesUpdated" {if $details.emails && 'notesUpdated'|in_array:$details.emails}checked="checked"{/if} /> Hostbill Admin Notes Changed </label>

                            </fieldset>
                            <fieldset>
                                <legend><label><input type="checkbox" /><a href="?cmd=notifications" target="_blank">{$lang.Notifications}</a></label></legend>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileNewPayment" {if $details.emails && 'mobileNewPayment'|in_array:$details.emails}checked="checked"{/if} /> New transaction </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileNewOrder" {if $details.emails && 'mobileNewOrder'|in_array:$details.emails}checked="checked"{/if} /> New Order </label>
                                <label><input  class="checker1" type="checkbox" name="emails[]" value="mobileFailedAutomation" {if $details.emails && 'mobileFailedAutomation'|in_array:$details.emails}checked="checked"{/if} /> Failed auto provisioning </label>

                            </fieldset>
                        </td>
                    </tr>
                {/if}
                <tr>
                    <td colspan="4" align="center">
                        <input type="submit" style="font-weight:bold" value="{$lang.savechanges}" class="submitme"/> <span class="orspace">{$lang.Or} <a href="?cmd=editadmins" class="editbtn">{$lang.Cancel}</a></span>
                    </td>
                </tr>
            </table>
        </div>

        {securitytoken}</form>

{elseif $action=='addgroup'}

    <form name="" action="" method="post">
        <input name="make" value="addgroup" type="hidden"/>

        <div class="blu"> <a href="?cmd=editadmins&action=groups"  class="tload2"><strong>&laquo; {$lang.backtogroups}</strong></a>


        </div>
        <div class="lighterblue" style="padding:5px">
            <table  width="100%" cellpadding="6" cellspacing="0" border="0">
                <tr>    <td width="160">{$lang.groupname}:</td><td colspan="2"><input name="name" value="{$submit.name}" class="inp" style="font-weight:bold"/></td>    </tr>

                <tr><td class="blu" style="padding:3px" valign="top"><strong>{$lang.emailnotification}:</strong></td>
                    <td class="blu" style="padding:3px" valign="top">

                        <input class="checker" type="checkbox" name="emails[]" value="createAccount" {if $submit.emails && 'createAccount'|in_array:$submit.emails}checked="checked"{/if}/> {$lang.hbcreateaccount} <br />
                        <input class="checker"  type="checkbox" name="emails[]" value="terminateAccount" {if $submit.emails && 'terminateAccount'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbterminateaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="suspendAccount" {if $submit.emails && 'suspendAccount'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbsuspendaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="unsuspendAccount" {if $submit.emails && 'unsuspendAccount'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbunsuspendaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="accountPasswordReset" {if $submit.emails && 'accountPasswordReset'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbaccpassreset} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="newOrder" {if $submit.emails && 'newOrder'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbneworder} 
                    </td>		
                    <td valign="top" class="blu" style="padding:3px">			
                        <input  class="checker" type="checkbox" name="emails[]" value="cancelOrder" {if $submit.emails && 'cancelOrder'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbordercancel} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="autoSetup" {if $submit.emails && 'autoSetup'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbautosetup} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="cronResults" {if $submit.emails && 'cronResults'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbcronresults} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="failedLogin" {if $submit.emails && 'failedLogin'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbfailedlogin} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="clientDetailsChanged" {if $submit.emails && 'clientDetailsChanged'|in_array:$submit.emails}checked="checked"{/if} /> {$lang.hbclientdetailschanged}<br />
                        <input  class="checker1" type="checkbox" name="emails[]" value="notesUpdated" {if $submit.emails && 'notesUpdated'|in_array:$submit.emails}checked="checked"{/if} /> Hostbill Admin Notes Changed

                        <script type="text/javascript">
                            {literal}
                    function checkit(ele) {
                        if ($(ele).is(':checked')) {
                            $('.checker').attr('checked', 'checked');
                        } else {
                            $('.checker').removeAttr('checked');
                        }
                    }
                            {/literal}
                        </script>		

                    </td></tr>

                <tr><td  valign="top"><strong>{$lang.thisgroupcan}</strong></td><td valign="top">
                        <input type="checkbox" name="access[]" value="editConfiguration" class="checker"/> <strong>{$lang.editConfiguration}</strong><br />
                        <input type="checkbox" name="access[]" value="listClients"  class="checker"/> {$lang.listClients}<br />

                        <input type="checkbox" name="access[]" value="registerClient"  class="checker"/> {$lang.registerClient}<br />	
                        <input type="checkbox" name="access[]" value="manageAffiliates" class="checker"/> {$lang.manageAffiliates}<br />			
                        <input type="checkbox" name="access[]" value="emailClient" class="checker"/> {$lang.emailClient}<br />
                        <input type="checkbox" name="access[]" value="viewTickets" class="checker"/> {$lang.viewTickets}<br />
                        <input type="checkbox" name="access[]" value="editNews" class="checker"/> {$lang.editNews}<br />
                        <input type="checkbox" name="access[]" value="editKBase" class="checker"/> {$lang.editKBase}<br />
                        <input type="checkbox" name="access[]" value="viewInvoices" class="checker"/> {$lang.viewInvoices}
                    </td>
                    <td  valign="top">
                        <input type="checkbox" name="access[]" value="viewEstimates" class="checker"/> {$lang.viewEstimates}<br />
                        <input type="checkbox" name="access[]" value="viewTransactions" class="checker"/> {$lang.viewTransactions}<br />
                        <input type="checkbox" name="access[]" value="viewLogs" class="checker"/> {$lang.viewLogs}<br />
                        <input type="checkbox" name="access[]" value="viewOrders" class="checker"/> {$lang.viewOrders}<br />
                        <input type="checkbox" name="access[]" value="viewAccounts" class="checker"/> {$lang.viewAccounts}<br />
                        <input type="checkbox" name="access[]" value="viewDomains" class="checker"/> {$lang.viewDomains}<br />
                        <input type="checkbox" name="access[]" value="accessChat" class="checker"/> {$lang.accessChat}<br />
                        <input type="checkbox" name="access[]" value="editDownloads" class="checker"/> {$lang.editDownloads}<br />
                        <input type="checkbox" name="access[]" value="viewStats" class="checker"/> {$lang.viewStats}	</td>
                </tr>
                <tr><td></td><td><input type="checkbox"  value="1" onclick="checkit(this)" /> <strong>{$lang.checkallmini}</strong></td><td></td></tr>


            </table>
        </div>
        <div class="blu"> <a href="?cmd=editadmins&action=groups"  class="tload2"><strong>&laquo; {$lang.backtogroups}</strong></a>
            <input type="submit" style="font-weight:bold" value="{$lang.addgroup}" />
            <input type="button" onclick="window.location = '?cmd=editadmins&action=groups'" style="" value="{$lang.Cancel}"/>

        </div>
        {securitytoken}</form>

{elseif $action=='group' AND $details}

    <form name="" action="" method="post">
        <input name="make" value="editgroup" type="hidden"/>

        <div class="blu"> <a href="?cmd=editadmins&action=groups"  class="tload2"><strong>&laquo; {$lang.backtogroups}</strong></a>


        </div>
        <div class="lighterblue" style="padding:5px">
            <table  width="100%" cellpadding="6" cellspacing="0" border="0">
                <tr>    <td width="160">{$lang.groupname}:</td><td colspan="2"><input name="name" value="{$details.name}"  class="inp" style="font-weight:bold"/></td>    </tr>

                <tr><td class="blu" style="padding:3px" valign="top"><strong>{$lang.emailnotification}:</strong></td>
                    <td class="blu" style="padding:3px" valign="top">

                        <input class="checker" type="checkbox" name="emails[]" value="createAccount" {if $details.emails && 'createAccount'|in_array:$details.emails}checked="checked"{/if}/> {$lang.hbcreateaccount} <br />
                        <input class="checker"  type="checkbox" name="emails[]" value="terminateAccount" {if $details.emails && 'terminateAccount'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbterminateaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="suspendAccount" {if $details.emails && 'suspendAccount'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbsuspendaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="unsuspendAccount" {if $details.emails && 'unsuspendAccount'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbunsuspendaccount} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="accountPasswordReset" {if $details.emails && 'accountPasswordReset'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbaccpassreset} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="newOrder" {if $details.emails && 'newOrder'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbneworder}	</td>		
                    <td valign="top" class="blu" style="padding:3px">	
                        <input  class="checker" type="checkbox" name="emails[]" value="cancelOrder" {if $details.emails && 'cancelOrder'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbordercancel} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="autoSetup" {if $details.emails && 'autoSetup'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbautosetup} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="cronResults" {if $details.emails && 'cronResults'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbcronresults} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="failedLogin" {if $details.emails && 'failedLogin'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbfailedlogin} <br />
                        <input  class="checker" type="checkbox" name="emails[]" value="clientDetailsChanged" {if $details.emails && 'clientDetailsChanged'|in_array:$details.emails}checked="checked"{/if} /> {$lang.hbclientdetailschanged}<br />
                        <input  class="checker1" type="checkbox" name="emails[]" value="notesUpdated" {if $details.emails && 'notesUpdated'|in_array:$details.emails}checked="checked"{/if} /> Hostbill Admin Notes Changed

                        <script type="text/javascript">
                            {literal}
                    function checkit(ele) {
                        if ($(ele).is(':checked')) {
                            $('.checker').attr('checked', 'checked');
                        } else {
                            $('.checker').removeAttr('checked');
                        }
                    }
                            {/literal}
                        </script>		

                    </td></tr>

                <tr><td  valign="top"><strong>{$lang.thisgroupcan}</strong></td><td valign="top">
                        <input type="checkbox" name="access[]" value="editConfiguration" class="checker" {if $details.access && 'editConfiguration'|in_array:$details.access}checked="checked"{/if}/> <strong>{$lang.editConfiguration}</strong><br />
                        <input type="checkbox" name="access[]" value="listClients"  class="checker" {if $details.access && 'listClients'|in_array:$details.access}checked="checked"{/if}/> {$lang.listClients}<br />

                        <input type="checkbox" name="access[]" value="registerClient"  class="checker" {if $details.access && 'registerClient'|in_array:$details.access}checked="checked"{/if}/> {$lang.registerClient}<br />	
                        <input type="checkbox" name="access[]" value="manageAffiliates" class="checker" {if $details.access && 'manageAffiliates'|in_array:$details.access}checked="checked"{/if}/> {$lang.manageAffiliates}<br />			
                        <input type="checkbox" name="access[]" value="emailClient" class="checker" {if $details.access && 'emailClient'|in_array:$details.access}checked="checked"{/if}/> {$lang.emailClient}<br />
                        <input type="checkbox" name="access[]" value="viewTickets" class="checker" {if $details.access && 'viewTickets'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewTickets}<br />
                        <input type="checkbox" name="access[]" value="editNews" class="checker" {if $details.access && 'editNews'|in_array:$details.access}checked="checked"{/if}/> {$lang.editNews}<br />
                        <input type="checkbox" name="access[]" value="editKBase" class="checker" {if $details.access && 'editKBase'|in_array:$details.access}checked="checked"{/if}/> {$lang.editKBase}<br />
                        <input type="checkbox" name="access[]" value="viewInvoices" class="checker" {if $details.access && 'viewInvoices'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewInvoices}
                    </td>
                    <td  valign="top">
                        <input type="checkbox" name="access[]" value="viewEstimates" class="checker" {if $details.access && 'viewEstimates'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewEstimates}<br />
                        <input type="checkbox" name="access[]" value="viewTransactions" class="checker" {if $details.access && 'viewTransactions'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewTransactions}<br />
                        <input type="checkbox" name="access[]" value="viewLogs" class="checker" {if $details.access && 'viewLogs'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewLogs}<br />
                        <input type="checkbox" name="access[]" value="viewOrders" class="checker" {if $details.access && 'viewOrders'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewOrders}<br />
                        <input type="checkbox" name="access[]" value="viewAccounts" class="checker" {if $details.access && 'viewAccounts'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewAccounts}<br />
                        <input type="checkbox" name="access[]" value="viewDomains" class="checker" {if $details.access && 'viewDomains'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewDomains}<br />
                        <input type="checkbox" name="access[]" value="accessChat" class="checker" {if $details.access && 'accessChat'|in_array:$details.access}checked="checked"{/if}/> {$lang.accessChat}<br />
                        <input type="checkbox" name="access[]" value="editDownloads" class="checker" {if $details.access && 'editDownloads'|in_array:$details.access}checked="checked"{/if}/> {$lang.editDownloads}<br />
                        <input type="checkbox" name="access[]" value="viewStats" class="checker" {if $details.access && 'viewStats'|in_array:$details.access}checked="checked"{/if}/> {$lang.viewStats}	</td>
                </tr>
                <tr><td></td><td><input type="checkbox"  value="1" onclick="checkit(this)"/> <strong>{$lang.checkallmini}</strong></td><td></td></tr>

            </table>
        </div>
        <div class="blu"> <a href="?cmd=editadmins&action=groups"  class="tload2"><strong>&laquo; {$lang.backtogroups}</strong></a>
            <input type="submit" style="font-weight:bold" value="{$lang.savechanges}" />
            <input type="button" onclick="window.location = '?cmd=editadmins&action=groups'" style="" value="{$lang.Cancel}"/>

        </div>
        {securitytoken}</form>
    {elseif $action=='groups' AND $groups}



    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
        <tr>
            <th>Id</th>
            <th>{$lang.Name}</th>
            <th width="20">&nbsp;</th>
        </tr>
        {foreach from=$groups item=gr key=i}
            <tr>
                <td>{$gr.id}</td>
                <td><a href="?cmd=editadmins&action=group&id={$gr.id}">{$gr.name}</a></td>
                <td><a href="?cmd=editadmins&action=groups&make=deletegroup&id={$gr.id}&security_token={$security_token}" onclick="return confirm('{$lang.deletegroupconfirm}');" class="delbtn">Delete</a></td>
            </tr>


        {/foreach}
    </table>

{elseif $action=='default'}
    <div class="blu">
        <strong>{$lang.Administrators}</strong>
    </div>

    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">
        <tr>

            <th width="30%">{$lang.Name}</th>
            <th width="20%">{$lang.Username}</th>
            <th width="30%">{$lang.Email}</th>
            <th>{$lang.Status}</th>
            <th width="20">&nbsp;</th>
        </tr>
        {foreach from=$admins item=ad}

            <tr class="product">
                <td><a href="?cmd=editadmins&action=administrator&id={$ad.id}">{$ad.firstname} {$ad.lastname}</a></td>
                <td>{$ad.username}</td>
                <td><a href="mailto:{$ad.email}">{$ad.email}</a></td>
                <td>{$lang[$ad.status]}</td>
                <td><a href="?cmd=editadmins&make=deleteadmin&id={$ad.id}&security_token={$security_token}" onclick="return confirm('{$lang.deleteadminconfirm}');" class="delbtn">Delete</a></td>
            </tr>

        {/foreach}
        <tr>

            <th colspan="5" align="left"><a href="?cmd=editadmins&action=addadministrator"  class="editbtn"><strong>{$lang.addadmin}</strong></a></th>
        </tr>
    </table>



{/if}
{if $action=='addadministrator' || $action=='administrator'}
    <script src="{$template_dir}/js/editadmins.js?v={$hb_version}" type="text/javascript"></script>
{/if}