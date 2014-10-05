<div id="Once_b" {if $product.paytype!='Once'}style="display:none"{/if} class="p5 boption">

     <strong>{$lang.Price}: </strong><input type="text" value="{$product.m|price:$currency:false}" size="4" name="m1" class="inp"/>
    &nbsp;&nbsp;
	{$lang.setupfee}: <input type="text" value="{$product.m_setup|price:$currency:false}" size="4" name="m_setup1" class="inp"/> <br />
</div>