<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage api
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

?>
<div class="row">
  <div class="col-md-12 well">
    <h3>清单:</h3>
    <p>
      使用该模块能够导出在设备列表中发现的数据内容
      设备清单.
    </p>
    <dl>
      <dt>设备</dt>
      <dd>想要从设备清单中抓取设备ID</dd>
    </dl>
    <pre>
      <strong>Explanation :</strong> Collect the inventory list of server with id 2
      <strong>Example 1   :</strong> http://<?php echo($_SERVER['SERVER_NAME']); ?>/api.php?username=demo&amp;password=demo&amp;module=inventory&amp;device=2
      <strong>Result      :</strong> {"login":{"success":{"code":"101","msg":"User authentification succeeded"}},"data":[{"hrDevice_id":"1","device_id":"2","hrDeviceIndex":"768","hrDeviceDescr":"GenuineIntel: Intel(R) Xeon(TM) CPU 2.40GHz","hrDeviceType":"hrDeviceProcessor","hrDeviceErrors":"0","hrDeviceStatus":"running","hrProcessorLoad":"16"},{"hrDevice_id":"2","device_id":"2","hrDeviceIndex":"1025","hrDeviceDescr":"network interface lo","hrDeviceType":"hrDeviceNetwork","hrDeviceErrors":"0","hrDeviceStatus":"running","hrProcessorLoad":null},{"hrDevice_id":"3","device_id":"2","hrDeviceIndex":"1026","hrDeviceDescr":"network interface eth0","hrDeviceType":"hrDeviceNetwork","hrDeviceErrors":"0","hrDeviceStatus":"running","hrProcessorLoad":null},{"hrDevice_id":"62","device_id":"2","hrDeviceIndex":"1600","hrDeviceDescr":"LVM volume (VolGroup-lv_root)","hrDeviceType":"hrDeviceDiskStorage","hrDeviceErrors":"0","hrDeviceStatus":"","hrProcessorLoad":null},{"hrDevice_id":"63","device_id":"2","hrDeviceIndex":"1616","hrDeviceDescr":"LVM volume (VolGroup-lv_swap)","hrDeviceType":"hrDeviceDiskStorage","hrDeviceErrors":"0","hrDeviceStatus":"","hrProcessorLoad":null},{"hrDevice_id":"4","device_id":"2","hrDeviceIndex":"3072","hrDeviceDescr":"Guessing that there's a floating point co-processor","hrDeviceType":"hrDeviceCoprocessor","hrDeviceErrors":"0","hrDeviceStatus":"","hrProcessorLoad":null}]}</pre>
  </div>
</div>

