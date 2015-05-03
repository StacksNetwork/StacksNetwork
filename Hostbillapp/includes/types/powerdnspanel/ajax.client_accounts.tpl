
<style type="text/css">{literal}
#facebox {z-index:1500}
.recordbox {min-height: 30px; padding: 5px;}
.recordbox label {clear: both; display: block; float: left; width: 100px;}
.recordbox input, .recordbox select {display: block; float: left; min-width:140px}
#contentbox input {float:none; display:inline; margin:0 0 5px 0}
#contentbox {margin-left:100px}
</style>
<script type="text/javascript">
	var types = { 
		'A' : [['Ip','IP Addres ']],
		'AAAA':[['IPv6']], 
		'CNAME':[['Hostname']], 
		'DNAME':[['Hostname']], 
		'PTR':[['Hostname']], 
		'TXT':[['Text']], 
		'SPF':[['Text']], 
		'MX':[['Hostname']],
		'AFSDB':[['Subtype'], ['Hostname']],
		'HINFO':[['Hardware info'], ['Software info']],
		'NSEC':[['Next Domain Name'], ['Type Bit Maps']],
		'RP':[['email address with no at sign'], ['TXT pointer for more info']],
		'A6':[['Prefix len.'], ['Address'], ['Prefix name']],
		'SSHFP':[['Algorithm '], ['fp-type'], ['Fingerprint']],
		'DNSKEY':[['Flags'], ['Protocol'], ['Algorithm'], ['Public Key']],
		'KEY':[['Flags'], ['Protocol'], ['Algorithm'], ['Public Key ']],
		'DS':[['Key tag'], ['Algorithm'], ['Digest Type'], ['Digest',]],
		'CERT':[['Type'], ['Key tag'], ['Algorithm'], ['Certificate ']],
		'SRV':[['Priority'], ['Weight'], ['Port'], ['Hostname']], 
		'LOC':[['Latitude'], ['Longitude'], ['Altitude'],['Size'], ['Horizontal Precision'], ['Vertical Precision']], 
		'NAPTR':[['Order'], ['Preferences'], ['Flags'], ['Service'], ['Regex'], ['Hostname']],
		'RRSIG':[['Type Covered'], ['Algorithm'], ['Labels'], ['Original TTL'], ['Signature Expiration'], ['Signature Inception'], ['Key Tag'], ['Signer\'s Name'], ['Signature']]
	};
$(function(){
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
<form>
	<input id="type" type="hidden" name="type" value="{$r_type}" />
	<input type="hidden" name="dom" value="{$domid}" />
	<h3 >Add new '{$r_type}' record</h3>
	<div class="recordbox">
		<label>Name:</label>
		<input class="styled" type="text" name="name" />
	</div>
	<div class="recordbox">
		<label>TTL</label>
		<select class="styled" name="ttl" >
			<option value="">1h</option>
			<option value="">12h</option>
			<option value="">24h</option>
			<option value="">48h</option>
		</select><a class="vtip_description" title="test"></a>
	</div>
	<div class="recordbox">
		<label>Content</label>
		<div id="contentbox">
		<input class="styled" type="text" name="content" /><a class="vtip_description" title="test"></a><br>
		<input class="styled" type="text" name="content" /><a class="vtip_description" title="test"></a><br>
		</div>
	</div>
</form>
	
	



