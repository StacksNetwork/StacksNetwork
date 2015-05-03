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
        <script type="text/javascript">
            
            $(function(){
                 $('#use_added_servers .new_control:first').replaceWith($('#use_added_servers_new_control').show());
            });
            var timeout;
            function populateFields(){
                $('#getvaluesloader').html('<center><img src="ajax-loading.gif" /></center>');
                var serverfield = $('#serv_picker input[name^="server"]:checked:first');
                if(serverfield.length < 1){
                    return false;
                }
                var list = [];
                $('.try2load').each(function(i){
                    list[i] = $(this).attr('id');
                });
                $.post('?cmd=services&action=product',{
                    cat_id:$('#category_id').val(),
                    id:$('#product_id').val(),
                    make:'loadoptions',
                    opt:list,
                    server_id:serverfield.val()
                }, function(data){
                    $('#getvaluesloader').html('');
                    if(data !== undefined){
                        for(var x =0; x < list.length; x++){
                            if(data[list[x]] !== undefined && data[list[x]].length > 0){
                                var listx = data[list[x]];
                                var target = $('#'+list[x]);
                                var ht = '<select class="inp" name="'+ target.attr('name')+'">';
                                for(var i = 0; i< listx.length; i++){
                                    ht += '<option value="'+listx[i][0];
                                    if(target.val() == listx[i][0])
                                        ht += '" selected="selected';
                                    ht += '" >'+listx[i][1]+'</option>';
                                }
                                target.replaceWith(ht+'</select>');
                            }
                        }
                    }
                });
            }
            
        </script>
        {/literal}
        <a id="use_added_servers_new_control" style="display:none" class="new_control" onclick="return populateFields()" href="#">
        <span class="dwd">
        <strong>{$lang.getvalsfromserver}</strong>
        </span>
        </a>
        <div style="padding: 5px;">
            <span id="getvaluesloader"></span>
        </div>
        <div class="left" style="width:330px;">
            <div style="margin:0 5px 5px 0" >
                <div class="sectionhead_ext open" >Account Settings</div>
                <div class="sectionbody" style="padding:10px;">
                    <div>
                        <b class="fs11">User Role</b><a class="vtip_description" title="HostBill will create new user for client in onapp using this role."></a><br/>
                        <input type="text"  name="options[user_role]" id="user_role" value="{$default.user_role}" class="inp try2load" style="width:250px;"/>
                        
                    </div>
                    <div>
                        <b class="fs11">User Billing Plan</b><br/>
                        <input type="text"  name="options[billing_plan]" id="billing_plan" value="{$default.billing_plan}" class="inp try2load" style="width:250px;"/>
                    </div>
                    <div>
                        <b class="fs11">User Group</b><br/>
                        <input type="text"  name="options[user_group]" id="user_group" value="{$default.user_group}" class="inp try2load" style="width:250px;"/>
                    </div>
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
                        <input type="radio"  name="options[soaemailclient]" value="off" {if $default.soaemailclient && $default.soaemailclient!='1'}checked="checked"{/if} /> Use email address below:
                        <input type="text"  name="options[soaemaildefault]" value="{$default.soaemaildefault}" class="inp" style="width:250px;"/>
                    </div>
                    {*
                    <div>
                        <b class="fs11">SOA Refresh</b><br/>
                        Default: <input type="text"  name="options[soarefreshdefault]" value="{if $default.soarefreshdefault!=''}{$default.soarefreshdefault}{else}{$options.soarefreshdefault.default}{/if}" class="inp" style="width:80px;"/>
                        Minimum: <input type="text"  name="options[soarefreshmin]" value="{if $default.soarefreshmin!=''}{$default.soarefreshmin}{else}{$options.soarefreshmin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA Retry</b><br/>
                        Default: <input type="text"  name="options[soaretrydefault]" value="{if $default.soaretrydefault!=''}{$default.soaretrydefault}{else}{$options.soaretrydefault.default}{/if}" class="inp" style="width:80px;"/>
                        Minimum: <input type="text"  name="options[soaretrymin]" value="{if $default.soaretrymin!=''}{$default.soaretrymin}{else}{$options.soaretrymin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA Expire</b><br/>
                        Default: <input type="text"  name="options[soaexpiredefault]" value="{if $default.soaexpiredefault!=''}{$default.soaexpiredefault}{else}{$options.soaexpiredefault.default}{/if}" class="inp" style="width:80px;"/>
                        Minimum: <input type="text"  name="options[soaexpiremin]" value="{if $default.soaexpiremin!=''}{$default.soaexpiremin}{else}{$options.soaexpiremin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    <div>
                        <b class="fs11">SOA TTL</b><br/>
                        Default: <input type="text"  name="options[soattldefault]" value="{if $default.soattldefault!=''}{$default.soattldefault}{else}{$options.soattldefault.default}{/if}" class="inp" style="width:80px;"/>
                        Minimum: <input type="text"  name="options[soattlmin]" value="{if $default.soattlmin!=''}{$default.soattlmin}{else}{$options.soattlmin.default}{/if}" class="inp" style="width:80px;"/>
                    </div>
                    *}
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