<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=module&module={$moduleid}&do=vendors&make=addvendor" method="post" id="addcolocation">

            <div class="tabb colo_floor">
                <h3 style="margin:0px;">新建供应商:</h3>

                <div class="form" style="margin:10px 0px">


                    <label class="nodescr">名称</label>
                    <input name="name" type="text" class="w250" value="{$vendor.name}"/>
                    <label class="nodescr">注释</label>
                    <textarea name="comments" class="w250">{$vendor.comments}</textarea>



                </div>

                <div class="clear"></div>
            </div>

            {securitytoken}
        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>添加供应商</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>