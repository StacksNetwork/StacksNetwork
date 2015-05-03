<script type="text/javascript" src="{$moduleurl}script.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$moduleurl}styles.css"/>

<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li {if !$action || $action == 'default'}class="active"{/if}>
                <a href="?cmd=geolocation"><span>Geo Rules</span></a>
            </li>
            <li class="last{if $action == 'database'} active{/if}">
                <a href="?cmd=geolocation&action=database"><span>Geo Database</span></a>
            </li>
        </ul>
    </div>
</div>
{if $action == 'database'}
    <div class="sectioncontent geo-database">
        <div  class="nicerblu">
        {if $ChatGeoIPEnabled!='on'} <div class="imp_msg">Note: GeoIP tracking is not enabled in your HostBill yet! Follow instructions below to update your database</div>{/if}
        {if $import}
            <div class="p6" style="padding:15px;margin-top:10px;">
                <table border="0" cellspacing="0" cellpadding="3" >
                    <tr><td colspan="2"> <strong>Database to import/update: {$import} </strong></td></tr>
                    <tr><td width="150">Lines <a class="vtip_description" title="Number of csv lines to parse per one ajax call. Higher values require more powerful servers"></a></td><td><input class="inp" size="3" value="1000" id="line_limit" /></td></tr>
                    <tr><td width="150">Transactions <a class="vtip_description" title="Number of database transactions to use per ajax call. Higher values require more powerful servers"></a></td><td><input class="inp" size="3" value="2" id="pass_limit" /></td></tr>
                    <tr><td colspan="2" style="padding-top:15px;"><a href="#" class="new_control" onclick="$(this).hide(); return start_import('{$import}');"><span class="gear_small"><b>Import database</b></span></a></td></tr>

                </table>


            </div>


            <div id="testconfigcontainer" style="padding:15px">
                <div style="height:20px"><div style="display: none;" class="lxa spinner " id="spinner"><img src="ajax-loading2.gif"></div></div>
                <div style="display: none;height:60px;" id="testcontainer">
                    <div><strong>Do not refresh or close this page! If progress will stop or hang, re-login and try again.</strong></div>
                    <div id="testcontent" >

                    </div>
                </div>
            </div>
        {/if}

        <br/><br/><strong >HowTo: Install/Update GeoIP database <a href="#" onclick="$('#geoshow').show();return false" >show</a></strong>
        <div id="geoshow" style="display:none;padding:5px;">
            1. Download latest CSV zip file from <a href="http://www.maxmind.com/app/geolitecity" target="_blank">http://www.maxmind.com/app/geolitecity</a> <br/>
            2. Upload on server and extract archive contents into includes/libs/geoip directory. It will create directory, i.e.: includes/libs/geoip/GeoLiteCity_20111206 <br />
            3. Refresh this page - database import/update option will show up. <br/>
            4. Once import starts - do not refresh this page! Database import is time-consuming process, you will be notified about its progress.<br />
            5. If import process fails (hangs), refresh browser and adjust import parameters</div>
    </div>
    {literal}
        <script type="text/javascript">
            var line_limit=300;
            var pass_limit=3;
            function start_import(filex) {
                line_limit=$('#line_limit').val();
                pass_limit=$('#pass_limit').val();
                $('#testcontainer').slideDown();
                $('#spinner').show();
                $.getJSON('?cmd=geolocation&action=geoimport',{part:'blocks',file:filex,limit:line_limit,passes:pass_limit},blocks_loop);
                return false;
            }


            function blocks_loop(response) {
                if(response.re.loop==0) {
                    $('#spinner').hide();
                    $('#testcontent').prepend('<div><strong>ERROR!</strong></div>');
                    $('#testcontent').prepend('<div><strong>' + response.re.msg + '</strong></div>');
                    return;
                }
                if (response.re.finished) {
                    $('#spinner').hide();

                    return location_loop({re: {loop: 1, file: response.re.file}});
                }
                if (response.re.msg) {
                    $('#testcontent').text(response.re.msg);
                }
                var offset = typeof(response.re.offset) != 'undefined' ? response.re.offset : 0;
                $.getJSON('?cmd=geolocation&action=geoimport', {part: 'blocks', file: response.re.file, offset: offset, limit: line_limit, passes: pass_limit}, blocks_loop)


            }
            function location_loop(response) {
                if (response.re.loop == 0) {
                    $('#testcontent').prepend('<div><strong>ERROR!</strong></div>');
                    $('#testcontent').prepend('<div><strong>' + response.re.msg + '</strong></div>');
                    $('#spinner').hide();
                    return;

                }

                if (response.re.finished) {
                    $('#testcontent').prepend('<div><strong>IMPORT FINISHED!</strong></div>');
                    $('#spinner').hide();
                    return;
                }

                if (response.re.msg) {
                    $('#testcontent').text(response.re.msg);
                }
                var offset = typeof(response.re.offset) != 'undefined' ? response.re.offset : 0;
                $.getJSON('?cmd=geolocation&action=geoimport', {part: 'locations', file: response.re.file, offset: offset, limit: line_limit, passes: pass_limit}, location_loop);

            }
        </script>

        <style type="text/css">
            #testcontainer {
            background: none repeat scroll 0 0 #303030;
            color: #FFFFFF;
            height: 220px;
            overflow: auto;
        }
        .lxa {
            margin-right: 10px;
        }
        #facebox .lxa {
            display: none;
            height: 0;
        }
        #testcontainer #testcontent {
            padding: 5px;
        }

        </style>
    {/literal}
    </div>
{else}
    <div class="sectioncontent geo-rules">
        <div id="geo-list" {if !$rules}style="display:none"{/if}> 
            <ul class="grab-sorter{if !$rules} empty blank_news{/if}"  >
                {include file='ajax.default.tpl'}
            </ul>
            <a id="addnew_btn" onclick="geolocation.newform(); return false;" class="new_control" href="#">
                <span class="addsth">Create new geo rules</span>
            </a>
        </div>
        {if !$rules}
            <div id="blank_state" class="blank_state blank_news">
                <div class="blank_info">
                    <h1> Target your customers directly based on their location </h1>
                    With HostBill you can set appropriate user language, currency or available gateways for your client basing on their location
                    <div class="clear"></div>
                    {if !$geo_db}
                        <a class="new_ddown new_menu" href="?cmd=geolocation&action=database" style="margin-top:10px">
                            <span>Create GeoLocation database</span>
                        </a>
                        <div class="clear"></div>
                    {else}
                        <a class="new_add new_menu" href="#" onclick="geolocation.newform(); $('#blank_state').hide(); $('#geo-list').show(); return false;" style="margin-top:10px">
                            <span>Add new rule</span></a>
                        <div class="clear"></div>
                    {/if}
                </div>
            </div>
        {/if}
        <form action="?cmd=geolocation&action=add" method="post" onsubmit="geolocation.submit(this); return false;" style="display: none;" id="geoform">
            <div class="geo-new-rule">
                <div class="geo-loc left">
                    <h3>Location <img src="{$template_dir}img/ajax-loader3.gif" style="display:none" class="ajax-load" /></h3>
                    <label>
                        <span>Country</span> 
                        <select name="country" class="load-values inp">
                            <option value=""> Not selected </option>
                            {foreach from=$countries item=country key=code}
                                <option value="{$code}">{$country}</option>
                            {/foreach}
                        </select>
                    </label>
                    <label>
                        <span>Region</span> 
                        <select name="region" class="load-values inp">
                            <option value=""> All </option>
                        </select>
                    </label>
                    <label>
                        <span>City</span> 
                        <select name="city" class="load-values inp">
                            <option value=""> All </option>
                        </select>
                    </label>

                </div>
                <div class="geo-actions left">
                    <h3>Actions</h3>
                    <label>
                        <span>Set language</span> 
                        <select name="language" class="inp">
                            <option value=""> Default </option>
                            {foreach from=$languages item=language} 
                                <option value="{$language}"> {$language|capitalize} </option>
                            {/foreach}
                        </select>
                    </label>
                    <label>
                        <span>Set currency</span> 
                        <select name="currency" class="inp">
                            {foreach from=$currencies item=crr} 
                                <option value="{$crr.id}"> {$crr.code} {if $crr.sign}( {$crr.sign} ){/if} </option>
                            {/foreach}
                        </select>
                    </label>
                    <div class="geo-label-lkie">
                        <span>Payment gateways</span> 
                        {if $modules}
                            <label><input class="geo-all-gates" type="checkbox" name="gates[]" checked="checked" value="all" onchange="geolocation.gates(this);" /> All gateways</label>
                            <div class="geo-gates" style="display:none">
                            {foreach from=$modules item=gateway key=id}
                                <label><input type="checkbox" name="gates[]" checked="checked" value="{$id}" onchange="geolocation.gates(this);"/> {$gateway}</label>                           
                            {/foreach}
                            </div>
                        {else}
                            <a href="?cmd=managemodules&action=payment"> No active payment gateways</a>
                        {/if}
                    </div>
                </div>
                <div class="clear"></div>
                <input type="submit" class="new_control" value="Create rule"/>
                <input type="submit" class="new_control" onclick="geolocation.cancel(); return false;" value="Cancel"/>
            </div>
            {securitytoken}
        </form>
    </div>
{/if}

