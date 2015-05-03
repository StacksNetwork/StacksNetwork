<h3>受影响的客户/服务</h3>


<label class="nodescr">受影响的客户</label>
<select name="related_client_id" onchange="changeClient($(this).val())">
    <option value="0">对客户无影响/尚未统计</option>
    {foreach from=$clients item=d key=k}
        <option value="{$d.id}" {if $d.id==$case.related_client_id}selected="selected"{/if}>#{$d.id} {$d.lastname} {$d.firstname}</option>
        {/foreach}
</select>
<div class="clear"></div>

<div id="clientcontainer" {if !$case.related_client_id}style="display:none"{/if}>
{include file='ajax.clientservices.tpl'}
</div>

{literal}
<script>
    function changeClient(id) {
        if(!id) {
            $('#clientcontainer').hide();
            return;
         }
            
            $('#clientcontainer').html('').show(); 
                ajax_update('?cmd=migration_manager&action=listservices&related_client_id='+id,'','#clientcontainer');
    }
    </script>
    {/literal}