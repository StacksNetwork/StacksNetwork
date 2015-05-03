<script type="text/javascript" src="{$template_dir}js/facebox/facebox.js"></script>
 <link rel="stylesheet" href="{$template_dir}js/facebox/facebox.css" type="text/css" />
 <div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li {if !$action || $action == 'default'}class="active"{/if}>
                <a href="?cmd=bugtracker"><span>最紧急的bug</span></a>
            </li>
            <li class="{if $action == 'categories' || $action=='category' || $action=='bug' || $action=='addcategory'}active{/if}">
                <a href="?cmd=bugtracker&action=categories"><span>分类</span></a>
            </li>
            <li class="{if $action == 'changelog'} active{/if}">
                <a href="?cmd=bugtracker&action=changelog"><span>更新日志</span></a>
            </li>
            <li class=" {if $action == 'clientbans'} active{/if}">
                <a href="?cmd=bugtracker&action=clientbans"><span>用户黑名单</span></a>
            </li>
            <li class="last">
                <a href="?cmd=bugtracker&action=quickfix" onclick="return showFacebox(this)"><span style="color:red">报告 &amp; 修正</span></a>
            </li>
        </ul>
    </div>{if $action == 'categories' || $action=='category' || $action=='bug' || $action=='addcategory'} 
                <div class="list-2">
                <div class="subm1 haveitems" style="">
                    <ul>
                    <li {if $action=='addcategory'}class="picked"{/if}><a href="?cmd=bugtracker&action=addcategory"><span><b>添加分类</b></span></a></li>
                    {foreach from=$categories item=cat}
                        <li {if $category.id==$cat.id}class="picked"{/if}>
                                <a href="?cmd=bugtracker&action=category&id={$cat.id}"><span>{$cat.name}</span></a>
                        </li>
                 {/foreach}
                    </ul>
                </div>

                </div>
                {/if}
</div>
{if !$action || $action == 'default' || $action == 'category'} 
    {include file='buglist.tpl'}
    {if $action=='category'}
        <div style="margin-left:15px"><a style="width:14px;"  class="menuitm" href="?cmd=bugtracker&action=category&make=delete&id={$category.id}&security_token={$security_token}" onclick="return confirm('您确定要删除该分类以及被提交于该分类下的所有Bug内容吗?');"><span class="rmsth">删除该分类</span></a>
        <br/><br/></div>
 {/if}
{elseif $action=='addcategory' || $action=='categories'}
    {include file='addcategory.tpl'}
{elseif $action=='bug'}
{elseif $action=='changelog'}
    {include file='changelog.tpl'}
{elseif $action=='clientbans'}
    {include file='clientbans.tpl'}
{/if}

    {literal}
        <script> 
   
function showFacebox(el) {
            $.facebox({ ajax: $(el).attr('href'),width:900,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
            return false;
                }</script>
    {/literal}