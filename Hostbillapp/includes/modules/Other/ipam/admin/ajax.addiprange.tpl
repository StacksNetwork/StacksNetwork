<table width="100%"><tr>
<td class="fright">
	<h3 style="margin-bottom:0px;">添加子网 / IP范围</h3>
	<div class="form_container">
	<form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
		<input type="hidden" name="action" value="addlist" />
		<input type="hidden" name="group" value="{$group}" />
		<input type="hidden" name="mode" value="addrange" />

		<br/>
		<label>IP</label><input type="text" name="ip" value="" />
                <div class="clear"></div>
		

	<h4 style="margin-bottom:0px;">图示:</h4>
        使用下列IP符号: <br/>
         - x.x.x.x - y.y.y.y  <br/>
         - x.x.x.x/C  <br/>

               
	</form>
	</div>
	
</td>
</tr></table>
<div style=" background: #272727; box-shadow: 0 -1px 2px rgba(0, 0, 0, 0.3); color: #FFFFFF; height: 20px; padding: 11px 11px 10px; clear:both">
	<div class="left spinner" style="display: none;">
		<img src="ajax-loading2.gif" />
	</div>
	<div class="right">
		<span class="bcontainer ">
			<a class="new_control greenbtn" onclick="$('.spinner').show();submitIPRange($('#facebox .form_container form').eq(0));return false;" href="#">
				<span>添加IP范围 / 子网</span>
			</a>
		</span>
		<span class="bcontainer">
			<a class="submiter menuitm" href="#" onclick="$(document).trigger('close.facebox');return false;">
				<span>关闭</span>
			</a>
		</span>
	</div>
	<div class="clear"></div>
</div>