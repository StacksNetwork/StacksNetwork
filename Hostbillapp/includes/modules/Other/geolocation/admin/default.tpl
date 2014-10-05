<script type="text/javascript" src="{$moduleurl}script.js"></script>
<link media="all" type="text/css" rel="stylesheet" href="{$moduleurl}styles.css"/>

<div class="newhorizontalnav" id="newshelfnav">
    <div class="list-1">
        <ul>
            <li {if !$action || $action == 'default'}class="active"{/if}>
                <a href="?cmd=geolocation"><span>地理(Geo)规则</span></a>
            </li>
            <li class="last{if $action == 'database'} active{/if}">
                <a href="?cmd=geolocation&action=database"><span>地理(Geo)数据库</span></a>
            </li>
        </ul>
    </div>
</div>
{if $action == 'database'}
    <div class="sectioncontent geo-database">
        <div  class="nicerblu">
        {if $ChatGeoIPEnabled!='on'} <div class="imp_msg">注意: 地理IP(GeoIP)追踪的在您的系统中尚未启用! 按下面的说明更新您的数据库</div>{/if}
        {if $import}
            <div class="p6" style="padding:15px;margin-top:10px;">
                <table border="0" cellspacing="0" cellpadding="3" >
                    <tr><td colspan="2"> <strong>数据库导入/更新: {$import} </strong></td></tr>
                    <tr><td width="150">行 <a class="vtip_description" title="每一个Ajax调用解析CSV线程数. 值越高需要更强的服务器"></a></td><td><input class="inp" size="3" value="100000" id="line_limit" /></td></tr>
                    <tr><td width="150">支付 <a class="vtip_description" title="使用每个Ajax调用数据库的线程数. 值越高需要更强的服务器"></a></td><td><input class="inp" size="3" value="20" id="pass_limit" /></td></tr>
                    <tr><td colspan="2" style="padding-top:15px;"><a href="#" class="new_control" onclick="$(this).hide(); return start_import('{$import}');"><span class="gear_small"><b>数据库导入</b></span></a></td></tr>

                </table>


            </div>


            <div id="testconfigcontainer" style="padding:15px">
                <div style="height:20px"><div style="display: none;" class="lxa spinner " id="spinner"><img src="ajax-loading2.gif"></div></div>
                <div style="display: none;height:60px;" id="testcontainer">
                    <div><strong>不刷新或关闭本页! 如果进程将停止或挂起, 重新登录并再次尝试.</strong></div>
                    <div id="testcontent" >

                    </div>
                </div>
            </div>
        {/if}

        <br/><br/><strong >HowTo: 安装/更新GeoIP数据库 <a href="#" onclick="$('#geoshow').show();return false" >显示</a></strong>
        <div id="geoshow" style="display:none;padding:5px;">
            1. 下载最新的CSV文件从 <a href="http://www.maxmind.com/app/geolitecity" target="_blank">http://www.maxmind.com/app/geolitecity</a> <br/>
            2. 上传服务器并解压文件内容至 includes/libs/geoip 目录. 这将创建目录, i.e.: includes/libs/geoip/GeoLite2-City-CSV_20140909 <br />
            3. 刷新本页面 - 数据库导入/更新选项将显示. <br/>
            4. 一旦导入开始 - 请不要刷新本页! 数据库导入是耗时的过程, 您将会收到它进展的通知.<br />
            5. 如果导入过程失败(挂起), 刷新浏览器和调整导入参数.</div>
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
                    $('#testcontent').prepend('<div><strong>错误!</strong></div>');
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
                    $('#testcontent').prepend('<div><strong>错误!</strong></div>');
                    $('#testcontent').prepend('<div><strong>' + response.re.msg + '</strong></div>');
                    $('#spinner').hide();
                    return;

                }

                if (response.re.finished) {
                    $('#testcontent').prepend('<div><strong>导入完成!</strong></div>');
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
                <span class="addsth">创建新的地理(Geo)规则</span>
            </a>
        </div>
        {if !$rules}
            <div id="blank_state" class="blank_state blank_news">
                <div class="blank_info">
                    <h1> 对象客户直接基于他们的位置 </h1>
                    用系统可以设置适当的用户语言, 针对客户地区可以对应应用货币或支付网关
                    <div class="clear"></div>
                    {if !$geo_db}
                        <a class="new_ddown new_menu" href="?cmd=geolocation&action=database" style="margin-top:10px">
                            <span>地理(GeoLocation)数据库的创建</span>
                        </a>
                        <div class="clear"></div>
                    {else}
                        <a class="new_add new_menu" href="#" onclick="geolocation.newform(); $('#blank_state').hide(); $('#geo-list').show(); return false;" style="margin-top:10px">
                            <span>添加新规则</span></a>
                        <div class="clear"></div>
                    {/if}
                </div>
            </div>
        {/if}
        <form action="?cmd=geolocation&action=add" method="post" onsubmit="geolocation.submit(this); return false;" style="display: none;" id="geoform">
            <div class="geo-new-rule">
                <div class="geo-loc left">
                    <h3>位置 <img src="{$template_dir}img/ajax-loader3.gif" style="display:none" class="ajax-load" /></h3>
                    <label>
                        <span>国家</span> 
                        <select name="country" class="load-values inp">
                            <option value=""> 未选定 </option>
                            {foreach from=$countries item=country key=code}
                                <option value="{$code}">{$country}</option>
                            {/foreach}
                        </select>
                    </label>
                    <label>
                        <span>Region</span> 
                        <select name="region" class="load-values inp">
                            <option value=""> 所有 </option>
                        </select>
                    </label>
                    <label>
                        <span>City</span> 
                        <select name="city" class="load-values inp">
                            <option value=""> 所有 </option>
                        </select>
                    </label>

                </div>
                <div class="geo-actions left">
                    <h3>动作</h3>
                    <label>
                        <span>设置语言</span> 
                        <select name="language" class="inp">
                            <option value=""> 默认 </option>
                            {foreach from=$languages item=language} 
                                <option value="{$language}"> {$language|capitalize} </option>
                            {/foreach}
                        </select>
                    </label>
                    <label>
                        <span>设置货币</span> 
                        <select name="currency" class="inp">
                            {foreach from=$currencies item=crr} 
                                <option value="{$crr.id}"> {$crr.code} {if $crr.sign}( {$crr.sign} ){/if} </option>
                            {/foreach}
                        </select>
                    </label>
                    <div class="geo-label-lkie">
                        <span>支付接口</span> 
                        {if $modules}
                            <label><input class="geo-all-gates" type="checkbox" name="gates[]" checked="checked" value="all" onchange="geolocation.gates(this);" /> 所有支付接口</label>
                            <div class="geo-gates" style="display:none">
                            {foreach from=$modules item=gateway key=id}
                                <label><input type="checkbox" name="gates[]" checked="checked" value="{$id}" onchange="geolocation.gates(this);"/> {$gateway}</label>                           
                            {/foreach}
                            </div>
                        {else}
                            <a href="?cmd=managemodules&action=payment"> 没有可用的支付接口</a>
                        {/if}
                    </div>
                </div>
                <div class="clear"></div>
                <input type="submit" class="new_control" value="创建规则"/>
                <input type="submit" class="new_control" onclick="geolocation.cancel(); return false;" value="取消"/>
            </div>
            {securitytoken}
        </form>
    </div>
{/if}

