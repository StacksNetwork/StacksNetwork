{if $action=='getpackages'}

    {if $import_type == '2' || $import_type == '3'}
    <script type="text/javascript">
                {literal}
                    function getaccounts() {
                            $('#continue').val('{/literal}{$lang.Loading}{literal} ...');
                            $('#continue').attr("disabled", true);
                            return true;
                    }
                {/literal}

                </script>
        <div style="margin: auto;width: 500px;text-align: center; border:1px solid #DDDDDD;background:#FFFFDF;font-size:13px;padding:10px;">
            {$lang.import_type2}
            {if $no_products}<p style="color: red">{$lang.no_products_error}</p>{/if}
                    <form action="" method="post" onsubmit="{if $no_products}return false; {else}return getaccounts(){/if}">
                        <input type="hidden" name="import_type" value="{$import_type}" />
                        <input type="hidden" name="action" value="step2" />
                        <input type="hidden" value="{$server_id}" name="server_id" />

                        <input id="continue" type="submit" name="continue" value="{$lang.Continue} &raquo;" style="font-weight:bold; margin: 10px" {if $no_products}disabled="disabled"{/if} />
                    {securitytoken}</form>
        </div>

    {elseif $import_type == '1'}

        {if $packages}
        <ul>
            <li>{$lang.importplease1}</li>
            <li>{$lang.importplease2}</li>
            <li>{$lang.importplease3}</li>
        </ul>
            <script type="text/javascript">
                {literal}
                    function new_product(pkg_name,number) {
                        if($("input[name='package["+pkg_name+"][product]']:checked").val() == 'new') {
                            $('#new_product_'+number).show();
                        }
                        else {
                            $('#new_product_'+number).hide();
                        }
                    }

                    function switch_t(el,id) {
                            $('#free_b_'+id).hide();
                            $('#once_b_'+id).hide();
                            $('#recur_b_'+id).hide();
                            $('#'+$(el).attr('id')+'_b_'+id).show();
                    }

                    function getaccounts() {
                            if ($("input[class=check]:checked").length==0) {
                                alert('{/literal}{$lang.thereisnopackagesselected}{literal}');
                                return false;
                            }

                            $('#continue').val('{/literal}{$lang.Loading}{literal} ...');
                            $('#continue').attr("disabled", true);
                            $('#packages_list').addLoader();
                            return true;
                    }
                {/literal}

                </script>

                    <form action="" method="post" onsubmit="return getaccounts()">
                        <input type="hidden" name="import_type" value="1" />
                        <input type="hidden" value="{$server_id}" name="server_id" />

                        <table width="100%" cellspacing="0" cellpadding="3" border="0" class="glike">

                            <tr>
                                <th></th>
                                <th width="25%">{$lang.packagename}</th>
                                <th width="70%"></th>
                            </tr>
                            <tbody id="packages_list">
                            {foreach name=rows from=$packages item=pkg key=pkg_id}
                                <tr>
                                    <td valign="top"><input type="checkbox" class="check" value="{$pkg_id}" name="selected[]"/></td>
                                    <td valign="top">{$pkg.name} <input type="hidden" name="package[{$pkg_id}][name]" value="{$pkg.name}" /> {if $pkg.reseller}(reseller) <input type="hidden" name="package[{$pkg_id}][product_data][reseller]" value="1" /> <input type="hidden" name="package[{$pkg_id}][name_accounts]" value="{$pkg.name} (reseller)" />{else} <input type="hidden" name="package[{$pkg_id}][name_accounts]" value="{$pkg.name}" />{/if}</td>
                                    <td>
                                        {if $pkg.products}
                                            <input type="radio" checked="checked" name="package[{$pkg_id}][product]" value="old" onclick="new_product('{$pkg_id}',{$smarty.foreach.rows.iteration})" />{$lang.useexistingprod}:
                                            <select name="package[{$pkg_id}][product_id]">
                                                {foreach from=$pkg.products item=prod}<option value="{$prod.id}">{$prod.name}</option>{/foreach}
                                            </select>

                                            <input type="radio" name="package[{$pkg_id}][product]" value="new" onclick="new_product('{$pkg_id}',{$smarty.foreach.rows.iteration})" />{$lang.createnewprod}:<br />
                                            <div style="display: none; padding: 10px; margin: 10px" class="bordered" id="new_product_{$smarty.foreach.rows.iteration}">
                                                {$lang.Name}: <input name="package[{$pkg_id}][product_data][name]">
                                                {$lang.Type}: <select name="package[{$pkg_id}][product_data][type]">
                                                    {foreach from=$ptypes item=ptype}
                                                        <option value="{$ptype.id}" >
                                                        {assign var="descr" value="_hosting"}{assign var="bescr" value=$ptype.lptype}{assign var="baz" value="$bescr$descr"}
                                                        {if $lang.$baz}{$lang.$baz}{else}{$ptype.type}{/if}
                                                        </option>
                                                {/foreach}

                                                    </select>
                                                {$lang.Category}:
                                                    <select name="package[{$pkg_id}][product_data][category]">
                                                        {foreach from=$prod_categories item=cat}
                                                            <option value="{$cat.id}">{$cat.name}</option>
                                                        {/foreach}
                                                    </select>
                                                 {$lang.Tax}: <input type="checkbox" name="package[{$pkg_id}][product_data][tax]" value="1" />
                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="import_payment" style="margin-top: 5px">
                                                                  <tr>
                                                                    <td><strong>{$lang.paymenttype}</strong></td>
                                                                    <td><input type="radio" value="Free" name="package[{$pkg_id}][product_data][paytype]" checked="checked" id="free" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Free}</td>
                                                                    <td><input type="radio" value="Once" name="package[{$pkg_id}][product_data][paytype]" id="once" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Once}</td>
                                                                    <td><input type="radio" value="Regular" name="package[{$pkg_id}][product_data][paytype]" id="recur" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Recurring}</td>
                                                                  </tr>
                                                                </table>
                                                                <div id="free_b_{$smarty.foreach.rows.iteration}"></div>
                                                                <div id="once_b_{$smarty.foreach.rows.iteration}" {if $product.paytype!='Once'}style="display:none"{/if}>
                                                                  <table class="import_payment" border="0" cellpadding="1">
                                                                    <tr  style="text-align: center;">
                                                                      <td>{$lang.setupfee}</td>
                                                                      <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m_setup1]"/></td>
                                                                    </tr>
                                                                    <tr  style="text-align: center;">
                                                                      <td>{$lang.Price}</td>
                                                                      <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m1]"/></td>
                                                                    </tr>
                                                                  </table>
                                                                </div>
                                                                <div id="recur_b_{$smarty.foreach.rows.iteration}" {if $product.paytype!='Regular'}style="display:none"{/if}>
                                                                  <table class="import_payment" cellspacing="1" >
                                                                    <tbody>
                                                                      <tr  style="text-align: center; font-weight: bold;">
                                                                        <td width="80"/>
                                                                        <td width="80">{$lang.Monthly}</td>
                                                                        <td width="80">{$lang.Quarterly}</td>
                                                                        <td width="100">{$lang.SemiAnnually}</td>
                                                                        <td width="80">{$lang.Annually}</td>
                                                                        <td width="80">{$lang.Biennially}</td>
                                                                      </tr>
                                                                      <tr style="text-align: center;">
                                                                        <td>{$lang.setupfee}</td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m_setup]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][q_setup]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][a_setup]"/></td>
                                                                      </tr>
                                                                      <tr  style="text-align: center;">
                                                                        <td>{$lang.Price}</td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][q]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][a]"/></td>
                                                                      </tr>
                                                                    </tbody>
                                                                  </table>
                                                                </div>


                                            </div>
                                        {else}
                                                    {$lang.thereisnoproductsinhb}
                                                    <input type="hidden" name="package[{$pkg_id}][product]" value="new" />
                                                    <div style="padding: 10px; margin: 10px" class="bordered">
                                                        {$lang.Name}: <input name="package[{$pkg_id}][product_data][name]">
                                                {$lang.Type}: <select name="package[{$pkg_id}][product_data][type]">
                                                   {foreach from=$ptypes item=ptype}
                                                        <option value="{$ptype.id}" >
                                                        {assign var="descr" value="_hosting"}{assign var="bescr" value=$ptype.lptype}{assign var="baz" value="$bescr$descr"}
                                                        {if $lang.$baz}{$lang.$baz}{else}{$ptype.type}{/if}
                                                        </option>
                                                {/foreach}
                                                    </select>
                                                {$lang.Category}:
                                                    <select name="package[{$pkg_id}][product_data][category]">
                                                        {foreach from=$prod_categories item=cat}
                                                            <option value="{$cat.id}">{$cat.name}</option>
                                                        {/foreach}
                                                    </select>

                                                                <table border="0" cellpadding="0" cellspacing="0" width="100%" class="import_payment" style="margin-top: 5px">
                                                                  <tr>
                                                                    <td><strong>{$lang.paymenttype}</strong></td>
                                                                    <td><input type="radio" value="Free" name="package[{$pkg_id}][product_data][paytype]" checked="checked" id="free" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Free}</td>
                                                                    <td><input type="radio" value="Once" name="package[{$pkg_id}][product_data][paytype]" id="once" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Once}</td>
                                                                    <td><input type="radio" value="Regular" name="package[{$pkg_id}][product_data][paytype]" id="recur" onclick="switch_t(this,{$smarty.foreach.rows.iteration})"/>
                                                                      {$lang.Recurring}</td>
                                                                  </tr>
                                                                </table>
                                                                <div id="free_b_{$smarty.foreach.rows.iteration}"></div>
                                                                <div id="once_b_{$smarty.foreach.rows.iteration}" {if $product.paytype!='Once'}style="display:none"{/if}>
                                                                  <table class="import_payment" border="0" cellpadding="1">
                                                                    <tr  style="text-align: center;">
                                                                      <td>{$lang.setupfee}</td>
                                                                      <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m_setup1]"/></td>
                                                                    </tr>
                                                                    <tr  style="text-align: center;">
                                                                      <td>{$lang.Price}</td>
                                                                      <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m1]"/></td>
                                                                    </tr>
                                                                  </table>
                                                                </div>
                                                                <div id="recur_b_{$smarty.foreach.rows.iteration}" {if $product.paytype!='Regular'}style="display:none"{/if}>
                                                                  <table class="import_payment" cellspacing="1" >
                                                                    <tbody>
                                                                      <tr  style="text-align: center; font-weight: bold;">
                                                                        <td width="80"/>
                                                                        <td width="80">{$lang.Monthly}</td>
                                                                        <td width="80">{$lang.Quarterly}</td>
                                                                        <td width="80">{$lang.Annually}</td>
                                                                      </tr>
                                                                      <tr style="text-align: center;">
                                                                        <td>{$lang.setupfee}</td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m_setup]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][q_setup]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][a_setup]"/></td>
                                                                      </tr>
                                                                      <tr  style="text-align: center;">
                                                                        <td>{$lang.Price}</td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][m]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][q]"/></td>
                                                                        <td><input type="text" value="0.00" size="10" name="package[{$pkg_id}][product_data][a]"/></td>
                                                                      </tr>
                                                                    </tbody>
                                                                  </table>
                                                                </div>
                                                        </div>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                            </tbody>
                        </table>
                        <script type="text/javascript">
                            {literal}
                                setTimeout(function() {
                                    $('.check').unbind('click');
                                    $('.check').click(checkEl);
                                },40);
                            {/literal}
                        </script>
                        <input type="hidden" name="action" value="step2" />
                        <input id="continue" type="submit" name="continue" value="{$lang.Continue} &raquo;" style="font-weight:bold; margin: 10px" />
                    {securitytoken}</form>
                {else}
                    <p style="font-weight: bold; text-align: center">{$lang.thereisnopackagestodispl}</p>
                {/if}

    {else}
        <p style="font-weight: bold; text-align: center; color: red">{$lang.import_notsupported}</p>
    {/if}
{/if}

