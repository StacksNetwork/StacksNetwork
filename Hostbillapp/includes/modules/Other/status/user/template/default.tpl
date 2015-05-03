<link media="all" rel="stylesheet" href="{$moduleurl}css/jCal.css" />
<script type="text/javascript" src="{$moduleurl}js/jCal-light.js" ></script>
<link media="all" rel="stylesheet" href="{$moduleurl}css/styles.css" />
{literal}
    <script type="text/javascript">
        $(function() {
            var events = {/literal}{$calendar}{literal},
                selected = null,
                cdate = new Date();
                dateformat = "{/literal}{$date_format}{literal}";
            $('#status_calendar div').jCal({
                day: new Date(cdate.getFullYear(), cdate.getMonth()-1, cdate.getDate()),
                days: 1,
                showMonths: 3,
                dayOffset: 1,
                dow: [{/literal}'{$lang.mon}', '{$lang.tue}', '{$lang.wed}', '{$lang.thu}', '{$lang.fri}', '{$lang.sat}', '{$lang.sun}'{literal}],
                ml: [{/literal}'{$lang.January}', '{$lang.February}', '{$lang.March}', '{$lang.April}', '{$lang.May}', '{$lang.June}', '{$lang.July}', '{$lang.August}', '{$lang.September}', '{$lang.October}', '{$lang.November}', '{$lang.December}'{literal}],
                callback: function(day, days) {
                    if (selected == day.getTime()) {
                        ajax_update("?cmd=status", {}, "#status_list");
                        selected = 0;
                        $(this).removeClass('selectedDay');
                        $('#view_all').hide();
                    } else {
                        ajax_update("?cmd=status&action=dayevents", {day: day.getFullYear() + '-' + (day.getMonth()+1) + '-' + day.getDate()}, "#status_list");
                        selected = day.getTime();
                        var date = dateformat,
                            dday = day.getDate(),
                            dmonth = day.getMonth()+1,
                            dyear = day.getFullYear();
                        
                        $('#view_all').children('#from_date').text(date
                                .replace(/d+/g, dday.length < 8 ? '0'+dday : dday)
                                .replace(/m+/g, dmonth.length < 2 ? '0'+dmonth : dmonth)
                                .replace(/Y+/g, dyear)).end().show();
                    }
                },
                postInsert: function(date) {
                    var that = $(this),
                            month = date.getMonth()+1,
                            day = date.getDate();
                    that.height(that.width() * 1.00).css("line-height", that.width() + "px");
                    if (events != undefined && events[month] != undefined && events[month][day] != undefined) {
                        that.addClass('hasEvent');
                    }
                    return true;
                }
            });
        });

    </script>
{/literal}
<div class="padding white-bg">
    
    <div id="status_calendar">
        <div id="jCalTarget" class="clearfix row-fluid"></div>
    </div>
    {if $logged == '1'}
    <p>
    {$lang.currentstatusnotificationssubscript}: <strong> {if $subscribed}{$lang.suscribed|capitalize}{else}{$lang.unsuscribed|capitalize}{/if}</strong> 
        <br />
        <small>
            {if $subscribed}{$lang.youwillbenotified} 
                <a href="{$ca_url}status/unsubscribe/&security_token={$security_token}" onclick="return confirm('{$lang.areshurewantunsuscribe}')">{$lang.unsubscribe}</a>
            {else}{$lang.youwillnotreceive}
                        <a href="{$ca_url}status/subscribe/&security_token={$security_token}">{$lang.suscribenow}</a>
            {/if}
        </small>
    </p>
    {/if}
    <p id="view_all" style="display: none;">
        {$lang.thefollowingmaintenanceeventsschedu} <span id="from_date">08.08.2013l</span>. <a href="{$ca_url}status" >{$lang.viewall}</a>
    </p>
    <div id="status_list">
        {include file="ajax.default.tpl"}
    </div>
</div>

