<table width="100%"><tr>
<td class="fright">
	<h3 style="margin-bottom:0px;">IP分配详情 {$ip.ipaddress}</h3>
	<div class="form_container">
	<form action="?cmd=module&module={$moduleid}" method="post" onsubmit="return false">
		<input type="hidden" name="action" value="editassignment" />
		<input type="hidden" name="ip_id" value="{$ip.id}" />
		<input type="hidden" name="make" value="save" />

                        <label class="nodescr">所有人</label>
                        <select  class="w250" name="client_id" load="clients" default="{$ip.client_id}" id="client_id" onchange="reloadServices()"><option value="0">无</option></select>
                        <div class="clear"></div>


                    <div id="related_service">
                            <label class="nodescr">相关服务</label>
                            <input type="text"   size="" value="{$ip.account_id}" class="w250" name="account_id" id="account_id" />
                            <div class="clear"></div>
                        </div>



                        {if $dedimgr}
                         <div id="related_service">
                            <label class="nodescr">相关设备/端口</label>
                            <div style="margin: 7px 0 20px 10px;" class="left">{if $ip.port}
                                    <a href="?cmd=module&module=dedimgr&do=rack&rack_id={$ip.port.rack_id}&expand={$ip.port.id}" target="_blank">{$ip.port.typename} - {$ip.port.label} ({$ip.port.number})</a>
                                    {else}<em>在这个 <a href="?cmd=module&module=dedimgr" target="_blank">虚拟数据中心</a> 管理系统中未找到分配过的IP</em> {/if}
                            </div>
                            <div class="clear"></div>
                        </div>
                        {/if}


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
				<span>更新IP分配</span>
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

{literal}
<script type="text/javascript">
    $(function(){
        inichosen();
    });
     function inichosen() {
        if(typeof jQuery.fn.chosen != 'function') {
            $('<style type="text/css">@import url("templates/default/js/chosen/chosen.css")</style>').appendTo("head");
            $.getScript('templates/default/js/chosen/chosen.min.js', function(){
                inichosen();
                return false;
            });
            return false;
        }

        $('#client_id','#facebox').each(function(n){
            var that = $(this);
            var selected = that.attr('default');
            $.get('?cmd=clients&action=json',function(data){
                if(data.list != undefined){
                    for(var i = 0; i<data.list.length; i++){
                        var name = data.list[i][3].length ? data.list[i][3] : data.list[i][1] +' '+ data.list[i][2];
                        var select = selected == data.list[i][0] ? 'selected="selected"' : '';
                        that.append('<option value="'+data.list[i][0]+'" '+select+'>#'+data.list[i][0]+' '+name+'</option>');
                    }
                }
                reloadServices();
                that.chosen();

            });
        });

    }
         function reloadServices() {
            ajax_update('?cmd=module&module=ipam&action=getclientservices',{client_id:$("#client_id").val(),service_id:$('#account_id').val()},'#related_service');
        }
</script>
{/literal}