
<div  class="nicerblu"><form action="" method="post" id="submitform">
        <input type="hidden" name="make" value="updateconfig"/>
        <table width="100%" cellspacing="0" cellpadding="6">
            <tbody  class="sectioncontent">

              
                <tr >
                    <td width="180" align="right" ><strong>自动连接访问者, 每 <a title="如果工作人员不能接通聊天请求, 系统将从这个部门切换另一名工作人员.
                                                                                                <br> 输入秒数自动连接" class="vtip_description"></a></strong></td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatRoundRobinInterval]" value="{$configuration.ChatRoundRobinInterval}" />
                        秒
                    </td>
                </tr>

                <tr >
                    <td  align="right" ><strong>最大工作人员切换 <a title="如果没有工作人员接通聊天, 在N次聊天请求后会自动关闭" class="vtip_description"></a></strong></td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatRoundRobinMiss]" value="{$configuration.ChatRoundRobinMiss}" />
                    </td>
                </tr>
                 <tr >
                    <td align="right" ><strong>聊天邀请超时 <a title="如果工作人员邀请访客聊天, 在N秒后还未开始交谈的,会报为超时" class="vtip_description"></a></strong></td>
                    <td class="editor-container">
                        <input type="text" class="styled inp" size="4" name="config[ChatInvitationTimeout]" value="{$configuration.ChatInvitationTimeout}" />
                        秒
                    </td>
                </tr>

                <tr >
                    <td  align="right" valign="top"><strong>添加跟踪至用户控制台 <a title="使用此选项, 访问路线跟踪/邀请代码会自动与客户接口集成" class="vtip_description"></a></strong></td>
                    <td class="editor-container">
                        <input type="checkbox" class="styled inp" name="config[ChatTrackHostBill]" value="on" {if $configuration.ChatTrackHostBill=='on'}checked="checked"{/if} />
                    </td>
                </tr>

                <tr><td colspan="2"></td></tr>
                <tr><td colspan="2"><a onclick="$('#submitform').submit();return false;" href="#" class="new_dsave new_menu">
                            <span>保存修改</span>
                        </a></td></tr>
            </tbody>
        </table>
        {securitytoken}

    </form>
</div>