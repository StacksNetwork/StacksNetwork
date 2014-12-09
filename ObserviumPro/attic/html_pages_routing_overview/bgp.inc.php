
<?php 

$total = mysql_result(mysql_query("SELECT count(*) FROM `bgpPeers`"),0);
$up    = mysql_result(mysql_query("SELECT count(*) FROM `bgpPeers` WHERE `bgpPeerState` = 'established'"),0);
$stop  = mysql_result(mysql_query("SELECT count(*) FROM `bgpPeers` WHERE `bgpPeerAdminStatus` = 'stop'"),0);

echo('
  <div>
    <span style="device-list">会话: '.$total.' 正常: '.$up.' 异常: '.($total-$up) . ($stop != 0 ? ' ( 关闭: '.$stop.' )' : '') . '</span>
  </div>');

?>
