<div id="formcontainer">
    <div id="formloader" style="background:#fff;padding:10px;"> <form action="?cmd=module&module={$moduleid}&do=newcolo" method="post" id="addcolocation">

            <div class="tabb colocation">
                <h3 style="margin:0px;">新建数据中心</h3>

                <div class="form" style="margin:10px 0px">
                    <label class="nodescr">名称</label>
                    <input name="name" type="text" class="w250"/>

                    <label class="nodescr">地址</label>
                    <textarea name="address" class="w250"></textarea>

                    <label class="nodescr">紧急联系人</label>
                    <textarea name="emergency_contact" class="w250"></textarea>

                    <label class="nodescr">电话</label>
                    <input name="phone" type="text"/>

                    <label class="nodescr">单价 / GB</label>
                    <input name="price_per_gb" type="text" size="5" />

                    <label class="nodescr">单价 / IP</label>
                    <input name="price_per_ip" type="text" size="5"  />

                    <label  class="nodescr">单价 / Rank</label>
                    <input name="price_reboot" type="text" size="5"  /><br />

                    <div class="clear"></div>
                </div>

                <div class="clear"></div>
            </div>


        </form></div>

    <div class="dark_shelf dbottom">
        <div class="left spinner"><img src="ajax-loading2.gif"></div>
        <div class="right">
            <span id="savechanges" >
                <span class="bcontainer " ><a class="new_control greenbtn" href="#" onclick="$('#addcolocation').submit(); return false"><span><b>添加新的数据中心</b></span></a></span>
                <span >{$lang.Or}</span>
            </span>
            <span class="bcontainer"><a href="#" class="submiter menuitm" onclick="$(document).trigger('close.facebox');return false;"><span>{$lang.Close}</span></a></span>
        </div>
        <div class="clear"></div>
    </div>

</div>