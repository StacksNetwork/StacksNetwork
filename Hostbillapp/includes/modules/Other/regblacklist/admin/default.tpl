{literal}
<style type="text/css">
	#newshelf a.picked {background: #FFFFFF !important; }	
	p#vtip{max-width: none;}
	#bodycont > .blu  {display:none}
</style>
<script type="text/javascript">
	$(function(){
		$('#newshelfnav .list-1 li').each(function(i){
			$(this).click(function(){
				$('#newshelfnav .list-1 li').removeClass('active').eq(i).addClass('active');
				$('.selectable').hide().eq(i).show();
			});
		});
		$('.legend').siblings().hide();
		$('.legend').click(function(){
			$(this).siblings().toggle();
		});
	});
</script> 
{/literal}
<div id="newshelfnav" class="newhorizontalnav">
	<div class="list-1">
		<ul>
			<li {if !$tab || $tab==0}class="active"{/if}>
				<a href="#"><span>Email黑名单</span></a>
			</li>
			<li {if $tab && $tab==1}class="active"{/if}>
				<a href="#"><span>IP黑名单</span></a>
			</li>
			<li {if $tab && $tab==2}class="active"{/if}>
				<a href="#"><span>禁言的信息</span></a>
			</li>
		</ul>
	</div>
</div>
<div id="email" class="selectable" {if $tab && $tab!=0}style="display:none"{/if}>
	<div style="margin:10px" class="p6">
		<strong>黑名单Emails</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="add" />
			{$lang.add} 
			<input type="text" name="site" /> <input type="submit" value="{$lang.submit}" />
		</form>
	</div>
	<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" >
		<tr>
			<th >规则</th>
			<th width="20"></th>
		</tr>
	{if !$emailrule}
		<tr>
			<td colspan="2">没有可显示的内容</td>
		</tr>
	{else}{foreach from=$emailrule item=site}
		<tr>
			<td>{$site.rule} </td>
			<td>
				<a class="delbtn" onclick="return remove_bannedemail($(this).attr('href'))"href="?cmd=module&module={$moduleid}&site={$site.id}&make=delete">移除</a>
			</td>
		</tr>
	{/foreach}
	{/if}
	</table>
	<div style="min-height:1em;padding:10px" class="sectionfoot nicerblu">
		<h3 class="legend" style="margin:5px 0 2px;cursor:pointer">图例<img src="{$template_dir}img/question-small-white.png" /></h3>
		<ul style="list-style:inside;padding:0">
		规则格式:
		<li> <strong>name@domain.com</strong> - 匹配1个邮箱</li>
		<li> <strong>domain.com</strong> - 匹配指定域名下的所有邮箱</li>
		<li> <strong>domain</strong> - 匹配所有包含这个字符串域名</li></li>
		</ul>
		<ul style="list-style:inside;padding:0">
		范例格式:
		<li><strong>foo@yahoo.com</strong> 仅会限制 foo@yahoo.com 邮箱注册. </li>
		<li><strong>yahoo.ca</strong> 会限制 yahoo.ca 注册, 不影响 yahoo.com 或 yahoo.de 等. </li>
		<li><strong>yahoo</strong> 将会限制 yahoo.com/yahoo.ca/subyahoo.de. 等注册</li>
		</ul>
	</div>
</div>
<div id="ip"  class="selectable" {if !$tab || $tab!=1}style="display:none"{/if}>
	<div style="margin:10px" class="p6">
		<strong>已拉黑IPs</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="addip" />
			<input type="hidden" name="tab" value="1" />
			添加IP黑名单规则
			<input type="text" name="site" /> <input type="submit" value="{$lang.submit}" />
		</form>
	</div>
	<table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover" >
		<tr>
			<th>规则</th>
			<th width="20"></th>
		</tr>
	{if !$iprule}
		<tr>
			<td colspan="2">没有可显示的内容</td>
		</tr>
	{else}{foreach from=$iprule item=site}
		<tr>
			<td>{$site.rule} </td>
			<td>
				<a class="delbtn" onclick="return remove_bannedemail($(this).attr('href'))"href="?cmd=module&module={$moduleid}&site={$site.id}&make=delete&tab=1">移除</a>
			</td>
		</tr>
	{/foreach}
	{/if}
	</table>
	<div style="min-height:1em;padding:10px" class="sectionfoot nicerblu">
		<h3 class="legend" style="margin:5px 0 2px;cursor:pointer">图例<img src="{$template_dir}img/question-small-white.png" /></h3>
		<ul style="list-style:inside;padding:0">
	规则格式:
		<li> <strong>所有</strong> - 匹配所有IPs</li>
		<li> <strong>xxx.xxx.xxx.xxx</strong> - 独立IP</li>
		<li> <strong>xxx.xxx.xxx.xxx/M</strong> - CIDR格式的掩码</li>
		<li> <strong>xxx.xxx.xxx.xxx/mmm.mmm.mmm.mmm</strong> - 完整格式的掩码</li>
	</ul>
	<ul style="list-style:inside;padding:0">
	范例规则:
		<li><strong>120.123.123.57/28</strong> 匹配IP从 120.123.123.48 到 120.123.123.63 </li>
		<li><strong>120.123.123.57/24</strong> 匹配IP从 120.123.123.0 到 120.123.123.255 </li>
		<li><strong>120.123.123.57/16</strong> 匹配IP从 120.123.0.0 到 120.123.255.255</li>
		<li><strong>120.123.123.57/8</strong> 匹配IP从 120.0.0.0 到 120.255.255.255</li>
	</ul>
	</div>
</div>
<div id="msg" {if !$tab || $tab!=2}style="display:none"{/if} class="selectable">
	<div style="margin:10px" class="p6">
		<strong>禁言的信息</strong>
		<br>
		<form name="input" action="?cmd=module&module={$moduleid}" method="post">
			<input type="hidden" name="make" value="setmsg"  />
			<input type="hidden" name="tab" value="2" />
			<div style="margin: 5px;"><textarea name="msg" style="width:100%">{$blockmsg}</textarea></div>
			上述显示消息内容将禁止注册 <input type="submit" value="{$lang.submit}" />
		</form>
	</div>	
</div>