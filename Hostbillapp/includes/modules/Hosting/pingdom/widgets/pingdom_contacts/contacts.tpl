<form action="" method="post">
    <input type="hidden" name="make" value="uprdns" />
<table border="0" cellpadding="3" cellspacing="0" width="100%" class="fullscreen table" >
   

    <tr>
        <td style="padding-top:15px;font-weight:bold">Host down alert sent to email:</td>
        <td>{$monitored_email}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">Change to:</td>
        <td><input type="text" name="email" value="{$monitored_email}" style="width:350px;"/>
    </td>
    </tr>
    
    
    {if $phonechange}
           <tr>
        <td style="padding-top:15px;font-weight:bold">Host down alert sms sent to phone:</td>
        <td>{$monitored_phone}</td>
    </tr>

    <tr>
        <td style="padding-top:15px;font-weight:bold">Change to:</td>
        <td><input type="text" name="phone" value="{$monitored_phone}" style="width:350px;"/>
    </td>
    </tr>
        {/if}
</table>
    <div class="form-actions" style="text-align: center">


<input type="submit" style="font-weight:bold" value="Update monitoring contact" class="btn btn-info ">
<div class="clear"></div>
</div>{securitytoken}
</form>
