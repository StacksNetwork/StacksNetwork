<table border="0" cellspacing="0" cellpadding="0" width="100%" id="content_tb" {if $currentfilter}class="searchon"{/if}>
  <tr>
    <td ><h3>{$lang.Gatewaylog}</h3></td>
    <td  class="searchbox"><div id="hider2" style="text-align:right">
      
          &nbsp;&nbsp;&nbsp;<a href="?cmd=gtwlog&action=getadvanced" class="fadvanced">{$lang.filterdata}</a> <a href="?cmd=gtwlog&resetfilter=1" {if $currentfilter}style="display:inline"{/if}  class="freseter">{$lang.filterisactive}</a>
        
      </div>
      <div id="hider" style="display:none"></div></td>
  </tr>
  <tr>
    <td class="leftNav"><a href="?cmd=invoices&list=all&showall=true"  class="tstyled">{$lang.Allinvoices}</a>
        <a href="?cmd=invoices&list=paid&showall=true"  class="tstyled">{$lang.Paidinvoices}</a>
        <a href="?cmd=invoices&list=cancelled&showall=true"  class="tstyled">{$lang.Cancelledinvoices}</a>
        <a href="?cmd=invoices&list=unpaid&showall=true"  class="tstyled">{$lang.Unpaidinvoices}</a><br />
 <a href="?cmd=invoices&list=recurring&showall=true"  class="tstyled">{$lang.Recurringinvoices}</a><br />
	<a href="?cmd=estimates"  class="tstyled">{$lang.Estimates}</a><br />
      <a href="?cmd=transactions"  class="tstyled">{$lang.Transactions}</a> <a href="?cmd=gtwlog"  class="tstyled selected">{$lang.Gatewaylog}</a> </td>
    <td  valign="top"  class="bordered"><div id="bodycont">
	{if $logs}
        <form action="" method="post" id="testform" >
		<input type="hidden" value="{$totalpages}" name="totalpages2" id="totalpages"/>
         <div class="blu">
		  <div class="right"><div class="pagination"></div></div>
			<div class="clear"></div>
			</div>

          <a href="?cmd=gtwlog" id="currentlist" style="display:none"></a>
          <table cellspacing="0" cellpadding="3" border="0" width="100%" class="glike">
            <tbody>
              <tr>
                <th><a href="?cmd=gtwlog&orderby=id|ASC" class="sortorder">{$lang.idhash}</a></th>
                <th><a href="?cmd=gtwlog&orderby=date|ASC" class="sortorder">{$lang.Date}</a></th>
                <th><a href="?cmd=gtwlog&orderby=module|ASC" class="sortorder">{$lang.Gateway}</a></th>
                <th>{$lang.Output}</th>
                <th><a href="?cmd=gtwlog&orderby=result|ASC" class="sortorder">{$lang.Result}</a></th>
              </tr>
            </tbody>
            <tbody id="updater">

            {include file='ajax.gtwlog.tpl'}
            </tbody>
<tbody id="psummary">
            <tr>
                <th colspan="5">
                    {$lang.showing} <span id="sorterlow">{$sorterlow}</span> - <span id="sorterhigh">{$sorterhigh}</span> {$lang.of} <span id="sorterrecords">{$sorterrecords}</span>
                </th>
            </tr>
        </tbody>
          </table>
		  <script type="text/javascript">
		  {literal}function showdetails(el) {
		  $(el).hide();
		  $(el).parent().find('textarea').show();
		  return false;
		  }{/literal}
		  </script>
		   <div class="blu">
		  <div class="right"><div class="pagination"></div> </div>
			<div class="clear"></div>
			</div>
        {securitytoken}</form>
		{else}
	<div class="blu">	{$lang.nothingtodisplay}</div>
		{/if}
		</div></td>
  </tr>
</table>
