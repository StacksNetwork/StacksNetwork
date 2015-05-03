
    <table width="100%" cellspacing="3" cellpadding="0" border="0" class="checker table">
        <tr>
            <td width="160"><span class="slabel">Login URL</span></td><td> <span class="slabel"><a href="{$wpanellink}" target="_blank">{$wpanellink}</a></span></td>
        </tr>
        <tr>
            <td ><span class="slabel">{$lang.username}</span></td><td> <span class="slabel">{$service.username}</span></td>
        </tr>
        <tr>
            <td><span class="slabel">{$lang.password}</span></td><td> <span class="slabel">{$service.password}</span></td>
        </tr>
        <tr class="lastone">
            <td align="center" style="padding:10px 0px;" colspan="2">
                <form action="{$wpanellink}" method="get" target="_blank">
                    <input type="submit" value="{$lang.proceedtocp}" class="blue btn btn-success" />
                </form>
            </td>
        </tr>
    </table>
