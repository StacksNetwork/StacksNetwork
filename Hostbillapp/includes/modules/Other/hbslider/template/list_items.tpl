{if $sliders}
<h3>Your sliders:</h3>
<table class="table table-bordered">
    {foreach from=$sliders item=slider}
    <tr>
        <td>
            {$slider.name}
        </td>
        <td width="50">
           <div class="btn-group">
                <button data-toggle="dropdown" class="btn dropdown-toggle btn-mini"><i class="icon-cog"></i> <span class="caret"></span></button>
                <ul class="dropdown-menu fs11 pull-right">
                  <li><a href="?cmd=hbslider&action=edit&id={$slider.id}">Edit</a></li>
                  <li><a href="?cmd=hbslider&action=slides&id={$slider.id}">Manage slides</a></li>
                  <li><a href="?cmd=hbslider&action=html&id={$slider.id}">Get HTML code</a></li>
                  <li><a href="?cmd=hbslider&action=remove&id={$slider.id}&security_token={$security_token}" style="color:red" onclick="return confirm('Are you sure?')">Remove</a></li>
                </ul>
              </div>
        </td>
    </tr>
    {/foreach}
</table>
{else}
<center>
<em>You don't have any sliders created yet</em>
</center>
{/if}
<center>
<br/>
<br/>
<a class="btn btn-success btn-large" href="?cmd=hbslider&action=add" style="color:white;">Create new slider</a>
</center>