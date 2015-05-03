<div class="lighterblue" style="padding:6px;">
    <table border="0" width="100%" cellpadding="5">
        <tr><td colspan="2"> <h3>Client area login</h3>This will enable your clients to login into HostBill client section using your website.
            </td></tr>
        <tr>
            <td width="350" valign="middle">
                <div style="padding:5px;background:#fff;">
                    <form method="post" action="{$system_url}" name="" target="_blank">
                        Email Address <input  value="" name="username"><br />
                        Password <input type="password" name="password"/>
                        <input type="hidden" value="login" name="action"/><br/>
                        <input type="submit"  value="Log In">
                    </form>
                </div>
            </td>
            <td valign="top">
                <textarea style="width:80%"  class="inp" rows="6">
<form method="post" action="{$system_url}" name="">
Email Address <input  value="" name="username"><br />
Password <input type="password" name="password">
<input type="hidden" value="login" name="action">
<input type="submit"  value="Log In">
</form>
                </textarea>
            </td>
        </tr>



{foreach from=$cats item=c}
      <tr><td colspan="2">   <h3>{$c.name}</h3>
            </td></tr>

{if $c.template=='transfer'}

<tr>
            <td width="350" valign="middle"><div style="padding:5px;background:#fff;">
                    <form method="post" action="{$system_url}?cmd=checkdomain" target="_blank">
                        <input type="hidden" value="checkdomain" name="action">
                        <input type="hidden" value="1" name="singlecheck">
                        <input type="hidden" value="1" name="transfer">
       <input type="hidden" value="{$c.id}" name="domain_cat">
                        Domain: <input value=""  name="sld">
                        <select  name="tld">{foreach from=$c.tlds item=tkd}<option value="{$tkd.name}">{$tkd.name}</option>
			{/foreach}</select>
                        <input type="submit"  value="Transfer">
                    </form></div>
            </td>
            <td valign="top">

                <textarea style="width:80%"  class="inp" rows="6">
<form method="post" action="{$system_url}?cmd=checkdomain">
    <input type="hidden" value="checkdomain" name="action">
     <input type="hidden" value="1" name="singlecheck">
      <input type="hidden" value="1" name=transfer">
       <input type="hidden" value="{$c.id}" name="domain_cat">
    Domain: <input value=""  name="sld">
            <select  name="tld">{foreach from=$c.tlds item=tkd}<option value="{$tkd.name}">{$tkd.name}</option>
			{/foreach}</select>
            <input type="submit"  value="Check Availability">
    </form>
                </textarea>
            </td>
        </tr>
{elseif $c.template=='single'}

<tr>
            <td width="350" valign="middle"><div style="padding:5px;background:#fff;">
                    <form method="post" action="{$system_url}?cmd=checkdomain" target="_blank">
                        <input type="hidden" value="checkdomain" name="action">
                        <input type="hidden" value="1" name="singlecheck">
                        <input type="hidden" value="1" name="register">
       <input type="hidden" value="{$c.id}" name="domain_cat">
                        Domain: <input value=""  name="sld">
                        <select  name="tld">{foreach from=$c.tlds item=tkd}<option value="{$tkd.name}">{$tkd.name}</option>
			{/foreach}</select>
                        <input type="submit"  value="Check Availability">
                    </form></div>
            </td>
            <td valign="top">

                <textarea style="width:80%"  class="inp" rows="6">
<form method="post" action="{$system_url}?cmd=checkdomain">
    <input type="hidden" value="checkdomain" name="action">
     <input type="hidden" value="1" name="singlecheck">
      <input type="hidden" value="1" name="register">
       <input type="hidden" value="{$c.id}" name="domain_cat">
    Domain: <input value=""  name="sld">
            <select  name="tld">{foreach from=$c.tlds item=tkd}<option value="{$tkd.name}">{$tkd.name}</option>
			{/foreach}</select>
            <input type="submit"  value="Check Availability">
    </form>
                </textarea>
            </td>
        </tr>
{elseif $c.template=='bulkregister' || $c.template == 'bulkregister_suggest'}
  <tr>
            <td width="350" valign="top"><div style="padding:5px;background:#fff;">
                    <form method="post" action="{$system_url}?cmd=checkdomain">

                        <input type="hidden" value="checkdomain" name="action">
                        <input type="hidden" value="true" name="bulk">
                        <input type="hidden" value="{$c.id}" name="domain_cat">
                        <input type="hidden" value="1" name="register">
                        <table border="0" width="100%">
                            <tr>
                                <td valign="top">Domain: <textarea  name="sld"></textarea>  <input type="submit"  value="Check Availability"/></td>
                                <td valign="top">{foreach from=$c.tlds item=tkd name=floop}<span style="float:left;width:70px"><input type="checkbox" value="{$tkd.name}" name="tld[]"/> {$tkd.name}</span>{/foreach}
                                    <span style="clear:both"></span></td>
                            </tr>
                        </table>


                    </form></div>
            </td>
            <td valign="top">

                <textarea style="width:80%"  class="inp" rows="6">
<form method="post" action="{$system_url}?cmd=checkdomain">

    <input type="hidden" value="checkdomain" name="action">
     <input type="hidden" value="true" name="bulk">
      <input type="hidden" value="1" name="register">
       <input type="hidden" value="{$c.id}" name="domain_cat">
      <table border="0" width="100%">
          <tr>
              <td valign="top">Domain: &lt;textarea  name="sld"&gt;&lt;/textarea&gt;  <input type="submit"  value="Check Availability"/></td>
              <td valign="top">{foreach from=$c.tlds item=tkd name=floop}<span style="float:left;width:70px"><input type="checkbox" value="{$tkd.name}}" name="tld[]"/> {$tkd.name}}</span>{/foreach}<span style="clear:both"></span></td>
          </tr>
      </table>


    </form>
                </textarea>
            </td>
        </tr>
{elseif $c.template=='bulktransfer'}
  <tr>
            <td width="350" valign="top"><div style="padding:5px;background:#fff;">
                    <form method="post" action="{$system_url}?cmd=checkdomain">

                        <input type="hidden" value="checkdomain" name="action">
                        <input type="hidden" value="true" name="bulk">
                        <input type="hidden" value="{$c.id}" name="domain_cat">
                        <input type="hidden" value="1" name="transfer">
                        <table border="0" width="100%">
                            <tr>
                                <td valign="top">Domain: <textarea  name="sld"></textarea>  <input type="submit"  value="Check Availability"/></td>
                                <td valign="top">{foreach from=$c.tlds item=tkd name=floop}<span style="float:left;width:70px"><input type="checkbox" value="{$tkd.name}" name="tld[]"/> {$tkd.name}</span>{/foreach}
                                    <span style="clear:both"></span></td>
                            </tr>
                        </table>


                    </form></div>
            </td>
            <td valign="top">

            <textarea style="width:80%"  class="inp" rows="6">
<form method="post" action="{$system_url}?cmd=checkdomain">
    <input type="hidden" value="checkdomain" name="action">
    <input type="hidden" value="true" name="bulk">
    <input type="hidden" value="1" name="transfer">
    <input type="hidden" value="{$c.id}" name="domain_cat">
    <table border="0" width="100%">
        <tr>
            <td valign="top">Domain: &lt;textarea  name="sld"&gt;&lt;/textarea&gt;  <input type="submit"  value="Check Availability"/></td>
            <td valign="top">{foreach from=$c.tlds item=tkd name=floop}<span style="float:left;width:70px"><input type="checkbox" value="{$tkd.name}}" name="tld[]"/> {$tkd.name}}</span>{/foreach}<span style="clear:both"></span></td>
        </tr>
    </table>
</form>
</textarea>
            </td>
        </tr>

{/if}
{/foreach}


    </table>







</div>