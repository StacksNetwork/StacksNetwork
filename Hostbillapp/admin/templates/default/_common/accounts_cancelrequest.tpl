{if $cancel_request}
    <div style="{if $cancel_request.disabled}border: 1px solid #CCCCCC; background: #DDDDDD;{else}{/if}" class="cancellation">
        <div><strong style="margin-right: 15px;">{$lang.user_canc_requested}</strong>{if !$cancel_request.disabled}<input type="submit" name="cancellation" value="{$lang.CancelAccount}" onclick="return confirm('{$lang.confirm_cancel_account}')" style="margin: 5px; font-weight: bold;">{/if}<input type="submit" name="del_cancreq" onclick="return confirm('{$lang.confirm_del_crequest}')" value="{$lang.DeleteRequest}"></div>
        <table width="60%" cellspacing="2" style="padding: 5px 20px; font-size: 11px;">
            <tbody>
                <tr><td  width="10%" valign="top"><strong>{$lang.Type}:</strong></td><td width="30%" valign="top">{$lang[$cancel_request.type]}</td><td width="10%" valign="top"><strong>{$lang.Reason}:</strong></td><td valign="top" rowspan="2">{$cancel_request.reason}</td></tr>
                <tr><td valign="top"> <strong>{$lang.Date}:</strong></td><td valign="top">{$cancel_request.date}</td><td></td></tr>
            </tbody>
        </table>
    </div>
{/if}