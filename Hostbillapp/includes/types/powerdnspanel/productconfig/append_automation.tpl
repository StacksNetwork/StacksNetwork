<table border="0" cellpadding="6" cellspacing="0" width="100%" class="editor-container">
    <tr class="odd">
        <td align="right" width="200"><strong>Metered: Send usage report to staff</strong></td>
        <td><select name="config[MeteredUsageStaff]" class="inp">
                <option value="No" {if $configuration.MeteredUsageStaff=='No'}selected="selected"{/if}>Off</option>
                <option value="Daily" {if $configuration.MeteredUsageStaff=='Daily' || !$configuration.MeteredUsageStaff}selected="selected"{/if}>Daily</option>
                <option value="Weekly" {if $configuration.MeteredUsageStaff=='Weekly'}selected="selected"{/if}>On Mondays</option>
                <option value="Monthly" {if $configuration.MeteredUsageStaff=='Monthly'}selected="selected"{/if}>Every 1st day of month</option>
            </select>
        </td>
    </tr>
    <tr >
        <td align="right" width="200"><strong>Metered: Send usage report to client</strong></td>
        <td><select name="config[MeteredUsageClient]" class="inp">
                <option value="No" {if $configuration.MeteredUsageClient=='No' ||  !$configuration.MeteredUsageClient}selected="selected"{/if}>Off</option>
                <option value="7days" {if $configuration.MeteredUsageClient=='7days'}selected="selected"{/if}>7 days before invoice</option>
                <option value="30days" {if $configuration.MeteredUsageClient=='30days'}selected="selected"{/if}>30 days before invoice</option>
            </select>
        </td>
    </tr>
     <tr class="odd">
        <td align="right" width="200"><strong>Metered: Update usage statistics</strong></td>
        <td><select name="config[MeteredUsageUpdateF]" class="inp">
                <option value="Hourly" {if $configuration.MeteredUsageUpdateF=='Hourly'}selected="selected"{/if}>Hourly</option>
                <option value="Daily" {if $configuration.MeteredUsageUpdateF=='Daily' || !$configuration.MeteredUsageUpdateF}selected="selected"{/if}>Daily</option>
                <option value="Weekly" {if $configuration.MeteredUsageUpdateF=='Weekly'}selected="selected"{/if}>Weekly</option>
                <option value="Monthly" {if $configuration.MeteredUsageUpdateF=='Monthly'}selected="selected"{/if}>Monthly</option>
            </select>
        </td>
    </tr>
    
</table>