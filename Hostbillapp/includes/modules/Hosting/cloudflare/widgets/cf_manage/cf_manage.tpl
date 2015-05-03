{foreach from=$widgets item=wig}
    {if $widget.name == $wig.name}
        {assign value=$wig.location var=widgeturl}
    {/if}
{/foreach}
<h3>{if $lang[$widget.name]}{$lang[$widget.name]}{elseif $widget.fullname}{$widget.fullname}{else}{$widget.name}{/if}</h3>

{if $needs_auth}
    <p>Before you can start using CloudFlare, we will need you to authorize your account.</p>
    <br />
    <form class="form-horizontal" action="{$ca_url}{$cmd}/{$action}/{$service.slug}/{$service.id}/&widget={$widget.name}" method="POST">
        <input type="hidden" name="do" value="auth" />
        <div class="control-group">
            <label class="control-label" for="inputEmail">Email</label>
            <div class="controls">
                <input type="text" id="inputEmail" value="{$service.extra_details.usedemail}" readonly="readonly">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label" for="inputPassword">Password</label>
            <div class="controls">
                <input type="password" name="password" id="inputPassword" placeholder="Password">
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <label class="checkbox">
                    <input type="checkbox" name="savepass"> Save my pasword <a href="#" class="vtip_description" title="If you select this option, yor password will be stored in our database, you will be able to reatreave it later if you forget it. This is NOT required."></a>
                </label>
            </div>
        </div>
        <div class="control-group">
            <div class="controls">
                <button type="submit" class="btn">Authorize</button>
            </div>
        </div>
        {securitytoken}
    </form>
{else}
    <p>Choose which website you want to activate by clicking on the cloud, domains are listed from yor current DNS service. <br />
        We will activate CloudFlare for the subdomain 'www' and you can choose the additional subdomains to activate.</p>
   
{/if}
    <table class="table table-striped">
        <tr>
            <th colspan="2">
                Domain
                <span style="display: block; font-size: 80%; font-weight: normal;">You can activate and deactivate CloudFlare for each website by toggling between the orange and grey cloud.</spn>
            </th>
        </tr>
        {foreach from=$zones item=zone}
            <tr>
                <td>{$zone.domain}</td>
                <td class="span6">
                    {if !$zone.hosted}
                        <a href="#" title="Enable CloudFlare for this domain" onclick="$(this).hide().next().show();
                                return false">
                            <img src="{$widgeturl}solo_cloud_off.png" style="margin: 1px 0 2px"/>
                        </a>
                        <form class="form form-inline" style="display: none; margin: 0" action="{$ca_url}{$cmd}/{$action}/{$service.slug}/{$service.id}/&widget={$widget.name}" method="POST">
                            <input type="hidden" name="domain" value="{$zone.domain_id}" />
                            <input type="hidden" name="enable" value="1" />
                            <input type="text" class="span4" name="subdomains" placeholder="List of subdomains, comma separated" /> 
                            <input class="btn btn-success" type="submit" value="Enable" />
                            {securitytoken}
                        </form>
                    {else}
                        <a href="{$ca_url}{$cmd}/{$action}/{$service.slug}/{$service.id}/&widget={$widget.name}&domain={$zone.domain_id}&enable=0&security_token={$security_token}" 
                           title="Disable CloudFlare for this domain"
                           onclick="return confirm('Are you sure you want to disable CloudFlare for this domain?')">
                            <img src="{$widgeturl}solo_cloud.png" style="margin: 1px 0"/>
                        </a>
                    {/if}
                </td>
            </tr>
            {foreachelse}
                <tr>
                    <td colspan="2">{$lang.nothing}</td>
                </tr>
        {/foreach}
    </table>
