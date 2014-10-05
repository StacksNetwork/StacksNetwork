<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.Orders}</h3></td>
    <td  class="searchbox"><div id="hider2" style="text-align:right">
        <a href="?cmd=orders&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=orders&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        
      </div>
      <div id="hider" style="display:none"></div></td>
  </tr>
  <tr>
  
  <td class="leftNav">
  <a href="?cmd=orders&list=all"  class="tstyled {if $action == 'default' && ($currentlist=='all' || !$currentlist)}selected{/if}">{$lang.allorders} <span>({$stats.All})</span></a>
  <a href="?cmd=orders&list=active" class="tstyled {if $action == 'default' && $currentlist=='active'}selected{/if}">{$lang.activeorders} <span>({$stats.Active})</span></a>
  <a href="?cmd=orders&list=cancelled" class="tstyled {if $action == 'default' && $currentlist=='cancelled'}selected{/if}">{$lang.cancelledorders} <span>({$stats.Cancelled})</span></a>
  <a href="?cmd=orders&list=pending" class="tstyled {if $action == 'default' && $currentlist=='pending'}selected{/if}">{$lang.pendingorders} <span>({$stats.Pending})</span></a>
  <a href="?cmd=orders&list=fraud" class="tstyled {if $action == 'default' && $currentlist=='fraud'}selected{/if}">{$lang.fraudorders} <span>({$stats.Fraud})</span></a>
  <a href="?cmd=orders&action=draft" class="tstyled {if $action=='draft' || $action== 'createdraft'}selected{/if}">{$lang.Draft} <span>({$stats.Draft})</span></a>
  <td  valign="top"  class="bordered">
  <div id="bodycont"> 
  
  
  {if $action=='edit' && $details}
   
   {include file='orders/edit.tpl'}
   
    {elseif $action=='add'}
        {include file='orders/add.tpl'}
    {elseif $action=='createdraft'}
   {include file='orders/add.tpl'}

    {elseif $action=="draft"}
        <form action="" method="post" id="testform" >
            <input type="hidden" value="{$totalpages}" name="totalpages" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    <a  class="menuitm" href="?cmd=orders&action=createdraft" style="margin-right: 30px;font-weight:bold;"><span class="addsth">{$lang.createorder}</span></a>
                    {$lang.withselected}
                    <a class="submiter menuitm menuf" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.generatefromdrafts}</span></a>{*              
                    *}<a class="submiter menuitm confirm menul" name="delete" ><span style="color:red">{$lang.Delete}</span></a>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=orders&action={$action}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        <th><a href="?cmd=orders&action=draft&orderby=id|ASC" class="sortorder">ID</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                        <th><a href="?cmd=orders&action=draft&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        <th width="20"></th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file='ajax.orders.tpl'}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="9">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        </th>
                    </tr>
                </tbody>
            </table>
        </form>
        <div class="blu">
            <div class="right"><div class="pagination"></div></div>
            <div class="left menubar">
                {$lang.withselected}                    
                <a class="submiter menuitm menuf" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.generatefromdrafts}</span></a>{*              
                *}<a class="submiter menuitm confirm menul" name="delete" href="#"  ><span style="color:red">{$lang.Delete}</span></a>
            </div>
            <div class="clear"></div> 
        </div> 
    {else}
        <form action="" method="post" id="testform" ><input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    <a  class="menuitm" href="?cmd=orders&action=add"    style="margin-right: 30px;font-weight:bold;"><span class="addsth">{$lang.createorder}</span></a>
                    {$lang.withselected}
                    <a class="submiter menuitm menuf" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.Accept}</span></a>{*
                    *}<a class="submiter menuitm menuc" name="markpending" {if $enablequeue}queue='push'{/if} href="#" ><span >{$lang.setpending}</span></a>{*
                    *}<a {if $enablequeue}queue='push'{/if}  class="submiter menuitm menul" name="markcancelled"  href="#" ><span >{$lang.Cancel}</span></a>
                    
                    {if !$forbidAccess.deleteOrders}<a class="menuitm menuf" name="delete" href="#"  onclick="confirm1(); return false;" ><span style="color:red">{$lang.Delete}</span></a>{/if}{*
                    *}<a class="menuitm setStatus menu{if !$forbidAccess.deleteOrders}l{/if}" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                </div>
                <div class="clear"></div>
            </div>
            <a href="?cmd=orders&list={$currentlist}" id="currentlist" style="display:none" updater="#updater"></a>
            <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike hover">
                <tbody>
                    <tr>
                        <th width="20"><input type="checkbox" id="checkall"/></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=id|ASC" class="sortorder">ID</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=number|ASC" class="sortorder">{$lang.orderhash}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=lastname|ASC"  class="sortorder">{$lang.clientname}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=date_created|ASC"  class="sortorder">{$lang.Date}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=total|ASC"  class="sortorder">{$lang.Total}</a></th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=module|ASC"  class="sortorder">{$lang.paymethod}</a></th>
                        <th>{$lang.paymentstatus}</th>
                        <th><a href="?cmd=orders&list={$currentlist}&orderby=status|ASC"  class="sortorder">{$lang.Status}</a></th>
                        <th width="20"></th>
                    </tr>
                </tbody>
                <tbody id="updater">
                    {include file='ajax.orders.tpl'}
                </tbody>
                <tbody id="psummary">
                    <tr>
                        <th></th>
                        <th colspan="9">
                            {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                        
                        </th>
                    </tr>
                </tbody>
            </table>
            <div class="blu">
                <div class="right"><div class="pagination"></div></div>
                <div class="left menubar">
                    {$lang.withselected}
                                
                    <a class="submiter menuitm menuf" name="markaccepted" {if $enablequeue}queue='push'{/if}  href="#" ><span >{$lang.Accept}</span></a>{*
                    *}<a class="submiter menuitm menuc" name="markpending" {if $enablequeue}queue='push'{/if} href="#" ><span >{$lang.setpending}</span></a>{*
                    *}<a {if $enablequeue}queue='push'{/if}  class="submiter menuitm menul" name="markcancelled"  href="#" ><span >{$lang.Cancel}</span></a>
                    
                    {if !$forbidAccess.deleteOrders}<a class="menuitm menuf" name="delete" href="#"  onclick="confirm1(); return false;" ><span style="color:red">{$lang.Delete}</span></a>{/if}{*
                    *}<a class="menuitm setStatus menu{if !$forbidAccess.deleteOrders}l{/if}" id="hd1" onclick="return false;"   href="#" ><span class="morbtn">{$lang.moreactions}</span></a>
                    <input type="submit"   class="submiter" name="markfraud" value="{$lang.setasfraud}" {if $enablequeue}queue='push'{/if} style="display:none" id="markasfraud1"/>
                    <ul id="hd1_m" class="ddmenu">
                        <li ><a href="#" onclick="return send_msg('orders')">{$lang.SendMessage}</a></li>
                        <li  ><a href="MarkFraud" onclick="$('#markasfraud1').click();">{$lang.setasfraud}</a></li>
                    </ul>
                                
                </div>
                <div class="clear"></div>
                {securitytoken}
        </form>
        <div id="confirm_ord_delete" style="display:none" class="confirm_container">
        
            <div class="confirm_box">
                <h3>{$lang.orddelheading}</h3>
                {$lang.orddeldescr}<br />
                <br />
    
    
                <input type="radio" checked="checked" name="cc_" value="1" id="cc_hard"/> {$lang.deleteopt1}<br />
                <input type="radio"  name="cc_" value="0" id="cc_soft"/> {$lang.deleteopt2}<br />
            
            
                <br />
                <center><input type="submit" value="{$lang.Apply}" style="font-weight:bold"  onclick="confirmsubmit2(); return false;"/>&nbsp;<input type="submit" value="{$lang.Cancel}" onclick="cancelsubmit2(); return false;"/></center>
            
            </div>
            <script type="text/javascript">
{literal}
function confirm1() {
if ( $("#testform input[class=check]:checked").length<1) 
	return false;
 $('#bodycont').css('position','relative');
             $('#confirm_ord_delete').width($('#bodycont').width()).height($('#bodycont').height()).show();
			 return false;
}
function confirmsubmit2() {	
var add='';
if($('#cc_hard').is(':checked'))
	add='&harddelete=true';
	
	ajax_update('?cmd=orders&delete=delete&'+$.param($("#testform input[class=check]:checked"))+add,{stack:'push'});
	cancelsubmit2(); return false;
}
function cancelsubmit2() {
	$('#confirm_ord_delete').hide().parent().css('position','inherit');
}
  $('.setStatus').dropdownMenu({},function(action,el,pos,valx){});
{/literal}
</script>
    {/if}</div>
  </td>
  </tr>
</table>
