<tr>
    <td id="getvaluesloader">
        {if $test_connection_result}
            <span style="margin-left: 10px; font-weight: bold;text-transform: capitalize; color: {if $test_connection_result.result == 'Success'}#009900{else}#990000{/if}">
                {$lang.test_configuration}:
                {if $lang[$test_connection_result.result]}
                    {$lang[$test_connection_result.result]}
                {else}{$test_connection_result.result}
                {/if}
                {if $test_connection_result.error}: 
                    {$test_connection_result.error}
                {/if}
            </span>
        {/if}
    </td>
    <td id="onappconfig_">
        {include file="../../../includes/modules/Hosting/cloudstack2/productconf/productconfig.tpl"}
    </td>
</tr>