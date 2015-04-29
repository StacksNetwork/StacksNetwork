<?php

/**
 * Observium Network Management and Monitoring System
 * Copyright (C) 2006-2014, Adam Armstrong - http://www.observium.org
 *
 * @package    observium
 * @subpackage webui
 * @author     Adam Armstrong <adama@memetic.org>
 * @copyright  (C) 2006-2015 Adam Armstrong
 *
 */

// Alert test display and editing page.

include($config['html_dir']."/includes/alerting-navbar.inc.php");

?>

<div class="row">
<div class="col-md-12">

<?php

// FIXME. Show for anyone (also for non-ADMIN) and any contacts?
$contacts = dbFetchRows("SELECT * FROM `alert_contacts` WHERE 1");
if (count($contacts))
{
  // We have contacts, print the table.
?>

<table class="table table-condensed table-bordered table-striped table-rounded table-hover">
  <thead>
    <tr>
    <th style="width: 1px"></th>
    <th style="width: 50px">Id</th>
    <th style="width: 300px">Description</th>
    <th style="width: 100px">Method</th>
    <th>Endpoint / Destination</th>
    <th></th>
    <th style="width: 100px">Disabled</th>
    </tr>
  </thead>
  <tbody>

<?php

  foreach($contacts as $contact)
  {
    echo '    <tr>';
    echo '      <td></td>';
    echo '      <td>'.$contact['contact_id'].'</td>';
    echo '      <td>'.$contact['contact_descr'].'</td>';
    echo '      <td>'.$contact['contact_method'].'</td>';
    echo '      <td>'.$contact['contact_endpoint'].'</td>';
    echo '      <td></td>';
    echo '      <td></td>';
    echo '    </tr>';
  }

?>

  </tbody>
</table>

<?php
} else {

// We don't have contacts. Say so.

}
?>

  </div> <!-- col-md-12 -->

</div> <!-- row -->

