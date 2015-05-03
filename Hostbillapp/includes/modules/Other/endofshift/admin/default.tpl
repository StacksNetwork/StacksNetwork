{if $do=='settings'}
    <div class="nicers2" style="border: medium none; padding: 20px;">
        <a href="?cmd=module&module={$moduleid}"><b>&laquo; 返回报告</b></a> <br/> <br/>
        <div class="mod_desc">
	<div class="headshelf">
            <strong> 选择交接班报告收件人.</strong>
        </div>
        <div style="padding: 10px;" class="mmdescr">
           <form action="" method="post">
                    <input type="hidden" name="make" value="saveconfig" />

                    {foreach from=$emails item=email}

                    <input type="checkbox" name="allowed[]" value="{$email}" {if $settings.AllowedAdmins[$email]}checked="checked"{/if} /> {$email} <br/>

                    {/foreach}

                    {foreach from=$settings.AllowedAdmins item=admin}
                        {if !$emails[$admin]}
                    <input type="checkbox" name="allowed[]" value="{$admin}" checked="checked" /> {$admin} <br/>
                         {/if}

                    {/foreach}

                    <div style="padding:5px 0px 5px 20px;">
                        <span style="display: none;"><input  style="width:150px" name="new_allowed[]" /></span>
                        <a href="#" onclick="$(this).hide().parent().find('span').show();return false;">添加另一名收件人的邮箱</a>
                        <br/>
                    </div>
                    <br/>
                    <input type="submit" style="font-weight: bold; padding: 3px 5px;" value="保存修改"/>

                </form>

       </div>

    </div>


</div>



{else}
<script type="text/javascript">
var constr=" {$now|dateformat:$date_format}, {$myname}";
    {literal}
        function get_support_summary() {
            $.get('?cmd=module&module='+module_id+'&do=get_support_summary',{},function(data){
                var resp = parse_response(data);
                     if (typeof(resp)=='string')  {
                var reply = $('#replyarea').val();
                $('#replyarea').val(reply + "\r\n" + resp);
                $('#replyarea').focus();
            }
            });
                return false;
        }
             function get_servers() {
            $.get('?cmd=module&module='+module_id+'&do=get_server_list',{},function(data){
                var resp = parse_response(data);
                     if (typeof(resp)=='string')  {
                var reply = $('#replyarea').val();
                $('#replyarea').val(reply + "\r\n" + resp);
                $('#replyarea').focus();
            }
            });
                return false;
        }

        function report_save() {
            $('#resaver').hide();
            $('#reportsave').show();
                $('#reportsave input').val($('input[name=subject]').val().replace(constr,""));
        }

            function save_report() {
                $('#makeb').val('savereport');
                $('#fform').submit();
                return false;
            }
            function update_report() {
                $('#makeb').val('updatereport');
                $('#fform').submit();
                return false;
            }

            function send_report() {
                $('#makeb').val('sendreport');
                $('#fform').submit();

                return false;
               }
        {/literal}
</script>

<div class="nicers2" style="border: medium none; padding: 20px;">



<table border="0" cellpadding="6" cellspacing="0" width="80%">
      {if !$settings.AllowedAdmins}
    <tr><td colspan="2">
        <div class="imp_msg">
            <strong>您尚未配置任何收件人 - 添加一些到 <a href="?cmd=module&module={$moduleid}&do=settings">这里</a>.</strong>
</div>
        </td></tr>
    {/if}

    <tr>
        <td width="70%" valign="top">
           <div class="mod_desc">
	<div class="headshelf">
            <strong> 撰写新的报告.</strong>
        </div>
               <div style="padding: 10px;" class="mmdescr"><form method="post" action="" id="fform">
                       <input type="hidden" name="make" value="sendreport" id="makeb"/>
                      <input type="hidden" name="constr" value=" {$now|dateformat:$date_format}, {$myname}"/>
            <table border="0" cellpadding="3" cellspacing="0" width="100%">
                <tr>
                    <td width="130"><b>主题</b></td>
                    <td><input name="subject" value="{if $submit}{$submit.subject}{elseif $report}{$report.subject}  {$now|dateformat:$date_format}, {$myname}{else}交接班报告: {$now|dateformat:$date_format}, {$myname}{/if}" style="width:95%" class="inp"/></td>
                </tr>
                <tr>
                    <td colspan="2">

                    <textarea name="body" id="replyarea" rows="14" style="width: 99%;">{if $submit}{$submit.body}{elseif $report}{$report.content}{else}{/if}</textarea>
                    <div id="draftinfo">
                        <div style="text-align: right; padding: 10px 10px;">


                    <a href="#" class="menuitm menuf greenbtn"  onclick="return send_report();"><span><strong>发送报告</strong></span></a>{if $report}<a href="#" class="menuitm menul" onclick="return update_report();"><span>更新保存的报告</span></a>{else}<a  href="#" class="menuitm menul" onclick="report_save();return false;" id="resaver"><span>另存为预定义的报表</span></a>{/if}
                    {if !$report}
                    <div id="reportsave" style="display:none;padding:15px 0px 0px;">
                        <b>报告名称:</b> <input name="reportname" value="" /> <a href="#" class="menuitm  "  onclick="return save_report();"><span>保存报告</span></a> Or <a href="#" onclick="$('#resaver').show();$('#reportsave').hide();return false;" class="editbtn">Cancel</a>
                    </div>
                    {/if}



                                    </div>
                    </div>
                    </td>
                </tr>

            </table>
            </form>
       </div>

    </div>
        </td>
        <td valign="top">
         <div class="mod_desc">
	<div class="headshelf">
            <strong> 工具栏.</strong>
        </div>
        <div style="padding: 10px;" class="mmdescr">
            <p style="margin:0px;padding:0px;line-height: 22px">
            <a href="?cmd=module&module={$moduleid}"><b>开始新的报告</b></a> <br/>
              <a href="?cmd=module&module={$moduleid}&do=settings"><b>管理收件人</b></a> <br/>
            <a href="?cmd=module&module={$moduleid}" onclick="return get_support_summary()"><b>粘贴我工单汇总</b></a> <br/>
            <a href="?cmd=module&module={$moduleid}" onclick="return get_servers()"><b>粘贴应用/服务器列表</b></a> <br/>
           </p><br/>

           {if $profiles}
           <b>预先设置的报告:</b>
           <div style="padding:3px;border: solid 1px #f6f6f6"><table border="0" cellspacing="0" cellpadding="3" width="100%">
          {foreach from=$profiles item=profile} <tr class="havecontrols {if $report.id==$profile.id}shownice{/if}">

              <td align="left"><a href="?cmd=module&module={$moduleid}&pid={$profile.id}">{$profile.name}</a>
</td>
<td width="16"><div class="controls" style="display: none;"><a  class="rembtn" href="?cmd=module&module={$moduleid}&make=removereport&pid={$profile.id}" onclick="return confirm('您确定需要删除该报告吗?');">删除</a></div></td>
</tr>         {/foreach}
               
           </table></div>

            
           
  
            {/if}
       </div>

    </div>
        </td>

    </tr>
</table>

</div>



{/if}