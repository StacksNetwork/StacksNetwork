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

$pagetitle[] = '端口';

// Set Defaults here

if(!isset($vars['format'])) { $vars['format'] = 'list'; }

if($vars['searchbar'] != 'hide')
{

echo('<div class="well" style="padding: 10px;">');

?>
<form method="post" action="" class="form form-inline" style="margin-bottom: 0;" id="ports-form">
  <div class="row">
    <div class="col-lg-2">
      <select name="device_id" id="device_id" class="selectpicker">
        <option value="">所有设备</option>
<?php

foreach (dbFetchRows('SELECT `device_id`, `hostname` FROM `devices` GROUP BY `hostname` ORDER BY `hostname`') as $data)
{
  if (device_permitted($data['device_id']))
  {
    echo('        <option value="'.$data['device_id'].'"');
    if ($data['device_id'] == $vars['device_id']) { echo('selected'); }
    echo('>'.$data['hostname'].'</option>');
  }
}
?>
      </select>
    </div>
    <div class="col-lg-2">
        <input placeholder="端口名称" title="端口名称" type="text" name="ifDescr" id="ifDescr" <?php if (strlen($vars['ifDescr'])) {echo('value="'.$vars['ifDescr'].'"');} ?> />
    </div>

    <div class="col-lg-2">
      <select name="state" id="state" class="selectpicker">
        <option value="">所有状态</option>
        <option value="up" <?php if ($vars['state'] == "up") { echo("selected"); } ?>>正常</option>
        <option value="down"<?php if ($vars['state'] == "down") { echo("selected"); } ?>>停止</option>
        <option value="admindown" <?php if ($vars['state'] == "admindown") { echo("selected"); } ?>>关闭</option>
      </select>
    </div>
    <div class="col-lg-2">
      <select name="ifType" id="ifType" class="selectpicker">
        <option value="">所有介质</option>
<?php
foreach (dbFetchRows("SELECT `ifType` FROM `ports` GROUP BY `ifType` ORDER BY `ifType`") as $data)
{
  if ($data['ifType'])
  {
    echo('        <option value="'.$data['ifType'].'"');
    if ($data['ifType'] == $vars['ifType']) { echo("selected"); }
    echo(">".$data['ifType']."</option>");
  }
}
?>
       </select>
    </div>
    <div class="col-lg-2">
<?php
/**
      <td width=80 rowspan=2>
        <label for="ignore">
        <input type=checkbox id="ignore" name="ignore" value=1 <?php if ($vars['ignore']) { echo("checked"); } ?> ></input> 忽略
        </label>
        <label for="disable">
        <input type=checkbox id="disable" name="disable" value=1 <?php if ($vars['disable']) { echo("checked"); } ?> > 禁用</input>
        </label>
        <label for="deleted">
        <input type=checkbox id="deleted" name="deleted" value=1 <?php if ($vars['deleted']) { echo("checked"); } ?> > 删除</input>
        </label>
        </td>
**/
?>
    </div>
    <div class="col-lg-2 pull-right">
        <select name="sort" id="sort" class="selectpicker pull-right" title="排列方式" style="width: 150px;" data-width="150px">
<?php
$sorts = array('device' => '设备',
              'port' => '端口',
              'speed' => '速度',
              'traffic' => '进出流量',
              'traffic_in' => '进向流量',
              'traffic_out' => '出向流量',
              'traffic_perc' => '进出流量比例',
              'traffic_perc_in' => '进向流量比例',
              'traffic_perc_out' => '出向流量比例',
              'packets' => '进出数据包',
              'packets_in' => '进向数据包',
              'packets_out' => '出向数据包',
              'errors' => '错误',
              'media' => '介质',
              'descr' => '说明');

foreach ($sorts as $sort => $sort_text)
{

  if (!isset($vars['sort'])) { $vars['sort'] = $sort; }
  echo('<option value="'.$sort.'"');
  if ($vars['sort'] == $sort)  { echo( 'selected'); }
  if ($vars['sort'] == $sort)  { echo(' data-icon="oicon-sort-alphabet-column"'); }
  echo('>'.$sort_text.'</option>');
}
?>

        </select>
    </div>

  </div>
  <div class="row" style="margin-top: 10px;">
    <div class="col-lg-2">
      <input placeholder="主机名" type="text" name="hostname" id="hostname" title="主机名" <?php if (strlen($vars['hostname'])) {echo('value="'.$vars['hostname'].'"');} ?> />
    </div>
    <div class="col-lg-2">
        <input placeholder="端口说明" title="Port Description" type="text" name="ifAlias" id="ifAlias" <?php if (strlen($vars['ifAlias'])) {echo('value="'.$vars['ifAlias'].'"');} ?> />
    </div>
    <div class="col-lg-2">
      <select name="ifSpeed" id="ifSpeed" class="selectpicker">
      <option value="">所有速度</option>
<?php

foreach (dbFetchRows("SELECT `ifSpeed` FROM `ports` GROUP BY `ifSpeed` ORDER BY `ifSpeed`") as $data)
{
  if ($data['ifSpeed'])
  {
    echo("<option value='".$data['ifSpeed']."'");
    if ($data['ifSpeed'] == $vars['ifSpeed']) { echo("selected"); }
    echo(">".humanspeed($data['ifSpeed'])."</option>");
  }
}
?>
       </select>
    </div>
    <div class="col-lg-2">
      <select name="port_descr_type" id="port_descr_type" class="selectpicker">
        <option value="">所有端口类型</option>
<?php
$ports = dbFetchRows("SELECT `port_descr_type` FROM `ports` GROUP BY `port_descr_type` ORDER BY `port_descr_type`");
$total = count($ports);
echo("Total: $total");
foreach ($ports as $data)
{
  if ($data['port_descr_type'])
  {
    echo('        <option value="'.$data['port_descr_type'].'"');
    if ($data['port_descr_type'] == $vars['port_descr_type']) { echo("selected"); }
    echo(">".ucfirst($data['port_descr_type'])."</option>");
  }
}
?>
         </select>
    </div>
    <div class="col-lg-2">
        <select name="location" id="location" class="selectpicker">
          <option value="">所有物理位置</option>
          <?php
           // fix me function?

          foreach (get_locations() as $location)
          {
            $value = base64_encode(json_encode(array($location)));
            $name  = ($location == '' ? '[[未知]]' : htmlspecialchars($location));
            echo('<option value="'.$value.'"');
            if (array($location) === $vars['location']) { echo(" selected"); }
            echo(">" . $name . "</option>");
          }
         ?>
        </select>
    </div>
    <div class="col-lg-2 pull-right">
        <button type="submit" onClick="submitURL()" class="btn pull-right"><i class="icon-search"></i> 搜索</button>
    </div>
  </div>
</form>

<script>

// This code updates the FORM URL

function submitURL() {
  var url = '/ports/';

    var partFields = document.getElementById("ports-form").elements;

    for(var el, i = 0, n = partFields.length; i < n; i++) {
      el = partFields[i];
      if (el.value != '') {
        if (el.checked || el.type !== "checkbox") {
            url += encodeURIComponent(el.name) + "=" +
                   encodeURIComponent(el.value) + "/"
            ;
        }
      }
    }

   $('#ports-form').attr('action', url);

}

</script>

</div>

<?php }

$navbar = array('brand' => "端口", 'class' => "navbar-narrow");

$navbar['options']['basic']['text']   = '基础';
// There is no detailed view for this yet.
//$navbar['options']['detail']['text']  = '详情';

$navbar['options']['graphs']     = array('text' => '流量图');

foreach ($navbar['options'] as $option => $array)
{
  if ($vars['format'] == 'list' && !isset($vars['view'])) { $vars['view'] = 'basic'; }
  if ($vars['format'] == 'list' && $vars['view'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($vars,array('format' => 'list', 'view' => $option));
}

foreach (array('graphs') as $type)
{
  foreach ($config['graph_types']['port'] as $option => $data)
  {
    if ($vars['format'] == $type && $vars['graph'] == $option)
    {
      $navbar['options'][$type]['suboptions'][$option]['class'] = 'active';
      $navbar['options'][$type]['text'] .= " (".$data['name'].')';
    }
    $navbar['options'][$type]['suboptions'][$option]['text'] = $data['name'];
    $navbar['options'][$type]['suboptions'][$option]['url'] = generate_url($vars, array('view' => NULL, 'format' => $type, 'graph' => $option));
  }
}

  if ($vars['searchbar'] == "hide")
  {
    $navbar['options_right']['searchbar']     = array('text' => '显示搜索', 'url' => generate_url($vars, array('searchbar' => NULL)));
  } else {
    $navbar['options_right']['searchbar']     = array('text' => '隐藏搜索' , 'url' => generate_url($vars, array('searchbar' => 'hide')));
  }

  if ($vars['bare'] == "yes")
  {
    $navbar['options_right']['header']     = array('text' => '显示标题', 'url' => generate_url($vars, array('bare' => NULL)));
  } else {
    $navbar['options_right']['header']     = array('text' => '隐藏标题', 'url' => generate_url($vars, array('bare' => 'yes')));
  }

  $navbar['options_right']['reset']        = array('text' => '重置', 'url' => generate_url(array('page' => 'ports', 'section' => $vars['section'], 'bare' => $vars['bare'])));

print_navbar($navbar);
unset($navbar);

if($debug) { print_vars($vars); }

$param = array();

if(!isset($vars['ignore']))   { $vars['ignore'] = "0"; }
if(!isset($vars['disabled'])) { $vars['disabled'] = "0"; }
if(!isset($vars['deleted']))  { $vars['deleted'] = "0"; }

$select = "`ports`.`port_id` AS `port_id`, `devices`.`device_id` AS `device_id`";
$where = " WHERE 1 ";

include("includes/port-sort-select.inc.php");

foreach ($vars as $var => $value)
{
  if ($value != "")
  {
    switch ($var)
    {
      case 'hostname':
      case 'location':
        $where .= " AND `$var` LIKE ?";
        if (is_array($value)) { $value = $value[0]; }
        $param[] = "%".$value."%";
      case 'device_id':
      case 'deleted':
      case 'ignore':
      case 'disable':
      case 'ifSpeed':
        if (is_numeric($value))
        {
          $where .= " AND `ports`.`$var` = ?";
          $param[] = $value;
        }
        break;
      case 'ifType':
        $where .= " AND `$var` = ?";
        $param[] = $value;
        break;
      case 'ifAlias':
        foreach (explode(",", $value) as $val)
        {
          $param[] = "%".$val."%";
          $cond[] = "`$var` LIKE ?";
        }
        $where .= "AND (";
        $where .= implode(" OR ", $cond);
        $where .= ")";
        break;
      case 'ifDescr':
        foreach (explode(",", $value) as $val)
        {
          $param[] = "%".$val."%";
          $cond[] = "`$var` LIKE ?";
        }
        $where .= "AND (";
        $where .= implode(" OR ", $cond);
        $where .= ")";
        break;
      case 'port_descr_type':
        foreach (explode(",", $value) as $val)
        {
          $param[] = $val;
          $cond[] = "`$var` LIKE ?";
        }
        $where .= "AND (";
        $where .= implode(" OR ", $cond);
        $where .= ")";
        break;
      case 'errors':
        if ($value == 1 || $value == "yes")
        {
          $where .= " AND (`ifInErrors_delta` > '0' OR `ifOutErrors_delta` > '0')";
        }
        break;
      case 'alerted':
        if ($value == "yes")
        {
          $where .= "AND `ifAdminStatus` = ? AND ( `ifOperStatus` = ? OR `ifOperStatus` = ? )";
          $param[] = "up";
          $param[] = "LowerLayerDown";
          $param[] = "down";
        }
      case 'state':
        if ($value == "down")
        {
          $where .= "AND `ifAdminStatus` = ? AND `ifOperStatus` = ?";
          $param[] = "up";
          $param[] = "down";
        } elseif($value == "up") {
          $where .= "AND `ifAdminStatus` = ? AND ( `ifOperStatus` = ? OR `ifOperStatus` = ? )";
          $param[] = "up";
          $param[] = "up";
          $param[] = "monitoring";
        } elseif($value == "admindown") {
          $where .= "AND `ifAdminStatus` = ?";
          $param[] = "down";
        }
      break;
    }
  }
}

$sql  = "SELECT " . $select;
$sql .= " FROM  `ports`";
$sql .= " INNER JOIN `devices` ON `ports`.`device_id` = `devices`.`device_id`";
$sql .= " LEFT JOIN `ports-state` ON `ports`.`port_id` = `ports-state`.`port_id`";
$sql .= " ".$where;

$row = 1;

$ports = dbFetchRows($sql, $param);

port_permitted_array($ports);

include("includes/port-sort.inc.php");

if(file_exists('pages/ports/'.$vars['format'].'.inc.php'))
{
  include('pages/ports/'.$vars['format'].'.inc.php');
} else {
  print_error("错误的列表格式.");
}

// EOF
