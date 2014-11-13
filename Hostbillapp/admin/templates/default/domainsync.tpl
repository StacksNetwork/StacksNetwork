<div class="blu">
                      <div class="right"><div class="pagination"></div></div>
                	<div class="left menubar">

              <a style="margin-right: 30px;font-weight:bold;"
                 href="#" class="menuitm" onclick="$('#domsyncmgr').toggle();return false"><span class="gear_small">现在同步</span></a>

            </div>
                            <div class="clear"></div>
                            </div>

    <form action="" method="post" id="domsyncform" onsubmit="return dsync()"><div id="domsyncmgr" class="nicerblu" style="{if !$syncdo}display:none;{/if}padding:20px;">
        <table border="0" cellspacing="0" cellpadding="4" >
                <tr>
                    <td width="20"><img src="ajax-loading2.gif" alt="" style="display:none" id="spinner"/></td>
                    <td>
                        Registrar:
                    </td>
                    <td>
                        <select name="registrar" id="domregistrar" class="inp styled todisable">
                            <option value="0">所有</option>
                            {foreach from=$domainmodules item=modx}
                            <option value="{$modx.id}">{$modx.module}</option>
                            {/foreach}
                        </select>
                    </td>
                    <td>
                        域名进行同步:
                    </td>
                    <td>
                        <input name="domaincount" id="domaincount" value="{$totaltosync}" class="inp styled  todisable" size="3" />
                        <input name="domaincount_h" id="domaincount_h" class="ready" value="{$totaltosync}" type="hidden" />
                    </td>
                    <td>
                        Statuses:
                    </td>
                    <td>
                         <select name="status" id="domstatus" class="inp styled  todisable">
                            <option value="All">所有</option>
                            <option value="Active">激活</option>
                            <option value="Expired">到期</option>
                            <option value="Pending Transfer">转移待定</option>
                            <option value="Pending Registration">注册待定</option>
                        </select>
                    </td>
                    <td>
                        <input type="submit" value="{$lang.Synchronize}" class="padded  todisable" style="font-weight:bold" />
                    </td>
                </tr>
            </table>

            <div id="output" style="{if !$syncdo}display:none;{/if}height:300px;overflow:auto;margin:5px 0px;-moz-box-shadow: inset 0 0 2px #888;-webkit-box-shadow: inset 0 0 2px #888;box-shadow: inner 0 0 2px #888;background:#FFF;padding:10px;">
                <div id="outlog" class="fs11">
                    
                </div>
            </div>
    </div></form>
<form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
              <a href="?cmd=domains&action=sync" id="currentlist" style="display:none"  updater="#updater"></a>
              <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                    <tr>
                        <th width="35"><a href="?cmd=domains&action=sync&list={$currentlist}&orderby=id|ASC" class="sortorder">{$lang.idhash}</a></th>
                        <th width="125"><a href="?cmd=domains&action=sync&list={$currentlist}&orderby=date|ASC" class="sortorder">{$lang.Date}</a></th>
                        <th width="250"><a href="?cmd=domains&action=sync&list={$currentlist}&orderby=name|ASC"  class="sortorder">{$lang.Domain}</a></th>
                        <th width="150"><a href="?cmd=domains&action=sync&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th  width="110"><a href="?cmd=domains&action=sync&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.Registrar}</a></th>
                        <th >{$lang.Change}</th>
                    </tr>
                </tbody>
                <tbody id="updater">
                 {include file='ajax.domainsync.tpl'}
                </tbody>
              </table>
              <div class="blu">
			  <div class="right"><div class="pagination"></div></div>
				<div class="left menubar">
             


			  </div>
			  <div class="clear"></div>
              </div>
{securitytoken}</form>

<script type="text/javascript" >
    var syncdo="syncqueue";
     var list="";
     {if $synclist}
     list = "{$synclist}";
     {/if}
{literal}
    function dsync(slist) {
        var a="";
        if(!slist) {
            slist=false;
        }
            if(list!='')
                a="&list="+list;
        
        var x = $('#domaincount_h');
        if(x.hasClass('ready')) {
            $('#output').slideDown();
                $('#spinner').show();
            x.removeClass('ready').val($('#domaincount').val());
            $('.todisable').attr('disabled','disabled');
        }
        var c=parseInt(x.val());

     if(c<=0) {
         x.addClass('ready');
         $('.todisable').removeAttr('disabled');
          $('#spinner').hide();
             //refresh view
                 ajax_update('?cmd=domains&action=sync&list=&orderby=id|DESC',{page:0},'#updater');
         return false;
      }
        c=c-1;
        x.val(c);

        $.getJSON('?cmd=domains&action=sync'+a,{syncdo:syncdo,fulllist:slist,status:$('#domstatus').val(),registrar:$('#domregistrar').val(),totalcount:$('#domaincount').val(),current:c},function(data){
            if(data.text) {
                var r="";
                for(i in data.text) {
                    if(data.text[i].list) {
                        list = data.text[i].list;
                    } 
                     r+="<div class='";
                         if(data.text[i].css)
                             r+=data.text[i].css+" ";
                         if(c%2==0)
                             r+='alternate';
                     r+="'>"+data.text[i].text+"</div>";
                         if(data.text[i].counter) {
                            x.val(data.text[i].counter-1);
                            }
                }
                $('#outlog').append(r);
                $("#output").scrollTop($("#outlog")[0].scrollHeight);
                dsync();
            }

        });
        return false;
    }
{/literal}{if $synclist}
   
        dsync(true);
    {/if}
</script>