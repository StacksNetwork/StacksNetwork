<table width="100%" border="0" cellspacing="0" cellpadding="0" id="content_tb">
    <tbody>
        <tr>
            <td colspan="2"><h3>OrderPages A/B Testing</h3></td>
        </tr>
        <tr>
            <td rowspan="2" style="line-height:20px;" class="leftNav"></td>
            <td  valign="top"  class="bordered" ><div id="bodycont">
                    {if $tests}<div style="padding:15px;background:#F5F9FF;">
<table width="100%" cellspacing="0" cellpadding="3" border="0" style="border:solid 1px #ddd;" class="whitetable">
<tbody>
<tr>
<th align="left" colspan="4">Current tests</th>
</tr>
{foreach from=$tests item=test}
<tr class="man">
<td style="padding-left:10px"><a href="?cmd=abtesting&action=edit&id={$test.id}">{$test.name}</a></td>
<td width="17" class="lastitm"><a onclick="return confirm('Do you really want to delete this A/B test?')" class="delbtn" href="?cmd=abtesting&action=delete&id={$test.id}&security_token={$security_token}">Delete</a></td>
</tr>{/foreach}
</tbody>
</table>
                    </div>{/if}
                    <div id="blank_state" class="blank_state blank_news">
                        <div class="blank_info">
                            <h1>Test which orderpage brings you most sales</h1>
                            This plugin is built to work with Google Analytics. How it works: <ol>
                                <li>Add Google Analytics to your HostBill clientarea - <a href="http://dev.hostbillapp.com/additional-resources/adding-google-analytics-ecommerce-tracking/" target="_blank">learn how</a></li>
                                <li>Create new experiment in Google Analytics panel - <a href="http://support.google.com/analytics/bin/answer.py?hl=en&answer=1745210&topic=1745207&ctx=topic" target="_blank">learn how</a></li>
                                <li>You'll be asked for two URLs, to get them <a  href="?cmd=abtesting&action=add&security_token={$security_token}">create new A/B test case</a> using this plugin</li>
                                <li>During creation, select Product category from HostBill you wish to test with, and its new orderpage to compare results with</li>
                                <li>Paste your experiment javascript code from Analytics to this plugin</li>
                                <li>Save changes, you can now start your experiment with Google Analytics</li>

                            </ol>
                            <div class="clear"></div>
                            <a class="new_add new_menu" href="?cmd=abtesting&action=add&security_token={$security_token}"  style="margin-top:10px">
                                <span>Create new A/B Test case</span></a>
                            <div class="clear"></div>
                        </div>
                    </div>
                </div>

            </td>
        </tr>
</table>