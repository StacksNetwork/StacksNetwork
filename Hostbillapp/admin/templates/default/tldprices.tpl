<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
       <tr>
        <td colspan="2"><h3>{$lang.domainpricing}</h3></td>

    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=configuration"  class="tstyled">{$lang.generalsettings}</a>
            <a href="?cmd=configuration&action=cron"  class="tstyled">{$lang.cronprofiles}</a>
            <!--<a href="?cmd=configuration&action=currency"  class="tstyled">{$lang.currencysettings}</a>-->
            <a href="?cmd=tldprices"  class="tstyled selected">{$lang.domainpricingandsett}</a>
            <a href="?cmd=security"  class="tstyled">{$lang.securitysettings}</a>
			<a href="?cmd=langedit"  class="tstyled">{$lang.languages}</a> 
        </td>
        <td valign="top"  class="bordered"><div id="bodycont" style="">
	{if $action=='edit' && $tld}

                <div class="blu"><strong>{$lang.edtld} {$tld.tld}</strong></div>
                <div class="nicerblu"><center>
                        <form action=""	method="post">
                            <input type="hidden" name="make" value="edit" />
                            <input type="hidden" name="oldtld" value="{$tld.tld}" />
                            <table border="0" cellpadding="6" cellspacing="0" width="70%">
                                <tbody>
                                    <tr>
                                        <td width="160" align="right"><strong style="font-size:16px !important;">{$lang.dom_ext}</strong></td>
                                        <td align="left"><input class="inp"  name="tld" style="font-size:16px !important;font-weight:bold;width:97%" value="{$tld.tld}"/>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td colspan="2" align="left">
                                            <div class="left" style="padding:5px;margin-right:5px;width:46%;border-right:solid 1px #c0c0c0">
                                                <input type="radio" name="automate" value="1" checked="checked" onclick="$('#dommodules').show();loadMod(this);" {if $tld.module!="0" && $tld.module!=$email_module}checked="checked"{/if}/>	<strong style="font-size:16px !important;">{$lang.dom_aut}</strong><br />
								{$lang.dom_aut_exp}

                                            </div>
                                            <div  class="left" style="width:46%;padding:5px;margin-left:5px;;">
                                                <input type="radio" name="automate" value="0" onclick="$('#dommodules').hide();loadMod(this);"  {if $tld.module=="0" || $tld.module==$email_module}checked="checked"{/if}/>	<strong style="font-size:16px !important;">{$lang.Manual}</strong><br />
								{$lang.dom_man_exp}
                                            </div>
                                            <div class="clear"></div>
                                        </td>
                                    </tr>

                                    <tr id="dommodules"  {if $tld.module=="0" || $tld.module==$email_module}style="display:none"{/if}>
                                        <td colspan="2" align="left">
                                            <div class="left" style="margin:20px 10px 0px 0px;font-weight:bold">{$lang.registrarname}: </div>
						{foreach from=$modules item=mod}{if $mod.id==$tld.module  && $mod.filename!='class.email.php'}
                                            <div class="featured_module left">
                                                <div class="mod_img" style="width:113px;height:34px;font-size:16px;">	
								{$mod.module}
                                                </div>							
                                                <div class="mod_sel moremodules" style="display:none"><input type="radio" name="module" value="{$mod.id}" checked="checked" onclick="loadMod(this);"/></div></div>{/if} {/foreach}
						{foreach from=$modules item=mod}{if $mod.featured && $mod.id!=$tld.module}						
                                            <div class="featured_module  {if $tld.module!="0" && $tld.module!=$email_module}moremodules{/if} left" {if $tld.module!="0" && $tld.module!=$email_module}style="display:none"{/if}>
                                                 <div class="mod_img">
                                                                      <label for="modpick-{$mod.classname}">{$mod.module}</label>
                                                                  </div>							
                                                                  <div class="mod_sel"><input type="radio" name="module" {if $tld.module!="0" && $tld.module==$mod.id}checked="checked"{/if} id="modpick-{$mod.classname}" value="{if $mod.id==-1}{$mod.filename}{else}{$mod.id}{/if}"  onclick="loadMod(this);"/></div>
                                                              </div>
						{/if} {/foreach}



                                                              <div class="left" style="padding:15px;">

                                                                  <a href="#" class="new_control" onclick="$(this).parent().hide();$('.moremodules').show();return false;" ><span class="addsth" >{$lang.newregistrar}</span></a>


                                                              </div>
                                                              <div class="clear"></div>						
                                                              <div class="moremodules" style="display:none">
							{foreach from=$modules item=mod}{if !$mod.featured && $mod.id!=$tld.module && $mod.id!='-1'  && $mod.filename!='class.email.php'}
                                                                      <div class="regular_module left">							
                                                                          <input type="radio" name="module" value="{$mod.id}" onclick="loadMod(this);" id="modpick-{$mod.classname}" /> <label for="modpick-{$mod.classname}">{$mod.module}</label>
                                                                  </div>{/if} {/foreach} 
                                                                  <div style="padding-top:10px;float:left;"><a href="#" onclick="$(this).parent().hide();$('.moremodules .inactivemod').show();return false;" >{$lang.show_inactive_mods}</a></div>

							{foreach from=$modules item=mod}{if !$mod.featured  && $mod.id=='-1'  && $mod.filename!='class.email.php'}
                                                              <div class="regular_module left inactivemod" style="display:none">							
                                                                  <input type="radio" name="module" value="{$mod.filename}" onclick="loadMod(this);" id="modpick-{$mod.classname}"/> <label for="modpick-{$mod.classname}">{$mod.module}</label>
                                                              </div>{/if} {/foreach} 

                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="modconfig" style="display:none">
                                        <td colspan="2">							
                                        </td>
                                    </tr>
                                </tbody>
                                <tbody  >
                                    <tr><td colspan="2">
                                            <div class="sectionhead">{$lang.messoptions}</div>			 
                                        </td></tr></tbody>
                                <tbody  id='aut-settings' > 
                                    <tr>
                                        <td><strong>{$lang.domregmail}</strong></td>
                                        <td  id="welcome_msg"><select class="inp" name="email_registered">
                                                <option value="0" {if $tld.email_registered=='0'}selected="selected"{/if}>{$lang.none}</option> 
				{foreach from=$messages item=msg}
                                                <option value="{$msg.id}" {if $tld.email_registered==$msg.id}selected="selected"{/if}>{$msg.tplname}</option>
				{/foreach}
                                            </select>
                                            <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=welcome' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><strong>{$lang.domtransmail}</strong></td>
                                        <td id="suspend_msg"><select class="inp" name="email_transfered">
                                                <option value="0" {if $tld.email_transfered=='0'}selected="selected"{/if}>{$lang.none}</option> 
				{foreach from=$messages item=msg}
                                                <option value="{$msg.id}" {if $tld.email_transfered==$msg.id}selected="selected"{/if}>{$msg.tplname}</option>

				{/foreach}</select>
                                            <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=suspend' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><strong>{$lang.domrenewed}</strong></td>
                                        <td id="unsuspend_msg"><select class="inp" name="email_renewed">
                                                <option value="0" {if $tld.email_renewed=='0'}selected="selected"{/if}>{$lang.none}</option> 
				{foreach from=$messages item=msg}
                                                <option value="{$msg.id}" {if $tld.email_renewed==$msg.id}selected="selected"{/if}>{$msg.tplname}</option>
				{/foreach}</select>
                                            <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=unsuspend' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td><strong>{$lang.domrenewal}</strong></td>
                                        <td id="terminate_msg"><select class="inp" name="email_reminder">
                                                <option value="0" {if $tld.email_reminder=='0'}selected="selected"{/if}>{$lang.none}</option> 
				{foreach from=$messages item=msg}
                                                <option value="{$msg.id}" {if $tld.email_reminder==$msg.id}selected="selected"{/if}>{$msg.tplname}</option>
				{/foreach}</select>
                                            <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=terminate' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                        </td>
                                    </tr>

                                </tbody>
                                <tbody  >
                                    <tr><td colspan="2">
                                            <div class="sectionhead">{$lang.domaddons} </div>			 
                                        </td></tr>
                                <tbody  id='doma-settings' > 
                                    <tr>
                                        <td><strong>{$lang.DNSmanagement}</strong></td>
                                        <td>
                                            <input type="checkbox"  value="1"  name="dns_on" {if $tld.dns>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="price inp" {if $tld.dns>=0}value="{$tld.dns}"{else}value="0.00" disabled="disabled"{/if} name='dnscharge'/> {$lang.peryear}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Emailforwarding}</strong></td>
                                        <td>
                                            <input type="checkbox"  value="1"  name="email_on" {if $tld.email>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="price inp" {if $tld.email>=0}value="{$tld.email}"{else}value="0.00" disabled="disabled"{/if} name='emailcharge'/> {$lang.peryear}
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.IDprotection}</strong></td>
                                        <td>
                                            <input type="checkbox"  value="1"  name="id_on" {if $tld.idp>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="price inp" {if $tld.idp>=0}value="{$tld.idp}"{else}value="0.00" disabled="disabled"{/if} name='idcharge'/> {$lang.peryear}
                                        </td>
                                    </tr>
                                </tbody>

                                <tbody  >
                                    <tr><td colspan="2">
                                            <div class="sectionhead">{$lang.Nameservers} </div>			 
                                        </td></tr>
                                </tbody>
                                <tbody  id='doma-settings' > 
                                    <tr>
                                        <td><strong>{$lang.Nameserver} 1</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.ns[0]}"  name='ns[0]'/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} 2</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.ns[1]}"  name='ns[1]'/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} 3</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.ns[2]}"  name='ns[2]'/> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} 4</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.ns[3]}"  name='ns[3]'/> 
                                        </td>
                                    </tr>

                                </tbody>


			 		{if $tld.nsip|is_array} <tbody  >
                                    <tr><td colspan="2">
                                            <div class="sectionhead">{$lang.Nameservers} IPs</div>
                                        </td></tr>
                                </tbody>
                                <tbody  id='doma-settings' >
                                    <tr>
                                        <td><strong>{$lang.Nameserver} IP 1</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.nsip[0]}"  name='nsip[0]'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} IP 2</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.nsip[1]}"  name='nsip[1]'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} IP 3</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.nsip[2]}"  name='nsip[2]'/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>{$lang.Nameserver} IP 4</strong></td>
                                        <td>
                                            <input class="inp" value="{$tld.nsip[3]}"  name='nsip[3]'/>
                                        </td>
                                    </tr>

                                </tbody>
                                {/if}
                                <tbody  >
                                    <tr><td colspan="2">
                                            <div class="sectionhead">{$lang.othersettings}</div>			 
                                        </td></tr>
                                    <tr>
                                        <td><strong>{$lang.donotrenew}</strong></td>
                                        <td><input type="checkbox" name="donotrenew" value="1" {if $tld.not_renew=='1'}checked="checked"{/if}/></td>
                                    </tr><tr>
                                        <td><strong>{$lang.requireepp}</strong></td>
                                        <td><input type="checkbox" name="epp" value="1" {if $tld.epp=='1'}checked="checked"{/if}/></td>
                                    </tr>
                                </tbody>


                                <tbody>

                                    <tr >
                                        <td colspan="2">
                                            <p align="center">
                                                <input type="submit" value="{$lang.savechanges}" class="submitme" style="font-weight:bold;"/>
                                                <span class="orspace">{$lang.Or}</span> <a href="?cmd=tldprices"  class="editbtn">{$lang.Cancel}</a>

                                            </p>

                                        </td>
                                    </tr></tbody>
                            </table>


                        {securitytoken}</form></center>
                </div>
	{else}

                <div id="addtld" {if $action!='add'}style="display:none"{/if}>
                     <div class="blu"><strong>{$lang.addtld}</strong></div>
                    <div class="nicerblu"><center>
                            <form action=""	method="post">
                                <input type="hidden" name="make" value="add" />
                                <table border="0" cellpadding="6" cellspacing="0" width="70%">
                                    <tbody><tr>
                                            <td width="160" align="right"><strong style="font-size:16px !important;">{$lang.dom_exts}</strong></td>
                                            <td align="left"><input class="inp"  name="tld" style="font-size:16px !important;font-weight:bold;width:97%"/><br />
                                                <small>{$lang.tldexample}</small>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td colspan="2" align="left">
                                                <div class="left" style="padding:5px;margin-right:5px;width:46%;border-right:solid 1px #c0c0c0">
                                                    <input type="radio" name="automate" value="1" checked="checked" onclick="$('#dommodules').show();loadMod(this);"/>	<strong style="font-size:16px !important;">{$lang.dom_aut}</strong><br />
								{$lang.dom_aut_exp}

                                                </div>
                                                <div  class="left" style="width:46%;padding:5px;margin-left:5px;;">
                                                    <input type="radio" name="automate" value="0" onclick="$('#dommodules').hide();loadMod(this);"/>	<strong style="font-size:16px !important;">{$lang.Manual}</strong><br />
								{$lang.dom_man_exp}
                                                </div>
                                                <div class="clear"></div>
                                            </td>
                                        </tr>

                                        <tr id="dommodules">
                                            <td colspan="2" align="left">


						{foreach from=$modules item=mod}{if $mod.featured}
                                                <div class="featured_module left">
                                                    <div class="mod_img">
								{$mod.module}
                                                    </div>							
                                                    <div class="mod_sel"><input type="radio" name="module" value="{if $mod.id==-1}{$mod.filename}{else}{$mod.id}{/if}"  onclick="loadMod(this);" {if $mod.id==$product.module}checked="checked"{/if}/></div>
                                                </div>
						{/if} {/foreach}



                                                <div class="left" style="padding:15px;">

                                                    <a href="#" class="new_control" onclick="$(this).parent().hide();$('#moremodules').show();return false;" ><span class="addsth" >{$lang.newregistrar}</span></a>


                                                </div>
                                                <div class="clear"></div>						
                                                <div id="moremodules" style="display:none">
							{foreach from=$modules item=mod}{if !$mod.featured && $mod.filename!='class.email.php' && $mod.id!='-1'}
                                                    <div class="regular_module left">							
                                                        <input type="radio" name="module" value="{$mod.id}" onclick="loadMod(this);"/> {$mod.module}
                                                    </div>{/if} {/foreach} 
                                                    <div style="padding-top:10px;float:left;"><a href="#" onclick="$(this).parent().hide();$('.inactivemod').show();return false;" >{$lang.show_inactive_mods}</a></div>

							{foreach from=$modules item=mod}{if !$mod.featured  && $mod.id=='-1' && $mod.filename!='class.email.php'}
                                                    <div class="regular_module left inactivemod" style="display:none">							
                                                        <input type="radio" name="module" value="{$mod.filename}" onclick="loadMod(this);"/> {$mod.module}
                                                    </div>{/if} {/foreach} 

                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="modconfig" style="display:none">
                                            <td colspan="2">							
                                            </td>
                                        </tr></tbody>

                                    <tbody  >
                                        <tr><td colspan="2">
                                                <div class="sectionhead">{$lang.messoptions} <a href="#" class="editbtn" onclick="$(this).hide();$('#aut-settings').show();return false;">{$lang.expand}</a></div>			 
                                            </td></tr></tbody>
                                    <tbody  id='aut-settings' style="display:none"> 
                                        <tr>
                                            <td><strong>{$lang.domregmail}</strong></td>
                                            <td id="welcome_msg"><select class="inp" name="email_registered">
                                                    <option value="0">{$lang.none}</option> 
				{foreach from=$messages item=msg}
                                                    <option value="{$msg.id}" {if $msg.id=='28'}selected="selected"{/if}>{$msg.tplname}</option>
				{/foreach}
                                                </select>
                                                <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=welcome' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td><strong>{$lang.domtransmail}</strong></td>
                                            <td id="suspend_msg"><select class="inp" name="email_transfered">
                                                    <option value="0">{$lang.none}</option>{foreach from=$messages item=msg}
                                                    <option value="{$msg.id}" {if $msg.id=='30'}selected="selected"{/if}>{$msg.tplname}</option>

				{/foreach}</select>
                                                <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=suspend' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td><strong>{$lang.domrenewed}</strong></td>
                                            <td id="unsuspend_msg"><select class="inp" name="email_renewed">
                                                    <option value="0">{$lang.none}</option> {foreach from=$messages item=msg}
                                                    <option value="{$msg.id}" {if $msg.id=='29'}selected="selected"{/if}>{$msg.tplname}</option>

				{/foreach}</select>
                                                <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=unsuspend' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td><strong>{$lang.domrenewal}</strong></td>
                                            <td id="terminate_msg"><select class="inp" name="email_reminder">
                                                    <option value="0">{$lang.none}</option>{foreach from=$messages item=msg}
                                                    <option value="{$msg.id}" {if $msg.id=='54'}selected="selected"{/if}>{$msg.tplname}</option>

				{/foreach}</select>
                                                <a href="?cmd=emailtemplates&action=add&inline=true" class="new_control colorbox"  target="_blank"  onclick="{literal}$.facebox({ ajax: '?cmd=emailtemplates&action=add&inline=true&to=terminate' });{/literal} return false;"><span class="addsth" >{$lang.composenewmsg}</span></a>
                                            </td>
                                        </tr>

                                    </tbody>
                                    <tbody  >
                                        <tr><td colspan="2">
                                                <div class="sectionhead">{$lang.domaddons} <a href="#" class="editbtn" onclick="$(this).hide();$('#doma-settings').show();return false;">{$lang.expand}</a></div>			 
                                            </td></tr>
                                    <tbody  id='doma-settings' style="display:none"> 
                                        <tr>
                                            <td><strong>{$lang.DNSmanagement}</strong></td>
                                            <td>
                                                <input type="checkbox"  value="1"  name="dns_on" {if $dnscharge>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="inp price" {if $dnscharge>=0}value="{$dnscharge}"{else}value="0.00" disabled="disabled"{/if} name='dnscharge'/> {$lang.peryear}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Emailforwarding}</strong></td>
                                            <td>
                                                <input type="checkbox"  value="1"  name="email_on" {if $emailcharge>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="inp price" {if $emailcharge>=0}value="{$emailcharge}"{else}value="0.00" disabled="disabled"{/if} name='emailcharge'/> {$lang.peryear}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.IDprotection}</strong></td>
                                            <td>
                                                <input type="checkbox"  value="1"  name="id_on" {if $idcharge>=0}checked="checked"{/if} onclick="check_i(this)"/><input size="5" class="inp price" {if $idcharge>=0}value="{$idcharge}"{else}value="0.00" disabled="disabled"{/if} name='idcharge'/> {$lang.peryear}
                                            </td>
                                        </tr>
                                    </tbody>
                                    <tbody  >
                                        <tr><td colspan="2">
                                                <div class="sectionhead">{$lang.Nameservers} <a href="#" class="editbtn" onclick="$(this).hide();$('#domn-settings').show();return false;">{$lang.expand}</a> </div>			 
                                            </td></tr>
                                    <tbody  id='domn-settings' style="display:none"> 
                                        <tr>
                                            <td><strong>{$lang.Nameserver} 1</strong></td>
                                            <td>
                                                <input class="inp"  name='ns[0]'/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} 2</strong></td>
                                            <td>
                                                <input class="inp"  name='ns[1]'/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} 3</strong></td>
                                            <td>
                                                <input class="inp"  name='ns[2]'/> 
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} 4</strong></td>
                                            <td>
                                                <input class="inp" name='ns[3]'/> 
                                            </td>
                                        </tr>

                                    </tbody>

                                    <tbody  >
                                        <tr><td colspan="2">
                                                <div class="sectionhead">{$lang.Nameservers} IPs <a href="#" class="editbtn" onclick="$(this).hide();$('#domn-settings2').show();return false;">{$lang.expand}</a> </div>
                                            </td></tr>
                                    </tbody>
                                    <tbody   id='domn-settings2' style="display:none">
                                        <tr>
                                            <td><strong>{$lang.Nameserver} IP 1</strong></td>
                                            <td>
                                                <input class="inp"  name='nsip[0]'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} IP 2</strong></td>
                                            <td>
                                                <input class="inp"  name='nsip[1]'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} IP 3</strong></td>
                                            <td>
                                                <input class="inp" name='nsip[2]'/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><strong>{$lang.Nameserver} IP 4</strong></td>
                                            <td>
                                                <input class="inp" name='nsip[3]'/>
                                            </td>
                                        </tr>

                                    </tbody>

                                    <tbody  >
                                        <tr><td colspan="2">
                                                <div class="sectionhead">{$lang.othersettings}</div>			 
                                            </td></tr>
                                        <tr>
                                            <td><strong>{$lang.donotrenew}</strong></td>
                                            <td><input type="checkbox" name="donotrenew" value="1" /></td>
                                        </tr><tr>
                                            <td><strong>{$lang.requireepp}</strong></td>
                                            <td><input type="checkbox" name="epp" value="1" checked="checked"/></td>
                                        </tr>
                                    </tbody>

                                    <tbody>


                                        <tr >
                                            <td colspan="2">
                                                <p align="center">
                                                    <input type="submit" value="Add tld" class="submitme" style="font-weight:bold;"/>
                                                    <span class="orspace">{$lang.Or}</span> <a href="#" onclick="$('#tlds').show();$('#addtld').hide();return false;" class="editbtn">{$lang.Cancel}</a>

                                                </p>

                                            </td>
                                        </tr></tbody>
                                </table>


                            {securitytoken}</form></center>
                    </div>

                </div>
                <div id="tlds"  {if $action=='add'}style="display:none"{/if}>
                     {if !$tlds}
                     <div class="blank_state blank_domains">
                        <div class="blank_info">
                            <h1>{$lang.blank_info_tld}</h1>
                            <div class="clear"></div>

                            <a class="new_add new_menu" href="?cmd=tldprices&action=add" onclick="addnewtlds();return false;" style="margin-top:10px">
                                <span>{$lang.addtld}</span></a>
                            <div class="clear"></div>

                        </div>
                    </div>

                    {else}
                    <div class="blu">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td><strong>{$lang.mangage_tlds_}</strong></td>
                                <td align="right"><a href="?cmd=tldprices&action=add" class="editbtn"  onclick="addnewtlds();return false;">{$lang.addtld}</a>&nbsp;&nbsp; <a href="#"  class="editbtn"  onclick="return addnewgroup()">{$lang.addnewpgroup}</a></td>
                            </tr>
                        </table>




                    </div>
                    <div id="ticketbody">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td valign="top" width="160"><form id="serializeit" method="post" action="">
                                        <ul id="grab-sorter" class="grabsortdomain">
	{foreach from=$tlds item=tld}
                                            <li><div>
                                                    <table class="glike" cellpadding="3" cellspacing="0" width="100%">
                                                        <tr >
                                                            <td  width="20"><a class="sorter-handle">sort</a></td>
                                                            <td width="100"><strong>{$tld.tld}</strong></td>
                                                            <td  width="20">
                                                                <a class="editbtn" href="?cmd=tldprices&action=edit&tld={$tld.tld}">{$lang.edit}</a></td>
                                                            <td  width="20"><a class="delbtn" href="?cmd=tldprices&make=delete&tld={$tld.tld}&security_token={$security_token}" onclick="return confirm('{$lang.deletetldconfirm}');">{$lang.Delete}</a></td>
                                                        </tr>
                                                    </table>

                                                    <input type="hidden" name="sort[]" value="{$tld.tld}" />

                                                </div></li>	
	{/foreach}
                                        </ul>
                                    {securitytoken}</form>
                                    <table class="glike" cellpadding="3" cellspacing="0" width="100%">
                                        <tr >
                                            <th  ><a href="?cmd=tldprices&action=add" class="editbtn" onclick="addnewtlds();return false;">{$lang.addtld}</a></th>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top" class="nicers2"  style="background:#ffffff;padding-bottom:15px">
		{if !$pricegroup}
                                    <div class="blank_state blank_domains" id="addnewgroup_btn">
                                        <div class="blank_info">
                                            <h1>{$lang.blank_pgroup}</h1>
				{$lang.blank_pgroup2}
                                            <div class="clear"></div>

                                            <a class="new_add new_menu" href="?cmd=tldprices&action=add"  onclick="return addnewgroup()" style="margin-top:10px">
                                                <span>{$lang.addnewpgroup}</span></a>
                                            <div class="clear"></div>

                                        </div>
                                    </div>

		{else}
                                    <div style="padding:15px 15px 0px">
                                        <table border="0" cellpadding="3" cellspacing="0" width="100%" id="tldpricestable" class="whitetable">
                                            <tr>
                                                <th width="10%">{$lang.Period}:</th>
                                                <th  width="15%">{$lang.Register}</th>
                                                <th  width="15%">{$lang.Transfer}</th>
                                                <th  width="15%">{$lang.Renew}</th>
                                                <th width="43%"></th>
                                                <th width="5%"></th>

                                                <th width="17"></th>
                                            </tr>

			{foreach from=$pricegroup item=group name=gloop}
                                            <tr {if $smarty.foreach.gloop.iteration%2==0}class="even"{/if}>
                                                <td>{$group.period} {$lang.yearslash}</td>	
                                                <td>{if $group.register>0}{$group.register|price:$currency}{elseif $group.register==0}{$lang.Free}{else}-{/if}</td>
                                                <td>{if $group.transfer>0}{$group.transfer|price:$currency}{elseif $group.transfer==0}{$lang.Free}{else}-{/if}</td>
                                                <td>{if $group.renew>0}{$group.renew|price:$currency}{elseif $group.renew==0}{$lang.Free}{else}-{/if}</td>
                                                <td class="fs11 lastitm">{foreach from=$group.tlds item=tld name=tloop}{$tld}{if !$smarty.foreach.tloop.last}, {/if}{/foreach}</td>
                                                <td><a href="?cmd=tldprices&make=deletegroup&hash={$group.hash}" class="editbtn" onclick="editgroup(this,'{$group.hash}', '{$group.period}' ,{if $group.register>0}'{$group.register}'{elseif $group.register==0}'free'{else}null{/if},{if $group.transfer>0}'{$group.transfer}'{elseif $group.transfer==0}'free'{else}null{/if},{if $group.renew>0}'{$group.renew}'{elseif $group.renew==0}'free'{else}null{/if}); return false;">{$lang.Edit}</a>
                                                </td>

                                                <td class="lastitm">
                                                    <a href="?cmd=tldprices&make=deletegroup&hash={$group.hash}&security_token={$security_token}" class="delbtn" onclick="return confirm('{$lang.delconfirmation2}');">{$lang.Delete}</a>
                                                </td>
                                            </tr>
			{/foreach}
                                            <tr id="addnewgroup_btn">
                                                <th colspan="7" align="right">
                                                    <a href="#" class="editbtn" onclick="return addnewgroup()">{$lang.addnewpgroup}</a>
                                                </th>
                                            </tr>

                                        </table>





                                    </div>

		{/if}
                                    <div style="margin:0px 15px;display:none;" id="newgroup">
                                        <div class="blu"><strong>{$lang.addnewpgroup}</strong></div>
                                        <div class="nicerblu"><form method="post" action="">
                                                <input type="hidden" name="make" value="addgroup" />
                                                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="25%">
                                                            <strong>{$lang.Period}</strong>

                                                            <select class="inp" name="period">
						{section name=foo loop=10}
                                                                <option value="{$smarty.section.foo.iteration}">{$smarty.section.foo.iteration}{if $smarty.section.foo.iteration == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>{/section}
                                                            </select>
                                                        </td>

                                                        <td width="25%" ><strong>{$lang.Register}</strong><input type="checkbox"  value="1"  name="register_on" onclick="check_i(this)" checked="checked"/> <input name="register" value="0.00" size="4" class="price inp"/></td>

                                                        <td  width="25%"><strong>{$lang.Transfer}</strong><input type="checkbox"  value="1"  name="transfer_on" onclick="check_i(this)" checked="checked"/> <input name="transfer" value="0.00" size="4" class="price inp"/></td>

                                                        <td width="25%"><strong>{$lang.Renew}</strong><input type="checkbox"  value="1"  name="renew_on" onclick="check_i(this)" checked="checked"/> <input name="renew" value="0.00" size="4" class="price inp"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <input type="checkbox" onclick="c_all(this)"/> <span class="fs11"><strong>{$lang.selectAll}</strong></span><br />
					{foreach from=$tlds item=tld}
                                                            <div class="left" style="width:80px"><input type="checkbox" name="tld[]" value="{$tld.tld}" /><span class="fs11">{$tld.tld}</span> </div>
					{/foreach}
                                                            <div class="clear"></div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4" align="center">
                                                            <input type="submit" value="{$lang.addnewpgroup}"  style="font-weight:bold" class="submitme"/> <span class="orspace">{$lang.Or}</span><a href="#" onclick="$('#addnewgroup_btn').show();	$('#newgroup').hide();return false;" class="editbtn">{$lang.Cancel}</a>
                                                        </td>
                                                    </tr>
                                                </table>{securitytoken}</form>
                                        </div></div>

                                    <div style="margin:0px 15px; display: none" id="editgroup">
                                        <div class="blu"><strong>{$lang.editpgroup}</strong></div>
                                        <div class="nicerblu"><form method="post" action="">
                                                <input type="hidden" name="make" value="editgroup" />
                                                <input type="hidden" name="hash" value="" />
                                                <input type="hidden" name="period" value="" />
                                                <table border="0" cellpadding="6" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td width="25%">
                                                            <strong>{$lang.Period}</strong>

                                                            <span class="edit_period"></span> {$lang.yearslash}
                                                        </td>

                                                        <td width="25%" ><strong>{$lang.Register}</strong><input type="checkbox"  value="1"  name="register_on" onclick="check_i(this)" checked="checked"/> <input name="register" value="0.00" size="4" class="price inp"/></td>

                                                        <td  width="25%"><strong>{$lang.Transfer}</strong><input type="checkbox"  value="1"  name="transfer_on" onclick="check_i(this)" checked="checked"/> <input name="transfer" value="0.00" size="4" class="price inp"/></td>

                                                        <td width="25%"><strong>{$lang.Renew}</strong><input type="checkbox"  value="1"  name="renew_on" onclick="check_i(this)" checked="checked"/> <input name="renew" value="0.00" size="4" class="price inp"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" class="tldext_list">
                                                            <input type="checkbox" onclick="c_all(this)"/> <span class="fs11"><strong>{$lang.selectAll}</strong></span><br />
					{foreach from=$tlds item=tld}
                                                            <div class="left" style="width:80px"><input type="checkbox" name="tld[]" value="{$tld.tld}" /><span class="fs11">{$tld.tld}</span> </div>
					{/foreach}
                                                            <div class="clear"></div>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td colspan="4" align="center">
                                                            <input type="submit" value="{$lang.savechanges}"  style="font-weight:bold" class="submitme"/> <span class="orspace">{$lang.Or}</span><a href="#" onclick="$('#tldpricestable tr').removeClass('yellow_bg');$('#editgroup').hide();$('#addnewgroup_btn').show(); return false;" class="editbtn">{$lang.Cancel}</a>
                                                        </td>
                                                    </tr>
                                                </table>{securitytoken}</form>
                                        </div></div>


                                </td>
                            </tr>
                        </table>

                    </div>
                    <div class="clear"></div>
                    {/if}
                </div>
                <script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js"></script>
                <script type="text/javascript">{literal}
                    $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle",  dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
		
                    function saveOrder() {	
                        var sorts = $('#serializeit').serialize();
                        ajax_update('?cmd=tldprices&action=changeorder&'+sorts,{});		
                    };
		
                    function addnewtlds() {
                        $('#tlds').hide();
                        $('#addtld').show();
                        return false;
                    }
                    function addnewgroup() {
                        $('#addnewgroup_btn').hide();
                        $('#editgroup').hide();
                        $('#tldpricestable tr').removeClass('yellow_bg');
                        $('#newgroup').show();
                        return false;

                    }
                    function editgroup(elem, hash, period, register, transfer, renew) {
                        $('#addnewgroup_btn').hide();
                        $('#newgroup').hide();
                        $('#tldpricestable tr').removeClass('yellow_bg');

                        $(elem).parents('tr').first().addClass('yellow_bg');
                        $('#editgroup .tldext_list input').removeAttr('checked');
                        var tldlist = $(elem).parents('tr').first().find('.fs11').html();
                        var tld = tldlist.split(', ');
                        for(i in tld) {
                            $('#editgroup .tldext_list input[value="'+tld[i]+'"]').attr('checked','checked');
                        }
                        $('#editgroup input[name="hash"]').val(hash);
                        $('#editgroup input[name="period"]').val(period);
                        $('.edit_period').html(period);
                        if(register) {
                            if(register == 'free') {register = '0.00';}
                            $('#editgroup input[name="register_on"]').attr('checked', 'checked');
                            $('#editgroup input[name="register"]').removeAttr('disabled').val(register);
                        } else { $('#editgroup input[name="register_on"]').removeAttr('checked'); $('#editgroup input[name="register"]').attr('disabled', 'disabled').val('0.00');}
                        if(transfer) {
                            if(transfer == 'free') {transfer = '0.00';}
                            $('#editgroup input[name="transfer_on"]').attr('checked', 'checked');
                            $('#editgroup input[name="transfer"]').removeAttr('disabled').val(transfer);
                        } else { $('#editgroup input[name="transfer_on"]').removeAttr('checked'); $('#editgroup input[name="transfer"]').attr('disabled', 'disabled').val('0.00');}
                        if(renew) {
                            if(renew == 'free') {renew = '0.00';}
                            $('#editgroup input[name="renew_on"]').attr('checked', 'checked');
                            $('#editgroup input[name="renew"]').removeAttr('disabled').val(renew);
                        } else { $('#editgroup input[name="renew_on"]').removeAttr('checked'); $('#editgroup input[name="renew"]').attr('disabled', 'disabled').val('0.00');}
                        $('#editgroup').show();
                        return false;

                    }

                    {/literal}
                </script>
                {/if}
            </div>

        </td>
    </tr>
</table>
<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
<link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
<script type="text/javascript">
    {literal}
    function add_message(gr,id,msg) {
        var sel=$('#'+gr+'_msg select');
        sel.find('option:selected').removeAttr('selected');
        sel.prepend('<option value="'+id+'">'+msg+'</option>').find('option').eq(0).attr('selected','selected');
        return false;

    }
    function check_i(element) {
        var td = $(element).parent();
        if ($(element).is(':checked'))
            $(td).find('input.price').removeAttr('disabled');
        else
            $(td).find('input.price').attr('disabled','disabled');
    }
    function loadMod(el) {
        if ($(el).val()=='0') {
            //show email config
            $('#modconfig').show();
            ajax_update('?cmd=managemodules',{action:'quickactivate',fname:'class.email.php',type:'Domain'},'#modconfig td');
        } else if($(el).val().lastIndexOf('class')!=-1) {
            //now, lets activate new module
            $('#modconfig').show();
            ajax_update('?cmd=managemodules',{action:'quickactivate',fname:$(el).val(),type:'Domain'},'#modconfig td');
        }else {
            $('#modconfig').show();
            ajax_update('?cmd=managemodules',{action:'quickactivate',fname:$(el).val(),type:'Domain'},'#modconfig td');

        }

        return false;
    }
    function c_all(el) {
        if($(el).is(':checked')) {
            $(el).parent().find('input[type="checkbox"]').attr('checked','checked');	
        } else {
            $(el).parent().find('input[type="checkbox"]').removeAttr('checked');
        }
        return false;

    }
    {/literal}
</script>