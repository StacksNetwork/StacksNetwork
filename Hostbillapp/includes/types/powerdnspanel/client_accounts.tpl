<link media="all" type="text/css" rel="stylesheet" href="{$system_url}includes/types/powerdnspanel/style.css" />
<style type="text/css">{literal} 
	.icons ul{list-style:none}
	.icons ul li.disabled a span {  color: #C0C0C0;}
	.icons ul li a span {color: #333333; display: block; font: 11px Tahoma,sans-serif;}
	.icons > ul > li > a { border: 1px solid #F1F1F1;  border-radius: 5px 5px 5px 5px; display: block;  min-height: 61px;  padding: 5px;  text-decoration: none;}
	.icons > ul > li.disabled {  opacity: 0.6; cursor:auto}
	.icons > ul > li.disabled a{cursor:default}
	.icons ul li { display: inline-block; margin: 0 20px 20px 0; text-align: center; vertical-align: top; width: 80px; position:relative}
	.styled tbody{text-align: center;}
	.icons .dwarrow { background: url("{/literal}{$template_dir}{literal}icons/arrow-turn-270-left.png") no-repeat scroll 5px 43px transparent;  font-size: 18px; font-weight: normal;  letter-spacing: -1px !important;line-height: 20px; padding: 35px 25px 15px;}
	.cbreadcrumb {background:#FFF}
	#more_list{position:absolute;right: 0;top: 74px; width: 300px; ;padding:1em 0 0 0; border:solid 1px #eee; background:#fff; border-radius: 5px 0 5px 5px;z-index:200}
	#more_list li{ display: block; float: right; height: 2em; margin: 0; padding:6px 1em 0 ; width: 120px;}
	#more_list li:hover{background:#eee}
	#more_list li a{text-decoration:none}
	.recordbox {min-height: 30px; padding: 5px;}
	.recordbox label {clear: both; display: block; float: left; width: 100px;}
	.recordbox input, .recordbox select {display: block; float: left; min-width:150px}
	.recordbox select{ min-width:160px}
	.recordbox input.owname{display:none}
	#contentbox input {float:none; display:inline; margin:0 5px 5px 0}
	#contentbox {margin-left:100px}
	.autorefreash {background:url('{/literal}{$template_dir}{literal}img/arrow_refresh_small.gif') no-repeat center center; padding: 0 6px; }
	.autorefreash.off {opacity:0.3}
	.nslist {clear:both; margin:20px 10px 0;  width: 500px;}
	.pricing {text-align:right;padding:10px; float:right}
	
</style>
{/literal}
{if $act=='dns_manage' || $act=='add_record' || $act=='edit_record'}
<script type="text/javascript">{literal}
	var types = { 
		'A' : [['Ip','IP Address, as a decimal dotted quad string, for example: \'213.244.168.210\' ']],
		'NS' : [['Target nameserver hostname','Delegate this domain to use given nameserver ']],
		'AAAA':[['IPv6', 'IPv6 address. An example: \'3ffe:8114:2000:bf0::1\'. ']], 
		'CNAME':[['Hostname', 'Specifies the canonical name of a record. An example: \'webserver-01.yourcompany.com\'']], 
		'DNAME':[['Hostname']], 
		'PTR':[['Hostname', 'Reverse pointer, used to specify the host name belonging to an IP or IPv6 address. An example:  \'www.powerdns.com\'']], 
		'TXT':[['Text','The TXT field can be used to attach textual data to a domain']], 
		'SPF':[['Text','Used to store Sender Permitted From details']], 
		'MX':[['Hostname','Specifies a mail exchanger host for a domain.']],
		'AFSDB':[['Subtype'], ['Hostname']],
		'HINFO':[['Hardware info'], ['Software info']],
		'NSEC':[['Next Domain Name'], ['Type Bit Maps']],
		'RP':[['Email address with no at sign'], ['TXT pointer for more info']],
		'A6':[['Prefix len.'], ['Address'], ['Prefix name']],
		'SSHFP':[['Algorithm '], ['Fp-Type'], ['Fingerprint']],
		'SOA':[['Primary NS'], ['Email address','Use dot instead of @ sign'], ['Serial number'], ['Refresh','Indicates the time in seconds, when the slave will try to refresh the zone from the master'], ['Retry','Defines the time in seconds between retries if the slave (secondary) fails to contact the master when refresh (above) has expired.'], ['Expiry','Indicates when the zone data is no longer authoritative in seconds.'], ['Minimum TTL']],
		'DNSKEY':[['Flags'], ['Protocol'], ['Algorithm'], ['Public Key']],
		'KEY':[['Flags'], ['Protocol'], ['Algorithm'], ['Public Key ']],
		'DS':[['Key tag'], ['Algorithm'], ['Digest Type'], ['Digest',]],
		'CERT':[['Type'], ['Key tag'], ['Algorithm'], ['Certificate ']],
		'SRV':[['Priority'], ['Weight'], ['Port'], ['Hostname']], 
		'LOC':[['Latitude'], ['Longitude'], ['Altitude'],['Size'], ['Horizontal Precision'], ['Vertical Precision']], 
		'NAPTR':[['Order'], ['Preferences'], ['Flags'], ['Service'], ['Regex'], ['Hostname']],
		'RRSIG':[['Type Covered'], ['Algorithm'], ['Labels'], ['Original TTL'], ['Signature Expiration'], ['Signature Inception'], ['Key Tag'], ['Signer\'s Name'], ['Signature']]
	};
</script>{/literal}
{/if}
{if $act=='add_domain'}
<script type="text/javascript">{literal}
$(function() {
	$('.cbreadcrumb').children(':last').wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />').end().append(' » <strong>{$lang.newdomain}{literal}</strong>')
});
function sh_option(val)  {
    $('.sh_option').hide();
    $('#option_'+val).show();
}


{/literal}
</script>
	<form action="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_domain" method="POST">
            <div class="wbox"><div class="wbox_header"><strong>Add new zone</strong></div>
		<div class="wbox_content">
                    <table width="98%" cellspacing="0" border="0" class="checker">
                        <tr>
                            <td width="145"><b>Domain name:</b></td>
                            <td><input type="text" name="domain" value="" class="styled" style="font-size:16px"/></td>
                            <td style="color:#808080">{$lang.enter_domain_name} 'example.com'</td>
                        </tr>
                        {if $user_domains || $dns_templates}<tr>
                            <td>Zone contents</td>
                            <td colspan="2">
                                <input type="radio" checked="checked" name="postaction" value="none" onclick="sh_option(0)" id="val1" /> <label for="val1"> I will add entries manually <a title="After adding new zone you will be able to add/edit its contents" class="vtip_description"></a></label> <br/>
                               {if $user_domains} <input type="radio" name="postaction" value="clone"  onclick="sh_option(1)" id="val11" /> <label for="val11">Clone entries from other domain  <a title="New domain zone will contain entries cloned from domain you already own" class="vtip_description"></a></label><br/> {/if}
                                <input type="radio" name="postaction" value="premade"  onclick="sh_option(2)"  id="val111" /> <label for="val111">Use premade DNS template  <a title="Use one of available, pre-configured DNS templates" class="vtip_description"></a></label> <br/>
                            </td>
                        </tr>
                        {/if}
                        {if $user_domains}  <tr id="option_1" style="display:none" class="sh_option">
                            <td>{$lang.clone_zone} </td>
                            <td colspan="2"><select name="clone" style="width: 180px;">
			{foreach from=$user_domains item=domain}
                                    <option value="{$domain.rawoutput}">{$domain.output}</option>
			{/foreach}

                                </select> <input type="checkbox" name="clonenames"  id="clonenames" value="1" checked="checked" /> <label for="clonenames">Replace record content (i.e. CNAME's) as well  <a title="With this option enabled cloned zone contents will be replaced with this domain name.<br>
                                                                                                                                                                                                   I.e. original: mail.test.com. IN MX 0 test.com,<br/> new domain: mail.newdomain.com. IN MX 0 newdomain.com" class="vtip_description"></a></label>
                            </td>
                        </tr>{/if}
                         {if $dns_templates}  <tr id="option_2" style="display:none" class="sh_option">
                             <td>DNS Template</td>
                    <td colspan="2"><select name="dns_template" style="width: 180px;" id="dns_tpl" onchange="$('.dns_id').hide();$('#dns_id_'+$(this).val()).show();">
			{foreach from=$dns_templates item=template key=name}
                            <option value="{$template[0].id}">{$template[0].template}</option>
                        {/foreach}

                                </select> <a href="#" onclick="$('#dns_preview').show();$('#dns_id_'+$('#dns_tpl').val()).show();$(this).hide();return false">Preview</a>
                            </td>
                        </tr>
                        <tr id="dns_preview" style="display:none">
                            <td></td>
                            <td colspan="3">
                                {foreach from=$dns_templates item=template key=tid name=floop}
                                <div class="dns_id" id="dns_id_{$template[0].id}" style="display:none;">
                                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                                        <thead >
                                            <tr>
                                                <th>{$lang.name}</th>
                                                <th>TTL</th>
                                                <th>Priority</th>
                                                <th>{$lang.type}</th>
                                                <th>Content</th>
                                            </tr>
                                        </thead>

                                        <tbody >
                                            {foreach from=$template item=record}
                                            <tr>
                                                <td>{$record.name}</td>
                                                <td>{$record.ttl}</td>
                                                <td>{$record.prio}</td>
                                                <td>{$record.type}</td>
                                                <td>{$record.content}</td>
                                            </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>

                                {/foreach}
                            </td>
                        </tr>
                        {/if}

                       <tr>
                           <td align="center" colspan="3" style="border-bottom:none">
                <input type="submit" name="submit" class="btn btn-primary"  value="Submit" style="padding:4px 3px;font-weight:bold;font-size:12px"/> &nbsp; or &nbsp; <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" class="editbtn">{$lang.cancel}</a>
                                
                            </td>

                        </tr>

                    </table>

                    </div>
</div>
		
	
		
	</form>
{elseif $act=='clone_record'}
<script type="text/javascript">{literal}
$(function() {
	$('.cbreadcrumb').children(':last').wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />').end().append(' » <strong>Clone{literal}</strong>')
});{/literal}
</script>
<form action="" method="POST"><div class="wbox">
	<div class="wbox_header"><strong>{$lang.clone_zone}</strong></div>
	<div class="wbox_content">
		<label>From:</label><select name="clone">
			<option>---</option>
			{if $user_domains}
			{foreach from=$user_domains item=domain}
				<option value="{$domain.id}">{$domain.name}</option>
			{/foreach}
			{/if}
		</select>
                <input type="checkbox" name="clonenames"  id="clonenames" value="1" checked="checked" /> <label for="clonenames">Replace record content (i.e. CNAME's) as well  <a title="With this option enabled cloned zone contents will be replaced with this domain name.<br>
                  
                                                                                                                                                                                   
                                                                                                                                                                                   I.e. original: mail.test.com. IN MX 0 test.com,<br/> new domain: mail.newdomain.com. IN MX 0 newdomain.com" class="vtip_description"></a></label>
        <center><input type="submit" name="submit" class="btn btn-primary"  value="Submit" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
	<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.cancel}</a></center>
	</div>
        </div><div class="wbox">
	<div class="wbox_header">{$lang.bulkdomains}</div>
	<div class="wbox_content">
		{foreach from=$sected_domains item=domain name=row}
		<div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.id}" name="dom[]" checked="checked"/> 
			{$domain.name}
		</div>
		{/foreach}
	</div> 
	<input type="submit" name="submit" class="btn btn-primary"  value="{$lang.shortsave}" /> &nbsp; &nbsp; <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.cancel}</a>
        </div>
</form>
{elseif $act=='add_record'}
	
<script type="text/javascript">{literal}
$(function() {
	$('.cbreadcrumb').children(':last')
		.wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />')
	.end()
		.append(' {if $domid} » <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domid}"><strong>{$domname}</strong></a>{/if}{literal} » <strong>Add record</strong> ')
	
	var type = $('#type').val();
	var ht;
	if(types[type]!==undefined){
		for(var i=0;i<types[type].length;i++){
			ht = '<input name="content['+i+']" type="text" class="styled" > ';
			ht += types[type][i][0];
			if(types[type][i][1]!==undefined)
				ht += '<a class="vtip_description" title="'+types[type][i][1]+'"></a>';
			ht += '<br>';

			if(i==0) $('#contentbox').html(ht);
			else $('#contentbox').append(ht);
		}
	}
});
	
</script>
{/literal}
<form action="" method="POST">
		<input id="type" type="hidden" name="type" value="{$r_type}" />
		{if $domid}<input type="hidden" name="dom" value="{$domid}" />{/if}
		

                <div class="wbox">
                    <div class="wbox_header"><strong>Add new '{$r_type}' record</strong></div>



                    <div class="wbox_content">
                        <div class="recordbox">
                            <label>Name:</label>
			{if $sected_domains}
                            <a href="#" class="editbtn" onclick="$('.owname').show();$(this).hide();$('input[name=\'namesover\']').val('1');return false">
				Default names
                            </a>
                            <input type="hidden" value="0" name="namesover" >
			{/if}
                            <input type="text" name="name" value="" class="styled {if $sected_domains}owname{/if}" />
                        </div>
                        <div class="recordbox">
                            <label>TTL</label>
                            <select class="styled" name="ttl" >
                                <option value="3600">1 Hour</option>
                                <option value="43200">12 Hours</option>
                                <option value="86400">24 Hours</option>
                                <option value="172800">48 Hours</option>
                            </select> <a class="vtip_description" title="TTL settings define the frequency of website content updates."></a>
                        </div>
		{if $r_type == 'MX'}
                        <div class="recordbox">
                            <label>Priority</label>
                            <input type="text" name="prio" value="0" class="styled" /> <a class="vtip_description" title="Priority settings for mail exchanger record, the lower preference number is the higher priority."></a>
                        </div>
		{/if}
                        <div class="recordbox">
                            <label>Content</label>
                                <div id="contentbox">

                            </div>
                        </div>
                <center><input type="submit" class="btn btn-primary" name="submit" value="Submit" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
	<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.cancel}</a></center>
                    </div></div>

                {if $sected_domains}<div class="wbox">
		<div class="wbox_header">{$lang.bulkdomains}</div>
		<div class="wbox_content">
			{foreach from=$sected_domains item=domain name=row}
			<div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.id}" name="dom[]" checked="checked"/>
				{$domain.name}
			</div>
			{/foreach}
		</div>
                
        </div>
	{/if}
	
</form>
	
{elseif $act=='edit_record'}
	
<script type="text/javascript">{literal}
$(function() {
	$('.cbreadcrumb').children(':last')
		.wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />')
	.end()
		.append(' » <strong>All</strong>{if $domid} » <a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domid}"><strong>{$domname}</strong></a>{/if}{literal}')
	
	var type = $('#type').val();
	var ht;
	if(types[type]!==undefined){
		for(var i=0;i<types[type].length;i++){
			ht = types[type][i][0];
			if(types[type][i][1]!==undefined)
				ht += '<a class="vtip_description" title="'+types[type][i][1]+'"></a>';
			$('input[name="content['+i+']"]').after(ht);
		}
	}
	
});
</script>
{/literal}
<form action="" method="POST">
    <input id="type" type="hidden" name="type" value="{$record.type}" />
    <input type="hidden" name="dom" value="{$domid}" />

    <div class="wbox">
        <div class="wbox_header"><strong>{$lang.edit} record</strong></div>



        <div class="wbox_content">

            <div class="recordbox">
                <label>Name:</label>
                <input type="text" name="name" value="{$record.name}" class="styled" />
            </div>
            <div class="recordbox">
                <label>TTL</label>
                <select class="styled" name="ttl" >
                    <option {if $record.ttl == '3600'}selected="selected"{/if} value="3600">1 Hour</option>
                    <option {if $record.ttl == '43200'}selected="selected"{/if}value="43200">12 Hours</option>
                    <option {if $record.ttl == '86400'}selected="selected"{/if} value="86400">24 Hours</option>
                    <option {if $record.ttl == '172800'}selected="selected"{/if} value="172800">48 Hours</option>
                </select> <a class="vtip_description" title="TTL settings define the frequency of website content updates."></a>
            </div>
		{if $r_type == 'MX'}
            <div class="recordbox">
                <label>Priority</label>
                <input type="text" name="prio" value="{$record.prio}" class="styled" /> <a class="vtip_description" title="Priority settings for mail exchanger record, the lower preference number is the higher priority."></a>
            </div>
		{/if}
            <div class="recordbox">
                <label>Content</label>
                <div id="contentbox">
				{foreach from=$record.content item=content key=ky}
                    <input type="text" name="content[{$ky}]" class="styled" value="{$content}" /> <br>
				{/foreach}
                </div>
            </div>
           <center><input type="submit" class="btn btn-primary" name="submit" value="Submit" style="padding:4px 3px;font-weight:bold;font-size:12px" /> &nbsp; &nbsp;
	<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/">{$lang.cancel}</a></center>
        </div></div> 
</form>
{elseif $act=='default'}
	{if $service.status=='Active'}
<script type="text/javascript">{literal}
	$(function() {
            if($('#cont').length) {
                var ch = $('#more_list').parents('#cont').height()
		while($('#more_list').height() > ch)
			$('#more_list').width($('#more_list').width()+1);
            }
			

		$('.idchecker').click(function(){
			if($('.idchecker:checked').length < 1)
				unbind_ico();
			else
				bind_ico();
		});
		unbind_ico();
			
		$(document).click(function(event) {
			if($('#more_list:visible').length && !$(event.target).parents('#more_icon').length && !$(event.target).is('#more_icon').length ) {
				 $("#more_list").hide();
			}
		});
	});
	function switchRenew(el,id){
		ajax_update("{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/{literal}",{did:id, make:'renewstate',state:$(el).hasClass('off')?1:0},function (a){
				$(el).toggleClass('off');
			});
		return false;
	}
	function bind_ico(){
		$('.icons ul a:[href]').unbind().click(function(){
			var ids = $('.idchecker:checked').serialize();
			if(ids=='') {
				return false;
			}
			window.location = $(this).attr('href')+'&'+ids;
			return false; 	
		});
		$('.icons > ul > li > a:last').unbind().click(function(){
			$('#more_list').toggle();
		});
		$('.icons > ul > li').removeClass('disabled');
	}
	function unbind_ico(){
		$('.icons > ul > li > a:last').unbind().click(function(){return false});
		$('.icons ul a:[href]').unbind().click(function(){return false});
		$('.icons > ul > li').addClass('disabled');
	}
</script>
{/literal}
{if $widget.appendtpl}
    {include file=$widget.appendtpl}
{/if}

<div class="icons">
	<div class="left dwarrow">{$lang.withdomains}</div>  

	<ul class="right">
		{if $dns_templates}<li class="disabled">
			<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_templates" >
				<img src="includes/types/powerdnspanel/icons/ico-renew.png" alt="">
				<span>DNS Templates</span>
			</a>
		</li> {/if}
		<li class="disabled">
			<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&type=A" >
				<img src="includes/types/powerdnspanel/icons/ico_domains2.jpg" alt="">
				<span>Add A record</span>
			</a>
		</li> 
		<li class="disabled">
			<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&type=MX" >
				<img src="{$type_dir}icons/email_foward.png" alt="">
				<span>Add MX entry</span>
			</a>
		</li>
		<li class="disabled">
			<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&type=CNAME" >
				<img src="{$type_dir}icons/foward.png" alt="">
				<span>Add new Alias Name</span>
			</a>
		</li>
		<li class="disabled">
			<a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=clone_record" >
				<img src="{$type_dir}icons/ico_invoices2.jpg" alt="">
				<span>Clone DNS settings</span>
			</a>
		</li>
		<li class="disabled" id="more_icon">
			<a>
				<img src="{$type_dir}icons/ico_resources.png" alt="">
				<span>More</span>
			</a>
			<ul style="display:none" id="more_list">
				{foreach from=$supp_type item=stype}
				{if $stype != 'MX' && $stype != 'A' && $stype != 'CNAME'}
					<li><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&type={$stype}">{$lang.Add} {$stype} record</a></li>
				{/if}
				{/foreach}
			</ul>
		</li>
	</ul>
	<div class="clear"></div>
</div>
<form action="" method="POST">
    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display">
        <thead>
            <tr>
                <th width="20"><input type="checkbox" onclick="{literal}if(this.checked && $('.idchecker').length){ $('.idchecker').attr('checked',true); bind_ico(); }else {$('.idchecker').attr('checked',false); unbind_ico();}{/literal}" /></th>
                <th align="left">{$lang.domain}</th>
                <th width="150">Creation date</th>
			{if $metered_enable}<th width="80">Price</th>{/if}
                <th width="20"></th>
            </tr>
        </thead>

	{if $user_domains}	<tbody>
		{foreach from=$user_domains item=domain name=row}
            <tr {if  $smarty.foreach.row.index%2 == 0}class="even"{else}class="odd"{/if}>
                <td width="20"><input class="idchecker" type="checkbox" onclick="" name="dom[]"  value="{$domain.rawoutput}"/></td>
                <td align="left"><a  href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domain.rawoutput}">{$domain.output}</a></td>
                <td>{if $domain.date_created}{$domain.date_created|dateformat:$date_format}{else}-{/if}</td>
			{if $metered_enable}<td>{if $domain.charge}{$domain.charge|price:$currency}{else}-{/if}</td> {/if}
                <!--<td><a class="autorefreash {if $domain.qty==0}off{/if}" href="#" onclick="return switchRenew(this,'{$domain.id}')" title="{$lang.autorenew}: {if $domain.qty==0}{$lang.Off}{else}{$lang.On}{/if}"></a></td>-->
                <td><a title="Delete" onclick="return confirm('Are you sure you wish to remove this domain?');" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&did={$domain.rawoutput}&make=removedomain" class="deleteico fs11 btn btn-mini"><i class="icon-trash"></i> </a></td>
            </tr>
		{/foreach}
        </tbody>

        <tbody>
            <tr>
                <th colspan="{if $metered_enable}2{else}4{/if}" style="font-weight:normal">Domains count:  <b {if $dom_limit && $user_domains_cnt==$dom_limit}style="color:red"{/if}>{$user_domains_cnt}</b> Max allowed: <b>{$dom_limit}</b></th>
               {if $metered_enable}
               <th align="right" style="text-align:right">Total:</th>
               <th colspan="2" > <b>{$service.metered_total|price:$currency}</b></th>{/if}

            </tr>
        </tbody>
            {else}
            <tbody>
                <tr>
                    <td colspan="{if $metered_enable}5{else}4{/if}" align="center">No domains added yet</td>
                </tr>
           </tbody>

            {/if}

    </table>
        <table border="0" width="100%">
            <tr>
                <td >
                    {if $dom_limit && $user_domains_cnt>=$dom_limit}
                      <span class="fs11" style="color:red">You've reached your domains limit</span>
                    {else}
                      <a class="btnx btn_dS fl" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_domain">Add new domain</a>
                    {/if}
                </td>
                <td align="right">
                    {if $metered_enable}
                            {if $next_price} Your current price for next domain is {$next_price|price:$currency}{/if} <a href="#" onclick="$('#mpricing').toggle();return false">View pricing</a>
                    {/if}
                </td>
            </tr>
        </table>
    {/if}
<div class="wbox" style="margin-top:30px;">
    <div class="wbox_header">Billing info</div>
    <div class="wbox_content">
        <table cellspacing="0" cellpadding="0" class="checker" width="100%">
            <tr >
                <td align="right" style="border:none;"><b>{$lang.status}</b></td>
                <td style="border:none;"><span class="{$service.status}">{$lang[$service.status]}</span></td>
                {if $service.billingcycle!='Free' && $service.billingcycle!='Once' && $service.billingcycle!='One Time'}
                    <td style="border:none;" align="right"><b>Next invoice</b></td>
                    <td style="border:none;">{$service.next_invoice|dateformat:$date_format}</td>

                    <td style="border:none;" align="right"><b>Next invoice total</b></td>
                    <td style="border:none;">{if $metered_enable}
                            {$user_domains_cnt} domains * {$curent_price|price:$currency}/domain = <b>{$summary.charge|price:$currency}</b>
                        {else}{$service.total|price:$currency}{/if}</td>
                {/if}
            </tr>
        </table>
        <div id="mpricing" style="display:none">
            <table border="0" cellspacing="0" cellpadding="0" width="100%" class="checker" >

            {foreach from=$pricebrackets item=bracket}
                 {foreach from =$bracket.prices item=p key=k name=bloop}
                    <tr {if $smarty.foreach.bloop.index%2==0}class="even"{/if}>
                        <td width="20"></td>
                        <td >From {$p.qty} {$bracket.unit_name}</td>
                        <td >{if $p.qty_max>0}to {$p.qty_max} {$bracket.unit_name}{else} to <b>unlimited</b>{/if}</td>
                        <td >{$p.price|price:$currency} / {$lang[$service.billingcycle]}</td>
                    </tr>
                 {/foreach}
            {/foreach}
     </table>
        </div>
    </div>
</div>


{if $service.status=='Active'}
    {if $nameserv}
    <div class="wbox" style="margin-top:30px;">
        <div class="wbox_header">Update your domain registrar's nameservers</div>
        <div class="wbox_content">
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td width="50%" style="padding-right:10px;">
                        <ul style="" class="listi">
                                    <li>Sign in to your domain registrar backend.</li>
                                    <li>Navigate to an Nameserver (NS) record maintenance page. They can be located under
                                        sections 'DNS Management' or 'Name Server Management'.</li>
                                    <li>Delete any existing NS records.</li>
                                    <li>For each NS record, enter information according to the entries in the following
                                        table.</li>
                                </ul>

                    </td>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" class="checker" width="100%">
                            <tr><th style="text-align: left">Host name</th><th  style="text-align: left">IP Address </th></tr>
                            {foreach from=$nameserv item=ns name=namserver}{if $ns!=''}
                            <tr {if $smarty.foreach.namserver.index%2==0}class="even"{/if}><td>{$ns.name}</td><td>{$ns.ip}</td></tr>
                            {/if}{/foreach}
                        </table>
                    </td>
                </tr>
            </table>

        </div>
    </div>

    {/if}
{/if}
</form>
{/if}
{if $act=='dns_manage'}
{literal}
<script type="text/javascript">
	$(function(){
		$('.cbreadcrumb').children(':last')
			.wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />')
		.end()
			.append(' <strong>» {$domain.domain}</strong> » {$lang.dnsedit}{literal}');
	});

	function ask(){
		if(!confirm('{/literal}{$lang.confirm_delrecord}{literal}'))
			return false;
	}	
</script>
{/literal}

<form action="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domid}" method="POST">
    {foreach from=$record_types item=ids key=type}
        {if $type=='SOA'}
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display"  style="margin-bottom:15px">
            <thead>
                <tr>
                    <th colspan="6">SOA Record</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width: 250px;">{$lang.name}</th>
                    <th style="width: 50px;">Priority</th>
                    <th style="width: 50px;">TTL</th>
                    <th style="width: 50px;">{$lang.type}</th>
                    <th>{$lang.data}</th>
                    <th width="60"></th>
                </tr>
            </tbody>
            <tbody>
                {foreach from=$records item=record}
                {if in_array($record.id, $ids)}
                <tr style="vertical-align:top">
                    <td>{$record.name}</td>
                    <td>{$record.prio}</td>
                    <td>{$record.ttl}</td>
                    <td>{$record.type}</td>
                    <td align="left" style="padding-left:1em">{$record.content[0]} {$record.content[1]} (<br />
                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[2]};</div><div> Serial</div>
                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[3]};</div><div> Refresh</div>
                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[4]};</div><div> Retry</div>
                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[5]};</div><div> Expire</div>
                        <div style="min-width: 90px; padding-right: 0.5em;text-align: right;" class="clear left">{$record.content[6]}</div><div> Minimum TTL</div>
                        &nbsp;&nbsp;&nbsp;)
                    </td>
                    <td><a class="fs11" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=edit_record&domain_id={$domid}&record={$record.id}" title="{$lang.edit}">{$lang.edit}</a> &nbsp;&nbsp;</td>
                   
                </tr>
                {/if}
                {/foreach}
            </tbody>
        </table>
        {/if}
    {/foreach}
        {foreach from=$record_types item=ids key=type}
            {if $type!='SOA'}
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="display" style="margin-bottom:15px">
                <thead><tr><th align="left" colspan="6">{$type} Records</th></tr></thead>
		<tbody>
			<tr>
				<th style="width: 250px;">{$lang.name}</th>
				<th style="width: 50px;">Priority</th>
				<th style="width: 50px;">TTL</th>
				<th style="width: 50px;">{$lang.type}</th>
				<th>{$lang.data}</th>
                                <th width="60"></th>
			</tr>
                        {foreach from=$records item=record name=rc}
			{if in_array($record.id, $ids)}
                        <tr  {if  $smarty.foreach.rc.index%2 == 0}class="even"{else}class="odd"{/if}>
				<td>{$record.name}</td>
				<td>{$record.prio}</td>
				<td>{$record.ttl}</td>
				<td>{$record.type}</td>
				<td align="left">
					{if is_array($record.content)}
						{foreach from=$record.content item=content name=row}
							{$content}&nbsp;
						{/foreach}
					{else}
						{$record.content}
					{/if}
				</td>
				<td align="right" >
					{if in_array($record.type,$supported_types)}
					<a class="fs11" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=edit_record&domain_id={$domid}&record={$record.id}" title="{$lang.edit}">{$lang.edit}</a> &nbsp;&nbsp;
					<a class="deleteico fs11" href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_manage&domain_id={$domid}&delete={$record.id}" onclick="return ask()" title="{$lang.delete}"><i class="icon-trash"></i>  </a>
					{/if}
				</td>
			</tr>
			{/if}
			{/foreach}
                        <tr>
                            <td colspan="6" style="text-align:right"><a href="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&dom={$domid}&type={$type}" class="fs11">Add new {$type} record</a></td>
			</tr>
		</tbody>

            </table>
            {/if}
{/foreach}

	
		<div style="margin-top:2em">
                    <div class="left" style="margin-right: 5px">{$lang.newrecord}
			<select id="add_record">
			{foreach from=$supported_types item=stype}
				<option  value="{$stype}" >{$stype}</option>
			{/foreach}
			</select>
                        </div>
                        <a class="btnx btn_d fl" href="#" onclick="window.location='{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=add_record&dom={$domid}&type='+$('#add_record').val();return false;">Add</a>
                        <div class="clear"></div>
		</div>
		
		
</form>
{/if}
{if $act=='dns_templates'}

<script type="text/javascript">{literal}
	var start = false;
        $(document).ready(function(){

            $("#nitems strong").click(function(){
                $(this).parent().find('input').click();
                return false;
            });

            $('#nitems input').click(function(){
                $('.diss').removeClass('diss');
                $('#nitems .nitem').removeClass('niselected');
                $(this).parent().addClass('niselected');
                var id=$(this).val();
                $('.oitem').hide();
                 $('.oitem_'+id).fadeIn('fast');

            });

		$('.cbreadcrumb').children(':last').wrap('<a href="{/literal}{$ca_url}clientarea/services/{$service.slug}/{$service.id}/" />').end().append(' » <strong>DNS Templates{literal}</strong>');

        });
    
	
	
</script>
<style type="text/css">
	#dns_templ {list-style:none; padding:0; margin:0}
	#dns_templ li {padding:2px 10px; cursor:pointer; font-weight:bold}
	#dns_templ li:hover , #dns_templ li.active {color:#026BeB}
	#dns_prev {border:solid 1px #bbb; min-height:250px; margin-bottom:20px}
        .diss {
            color:#C0C0C0 !important;
}
</style>
{/literal}
<form id="mform" action="{$ca_url}clientarea/services/{$service.slug}/{$service.id}/&act=dns_templates" method="post">
{if $sected_domains} 
<div class="wbox"><div class="wbox_header">{$lang.bulkdomains}</div>
	<div class="wbox_content">
		{foreach from=$sected_domains item=domain name=row}
		<div {if  $smarty.foreach.row.index == 0}class="first"{/if}><input type="checkbox" value="{$domain.id}" name="dom[]" checked="checked"/> 
			{$domain.name}
		</div>
		{/foreach}
	</div></div>
{/if}

<h3>Available DNS Templates</h3>
<table border="0" cellpadding="0" cellspacing="0" width="100%" class="ntable">
    <tr>
        <td valign="top" width="33%" style="padding:10px 0px;" id="nitems">
            
                {foreach from=$templates item=template key=name}
                <div class="nitem">
                    <input type="radio" name="template" value="{$template[0].id}"/> <strong>{$template[0].template}</strong>
                </div>
		{/foreach}
        </td>
            <td valign="top" class="orderbox1" id="orderitems">
                <div class="oitem">
                    Select one of available DNS templates from the left. <br />
                    If you will choose to add template, its records will be automatically added to your zone.


                </div>
            {foreach from=$templates item=template key=tid name=floop}
            <div class="oitem oitem_{$tid}" style="display:none;">
                <table cellspacing="0" cellpadding="0" border="0" width="100%" class="styled">
                    <thead >
                        <tr>
                            <th>{$lang.name}</th>
                            <th>TTL</th>
                            <th>Priority</th>
                            <th>{$lang.type}</th>
                            <th>Content</th>
                        </tr>
                    </thead>

                    <tbody >
			{foreach from=$template item=record}
                        <tr>
                            <td>{$record.name}</td>
                            <td>{$record.ttl}</td>
                            <td>{$record.prio}</td>
                            <td>{$record.type}</td>
                            <td>{$record.content}</td>
                        </tr>
			{/foreach}
                    </tbody>
                </table>
            </div>

            {/foreach}
        </td>
    </tr>
    <tr>
        <td></td>
        <td class="orderbox2">
            <table width="100%" cellspacing="0">
                <tbody><tr>
                        <td width="70%" class="orderbox3" align="right">
                            <input type="submit"    onclick="return  $('input[name=template]:checked').val()!=undefined" value="Apply Template" name="submit" class="btn btn-primary diss" style="font-weight: bold;padding:4px 2px;">
                        </td>

                    </tr>
                </tbody></table>
        </td>
    </tr>
</table>
            </form>


{/if}
