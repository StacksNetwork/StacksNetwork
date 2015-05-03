<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}{$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td>
        <table width="600" cellspacing="0" cellpadding="5" border="0" id="configoptionstable" class="editor-container">
            <tr id="serverlimitrow">
                <td width="190" align="right" style="ver">
                    <strong>{$options.serverlimit.name}:</strong>                        
                </td>
                <td id="config_serverlimit">
                    <input value="{if $default.serverlimit!==false}{$default.serverlimit}{elseif $options.serverlimit.default}{$options.serverlimit.default}{/if}" name="options[serverlimit]" id="serverlimit">
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="serverlimit"  />Allow client to select during order</span>
                </td>
            </tr>
            <tr id="quotatyperow" class="odd">
                <td width="190" align="right">
                    <strong>{$options.quotatype.name}</strong> 
                    <a href="#" class="vtip_description" title="{$options.quotatype.description}" ></a>
                </td>
                <td>
                    <div>
                        <select name="options[quotatype]" id="conf_opt_quotatype">
                            {foreach from=$options.quotatype.default item=item}
                                <option {if $default.quotatype == $item}selected="selected"{/if}>{$item}</option>
                            {/foreach}
                        </select>
                    </div>
                </td>
            </tr>
            <tr id="hardquotarow">
                <td width="190" align="right">
                    <strong>{$options.hardquota.name}</strong>                        
                </td>
                <td id="config_hardquota">
                    <input value="{if $default.hardquota!==false}{$default.hardquota}{elseif $options.hardquota.default}{$options.hardquota.default}{/if}" name="options[hardquota]" id="hardquota">
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="hardquota"  />Allow client to select during order</span>
                </td>
            </tr>
            <tr id="volumeprefixrow" class="odd">
                <td width="190" align="right">
                    <strong>{$options.volumeprefix.name}</strong>
                    <a href="#" class="vtip_description" title="{$options.volumeprefix.description}" ></a>                       
                </td>
                <td>
                    <input value="{if $default.volumeprefix!==false}{$default.volumeprefix}{elseif $options.volumeprefix.default}{$options.volumeprefix.default}{/if}" name="options[volumeprefix]">
                </td>
            </tr>
            <tr id="recoverypointrow">
                <td width="190" align="right">
                    <strong>{$options.recoverypoint.name}</strong>
                    <a href="#" class="vtip_description" title="{$options.recoverypoint.description}" ></a>
                </td>
                <td>
                    <input value="{if $default.recoverypoint!==false}{$default.recoverypoint}{elseif $options.recoverypoint.default}{$options.recoverypoint.default}{/if}" name="options[recoverypoint]">
                </td>
            </tr>
            <tr id="archivepointrow" class="odd">
                <td width="190" align="right">
                    <strong>{$options.archivepoint.name}</strong>
                    <a href="#" class="vtip_description" title="{$options.archivepoint.description}" ></a>
                </td>
                <td>
                    <input value="{if $default.archivepoint!==false}{$default.archivepoint}{elseif $options.archivepoint.default}{$options.archivepoint.default}{/if}" name="options[archivepoint]">
                </td>
            </tr>
            <tr id="replicationrow">
                <td width="190" align="right">
                    <strong>{$options.replication.name}</strong>
                    <a href="#" class="vtip_description" title="{$options.replication.description}" ></a>
                </td>
                <td id="config_replication">
                    <select name="options[replication]" id="replication" style="width:126px">
                        {foreach from=$options.replication.default item=item}
                            <option {if $default.replication == $item}selected="selected"{/if}>{$item}</option>
                        {/foreach}
                    </select>
                    <span class="fs11"><input type="checkbox" class="formchecker" rel="replication"  />Allow client to select during order</span>
                </td>
            </tr>
        </table>

        <script type="text/javascript">
            {literal}

                function lookforsliders() {
                    var pid = $('#product_id').val();
                    $('.formchecker').click(function() {
                        var tr = $(this).parents('tr').eq(0);
                        var rel = $(this).attr('rel').replace(/[^a-z_]/g, '');
                        if (!$(this).is(':checked')) {
                            if (!confirm('Are you sure you want to remove related Form element? ')) {
                                return false;
                            }
                            if ($('#configvar_' + rel).length) {
                                ajax_update('?cmd=configfields&make=delete', {
                                    id: $('#configvar_' + rel).val(),
                                    product_id: pid
                                }, '#configeditor_content');
                            }
                            //remove related form element
                            tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                            tr.find('input[id], select[id]').eq(0).removeAttr('disabled', 'disabled').show();
                            $(this).parents('span').eq(0).find('a.editbtn').remove();
                        } else {
                            //add related form element
                            var el = $(this);
                            var rel = $(this).attr('rel');
                            tr.find('input[id], select[id]').eq(0).attr('disabled', 'disabled').hide();
                            $.post('?cmd=services&action=product', {
                                make: 'importformel',
                                variableid: rel,
                                cat_id: $('#category_id').val(),
                                other: $('input, select', '#onapptabcontainer').serialize(),
                                id: pid,
                                server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                            }, function(data) {
                                var r = parse_response(data);
                                if (r && r.length>1) {
                                    el.parents('span').eq(0).append(r);
                                    ajax_update('?cmd=configfields', {product_id: pid, action: 'loadproduct'}, '#configeditor_content');
                                }
                            });
                        }
                    }).each(function() {
                        var rel = $(this).attr('rel').replace(/[^a-z_]/g, '');
                        if ($('#configvar_' + rel).length < 1)
                            return 1;
                        var fid = $('#configvar_' + rel).val();
                        var tr = $(this).attr('checked', 'checked').parents('tr').eq(0);
                        tr.find('input[id], select[id]').eq(0).attr('disabled', 'disabled').hide();
                        tr.find('.tofetch').addClass('disabled');
                        $(this).parents('span').eq(0).append(' <a href="#" onclick="return editCustomFieldForm(' + fid + ',' + pid + ')" class="editbtn orspace">Edit related form element</a>');
                    });
                }
            {/literal}
            {if $_isajax}
                setTimeout('lookforsliders()', 50);
            {else}appendLoader('lookforsliders');
            {/if}

        </script>
    </td>
</tr>
