<?php

//  Lives at /opt/observium/html/pages/device/graphs/sonicwall-sessions.inc.php

if ($device['os'] == "sonicwall")
{
  $graph_title = "防火墙会话";
  $graph_type = "netscreen_sessions";

  include("includes/print-device-graph.php");
}

?>
