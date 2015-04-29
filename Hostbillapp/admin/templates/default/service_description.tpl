{assign var=product_features value=$categories[$product.category_id].opconfig.productfeatures}
<tr {if $product_features}style="display:none"{/if}>
	<td width="160" align="right" valign="top" ><strong>{$lang.productdescription}</strong></td>
	<td class="editor-container">
		{if $product.description!=''}
                    {hbwysiwyg value=$product.tag_description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}
		{else}
		<a href="#" onclick="$(this).hide();$('#prod_desc_c').show();return false;"><strong>{$lang.adddescription}</strong></a>
                <div id="prod_desc_c" style="display:none">{hbwysiwyg value=$product.description style="width:99%;" class="inp wysiw_editor" cols="100" rows="6" id="prod_desc" name="description" featureset="full"}</div>
		{/if}
	</td>
</tr>

{if $product_features=='ulli' 
|| $product_features=='ulli+features' 
|| $product_features=='ulli+description'
|| $product_features=='ulli+description+'
|| $product_features=='ulli+spec'}
<tr>
	<td width="160" align="right" valign="top" ><strong>Product features</strong></td>
	<td >
	{if $product.description!=''}
		<div style="display:none" id="oridesc">{$product.description}</div>
	{/if}
	<div id="featureeditor">
		<div class="featureline nl"><span>{$lang.feature}: </span> <input type="text" size='40'/> 
		{if $product_features=='ulli+description' || $product_features=='ulli+description+'}<span>{$lang.Description}:</span> 
                    <textarea  cols="60" style="height:2em;vertical-align: middle;" class="desc" ></textarea>
                {/if}
		{if $product_features=='ulli+spec'} <span>Value:</span> 
                    <input type="text" class="spec" >
                {/if}
		</div>
		<div class="featureline"><a href="#" class="editbtn" onclick="return addNextFeature(this)">{$lang.addmorefeatures}</a></div>
	</div>
	{if $product_features=='ulli+features' || $product_features=='ulli+spec' || $product_features=='ulli+description+'}
	</td>
</tr>
<tr>
	<td width="160" align="right" valign="top" >
		<strong>Aditional features</strong>
	</td>
	<td >
	<div id="adt_featureeditor">
		<div class="featureline nl"><span>{$lang.feature}: </span> <input type="text"  size='40'/></div>
		<div class="featureline"><a href="#" class="editbtn" onclick="return addNextFeature(this)">{$lang.addmorefeatures}</a></div>
	</div>
	{/if}
	
	{literal}
	<script type="text/javascript">
	{/literal}{if $product_features=='ulli+description' || $product_features=='ulli+description+'}{literal}
	$('#oridesc ul li').each(function(){
		var dsc ='';
		if($(this).find('dl dd').length)
			dsc = $(this).find('dl dd').html();
		$(this).find('dl').remove();
		$('#featureeditor .nl').eq(0).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='"+$(this).html().replace(/'/g,'&#39;').replace(/"/g,'&quot;')+"' /> <span>{/literal}{$lang.Description}{literal}:</span> <textarea  cols='60' style='height:2em;vertical-align: middle;' class='desc' >"+ dsc +"</textarea></div>");
	});
	{/literal}{elseif $product_features=='ulli+spec'}{literal}
		if($('#oridesc').length && $('#oridesc').html().length){
			var source = $('#oridesc').html().split(/<\s*br[/\s]*?>/i);
			for(var i=0;i<source.length;i++){
				if(source[i] == '') continue;
				if(source[i].indexOf('<ul>') > -1){
					var feats = source[i].replace(new RegExp("<.*?>|\\n",'ig'),String.fromCharCode(0x1c)).match(new RegExp("[^\\x1c]+",'ig'));
					if(feats)
					for(var f=0;f<feats.length;f++){
						$('#adt_featureeditor .nl').eq(0).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='"+feats[f].replace(/'/g,'&#39;').replace(/"/g,'&quot;')+"' /></div>");
					}
				}else{
					var bit = source[i].split(/:/);
					$('#featureeditor .nl').eq(0).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='"+bit[0].replace(/'/g,'&#39;').replace(/"/g,'&quot;')+"' /> <span>Value:</span> <input value='"+(bit[1]==undefined?'':bit[1])+"' type='text' class='spec' ></div>");
				}	
			}
		}
	{/literal}{else}{literal}
	$('#oridesc ul li').each(function(){
		$('#featureeditor .nl').eq(0).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='"+$(this).html().replace(/'/g,'&#39;').replace(/"/g,'&quot;')+"' /></div>");
	});
	{/literal}{/if}{literal} 
		
	{/literal}{if $product_features=='ulli+features' || $product_features=='ulli+description+'}{literal}
	$('#oridesc ol li').each(function(){
		$('#adt_featureeditor .nl').eq(0).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='"+$(this).html().replace(/'/g,'&#39;').replace(/"/g,'&quot;')+"' /></div>");
	});
	{/literal}{/if}{literal} 
		
	function addNextFeature(el) {
		//$(el).before("<div class='featureline'><span>{/literal}{$lang.feature}{literal}:</span> <input type='text' size='40' value='' />{/literal}{if $product_features=='ulli+description'}{literal}<span>{/literal}{$lang.Description}{literal}:</span> <input type='text' class='desc' size='40' />{/literal}{/if}{literal} </div>");
		var clon = $(el).parent().prev('.nl').clone();
		clon.find('input').val('');
		$(el).before(clon);
		return false;
	}
	function bindOnSave() {
		$('#productedit').submit(function(){
			var v='<ul>';
			var inputs = $('#{/literal}{if $product_features=='ulli+spec'}adt_{/if}{literal}featureeditor input');
			for(var i=0; i<inputs.length;i++){
				if(inputs.eq(i).val()!=''){
					v+='<li>'+inputs.eq(i).val();
					{/literal}{if $product_features=='ulli+description' || $product_features=='ulli+description+'}
					if($('#featureeditor textarea').eq(i).val()!='')
						v+='<dl><dd>'+$('#featureeditor textarea').eq(i).val()+'</dd></dl>';
					{/if}{literal}
					v+='</li>';
				}
			}
			v+='</ul>';
	{/literal}{if $product_features=='ulli+spec'}{literal}
		var spec = $('#featureeditor input').not('.spec');
		var s ='';
		for(var i=0; i<spec.length;i++){
			if(spec.eq(i).val()!='' && $('#featureeditor input.spec').eq(i).val()!='')
				s+=spec.eq(i).val()+':'+$('#featureeditor input.spec').eq(i).val()+'<br>';
		}
		v = s+v;
	{/literal}{/if}
	{if $product_features=='ulli+features' || $product_features=='ulli+description+'}{literal}
			var adt='';
			$('#adt_featureeditor input').each(function(){
				if($(this).val()!='') {
					adt+='<li>'+$(this).val()+'</li>';
				}
			});
			if(adt!='')
			v+='<ol style="list-style:disc">'+adt+'</ol>';
	{/literal}{/if}{literal}
			$('textarea[name=description]').val(v);
		});
	};
	appendLoader('bindOnSave');
	</script>
	{/literal}
	</td>
</tr>

    {/if}