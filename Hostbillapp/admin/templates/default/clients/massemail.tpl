<div class="lighterblue" id="sendtoall" style="display: none; padding: 10px">
    <input checked="checked" type="radio" name="sendtype" value="all" onclick="specifictypes_show()" /> {$lang.allclients}
    <input type="radio" name="sendtype" value="specific" onclick="specifictypes_show()" /> {$lang.specifiedclients}
    <input type="radio" name="sendtype" value="filters" onclick="specifictypes_show()" /> Use current filters

    <input type="submit" name="sendmail" value="{$lang.Send}" onclick="return send_msg('allclients')" style="font-weight: bold; margin-left: 50px" />
    <input type="submit" value="{$lang.Cancel}" onclick="return sendtoall_show()" />
    <div id="specifictypes" style="display: none;">
        <div class="blu"><span style="width: 80px; float:left; font-weight: bold">{$lang.Service}:</span><select name="services" onchange="getCriterias(this, 'services')">
                <option value="all">{$lang.allservices}</option>
                <option value="select">{$lang.selectservice}</option>
                <option value="none">{$lang.None}</option>
            </select></div>
        <div id="show_services" class="blu" style="display: none;"></div>

        <div class="blu" style="margin-top: 5px !important"><span style="width: 80px; float:left; font-weight: bold">{$lang.Server}:</span><select name="servers" onchange="getCriterias(this, 'servers')">
                <option value="all">{$lang.allservers}</option>
                <option value="select">{$lang.selectserver}</option>
                <option value="none">{$lang.None}</option>
            </select></div>
        <div id="show_servers" class="blu" style="display: none"></div>

        <div class="blu" style="margin-top: 5px !important"><span style="width: 80px; float:left; font-weight: bold">{$lang.Countries}:</span><select name="countries" onchange="getCriterias(this, 'countries')">
                <option value="all">{$lang.allcountries}</option>
                <option value="select">{$lang.selectcountries}</option>
            </select></div>
        <div id="show_countries" class="blu" style="display: none"></div>
    </div>
</div>