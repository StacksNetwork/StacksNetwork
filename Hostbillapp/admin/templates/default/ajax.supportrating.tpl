{if !$ajax}
    <div class="blu"> 
        <strong>{$lang.supportrating}</strong>
    </div>
    <link type="text/css" rel="stylesheet" href="{$template_dir}js/jRating.jquery.css" />
    <div class="newhorizontalnav" id="newshelfnav">
        <div class="list-1">
            <ul>
                <li class="{if !$action || $action=='default'}active {/if}">
                    <a href="?cmd={$cmd}"><span>{$lang.allrating}</span></a>
                </li>
                <li {if $action=='staff'}class="active"{/if}>
                    <a href="?cmd={$cmd}&action=staff"><span>{$lang.staffrating}</span></a>
                </li>
                <li {if $action=='departments'}class="active"{/if}>
                    <a href="?cmd={$cmd}&action=departments"><span>{$lang.dptrating}</span></a>
                </li>
                <li class="{if $action=='config'}active {/if}{if $action!='details'}last{/if}">
                    <a href="?cmd={$cmd}&action=config"><span>{$lang.Configuration}</span></a>
                </li>
                {if $action=='details'}
                    <li class="active last">
                        <a href=""><span>{$name}</span></a>
                    </li>
                {/if}
            </ul>
        </div>

        <div class="list-2">
            <div class="subm1 haveitems" style="display: block;{if $action =='config' || !$enableddepts}height:0px{/if}">
                {if $action !='config' && $enableddepts}
                    <form action="?cmd={$cmd}&action={$action}{if $type}&type={$type}&id={$id}{/if}" id="rateform" method="post" > 
                        <select id="daterange" name="year">
                            <option value=''>{$lang.ofalltime}</option>
                            {foreach from=$dates item=y key=v}
                                <option {if $selectedyear == $v}selected="selected"{/if} value="{$y}">{$v}</option>
                            {/foreach}
                        </select>
                        <select id="daterangem" name="month">
                            <option value=''>{$lang.allmonths}</option>
                            {foreach from=$months item=y key=v}
                                {if $v}
                                    <option {if $selectedmonth === $v}selected="selected"{/if} value="{$v}">{$y}</option>
                                {/if}
                            {/foreach}
                        </select>
                        <a class="new_control greenbtn" href="#" onclick="$('#rateform').submit();
                                return false;"><span>提交</span></a> 
                    </form>
                    {literal}
                        <script type="text/javascript">
                            $('#rateform').submit(function(e) {
                                function uri(url, params){
                                    var uri = JSON.parse('{"' + url.substr(1).replace(/&/g, '","').replace(/=/g, '":"') + '"}',
                                        function(key, value) {
                                            return key === "" ? value : decodeURIComponent(value)
                                        }),
                                            o = uri.orderby;
                                        delete uri.orderby;
                                        $.extend(uri, params);
                                        uri.orderby = o;
                                        return '?' + $.param(uri).replace(/%7C/g,'|');
                                }
                                
                                e.preventDefault();
                                var self = $(this),
                                    c = $('#currentlist'),
                                    params = {
                                        year: self[0].year.value,
                                        month: self[0].month.value
                                    },
                                    href = uri(c.attr('href'), params);
                                    
                                c.attr('href', href);
                                $('.sortorder').each(function(){
                                    var self = $(this);
                                    self.attr('href', uri(self.attr('href'), params));
                                });
                                
                                $('#updater').addLoader();
                                $.get(href, function(data) {
                                    data = parse_response(data);
                                    if (data.length)
                                        $('#updater').html(data);
                                })
                            });
                        </script>
                    {/literal}
                {/if}
            </div>
        </div>

    </div>

    <div style="padding: 0px; display: block;" class="sectioncontent">
        {if $action !='config'}
            {if !$enableddepts}
                <div style="padding: 145.5px 15px;" class="blank_state blank_news" id="blank_state">
                    <div class="blank_info">
                        <h1>{$lang.ratingdisabled}</h1>
                        {$lang.norateddepartment}
                    </div>

                </div>
            {else}
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>

                <input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
                <a href="?cmd={$cmd}&action={$action}{if $type}&type={$type}&id={$id}{/if}" id="currentlist" style="display:none" updater="#updater"></a>
                <table class="glike hover" cellpadding="6" cellspacing="0" style="width: 100%">

                    <thead>
                        <tr>
                            {if $action !='details'}
                                <th><a href="?cmd={$cmd}&action={$action}&orderby=avg|ASC"  class="sortorder">{$lang.avergerating}</a></th>
                                    {if $action && $action!=='default'}
                                    <th>
                                        {if $action=='departments'}
                                            <a href="?cmd={$cmd}&action={$action}&orderby=name|ASC"  class="sortorder">部门</a>
                                        {else}
                                            <a href="?cmd={$cmd}&action={$action}&orderby=name|ASC"  class="sortorder">员工</a>
                                        {/if} 
                                    </th>
                                {/if}
                                <th><a href="?cmd={$cmd}&action={$action}&orderby=rated|ASC"  class="sortorder">{$lang.rated}</a></th>
                                <th><a href="?cmd={$cmd}&action={$action}&orderby=replies|ASC"  class="sortorder">{$lang.unrated}</a></th>
                                <th><a href="?cmd={$cmd}&action={$action}&orderby=max|ASC"  class="sortorder">{$lang.bestrating}</a></th>
                                <th><a href="?cmd={$cmd}&action={$action}&orderby=min|ASC"  class="sortorder">{$lang.lowestrating}</a></th>
                                {else}
                                <th><a href="?cmd={$cmd}&action={$action}&type={$type}&id={$id}&orderby=rating|ASC"  class="sortorder">{$lang.rated}</a></th>
                                <th>
                                    {if $action=='departments'}
                                        <a href="?cmd={$cmd}&action={$action}&type={$type}&id={$id}&orderby=name|ASC"  class="sortorder">员工</a>
                                    {else}
                                        <a href="?cmd={$cmd}&action={$action}&type={$type}&id={$id}&orderby=name|ASC"  class="sortorder">部门</a>
                                    {/if} 
                                </th>
                                <th>回复</th>
                                <th style="width:130px">工单</th>
                                <th style="width:130px"><a href="?cmd={$cmd}&action={$action}&type={$type}&id={$id}&orderby=date|ASC"  class="sortorder">回复日期</a></th>
                                <th style="width:130px"><a href="?cmd={$cmd}&action={$action}&type={$type}&id={$id}&orderby=rdate|ASC"  class="sortorder">评级日期</a></th>
                                {/if}
                        </tr>
                    </thead>
                    <tbody id="updater">
                        {include file='ajax.supportrating.tpl' ajax=1}
                    </tbody>
                    <tbody id="psummary">
                        <tr>
                            <th></th>
                            <th {if $tview}colspan="{$columns_count+1}"{else}colspan="6"{/if}>
                                {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                            </th>
                        </tr>
                    </tbody>
                </table>
                <div class="blu">
                    <div class="right">
                        <div class="pagination"></div>
                    </div>
                    <div class="clear"></div>
                </div>
            {/if}
        {else}
            <div class="nicerblu">
                <form method="POST" action="" onsubmit="return recalc();" id="ratingform">
                    <table width="100%" cellspacing="0" cellpadding="6" border="0">
                        <tr>
                            <td style="width: 120px; text-align: right"><strong>{$lang.ratingscale}</strong></td>
                            <td>
                                <input type="hidden" name="old_scale" value="{$rate}" id="oldscale"/>
                                <select class="inp" name="rating_scale" id="newscale">
                                    <option {if $rate == 1}selected="selected"{/if} value="1">5</option>
                                    <option {if $rate == 2}selected="selected"{/if} value="2">10</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <input type="submit" name="submit" style="font-weight:bold" value="{$lang.savechanges}">
                            </td>
                        </tr>
                    </table>
                    {securitytoken}
                </form>
                {literal}
                    <script type="text/javascript">
                        function recalc() {
                            if ($('#oldscale').val() != $('#newscale').val()) {
                                if (confirm('Do you want to recalculate current rating?')) {
                                    $('#ratingform').append('<input name="recalc" type="hidden" value="1" />');
                                }
                            }
                            return true;
                        }
                    </script>
                {/literal}
            </div>
        {/if}
    </div> 
{else}
    {foreach from=$ratings item=rating}
        <tr>
            <td style="width: {$starwidth}px; background: white;">
                <div style="height: 20px; width: {$starwidth}px; overflow: hidden; z-index: 1; position: relative; cursor: default;">
                    <div class="jRatingColor" style="width: {$rating.percent}%;"></div>
                    <div class="jRatingAverage" style="width: 0px; top: -20px;"></div>
                    <div class="jStar" style="width: {$starwidth}px; height: 20px; top: -40px;"></div>
                    <div style="position: absolute; left: 28%; bottom: 0px; z-index: 14; font-weight: bold; color: darkred; text-shadow: -1px -1px 0px white;">{$rating.avg} / {$max}</div>
                </div>
            </td>
            {if $action && $action!=='default'}
                <td><a href="?cmd={$cmd}&action=details{if $dtype}&type={$dtype}&id={$rating.id}{/if}">{$rating.name}</a></td>
                {/if}
                {if $action !='details'}
                    {if $rating.id}
                    <td>{$rating.rated}</td>
                    <td>{$rating.unrated}</td>
                    <td>{$rating.max}</td>
                    <td>{$rating.min}</td>
                {else}
                    <td>{$rating.rated}</td>
                    <td>{$rating.unrated}</td>
                    <td>{$rating.max}</td>
                    <td>{$rating.min}</td>
                {/if}
            {else}
                <td>{$rating.body|truncate|escape}</td>
                <td><a href="?cmd=tickets&action=view&num={$rating.ticket_number}">#{$rating.ticket_number}</a></td>
                <td>{$rating.date|dateformat:$date_format}</td>
                <td>{if $rating.rdate}{$rating.rdate|dateformat:$date_format}{else}-{/if}</td>
            {/if}
        </tr>
    {foreachelse}
        <tr>
            <td colspan="{if $action !='details'}6{else}5{/if}">
                {$lang.nothingtodisplay}
            </td>
        </tr>
    {/foreach}
{/if}