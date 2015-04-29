<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$vsvrs = dbFetchRows("SELECT * FROM `netscaler_vservers` WHERE `device_id` = ? ORDER BY `vsvr_label`", array($device['device_id']));

#print_r($vsvrs);

if ($vars['submit'] == "update-vsvrs" && $_SESSION['userlevel'] == '10')
{
  foreach ($vsvrs AS $vsvr)
  {
    if ($vars['vsvrs'][$vsvr['vsvr_id']]['vsvr_ignore'] == "on") { $vars['vsvrs'][$vsvr['vsvr_id']]['vsvr_ignore'] = "1"; } else { $vars['vsvrs'][$vsvr['vsvr_id']]['vsvr_ignore'] = "0"; }

    foreach (array('vsvr_ignore','vsvr_limit_low','vsvr_limit') as $field)
    {
      if ($vars['vsvrs'][$vsvr['vsvr_id']][$field]    != $vsvr[$field])    { $sup[$field] = $vars['vsvrs'][$vsvr['vsvr_id']][$field]; }
    }

    if (is_array($sup))
    {
      dbUpdate($sup, 'netscaler_vservers', '`vsvr_id` = ?', array($vsvr['vsvr_id']));
      $did_update = TRUE;
    }
    unset($sup);
  }

  $vsvrs = dbFetchRows("SELECT * FROM `netscaler_vservers` WHERE `device_id` = ? ORDER BY `vsvr_label`", array($device['device_id']));
}

?>

<form id='update-vsvrs' name='update-vsvrs' method='post' action=''>
<fieldset>
  <legend>Netscaler vServer 属性</legend>

<table class="table table-bordered table-striped table-condensed">
  <thead>
    <tr>
      <th width="120">MIB类型</th>
      <th>名称</th>
      <th width="60">状态</th>
      <th width="50">报警</th>
    </tr>
  </thead>
  <tbody>

<?php
$row=1;
foreach ($vsvrs as $vsvr)
{

  echo('<tr>');
  echo('<td>'.htmlentities($vsvr['vsvr_type']).'</td>');
  echo('<td>'.htmlentities($vsvr['vsvr_label']).'</td>');
  echo('<td>'.htmlentities($vsvr['vsvr_state']).'</td>');
  echo('<td>
          <input type=checkbox data-toggle="switch-revert" id="vsvrs['.$vsvr['vsvr_id'].'][vsvr_ignore]" name="vsvrs['.$vsvr['vsvr_id'].'][vsvr_ignore]"'.($vsvr['vsvr_ignore'] ? "checked" : "").'>
        </td>');
  echo('</tr>');
}
?>

</tbody>
</table>
</fieldset>

  <div class="form-actions">
    <button type="submit" class="btn btn-primary" name="submit" value="update-vsvrs"><i class="icon-ok icon-white"></i> 保存变化</button>
  </div>
</form>
<?php

// EOF
