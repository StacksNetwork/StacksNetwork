<tr>
    <td ></td>
    <td>
        {literal}
        <style>
            .sectionbody > div{
                padding:3px;
            }
            input[type=text].inp{
                width:250px; height: 17px;
            }
            select.inp{
                width:256px
            }
        </style>
 
        {/literal}
        <div class="left" style="width:330px;">
            <div style="margin:0 5px 5px 0" >
                <div class="sectionhead_ext open" >Account Settings</div>
                <div class="sectionbody" style="padding:10px;">
                    <div>
                        <b class="fs11">Max domains count: <a class="vtip_description" title="Maximum number of domains client can create trough clientarea interface"></a></b><br/>
                        <input type="text"  name="options[maxdomain]" value="{$default.maxdomain}" class="inp" style="width:250px;"/>
                    </div>
                </div>
            </div>

            <div style="margin:0 5px 5px 0">
                <div class="sectionhead_ext open" >SOA Settings</div>
                <div class="sectionbody" style="padding:10px;">
                    <div>
                        <b class="fs11">SOA Email address</b><br/>
                        <input type="radio"  name="options[soaemailclient]" value="1" {if $default.soaemailclient=='1' || !$default.soaemailclient}checked="checked"{/if} /> Use client email address <br />
                        <input type="radio"  name="options[soaemailclient]" value="0" {if $default.soaemailclient && $default.soaemailclient!='1'}checked="checked"{/if} /> Use email address below:
                        <input type="text"  name="options[soaemaildefault]" value="{$default.soaemaildefault}" class="inp" style="width:250px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA Refresh</b><br/>
                        {*Default: <input type="text"  name="options[soarefreshdefault]" value="{if $default.soarefreshdefault!=''}{$default.soarefreshdefault}{else}{$options.soarefreshdefault.default}{/if}" class="inp" style="width:80px;"/>*}
                        Minimum: <input type="text"  name="options[soarefreshmin]" value="{if $default.soarefreshmin!=''}{$default.soarefreshmin}{else}{$options.soarefreshmin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA Retry</b><br/>
                        {*Default: <input type="text"  name="options[soaretrydefault]" value="{if $default.soaretrydefault!=''}{$default.soaretrydefault}{else}{$options.soaretrydefault.default}{/if}" class="inp" style="width:80px;"/>*}
                        Minimum: <input type="text"  name="options[soaretrymin]" value="{if $default.soaretrymin!=''}{$default.soaretrymin}{else}{$options.soaretrymin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA Expire</b><br/>
                        {*Default: <input type="text"  name="options[soaexpiredefault]" value="{if $default.soaexpiredefault!=''}{$default.soaexpiredefault}{else}{$options.soaexpiredefault.default}{/if}" class="inp" style="width:80px;"/>*}
                        Minimum: <input type="text"  name="options[soaexpiremin]" value="{if $default.soaexpiremin!=''}{$default.soaexpiremin}{else}{$options.soaexpiremin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA TTL</b><br/>
                        {*Default: <input type="text"  name="options[soattldefault]" value="{if $default.soattldefault!=''}{$default.soattldefault}{else}{$options.soattldefault.default}{/if}" class="inp" style="width:80px;"/>*}
                        Minimum: <input type="text"  name="options[soattlmin]" value="{if $default.soattlmin!=''}{$default.soattlmin}{else}{$options.soattlmin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                </div>
            </div>
        </div>
        <div style="width:330px;  margin:0 5px 5px 0" class="left">
            <div class="sectionhead_ext open" >Nameservers</div>
            <div class="sectionbody" style="padding:10px;">
                <div>
                    <b class="fs11">Nameserver 1:</b><br/>
                    <input type="text"  name="options[ns1]" value="{$default.ns1}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 1 IP:</b><br/>
                    <input type="text"  name="options[ip1]" value="{$default.ip1}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 2:</b><br/>
                    <input type="text"  name="options[ns2]" value="{$default.ns2}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 2 IP:</b><br/>
                    <input type="text"  name="options[ip2]" value="{$default.ip2}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 3:</b><br/>
                    <input type="text"  name="options[ns3]" value="{$default.ns3}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 3 IP:</b><br/>
                    <input type="text"  name="options[ip3]" value="{$default.ip3}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 4:</b><br/>
                    <input type="text"  name="options[ns4]" value="{$default.ns4}" class="inp" style="width:250px;"/>
                </div>
                <div>
                    <b class="fs11">Nameserver 4 IP:</b><br/>
                    <input type="text"  name="options[ip4]" value="{$default.ip4}" class="inp" style="width:250px;"/>
                </div>
            </div>
        </div>

    </td>
</tr>