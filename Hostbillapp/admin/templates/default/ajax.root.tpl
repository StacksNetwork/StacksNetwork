{if $action=='initialconfig'}
<h2 style="margin-top:0px;">Welcome in <span style="color:#484740;font-family:Calibri,Arial,Helvetica;font-size:21px">Host</span><span style="color:#6694e3;font-family:Calibri,Arial,Helvetica;font-size:21px">Bill</span></h2>
Thank you for choosing HostBill as your new billing application. For quick start use one of pre-configured settings below.

<div style="margin: 20px 0px"><form action="" method="post">
        <input type="hidden" name="action" value="saveprofile"/>
{if $qc_features}
    <strong>Profile:</strong> <select class="inp" name="profile" onchange="ppp(this)">
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