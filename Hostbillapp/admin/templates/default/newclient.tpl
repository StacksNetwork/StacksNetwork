<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
    <tr>
        <td ><h3>{$lang.newclient}</h3></td>
        <td  class="searchbox"><div id="hider2" style="text-align:right">

                &nbsp;&nbsp;&nbsp;<a href="?cmd=clients&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=clients&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>

            </div>
            <div id="hider" style="display:none"></div></td>
    </tr>
    <tr>
        <td class="leftNav"><a href="?cmd=newclient"  class="tstyled selected"><strong>{$lang.registernew}</strong></a><br />

            <a href="?cmd=clients"  class="tstyled">{$lang.managecustomers}</a>
            <a href="?cmd=clients&list=active"  class="tstyled tsubit ">{$lang.Active}</a>
            <a href="?cmd=clients&list=closed"  class="tstyled tsubit ">{$lang.Closed}</a>
            {foreach from=$groups item=group}
                <a href="?cmd=clients&list={$group.id}"  class="tstyled tsubit " style="color:{$group.color}">{$group.name} <span>({$group.count})</span></a>
            {/foreach}
            <br />
            <a href="?cmd=clients&action=groups"  class="tstyled ">{$lang.clientgroups}</a>
            <a href="?cmd=clients&action=fields"  class="tstyled ">{$lang.customerfields}</a>
            <br />
            <a href="?cmd=affiliates"  class="tstyled">{$lang.Affiliates}</a>
            <a href="?cmd=affiliates&action=configuration"  class="tstyled">{$lang.affconfig}</a>
        </td>


        <td  valign="top"  class="bordered"><div id="bodycont">
                <form method="post" action="" name="signupform">
                    <input type="hidden" name="adminsignup" value="1" />
                    <div class="blu"><a href="?cmd=clients" ><strong>&laquo; {$lang.backtoclients}</strong></a>


                    </div>


                    <div id="ticketbody" class="lighterblue">



                        <table cellspacing="1" cellpadding="0" width="100%">
                            <tbody>
                                <tr><td width="50%" valign="top">

                                        <table cellpadding="2" width="100%">
                                            <tbody>{foreach from=$fields item=field name=floop key=k}
                                            {if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}{/if}

                                            <tr  {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                                            {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                                                    <td width="110" class="">
                                                        {if $k=='type'}
                                                            {$lang.clacctype}
                                                        {elseif $field.options & 1}
                                                    {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                                {else}
                                                    {$field.name}
                                                {/if}
                                            </td>
                                            <td class="">
                                                {if $k=='type'}
                                                    <select  name="type" style="width: 80%;" onchange="{literal}if ($(this).val() == 'Private') {
                                                                $('.iscomp').hide();
                                                                $('.ispr').show();
                                                            } else {
                                                                $('.ispr').hide();
                                                                $('.iscomp').show();
                                                            }{/literal}">
                                                        <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                                        <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                                    </select>
                                                {elseif $k=='country'}
                                                    <select name="country" style="width: 80%;">
                                                        {foreach from=$countries key=k item=v}
                                                            <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

                                                        {/foreach}
                                                    </select>
                                                {else}
                                                    {if $field.field_type=='Input'}
                                                        <input type="text" value="{$submit[$k]}" style="width: 80%;" name="{$k}" class="styled"/>
                                                    {elseif $field.field_type=='Password'}
                                                        <input type="password" value="" style="width: 80%;" name="{$k}" class="styled"/>
                                                    {elseif $field.field_type=='Select'}
                                                        <select name="{$k}" style="width: 80%;">
                                                            {foreach from=$field.default_value item=fa}
                                                                <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                                            {/foreach}
                                                        </select>
                                                    {elseif $field.field_type=='Check'}
                                                        {foreach from=$field.default_value item=fa}
                                                            <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                                        {/foreach}
                                                    {/if}
                                                {/if}
                                            </td>
                                        </tr>

                                        {/foreach}
                                        </tbody></table>

                                </td><td width="50%" valign="top">

                                    <table cellpadding="2" width="100%">
                                        <tbody>{foreach from=$fields item=field name=floop key=k}
                                        {if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}{/if}

                                        <tr {if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
                                        {elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
                                                <td width="110" class="">
                                                    {if $k=='type'}
                                                        {$lang.clacctype}
                                                    {elseif $field.options & 1}
                                                {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                            {else}
                                                {$field.name}
                                            {/if}
                                        </td>
                                        <td class="">
                                            {if $k=='type'}
                                                <select  name="type" style="width: 80%;" onchange="{literal}if ($(this).val() == 'Private') {
                                                                $('.iscomp').hide();
                                                                $('.ispr').show();
                                                            } else {
                                                                $('.ispr').hide();
                                                                $('.iscomp').show();
                                                            }{/literal}">
                                                    <option value="Private" {if $submit.type=='Private'}selected="selected"{/if}>{$lang.Private}</option>
                                                    <option value="Company" {if $submit.type=='Company'}selected="selected"{/if}>{$lang.Company}</option>
                                                </select>{elseif $k=='country'}
                                                <select name="country" style="width: 80%;">
                                                    {foreach from=$countries key=k item=v}
                                                        <option value="{$k}" {if $k==$submit.country  || (!$submit.country && $k==$defaultCountry)} selected="Selected"{/if}>{$v}</option>

                                                    {/foreach}
                                                </select>
                                            {else}
                                                {if $field.field_type=='Input'}
                                                    <input type="text" value="{$submit[$k]}" style="width: 80%;" name="{$k}" class="styled"/>
                                                {elseif $field.field_type=='Password'}
                                                    <input type="password" value="" style="width: 80%;" name="{$k}" class="styled"/>
                                                {elseif $field.field_type=='Select'}
                                                    <select name="{$k}" style="width: 80%;">
                                                        {foreach from=$field.default_value item=fa}
                                                            <option {if $submit[$k]==$fa}selected="selected"{/if}>{$fa}</option>
                                                        {/foreach}
                                                    </select>
                                                {elseif $field.field_type=='Check'}
                                                    {foreach from=$field.default_value item=fa}
                                                        <input type="checkbox" name="{$k}[{$fa}]" {if $submit[$k][$fa]}checked="checked"{/if} value="1" />{$fa}<br />
                                                    {/foreach}
                                                {/if}
                                            {/if}
                                        </td>
                                    </tr>

                                    {/foreach}

                                    </tbody></table>

                            </td>
                        </tr>
                    </tbody>
                </table>

                <br />{$lang.notifyclient} <input name="notifyclient" value="yes" type="checkbox"/>
                {$lang.EnableAffiliate}  <input name="affiliate" value="yes" type="checkbox"/>


                {if count($currencies)>1}
                    {$lang.currency}:
                    <select name="currency_id" id="currency_id">
                        {foreach from=$currencies item=curre}
                            <option value="{$curre.id}" {if $curre.id=='0'}selected="selected"{/if}>{if $curre.code}{$curre.code}{else}{$curre.iso}{/if}</option>
                        {/foreach}
                    </select>
                {/if}


                {if $groups}
                    Group: <select name="group_id" id="group_id" >
                        <option value="0" >{$lang.none}</option>
                        {foreach from=$groups item=group}
                            <option value="{$group.id}" style="color:{$group.color}" {if $submit.group_id==$group.id}selected="selected"{/if}>{$group.name}</option>
                        {/foreach}
                    </select>
                {/if}
                {if $submit.ticket_id}
                    <input type="hidden" name="ticket_id" value="{$submit.ticket_id}" />
                {/if}
            </div>

            <div class="blu"><a href="?cmd=clients" ><strong>&laquo; {$lang.backtoclients}</strong></a>

                <input type="submit"  value="{$lang.registerclient}" style="font-weight:bold"/>
                <input type="button"  value="{$lang.Cancel}" onclick="window.location.href = '?cmd=clients'"/>

            </div> 
            {securitytoken}
        </form>

    </div>

</td></tr>
</table>