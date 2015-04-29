<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=module&module={$moduleid}&do=flooredit&floor_id={$floor.id}" method="post" id="addcolocation">

            <div class="tabb colo_floor">
                <h3 style="margin:0px;">编辑数据中心楼层</h3>

                <div class="form" style="margin:10px 0px">


                    <label class="nodescr">标签</label>
                    <input name="name" type="text" class="w250" value="{$floor.name}"/>
                    <label class="nodescr">楼层数</label>
                    <input name="floor" type="text" class="w250" size="10"  value="{$floor.floor}"/><br />



                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>保存楼层</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>