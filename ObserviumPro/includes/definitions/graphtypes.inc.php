<?php

/**
 * Observium
 *
 *   This file is part of Observium.
 *
 * @package    observium
 * @subpackage definitions
 * @copyright  (C) 2006-2014 Adam Armstrong
 *
 */

// Graph sections is used to categorize /device/graphs/

$config['graph_sections'] = array('general', 'system', 'firewall', 'netstats', 'wireless',
                                  'storage', 'vpdn', 'appliance', 'poller', 'netapp',
                                  'netscaler_tcp' => 'Netscaler TCP', 'netscaler_ssl' => 'Netscaler SSL',
                                  'netscaler_http' => 'Netscaler HTTP', 'netscaler_comp' => 'Netscaler Compression',
                                  'proxysg' => 'Proxy SG');

// Graph types

$config['graph_types']['port']['bits']       = array('name' => 'Bits',            'descr' => "流入比特/秒");
$config['graph_types']['port']['upkts']      = array('name' => '单播数据包',      'descr' => "单播数据包/秒");
$config['graph_types']['port']['nupkts']     = array('name' => '多播数据包',         'descr' => "非单播数据包/秒");
$config['graph_types']['port']['pktsize']    = array('name' => '包大小',        'descr' => "数据包的平均大小");
$config['graph_types']['port']['percent']    = array('name' => '百分比',         'descr' => "利用率百分比");
$config['graph_types']['port']['errors']     = array('name' => '错误',          'descr' => "错误/秒");
$config['graph_types']['port']['etherlike']  = array('name' => '以太网错误', 'descr' => "详细的错误/秒以太网接口");
$config['graph_types']['port']['fdb_count']  = array('name' => 'FDB计数',      'descr' => "FDB使用");

$config['graph_types']['device']['wifi_clients']['section'] = 'wireless';
$config['graph_types']['device']['wifi_clients']['order'] = '0';
$config['graph_types']['device']['wifi_clients']['descr'] = '无线客户端';

// NetApp graphs
$config['graph_types']['device']['netapp_ops']     = array('section' => 'netapp', 'descr' => 'NetApp操作系统', 'order' => '0');
$config['graph_types']['device']['netapp_net_io']  = array('section' => 'netapp', 'descr' => 'NetApp网络I/O', 'order' => '1');
$config['graph_types']['device']['netapp_disk_io'] = array('section' => 'netapp', 'descr' => 'NetApp磁盘I/O', 'order' => '2');
$config['graph_types']['device']['netapp_tape_io'] = array('section' => 'netapp', 'descr' => 'NetApp磁带I/O', 'order' => '3');
$config['graph_types']['device']['netapp_cp_ops']  = array('section' => 'netapp', 'descr' => 'NetApp检查操作系统', 'order' => '4');

// Poller graphs

$config['graph_types']['device']['poller_perf']    = array(
  'section'   => 'poller',
  'descr'     => '轮询时间',
  'file'      => 'perf-poller.rrd',
  'colours'   => 'greens',
  'unit_text' => ' ',
  'ds'        => array (
    'val'   => array ('label' => '秒', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['ping'] = array(
  'section'   => 'poller',
  'descr'     => 'Ping响应',
  'file'      => 'ping.rrd',
  'colours'   => 'reds',
  'unit_text' => '毫秒',
  'ds'        => array(
    'ping' => array('label' => 'Ping', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['ping_snmp'] = array(
  'section'   => 'poller',
  'descr'     => 'SNMP响应',
  'file'      => 'ping_snmp.rrd',
  'colours'   => 'blues',
  'unit_text' => '毫秒',
  'ds'        => array(
    'ping_snmp' => array('label' => 'SNMP', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['agent']['section'] = 'poller';
$config['graph_types']['device']['agent']['order'] = '0';
$config['graph_types']['device']['agent']['descr'] = '代理执行时间';

$config['graph_types']['device']['netstat_arista_sw_ip'] = array(
  'section' => 'netstats',
  'order' => '0',
  'descr' => "软件转发IPv4统计"
);
$config['graph_types']['device']['netstat_arista_sw_ip_frag'] = array(
  'section' => 'netstats',
  'order' => '0',
  'descr' => "软件转发IPv4碎片统计"
);
$config['graph_types']['device']['netstat_arista_sw_ip6'] = array(
  'section' => 'netstats',
  'order' => '0',
  'descr' => "软件转发IPv6统计"
);
$config['graph_types']['device']['netstat_arista_sw_ip6_frag'] = array(
  'section' => 'netstats',
  'order' => '0',
  'descr' => "软件转发IPv6碎片统计s"
);

$config['graph_types']['device']['cipsec_flow_bits']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_bits']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_bits']['descr'] = 'IPSec隧道流量';
$config['graph_types']['device']['cipsec_flow_pkts']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_pkts']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_pkts']['descr'] = 'IPSec隧道数据包流量';
$config['graph_types']['device']['cipsec_flow_stats']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_stats']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_stats']['descr'] = 'IPSec隧道统计';
$config['graph_types']['device']['cipsec_flow_tunnels']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_tunnels']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_tunnels']['descr'] = 'IPSec可用隧道';
$config['graph_types']['device']['cras_sessions']['section'] = 'firewall';
$config['graph_types']['device']['cras_sessions']['order'] = '0';
$config['graph_types']['device']['cras_sessions']['descr'] = '远程访问会话';
$config['graph_types']['device']['fortigate_sessions']['section'] = 'firewall';
$config['graph_types']['device']['fortigate_sessions']['order'] = '0';
$config['graph_types']['device']['fortigate_sessions']['descr'] = '活跃会话';
$config['graph_types']['device']['fortigate_cpu']['section'] = 'system';
$config['graph_types']['device']['fortigate_cpu']['order'] = '0';
$config['graph_types']['device']['fortigate_cpu']['descr'] = 'CPU';
$config['graph_types']['device']['screenos_sessions']['section'] = 'firewall';
$config['graph_types']['device']['screenos_sessions']['order'] = '0';
$config['graph_types']['device']['screenos_sessions']['descr'] = '活跃会话';
$config['graph_types']['device']['panos_sessions']['section'] = 'firewall';
$config['graph_types']['device']['panos_sessions']['order'] = '0';
$config['graph_types']['device']['panos_sessions']['descr'] = '活跃会话';

// CHECKPOINT-MIB

$config['graph_types']['device']['checkpoint_connections'] = array(
  'section'   => 'firewall',
  'descr'     => '并发连接',
  'file'      => 'checkpoint-mib_fw.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '并发连接',
  'ds'        => array(
    'NumConn'     => array('label' => '当前', 'draw' => 'LINE'),
    'PeakNumConn' => array('label' => '峰值',    'draw' => 'LINE'),
  )
);

$config['graph_types']['device']['checkpoint_packets']    = array(
  'section'   => 'firewall',
  'descr'     => '数据包',
  'file'      => 'checkpoint-mib_fw.rrd',
  'colours'   => 'mixed',
  'unit_text' => '数据包',
  'ds'        => array(
    'Accepted'   => array('label' => '接受', 'draw' => 'LINE'),
    'Rejected'   => array('label' => '拒绝', 'draw' => 'LINE'),
    'Dropped'    => array('label' => '丢弃',  'draw' => 'LINE'),
    'Logged'     => array('label' => '记录',   'draw' => 'LINE')
  )
);

// Not enabled
$config['graph_types']['device']['checkpoint_packets_rate'] = array(
  'section'   => 'firewall',
  'descr'     => '数据包比例',
  'file'      => 'checkpoint-mib_fw.rrd',
  'colours'   => 'mixed',
  'unit_text' => '数据包/秒',
  'ds'        => array(
    'PacketsRate'       => array('label' => '数据包',        'draw' => 'LINE'),
    'AcceptedBytesRate' => array('label' => '接受字节', 'draw' => 'LINE'),
    'DroppedBytesRate'  => array('label' => '丢弃字节',  'draw' => 'LINE'),
    'DroppedRate'       => array('label' => '总丢弃',  'draw' => 'LINE'),
  )
);

$config['graph_types']['device']['checkpoint_vpn_sa']    = array(
  'section'   => 'firewall',
  'descr'     => 'VPN IKE/IPSec SAs',
  //'file'      => 'checkpoint-mib_cpvikeglobals.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => 'IKE/IPSec SAs',
  'ds'        => array(
    'IKECurrSAs'     => array('label' => 'IKE SAs',       'draw' => 'LINE', 'file' => 'checkpoint-mib_cpvikeglobals.rrd'),
    'CurrEspSAsIn'   => array('label' => 'IPSec SAs流入',  'draw' => 'LINE', 'file' => 'checkpoint-mib_cpvsastatistics.rrd'),
    'CurrEspSAsOut'  => array('label' => 'IPSec SAs流出', 'draw' => 'LINE', 'file' => 'checkpoint-mib_cpvsastatistics.rrd')
  )
);

$config['graph_types']['device']['checkpoint_vpn_packets']    = array(
  'section'   => 'firewall',
  'descr'     => 'VPN数据包',
  'file'      => 'checkpoint-mib_cpvgeneral.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '数据包/秒',
  'ds'        => array(
    'EncPackets' => array('label' => '加密', 'draw' => 'LINE'),
    'DecPackets' => array('label' => '解密', 'draw' => 'LINE')
  )
);

$config['graph_types']['device']['checkpoint_memory']    = array(
  'section'   => 'firewall',
  'descr'     => '内核/散列内存',
  'file'      => 'checkpoint-mib_fwkmem.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '字节',
  'ds'        => array(
    'Kmem-bytes-used'   => array('label' => 'Kmem已用',   'draw' => 'LINE'),
    'Kmem-bytes-unused' => array('label' => 'Kmem未使用', 'draw' => 'LINE'),
    'Kmem-bytes-peak'   => array('label' => 'Kmem峰值',   'draw' => 'LINE'),
    'Hmem-bytes-used'   => array('label' => 'Hmem已用',   'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd'),
    'Hmem-bytes-unused' => array('label' => 'Hmem未使用', 'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd'),
    'Hmem-bytes-peak'   => array('label' => 'Hmem峰值',   'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd')
  )
);

$config['graph_types']['device']['checkpoint_memory_operations']    = array(
  'section'   => 'firewall',
  'descr'     => '内核/散列内存进程',
  'file'      => 'checkpoint-mib_fwkmem.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '进程/秒',
  'ds'        => array(
    'Kmem-alc-operations'  => array('label' => 'Kmem分配',         'draw' => 'LINE'),
    'Kmem-free-operation'  => array('label' => 'Kmem释放',          'draw' => 'LINE'),
    'Kmem-failed-alc'      => array('label' => 'Kmem未分配',  'draw' => 'LINE'),
    'Kmem-failed-free'     => array('label' => 'Kmem未释放',   'draw' => 'LINE'),
    'Hmem-alc-operations'  => array('label' => 'Hmem分配',         'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd'),
    'Hmem-free-operation'  => array('label' => 'Hmem释放',          'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd'),
    'Hmem-failed-alc'      => array('label' => 'Hmem未分配',  'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd'),
    'Hmem-failed-free'     => array('label' => 'Hmem未释放',   'draw' => 'LINE', 'file' => 'checkpoint-mib_fwhmem.rrd')
  )
);

// SONICWALL-FIREWALL-IP-STATISTICS-MIB
$config['graph_types']['device']['sonicwall_sessions'] = array(
  'section'   => 'firewall',
  'descr'     => '通过防火墙连接缓存内容数量',
  'file'      => 'sonicwall-firewall-ip-statistics-mib_sonicwallfwstats.rrd',
  'scale_min' => '0',
  'no_mag'    => TRUE,
  'num_fmt'   => '6.0',
  'colours'   => 'mixed',
  'unit_text' => 'Entries',
  'ds'        => array(
    'MaxConnCache'     => array('label' => '最大连接数'),
    'CurrentConnCache' => array('label' => '活跃连接'),
  )
);
$config['graph_types']['device']['sonicwall_sa_byte'] = array(
  'section'   => 'firewall',
  'descr'     => '加密/解密字节统计',
  'file'      => 'sonicwall-firewall-ip-statistics-mib_sonicsastattable.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '字节/秒',
  'ds'        => array(
    'EncryptByteCount'  => array('label' => '加密'),
    'DecryptByteCount'  => array('label' => '解密'),
  )
);
$config['graph_types']['device']['sonicwall_sa_pkt'] = array(
  'section'   => 'firewall',
  'descr'     => '加密/解密的数据包数',
  'file'      => 'sonicwall-firewall-ip-statistics-mib_sonicsastattable.rrd',
  'scale_min' => '0',
  'colours'   => 'mixed',
  'unit_text' => '数据包/秒',
  'ds'        => array(
    'EncryptPktCount'   => array('label' => '加密'),
    'DecryptPktCount'   => array('label' => '解密'),
    'InFragPktCount'    => array('label' => '进入的碎片包'),
    'OutFragPktCount'   => array('label' => '出去的碎片包'),
  )
);

$config['graph_types']['device']['juniperive_users']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_users']['order'] = '0';
$config['graph_types']['device']['juniperive_users']['descr'] = '并发用户';
$config['graph_types']['device']['juniperive_meetings']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_meetings']['order'] = '0';
$config['graph_types']['device']['juniperive_meetings']['descr'] = '会话';
$config['graph_types']['device']['juniperive_connections']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_connections']['order'] = '0';
$config['graph_types']['device']['juniperive_connections']['descr'] = '连接数';
$config['graph_types']['device']['juniperive_storage']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_storage']['order'] = '0';
$config['graph_types']['device']['juniperive_storage']['descr'] = '存储';

// Device - Ports section
$config['graph_types']['device']['bits']['section'] = 'ports';
$config['graph_types']['device']['bits']['descr']   = '流量';

// Device - Netstat section
$config['graph_types']['device']['ipsystemstats_ipv4']['section'] = 'netstats';
$config['graph_types']['device']['ipsystemstats_ipv4']['order'] = '0';
$config['graph_types']['device']['ipsystemstats_ipv4']['descr'] = 'IPv4数据包统计';
$config['graph_types']['device']['ipsystemstats_ipv4_frag']['section'] = 'netstats';
$config['graph_types']['device']['ipsystemstats_ipv4_frag']['order'] = '0';
$config['graph_types']['device']['ipsystemstats_ipv4_frag']['descr'] = 'IPv4碎片统计';
$config['graph_types']['device']['ipsystemstats_ipv6']['section'] = 'netstats';
$config['graph_types']['device']['ipsystemstats_ipv6']['order'] = '0';
$config['graph_types']['device']['ipsystemstats_ipv6']['descr'] = 'IPv6数据包统计';
$config['graph_types']['device']['ipsystemstats_ipv6_frag']['section'] = 'netstats';
$config['graph_types']['device']['ipsystemstats_ipv6_frag']['order'] = '0';
$config['graph_types']['device']['ipsystemstats_ipv6_frag']['descr'] = 'IPv6碎片统计';
$config['graph_types']['device']['netstat_icmp_info']['section'] = 'netstats';
$config['graph_types']['device']['netstat_icmp_info']['order'] = '0';
$config['graph_types']['device']['netstat_icmp_info']['descr'] = 'ICMP信息统计';
$config['graph_types']['device']['netstat_icmp']['section'] = 'netstats';
$config['graph_types']['device']['netstat_icmp']['order'] = '0';
$config['graph_types']['device']['netstat_icmp']['descr'] = 'ICMP统计';
$config['graph_types']['device']['netstat_ip']['section'] = 'netstats';
$config['graph_types']['device']['netstat_ip']['order'] = '0';
$config['graph_types']['device']['netstat_ip']['descr'] = 'IP统计';
$config['graph_types']['device']['netstat_ip_frag']['section'] = 'netstats';
$config['graph_types']['device']['netstat_ip_frag']['order'] = '0';
$config['graph_types']['device']['netstat_ip_frag']['descr'] = 'IP碎片统计';

$config['graph_types']['device']['netstat_snmp_stats']           = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'SNMP统计');

$config['graph_types']['device']['netstat_snmp_packets']    = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'SNMP数据包');

$config['graph_types']['device']['netstat_tcp_stats']            = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP统计');

$config['graph_types']['device']['netstat_tcp_currestab']       = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP建立连接');

$config['graph_types']['device']['netstat_tcp_segments']    = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP分段');

$config['graph_types']['device']['netstat_udp_errors']         = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'UDP错误');

$config['graph_types']['device']['netstat_udp_datagrams']    = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'UDP数据包');

// Device - System section
$config['graph_types']['device']['fdb_count']['section'] = 'system';
$config['graph_types']['device']['fdb_count']['order'] = '0';
$config['graph_types']['device']['fdb_count']['descr'] = 'FDB表的使用';

$config['graph_types']['device']['hr_processes'] = array(
  'section'   => 'system',
  'descr'     => '运行的处理器',
  'file'      => 'hr_processes.rrd',
  'colours'   => 'pinks',
  'unit_text' => ' ',
  'ds'        => array(
    'procs' => array('label' => '处理器', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['hr_users'] = array(
  'section'   => 'system',
  'descr'     => '用户登录',
  'file'      => 'hr_users.rrd',
  'colours'   => 'greens',
  'unit_text' => ' ',
  'ds'        => array(
    'users' => array('label' => '用户', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['mempool']['section'] = 'system';
$config['graph_types']['device']['mempool']['order'] = '0';
$config['graph_types']['device']['mempool']['descr'] = '内存的使用';
$config['graph_types']['device']['processor']['section'] = 'system';
$config['graph_types']['device']['processor']['order'] = '0';
$config['graph_types']['device']['processor']['descr'] = '处理器';
$config['graph_types']['device']['processor']['long'] = '这是在系统中的所有处理器集合图.';

$config['graph_types']['device']['storage']['section'] = 'system';
$config['graph_types']['device']['storage']['order'] = '0';
$config['graph_types']['device']['storage']['descr'] = '文件系统的使用';

$config['graph_types']['device']['ucd_cpu']['section'] = 'system';
$config['graph_types']['device']['ucd_cpu']['order'] = '0';
$config['graph_types']['device']['ucd_cpu']['descr'] = '具体的处理器';

$config['graph_types']['device']['ucd_load'] = array(
  'section'   => 'system',
  'descr'     => '平均负载',
  'file'      => 'ucd_load.rrd',
  'unit_text' => '平均负载',
  'no_mag'    => TRUE,
  'num_fmt'   => '5.2',
  'ds'        => array(
    '1min'   => array('label' => '1分钟',  'colour' => 'c5aa00', 'cdef' => '1min,100,/'),
    '5min'   => array('label' => '5分钟',  'colour' => 'ea8f00', 'cdef' => '5min,100,/'),
    '15min'  => array('label' => '15分钟', 'colour' => 'cc0000', 'cdef' => '15min,100,/')
  )
);

$config['graph_types']['device']['ucd_memory']['section'] = 'system';
$config['graph_types']['device']['ucd_memory']['order'] = '0';
$config['graph_types']['device']['ucd_memory']['descr'] = '详细的内存';
$config['graph_types']['device']['ucd_swap_io']['section'] = 'system';
$config['graph_types']['device']['ucd_swap_io']['order'] = '0';
$config['graph_types']['device']['ucd_swap_io']['descr'] = 'Swap I/O 活跃';
$config['graph_types']['device']['ucd_io']['section'] = 'system';
$config['graph_types']['device']['ucd_io']['order'] = '0';
$config['graph_types']['device']['ucd_io']['descr'] = '系统 I/O 活跃';

$config['graph_types']['device']['ucd_contexts'] = array(
  'section'   => 'system',
  'descr'     => '内容交换',
  'file'      => 'ucd_ssRawContexts.rrd',
  'colours'   => 'blues',
  'unit_text' => ' ',
  'ds'        => array(
    'value' => array('label' => '交换/秒', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['ucd_interrupts'] = array(
  'section'   => 'system',
  'descr'     => '系统中断',
  'file'      => 'ucd_ssRawInterrupts.rrd',
  'colours'   => 'reds',
  'unit_text' => ' ',
  'ds'        => array(
    'value' => array('label' => '中断/秒', 'draw' => 'AREA', 'line' => TRUE)
  )
);

$config['graph_types']['device']['uptime'] = array(
  'section'   => 'system',
  'descr'     => '设备运行时间',
  'file'      => 'uptime.rrd',
  'unit_text' => ' ',
  'ds'        => array(
    'uptime' => array('label' => '运行时长', 'draw' => 'AREA', 'line' => TRUE, 'colour' => 'c5c5c5', 'cdef' => 'uptime,86400,/', 'rra_min' => FALSE, 'rra_max' => FALSE)
  )
);

$config['graph_types']['device']['ksm_pages']['section']           = 'system';
$config['graph_types']['device']['ksm_pages']['order']             = '0';
$config['graph_types']['device']['ksm_pages']['descr']             = 'KSM共享页面';

$config['graph_types']['device']['iostat_util']['section']         = 'system';
$config['graph_types']['device']['iostat_util']['order']           = '0';
$config['graph_types']['device']['iostat_util']['descr']           = '磁盘I/O利用率';

$config['graph_types']['device']['vpdn_sessions_l2tp']['section']  = 'vpdn';
$config['graph_types']['device']['vpdn_sessions_l2tp']['order']    = '0';
$config['graph_types']['device']['vpdn_sessions_l2tp']['descr']    = 'VPDN L2TP会话';

$config['graph_types']['device']['vpdn_tunnels_l2tp']['section']   = 'vpdn';
$config['graph_types']['device']['vpdn_tunnels_l2tp']['order']     = '0';
$config['graph_types']['device']['vpdn_tunnels_l2tp']['descr']     = 'VPDN L2TP隧道';

// ALVARION-DOT11-WLAN-MIB

$config['graph_types']['device']['alvarion_events'] = array(
  'section'   => 'wireless',
  'file'      => 'alvarion-events.rrd',
  'descr'     => '网络事务',
  'colours'   => 'mixed',
  'unit_text' => '事务/秒',
  'ds'        => array(
    'TotalTxEvents'      => array('label' => '总TX',      'draw' => 'LINE'),
    'TotalRxEvents'      => array('label' => '总RX',      'draw' => 'LINE'),
    'OthersTxEvents'     => array('label' => '其它TX',      'draw' => 'LINE'),
    'RxDecryptEvents'    => array('label' => '解密RX',    'draw' => 'LINE'),
    'OverrunEvents'      => array('label' => 'Overrun',       'draw' => 'LINE'),
    'UnderrunEvents'     => array('label' => 'Underrun',      'draw' => 'LINE'),
    'DroppedFrameEvents' => array('label' => '丢帧', 'draw' => 'LINE'),
  )
);

$config['graph_types']['device']['alvarion_frames_errors'] = array(
  'section'   => 'wireless',
  'file'      => 'alvarion-frames-errors.rrd',
  'descr'     => '其它的帧错误',
  'colours'   => 'mixed',
  'unit_text' => '帧/秒',
  'ds'        => array(
    'FramesDelayedDueToS' => array('label' => '因SW重试的延迟',     'draw' => 'LINE'),
    'FramesDropped'       => array('label' => '丢弃帧',              'draw' => 'LINE'),
    'RecievedBadFrames'   => array('label' => '收到错误帧',         'draw' => 'LINE'),
    'NoOfDuplicateFrames' => array('label' => '丢弃复制帧',  'draw' => 'LINE'),
    'NoOfInternallyDisca' => array('label' => '内部丢弃MirCir', 'draw' => 'LINE'),
  )
);

$config['graph_types']['device']['alvarion_errors'] = array(
  'section'   => 'wireless',
  'file'      => 'alvarion-errors.rrd',
  'descr'     => '身份不明的信号和CRC错误',
  'colours'   => 'mixed',
  'unit_text' => '帧/秒',
  'ds'        => array(
    'PhyErrors' => array('label' => 'Phy错误', 'draw' => 'LINE'),
    'CRCErrors' => array('label' => 'CRC错误', 'draw' => 'LINE'),
  )
);

$config['graph_types']['device']['netscaler_tcp_conn']['section']  = 'netscaler_tcp';
$config['graph_types']['device']['netscaler_tcp_conn']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_conn']['descr']    = 'TCP连接数';

$config['graph_types']['device']['netscaler_tcp_bits']['section']  = 'netscaler_tcp';
$config['graph_types']['device']['netscaler_tcp_bits']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_bits']['descr']    = 'TCP流量';

$config['graph_types']['device']['netscaler_tcp_pkts']['section']  = 'netscaler_tcp';
$config['graph_types']['device']['netscaler_tcp_pkts']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_pkts']['descr']    = 'TCP数据包';

$config['graph_types']['device']['netscaler_common_errors']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '常见的错误');

$config['graph_types']['device']['netscaler_conn_client']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '客户端连接');

$config['graph_types']['device']['netscaler_conn_clientserver']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '客户端与服务器的连接');

$config['graph_types']['device']['netscaler_conn_current']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '当前连接');

$config['graph_types']['device']['netscaler_conn_server']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '服务器连接');

$config['graph_types']['device']['netscaler_conn_spare']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '多余的连接');

$config['graph_types']['device']['netscaler_conn_zombie_flushed']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '僵尸Flushed连接数');

$config['graph_types']['device']['netscaler_conn_zombie_halfclosed']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '僵尸半封闭连接');

$config['graph_types']['device']['netscaler_conn_zombie_halfopen']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '僵尸半开放连接');

$config['graph_types']['device']['netscaler_conn_zombie_packets']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '僵尸连接数据包');

$config['graph_types']['device']['netscaler_cookie_rejected']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'Cookie拒绝');

$config['graph_types']['device']['netscaler_data_errors']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '数据错误');

$config['graph_types']['device']['netscaler_out_of_order']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '排序错误');

$config['graph_types']['device']['netscaler_retransmission_error']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '转播错误');

$config['graph_types']['device']['netscaler_retransmit_err']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => '传输错误');

$config['graph_types']['device']['netscaler_rst_errors']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP RST错误');

$config['graph_types']['device']['netscaler_syn_errors']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP SYN错误');

$config['graph_types']['device']['netscaler_syn_stats']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP SYN统计');

$config['graph_types']['device']['netscaler_tcp_errretransmit']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误重发');

$config['graph_types']['device']['netscaler_tcp_errfullretransmit']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误完全转发');

$config['graph_types']['device']['netscaler_tcp_errpartialretransmit']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP部分转播错误');

$config['graph_types']['device']['netscaler_tcp_errretransmitgiveup']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误重发放弃');

$config['graph_types']['device']['netscaler_tcp_errfastretransmissions']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误快速重传');

$config['graph_types']['device']['netscaler_tcp_errxretransmissions']    = array(
                                                                'section' => 'netscaler_tcp',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误重发计数');

$config['graph_types']['device']['nsHttpRequests'] = array(
  'section'   => 'netscaler_http',
  'file'      => 'nsHttpStatsGroup.rrd',
  'descr'     => 'HTTP请求',
  'colours'   => 'mixed',
  'unit_text' => '请求/秒',
  'log_y'     => TRUE,
  'ds'        => array(
    'TotGets'   => array('label' => 'GETs',   'draw' => 'AREASTACK'),
    'TotPosts'  => array('label' => 'POSTs',  'draw' => 'AREASTACK'),
    'TotOthers' => array('label' => '其它', 'draw' => 'AREASTACK'),
  )
);

$config['graph_types']['device']['nsHttpBytes'] = array(
  'section'   => 'netscaler_http',
  'file'      => 'nsHttpStatsGroup.rrd',
  'descr'     => 'HTTP流量',
  'colours'   => 'mixed',
  'ds'        => array(
    'TotRxResponseBytes' => array('label' => '对内响应',  'cdef' => 'TotRxResponseBytes,8,*', 'draw' => 'AREA'),
    'TotTxResponseBytes' => array('label' => '对外响应', 'cdef' => 'TotRxResponseBytes,8,*', 'invert' => TRUE, 'draw' => 'AREA'),
    'TotRxRequestBytes'  => array('label' => '对内请求',  'cdef' => 'TotRxRequestBytes,8,*'),
    'TotTxRequestBytes'  => array('label' => '对外请求', 'cdef' => 'TotTxRequestBytes,8,*', 'invert' => TRUE),
  )
);

$config['graph_types']['device']['nsHttpSPDY'] = array(
  'section'   => 'netscaler_http',
  'descr'     => 'SPDY请求',
  'file'      => 'nsHttpStatsGroup.rrd',
  'colours'   => 'mixed',
  'unit_text' => '请求/秒',
  'log_y'     => TRUE,
  'ds'        => array(
    'spdy2TotStreams' => array('label' => 'SPDY请求', 'draw' => 'AREA'),
  )
);

$config['graph_types']['device']['nsCompHttpSaving'] = array(
  'section'   => 'netscaler_comp',
  'descr'     => 'TCP压缩节省的带宽',
  'file'      => 'nsCompressionStatsGroup.rrd',
  'scale_min' => '0',
  'scale_max' => '100',
  'colours'   => 'greens',
  'unit_text' => '百分比',
  'ds'        => array(
    'compHttpBandwidthS' => array ('label' => '节省', 'draw' => 'AREA'),
  )
);

$config['graph_types']['device']['nsSslTransactions'] = array(
  'section'   => 'netscaler_ssl',
  'descr'     => 'SSL数据交换',
  'file'      => 'netscaler-SslStats.rrd',
  'colours'   => 'mixed',
  'unit_text' => '数据交换/秒',
  'log_y'     => TRUE,
  'ds'        => array(
    'Transactions'      => array('label' => '合计', 'draw' => 'AREA', 'colour' => 'B0B0B0'),
    'SSLv2Transactions' => array('label' => 'SSLv2'),
    'SSLv3Transactions' => array('label' => 'SSLv3'),
    'TLSv1Transactions' => array('label' => 'TLSv1')
  )
);

$config['graph_types']['device']['netscalersvc_bits']['descr']     = '总的服务流量';
$config['graph_types']['device']['netscalersvc_pkts']['descr']     = '总的服务数据包';
$config['graph_types']['device']['netscalersvc_conns']['descr']    = '总的服务连接数';
$config['graph_types']['device']['netscalersvc_reqs']['descr']     = '总的服务请求';

$config['graph_types']['device']['netscalervsvr_bits']['descr']    = '总的vServer流量';
$config['graph_types']['device']['netscalervsvr_pkts']['descr']    = '总的vServer数据包';
$config['graph_types']['device']['netscalervsvr_conns']['descr']   = '总的vServer连接数';
$config['graph_types']['device']['netscalervsvr_reqs']['descr']    = '总的vServer请求';
$config['graph_types']['device']['netscalervsvr_hitmiss']['descr'] = '总的vServer命中/缺失';

$config['graph_types']['device']['asyncos_workq']['section'] = 'appliance';
$config['graph_types']['device']['asyncos_workq']['order'] = '0';
$config['graph_types']['device']['asyncos_workq']['descr'] = '工作队列的消息';

$config['graph_types']['device']['smokeping_in_all'] = 'This is an aggregate graph of the incoming smokeping tests to this host. The line corresponds to the average RTT. The shaded area around each line denotes the standard deviation.';

$config['graph_types']['application']['unbound_queries']['long'] = '对递归解析器DNS查询. 多余的回复可能是干净的复制数据包, 迟到的应答, 或是欺骗危险数据.';
$config['graph_types']['application']['unbound_queue']['long']   = 'The queries that did not hit the cache and need recursion service take up space in the requestlist. If there are too many queries, first queries get overwritten, and at last resort dropped.';
$config['graph_types']['application']['unbound_memory']['long']  = '使用未绑定内存.';
$config['graph_types']['application']['unbound_qtype']['long']   = '通过DNS RR型的查询.';
$config['graph_types']['application']['unbound_class']['long']   = '通过DNS RR型的类查询.';
$config['graph_types']['application']['unbound_opcode']['long']  = '查询的DNS查询包指令的操作码.';
$config['graph_types']['application']['unbound_rcode']['long']   = '返回值排序的结果. 校验RRSets每秒伪造具有明显伪造RRSets的数量.';
$config['graph_types']['application']['unbound_flags']['long']   = 'This graphs plots the flags inside incoming queries. For example, if QR, AA, TC, RA, Z flags are set, the query can be rejected. RD, AD, CD and DO are legitimately set by some software.';

$config['graph_types']['application']['bind_answers']['descr'] = 'BIND 接受的应答';
$config['graph_types']['application']['bind_query_in']['descr'] = 'BIND 传入的查询';
$config['graph_types']['application']['bind_query_out']['descr'] = 'BIND 传出的查询';
$config['graph_types']['application']['bind_query_rejected']['descr'] = 'BIND 拒绝请求';
$config['graph_types']['application']['bind_req_in']['descr'] = 'BIND 传入的请求';
$config['graph_types']['application']['bind_req_proto']['descr'] = 'BIND 请求的协议细节';
$config['graph_types']['application']['bind_resolv_dnssec']['descr'] = 'BIND DNSSEC 验证';
$config['graph_types']['application']['bind_resolv_errors']['descr'] = 'BIND 解析时的错误';
$config['graph_types']['application']['bind_resolv_queries']['descr'] = 'BIND 解析查询';
$config['graph_types']['application']['bind_resolv_rtt']['descr'] = 'BIND 解析 RTT';
$config['graph_types']['application']['bind_updates']['descr'] = 'BIND 动态更新';
$config['graph_types']['application']['bind_zone_maint']['descr'] = 'BIND Zone维护';

// Generic Firewall Graphs

$config['graph_types']['device']['firewall_sessions_ipv4']['section']  = 'firewall';
$config['graph_types']['device']['firewall_sessions_ipv4']['order']    = '0';
$config['graph_types']['device']['firewall_sessions_ipv4']['descr']    = '防火墙的会话(IPv4)';

// Blue Coat ProxySG graphs
$config['graph_types']['device']['bluecoat_http_client']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_http_client']['order']    = '0';
$config['graph_types']['device']['bluecoat_http_client']['descr']    = 'HTTP客户端连接数';
$config['graph_types']['device']['bluecoat_http_server']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_http_server']['order']    = '0';
$config['graph_types']['device']['bluecoat_http_server']['descr']    = 'HTTP服务器连接数';
$config['graph_types']['device']['bluecoat_cache']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_cache']['order']    = '0';
$config['graph_types']['device']['bluecoat_cache']['descr']    = 'HTTP缓存统计';
$config['graph_types']['device']['bluecoat_server']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_server']['order']    = '0';
$config['graph_types']['device']['bluecoat_server']['descr']    = '服务器统计';
$config['graph_types']['device']['bluecoat_tcp']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_tcp']['order']    = '0';
$config['graph_types']['device']['bluecoat_tcp']['descr']    = 'TCP连接数';
$config['graph_types']['device']['bluecoat_tcp_est']['section']  = 'proxysg';
$config['graph_types']['device']['bluecoat_tcp_est']['order']    = '0';
$config['graph_types']['device']['bluecoat_tcp_est']['descr']    = 'TCP建立的会话';

// EDAC agent script
$config['graph_types']['device']['edac_errors']['section'] = 'system';
$config['graph_types']['device']['edac_errors']['order']   = '0';
$config['graph_types']['device']['edac_errors']['descr']   = 'EDAC内存错误';
$config['graph_types']['device']['edac_errors']['long']    = '该图像显示检测到自系统启动内存控制器错误的数量(校正和未校正).';

//FIXME. Sensors descriptions same as in nicecase(), but nicecase loads after definitions
// Device - Sensors section
$config['graph_types']['device']['temperature']['descr']   = '温度';
$config['graph_types']['device']['humidity']['descr']      = '湿度';
$config['graph_types']['device']['fanspeed']['descr']      = '风速';
$config['graph_types']['device']['airflow']['descr']       = '气流';
$config['graph_types']['device']['voltage']['descr']       = '电压';
$config['graph_types']['device']['current']['descr']       = '电流';
$config['graph_types']['device']['power']['descr']         = '电力';
$config['graph_types']['device']['apower']['descr']        = '表观功率';
$config['graph_types']['device']['impedance']['descr']     = '阻抗';
$config['graph_types']['device']['frequency']['descr']     = '频率';
$config['graph_types']['device']['dbm']['descr']           = '分贝毫瓦';
$config['graph_types']['device']['snr']['descr']           = '信号噪声比';
$config['graph_types']['device']['capacity']['descr']      = '容量';
$config['graph_types']['device']['load']['descr']          = '负载';
$config['graph_types']['device']['runtime']['descr']       = '运行时间';
$config['graph_types']['device']['state']['descr']         = '状态';
$config['graph_types']['device']['toner']['descr']         = '硒鼓';

$config['graph_types']['device']['arubacontroller_numaps']['descr']   = 'AP数量';
$config['graph_types']['device']['arubacontroller_numaps']['section'] = 'wireless';
$config['graph_types']['device']['arubacontroller_numclients']['descr']   = '无线客户端';
$config['graph_types']['device']['arubacontroller_numclients']['section'] = 'wireless';

// End includes/definitions/graphtypes.inc.php
