<?php

include("includes/graphs/device/auth.inc.php");

if ($auth && is_numeric($_GET['mod']) && is_numeric($_GET['chan']))
{

  $entity = dbFetchRow("SELECT * FROM entPhysical WHERE device_id = ? AND entPhysicalIndex = ?", array($device['device_id'], $_GET['mod']));

  $title .= " :: ".$entity['entPhysicalName'];
  $title .= " :: Fabric ".$_GET['chan'];

  $graph_title = short_hostname($device['hostname']) . "::" . $entity['entPhysicalName']. "::Fabric".$_GET['chan'];

  $rrd_filename = $config['rrd_dir'] . "/" . $device['hostname'] . "/c6kxbar-" . safename($_GET['mod']. "-".$_GET['chan']. ".rrd");
}

?>
