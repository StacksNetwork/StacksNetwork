<div id="Regular_b" {if $product.paytype!='Regular'}style="display:none"{/if} class="p5 boption">

     <table border="0" cellpadding="6" cellspacing="0" width="100%">
        <tr  id="hpricing" class="havecontrols" {if $product.h=='0.00' && $product.h_setup=='0.00'}style="display:none"{/if}>

             <td align="right" width="120" >
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Hourly}</strong></td>

            <td> <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.h|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.h_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.h_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					    {$lang.Price}: <input type="text" value="{$product.h|price:$currency:false}" size="4" name="h" class="inp"/> &nbsp;&nbsp;
					    {$lang.setupfee}:<input type="text" value="{$product.h_setup|price:$currency:false}" size="4" name="h_setup" class="inp"/>
                </div></td>
        </tr>
        <tr  id="dpricing" class="havecontrols" {if $product.d=='0.00' && $product.d_setup=='0.00'}style="display:none"{/if}>

             <td align="right" width="120" >
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Daily}</strong></td>

            <td> <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.d|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.d_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.d_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					    {$lang.Price}: <input type="text" value="{$product.d|price:$currency:false}" size="4" name="d" class="inp"/> &nbsp;&nbsp;
					    {$lang.setupfee}:<input type="text" value="{$product.d_setup|price:$currency:false}" size="4" name="d_setup" class="inp"/>
                </div></td>
        </tr>

        <tr  id="wpricing"  class="havecontrols" {if $product.w=='0.00' && $product.w_setup=='0.00'}style="display:none"{/if}>
             <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Weekly}</strong></td>
            <td>
                <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.w|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.w_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.w_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					   {$lang.Price}: <input type="text" value="{$product.w|price:$currency:false}" size="4" name="w" class="inp"/> &nbsp;&nbsp;
					   {$lang.setupfee}: <input type="text" value="{$product.w_setup|price:$currency:false}" size="4" name="w_setup" class="inp"/>
                </div></td>
        </tr>

        <tr id="mpricing" class="havecontrols" {if $product.m=='0.00' && $product.m_setup=='0.00' && !($product.d=='0.00' && $product.d_setup=='0.00' && $product.w=='0.00' && $product.w_setup=='0.00' && $product.q=='0.00' && $product.q_setup=='0.00' && $product.s=='0.00' && $product.s_setup=='0.00' && $product.a=='0.00' && $product.a_setup=='0.00' && $product.b=='0.00' && $product.b_setup=='0.00' &&  $product.t=='0.00' && $product.t_setup=='0.00' &&  $product.h=='0.00' && $product.h_setup=='0.00'&& $product.p4=='0.00' && $product.p4_setup=='0.00' &&  $product.p5=='0.00' && $product.p5_setup=='0.00')}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Monthly}</strong></td>
            <td>
                <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.m|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.m_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.m_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					   {$lang.Price}: <input type="text" value="{$product.m|price:$currency:false}" size="4" name="m" class="inp"/> &nbsp;&nbsp;
					    {$lang.setupfee}: <input type="text" value="{$product.m_setup|price:$currency:false}" size="4" name="m_setup" class="inp"/>
                </div>
            </td>
        </tr>

        <tr id="qpricing" class="havecontrols" {if $product.q=='0.00' && $product.q_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Quarterly}</strong></td>
            <td>
                <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.q|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.q_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.q_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
                    <strong>{$lang.Price}: </strong><input type="text" value="{$product.q|price:$currency:false}" size="4" name="q" class="inp"/> &nbsp;&nbsp;
					   {$lang.setupfee}: <input type="text" value="{$product.q_setup|price:$currency:false}" size="4" name="q_setup" class="inp"/>
                </div></td>
        </tr>

        <tr id="spricing" class="havecontrols" {if $product.s=='0.00' && $product.s_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.SemiAnnually}</strong></td>
            <td>
                <div class="e1">
					    {$lang.Price}: <strong>{$currency.sign} <span class="pricer">{$product.s|price:$currency:false}</span> {$currency.code}</strong>
                    <span {if $product.s_setup=='0.00'}style="display:none"{/if}>{$lang.setupfee}: <strong>{$currency.sign} <span class="pricer_setup">{$product.s_setup|price:$currency:false}</span> {$currency.code}</strong></span>
                </div>
                <div class="e2">
					    {$lang.Price}: <input type="text" value="{$product.s|price:$currency:false}" size="4" name="s" class="inp"/> &nbsp;&nbsp;
					    {$lang.setupfee}:  <input type="text" value="{$product.s_setup|price:$currency:false}" size="4" name="s_setup" class="inp"/>
                </div>
            </td>
        </tr>

        <tr id="apricing" class="havecontrols" {if $product.a=='0.00' && $product.a_setup=='0.00'}style="display:none"{/if}>
            <td align="right" width="120">
                <div class="controls"><a href="#" class="editbtn">{$lang.Edit}</a> <a href="#" class="delbtn">{$lang.Delete}</a></div>
                <strong>{$lang.Annually}</strong></td>
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
                <strong>{$lang.Biennially}</strong></td>
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
                <strong>{$lang.Triennially}</strong></td>
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
 <tr><td colspan="2">
                            <a href="#" class="new_control" onclick="$(this).hide();$('#tbpricing').show();$('#tbpricing select option:visible').eq(0).attr('selected','selected');return false;" id="addpricing" {if ($product.m!='0.00' || $product.m_setup!='0.00') && ($product.d!='0.00' || $product.d_setup!='0.00') && ($product.w!='0.00' || $product.w_setup!='0.00') && ($product.q!='0.00' || $product.q_setup!='0.00') && ($product.s!='0.00' || $product.s_setup!='0.00') && ($product.a!='0.00' || $product.a_setup!='0.00') && ($product.b!='0.00' || $product.b_setup!='0.00') &&  ($product.t!='0.00' || $product.t_setup=='0.00') &&  ($product.p4!='0.00' || $product.p4_setup=='0.00') &&  ($product.p5!='0.00' || $product.p5_setup=='0.00')}style="display:none"{/if}><span class="addsth" >{$lang.addpricingoption}</span></a>

                        </td></tr>
    </table>
</div>
<div id="tbpricing"  style="display:none;" class="p6">
    <div >
        <table border="0" cellpadding="3" cellspacing="0" width="100%">
            <tr>
                <td><strong>{$lang.billingcycle}:</strong></td>
                <td ><select >
                        {*}<option value="h"  {if $product.h!='0.00' || $product.h_setup!='0.00'}style="display:none"{/if}>{$lang.Hourly}</option>{*}
                        <option value="d"  {if $product.d!='0.00' || $product.d_setup!='0.00'}style="display:none"{/if}>{$lang.Daily}</option>
                        <option  value="w" {if $product.w!='0.00' || $product.w_setup!='0.00'}style="display:none"{/if}>{$lang.Weekly}</option>
                        <option  value="m" {if $product.m!='0.00' || $product.m_setup!='0.00'}style="display:none"{/if} >{$lang.Monthly}</option>
                        <option  value="q"  {if $product.q!='0.00' || $product.q_setup!='0.00'}style="display:none"{/if}>{$lang.Quarterly}</option>
                        <option  value="s"  {if $product.s!='0.00' || $product.s_setup!='0.00'}style="display:none"{/if}>{$lang.SemiAnnually}</option>
                        <option  value="a"  {if $product.a!='0.00' || $product.a_setup!='0.00'}style="display:none"{/if}>{$lang.Annually}</option>
                        <option  value="b"  {if $product.b!='0.00' || $product.b_setup!='0.00'}style="display:none"{/if}>{$lang.Biennially}</option>
                        <option  value="t"  {if $product.t!='0.00' || $product.t_setup!='0.00'}style="display:none"{/if}>{$lang.Triennially}</option>
			{*<option  value="p4"  {if $product.p4!='0.00' || $product.p4_setup!='0.00'}style="display:none"{/if}>{$lang.Quadrennially}</option>
                        <option  value="p5"  {if $product.p5!='0.00' || $product.p5_setup!='0.00'}style="display:none"{/if}>{$lang.Quinquennially}</option>*}
                    </select></td>

                <td><strong>{$lang.Price}:</strong></td>
                <td><input type="text" value="{0|price:$currency:false:false}" size="4" name="newprice" id="newprice" class="inp"/>&nbsp;&nbsp;<strong>{$lang.setupfee}:</strong> <a href="#" class="editbtn" id="newsetup1">{$lang.Enable}</a><input type="text" value="{0|price:$currency:false:false}" size="4" name="newsetup" id="newsetup" class="inp" style="display:none"/></td>

                <td colspan="2" align="center"><input type="button" value="{$lang.Add}"  onclick="addopt();return false;"/> <span class="orspace">{$lang.Or} </span> <a href="#" onclick="$('#addpricing').show();$('#tbpricing').hide();return false;" class="editbtn" id="hidepricingadd">{$lang.Cancel}</a></td>
            </tr>
        </table>
    </div>
</div>