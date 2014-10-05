<script type="text/javascript">
    lang['deleteprofileheading']="{$lang.deleteprofileheading}";
    lang['convertclientheading']="{$lang.convertclientheading}";
</script>

<div class="blu">
    <div class="menubar">
        <a href="?cmd=clients&action=show&id={$parent.id}" >
			<strong>&laquo; {$lang.backtoclient}</strong>
		</a>
	{if $action=='showprofile'}
        <a   class=" menuitm menuf"  href="{$system_url2}?action=adminlogin&id={$client.client_id}" target="_blank">
			<span ><strong>{$lang.loginascontact}</strong></span>
		</a>
		<a   class=" menuitm menuc"  href="{$system_url2}?action=adminlogin&id={$parent.client_id}&redirect=%3Fcmd%3Dprofiles%26action%3Dedit%26id%3D{$client.id}" target="_blank">
			<span >{$lang.editprivileges}</span>
		</a>
		<a   class="menuitm clDropdown menul" id="hd1" onclick="return false"  href="#" >
			<span class="morbtn">{$lang.moreactions}</span>
		</a>
		<ul id="hd1_m" class="ddmenu">
            <li ><a href="SendNewPass">{$lang.SendNewPass}</a></li>
            <li ><a href="ConvertToClient">{$lang.converttoclient}</a></li>
            <li ><a href="DeleteContact" style="color:#ff0000">{$lang.deletecontact}</a></li>
        </ul>
	{/if}
    </div>
</div>

<form action='' method='post'>
    <input type="hidden" value="{$client.client_id}" name="id" id="client_id"/>
    <input type="hidden" value="{$parent.id}" name="parent_id" id="parent_id"/>
    <div id="ticketbody">
	{if $action=='showprofile'}
        <h1>#{$parent.id} <a href="?cmd=clients&action=show&id={$parent.id}">{$parent.firstname} {$parent.lastname}</a> {$lang.contact}: {$client.firstname} {$client.lastname}</h1>
        <div class="ticketmsg ticketmain" id="client_tab">
            <div class="slide" style="display:block">
                <div class="right replybtn tdetail" id="tdetail">
                    <strong>
                        <a href="#">
                            <span class="a1">{$lang.editdetails}</span>
                            <span class="a2">{$lang.hidedetails}</span>
                        </a>
                    </strong>
                </div>
                <div id="detcont">
                    <div >
                        <table border="0" width="98%" cellspacing="5" cellpadding="0">
                            {foreach from=$fields item=field key=k name=floop}
                            {if $smarty.foreach.floop.index%3==0}<tr>{/if}
                                <td  width="100" align="right" {*
                                     *}{if $field.type=='Company'}class="iscomp light" style="{if $client.company!='1'}display:none{/if}" {*
                                     *}{elseif $field.type=='Private'}class="ispr light" style="{if $client.company=='1'}display:none{/if}" {* 
                                     *}{else}class="light"{/if}>
                                    {if $k=='type'}
                                        {$lang.clacctype}
                                    {elseif $field.options & 1}
                                        {if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
                                    {else}
                                        {$field.name}
                                    {/if}:</td>
                                <td {*
                                    *}{if $field.type=='Company'}class="iscomp" style="{if $client.company!='1'}display:none{/if}" {*
                                    *}{elseif $field.type=='Private'}class="ispr" style="{if $client.company=='1'}display:none{/if}" {*
                                    *}{else}{/if} >
                                    {if $k=='type'}
                                    {elseif $k=='country'}
                                        <select name="country">
                                            {foreach from=$countries key=k item=v}
                                                <option value="{$k}" {if $k==$client.country} selected="Selected"{/if}>{$v}</option>
                                            {/foreach}
                                        </select>
                                    {else}
                                        {if $field.field_type=='Password'}
                                        {elseif $field.field_type=='Input'}
                                            <input  value="{$client[$field.code]}" name="{$field.code}" style="width: 80%;"/>
                                        {elseif $field.field_type=='Check'}
                                            {foreach from=$field.default_value item=fa}
                                                <input type="checkbox" name="{$field.code}[{$fa}]" value="1" {if in_array($fa,$client[$field.code])}checked="checked"{/if}/>{$fa}<br />
                                            {/foreach}
                                        {else}
                                            <select name="{$field.code}" style="width: 80%;">
                                                {foreach from=$field.default_value item=fa}
                                                    <option {if $client[$field.code]==$fa}selected="selected"{/if}>{$fa}</option>
                                                {/foreach}
                                            </select>
                                        {/if}
                                    {/if}</td>
                                {if $smarty.foreach.floop.index%3==5}</tr>{/if}
                            {/foreach}
                        <tr>
                            <td align="right" class="light">{$lang.newpass}:</td>
                            <td align="left"><input name="password" /></td>
                            <td align="right" class="light">{$lang.repeatpass}:</td>
                            <td align="left"><input name="password2" /></td>
                            <td align="right" class="light">{$lang.Status}:</td>
                            <td align="left" >
                                <select name="status">
                                    <option value="Active" {if $client.status=='Active'}selected="selected"{/if}>{$lang.Active}</option>
                                    <option value="Closed"{if $client.status=='Closed'}selected="selected"{/if}>{$lang.Closed}</option>
                                </select>
                                <input type="hidden" name="type" value="Private" />
                                <input type="hidden" id="currency_id" value="{$client.currency_id}" />
                                <input type="hidden" name="latefeeoveride" value="0" />
                                <input type="hidden" name="taxexempt" value="0" />
                                <input type="hidden" name="overideduenotices" value="1" />
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="light">{$lang.signupdate}:</td>
                            <td align="left">{$client.datecreated|dateformat:$date_format}</td>

                            <td  align="right" class="light">{$lang.clientlastlogin}:</td>
                            <td  align="left">{if $client.lastlogin == '0000-00-00 00:00:00'}{$lang.never}{else}{$client.lastlogin|dateformat:$date_format}{/if}</td>

                            <td  align="right" class="light">{$lang.From}:</td>
                            <td  align="left">{$client.ip} {$lang.Host}: {$client.host}</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    {elseif $action=='newprofile'}
			<h1>#{$parent.id} <a href="?cmd=clients&action=show&id={$parent.id}">{$parent.firstname} {$parent.lastname}</a> &raquo;  {$lang.addcontact}</h1>
			<input type="hidden" name="id" value="{$parent.id}" />
			<div id="client_tab" class="ticketmsg ticketmain">
			<table cellspacing="1" cellpadding="0" width="100%">
				<tbody>
					<tr>
						<td width="50%" valign="top">
							<table cellpadding="2" width="100%">
								<tbody>
								{foreach from=$fields item=field name=floop key=k}
									{if $smarty.foreach.floop.iteration > ($smarty.foreach.floop.total/2)}{break}{/if}
									<tr  
									{if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
									{elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" 
									{/if}>
										<td width="110" align="right">
										{if $k=='type'}
											{$lang.clacctype}
										{elseif $field.options & 1}
											{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
										{else}
											{$field.name}
										{/if}
										</td>
										<td>
										{if $k=='type'}
											<select  name="type" style="width: 80%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
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
								</tbody>
							</table>
						</td>
						<td width="50%" valign="top">
							<table cellpadding="2" width="100%">
								<tbody>
									{foreach from=$fields item=field name=floop key=k}
										{if $smarty.foreach.floop.iteration <= ($smarty.foreach.floop.total/2)}{continue}{/if}
									<tr 
										{if $field.type=='Company' && $fields.type}class="iscomp" style="{if !$submit.type || $submit.type=='Private'}display:none{/if}"
										{elseif $field.type=='Private' && $fields.type}class="ispr" style="{if $submit.type=='Company'}display:none{/if}" {/if}>
											<td width="110" align="right">
										{if $k=='type'}
											{$lang.clacctype}
										{elseif $field.options & 1}
											{if $lang[$k]}{$lang[$k]}{else}{$field.name}{/if}
										{else}
											{$field.name}
										{/if}
										</td>
										<td>
										{if $k=='type'}
											<select  name="type" style="width: 80%;" onchange="{literal}if ($(this).val()=='Private') {$('.iscomp').hide();$('.ispr').show();}else {$('.ispr').hide();$('.iscomp').show();}{/literal}">
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
								</tbody>
							</table>
						</td>
					</tr>
				</tbody>
			</table>
			</div>	
			{/if}
{literal}
	<style type="text/css">
	.pgroup{padding:0 0 20px 15px}
</style>
{/literal}
			<div id="client_tab" class="ticketmsg ticketmain">
			<div style="padding:5px 20px 0">
                {foreach from=$privilages item=privs key=group}
                    {foreach from=$privs item=privopt}{if !$privopt.displaygroup || $privoptdisplaygroup==group}{assign value=1 var=displaythis}{/if}{/foreach}
                    {if $displaythis!=1}{continue}{/if}
                    <h3><input type="checkbox" class="privilege " id="{$group}_main" onclick="cUnc(this,'{$group}')" />
                        <label for="{$group}_main" > {assign value="`$group`_main" var=groupmain}{$lang[$groupmain]}</label>
                    </h3>
                    <div class="pgroup mb20">
                        <table border="0" cellspacing="0" cellpadding="0" width="100%">
                            {counter name=trp print=false start=0 assign=trp}
                            {foreach from=$privs item=privopt key=priv name=loop}
                                {if $privopt.condition && !$privopt.condition|checkcondition}{continue}{/if}
                                {if $trp != 0 && $trp % 3 == 0}</tr>{/if}
                                {if $trp % 3 == 0}<tr>{/if}

                                <td width="33%">
                                    <input type="checkbox" class="privilege {$group}" id="{$group}_{$priv}"  value="1" name="privileges[{$group}][{$priv}]" {if $submit.privileges.$group.$priv}checked="checked"{/if}  /> 
                                    <label for="{$group}_{$priv}" {if $privopt.important}style="color:red"{/if}> 
                                        {assign value="`$group`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                    </label>
                                </td>
                                {counter name=trp}
                            {/foreach}
                            {assign value=0 var=displaythis}
                            {foreach from=$privilages item=privs2 key=group2}
                                {foreach from=$privs2 item=privopt key=priv name=loop}
                                {if $privopt.displaygroup == $group && (!$privopt.condition || $privopt.condition|checkcondition)}
                                    {if $trp != 0 && $trp % 3 == 0}</tr>{/if}
                                    {if $trp % 3 == 0}<tr>{/if}
                                        <td width="33%">
                                            <input type="checkbox" class="privilege {$group2}" id="{$group2}_{$priv}"  value="1" name="privileges[{$group2}][{$priv}]" {if $submit.privileges.$group2.$priv}checked="checked"{/if}  /> 
                                            <label for="{$group2}_{$priv}" {if $privopt.important}style="color:red"{/if}> 
                                                {assign value="`$group2`_`$priv`" var=grouppriv}{$lang[$grouppriv]}
                                            </label>
                                        </td>
                                    {counter name=trp}
                                {/if}
                                {/foreach}
                            {/foreach}
                            <tr></tr>
                        </table>
                    </div>
                {/foreach}

			 </div>
			</div>
			<script type="text/javascript">
{literal}

    function cUnc(el,target) {
        if($(el).is(':checked')) {
            $('.'+target).attr('checked','checked');
        } else {
            $('.'+target).removeAttr('checked');

        }
    }
        function loadProfile(val) {
            $('.privilege').removeAttr('checked');
                $('#priv_dom').show();
                $('#priv_serv').show();
            if(val==0) {
                return false;
                    }
            $.post('?cmd=profiles&action=loadpremade',{premade:val},function(response){
                if(response.all) {
                    $('.privilege').attr('checked','checked'); return;
                }
                    if(response.billing) {
                        if(response.billing.all) {
                            $('.billing').attr('checked','checked'); 
                        } 
                    }if(response.domains) {
                        if(response.domains.all) {
                            $('.domains').attr('checked','checked');
                        } 
                    }if(response.services) {
                        if(response.services.all) {
                            $('.services').attr('checked','checked');
                        } 
                    }if(response.support) {
                        if(response.support.all) {
                            $('.support').attr('checked','checked');
                        }
                    }
            });

                return false;
        }
 {/literal}
</script>
			{if $action=='showprofile'}
			<div class="p6 secondtd" style="margin-bottom:7px;padding:15px 0px;text-align:center;">
				<a class="new_control greenbtn" href="#" onclick="$('#clientsavechanges').click(); return false;"><span>{$lang.savechanges}</span></a>
				<input type="submit" value="{$lang.savechanges}" id="clientsavechanges" style="display:none" name="save"/>
			</div>
			{elseif $action=='newprofile'}
			<div class="blu">
				<a href="?cmd=clients&action=show&id={$parent.id}" ><strong>&laquo; {$lang.backtoclient}</strong></a> 
				<input type="submit" name="save" value="{$lang.addcontact}" style="font-weight:bold"/>
				<input type="button"  value="{$lang.Cancel}" onclick="window.location.href='?cmd=clients'"/>
			</div>
			{/if}
		</div>
{securitytoken}</form>