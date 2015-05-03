<form action="" method="post">
    <input type="hidden" name="make" value="uprdns" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >
   

    <tr>
        <td style="padding-top:15px;font-weight:bold">Current host monitored</td>
        <td>{$monitored_host}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">Change to:</td>
        <td><input type="text" name="hostname" value="{$monitored_host}" style="width:350px;"/>
    </td>
    </tr>
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Update uptime monitor" class="btn btn-info ">
<div class="clear"></div>
</div>{securitytoken}
</form>
