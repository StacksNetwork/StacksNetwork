<div id="SSLRegular_b" {if $product.paytype!='SSLRegular'}style="display:none"{/if} class="p5 boption">

	<table border="0" cellpadding="6" cellspacing="0" width="100%" id="Regular_b">
        <tr id="apricing" class="havecontrols" {if $product.a=='0.00' && $product.a_setup=='0.00' && !($product.b=='0.00' && $product.b_setup=='0.00' &&  $product.t=='0.00' && $product.t_setup=='0.00' && $product.p4=='0.00' && $product.p4_setup=='0.00' &&  $product.p5=='0.00' && $product.p5_setup=='0.00')}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>1 {$lang.Year}</strong></td>
            <td>
                <div class="e1">
					{$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.a|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.a_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.a_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					{$lang.Price}: <input type="text" value="{$product.a|price:$currency:false}" size="4" name="a" class="inp"/> &nbsp;&nbsp;
					{$lang.setupfee}:  <input type="text" value="{$product.a_setup|price:$currency:false}" size="4" name="a_setup" class="inp"/>
                </div>
            </td>
        </tr>

        <tr id="bpricing" class="havecontrols" {if $product.b=='0.00' && $product.b_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>2 {$lang.Years}</strong></td>
            <td>
                <div class="e1">
					{$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.b|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.b_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.b_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
                    <strong>{$lang.Price}: </strong><input type="text" value="{$product.b|price:$currency:false}" size="4" name="b" class="inp"/> &nbsp;&nbsp;
                    <strong>{$lang.setupfee}: </strong> <input type="text" value="{$product.b_setup|price:$currency:false}" size="4" name="b_setup" class="inp"/>
                </div>
            </td>
        </tr>

        <tr id="tpricing" class="havecontrols" {if $product.t=='0.00' && $product.t_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>3 {$lang.Years}</strong></td>
            <td>
                <div class="e1">
					{$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.t|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.t_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.t_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					{$lang.Price}: <input type="text" value="{$product.t|price:$currency:false}" size="4" name="t" class="inp"/> &nbsp;&nbsp;
					{$lang.setupfee}:  <input type="text" value="{$product.t_setup|price:$currency:false}" size="4" name="t_setup" class="inp"/>
                </div>

            </td>
        </tr>
		<tr id="p4pricing" class="havecontrols" {if $product.p4=='0.00' && $product.p4_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>4 {$lang.Years}</strong></td>
            <td>
                <div class="e1">
					{$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.p4|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.p4_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.p4_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					{$lang.Price}: <input type="text" value="{$product.p4|price:$currency:false}" size="4" name="p4" class="inp"/> &nbsp;&nbsp;
					{$lang.setupfee}:  <input type="text" value="{$product.p4_setup|price:$currency:false}" size="4" name="p4_setup" class="inp"/>
                </div>

            </td>
        </tr>
		<tr id="p5pricing" class="havecontrols" {if $product.p5=='0.00' && $product.p5_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>5 {$lang.Years}</strong></td>
            <td>
                <div class="e1">
					{$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.p5|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.p5_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.p5_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					{$lang.Price}: <input type="text" value="{$product.p5|price:$currency:false}" size="4" name="p5" class="inp"/> &nbsp;&nbsp;
					{$lang.setupfee}:  <input type="text" value="{$product.p5_setup|price:$currency:false}" size="4" name="p5_setup" class="inp"/>
                </div>

            </td>
        </tr>
		<tr><td colspan="2">
				<a href="#" class="new_control" onclick="$(this).hide();$('#tbpricing').show();$('#tbpricing select option:visible').eq(0).attr('selected','selected');return false;" id="addpricing" {if ($product.m!='0.00' || $product.m_setup!='0.00') && ($product.d!='0.00' || $product.d_setup!='0.00') && ($product.w!='0.00' || $product.w_setup!='0.00') && ($product.q!='0.00' || $product.q_setup!='0.00') && ($product.s!='0.00' || $product.s_setup!='0.00') && ($product.a!='0.00' || $product.a_setup!='0.00') && ($product.b!='0.00' || $product.b_setup!='0.00') &&  ($product.t!='0.00' || $product.t_setup=='0.00') &&  ($product.p4!='0.00' || $product.p4_setup=='0.00') &&  ($product.p5!='0.00' || $product.p5_setup=='0.00')}style="display:none"{/if}><span class="addsth" >{$lang.addpricingoption}</span></a>

			</td></tr>
    </table>
</div>
<div id="tbpricing"  style="display:none;" class="p6">
    <div >
        <table border="0" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <td><strong>{$lang.Period}:</strong></td>
                <td ><select >
                        <option  value="a"  {if $product.a!='0.00' || $product.a_setup!='0.00'}style="display:none"{/if}>1 {$lang.Year}</option>
                        <option  value="b"  {if $product.b!='0.00' || $product.b_setup!='0.00'}style="display:none"{/if}>2 {$lang.Years}</option>
                        <option  value="t"  {if $product.t!='0.00' || $product.t_setup!='0.00'}style="display:none"{/if}>3 {$lang.Years}</option>
						<option  value="p4"  {if $product.p4!='0.00' || $product.p4_setup!='0.00'}style="display:none"{/if}>4 {$lang.Years}</option>
                        <option  value="p5"  {if $product.p5!='0.00' || $product.p5_setup!='0.00'}style="display:none"{/if}>5 {$lang.Years}</option>
                    </select></td>

                <td><strong>{$lang.Price}:</strong></td>
                <td><input type="text" value="{0|price:$currency:false:false}" size="4" name="newprice" id="newprice" class="inp"/>&nbsp;&nbsp;<strong>{$lang.setupfee}:</strong> <a href="#" class="editbtn" id="newsetup1">{$lang.Enable}</a><input type="text" value="{0|price:$currency:false:false}" size="4" name="newsetup" id="newsetup" class="inp" style="display:none"/></td>

                <td colspan="2" align="center"><input type="button" value="{$lang.Add}"  onclick="addopt();return false;"/> <span class="orspace">{$lang.Or} </span> <a href="#" onclick="$('#addpricing').show();$('#tbpricing').hide();return false;" class="editbtn" id="hidepricingadd">{$lang.Cancel}</a></td>
            </tr>
        </table>
    </div>
</div>