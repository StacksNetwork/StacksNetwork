<div id="observiummgr">
    <div id="observium_billing" style="margin-bottom:25px;">
    <center>
    加载带宽/计费数据... <Br/><Br/>
    <img src="ajax-loading.gif" alt="" />
    <br/>


    </center>
    {literal}
<script type="text/javascript">
    ajax_update('?cmd=observium&action=billingdata&account_id='+$('#account_id').val(),{},'#observium_billing');
    </script>
    {/literal}
</div>



    
<script type="text/javascript">
    var gtpl = "?cmd=observium&action=showgraph&account_id={$account_id}";
    {literal}
    function loadobserviumMgr() {
       ajax_update('?cmd=observium&action=accountdetails',{id:$('#account_id').val(),loadbyajax:true},'#observiummgr');
    }
  function loadobserviumPorts() {
    $('#add_observium').show();
    ajax_update('?cmd=observium&action=loadswitch',{account_id:$('#account_id').val()},'#observium_port_loader',true);
      return false;
  }
  function change_observium_sw(select) {
      var v = $(select).val();
      $('.sw_observium_port').hide();
      $('#observium_port_id_'+v).show();
      return false;
  }
  function showobserviumGraphs(sw,p,btn) {
      $(btn).toggleClass('activated');
      var imurl = gtpl + "&switch_id="+sw+"&port_id="+p;
      var targetc = $('#graphs_'+sw+'_'+p).toggle();
      var target = $('.lgraphs',targetc);
      if(targetc.hasClass('loaded'))
          return false;
      targetc.addClass('loaded');

$('.ldaily',target).append('<img src="'+imurl+'" />');
$('.lweekly',target).append('<img src="'+imurl+'&type=weekly" />');
$('.lmonthly',target).append('<img src="'+imurl+'&type=monthly" />');
return false;
  }
 function  unassignobserviumPort(sw,p) {
     if(!confirm('您确定要取消分配该端口? 这可能会改变计费总数')) {
         return false;
     }
     $.post('?cmd=observium&action=rmassignment',{
            account_id:$('#account_id').val(),
            switch_id:sw,
            port_id:p
        },function(){
            loadobserviumMgr();
        });
        return false;

  }
   function assignobserviumPort() {
        if(!$('#observium_switch_id').val())
            return false;

var switch_id=$('#observium_switch_id');
var port_id = $('#observium_port_id_'+switch_id.val());

        $.post('?cmd=observium&action=addassignment',{
            account_id:$('#account_id').val(),
            switch_id:switch_id.val(),
            port_id:port_id.val(),
            billforit: $('#billforit').is(':checked')?1:0,
            switch_name:$('option:selected',switch_id).text(),
            port_name:$('option:selected',port_id).text()
        },function(){
            loadobserviumMgr();
        });
        return false;
    }
    </script><style type="text/css">
        .lgraph {
            min-height:150px;
            text-align: center;
            margin-bottom:10px;
}
    </style>
{/literal}<div id="add_observium" style="display:none">
    <div class="left" style="margin-right:10px;padding:4px"><b>从Observium分配新的交换机与端口:</b></div>

    <div id="observium_port_loader" class="left">加载数据...</div>
    <div class="clear"></div>
</div>
{if !$observium_datasources}

<div class="blank_state_smaller blank_forms" id="blank_observium">
        <div class="blank_info">
            <h3>连接该帐户的Observium流量图</h3>
            <span class="fs11">
                使用本系统并通过Observium您可以详细的监控带宽使用与超流情况, "接口 - 流量" 图. <br/>
                同时在客户控制台界面可以到 产品->客户端功能中, 访问预先设置好的流量使用图.<br/>

            </span>
            <div class="clear"></div>
            <br>
            <a onclick="$('#blank_observium').hide();return loadobserviumPorts();" class="new_control" href="#"><span class="addsth"><strong>选择交换机/端口进行连接</strong></span></a>
            <div class="clear"></div>
        </div>
    </div>
{else}
<h3>分配Observium设备</h3>

    <ul style="border:solid 1px #ddd;border-bottom:none;margin-bottom:15px" id="grab-sorter">

{foreach from=$observium_datasources item=itm}
<li style="background:#ffffff" class="observium_row" ><div style="border-bottom:solid 1px #ddd;">
<table width="100%" cellspacing="0" cellpadding="5" border="0">
<tbody><tr>
<td width="200" valign="top"><div style="padding:10px 0px;">
<a onclick="return unassignobserviumPort('{$itm.c_switch_id}','{$itm.c_port_id}')" title="删除" class="menuitm menuf" href="#"><span class="rmsth">取消分配</span></a><!--
--><a onclick="return showobserviumGraphs('{$itm.c_switch_id}','{$itm.c_port_id}',this)" title="删除" class="menuitm menul" href="#"><span class="graphst">流量使用图</span></a>
</div></td>
<td>
    {$itm.name} {if !$itm.billed}<em>Not billable</em>{/if}
</td>
</tr>
<tr id="graphs_{$itm.c_switch_id}_{$itm.c_port_id}" style="display:none">
    <td></td>
    <td class="lgraphs">
        <div class="ldaily lgraph"></div>
        <div class="lweekly lgraph"></div>
        <div class="lmonthly lgraph"></div>
    </td>
</tr>
</tbody></table>
    </div></li>
{/foreach}
</ul>

<a onclick="$(this).hide();return loadobserviumPorts();" class="new_control" href="#"><span class="addsth"><strong>选择交换机/端口进行连接</strong></span></a>




{/if}
</div>