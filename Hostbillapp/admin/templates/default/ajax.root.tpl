{if $action=='initialconfig'}
<h2 style="margin-top:0px;">欢迎来到 <span style="color:#484740;font-family:Calibri,Arial,Helvetica;font-size:21px">STACKS® NETWORK</span><span style="color:#6694e3;font-family:Calibri,Arial,Helvetica;font-size:21px">管理后台</span></h2>
感谢您选择HostBill作为新的结算程序. 对于快速启动使用以下预设的设置之一.

<div style="margin: 20px 0px"><form action="" method="post">
        <input type="hidden" name="action" value="saveprofile"/>
{if $qc_features}
    <strong>配置文件:</strong> <select class="inp" name="profile" onchange="ppp(this)">
        {foreach from=$qc_features item=q}
        <option value="{$q.file}">{$q.name}</option>
        {/foreach}
    </select>

    <input type="submit" value="Use this profile" class="submitme" style="font-weight:bold"/>

    <br/>
    <div id="pdesc" style="padding:10px 0px;font-size:11px">
        {foreach from=$qc_features item=q key=k}
        <div id="o_{$k}" {if $k!=0}style="display:none"{/if}>{$q.description}</div>
        {/foreach}
    </div>
{/if}
    {securitytoken}</form>
</div>


<script type="text/javascript">
{literal}
    function ppp(el) {
        $("#pdesc div").hide();
        $('option',$(el)).each(function(n){
            if($(this).is(':selected')) {
                $("#pdesc div").eq(n).show();
            }
        });

}
        $('#facebox .footer').append(
            '<div class="left"><input type="checkbox" id="dontshowmeagain"> Dont show this message again</div>'
        );
            $(document).bind('close.facebox',function(){
                if ($("#dontshowmeagain").is(":checked")) {
                    ajax_update('?cmd=root&action=hideqc');
                }
            });
 {/literal}
</script>
{/if}