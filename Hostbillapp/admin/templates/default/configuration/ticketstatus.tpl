<link rel="stylesheet" media="screen" type="text/css" href="{$template_dir}js/colorpicker/css/colorpicker.css" />
<script type="text/javascript" src="{$template_dir}js/colorpicker/colorpicker.js?v={$hb_version}"></script>
<script type="text/javascript" src="{$template_dir}js/jquery.dragsort-0.3.10.min.js?v={$hb_version}"></script>
{literal}
<script>
    $(document).ready(function(){
        $('#colorSelector').ColorPicker({
            onSubmit: function(hsb, hex, rgb, el) {
                $(el).val(hex);
                $(el).ColorPickerHide();
            },onChange: function (hsb, hex, rgb) {
                $('#colorSelector').css('backgroundColor', '#'+ hex);
                $('#colorSelector_i').val(hex);
            },
            livePreview:true, color:'000000'}
        );
        $("#grab-sorter").dragsort({ dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>" });
    });
    function saveOrder() {
        var sorts = $('#serializeit').serialize();
        ajax_update('?cmd=configuration&action=ticketstatuses&'+sorts,{});
    };
    function newTStatus(){
        $('#blank_state').hide();
        $('#new_status').show().find('input[name=status]').val('').prop('disabled',false).removeAttr('disabled').filter('[type=hidden]').remove();
        $('.submitme').hide().filter('.add').show();
        var color = '000000',
            options = 2;
        $('#colorSelector').ColorPickerSetColor(color).css('background-color','#'+color);
        $('#colorSelector_i').val(color);
        $('#new_status input[name="options[]"]').each(function(){
            $(this).prop('checked',!!(parseInt($(this).val()) & options));
        })
    }
    function editTStatus(status, color, options){
        $('#blank_state').hide();
        var inp = $('#new_status').show().find('input[name=status]'),
            hidden = inp.val(status).clone();
        inp.prop('disabled',true).attr('disabled','disabled');
        hidden.prop('type','hidden').attr('type','hidden').insertAfter(inp);
        $('#colorSelector').ColorPickerSetColor(color).css('background-color','#'+color);
        $('#colorSelector_i').val(color);
        $('.submitme').hide().filter('.edit').show();
        $('#new_status input[name="options[]"]').each(function(){
            $(this).prop('checked',!!(parseInt($(this).val()) & options));
        })
    }
</script>
{/literal}
<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb">
    <tr>
        <td colspan="2">
            <h3>{$lang.sysconfig}</h3>
        </td>
    </tr>
    <tr>
        <td class="leftNav">
            {include file='configuration/leftmenu.tpl'}
        </td>
        <td  valign="top"  class="bordered">
            <div id="bodycont" style="">
                <div class="newhorizontalnav"  id="newshelfnav">
                    <div class="list-1">
                        <ul>
                            <li><a href="?cmd=configuration&picked_tab=0">{$lang.generalconfig}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=1">{$lang.Ordering}</a></li>
                            <li class="active picked"><a href="?cmd=configuration&picked_tab=2">{$lang.Support}</a></li>
                            <li ><a href="?cmd=configuration&picked_tab=3">{$lang.Billing}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=4">{$lang.Mail}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=5">{$lang.CurrencyName} &amp; {$lang.taxconfiguration}</a></li>
                            <li><a href="?cmd=configuration&picked_tab=6">{$lang.Other}</a></li>
                        </ul>
                    </div>
                    <div class="list-2">
                        <div class="subm1 haveitems">
                            <ul >
                                <li class=""><a href="#"><span>{$lang.General}</span></a></li>
                                <li class="picked"><a href="?cmd=configuration&action=ticketstatuses"><span>{$lang.ticketstatuses}</span></a></li>

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="nicerblu" id="ticketbody">
                    <table border="0" cellspacing="0" cellpadding="6" width="100%">
                        <tr>
                            <td width="33%" valign="top">
                                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable" >
                                    <tbody>
                                        <tr>
                                            <th align="left" colspan="2"><b>当前工单状态</b></th>
                                        </tr>
                                    </tbody>
                                </table>

                                <form id="serializeit" action="" method="post">
                                    <input type="hidden" name="make" value="sortorder" />
                                    <ul id="grab-sorter">
                                        {foreach from=$statuses item=status name=scloop}
                                            {if !($status.options & 4)}
                                            <li>
                                                <table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd; border-top:none;" class="whitetable">
                                                    <tr >
                                                        <td><span {if !($status.options & 1)}style="color:#{$status.color}"{/if} class="{if !($status.options & 1)}ticket-status-{/if}{$status.status}">{$status.status}</span></td>
                                                        <td width="20"><a class="sorter-handle">移动</a><input type="hidden" value="{$status.status}" name="sort[]"></td>
                                                        <td width="30" class="lastitm">
                                                            {if !($status.options & 1)}
                                                                <a onclick="return editTStatus('{$status.status}', '{$status.color}', {$status.options})" class="editbtn-ico left" style="margin-right: 8px;"  href="#">编辑</a>
                                                                <a onclick="return confirm('您确定要删除该状态吗?')" class="delbtn" href="?cmd=configuration&action=ticketstatuses&make=delete&security_token={$security_token}&status={$status.status}">删除</a>
                                                            {/if}
                                                        </td>
                                                    </tr>
                                                </table>
                                            </li>
                                            {/if}
                                        {/foreach}
                                    </ul>
                                    {securitytoken}
                                </form>
                                <br/>
                                <div>
                                    <a href="#" onclick="newTStatus(); return false" class=" new_control greenbtn"><span>创建自定义状态</span></a>
                                </div>

                            </td>
                            <td valign="top">
                                <div class="blank_state blank_news" id="blank_state" style="padding:0px 0px">
                                    <div class="blank_info">
                                        <h1>添加自定义工单状态</h1>
                                        可以创建自定义工单状态和重新安排现有的-最适合贵公司的支持工作流.
                                        <div class="clear"></div>
                                    </div>
                                </div>
                                <div class="p6" id="new_status" style="display:none">

                                    <form id="serializeit" action="" method="post">
                                        <input type="hidden" name="make" value="addstatus" />
                                        <table width="60%" cellspacing="0" cellpadding="6" border="0">
                                            <tbody>
                                                <tr >
                                                    <td  align="right" width="150"><strong>状态</strong></td>
                                                    <td><input class="inp" id="ticketstatus" value="" name="status" /></td>
                                                </tr>
                                                <tr >
                                                    <td  align="right" width="150"><strong>自动关闭</strong></td>
                                                    <td>
                                                        <input type="checkbox" value="2" name="options[]" checked="checked"/>   
                                                        <a class="vtip_description" title="工单的自动关闭功能可自动关闭未回复工单，根据部门设置"></a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                     <td  align="right" width="150">状态色彩</td>
                                                    <td>
                                                        <input id="colorSelector_i" type="hidden" class="w250" size="7" name="color" value="000000" style="margin-bottom:5px"/>
                                                        <div id="colorSelector" style="border: 2px solid #ddd; cursor: pointer; float: left; height: 15px;margin: 6px 0 5px 8px;position:relative; width: 40px; background: #000000;" onclick="$('#colorSelector_i').click()">
                                                            <div style="position:absolute; bottom:0; right: 0; color:white; background:url('{$template_dir}img/imdrop.gif') no-repeat 3px 4px #ddd; height:10px; width:10px"></div>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td  align="right" width="150"></td>
                                                    <td>
                                                        <input type="submit" class="submitme add" style="font-weight:bold" value="添加新的工单状态">
                                                        <input type="submit" class="submitme edit" style="font-weight:bold" value="更新工单状态">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        {securitytoken}
                                    </form>
                                </div>

                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </td>
    </tr>
</table>