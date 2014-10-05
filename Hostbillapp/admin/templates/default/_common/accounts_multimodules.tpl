{foreach from=$details.modules item=module key=mid}
<ul class="accor">
    <li><a href="#">Module details: {$module.modname} ({$module.status})</a>
        <div class="sor">
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="50%" valign="top">
                        <table cellspacing="2" cellpadding="3" border="0" width="100%" >
                            <tbody>

                                <tr>
                                    <td >{$lang.Server} / App</td>
                                    <td>
                                        <div  >
                                            <select name="modules[{$mid}][server_id]" id="server_id" >
                                                <option value="0" {if $server.id=='0'}selected="selected" def="def"{/if}>{$lang.none}</option>
                                                {foreach from=$moduleservers.$mid item=server}
                                                <option value="{$server.id}" {if $module.server_id==$server.id}selected="selected" def="def"{/if}>{$server.name} ({$server.accounts}/{$server.max_accounts} Accounts)</option>
                                                {foreachelse}
                                                <option value="0">{$lang.noservers}</option>
                                                {/foreach}
                                            </select></div>


                                    </td>
                                </tr>

                                {if $moduledetails.$mid}
                                    {foreach from=$moduledetails.$mid item=field key=field_key}
                                        {if $field.name == 'domain'}

                                        {elseif $field.name == 'username'}
                                            <tr>
                                                <td >{$lang.Username}</td>
                                                <td >
                                                    <input type="text" value="{$module.username}" name="modules[{$mid}][username]" size="20"  class="{if $module.status!='Pending' && $module.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $module.status!='Pending' && $module.status!='Terminated'}style="display:none"{/if}/>
                                                    <span class="{if $module.status!='Pending' && $module.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $module.status=='Pending' || $module.status=='Terminated'}style="display:none"{/if}>
                                                    {if $module.username}{$module.username}{else}<span style="color:#848C93;user-select: none">{$lang.none}</span>{/if}
                                                    </span>
                                                </td>
                                            </tr>
                                        {elseif $field.name == 'password'}
                                            <tr>
                                                <td >{$lang.Password}</td>
                                                <td ><input type="text" value="{$module.password}" name="modules[{$mid}][password]" size="20" />  {if $moduleacl.$mid.allowpasschange}<input type="submit" name="moduleaction[{$mid}][changepassword]" value="{$lang.changepassword}" />{/if}</td>
                                            </tr>
                                        {elseif $field.name == 'rootpassword'}
                                            <tr>
                                                <td >{$lang.rootpass}</td>
                                                <td ><input type="text" value="{$module.rootpassword}" name="modules[{$mid}][rootpassword]" size="20" /></td>
                                            </tr>
                                        {elseif $field.name}
                                            {if $field.type == 'hidden'}
                                            <input type="hidden" value="{if $module.extra_details.$field_key}{$module.extra_details.$field_key}{/if}" name="modules[{$mid}][extra_details][{$field_key}]" />
                                        {else}
                                            <tr>
                                                <td>{if $lang[$field.name]}{$lang[$field.name]}{else}{$field.name}{/if}</td>
                                                <td>
                                                    {if $field.type == 'input'}
                                                        <input type="text" value="{if $module.extra_details.$field_key}{$module.extra_details.$field_key}{/if}" name="modules[{$mid}][extra_details][{$field_key}]" size="20" class="{if $module.status!='Pending' && $module.status!='Terminated'}manumode{/if}"  {if $details.manual!='1' && $module.status!='Pending' && $module.status!='Terminated'}style="display:none"{/if}/>
                                                        <span class="{if $module.status!='Pending' && $module.status!='Terminated'}livemode{/if}" {if $details.manual=='1' || $module.status=='Pending' || $module.status=='Terminated'}style="display:none"{/if}>
                                                        {if $module.extra_details.$field_key}{$module.extra_details.$field_key}{else}<span style="color:#848C93;user-select: none">{$lang.empty}</span>{/if}
                                                    </span>
                                                    {elseif $field.type == 'check'}

                                                    {/if}
                                                </td>
                                            </tr>
                                        {/if}
                                    {/if}
                                {/foreach}
                            {/if}

                            <tr >
                                <td >{$lang.availactions}</td>
                                <td >

                                    <input type="submit" onclick="$('body').addLoader();"  name="moduleaction[{$mid}][create]" value="Create" {if !$moduleacl.$mid.allowcreate}class="manumode"{/if} {if !$moduleacl.$mid.allowcreate && $details.manual!='1'}style="display:none"{/if}/>
                                           <input type="submit" name="moduleaction[{$mid}][suspend]" value="Suspend" {if !$moduleacl.$mid.allowsuspend} class="manumode"{/if} {if !$moduleacl.$mid.allowsuspend && $details.manual!='1'}style="display:none"{/if}  onclick="return confirm('{$lang.suspendconfirm}')"/>
                                           <input type="submit" name="moduleaction[{$mid}][unsuspend]" value="Unsuspend" {if !$moduleacl.$mid.allowunsuspend} class="manumode"{/if} {if !$moduleacl.$mid.allowunsuspend && $details.manual!='1'}style="display:none"{/if}/>
                                           <input type="submit" name="moduleaction[{$mid}][terminate]"  value="Terminate" {if !$moduleacl.$mid.allowterminate}class="manumode"{/if} {if !$moduleacl.$mid.allowterminate && $details.manual!='1'}style="display:none;color:#ff0000;"{else} style="color:#ff0000"{/if} onclick="return confirm('{$lang.terminateconfirm}')"/>
                                           <input type="submit" name="moduleaction[{$mid}][renewal]"  value="Renewal" {if !$moduleacl.$mid.allowrenewal}style="display:none"{/if}/>


                                           {foreach from=$modulecustom.$mid item=btn}
                                           <input type="submit" name="moduleaction[{$mid}][customfn]" value="{$btn}" class="{if $module.status!='Active'}manumode{/if} {if $loadable[$btn]}toLoad{/if}" {if $module.status!='Active' && $details.manual!='1'}style="display:none"{/if} />
                                           {/foreach}

                                </td>
                            </tr>
                            </tbody>
                        </table>

                    </td>
                    <td width="50%" valign="top"></td>
                </tr>
            </table>
        </div>
    </li>
</ul>
{/foreach}