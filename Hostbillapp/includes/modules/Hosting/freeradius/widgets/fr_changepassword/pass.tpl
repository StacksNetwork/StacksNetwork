<form action="" method="post">
    <input type="hidden" name="make" value="changepass" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >


    <tr>
        <td style="padding-top:15px;font-weight:bold">当前密码</td>
        <td>{$currentpass}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">新的密码</td>
        <td><input type="text" name="newpassword" value="{$currentpass}" style="width:350px;"/>
    </td>
    </tr>
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="更改您的密码" class="btn btn-info ">
<div class="clear"></div>
</div>{securitytoken}
</form>
