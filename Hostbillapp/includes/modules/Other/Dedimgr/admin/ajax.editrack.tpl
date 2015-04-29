<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=module&module={$moduleid}&do=rackedit&rack_id={$rack.id}" method="post" id="addcolocation">

            <div class="tabb colo_newrack">
                <h3 style="margin:0px;">更新机架 {$rack.name}</h3>

                <div class="form" style="margin:10px 0px">
                    <label class="nodescr">名称</label>
                    <input name="name" type="text" value="{$rack.name}"/>

                    <label class="nodescr">包房</label>
                    <input name="room" type="text" value="{$rack.room}"/>

                    <label class="nodescr">空间 [U]</label>
                    <input name="units" type="text" size="4" value="{$rack.units}"/>


                    <label class="nodescr">重量(空)[KG]</label>
                    <input name="empty_weight" size="4" value="{$rack.empty_weight}" type="text" />

                    <label class="nodescr">速率[MBps]</label>
                    <input name="networkspeed" size="6" type="text" value="{$rack.networkspeed}" />




                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>更新机架详情</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>