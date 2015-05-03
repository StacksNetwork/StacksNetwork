<ul style="border:solid 1px #ddd;border-bottom:none;margin:15px" id="grab-sorter"> {foreach from=$bugs item=bug key=b}
<li style="background:#ffffff" class="power_row"><div style="border-bottom:solid 1px #ddd;">
<table width="100%" cellspacing="0" cellpadding="5" border="0">
<tbody><tr>
<td width="60" valign="top"><div style="padding:10px 0px;">
<a style="width:14px;"  class="menuitm menuf" href="?cmd=bugtracker&action=bandelete&id={$bug.id}&security_token={$security_token}" onclick="return confirm('您确定需要删除该Bug, 并拉黑提交人吗?');"><span class="rmsth">拉黑</span></a><!--
--><a onclick="return confirm('您确定要删除该Bug吗?');" title="delete" class="menuitm menul" href="?cmd=bugtracker&action=bugdelete&id={$bug.id}&security_token={$security_token}&category_id={$bug.category_id}"><span class="delsth"></span></a>
</div></td>

<td width="30" valign="middle" align="center" class="votes {if $bug.votes>0}important{elseif $bug.votes<0}inverse{else}warning{/if}">{$bug.votes}</td>
<td>
    <h3 class="inlineTags"><a href="?cmd=bugtracker&action=bug&id={$bug.id}" onclick="return showFacebox(this)">{if $bug.status!='Open'}<em style="color:gray">{/if}{$bug.subject}{if $bug.status!='Open'}</em><span style="margin-left:20px">{$bug.status}</span>{/if}</a></h3>
 <div class="fs11">
            版本: <span>{$bug.version}</span>
            {if $action!='category' && ( $bug.category_name || $category.name)}Category: <span class="label">{$bug.category_name}{$category.name}</span>{/if}
            {if $bug.resolved_version}修正:  <span class="label  label-success">{$bug.resolved_version}</span>{/if}
        </div>
</td>
<td width="150" style="background:#F0F0F3;color:#767679;font-size:11px" valign="top">{if $bug.firstname}报告: <b><a href="?cmd=clients&action=show&id={$bug.client_id}" target="_blank">{$bug.lastname} {$bug.firstname}</a></b>{/if}</td>
</tr>
</tbody></table></div></li>  
{foreachelse}
    <li style="background:#ffffff" class="power_row"><div style="border-bottom:solid 1px #ddd;">
 <center><h3>该分类尚无Bug提交.</h3></center>
        </div></li>  
       
{/foreach}
</ul>
{literal}
<style>
    .votes {font-weight: bold !important;font-size:14px;}
    .important {
        color:#b94a48;
        text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
        background:#f2dede;
        
    }
    .inverse {
        
    } 
    .warning {
        color:#c09853;
        text-shadow: 0 1px 0 rgba(255, 255, 255, 0.5);
        background:#fcf8e3;
    }
</style>
{/literal}