<div class="newhorizontalnav clear">
    <div class="list-2">
        <div class="haveitems">
            <ul>
                <li {if !$do || $do=='generate'}class="picked"{/if}><a href="?cmd=hbchat&action=widgets">Create new widget</a></li>
                <li {if $do=='images'}class="picked"{/if}><a  href="?cmd=hbchat&action=widgets&do=images">Chat images</a></li>
            </ul>
        </div>
    </div>
</div>
<div  class="nicerblu">
    {if !$do}



    <div style="padding:15px">
        Website widget is html code that you can put on your website to allow visitor tracking and/or chat request icon, with current chat status.<br/>
    </div>
    <div class="gallery">
        <div><div class="gal_itm">
<img class="thumb" src="templates/default/hbchat/widgets/footprint.png"><a  href="?cmd=hbchat&action=widgets&do=generate&tag=code" class="edit">Generate</a>			</div>
            <h1 class="hh1">Visitor monitoring</h1> This widget does not show "chat now" icon anywhere on website, it allows to track visits on your website, and invite  visitors to chat with nice invitation image set in Widgets->Chat Images
        </div><div class="clear"></div> </div>Generate


           <div class="gallery"><div><div class="gal_itm">
<img class="thumb" src="templates/default/hbchat/widgets/clickhere.png"><a  href="?cmd=hbchat&action=widgets&do=generate&tag=link" class="edit">Generate</a>			</div>
            <h1 class="hh1">"Click here to chat"</h1> This widget generates text link, that once clicked opens new chat window. It also allows to track website visitors and engage them to live chat.
        </div><div class="clear"></div> </div>

          <div class="gallery"> <div><div class="gal_itm">
<img class="thumb" src="templates/default/hbchat/widgets/image.png"><a  href="?cmd=hbchat&action=widgets&do=generate&tag=image" class="edit">Generate</a>			</div>
            <h1 class="hh1">Chat icon</h1> Generate chat offline/online graphical icon to embed on website. You can use different image sets on different websites/parts of your website. It also allows to track website visitors and engage them to live chat.
        </div><div class="clear"></div> </div>

           <div class="gallery"><div><div class="gal_itm">
<img class="thumb" src="templates/default/hbchat/widgets/sidetag.png"><a  href="?cmd=hbchat&action=widgets&do=generate&tag=sidebar" class="edit">Generate</a>			</div>
            <h1 class="hh1">Floating sidebar</h1> Generate popular website floating sidebar tag, that once clicked opens live chat window. It also allows to track website visitors and engage them to live chat.
        </div><div class="clear"></div> </div>
    
    <br/><br/>
    {elseif $do=='images'}
    <div style="padding:15px">
        Images located here can be used as invitation to chat, or as chat status button with website widgets
    </div>
    {if $images}

    <ul style="border:solid 1px #ddd;border-bottom:none;" id="grab-sorter"> {foreach from=$images item=i}
        <li style="background:#ffffff"><div style="border-bottom:solid 1px #ddd;">
                <table cellspacing="0" cellpadding="5" border="0" width="100%">
                    <tbody><tr>
                            <td width="60" valign="top"><div style="padding:10px 0px;"><input type="hidden" class="ser" value="464" name="sortc[]"><a name="f464"></a>
                                    <!--
                                    --><a style="width:14px;"  title="Edit" class="menuitm menuf" href="?cmd=hbchat&action=widgets&do=editimage&id={$i.id}"><span class="editsth"></span></a><!--
                                    --><a onclick="return confirm('Are you sure you wish to remove this image(s)?')" title="delete" class="menuitm menul" href="?cmd=hbchat&action=widgets&do=images&make=delete&id={$i.id}&security_token={$security_token}"><span class="delsth"></span></a>
                                </div></td>
                            <td valign="top">
                                <b> {$i.name}</b>
                            </td>
                            <td width="450" valign="top" style="background:#F0F0F3;color:#767679;font-size:11px">
                                Type: {if $i.type=='invitation'} <strong>Invitation</strong><br>
                                <img src="{$i.url_on}" alt=""/>
                                {else} <strong>Chat status</strong><br />
                                <img src="{$i.url_on}" alt="" /> <br/>
                                <img src="{$i.url_off}" alt="" />
                                {/if}</td>

                        </tr>
                    </tbody></table></div></li>{/foreach}
    </ul>
    {else}
    No images has been added yet
    {/if}

    <div style="padding:10px 4px">
        <a id="addnew_conf_btn" class="new_control" href="?cmd=hbchat&action=widgets&do=addimage"><span class="addsth"><strong>Add new chat image</strong></span></a>
    </div>
    {elseif $do=='addimage' || $do=='editimage'}
    {literal}
    <script type="text/javascript">
        function chel(el) {
            if($(el).val()=='invitation') {
                $('.invitationrow').show();
                $('.statusrow').hide();
            } else {
                $('.invitationrow').hide();
                $('.statusrow').show();

            }
        }
    </script>
    {/literal}
    <form method="post" enctype="multipart/form-data" action="">
        <input type="hidden" name="make" value="{$do}"/>
        <table cellspacing="0" cellpadding="6" width="100%" class="editor-container">
            <tbody class="sectioncontent">
                 <tr class="odd">
                    <td align="right" width="180"><strong>Image name</strong></td>
                    <td>
                        <input class="inp" name="name" value="{$image.name}" size="40"/>
                    </td>
                </tr>
                <tr>
                    <td align="right" width="180"><strong>Image folder</strong></td>
                    <td>
                        <input class="inp" name="location" value="{$image.location}" size="40"/>
                    </td>
                </tr>
                <tr class="odd" >
                    <td align="right" width="180"><strong>Image type</strong></td>
                    <td >
                        {if $do=='editimage'}
                        {if $image.type=='invitation'}Chat invitation image{else}Chat status image{/if}
                        <input type="hidden" name="type" value="{$image.type}" />
                        {else}
                        <select class="inp" name="type" onchange="chel(this)">
                            <option value="invitation">Chat invitation image</option>
                            <option value="status">Chat status image</option>
                        </select>
                        {/if}
                    </td>
                </tr>

                <tr class="invitationrow" {if $image.type=='status'}style="display:none"{/if}>
                    <td align="right" width="180"><strong>Invitation image</strong></td>
                    <td >

                       {if $do=='editimage'}
                       Current image:<br/>
                       <img src="{$image.url_on}" alt="" />

                       <br/><br/>Upload new image:<br/>{/if}
                       <input type="file" name="invitation_new" />
                    </td>
                </tr>
                 <tr class="statusrow" {if !$image.type || $image.type=='invitation'}style="display:none"{/if}>
                    <td align="right" width="180"><strong>Status Offline</strong></td>
                    <td >

                       {if $do=='editimage'}
                       Current image:<br/>
                       <img src="{$image.url_off}" alt="" />

                       <br/><br/>Upload new image:<br/>{/if}
                       <input type="file" name="status_new_off" />
                    </td>
                </tr>
                <tr class="statusrow odd" {if !$image.type || $image.type=='invitation'}style="display:none"{/if}>
                    <td align="right" width="180"><strong>Status Online</strong></td>
                    <td >

                       {if $do=='editimage'}
                       Current image:<br/>
                       <img src="{$image.url_on}" alt="" />

                       <br/><br/>Upload new image:<br/>{/if}
                       <input type="file" name="status_new_on" />
                    </td>
                </tr><tr>
                    <td></td>
                    <td> </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" class="submitme" value="Submit" style="font-weight:bold"/></td>
                </tr>
            </tbody>
        </table>
        {securitytoken}
    </form>
    {elseif $do=='generate'}
    {if $code}

    <div style="padding:15px">
        <table border="0" cellspacing="0" cellpadding="6" width="100%">
            <tr>
                <td width="50%">
                    <div style="padding:0px 0px 5px;">
                        <b>Place this code in your website HTML source</b>
                    </div>
                    <textarea style="width:99%;height:150px;font-size:12px;">{$code}</textarea></td>
                <td valign="top">
                    {if $showpreview}<div style="padding:0px 0px 5px;">
                        <b>Preview:</b>
                    </div><br>{/if}
                    {$code}</td>
            </tr>
        </table>

    </div>
    {else}
    {literal}
    <script type="text/javascript">
        function cInvitation(el) {
            $('#invitationcontainer img').hide();
            var id = $(el).val();
            $('#invitationcontainer img#inv_'+id).show();
        }
        function cStatus(el) {
            $('#statuscontainer img').hide();
            var id = $(el).val();
            $('#statuscontainer img#stat_'+id).show();
            
        }
    </script>
    {/literal}
    <form action="" method="post" >
        <input type="hidden" name="make" value="generate" />
        <table cellspacing="0" cellpadding="6" >
            <tbody class="sectioncontent">
                 <tr>
                    <td align="right" width="180"><strong>Links protocol <a class="vtip_description " title="Use https only if you have valid certificate installed on server with HostBill"></a></strong></td>
                    <td class="editor-container" colspan="2">
                        <select class="inp" name="protocol">
                            <option value="http://">http://</option>
                            <option value="https://">https://</option>
                        </select>
                    </td>
                </tr>
                {if $tag!='code' && $tag!='link'}
                <tr>
                    <td align="right" width="180"><strong>Invitation image <a class="vtip_description " title="Once operator invite user to chat, this image will show."></a></strong></td>
                    <td class="editor-container">
                        <select class="inp" name="invite_image_id" onchange="cInvitation(this);">
                            {foreach from=$images item=i}
                            <option value="{$i.id}">{$i.name}</option>
                            {/foreach}

                        </select>
                    </td>
                     <td id="invitationcontainer">
                        Preview:<br/>
                        {foreach from=$images item=i name=floop}
                        <img src="{$i.url_on}" alt="" {if !$smarty.foreach.floop.first}style="display:none"{/if} id="inv_{$i.id}" width="50%" />
                        {/foreach}
                    </td>
                </tr>
                <tr>
                    <td align="right" width="180"><strong>Status images <a class="vtip_description " title="This status images set will be displayed on website in place where code will be embeded."></a></strong></td>
                    <td class="editor-container">
                        <select class="inp" name="status_images_id" onchange="cStatus(this);">
                            {foreach from=$images_status item=i}
                            <option value="{$i.id}">{$i.name}</option>
                            {/foreach}

                        </select>
                    </td>
                     <td id="statuscontainer">
                        Preview:<br/>
                        {foreach from=$images_status item=i name=floop}
                        <img src="{$i.url_on}" alt="" {if !$smarty.foreach.floop.first}style="display:none"{/if} id="stat_{$i.id}"  />
                        {/foreach}
                    </td>
                </tr>
                {/if}
                {if $tag=='code' || $tag=='link'}
                <tr>
                    <td align="right" width="180"><strong>Invitation image <a class="vtip_description " title="Once operator invite user to chat, this image will show."></a></strong></td>
                    <td class="editor-container">
                        <select class="inp" name="invite_image_id" onchange="cInvitation(this);">
                            {foreach from=$images item=i}
                            <option value="{$i.id}">{$i.name}</option>
                            {/foreach}

                        </select>
                    </td>
                    <td id="invitationcontainer">
                        Preview:<br/>
                        {foreach from=$images item=i name=floop}
                        <img src="{$i.url_on}" alt="" {if !$smarty.foreach.floop.first}style="display:none"{/if} id="inv_{$i.id}" width="50%" />
                        {/foreach}
                    </td>
                </tr>
                {/if}
                {if $tag=='link'}
                
                <tr>
                    <td align="right" width="180"><strong>Link text</strong></td>
                    <td class="editor-container" colspan="2">
                        <input class="inp" name="link_content" value="Click here to chat"/>
                    </td>
                </tr>
                {/if}
                <tr><td colspan="3"></td></tr>
                <tr><td></td><td><input type="submit" style="font-weight: bold" value="Generate" class="submitme"/></td><td></td></tr>
            </tbody>
        </table>

        {securitytoken}
    </form>

    {/if}

    {/if}
</div>