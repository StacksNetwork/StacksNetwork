<b>队列账单内容</b><br/>
{if !$items}
    <em>该客户尚无任何队列中的账单</em>
{else}
    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:10px" id="grab-sorter" >
        {foreach from=$items item=f}
            <li style="background:#ffffff">
                <div style="border-bottom:solid 1px #ddd;">
                    <table width="100%" cellspacing="0" cellpadding="5" border="0">
                        <tr>
                            <td>
                                <a href="#" onclick="return itemqueue.edit('{$f.id}','{$f.description|escape:'javascript'}','{$f.amount}','{$f.taxed}','{$f.qty}','{$f.rel_id}','{$f.note|escape:'javascript'}');">{$f.description|escape}</a>
                            </td>
                            <td style="width: 20%">
                                {$f.total|price:$client_currency}
                            </td>
                            <td style="width: 30%">
                                {if !$f.rel_id}
                                    对于任何服务
                                {else}
                                    {foreach from=$services item=service}
                                        {if $f.rel_id==$service.id}
                                            for <a href="?cmd=accounts&action=edit&id={$service.id}">#{$service.id} {$service.name}{if $service.domain} - {$service.domain}{/if}</a>
                                            {break}
                                        {/if}
                                    {/foreach}
                                {/if}
                            </td>
                            <td width="20" >
                                <a onclick=" if(confirm('您确定需要删除该内容吗?')) return itemqueue.del('{$f.id}'); return false;" class="delbtn" href="#">删除</a>
                            </td>
                        </tr>
                    </table>
                </div>
            </li>
        {/foreach}
    </ul>
{/if}
<div id="itemqueueform" style="display:none; background: white">
    <div style="padding: 5px">
        <h1>队列中添加新的项目</h1>
        <table cellpadding="5" cellspacing="0" style="width: 100%">
            <tr>
                <td align="right" width="160"><strong>{$lang.Description}</strong></td>
                <td><input type="text" name="queueitem[description]" class="inp" placeholder="项目名称与描述"  style="width:370px;"/></td>
            </tr>
            <tr>
                <td align="right" width="160"><strong>{$lang.Note}</strong></td>
                <td><textarea name="queueitem[note]" class="inp" placeholder="该项目的简短说明. 它会被复制到帐单注释" style="width:370px; height:4em"></textarea></td>
            </tr>
            <tr>
                <td align="right" ><strong>{$lang.price}</strong></td>
                <td >
                    <input type="text" name="queueitem[amount]"  class="inp" size="4"/> {if $client_currency.code}{$client_currency.code}{else}{$client_currency.iso}{/if}
                </td>
            </tr>
            <tr>
                <td align="right" ><strong>{$lang.qty}</strong></td>
                <td >
                    <input type="number" name="queueitem[qty]"  class="inp" size="4" min="1" value="1"/>
                </td>
            </tr>
            <tr>
                <td align="right"  ><strong>{$lang.tax}</strong></td>
                <td >
                    <input type="checkbox" name="queueitem[taxed]" class="inp" />
                </td>
            </tr>
            <tr>
                <td align="right"  ><strong>添加到下一张服务帐单</strong></td>
                <td >
                    <select name="queueitem[rel_id]" class="inp">
                        <option value="0">{$lang.Any}</option>
                        {foreach from=$services item=service}
                            <option value="{$service.id}">#{$service.id} {$service.name}{if $service.domain} {$service.domain}{/if}</option>
                        {/foreach}
                    </select>
                </td>
            </tr>
        </table>
        {securitytoken}
    </div>
    <div style=" background: #272727; box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.3); color: #FFFFFF; height: 20px; padding: 11px 11px 10px; clear:both">
        <div style="display: none;" class="left spinner">
            <img src="ajax-loading2.gif">
        </div>
        <div class="right">
            <span class="bcontainer ">
                {literal}
                    <a href="#" onclick="return itemqueue.add()" class="new_control greenbtn">
                        <span>保存</span>
                    </a>
                {/literal}
            </span>
            <span class="bcontainer">
                <a onclick="return itemqueue.close()" href="#" class="submiter menuitm">
                    <span>关闭</span>
                </a>
            </span>
        </div>
        <div class="clear"></div>
    </div>
</div>
{if !$forbidAccess.editClients}
<a href="#" class="menuitm right greenbtn" onclick="return itemqueue.form()"><span>添加内容</span></a>
{/if}
<div class="clear"></div>
{literal}
    <script type="text/javascript">
                    var itemqueue = {
                        form: function() {
                            $('input,select,textarea','#facebox').remove();
                            $.facebox({div: '#itemqueueform', width: 900, opacity: 0.8, nofooter: true, addclass: 'modernfacebox'});
                            return false;
                        },
                        add: function() {
                        var errors = false;
                            $('input,select,textarea', '#facebox .content').each(function(){
                                var that = $(this);
                                if(that.val().length < 1){
                                    that.css('box-shadow', '0px 0px 0px 1px #FF0000').focus(function(){that.css('box-shadow', '')});
                                    errors = true;
                                }
                            });
                            if(errors)
                                return false;
                            $('.spinner', '#facebox').show();
                            var data = $('input,select,textarea', '#facebox').serializeObject();
                            data['queueitem[item_id]'] = data['queueitem[rel_id]'];
                            $.post('?cmd=clients&action=itemqueue&client_id=' + $('#client_id').val(), data, function(data) {
                                $(document).trigger('close.facebox');
                                data = parse_response(data);
                                if (data && data.length > 2) {
                                    $('#itemqueue').html(data);
                                }
                            });
                            return false;
                        },
                        close: function() {
                            $(document).trigger('close.facebox');
                            return false;
                        },
                        del: function(item_id){
                            $('#itemqueue').addLoader();
                            $.post('?cmd=clients&action=itemqueue&client_id=' + $('#client_id').val(), {item_id:item_id, do:'delete'}, function(data) {
                                data = parse_response(data);
                                if (data && data.length > 2) {
                                    $('#itemqueue').html(data);
                                }
                            });
                        },
                        edit: function(id,description, amount, taxed, qty, item_id, note){
                            $('input,select,textarea','#facebox').remove();
                            $.facebox({div: '#itemqueueform', width: 900, opacity: 0.8, nofooter: true, addclass: 'modernfacebox'});
                            $('input,select,textarea', '#facebox').each(function(){
                                var that = $(this);
                                switch(that.attr('name')){
                                    case 'queueitem[description]': that.val(description); break;
                                    case 'queueitem[note]': that.val(note); break;
                                    case 'queueitem[amount]': that.val(amount); break;
                                    case 'queueitem[taxed]': that.prop('checked', taxed == '1'); break;
                                    case 'queueitem[qty]': that.val(qty); break;
                                    case 'queueitem[rel_id]': that.val(item_id); break;
                                }
                            });
                            $('#facebox').append('<input type="hidden" name="item_id" value="'+id+'" />');
                        }
                    }
    </script>
{/literal}