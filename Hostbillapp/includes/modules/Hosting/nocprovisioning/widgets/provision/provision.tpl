{*
 * NOC-PS Hostbill module
 * Provisioning form template
 *
 * Copyright (C) Maxnet 2010-2012
 *
 * You are free to modify this module to fit your needs
 * However be aware that you need a NOC-PS license to actually provision servers
 *}

{if $status}
{* BEGIN PROVISIONING STATUS *}

<div class="wbox"><div class="wbox_header">配置状态</div><div class="wbox_content">

<p>
您服务器目前正在的配置...请注意, 这可能需要10分钟才能完成...
</p>

<form name="prov" method="post" action="">
  <input type="hidden" name="nps_nonce" value="{$nonce}" />

  <table width="100%" cellspacing="10" cellpadding="10">
          <tr>
            <td width="150" class="fieldarea">MAC地址</td>
            <td>{$mac}</td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">IP地址</td>
            <td>{$ip}</td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">主机名</td>
            <td>{$status.hostname|escape}</td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">安装配置</td>
            <td>{$status.profilename|escape}</td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">最后一个状态信息</td>
            <td id="statusmsg">{$status.statusmsg|escape}</td>
          </tr>

		  <tr>
			<td>&nbsp;
			<td><input type="submit" name="cancelprovisioning" value="取消配置">
		  </tr>
		  
		  <tr>
			<td colspan=2 align="center"><br><br>配置采用NOC-PS</td>
		  </td>
  </table>
</form>
</div></div></div>

{literal}
<script type="text/javascript">
  function pollForStatus(oldeventid)
  {
	$.post(document.location.href, {oldeventid: oldeventid}, function(reply) {
	  
	  var e = document.getElementById("statusmsg");
	  
	  if (reply.statusmsg)
	  {
		e.innerHTML = reply.statusmsg;
		pollForStatus(reply.eventnr);
	  }
	  else
	  {
		e.innerHTML = "<b>完成!</b>";
		document.forms.prov.cancelprovisioning.style.visibility = "hidden";
	  }
	  
	}, 'json');
  }
  
  pollForStatus(0);
</script>
{/literal}

{* END PROVISIONING STATUS *}
{else}

<script type="text/javascript">
{* Function to fill in the 'disklayout', 'package selection' and 'extra' combos depending on profile *}
function onProfileChange()
{ldelim}
  var a = {$addons_json};
  var p = {$profiles_json};
{literal}
  var f = document.forms.prov;
  var pid = f.profile.value;
  var pr = false;
  
  for (var k=0; k<p.length; k++)
  {
	pr = p[k];
	if (pr.id == pid)
	{
	  break;
	}
  }
    
  var t = pr.tags;
  var tags;
  if (t)
  {
	  tags = t.split(' ');
  }
  else
  {
	  tags = [];
  }
  
  var packages    = [['','Standard']];
  var disklayouts = [['','Standard']];
  var extras	  = [['','None']];
  var totalAddons = a.length;
  
  for (var i=0; i <totalAddons; i++)
  {
	  pr = a[i];
	  t  = pr.tag;
	  
	  for (var j=0; j < tags.length; j++)
	  {
		  if (t == tags[j])
		  {
			  var typ   = pr.type;
			  var item  = [t+':'+pr.name, pr.descr];
			  
			  if (typ == 'packages')
			  {
				  packages.push(item);
			  }
			  else if (typ == 'disklayout')
			  {
				  disklayouts.push(item);
			  }
			  else
			  {
				  extras.push(item);
			  }
				  
			  break;
		  }
	  }				
  }
  
  array2options(f.disklayout, disklayouts);
  array2options(f.packageselection, packages);
  array2options(f.extra1, extras);
  array2options(f.extra2, extras);

  f.disklayout.disabled = (disklayouts.length == 1);
  f.packageselection.disabled = (packages.length == 1);
  f.extra1.disabled = (extras.length == 1);
  f.extra2.disabled = (extras.length < 3);
}

function array2options(sel, arr)
{
  var opt = sel.options;
  opt.length = 0;

  for (var i=0; i<arr.length; i++)
  {
	opt[opt.length] = new Option(arr[i][1], arr[i][0]);
  }
}

{/literal}

</script>


<div class="wbox"><div class="wbox_header">{$lang.Provision}</div><div class="wbox_content">

{if !$ip && !$error}
您的订单尚未分配到任意一台服务器!
</div></div></div>
{/if}

{if $errormsg}
<p>
  <b>错误:</b> {$errormsg}
</p>
{/if}

{if $ip}
<form name="prov" method="post" action="" onsubmit="provbutton.disabled=true; return true;">
  <input type="hidden" name="nps_nonce" value="{$nonce}" />

  <table width="100%" cellspacing="10" cellpadding="10">
          <tr>
            <td width="150" class="fieldarea">MAC地址</td>
            <td>{$mac}</td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">IP地址</td>
            <td>{$ip}</td>
          </tr>

{if $ask_ipmi_password}
          <tr>
            <td width="150" class="fieldarea">您服务器的IPMI密码</td>
            <td><input type="password" name="ipmipassword" style="width: 350px;"></td>
          </tr>
{/if}

          <tr>
            <td width="150" class="fieldarea">主机名</td>
            <td><input type="text" name="hostname" style="width: 350px;"></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">安装配置</td>
            <td><select name="profile" style="width: 350px;" onchange="onProfileChange();">
				{foreach item=profile from=$profiles}
			      <option value="{$profile.id}"{if $defaultProfile == $profile.id} selected{/if}>{$profile.name|escape}</option>
				{/foreach}
			</select></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">磁盘部署</td>
            <td><select name="disklayout" style="width: 350px;">
			</select></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">软件包选择</td>
            <td><select name="packageselection" style="width: 350px;">
			</select></td>
          </tr>
		  
          <tr>
            <td width="150" class="fieldarea">额外</td>
            <td>
			  <select name="extra1" style="width: 350px;"></select><br><br>
			  <select name="extra2" style="width: 350px;"></select>
			</td>
          </tr>
		  
          <tr>
            <td width="150" class="fieldarea">Root用户密码</td>
            <td><input type="password" name="rootpassword" style="width: 350px;"></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">重复Root用户密码</td>
            <td><input type="password" name="rootpassword2" style="width: 350px;"></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">一般用户名(可选)</td>
            <td><input type="text" name="adminuser" value="charlie" style="width: 350px;"></td>
          </tr>
		  
          <tr>
            <td width="150" class="fieldarea">用户密码(可选)</td>
            <td><input type="password" name="userpassword" style="width: 350px;"></td>
          </tr>

          <tr>
            <td width="150" class="fieldarea">重复用户密码(可选)</td>
            <td><input type="password" name="userpassword2" style="width: 350px;"></td>
          </tr>
		  
		  <tr>
			<td>&nbsp;
			<td><input type="submit" name="provbutton" value="设置服务器(警告: 覆盖磁盘上的数据)" onclick="return confirm('这将删除磁盘上所有现有的数据, 您是否确定?');">
		  </tr>
  </table>
</form>
</div></div></div>

<script type="text/javascript">
{* Load comboboxes with information of default profile *}
onProfileChange();
</script>
{/if}
{/if}