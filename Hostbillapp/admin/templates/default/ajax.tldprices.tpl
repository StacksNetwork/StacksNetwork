{if $action=='listprices'}

<tbody>
      <tr>
        <th>{$lang.TLD}</th>
                    <th>{$lang.Period}</th>
            <th>{$lang.Register}</th>
            <th>{$lang.Transfer}</th>
            <th>{$lang.Renew}</th>
                    {if $dnscharge>=0}<th>{$lang.DNSmanagement}</th>{/if}

    {if $emailcharge>=0}		<th>{$lang.Emailfwd}</th>{/if}
                    {if $idcharge>=0}<th>{$lang.IDprotection}</th>{/if}
                            <th>{$lang.donotrenew}</th>

                    <th>{$lang.Registrar}</th>


                    <th width="20"></th>
            <th width="20"></th>
            <th width="20"></th>
            <th width="20"></th>
		
		
       
      </tr>
	 
		
  {if $tlds}

 {foreach  from=$tlds item=tld name=cat key=k}
	{assign var=foo value=$k+1}
	  {if $tld.tld}
	  </tbody>
	  <tbody>
	  {/if}
	
	  <tr {if $tlds[$foo].tld}{else}class="nobordera"{/if}>
        <td align="center"><strong>{$tld.tld}</strong></td>
			
		<td class="evel">
            <select name="{$tld.id}[period]">
                {section name=foo loop=9} 
                    <option {if $smarty.section.foo.iteration == $tld.period}selected="selected"{/if}>{$smarty.section.foo.iteration}{if $smarty.section.foo.iteration == 1} 年{else} 年{/if}</option>
                {/section}
            </select></td>
            	
	   
        
          <td align="center" width="80"><input type="checkbox"  value="1"  name="{$tld.id}[register_on]" {if $tld.register>=0}checked="checked"{/if} onclick="check_i(this)"/> <input name="{$tld.id}[register]" {if $tld.register<0} value="0.00" disabled="disabled"{else} value="{$tld.register}"{/if} size="4" class="price"/></td>
		 
        <td align="center" class="evel" width="80"><input type="checkbox"  value="1"  name="{$tld.id}[transfer_on]"  {if $tld.transfer>=0}checked="checked"{/if} onclick="check_i(this)"/> <input name="{$tld.id}[transfer]" {if $tld.transfer<0} value="0.00" disabled="disabled"{else} value="{$tld.transfer}"{/if} size="4" class="price" /></td>
        <td align="center" width="80"><input type="checkbox"  value="1"   name="{$tld.id}[renew_on]" {if $tld.renew>=0}checked="checked"{/if} onclick="check_i(this)"/> <input name="{$tld.id}[renew]" {if $tld.renew<0} value="0.00" disabled="disabled"{else} value="{$tld.renew}"{/if}  size="4" class="price" /></td>
       
	   {if $tld.tld}
            	{if $dnscharge>=0}<td style="text-align:center" class="evel"><input type="checkbox" name="{$tld.id}[dns]" value="1" {if $tld.dns == 1}checked="checked"{/if} /></td>{/if}
               {if $emailcharge>=0} <td style="text-align:center"><input type="checkbox" name="{$tld.id}[email]" value="1" {if $tld.email == 1}checked="checked"{/if} /></td>{/if}
                {if $idcharge>=0}<td style="text-align:center" class="evel"><input type="checkbox" name="{$tld.id}[idp]" value="1" {if $tld.idp == 1}checked="checked"{/if} /></td>{/if}
                <td style="text-align:center"><input type="checkbox" name="{$tld.id}[not_renew]" value="1" {if $tld.not_renew == 1}checked="checked"{/if} /></td>
                <td align="center" class="evel">
                <select name="{$tld.id}[module]" onchange="check_module(this.value);">
                    <option value="0">{$lang.none}</option>
                    {foreach from=$modules item=module} 
                        <option {if $module.id == $tld.module}selected="selected"{/if}>{$module.module}</option>
                    {/foreach} 
					
					<option value="new" style="font-weight:bold" >{$lang.newmodule}</option>
                </select>            
                </td>
            {else}
            	{if $dnscharge>=0}<td class="evel"></td>{/if}
				{if $emailcharge>=0}<td ></td>{/if}
				{if $idcharge>=0}<td class="evel"></td>{/if}
				<td></td><td class="evel"></td>
            {/if}
	{if $tld.tld}
	<td>
		<input type="hidden" name="sort[]" value="{$tld.id}" />
		 {if !$smarty.foreach.cat.first}<a href="javascript:void(0);" onclick="sortit(this,'up')"  class="upsorter">Up</a>{/if}</td>
        <td> {if !$smarty.foreach.cat.last}<a href="javascript:void(0);" onclick="sortit(this,'down')"  class="downsorter">Down</a>{/if}</td>
        
		{else}
		<td></td>		
		<td></td>
		{/if}
		
		<!--<td><a href="?cmd=ticketdepts&make=delete&id={$dept.id}&security_token={$security_token}" class="delbtn" onclick="return confirm('Are you sure you want to delete this dept?');">Delete</a></td>-->
		 <td><input type="submit" value="{$lang.Save}" name="save[{$tld.id}]" /></td>
            <td><a href="?cmd=tldprices&delete[{$tld.id}]&security_token={$security_token}" onclick="return confirm('{$lang.deletetldconfirm}');" class="delbtn">删除</a></td>
      </tr>
	  	{/foreach}
		 </tbody>
		{/if}
	   
		  <tbody>
		  	<th colspan="14" style="text-align:center">{$lang.ADDNEW}</th>
			<tr>
        <td ><input name="new[tld]" size="5" /></td>
		 <td class="evel">
        <select name="new[period]">
                {section name=foo loop=9} 
                    <option>{$smarty.section.foo.iteration}{if $smarty.section.foo.iteration == 1} {$lang.Year}{else} {$lang.Years}{/if}</option>
                {/section}
            </select></td>
        <td><input type="checkbox"  value="1"  name="new[register_on]" onclick="check_i(this)" checked="checked"/> <input name="new[register]" value="0.00" size="4" class="price"/></td>
        <td class="evel"><input type="checkbox"  value="1"  name="new[transfer_on]" onclick="check_i(this)" checked="checked"/> <input name="new[transfer]" value="0.00" size="4" class="price"/></td>
        <td><input type="checkbox"  value="1"  name="new[renew_on]" onclick="check_i(this)" checked="checked"/> <input name="new[renew]" value="0.00" size="4" class="price"/></td>
       {if $dnscharge>=0} <td style="text-align:center" class="evel"><input type="checkbox" name="new[dns]" value="1" /></td>{/if}
       	{if $emailcharge>=0} <td style="text-align:center"><input type="checkbox" name="new[email]" value="1" /></td>{/if}
       	{if $idcharge>=0} <td style="text-align:center" class="evel"><input type="checkbox" name="new[idp]" value="1" /></td>{/if}
        <td style="text-align:center"><input type="checkbox" name="new[not_renew]" value="1" /></td>
        <td class="evel"><select name="new[module]">
                {foreach from=$modules item=module} 
                    <option>{$module.module}</option>
                {/foreach}
            </select></td>
       
            
            <td colspan="4"><input type="submit" value="{$lang.Add}" name="add" /></td>
        </tr>
		  </tbody>
		  
		  
		  {/if}