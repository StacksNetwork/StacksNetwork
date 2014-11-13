<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage applications
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

$sql = "SELECT * FROM `applications-state` WHERE `application_id` = ?";
$app_state = dbFetchRow($sql, array($app['app_id']));
$app_data = unserialize($app_state['app_state']);

?>

<div class="row">
  <div class="col-md-6">
    <?php include("mssql/memory.inc.php"); ?>
  </div>
  <div class="col-md-6">
    <div class="well info_box">
      <div class="title"><i class="oicon-processor"></i> Processor</div>
      <div class="content">
        <?php include("mssql/processor.inc.php"); ?>
      </div>
    </div>
  </div>
  <div class="col-md-6">
  </div>
</div>

<?php

// EOF
