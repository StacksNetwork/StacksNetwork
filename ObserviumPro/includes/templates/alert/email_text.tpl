/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage templates
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */
/**
 * Used keys:
 * ALERT_STATE, ALERT_URL, ALERT_MESSAGE, CONDITIONS, METRICS, DURATION,
 * ENTITY_NAME, ENTITY_DESCRIPTION,
 * DEVICE_HOSTNAME, DEVICE_HARDWARE, DEVICE_OS, DEVICE_LOCATION, DEVICE_UPTIME
 */
------------------------------------
{{ALERT_STATE}}
{{ALERT_MESSAGE}}
------------------------------------
实体:      {{ENTITY_NAME}}
{{#ENTITY_DESCRIPTION}}
概述:      {{ENTITY_DESCRIPTION}}
{{/ENTITY_DESCRIPTION}}
{{#CONDITIONS}}
情况:      {{{CONDITIONS}}}
{{/CONDITIONS}}
指标:      {{METRICS}}
持续时间:  {{DURATION}}
------------------------------------

------------------------------------
设备:      {{DEVICE_HOSTNAME}}
硬件:      {{DEVICE_HARDWARE}}
OS:        {{DEVICE_OS}}
位置:      {{DEVICE_LOCATION}}
运行时间:  {{DEVICE_UPTIME}}
------------------------------------
