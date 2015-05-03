{if $tplname != 'default'}
<style>
{literal}
table.table{
    border: 1px solid #ccc
}
table.table th{
    background-color:#e5e5e5;
    background-image: -moz-linear-gradient(top , #f0f0f0, #e5e5e5);
    background-image: -webkit-linear-gradient(top , #f0f0f0, #e5e5e5);
    background-image: linear-gradient(top , #f0f0f0, #e5e5e5);
    background-repeat: repeat-x;
    padding: 8px
}
{/literal}

</style>
{/if}
<h1 class="gears2">{if $act=="editdomain"}{$lang.dnsedit}: {$domain}{else}{$lang.dnsmanagement|capitalize}{/if}</h1>
<br />
{if $act=="editdomain"}
<a href="?cmd=module&amp;module={$module_id}" style="font-weight: bold">&laquo; 返回</a>
<form action='' method="post" class="form-horizontal">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped table-bordered styled">
        <tbody>
            <tr>
                <th>{$lang.name}</th>
				<th>TTL</th>
				<th width="30"/>
                <th>{$lang.type}</th>
                <th>{$lang.data}</th>
				<th width="30"/>
            </tr>
        </tbody>
        <tbody>
            {if $dnsentries}
                {foreach from=$dnsentries item=entry key=line}
					<tr>{if $entry.type == 'SOA'}
						<td style="padding-left:7px">{$entry.name}</td>
						<td style="padding-left:5px">{$entry.ttl}</td>
						<td></td>
						<td align="center">{$entry.type}</td>
						<td align="left" style="padding-left:1em">{$entry.data.mname} {$entry.data.rname} (<br />
						&nbsp;&nbsp;&nbsp;&nbsp;{$entry.data.serial}; 序号<br />
						&nbsp;&nbsp;&nbsp;&nbsp;{$entry.data.refresh}; 刷新<br />
						&nbsp;&nbsp;&nbsp;&nbsp;{$entry.data.retry}; 重试<br />
						&nbsp;&nbsp;&nbsp;&nbsp;{$entry.data.expire}; 过期<br />
						&nbsp;&nbsp;&nbsp;&nbsp;{$entry.data.minimum} ); 最小TTL<br />
							
						</td>
						<td></td>
						{elseif $entry.type == 'NS'}
						<td style="padding-left:7px">{$entry.name}</td>
						<td style="padding-left:5px">{$entry.ttl}</td>
						<td></td>
						<td align="center">{$entry.type}</td>
						<td align="left" style="padding-left:1em">{$entry.data.0}</td>
						<td></td>
						{else}
						<td align="left"><input name="record[{$line}][name]" value="{$entry.name}" size="25" class="styled span3"></td>
						<td align="left"><input name="record[{$line}][ttl]" value="{$entry.ttl}" size="6" class="styled span1"></td>
						<td align="left"><input type="hidden" value="record[{$line}]" ></td>
						<td class="dnsz" align="left" >
							<select class="span2" name="record[{$line}][type]" onchange="setfields(this.name,this.value);" >
								<option {if $entry.type == 'A'}selected="selected"{/if}>A</option>
								<option {if $entry.type == 'A6'}selected="selected"{/if}>A6</option>
								<option {if $entry.type == 'AAAA'}selected="selected"{/if}>AAAA</option>
								<option {if $entry.type == 'AFSDB'}selected="selected"{/if}>AFSDB</option>
								<option {if $entry.type == 'CNAME'}selected="selected"{/if}>CNAME</option>
								<option {if $entry.type == 'DNAME'}selected="selected"{/if}>DNAME</option>
								<option {if $entry.type == 'DS'}selected="selected"{/if}>DS</option>
								<option {if $entry.type == 'HINFO'}selected="selected"{/if}>HINFO</option>
								<option {if $entry.type == 'LOC'}selected="selected"{/if}>LOC</option>
								<option {if $entry.type == 'MX'}selected="selected"{/if}>MX</option>
								<option {if $entry.type == 'NAPTR'}selected="selected"{/if}>NAPTR</option>
								{* <option {if $entry.type == 'NS'}selected="selected"{/if}>NS</option> *}
								<option {if $entry.type == 'PTR'}selected="selected"{/if}>PTR</option>
								<option {if $entry.type == 'RP'}selected="selected"{/if}>RP</option>
								<option {if $entry.type == 'SRV'}selected="selected"{/if}>SRV</option>
								<option {if $entry.type == 'TXT'}selected="selected"{/if}>TXT</option>
							</select>
						</td>
						<td align="left" style="width:760px" >
							{foreach from=$entry.data item=value key=field}
							<input style="display:none" name="record[{$line}][data][{$field}]" value="{$value|escape:'html'}" >
							{/foreach}
						</td>
						<td align="center">
                            <a class="btn btn-mini" href="?cmd=module&amp;module={$module_id}&amp;act=editdomain&amp;id={$domainid}&amp;deleteline={$line}" onclick="return confirm('{$lang.confirm_delrecord}')">{$lang.delete}</a>
                        </td>
						{/if}
					</tr>
                {/foreach}
            {/if}
            <tr><th colspan="6">{$lang.newrecord}</th></tr>
            {foreach from=$forworkaround item=newi}
		    <tr>
				<td align="left"><input name="record[new][{$newi}][name]" type="text" size="30" ></td>
				<td align="left"><input name="record[new][{$newi}][ttl]" type="text" value="14400" size="6" ></td>
				<td align="left"><input type="hidden" value="record[new][{$newi}]"><span style="font-family: monospace">IN</span></td>
				<td class="dnsz" align="center">
					<select class="span2" name="record[new][{$newi}][type]" >
						<option value="">选择</option>
						<option>A</option>
						<option>A6</option>
						<option>AAAA</option>
						<option>AFSDB</option>
						<option>CNAME</option>
						<option>DNAME</option>
						<option>DS</option>
						<option>HINFO</option>
						<option>LOC</option>
						<option>MX</option>
						<option>NAPTR</option>
						{*<option>NS</option>*}
						<option>PTR</option>
						<option>RP</option>
						<option>SRV</option>
						<option>TXT</option>
					</select>
				</td>
				 <td align="left" colspan="2" id="input{$newi}">

				</td>
			</tr>
			{/foreach}
        </tbody>
    </table>
            <center><input type="submit" name="save" value="{$lang.save}" style="font-weight:bold;"  class="btn btn-primary btn-large"/></center>
    </form>


{elseif $act=='default'}
        {if $nameservers}
            <p>{$lang.nsinfo}</p>
            <ul style="margin:0px;" class="unstyled">
                {foreach from=$nameservers item=ns}
                    <li style="display: block">{$ns.name} {if $ns.ip!=''}- {$ns.ip} {/if}</li>
                {/foreach}
            </ul>
            <br />
        {/if}
        <p class="left">
            <a class="btn" href="?cmd=module&amp;module={$module_id}&amp;act=adddomain" onclick="$('#adddomain').show(); $(this).hide(); return false;" {if $submit}style="display:none"{/if} id="adder" >
                {$lang.newdomain}
            </a>
        </p>
        <div id="adddomain" {if !$submit}style="display:none"{/if} >
                <form action="" method="post" class="form-horizontal">
                    <table width="100%" cellspacing="5" cellpadding="0" class="table table-striped table-condensed">
                        <tr>
							<td width="10%">{$lang.domain}: </td>
							<td><input name="newdomain" value="{$submit.newdomain}" size="30" class="styled"/></td>
						</tr>
                        <tr>
							<td width="10%">{$lang.dnsip}: </td><td>
                            {if $ips}
                        <select name="ip" onchange="check_ip(this)">
                                {foreach from=$ips item=ip}
                                    <option {if $submit.ip == $ip}selected="selected"{/if}>{$ip}</option>
                                {/foreach}
                            <option value="custom" {if $submit.ip == "custom"}selected="selected"{/if}>{$lang.different_ip}</option>
                        </select>
                            {else}
							<input type="hidden" value="custom" name="ip" />{/if}&nbsp;
							<input name="custom_ip" id="custom_ip" value="{$submit.custom_ip}" {if $ips && $submit.ip != "custom" }style="display: none"{/if} /></td></tr>
                        <tr><td colspan="2">
						<input type="submit" style="font-weight: bold" value="{$lang.adddomain}" name="adddns" class="padded btn btn-primary"/>
						<input type="submit" value="{$lang.cancel}" onclick="$('#adder').show(); $('#adddomain').hide(); return false;"  class="padded btn"/>
                    </table>
                </form>
                <script type="text/javascript">
                {literal}
                    function check_ip(elem) {
                        if($(elem).val() == 'custom')
                            $('#custom_ip').show();
                        else
                             $('#custom_ip').hide();
                    }
                {/literal}
                </script>
        </div>
    {if $dnsdomains}
    <p align="right"> {$lang.page}
    <select name="page" id="currentpage" class="span1">
        {section name=foo loop=$totalpages.totalpages}
        <option value='{$smarty.section.foo.iteration-1}'>{$smarty.section.foo.iteration}</option>
        {/section}
     </select>
    {$lang.pageof}<strong> {$totalpages.totalpages}</strong>
    </p>
    <a href="?cmd=module&amp;module={$module_id}" id="currentlist" style="display:none" updater="#updater"></a>
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="table table-striped table-condensed styled">
        <tbody>
            <tr>
                <th>{$lang.domain}</th>
                <th width="50"></th>
            </tr>  
        </tbody>
        <tbody id="updater">
            {foreach from=$dnsdomains item=domain name=foo}
                <tr {if $smarty.foreach.foo.index%2 == 0}class="even"{/if}>
                    <td>
                        <a href="?cmd=module&amp;module={$module_id}&amp;act=editdomain&amp;id={$domain.id}">{$domain.domain}</a>
                    </td>
                    <td  align="center">
                        <a href="?cmd=module&amp;module={$module_id}&amp;deletedomain={$domain.id}" onclick="return confirm('{$lang.confirm_deldomain}')">{$lang.delete}</a>
                    </td>
                </tr>
            {/foreach}
        </tbody>
    </table>
    <br />

    {else}
        <p style="text-decoration: italic; text-align: center">没有找到域名</p>
    {/if}
{/if}	
