{if $action=='default'}
    {foreach from=$logs item=log}
        <tr>
            <td>{$log.id}</td>
            <td>{$log.date|dateformat:$date_format}</td>
            <td><strong>{$log.module}</strong></td>
            <td width="60%">
{*			<a href="#" onclick="$(this).hide().next().show();return false">{$lang.showdetails}</a>						*}
				<div style="max-height:100px; overflow:auto">
					<div style="{*display:none;*} white-space: pre; font-size:8pt;">{$log.output}</div>
				</div>
			</td>
            <td><span class="{$log.result}">{$lang[$log.result]}</span></td>
        </tr>
    {/foreach}
{elseif $action=='getadvanced'}

<a href="?cmd=gtwlog&resetfilter=1"  {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
<form class="searchform filterform" action="?cmd=gtwlog" method="post" onsubmit="return filter(this)">
  <table width="100%" cellspacing="2" cellpadding="3" border="0">
    <tbody>
    <tr>
    <td width="15%">{$lang.Result}</td>
      <td ><select name="filter[result]">
          <option value="">{$lang.anyresult} </option>
          <option value="Successfull">{$lang.Successfull}</option>
          <option value="Pending">{$lang.Pending}</option>
          <option value="Failure">{$lang.Failure}</option>

        </select></td>

        <td>{$lang.Output}:</td><td> <input type="text" value="{if $currentfilter.output}{$currentfilter.output}{/if}" name="filter[output]" /></td>
    </tr>
    <tr>
      <td >{$lang.Gateway}</td>
      <td ><select name="filter[module]">
            <option value="">{$lang.allgateways}</option>
         {foreach from=$paymentmodules key=id item=module}
			<option value="{$id}" {if $currentfilter.module==$id}selected="selected"{/if}>{$module}</option>
		 {/foreach}
        </select></td>
        <td width="15%">{$lang.Date}</td>
        <td ><input type="text" value="{if $currentfilter.date}{$currentfilter.date|dateformat:$date_format}{/if}" size="15" name="filter[date]" class="haspicker"/></td>
    </tr>
    <tr>
        <td colspan="6"><center>
            <input type="submit" value="{$lang.Search}" />
            &nbsp;&nbsp;&nbsp;
            <input type="submit" value="{$lang.Cancel}" onclick="$('#hider2').show();$('#hider').hide();return false;"/>
          </center></td>
      </tr>
    </tbody>
  </table>
{securitytoken}</form>
<script type="text/javascript">bindFreseter();</script>

{/if}
