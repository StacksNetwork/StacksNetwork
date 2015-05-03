{if $action == 'createdraft'}
    {if $ajax}
        {include file='orders/ajax.add.tpl'}
    {else}
        <div class="blu" style="padding: 5px 0 8px 3px;">
            <a href="?cmd=orders" >
                <strong>&laquo; {$lang.backtoorders}</strong>
            </a>
        </div>
           
        <div class="order-draft">
             <h1>{$lang.newdraft} #{$draft.id}</h1>
                <div id="order_details">
                    {include file='orders/ajax.add.tpl' }
                </div>

                <h1>订单内容</h1>
                <form action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.edit(this); return false;">
                    <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                    <table width="100%" class="ordertable" cellpadding="3" cellspacing="0" border="0" >
                        <thead>
                            <tr >
                                <th style="width:30px"><img id="loadingindyk" style="display:none" src="{$template_dir}img/ajax-loader3.gif" /></th>
                                <th>
                                    <a name="order_items"></a>
                                    {$lang.Category}
                                </th>
                                <th >{$lang.Item}</th>
                                <th>{$lang.Configuration}</th>
                                <th style="width:100px">{$lang.Amount}</th>
                            </tr>
                        </thead>
                        <tbody class="order_items">
                            {include file='orders/ajax.add.tpl' make='getservice'}
                        </tbody>
                    </table>
                    <div class="p6 secondtd">
                        <a class="menuitm greenbtn" onclick="$(this).parents('form').submit(); return false;" >{$lang.savedraft|capitalize}</a>  
                        <a class="menuitm" href="?cmd={$cmd}&action={$action}&id={$draft_id}" >{$lang.revertchanges}</a>
                        <a class="menuitm menul" href="?cmd={$cmd}&action={$action}&id={$draft.id}&make=delete" onclick="return confirm('{$lang.deleteorderconfirm}');" ><span style="color:red">{$lang.deldraft}</span></a>    
                        &nbsp;<small>{$lang.whenfinished}</small>
                        <a class="menuitm" href="?cmd={$cmd}&action={$action}&id={$draft.id}&make=create" onclick="return order.confirm_unsaved('有一些未保存的更改, 您要继续吗?')" >{$lang.generatefromdraft}</a>
                

                        <div class="order_price right">{$draft.price.cost|price:$draft.currency}</div>
                        <div class="order_price_label right">{$lang.total}:</div>
                    </div>
                </form>
                
                <h1>添加新内容</h1>

                <ul id="tabbedmenu" class="tabs">
                    <li class="tpicker active"><a onclick="return false" href="#tab1">新的服务</a></li>
                    <li class="tpicker"><a onclick="return false" href="#tab2">现有服务</a> </li>
                </ul>
                <div class="tab_container">
                    <form class="tab" action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.additem(this); return false;">
                        <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                        <table width="100%" class="draft-input" cellpadding="3" cellspacing="0" border="0" >
                            <tbody>
                                <tr >
                                    <td style="width:160px">选择一个产品</td>
                                    <td>
                                        <select class="inp" style="min-width:160px" onchange="order.list_items(this)" name="items">
                                            <option value="service">{$lang.none}</option>
                                            <option value="service">{$lang.Service}</option>
                                            <option value="domain">{$lang.Domain}</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody id="order_item">
                                <tr ><td></td></td>
                            </tbody>
                        </table>
                    </form>
                    <form class="tab" action="?cmd={$cmd}&action={$action}&make=add" method="post" onsubmit="order.additem(this); return false;">
                        <input type="hidden" value="{$draft_id}" class="draft_id" name="id" />
                        <table width="100%" class="draft-input" cellpadding="3" cellspacing="0" border="0" >
                            <tbody>
                                <tr >
                                    <td style="width:160px">选择客户的服务内容</td>
                                    <td>
                                        <select class="inp client_services" style="min-width:160px" onchange="return order.load_service(this);" name="service">
                                            <option value="0">{$lang.none}</option>
                                            {foreach from=$clientservices item=item}
                                                <option value="{$item.id}">#{$item.id} {$item.name}{if $item.domain}({$item.domain}){/if}</option>
                                            {/foreach}
                                        </select>
                                    </td>
                                </tr>
                                <tr><td colspan="2" id="client_service"></td></tr>
                        </table>
                    </form>
                </div>
                <script type="text/javascript" src="{$template_dir}js/order.js?v={$hb_version}"></script>
                {literal}
                    <script type="text/javascript">
                        {/literal}
                        order.cmd = '{$cmd}';
                        order.action = '{$action}';
                        {literal}
                        order.cycle = {{/literal}h:'{$lang.h}',d:'{$lang.d}',w:'{$lang.w}',m:'{$lang.m}',q:'{$lang.q}',s:'{$lang.s}',a:'{$lang.a}',b:'{$lang.b}',t:'{$lang.t}',p4:'{$lang.p4}',p5:'{$lang.p5}'{literal}};
                        $(function(){
                            $('.order_items').delegate('input:not(.noevent), select:not(.noevent)', 'change', function(data){order.get_service($('.order_items').parents('form')[0]);} );
                            $('#tabbedmenu').TabbedMenu({elem:'.tab',picker:'li.tpicker',aclass:'active'});
                        });
                    </script>
                {/literal}
             <br/>
            {include file='_common/noteseditor.tpl'}
            <script type="text/javascript">AdminNotes.show();AdminNotes.hide();</script>
        </div>
        
        <div class="blu">
            <a href="?cmd=orders" ><strong>&laquo; {$lang.backtoorders}</strong></a>
        </div>
    {/if}
{/if}
