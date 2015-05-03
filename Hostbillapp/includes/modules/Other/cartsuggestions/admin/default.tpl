
<div id="newshelfnav" class="newhorizontalnav" style="margin-top: -32px; position: relative;">
    <div class="list-1">
        <ul>
            <li class="active last">
                <a {if $action != 'default'} href="?cmd={$modulename}"{/if}><span>购物车建议</span></a>
            </li>
        </ul>
    </div>
    <div class="list-2">
        <div class="subm1" style="display: block; height: 20px;">
        </div>
    </div>
</div>
{if $list}
    <div >
        <form id="suggestform" method="post" action="?cmd={$modulename}">
        <table class="whitetable" width="100%" cellspacing=0>
            <tr>
                <th style="width: 20px"></th>
                <th>名称</th>
                <th style="width: 77px; text-align: center">禁用</th>
                <th style="width: 77px; text-align: center">启用</th>
                <th style="width: 77px; text-align: center">始终显示</th>
                <th style="width: 20px;"></th>
            </tr>
            {foreach from=$list item=category}
                {if $category.ctype != 'domain'}
                    <tbody>
                        <tr><td></td></tr>
                        <tr class="havecontrols {if $category.suggestions == '1'}disabled{elseif $category.suggestions == '2'}forced{/if}">
                            <td colspan="2">
                                <a href="?cmd=services&action=category&id={$category.id}" >{$category.name}</a>
                            </td>
                            <td align="center"><input type="radio" name="category[{$category.id}]" {if $category.suggestions == '1'}checked="checked"{/if} value="1"/></td>
                            <td align="center"><input type="radio" name="category[{$category.id}]" {if !$category.suggestions || $category.suggestions == '0'}checked="checked"{/if} value="0"/></td>
                            <td align="center"></td>
                            <td><img style="display: none; position: absolute; background: white; border: 1px solid white;" src="{$template_dir}img/ajax-loader3.gif" /></td>
                        </tr>
                        {foreach from=$category.products item=product name=list}
                            <tr class="havecontrols {if $product.suggestions == '1'}disabled{elseif $product.suggestions == '2'}forced{/if}">
                                <td>{if $smarty.foreach.list.last}&boxur;{else}&boxvr;{/if}</td>
                                <td>
                                    <a href="?cmd=services&action=product&id={$product.id}" >{$product.name}</a>
                                </td>
                                <td align="center"><input type="radio" name="product[{$product.id}]" {if $product.suggestions == '1'}checked="checked"{/if} value="1"/></td>
                                <td align="center"><input type="radio" name="product[{$product.id}]" {if !$product.suggestions || $product.suggestions == '0'}checked="checked"{/if} value="0"/></td>
                                <td align="center"><input type="radio" name="product[{$product.id}]" {if $product.suggestions == '2'}checked="checked"{/if} value="2"/></td>
                                <td><img style="display: none; position: absolute; background: white; border: 1px solid white;" src="{$template_dir}img/ajax-loader3.gif" /></td>
                            </tr>
                        {/foreach}
                    </tbody>
                {/if}
            {/foreach}
        </table>
        </form>
    </div>
    {literal}
    <script type="text/javascript">
        $('.havecontrols input').change(function(){
            var that = $(this),
                tr = that.parents('tr').eq(0),
                data = that.serializeObject();
            data.action = 'change';
            var img = tr.find('img').show().offset(that.offset());
            $.post($('#suggestform').prop('action'), data, function(){
                img.hide();
                var newclass = that.val() == '1' ? 'havecontrols disabled' : (that.val() == '2' ? 'havecontrols forced' : 'havecontrols');
                tr.attr('class', newclass);
                if(tr.is(':nth-child(2)')){
                    tr.nextAll().attr('class', newclass).find('input[value='+that.val()+']').prop('checked', true);                    
                }
            });
        });
    </script>
    <style>
        .havecontrols.disabled td{
            background: #f5f5f5;
            font-style: italic;
        }
        .havecontrols.forced td{
            background: #FFFED1;
        }
        .havecontrols.forced:hover td{
            background: #FFF9B8  !important;
        }
    </style>
    {/literal}
{else}
    <div class="blank_state blank_kb">
        <div class="blank_info">
            <h1>购物车建议</h1>
            首先您需要添加一些商品.
            <div class="clear"></div>
            <a style="margin-top:10px" href="?cmd=services" class="new_add new_menu">
                <span>添加新商品</span></a>
            <div class="clear"></div>
        </div>
    </div>
{/if}