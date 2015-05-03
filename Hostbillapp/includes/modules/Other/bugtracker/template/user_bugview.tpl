<div class="bordered-section article text-block clear clearfix">
    <h2 class="h-width">{$bug.subject} <a href="?cmd=bugtracker"  class="btn btn-mini right"><i class="icon-chevron-left"></i> {$lang.back}</a></h2>  
    <div class="ribbon form-horizontal">
<div class="control-group">
<label for="appendedPrependedInput" class="control-label left" style="width:auto">
<span class="label  label-info">{$bug.version}</span>
    {if $bug.category_name || $category.name}<span class="label">{$bug.category_name}{$category.name}</span>{/if}
    严重程度: <span class="label  {if $bug.votes>0}label-important{elseif $bug.votes<0}label-inverse{else}label-warning{/if}">{$bug.votes}</span>           
       
</label>
<div class="right">{if $bug.status=='Open'}
    <a href="?cmd=bugtracker&action=bug&id={$bug.id}&make=vote&security_token={$security_token}&vote=1" class="btn btn-success btn-large"><i class="icon-ok icon-white"></i> 我确认了!</a>
    <a href="?cmd=bugtracker&action=bug&id={$bug.id}&make=vote&security_token={$security_token}&vote=-1" class="btn btn-inverse btn-large"><i class="icon-remove icon-white"></i> 这没关系</a>
{else}
    <div style="padding-top:10px">
    <span class="label">{$bug.status}</span>
   {if $bug.resolved_version}修正版本:  <span class="label  label-success">{$bug.resolved_version}</span>{/if}
    </div>{/if}</div>
</div>
</div><div class="ribbon-shadow-l"></div><div class="ribbon-shadow-r"></div>
    
    <div class="p19">
          {if $bug.admin_comment}
          <div class="well"><strong>管理员评论:</strong><br/>{$bug.admin_comment}</div>
          {/if}
        <p >{$bug.description|nl2br}</p>
         <span class="annoucement_date right fs11" style="line-height:13px">
              提交日期 {$bug.date_created|dateformat:$date_format} <br/> 提交人 <b>{$bug.lastname}{$bug.firstname}</b></span>
         <div class="clear"></div>
         
       
    </div>
</div>