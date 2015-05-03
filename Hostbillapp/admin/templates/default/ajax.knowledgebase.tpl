{if $action=='browser'}
    {if $category}
        <ul class="filetree treeview" id="browser2">

            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last}lastExpandable{/if}" id="kbfolder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=knowledgebase&action=getcat2&cid={$cat.id}">{$cat.name}</a>
                    </li>
                {/foreach}
            {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>
    {else}
        {$lang.nothingtodisplay} - <a href="?cmd=knowledgebase&action=addcategory">{$lang.addnewcat}</a> {$lang.tostart}.
    {/if}

{elseif $action=='getcat'}
    {if $category.name}
        <div class="hitarea collapsable-hitarea "></div><a class="folder" href="?cmd=knowledgebase&action=getcat&cid={$category.id}">{$category.name}</a> <a href="?cmd=knowledgebase&action=addarticle&cat_id={$category.id}" class="edit " style="margin-right:10px;">{$lang.addarticle}</a> <a href="?cmd=knowledgebase&action=category&cid={$category.id}" class="edit ">{$lang.Edit}</a> <a href="?cmd=knowledgebase&make=categorydelete&security_token={$security_token}&id={$category.id}" class="edit editbtn" onclick="return confirm('{$lang.deletecategoryconfirm}')">{$lang.delete}</a>

        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable{/if}" id="folder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=knowledgebase&action=getcat&cid={$cat.id}">{$cat.name}</a>
                        <a href="?cmd=knowledgebase&action=addarticle&cat_id={$cat.id}" class="edit " style="margin-right:10px;">{$lang.addarticle}</a> <a href="?cmd=knowledgebase&action=category&cid={$cat.id}" class="edit ">{$lang.Edit}</a> <a href="?cmd=knowledgebase&make=categorydelete&id={$cat.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.deletecategoryconfirm}')">{$lang.delete}</a></li>
                    {/foreach}
                {/if}

            {if $category.posts}
                {foreach from=$category.posts item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}"><a class="file" href="?cmd=knowledgebase&action=article&id={$rep.id}">{$rep.title}</a>
                        <a href="?cmd=knowledgebase&make=articledelete&id={$rep.id}&security_token={$security_token}" class="edit editbtn" onclick="return confirm('{$lang.deletearticleconfirm}')">{$lang.delete}</a> {$rep.body}</li>
                    {/foreach}
                {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>

    {/if}
{elseif $action=='getcat2'}
    {if $category.name}	
        <div class="hitarea collapsable-hitarea "></div><a class="folder" href="?cmd=knowledgebase&action=getcat2&cid={$category.id}">{$category.name}</a>
        <ul>
            {if $category.categories}
                {foreach from=$category.categories item=cat name=checklast}
                    <li class="closed expandable {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable{/if}" id="kbfolder_{$cat.id}">
                        <div class="hitarea closed-hitarea expandable-hitarea {if $smarty.foreach.checklast.last && !$category.posts}lastExpandable-hitarea{/if}"></div>
                        <a class="folder" href="?cmd=knowledgebase&action=getcat2&cid={$cat.id}" >{$cat.name}</a>
                    </li>
                {/foreach}
            {/if}

            {if $category.posts}
                {foreach from=$category.posts item=rep name=rechecklast}
                    <li class="{if $smarty.foreach.rechecklast.last}last{/if}">
                        <a class="file fil2" href="?cmd=knowledgebase&action=article&id={$rep.id}" rel="{$rep.id}">{$rep.title}</a> {$rep.body}
                    </li>
                {/foreach}
            {/if}
        </ul>
        <script type="text/javascript">bindPredefinied();</script>

    {/if}	


{elseif $action=='getr' && $getid}

    {$system_url}index.php?cmd=knowledgebase&action=article&id={$getid}
{elseif $action=='default'}
    <h4>
        {if !$categories.parent_cat && $categories.parent_cat != '0'}
            顶级分类
        {else}
            <a class="loadsubact" href="?cmd=knowledgebase">Top Category</a>
        {/if}
        {foreach from=$path item=cat}
            &raquo; <a class="loadsubact" href="?cmd=knowledgebase&cid={$cat.id}">{$cat.name}</a>
        {/foreach}
    </h4> 

    <ul class="grab-sorter">
        {foreach from=$categories.categories item=cat name=loop}
            <li class="{if $smarty.foreach.loop.index%2==0}even{/if} sortable">
                <div class="actions">
                    <input type="hidden" name="order[cat][{$cat.id}]" value="{$cat.sort_order}" class="sort-order"/>
                    <a href="#" onclick="return false" class="sorter-handler menuitm menuf"><span class="movesth" title="move">&nbsp;</span></a>{*
                    *}<a title="edit" href="?cmd=knowledgebase&action=category&cid={$cat.id}" class="menuitm menuc"><span class="editsth"></span></a>{*
                    *}<a onclick="return confirm('{$lang.deletecategoriesconfirm}')"
                       href="?cmd=knowledgebase&make=categorydelete&id={$cat.id}&security_token={$security_token}" title="delete" class="menuitm menul"><span class="delsth"></span></a>    
                </div>
                <div class="name"><a class="loadsubact" href="?cmd=knowledgebase&cid={$cat.id}">{$cat.name}</a></div>
                <div class="lastitm-art fs11">
                    {$cat.description|strip_tags|escape|truncate:255}
                </div>
            </li>
        {/foreach}
        <li class="{if $smarty.foreach.loop.index%2!=0}even{/if}">
            <div class="name">
                <a href="?cmd=knowledgebase&action=addcategory&parent_cat={$categories.id}" class="menuitm" title="{$lang.addnewcat}" >
                    <span class="addsth"></span> {$lang.addnewcat}
                </a>
            </div>
        </li>
    </ul>

    {if $categories.id || $categories.posts}
        <h4>Articles</h4>
        <ul class="grab-sorter">
            {foreach from=$categories.posts item=rep name=loop}
                <li class="{if $smarty.foreach.loop.index%2==0}even{/if} sortable">
                    <div class="actions">
                        <input type="hidden" name="order[art][{$rep.id}]" value="{$cat.sort_order}" class="sort-order"/>
                        <a href="#" onclick="return false" class="sorter-handler menuitm menuf"><span class="movesth" title="move">&nbsp;</span></a>{*
                        *}<a title="edit" href="?cmd=knowledgebase&action=article&id={$rep.id}"" class="menuitm menuc"><span class="editsth"></span></a>{*
                        *}<a onclick="return confirm('{$lang.deletearticleconfirm}')"
                           href="?cmd=knowledgebase&make=articledelete&id={$rep.id}&security_token={$security_token}" title="delete" class="menuitm menul"><span class="delsth"></span></a>    
                    </div>
                    <div class="name">{$rep.title}</div>
                    <div class="lastitm-art fs11">
                        阅读: {if $rep.views}{$rep.views}{else}0{/if}<br>
                        文章: {$rep.body}
                    </div>
                </li>
            {/foreach}
            {if $categories.id}
                <li class="{if $smarty.foreach.loop.index%2!=0}even{/if}">
                    <div class="name">
                        <a href="?cmd=knowledgebase&action=addarticle&cat_id={$categories.id}" class="menuitm" title="{$lang.addnewarticle}" >
                            <span class="addsth"></span> {$lang.addnewarticle}
                        </a>
                    </div>
                </li>
            {/if}
        </ul>
    {/if}
    {literal}
    <script type="text/javascript">
        $(function() {
            $(".grab-sorter").dragsort({
                dragSelector: "a.sorter-handler",
                dragBetween: false,
                itemSelector: 'li.sortable',
                placeHolderTemplate: "<li class='placeHolder'></li>",
                dragEnd: set_sort
            });
        });
    </script>
    {/literal}
{/if}
{if $action=='browser' || $action=='getcat2'}
    {literal}
        <script type="text/javascript">
            $("a.fil2", "#suggestion").unbind("click").bind("click", function() {
                $.post('?cmd=knowledgebase', {action: 'getr', id: $(this).attr('rel')}, function(data) {
                    data = parse_response(data);
                    $('#replyarea').val($('#replyarea').val() + "\r\n" + data).focus();
                });
                return false;
            });
        </script>
    {/literal}
{/if}