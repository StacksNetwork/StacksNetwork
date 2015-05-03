<script type="text/javascript">loadelements.emails=true;</script>
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" >
       <tr>
        <td ><h3>{$lang.Notifications}</h3></td>
        <td></td>
    </tr>
    <tr>
        <td class="leftNav">
            <a href="?cmd=notifications"  class="tstyled selected">{$lang.notification_settings}</a>
            <a href="?cmd=managemodules&action=notification"  class="tstyled">{$lang.notificationmodules}</a>


        </td>
        <td  valign="top"  class="bordered" rowspan="2"><div id="bodycont">

  {literal}
                <script>
                    $(document).ready(function(){
                        $('#newshelfnav').TabbedMenu({
                             elem: '.sectioncontent',
                             picker: '.list-1 li',
                             aclass: 'active'
                        });
                    });
                </script>
                {/literal}

               

                <div id="newshelfnav" class="newhorizontalnav">
                    <div class="list-1">
                        <ul>
                            <li class="active picked">
                                <a href="#"><span class="ico money">通知设置</span></a>
                            </li>
                            <li class="">
                                <a href="#"><span class="ico money">客户通知</span></a>
                            </li>
                            <li class="last">
                                <a href="#"><span class="ico plug">管理员通知</span></a>
                            </li>

                        </ul>
                    </div></div>
<div style="padding:15px;background:#F5F9FF;">
    <div class="sectioncontent">
        <div class="blank_state blank_news" id="blank_state" {if $config.MobileNotificationsAdmin!='off' || $config.MobileNotificationsClient!='off'}style="display:none"{/if}>
            <div class="blank_info">
                <h1>Get instant mobile notifications about events in HostBill</h1>
                With HostBill you can notify your client over mobile media (iPhone push, SMS &amp; more), 
                <br/>HostBill can also notify your staff members
                about important events  - like escalated ticket or new order.
                <div class="clear"></div>
                <a style="margin-top:10px" href="#" class="new_add new_menu" onclick="$('#blank_state').hide();$('#config_form').show();return false">
                <span>启用手机通知</span></a>
                <div class="clear"></div>
            </div>
        </div>

        <div id="config_form" {if $config.MobileNotificationsAdmin=='off' && $config.MobileNotificationsClient=='off'}style="display:none"{/if}>
               {if $nomodule}
                    <div class="imp_msg" style="margin-bottom:10px">
                        <strong>No notification module has been activated yet, please go to <a href="?cmd=managemodules&action=notification&do=inactive">Settings->Modules->Notification</a> and activate modules you'd like to use.</strong>
                    </div>
                {else}
                <div style="margin-bottom:20px">
                        <a style="" href="#" onclick="$(this).hide();$('#notify_test').show();return false;" class="menuitm"><span >Test mobile notification modules.</span></a>
                        <div id="notify_test" style="display:none">
                            Select admin to send test notification to: <select name="admin_id" id="admin_id" class="inp">{foreach from=$admins item=a}<option value="{$a.id}">{$a.firstname} {$a.lastname}</option>{/foreach}</select>
                                <a class=" new_control greenbtn" href="#" onclick="return send_test();">
                            <span>发送测试通知</span>
                                </a> <span id="test_result" style="padding:0px 10px"></span>
                        </div>
                        {literal}
                        <script>
                            function send_test() {
                                $.post('?cmd=notifications&action=test',{admin_id:$('#admin_id').val()},function(data){
                                    if(data.response) {
                                        $('#test_result').html(data.response);
                                    }
                                },'json');
                                return false;
                            }
                            </script>
                        {/literal}
            </div>
                {/if}
                <div class="blu" style="padding:15px 10px;">

             <form action="" method="post">
                 <input type="hidden" name="make" value="upform"/>
                 <table border="0" cellpadding="6" cellspacing="0" >
                     <tbody> <tr>
                         <td width="20"><input onclick="$('#MobileNotificationsAdmin').toggle();" type="checkbox" name="config[MobileNotificationsAdmin]" value="on" {if $config.MobileNotificationsAdmin=='on'}checked="checked"{/if} /></td>
                         <td>工作人员启用通知</td>
                     </tr></tbody>
                     <tbody {if $config.MobileNotificationsAdmin!='on'}style="display:none"{/if} id="MobileNotificationsAdmin">

                     <tr>
                         <td></td>
                         <td>工单优先级发送手机通知: <br/>
                             <select  name="config[MobileNotificationsAPriority]" class="inp" style="width:200px">
                                 <option value="" {if !$config.MobileNotificationsAPriority}selected="selected"{/if}>所有级别</option>
                                 <option value="1" {if $config.MobileNotificationsAPriority=='1'}selected="selected"{/if}>高于Low</option>
                                 <option value="2" {if $config.MobileNotificationsAPriority=='2'}selected="selected"{/if}>高于Medium</option>
                             </select></td>
                     </tr>

                      <tr>
                         <td></td>
                         <td>限制发送通知到下述部门: <br/>
                             <select multiple  name="config[MobileNotificationsDepts][]" class="inp" style="width:200px">
                                 <option value="0" {if $config.adepts[0]=="0"}selected="selected"{/if}>所有部门</option>
                                 {foreach from=$config.departments item=mod}
                                 <option value="{$mod.id}" {if $config.adepts[$mod.id]}selected="selected"{/if}>{$mod.name}</option>
                                 {/foreach}
                             </select></td>
                     </tr>

                         <tr>
                         <td></td>
                         <td><input value="2"  onclick="$('.specify_admin').hide()" type="radio" name="config[MobileNotificationsModAAdmin]" {if $config.MobileNotificationsModAdmin=='all'}checked="checked"{/if} /> 使用所有激活的通知模块</td>
                     </tr>
                     <tr>
                         <td></td>
                         <td><input value="1"  onclick="$('.specify_admin').show()" type="radio" name="config[MobileNotificationsModAAdmin]" {if $config.MobileNotificationsModAdmin!='all'}checked="checked"{/if}/> Using specific modules</td>
                     </tr>
                      <tr class="specify_admin" {if $config.MobileNotificationsModAdmin=='all'}style="display:none"{/if}>
                         <td></td>
                         <td> <select multiple name="config[MobileNotificationsModAdmin][]" class="inp" style="width:200px">
                                 {foreach from=$modules item=mod}
                                 <option value="{$mod.id}" {if $config.amodules[$mod.id]}selected="selected"{/if}>{$mod.modname}</option>
                                 {/foreach}
                             </select></td>

                     </tr>

                     </tbody>

                     <tbody><tr>
                         <td><input type="checkbox"  onclick="$('#MobileNotificationsClient').toggle();" name="config[MobileNotificationsClient]" value="on" {if $config.MobileNotificationsClient=='on'}checked="checked"{/if} /> </td>
                         <td>对客户启用通知</td>
                     </tr></tbody>
                     <tbody {if $config.MobileNotificationsClient!='on'}style="display:none"{/if} id="MobileNotificationsClient"><tr>
                         <td></td>
                         <td><input value="2"  onclick="$('#specify_client').hide()" type="radio" name="config[MobileNotificationsModAClient]" {if $config.MobileNotificationsModClient=='all'}checked="checked"{/if} /> 使用所有激活的通知模块</td>
                     </tr>
                     <tr>
                         <td></td>
                         <td><input value="1"  onclick="$('#specify_client').show()" type="radio" name="config[MobileNotificationsModAClient]" {if $config.MobileNotificationsModClient!='all'}checked="checked"{/if}/> 使用特定模块</td>
                     </tr>

                      <tr id="specify_client" {if $config.MobileNotificationsModClient=='all'}style="display:none"{/if}>
                         <td></td>
                         <td>
                             <select multiple name="config[MobileNotificationsModClient][]" class="inp" style="width:200px">
                                 {foreach from=$modules item=mod}
                                 <option value="{$mod.id}" {if $config.cmodules[$mod.id]}selected="selected"{/if}>{$mod.modname}</option>
                                 {/foreach}
                             </select>
                         </td>
                     </tr>
                     </tbody>
                     <tr><td colspan="2">
                             <input type="submit" class="submitme" style="font-weight:bold" value="Save Changes">
                         </td></tr>
                 </table>
                 
                 {securitytoken}

            </form></div>

           
        </div>


        

        


    </div>
    <div class="sectioncontent" style="display:none">
                    {if $emails}

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                        <tbody>

                            <tr >
                                <th colspan="4" align="left">{$lang.SystemMessages}</th>
                            </tr>
	{foreach from=$emails.All item=email  name=fr}{if $email.for!='Admin'}

                            <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                <td style="padding-left:10px"><strong>{$lang.Client}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" target="_blank">{$email.tplname}</a></td>
                                <td width="40"><a href="?cmd=notifications&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" target="_blank" class="editbtn">{$lang.Edit}</a></td>
                            </tr>
                           {/if} {/foreach}


                        </tbody></table>
                {else}
                <strong>尚无信息被配置</strong>

                {/if}




                </div>
                <div class="sectioncontent" style="display:none">
                    {if $emails}

                    <table width="100%" cellspacing="0" cellpadding="3" border="0" class="whitetable" style="border:solid 1px #ddd;">
                        <tbody>


                            <tr >
                                <th colspan="4" align="left">{$lang.SystemMessages}</th>
                            </tr>
	{foreach from=$emails.All item=email  name=fr}{if $email.for=='Admin'}

                            <tr class="havecontrols {if $smarty.foreach.fr.index%2==0}even{/if} ">

                                <td style="padding-left:10px"><strong>{$lang.Admin}: </strong><a href="?cmd=emailtemplates&action=edit&id={$email.id}" target="_blank">{$email.tplname}</a></td>
                                <td width="40"><a href="?cmd=notifications&id={$email.id}&make={if $email.send=='1'}disable{else}enable{/if}&security_token={$security_token}" class="editbtn {if $email.send=='1'}editgray{/if}">{if $email.send=='1'}{$lang.Disable}{else}{$lang.Enable}{/if}</a></td>
                                <td width="23" align="center" ><a href="?cmd=emailtemplates&action=edit&id={$email.id}" target="_blank" class="editbtn">{$lang.Edit}</a></td>
                            </tr>
                           {/if} {/foreach}


                        </tbody></table>
                {else}
                <strong>尚无信息被配置</strong> 

                {/if}



                </div>
    </div>

            </div></td>
    </tr>
</table>