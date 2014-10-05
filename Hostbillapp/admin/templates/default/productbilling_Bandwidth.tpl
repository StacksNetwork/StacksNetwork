<div id="Bandwidth_b" {if $product.paytype!='Bandwidth'}style="display:none"{/if} class="p5 boption">
{if $typetemplates.productconfig.bandwidth.replace}
    {include file=$typetemplates.productconfig.bandwidth.replace}
{else}


<div id="bandwidthmgr" >
    <div style="">

     {*   <b>以下变量可以被测量分析并出具自动化账单: <a title="注意: 填写收费标准如下, 您希望该产品套餐<b>遵循</b>的收费标准是什么. 结束的数量设置为 0 意味着 &无限; (无限的)
            <br/> 例如100GB流量/月对于本产品是免费的, 所有超出部分都应配置到计费账单表内." class="vtip_description"></a></b>
     <div class="clear"></div>
     *}
        

        

        <div class="clear"></div>
        <table width="100%" cellspacing="0" cellpadding="6" border="0">
            <tr>
                <td width="160" >生成使用账单</td>
                <td >
                    <select name="config[BandwidthCycle]" class="inp">
                        <option value="Monthly" {if $configuration.BandwidthCycle=='Monthly'}selected="selected"{/if}>{$lang.Monthly}</option>
                        <option value="Quarterly" {if $configuration.BandwidthCycle=='Quarterly'}selected="selected"{/if}>{$lang.Quarterly}</option>
                        <option value="Semi-Annually" {if $configuration.BandwidthCycle=='Semi-Annually'}selected="selected"{/if}>{$lang.SemiAnnually}</option>
                        <option value="Annually" {if $configuration.BandwidthCycle=='Annually'}selected="selected"{/if}>{$lang.Annually}</option>
                    </select>

                </td>
            </tr>
            <tr>
                <td width="160" style="background:#F0F0F3"></td>
                <td style="background:#F0F0F3"><input type="checkbox" id="bandwidth_by_client" value="1" onclick="importBandwidthForm()" /> 让客户在注册过程中选择自己的限制, 计费方式 & 价格.
                </td>
          </tr>
          <tr style="display:none" id="bwclient_info">
                <td style="background:#F0F0F3" colspan="2">
                    <em>禁用此选项请从 组件->表单 删除"计费方式"表单元素并保村.</em> <br/>
                    <b>关于超额的注意事项:</b> <a title="如果你让客户选择自己的上限值和测量方法, 平均价格将根据客户选择而自动计算. <br/>
                    I.e. 客户使用了 100Mbps 并限定了 $10USD 的价格, 他的平均价格将为 $0.1/Mb" class="vtip_description"></a>
                    
                </td>
          </tr>
              <tr class="bw_tohide">
                <td width="160" style="background:#F0F0F3">测量/计费方法</td>
                <td style="background:#F0F0F3">
                    <select name="config[BandwidthModel]" class="inp" onchange="change_measurement(this)">
                        <option value="95th" {if $configuration.BandwidthModel=='95th'}selected="selected"{/if}>95th 计费</option>
                        <option value="average" {if $configuration.BandwidthModel=='average'}selected="selected"{/if}>平均流量</option>
                        <option value="total" {if $configuration.BandwidthModel=='total'}selected="selected"{/if}>峰值带宽</option>
                    </select>

                </td>
            </tr>

              <tr class="bw_tohide">
                <td width="160" style="background:#F0F0F3">免费传输</td>
                <td style="background:#F0F0F3">
                    <input type="text" class="inp" size="4"  value="{if $configuration.BandwidthTransfer}{$configuration.BandwidthTransfer}{else}100{/if}" name="config[BandwidthTransfer]" id="config_tw_overage"/>
                    
                    <select name="config[BandwidthTransferUnitBytes]" class="inp" style="width:80px;{if $configuration.BandwidthModel!='total' || !$configuration.BandwidthModel}display:none;{/if}" id="byte">
                        <option value="MB" {if $configuration.BandwidthTransferUnit=='MB'}selected="selected"{/if}>MB</option>
                        <option value="GB" {if $configuration.BandwidthTransferUnit=='GB'}selected="selected"{/if}>GB</option>
                        <option value="TB" {if $configuration.BandwidthTransferUnit=='TB'}selected="selected"{/if}>TB</option>
                    </select>

                    <select name="config[BandwidthTransferUnitBits]" class="inp" style="width:80px;{if $configuration.BandwidthModel=='total' }display:none;{/if}" id="bit">
                        <option value="Mbit" {if $configuration.BandwidthTransferUnit=='Mbit'}selected="selected"{/if}>Mbps</option>
                        <option value="Gbit" {if $configuration.BandwidthTransferUnit=='Gbit'}selected="selected"{/if}>Gbps</option>
                    </select>
                    
                    <input type="checkbox" id="transfer_by_admin" value="1" onclick="importBandwidthForm('transfer_by_admin')" /> 分别设定每个帐号的基础
                </td>
            </tr>
  <tr class="bw_tohide">
                <td width="160" style="background:#F0F0F3">超额比例</td>
                <td style="background:#F0F0F3">
                   {$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.BandwidthOverage}{$configuration.BandwidthOverage}{else}0{/if}" name="config[BandwidthOverage]" id="config_bw_overage" />
                     {$currency.code}

                     per 1
                      <select name="config[BandwidthOverageUnitBytes]" class="inp" style="width:80px;{if $configuration.BandwidthModel!='total' || !$configuration.BandwidthModel}display:none;{/if}" id="obyte">
                        <option value="MB" {if $configuration.BandwidthOverageUnit=='MB'}selected="selected"{/if}>MB</option>
                        <option value="GB" {if $configuration.BandwidthOverageUnit=='GB'}selected="selected"{/if}>GB</option>
                        <option value="TB" {if $configuration.BandwidthOverageUnit=='TB'}selected="selected"{/if}>TB</option>
                    </select>

                    <select name="config[BandwidthOverageUnitBits]" class="inp" style="width:80px;{if $configuration.BandwidthModel=='total' }display:none;{/if}" id="obit">
                        <option value="Mbit" {if $configuration.BandwidthOverageUnit=='Mbit'}selected="selected"{/if}>Mbps</option>
                        <option value="Gbit" {if $configuration.BandwidthOverageUnit=='Gbit'}selected="selected"{/if}>Gbps</option>
                    </select>
                    
                    
                    <input type="checkbox" id="overage_by_admin" value="1"  onclick="importBandwidthForm('overage_by_admin')" /> 分别设定每个帐号的基础
                </td>
            </tr>
                <tr>
                    <td >设置费用</td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4"  value="{if $configuration.BandwidthSetupFee}{$configuration.BandwidthSetupFee}{else}0.00{/if}" name="config[BandwidthSetupFee]" /> {$currency.code}</td>
                </tr>
                <tr>
                    <td>固定的重复收费 <a title="固定值, 重复收费业务" class="vtip_description"></a></td>
                    <td>{$currency.sign} <input type="text" class="inp" size="4" value="{if $configuration.BandwidthRecurringFee}{$configuration.BandwidthRecurringFee}{else}0.00{/if}" name="config[BandwidthRecurringFee]" /> {$currency.code}</td>
                </tr>

        </table></div></div>

{literal}
<script type="text/javascript">
    function change_measurement(select) {
        $('#byte').hide();$('#bit').hide();
        $('#obyte').hide();$('#obit').hide();
        if($(select).val()=='95th' || $(select).val()=='average') {
            $('#bit').show();$('#obit').show();
        } else {
           $('#byte').show();$('#obyte').show();
        }
    }

    function importBandwidthForm(filename) {
       
        if($('#product_id').val()=='new') {
            alert('Please save your product first');
            return;
        }
        var field=false;
        switch(filename) {
            case 'transfer_by_admin':
                field= '#configvar_tw_override';
                break;
            case 'overage_by_admin':
                field= '#configvar_bw_override';
                break;
             default: 
               field='#configvar_bandwidth_method';
                filename = 'bandwidth_form';
                 $('#bwclient_info').show();
                 $('.bw_tohide').hide();
                break;
        }
         if($(field).length) {
                   $('#components_tab a').click();
                    editCustomFieldForm($(field).val(),$('#product_id').val());
                    return;
         }
       
        $.post('?cmd=coloutils&action=importbandwidthforms',{product_id:$('#product_id').val(),file:filename},function(){
           refreshConfigView($('#product_id').val());
           $('#components_tab a').click();
           
        });
        return;
    }
    $(document).ready(function(){
        if($('#configvar_bandwidth_method').length) {
           $('#bandwidth_by_client').attr('checked','checked');
           $('#bwclient_info').show();
           $('.bw_tohide').hide();
        }
        
        if($('#configvar_tw_override').length) {
           $('#transfer_by_admin').attr('checked','checked');
        }
        
        if($('#configvar_bw_override').length) {
           $('#overage_by_admin').attr('checked','checked');
        }
    });
    </script>
<style type="text/css">
    .scheme_container {
        margin:10px 0px 10px 80px;
        padding:10px;
        background:#F0F0F3;
        border-radius:5px;
        float:left;
        color:#767679;
    }
</style>
    {/literal}




 {/if}
</div>