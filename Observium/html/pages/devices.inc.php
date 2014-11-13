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

// Set Defaults here

if(!isset($vars['format'])) { $vars['format'] = "detail"; }
if (!$config['web_show_disabled'] && !isset($vars['disabled'])) { $vars['disabled'] = '0'; }

/// FIXME - new style (print_search_simple) of searching here

$sql_param = array();
$where = ' WHERE 1 ';
foreach ($vars as $var => $value)
{
  if ($value != '')
  {
    switch ($var)
    {
      case 'hostname':
        $where .= ' AND `hostname` LIKE ?';
        $sql_param[] = '%'.$value.'%';
        break;
      case 'sysname':
        $where .= ' AND `sysName` LIKE ?';
        $sql_param[] = '%'.$value.'%';
        break;
      case 'location_text':
        $where .= ' AND `location` LIKE ?';
        $sql_param[] = '%'.str_replace('*', '%', $value).'%';
        break;
      case 'os':
      case 'version':
      case 'hardware':
      case 'features':
      case 'type':
      case 'status':
      case 'ignore':
      case 'disabled':
      case 'location_country':
      case 'location_state':
      case 'location_county':
      case 'location_city':
      case 'location':
        $where .= ' AND `'.$var.'` = ?';
        if (is_array($value)) { $value = $value[0]; }
        $sql_param[] = $value;
        break;
    }
  }
}

$pagetitle[] = "设备";

echo('<div class="well" style="padding: 10px;">');

if($vars['searchbar'] != "hide")
{

?>

<form method="post" class="form form-inline" action="" id="devices-form" style="margin-bottom:0;">

<?php

  // Loop variables which can be set by button to make sure they're squeezed in to the URL.

  foreach (array('bare', 'searchbar', 'format') as $element) {
    if (isset($vars[$element])) {
      echo '<input type="hidden" name="',$element,'" value="',$vars[$element],'" />';
    }
  }

?>

    <div class="row">
      <div class="col-lg-2">
          <input placeholder="主机名" type="text" name="hostname" id="hostname" class="input" value="<?php htmlentities($vars['hostname']); ?>" />
      </div>
      <div class="col-lg-2">
        <select class="selectpicker" name="location" id="location">
          <option value="">所有物理位置</option>
          <?php
// FIXME function?

foreach (get_locations() as $location)
{
  $value = base64_encode(json_encode(array($location)));
  $name  = ($location == '' ? '[[UNKNOWN]]' : htmlspecialchars($location));
  echo('<option value="'.$value.'"');
  if (array($location) === $vars['location']) { echo(" selected"); }
  echo(">" . $name . "</option>");
}
?>
        </select>
      </div>
      <div class="col-lg-2">
        <select class="selectpicker" name='os' id='os'>
          <option value=''>所有操作系统</option>
          <?php

$where_form = ($config['web_show_disabled']) ? '' : 'AND disabled = 0';
foreach (dbFetch('SELECT `os` FROM `devices` AS D WHERE 1 '.$where_form.' GROUP BY `os` ORDER BY `os`') as $data)
{
  if ($data['os'])
  {
    echo("<option value='".$data['os']."'");
    if ($data['os'] == $vars['os']) { echo(" selected"); }
    echo(">".$config['os'][$data['os']]['text']."</option>");
  }
}
          ?>
        </select>
      </div>
      <div class="col-lg-2">
        <select class="selectpicker" name="hardware" id="hardware">
          <option value="">所有平台</option>
          <?php
foreach (dbFetch('SELECT `hardware` FROM `devices` AS D WHERE 1 '.$where_form.' GROUP BY `hardware` ORDER BY `hardware`') as $data)
{
  if ($data['hardware'])
  {
    echo('<option value="'.$data['hardware'].'"');
    if ($data['hardware'] == $vars['hardware']) { echo(" selected"); }
    echo(">".$data['hardware']."</option>");
  }
}
          ?>
        </select>
      </div>
    <div class="col-lg-2 pull-right">
        <select name="sort" id="sort" class="selectpicker pull-right" title="排序方式" style="width: 150px;" data-width="150px">
<?php
$sorts = array('hostname' => '主机名',
               'location' => '物理位置',
               'os' => '操作系统',
               'uptime'   => '运行时间');

foreach ($sorts as $sort => $sort_text)
{
  if (!isset($vars['sort'])) { $vars['sort'] = $sort; }
  echo('<option value="'.$sort.'"');
  if ($vars['sort'] == $sort)  { echo(" selected"); }
  if ($vars['sort'] == $sort)  { echo(' data-icon="oicon-sort-alphabet-column"'); }
  echo('>'.$sort_text.'</option>');
}
?>

        </select>
    </div>

    </div>
    <div class="row" style="margin-top: 10px;">
      <div class="col-lg-2">
          <input placeholder="系统名称" type="text" name="sysname" id="sysname" class="input" value="<?php echo($vars['sysname']); ?>" />
      </div>
      <div class="col-lg-2">
          <input placeholder="物理位置" type="text" name="location_text" id="location_text" class="input" value="<?php echo($vars['location_text']); ?>" />
      </div>
      <div class="col-lg-2">
        <select  class="selectpicker" name='version' id='version'>
          <option value=''>所有版本</option>
          <?php

foreach (dbFetch('SELECT `version` FROM `devices` AS D WHERE 1 '.$where_form.' GROUP BY `version` ORDER BY `version`') as $data)
{
  if ($data['version'])
  {
    echo("<option value='".$data['version']."'");
    if ($data['version'] == $vars['version']) { echo(" selected"); }
    echo(">".$data['version']."</option>");
  }
}
          ?>
        </select>
      </div>
      <div class="col-lg-2">
        <select class="selectpicker" name="features" id="features">
          <option value="">所有功能设置</option>
          <?php

foreach (dbFetch('SELECT `features` FROM `devices` AS D WHERE 1 '.$where_form.' GROUP BY `features` ORDER BY `features`') as $data)
{
  if ($data['features'])
  {
    echo('<option value="'.$data['features'].'"');
    if ($data['features'] == $vars['features']) { echo(" selected"); }
    echo(">".$data['features']."</option>");
  }
}
          ?>
        </select>

      </div>
      <div class="col-lg-2">
        <select class="selectpicker" name="type" id="type">
          <option value="">所有设备类型</option>
          <?php

foreach (dbFetch('SELECT `type` FROM `devices` AS D WHERE 1 '.$where_form.' GROUP BY `type` ORDER BY `type`') as $data)
{
  if ($data['type'])
  {
    echo("<option value='".$data['type']."'");
    if ($data['type'] == $vars['type']) { echo(" selected"); }
    echo(">".ucfirst($data['type'])."</option>");
  }
}
          ?>
        </select>

      </div>
      <div class="col-lg-2 pull-right">
        <button type="submit" onClick="submitURL();" class="btn pull-right"><i class="icon-search"></i> 搜索</button>
      </div>

    </div>

</form>

<script>

// This code updates the FORM URL

function submitURL() {
  var url = '/devices/';

    var partFields = document.getElementById("devices-form").elements;

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

   $('#devices-form').attr('action', url);

}

</script>

</div>

<?php

}

// Set graph period stuff

$timestamp_pattern = '/^(\d{4})-(\d{2})-(\d{2}) ([01][0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$/';
if (isset($vars['timestamp_from']) && preg_match($timestamp_pattern, $vars['timestamp_from']))
{
  $vars['from'] = strtotime($vars['timestamp_from']);
  unset($vars['timestamp_from']);
}
if (isset($vars['timestamp_to'])   && preg_match($timestamp_pattern, $vars['timestamp_to']))
{
  $vars['to'] = strtotime($vars['timestamp_to']);
  unset($vars['timestamp_to']);
}

if (!is_numeric($vars['from'])) { $vars['from'] = $config['time']['day']; }
if (!is_numeric($vars['to']))   { $vars['to']   = $config['time']['now']; }

// Build Devices navbar

$navbar = array('brand' => "设备", 'class' => "navbar-narrow");

$navbar['options']['basic']['text']    = '基础';
$navbar['options']['detail']['text']   = '详情';
$navbar['options']['status']['text']   = '状态';

// There is no detailed view for this yet.
//$navbar['options']['detail']['text']  = '详情';

$navbar['options']['graphs']     = array('text' => '流量图');

foreach ($navbar['options'] as $option => $array)
{
  if (!isset($vars['format'])) { $vars['format'] = 'basic'; }
  if ($vars['format'] == $option) { $navbar['options'][$option]['class'] .= " active"; }
  $navbar['options'][$option]['url'] = generate_url($vars,array('format' => $option));
}

$menu_options = array('bits'      => 'Bits',
                      'processor' => 'CPU',
                      'mempool'   => 'Memory',
                      'uptime'    => 'Uptime',
                      'storage'   => 'Storage',
                      'diskio'    => 'Disk I/O',
                      'poller_perf' => 'Poll Time'
                      );

// Print options related to graphs.

foreach (array('graphs') as $type)
{
  foreach ($config['graph_types']['device'] as $option => $data)
  {
    if (!isset($data['name'])) { $data['name'] = nicecase($option);}

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

  $navbar['options_right']['reset']        = array('text' => '重置', 'url' => generate_url(array('page' => 'devices', 'section' => $vars['section'], 'bare' => $vars['bare'])));

print_navbar($navbar);
unset($navbar);

// Print period options for graphs

if($vars['format'] == 'graphs')
{
  $search = array();
  $search[] = array('type'    => 'datetime',
                    'id'      => 'timestamp',
                    'presets' => TRUE,
                    'min'     => '2007-04-03 16:06:59',  // Hehe, who will guess what this date/time means? --mike
                                                         // First commit! Though Observium was already 7 months old by that point. --adama
                    'max'     => date('Y-m-d 23:59:59'), // Today
                    'from'    => date('Y-m-d H:i:s', $vars['from']),
                    'to'      => date('Y-m-d H:i:s', $vars['to']));

  print_search($search, NULL, 'update');
  unset($search);
}

switch ($vars['sort'])
{
  case 'uptime':
    $order= ' ORDER BY `uptime`';
    break;
  case 'location':
    $order = ' ORDER BY `location`';
    break;
  case 'os':
    $order = ' ORDER BY `os`';
    break;
  default:
    $order = ' ORDER BY `hostname`';
    break;
}

$query = "SELECT * FROM `devices` " . $where . $order;

list($format, $subformat) = explode("_", $vars['format'], 2);

$devices = dbFetchRows($query, $sql_param);

if(count($devices))
{
  if (file_exists('pages/devices/'.$format.'.inc.php'))
  {
    include('pages/devices/'.$format.'.inc.php');
  } else {
?>

<div class="alert alert-error">
  <h4>错误</h4>
  这是不应该发生的情况. 请确保使用的是最终版本, 如果再次发生请向observium开发团队报告.
</div>

<?php
  }

} else {

?>
<div class="alert alert-error">
  <h4>没有发现任何设备</h4>
  请调整您的搜索参数.
</div>

<?php
}

// EOF
