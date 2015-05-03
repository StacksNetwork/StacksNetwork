<tr><td></td>
    <td ><div id="">


            <table border="0" width="600" class="editor-container" cellpadding="5" cellspacing="0" >
                <tbody>
                    <tr id="v4_subnet_sizerow">
                        <td align="right" width="190">
                            <strong>IPv4子网大小:</strong>                        </td>
                        <td>
                            <div class="editor" style="display: block;">
                                <select id="conf_opt_v4_subnet_size" name="options[v4_subnet_size]">
                                    <option value="0" {if $default.v4_subnet_size=='0'}selected="selected"{/if}>无 (0 ips)</option>
                                    <option value="/32"  {if $default.v4_subnet_size=='/32'}selected="selected"{/if}>/32 (1)</option>
                                    <option value="/31" {if $default.v4_subnet_size=='/31'}selected="selected"{/if}>/31 (2)</option>
                                    <option value="/30" {if $default.v4_subnet_size=='/30'}selected="selected"{/if}>/30 (4)</option>
                                    <option value="/29" {if $default.v4_subnet_size=='/29'}selected="selected"{/if}>/29 (8)</option>
                                    <option value="/28" {if $default.v4_subnet_size=='/28'}selected="selected"{/if}>/28 (16)</option>
                                    <option value="/27" {if $default.v4_subnet_size=='/27'}selected="selected"{/if}>/27 (32)</option>
                                    <option value="/26" {if $default.v4_subnet_size=='/26'}selected="selected"{/if}>/26 (64)</option>
                                    <option value="/25" {if $default.v4_subnet_size=='/25'}selected="selected"{/if}>/25 (128)</option>
                                    <option value="/24" {if $default.v4_subnet_size=='/24'}selected="selected"{/if}>/24 (256)</option>
                                    <option value="/23" {if $default.v4_subnet_size=='/23'}selected="selected"{/if}>/23 (512)</option>
                                    <option value="/22" {if $default.v4_subnet_size=='/22'}selected="selected"{/if}>/22 (1024)</option>
                                </select>
                            </div>    
                        </td>
                    </tr>
                    <tr class="odd" id="v6_subnet_sizerow">
                        <td align="right" width="190">
                            <strong>IPv6子网大小:</strong>                        </td>
                        <td>

                            <div class="editor" style="display: block;">
                                <select id="conf_opt_v6_subnet_size" name="options[v6_subnet_size]">
                                    <option value="0" {if $default.v6_subnet_size=='0'}selected="selected"{/if}>无 (0 ips)</option>
                                    <option value="/128" {if $default.v6_subnet_size=='/128'}selected="selected"{/if}>/128 (1)</option>
                                    <option value="/127" {if $default.v6_subnet_size=='/127'}selected="selected"{/if}>/127 (2)</option>
                                    <option value="/126" {if $default.v6_subnet_size=='/126'}selected="selected"{/if}>/126 (4)</option>
                                    <option value="/125" {if $default.v6_subnet_size=='/125'}selected="selected"{/if}>/125 (8)</option>
                                    <option value="/124" {if $default.v6_subnet_size=='/124'}selected="selected"{/if}>/124 (16)</option>
                                    <option value="/123" {if $default.v6_subnet_size=='/123'}selected="selected"{/if}>/123 (32)</option>
                                    <option value="/122" {if $default.v6_subnet_size=='/122'}selected="selected"{/if}>/122 (64)</option>
                                    <option value="/121" {if $default.v6_subnet_size=='/121'}selected="selected"{/if}>/121 (128)</option>
                                    <option value="/120" {if $default.v6_subnet_size=='/120'}selected="selected"{/if}>/120 (256)</option>
                                    <option value="/119" {if $default.v6_subnet_size=='/119'}selected="selected"{/if}>/119 (512)</option>
                                    <option value="/118" {if $default.v6_subnet_size=='/118'}selected="selected"{/if}>/118 (1024)</option>
                                </select>
                            </div>    
                        </td>
                    </tr>
                    
                    <tr class="odd" id="auto_vlanrow">
                        <td align="right" width="190">
                            <strong>自动配置VLAN:</strong>                        </td>
                        <td>
                            <div class="editor" style="display: block;">
                                <input id="conf_opt_auto_vlan" type="checkbox" {if $default.auto_vlan}checked="checked"{/if} name="options[auto_vlan]">
                            </div>    
                        </td>
                    </tr>
                    
                    <tr id="v4_subnet_size_privrow">
                        <td align="right" width="190">
                            <strong>私网IPv4子网大小:</strong>                        </td>
                        <td>
                            <div class="editor" style="display: block;">
                                <select id="conf_opt_v4_subnet_size_priv" name="options[v4_subnet_size_priv]">
                                    <option value="0" {if $default.v4_subnet_size_priv=='0'}selected="selected"{/if}>无(0 ips)</option>
                                    <option value="/32"  {if $default.v4_subnet_size_priv=='/32'}selected="selected"{/if}>/32 (1)</option>
                                    <option value="/31" {if $default.v4_subnet_size_priv=='/31'}selected="selected"{/if}>/31 (2)</option>
                                    <option value="/30" {if $default.v4_subnet_size_priv=='/30'}selected="selected"{/if}>/30 (4)</option>
                                    <option value="/29" {if $default.v4_subnet_size_priv=='/29'}selected="selected"{/if}>/29 (8)</option>
                                    <option value="/28" {if $default.v4_subnet_size_priv=='/28'}selected="selected"{/if}>/28 (16)</option>
                                    <option value="/27" {if $default.v4_subnet_size_priv=='/27'}selected="selected"{/if}>/27 (32)</option>
                                    <option value="/26" {if $default.v4_subnet_size_priv=='/26'}selected="selected"{/if}>/26 (64)</option>
                                    <option value="/25" {if $default.v4_subnet_size_priv=='/25'}selected="selected"{/if}>/25 (128)</option>
                                    <option value="/24" {if $default.v4_subnet_size_priv=='/24'}selected="selected"{/if}>/24 (256)</option>
                                    <option value="/23" {if $default.v4_subnet_size_priv=='/23'}selected="selected"{/if}>/23 (512)</option>
                                    <option value="/22" {if $default.v4_subnet_size_priv=='/22'}selected="selected"{/if}>/22 (1024)</option>
                                </select>
                            </div>    
                        </td>
                    </tr>
                    <tr class="odd" id="v6_subnet_size_privrow">
                        <td align="right" width="190">
                            <strong>私网IPv6子网大小:</strong>                        </td>
                        <td>

                            <div class="editor" style="display: block;">
                                <select id="conf_opt_v6_subnet_size_priv" name="options[v6_subnet_size_priv]">
                                    <option value="0" {if $default.v6_subnet_size_priv=='0'}selected="selected"{/if}>无(0 ips)</option>
                                    <option value="/128" {if $default.v6_subnet_size_priv=='/128'}selected="selected"{/if}>/128 (1)</option>
                                    <option value="/127" {if $default.v6_subnet_size_priv=='/127'}selected="selected"{/if}>/127 (2)</option>
                                    <option value="/126" {if $default.v6_subnet_size_priv=='/126'}selected="selected"{/if}>/126 (4)</option>
                                    <option value="/125" {if $default.v6_subnet_size_priv=='/125'}selected="selected"{/if}>/125 (8)</option>
                                    <option value="/124" {if $default.v6_subnet_size_priv=='/124'}selected="selected"{/if}>/124 (16)</option>
                                    <option value="/123" {if $default.v6_subnet_size_priv=='/123'}selected="selected"{/if}>/123 (32)</option>
                                    <option value="/122" {if $default.v6_subnet_size_priv=='/122'}selected="selected"{/if}>/122 (64)</option>
                                    <option value="/121" {if $default.v6_subnet_size_priv=='/121'}selected="selected"{/if}>/121 (128)</option>
                                    <option value="/120" {if $default.v6_subnet_size_priv=='/120'}selected="selected"{/if}>/120 (256)</option>
                                    <option value="/119" {if $default.v6_subnet_size_priv=='/119'}selected="selected"{/if}>/119 (512)</option>
                                    <option value="/118" {if $default.v6_subnet_size_priv=='/118'}selected="selected"{/if}>/118 (1024)</option>
                                </select>
                            </div>    
                        </td>
                    </tr>
                    
                    <tr class="odd" id="auto_vlan_privrow">
                        <td align="right" width="190">
                            <strong>自动划分私有VLAN:</strong>                        </td>
                        <td>
                            <div class="editor" style="display: block;">
                                <input id="conf_opt_auto_vlan_priv" type="checkbox" {if $default.auto_vlan_priv}checked="checked"{/if} name="options[auto_vlan_priv]">
                            </div>    
                        </td>
                    </tr>

                    <tr class="odd">
                        <td align="right" width="190">
                            <a onclick="return preconfig_forms();"  class="new_control" href="#"><span class="gear_small">自动添加表单字段</span></a>
                        </td>
                        <td>

                            <div id="preconfigure_option">
                                注意: 您的客户可以选择使用表单中的子网类型, 如果添加相关元素组成的新字段, 则上述设置将会失效.<br/>

                            </div>    
                        </td>
                    </tr>


                </tbody></table>
                {literal}


                <script type="text/javascript">

         function preconfig_forms() {
             if ($('#configvar_ip4size').length || $('#configvar_ip6size').length) {
                 alert('表单元素已存在, 请在新建之前先删除旧的元素');
                 return false;
             }
             $.post('?cmd=ip_provisioning&action=preconfigure',
                     {
                         id: $('#product_id').val(),
                         cat_id: $('#category_id').val()
                     }, function(data) {
                 var r = parse_response(data);
                 ajax_update('?cmd=configfields', {product_id: $('#product_id').val(), action: 'loadproduct'}, '#configeditor_content');
             });
             return false;
         }

                </script>

            {/literal}

        </div>

    </td>
</tr>

