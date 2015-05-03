
<div class="bordered-section article text-block clear clearfix">
    {if $category}
            <h2>{$category.name}</h2>
    {else}
            <h2>发现Bug</h2>
{/if}
      
    <div class="ribbon form-horizontal">
<div class="control-group">
<label for="appendedPrependedInput" class="control-label left" style="width:auto">
  在使用我们服务时所碰到的Bug类问题.
</label>
<div class="right">
    <a href="?cmd=bugtracker&action=addbug" class="btn btn-success btn-large"><i class="icon-plus-sign icon-white"></i> 提交您发现的Bug</a>
</div>
</div>
</div><div class="ribbon-shadow-l"></div><div class="ribbon-shadow-r"></div>
    
    <div class="p19">
        
        
          <ul class="nav nav-tabs">
                <li {if !$category && $action!='mybugs' && $action!='category'}class="active"{/if}>
                        <a href="?cmd=bugtracker">首页</a>
                </li>
         {foreach from=$categories item=cat}
                <li {if $category.id==$cat.id}class="active"{/if}>
                        <a href="?cmd=bugtracker&action=category&id={$cat.id}">{$cat.name}</a>
                </li>
         {/foreach}
                <li {if $action=='mybugs'}class="active"{/if} >
                        <a href="?cmd=bugtracker&action=mybugs">我发现的Bug</a>
                </li>
	</ul>
        
        {foreach from=$bugs item=bug key=b}
    <blockquote>
        <h3><a href="?cmd=bugtracker&action=bug&id={$bug.id}">{if $bug.status!='Open'}<em style="color:gray">{/if}{$bug.subject}{if $bug.status!='Open'}</em>{/if}</a></h3> 
        <span class="label  label-info">{$bug.version}</span>
    {if $bug.category_name || $category.name}<span class="label">{$bug.category_name}{$category.name}</span>{/if}
    严重程度: <span class="label  {if $bug.votes>0}label-important{elseif $bug.votes<0}label-inverse{else}label-warning{/if}">{$bug.votes}</span>
    {if $bug.resolved_version}修正版本:  <span class="label  label-success">{$bug.resolved_version}</span>{/if}
    </blockquote>
    {foreachelse}
        
        <center><h3>该分类下暂时未发现Bug.</h3></center>
{/foreach}

        
    </div>
</div>