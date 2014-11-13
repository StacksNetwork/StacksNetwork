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

if ($bg == "#ffffff") { $bg = "#e5e5e5"; } else { $bg = "#ffffff"; }

$type_where = " (";
foreach (explode(",", $vars['type']) as $type)
{
  $type_where .= " $or `port_descr_type` = ?";
  $or = "OR";
  $type_param[] = $type;
}

$type_where .= ") ";
$ports = dbFetchRows("SELECT * FROM `ports` as I, `devices` AS D WHERE $type_where AND I.device_id = D.device_id AND I.deleted = 0 ORDER BY I.ifAlias", $type_param);

foreach ($ports as $port)
{
  $if_list .= $seperator . $port['port_id'];
  $seperator = ",";
}
unset($seperator);

$types_array = explode(',',$vars['type']);
for ($i = 0; $i < count($types_array);$i++) $types_array[$i] = ucfirst($types_array[$i]);
$types = implode(' + ',$types_array);

echo('<h4>所有端口类型的流量图 : '.$types.'</h4>');

if ($if_list)
{
  $graph_type = "multiport_bits_separate";
  $port['port_id'] = $if_list;

  include("includes/print-interface-graphs.inc.php");

?>

<table class="table table-hover table-striped-two table-bordered table-condensed table-rounded" style="margin-top: 10px;">
  <thead>
      <tr>
        <th width='250'><span style='font-weight: bold;' class=interface>说明</span></th>
        <th width='150'>设备</th>
        <th width='100'>接口</th>
        <th width='100'>速度</th>
        <th width='100'>线路</th>
        <th>备注</th>
      </tr>
  </thead>

<?php

  foreach ($ports as $port)
  {
    $done = "yes";
    unset($class);
    $port['ifAlias'] = str_ireplace($type . ": ", "", $port['ifAlias']);
    $port['ifAlias'] = str_ireplace("[PNI]", "Private", $port['ifAlias']);
    $ifclass = ifclass($port['ifOperStatus'], $port['ifAdminStatus']);
    if ($bg == "#ffffff") { $bg = "#e5e5e5"; } else { $bg = "#ffffff"; }
    echo("<tr class='iftype'>
             <td><span class=entity-title>" . generate_port_link($port,$port['port_descr_descr']) . "</span>");
#            <span class=small style='float: left;'>".generate_device_link($port)." ".generate_port_link($port)." </span>");

    if (dbFetchCell("SELECT count(*) FROM mac_accounting WHERE port_id = ?", array($port['port_id'])))
    {
      echo("<span style='float: right;'><a href='device/device=".$port['device_id']."/tab=port/port=".$port['port_id']."/view=macaccounting/'><img src='/images/16/chart_curve.png' align='absmiddle'> MAC Accounting</a></span>");
    }

    echo("</td>");

    echo("   <td width='150' class='strong'>" . generate_device_link($port) . "</td>
             <td width='150' class='strong'>" . generate_port_link($port, short_ifname($port['ifDescr'])) . "</td>
             <td width='75'>".$port['port_descr_speed']."</td>
             <td width='150'>".$port['port_descr_circuit']."</td>
             <td>".$port['port_descr_notes']."</td>");

    echo('</tr><tr><td colspan=6>');

    $rrdfile = get_port_rrdfilename($port, $port);
    if (file_exists($rrdfile))
    {
      $graph_type = "port_bits";

      include("includes/print-interface-graphs.inc.php");
    }

    echo("</td></tr>");
  }

}
else
{
  echo("没有发现.</td></tr>");
}

?>
</table>
<?php

// EOF
