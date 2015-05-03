<script type="text/javascript" src="{$system_url}templates/common/facebox/facebox.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$system_url}templates/common/facebox/facebox.css" />
<div id="cloginform" style="display:none">
    <table width="100%" cellspacing="3" cellpadding="0" border="0" class="checker">

        <tr>
            <td colspan="2"><span class="slabel">{$lang.username}</span> <span class="slabel">{$service.username}</span></td>
        </tr>
        <tr>
            <td colspan="2"><span class="slabel">{$lang.password}</span> <span class="slabel">{$service.password}</span></td>
        </tr>
        <tr class="lastone">
            <td align="center" style="padding:10px 0px;">
                <form action="{$wpanellink}" method="get" target="_blank">
                    <input type="submit" value="{$lang.proceedtocp}" class="blue btn btn-success" />
                </form>
            </td>
        </tr>
    </table>
</div>
{literal}
<script type="text/javascript">
    function bindonapplogin() {
        $.facebox({div:'#cloginform',width:350});
    }
    if(typeof(appendLoader)=='function') {
        appendLoader('bindonapplogin');
    } else {
        $(document).ready(function(){
            bindonapplogin();
        });
    }
</script>
{/literal}