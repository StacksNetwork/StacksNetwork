{if $action=='add'}
    <form method="post">
        <input type="hidden" name="make" value="add"/>
        <table width="100%" cellspacing="2" cellpadding="3" border="0" >
            <tbody>
                <tr>
                    <td width="20%">{$lang.departmentname}</td>
                    <td ><input type="text" value="{$submit.name}" size="25" name="name"/></td>
                </tr>
                <tr>
                    <td>{$lang.Description}</td>
                    <td ><input type="text" value="{$submit.description}" size="50" name="description"/></td>
                </tr>
                <tr>
                    <td>{$lang.email}</td>
                    <td ><input type="text" value="{$submit.email}" size="40" name="email"/></td>
                </tr>
                <tr>
                    <td>{$lang.clientsonly}</td>
                    <td ><input type="checkbox" name="clientsonly"  value="1" {if $submit.clientsonly=='1'}checked="checked"{/if}/>
                        {$lang.deptonlyforregistered}</td>
                </tr>
                <tr>
                    <td>{$lang.visibledept}</td>
                    <td ><input type="checkbox" name="visible" value="1" {if $submit.visible=='1'}checked="checked"{/if}/>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">{$lang.assignedadmins}</td>
                </tr>
                {foreach from=$admins item=admin}
                    <tr>
                        <td><input type="checkbox" name="assigned_admins[]" value="{$admin.id}" {if is_array($submit.assigned_admins) && in_array($admin.id,$submit.assigned_admins)}checked="checked"{/if}/></td>
                        <td >{$admin.username}</td>
                    </tr>
                {/foreach}
            </tbody>
        </table>
        <input type="submit" value="{$lang.submit}" />
        {securitytoken}
    </form>
{elseif $action=='edit'}
    <form method="post">
        <input type="hidden" name="make" value="edit"/>
        <table width="100%" cellspacing="2" cellpadding="3" border="0" >
            <tbody>
                <tr>
                    <td width="20%">{$lang.departmentname}</td>
                    <td ><input type="text" value="{$dept.name}" size="25" name="name"/></td>
                </tr>
                <tr>
                    <td>{$lang.Description}</td>
                    <td ><input type="text" value="{$dept.description}" size="50" name="description"/></td>
                </tr>
                <tr>
                    <td>{$lang.email}</td>
                    <td ><input type="text" value="{$dept.email}" size="40" name="email"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td ><input type="checkbox" name="clientsonly"  value="1" {if $dept.clientsonly=='1'}checked="checked"{/if}/>
                        {$lang.deptonlyforregistered} </td>
                </tr>
                <tr>
                    <td></td>
                    <td ><input type="checkbox" name="visible" value="1" {if $dept.visible=='1'}checked="checked"{/if}/>
                        {$lang.displaydeptinca}
                    </td>
                </tr>
                <tr>
                    <td colspan="2">{$lang.assignedadmins}:</td>
                </tr>
                {foreach from=$admins item=admin}
                    <tr>
                        <td><input type="checkbox" name="assigned_admins[]" value="{$admin.id}" {if is_array($dept.assigned_admins) && in_array($admin.id,$dept.assigned_admins)}checked="checked"{/if}/></td>
                        <td >{$admin.username}</td>
                    </tr>
                {/foreach}
            </tbody>

        </table>
        <input type="submit" value="{$lang.submit}" />
        {securitytoken}
    </form>
{else} 
    <a href="?cmd=ticketdepts&action=add">{$lang.addnewdepartment}</a><br />
    {if $depts}
        <script type="text/javascript">
            {literal}
                function sortit(element, act) {

                    var tr = $(element).parent().parent();

                    if (act == 'up') {
                        var prev = tr.prev();
                        if (prev.length > 0) {
                            $(tr).insertBefore(prev);
                        }

                    } else if (act == 'down') {
                        var next = tr.next();
                        if (next.length > 0) {
                            $(tr).insertAfter(next);
                        }

                    }

                    var sorts = $('#serializeit').serialize();
                    ajax_update('?cmd=ticketdepts&' + sorts, {}, '#updater', false);
                }
            {/literal} 
        </script>
        <div class="tablebg"><form id="serializeit" method="post">
                <table width="100%" cellspacing="1" cellpadding="3" border="1" class="datatable">
                    <tbody>
                        <tr>
                            <th>{$lang.departmentname}</th>
                            <th>{$lang.Description}</th>
                            <th>{$lang.email}</th>
                            <th>{$lang.hiddendept}</th>
                            <th width="20"></th>
                            <th width="20"></th>
                            <th width="20"></th>
                        </tr>
                    </tbody>
                    <tbody id="updater"> 
                        {include file='ajax.ticketdepts.tpl'}
                    </tbody> 
                </table>
                {securitytoken}
            </form>
        </div>
    {/if}
{/if}