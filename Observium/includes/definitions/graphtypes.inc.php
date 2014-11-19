<?php

// Graph sections is used to categorize /device/graphs/

$config['graph_sections'] = array('general', 'system', 'firewall', 'netstats', 'wireless', 'storage', 'vpdn', 'load balancer', 'appliance', 'poller', 'netapp');

// Graph types

$config['graph_types']['port']['bits']       = array('name' => 'Bits',            'descr' => "Traffic in bits/sec");
$config['graph_types']['port']['upkts']      = array('name' => 'Ucast Pkts',      'descr' => "Unicast packets/sec");
$config['graph_types']['port']['nupkts']     = array('name' => 'NU Pkts',         'descr' => "Non-unicast packets/sec");
$config['graph_types']['port']['pktsize']    = array('name' => 'Pkt Size',        'descr' => "Average packet size");
$config['graph_types']['port']['percent']    = array('name' => 'Percent',         'descr' => "Percent utilization");
$config['graph_types']['port']['errors']     = array('name' => 'Errors',          'descr' => "Errors/sec");
$config['graph_types']['port']['etherlike']  = array('name' => 'Ethernet Errors', 'descr' => "Detailed Errors/sec for Ethernet-like interfaces");
$config['graph_types']['port']['fdb_count']  = array('name' => 'FDB counts',      'descr' => "FDB count");

$config['graph_types']['device']['wifi_clients']['section'] = 'wireless';
$config['graph_types']['device']['wifi_clients']['order'] = '0';
$config['graph_types']['device']['wifi_clients']['descr'] = 'Wireless Clients';

// NetApp graphs
$config['graph_types']['device']['netapp_ops']     = array('section' => 'netapp', 'descr' => 'NetApp Operations', 'order' => '0');
$config['graph_types']['device']['netapp_net_io']  = array('section' => 'netapp', 'descr' => 'NetApp Network I/O', 'order' => '1');
$config['graph_types']['device']['netapp_disk_io'] = array('section' => 'netapp', 'descr' => 'NetApp Disk I/O', 'order' => '2');
$config['graph_types']['device']['netapp_tape_io'] = array('section' => 'netapp', 'descr' => 'NetApp Tape I/O', 'order' => '3');

// Poller graphs
$config['graph_types']['device']['poller_perf']['section'] = 'poller';
$config['graph_types']['device']['poller_perf']['order'] = '0';
$config['graph_types']['device']['poller_perf']['descr'] = 'Poller Duration';

$config['graph_types']['device']['ping']['section'] = 'poller';
$config['graph_types']['device']['ping']['order'] = '0';
$config['graph_types']['device']['ping']['descr'] = 'Ping Response';

$config['graph_types']['device']['ping_snmp']['section'] = 'poller';
$config['graph_types']['device']['ping_snmp']['order'] = '0';
$config['graph_types']['device']['ping_snmp']['descr'] = 'SNMP Response';

$config['graph_types']['device']['agent']['section'] = 'poller';
$config['graph_types']['device']['agent']['order'] = '0';
$config['graph_types']['device']['agent']['descr'] = '代理程序执行时间';

$config['graph_types']['device']['netstat_arista_sw_ip'] = array(
 'section' => 'netstats', 'order' => '0', 'descr' => "系统软件转发IPv4统计");
$config['graph_types']['device']['netstat_arista_sw_ip_frag'] = array(
 'section' => 'netstats', 'order' => '0', 'descr' => "系统软件转发IPv4碎片统计");

$config['graph_types']['device']['netstat_arista_sw_ip6'] = array(
 'section' => 'netstats', 'order' => '0', 'descr' => "系统软件转发IPv6统计");
$config['graph_types']['device']['netstat_arista_sw_ip6_frag'] = array(
 'section' => 'netstats', 'order' => '0', 'descr' => "系统软件转发IPv6碎片统计");

$config['graph_types']['device']['cipsec_flow_bits']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_bits']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_bits']['descr'] = 'IPSec隧道流量';
$config['graph_types']['device']['cipsec_flow_pkts']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_pkts']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_pkts']['descr'] = 'IPSec隧道流量数据包';
$config['graph_types']['device']['cipsec_flow_stats']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_stats']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_stats']['descr'] = 'IPSec隧道统计';
$config['graph_types']['device']['cipsec_flow_tunnels']['section'] = 'firewall';
$config['graph_types']['device']['cipsec_flow_tunnels']['order'] = '0';
$config['graph_types']['device']['cipsec_flow_tunnels']['descr'] = 'IPSec活跃隧道';
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

$config['graph_types']['device']['juniperive_users']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_users']['order'] = '0';
$config['graph_types']['device']['juniperive_users']['descr'] = '并发用户';
$config['graph_types']['device']['juniperive_meetings']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_meetings']['order'] = '0';
$config['graph_types']['device']['juniperive_meetings']['descr'] = '会议';
$config['graph_types']['device']['juniperive_connections']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_connections']['order'] = '0';
$config['graph_types']['device']['juniperive_connections']['descr'] = '连接';
$config['graph_types']['device']['juniperive_storage']['section'] = 'appliance';
$config['graph_types']['device']['juniperive_storage']['order'] = '0';
$config['graph_types']['device']['juniperive_storage']['descr'] = '存储';

$config['graph_types']['device']['bits']['section'] = 'netstats';
$config['graph_types']['device']['bits']['order'] = '0';
$config['graph_types']['device']['bits']['descr'] = '总流量';
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

$config['graph_types']['device']['netstat_tcp_stats']    	= array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP统计');

$config['graph_types']['device']['netstat_tcp_segments']    = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP段');

$config['graph_types']['device']['netstat_udp_errors']         = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'UDP错误');

$config['graph_types']['device']['netstat_udp_datagrams']    = array(
                                                                'section' => 'netstats',
                                                                'order'   => '0',
                                                                'descr'   => 'UDP数据包');

$config['graph_types']['device']['fdb_count']['section'] = 'system';
$config['graph_types']['device']['fdb_count']['order'] = '0';
$config['graph_types']['device']['fdb_count']['descr'] = 'FDB表的使用情况';
$config['graph_types']['device']['hr_processes']['section'] = 'system';
$config['graph_types']['device']['hr_processes']['order'] = '0';
$config['graph_types']['device']['hr_processes']['descr'] = '运行过程';
$config['graph_types']['device']['hr_users']['section'] = 'system';
$config['graph_types']['device']['hr_users']['order'] = '0';
$config['graph_types']['device']['hr_users']['descr'] = '用户登录';
$config['graph_types']['device']['mempool']['section'] = 'system';
$config['graph_types']['device']['mempool']['order'] = '0';
$config['graph_types']['device']['mempool']['descr'] = '内存池使用情况';
$config['graph_types']['device']['processor']['section'] = 'system';
$config['graph_types']['device']['processor']['order'] = '0';
$config['graph_types']['device']['processor']['descr'] = '处理器';
$config['graph_types']['device']['storage']['section'] = 'system';
$config['graph_types']['device']['storage']['order'] = '0';
$config['graph_types']['device']['storage']['descr'] = '文件系统使用情况';
$config['graph_types']['device']['temperature']['section'] = 'system';
$config['graph_types']['device']['temperature']['order'] = '0';
$config['graph_types']['device']['temperature']['descr'] = '温度';
$config['graph_types']['device']['ucd_cpu']['section'] = 'system';
$config['graph_types']['device']['ucd_cpu']['order'] = '0';
$config['graph_types']['device']['ucd_cpu']['descr'] = '处理器详情';
$config['graph_types']['device']['ucd_load']['section'] = 'system';
$config['graph_types']['device']['ucd_load']['order'] = '0';
$config['graph_types']['device']['ucd_load']['descr'] = '平均负载';
$config['graph_types']['device']['ucd_memory']['section'] = 'system';
$config['graph_types']['device']['ucd_memory']['order'] = '0';
$config['graph_types']['device']['ucd_memory']['descr'] = '内存详情';
$config['graph_types']['device']['ucd_swap_io']['section'] = 'system';
$config['graph_types']['device']['ucd_swap_io']['order'] = '0';
$config['graph_types']['device']['ucd_swap_io']['descr'] = 'Swap I/O 活动';
$config['graph_types']['device']['ucd_io']['section'] = 'system';
$config['graph_types']['device']['ucd_io']['order'] = '0';
$config['graph_types']['device']['ucd_io']['descr'] = 'System I/O 活动';
$config['graph_types']['device']['ucd_contexts']['section'] = 'system';
$config['graph_types']['device']['ucd_contexts']['order'] = '0';
$config['graph_types']['device']['ucd_contexts']['descr'] = '上下文转换';
$config['graph_types']['device']['ucd_interrupts']['section'] = 'system';
$config['graph_types']['device']['ucd_interrupts']['order'] = '0';
$config['graph_types']['device']['ucd_interrupts']['descr'] = '阻断';
$config['graph_types']['device']['uptime']['section'] = 'system';
$config['graph_types']['device']['uptime']['order'] = '0';
$config['graph_types']['device']['uptime']['descr'] = '系统运行时间';

$config['graph_types']['device']['ksm_pages']['section']           = 'system';
$config['graph_types']['device']['ksm_pages']['order']             = '0';
$config['graph_types']['device']['ksm_pages']['descr']             = 'KSM共享页面';

$config['graph_types']['device']['iostat_util']['section']         = 'system';
$config['graph_types']['device']['iostat_util']['order']           = '0';
$config['graph_types']['device']['iostat_util']['descr']           = '磁盘I/O利用率';

$config['graph_types']['device']['vpdn_sessions_l2tp']['section']  = 'vpdn';
$config['graph_types']['device']['vpdn_sessions_l2tp']['order']    = '0';
$config['graph_types']['device']['vpdn_sessions_l2tp']['descr']    = 'VPDN L2TP 会话';

$config['graph_types']['device']['vpdn_tunnels_l2tp']['section']   = 'vpdn';
$config['graph_types']['device']['vpdn_tunnels_l2tp']['order']     = '0';
$config['graph_types']['device']['vpdn_tunnels_l2tp']['descr']     = 'VPDN L2TP 隧道';

$config['graph_types']['device']['netscaler_tcp_conn']['section']  = 'load balancer';
$config['graph_types']['device']['netscaler_tcp_conn']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_conn']['descr']    = 'TCP连接';

$config['graph_types']['device']['netscaler_tcp_bits']['section']  = 'load balancer';
$config['graph_types']['device']['netscaler_tcp_bits']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_bits']['descr']    = 'TCP流量';

$config['graph_types']['device']['netscaler_tcp_pkts']['section']  = 'load balancer';
$config['graph_types']['device']['netscaler_tcp_pkts']['order']    = '0';
$config['graph_types']['device']['netscaler_tcp_pkts']['descr']    = 'TCP数据包';

$config['graph_types']['device']['netscaler_tcp_errretransmit']    = array(
								'section' => 'load balancer',
								'order'   => '0',
								'descr'   => 'TCP错误转发');

$config['graph_types']['device']['netscaler_tcp_errfullretransmit']    = array(
                                                                'section' => 'load balancer',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误完全转发');

$config['graph_types']['device']['netscaler_tcp_errpartialretransmit']    = array(
                                                                'section' => 'load balancer',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP部分错误转发');

$config['graph_types']['device']['netscaler_tcp_errretransmitgiveup']    = array(
                                                                'section' => 'load balancer',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP放弃错误转发');

$config['graph_types']['device']['netscaler_tcp_errfastretransmissions']    = array(
                                                                'section' => 'load balancer',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误快速转发');


$config['graph_types']['device']['netscaler_tcp_errxretransmissions']    = array(
                                                                'section' => 'load balancer',
                                                                'order'   => '0',
                                                                'descr'   => 'TCP错误转发计数');


$config['graph_types']['device']['netscalersvc_bits']['descr']     = '合计服务流量';
$config['graph_types']['device']['netscalersvc_pkts']['descr']     = '合计服务数据包';
$config['graph_types']['device']['netscalersvc_conns']['descr']    = '合计服务连接';
$config['graph_types']['device']['netscalersvc_reqs']['descr']     = '合计服务请求';

$config['graph_types']['device']['netscalervsvr_bits']['descr']    = '合计vServer流量';
$config['graph_types']['device']['netscalervsvr_pkts']['descr']    = '合计vServer数据包';
$config['graph_types']['device']['netscalervsvr_conns']['descr']   = '合计vServer连接';
$config['graph_types']['device']['netscalervsvr_reqs']['descr']    = '合计vServer请求';
$config['graph_types']['device']['netscalervsvr_hitmiss']['descr'] = '合计vServer命中/缺失';

$config['graph_types']['device']['asyncos_workq']['section'] = 'appliance';
$config['graph_types']['device']['asyncos_workq']['order'] = '0';
$config['graph_types']['device']['asyncos_workq']['descr'] = '工作队列的消息';

$config['graph_descr']['device_smokeping_in_all'] = "这是输入Smokeping测试主机集合图. 行对应于平均RTT. 在每一行的阴影区域是指标准偏差.";
$config['graph_descr']['device_processor']        = "这是在系统中的所有处理器集合图表.";

$config['graph_descr']['application_unbound_queries'] = "对递归解析器DNS查询. 多余的应答可能是无用的复制数据包, 迟到的响应, 或欺骗包.";
$config['graph_descr']['application_unbound_queue']   = "查询未命中高速缓存和递归服务在requestlist占用空间. 如果有太多的疑问, 首先查询得到重写, 并在最后关闭.";
$config['graph_descr']['application_unbound_memory']  = "内存使用未绑定.";
$config['graph_descr']['application_unbound_qtype']   = "通过DNS RR型检索查询.";
$config['graph_descr']['application_unbound_class']   = "通过DNS RR型类检索查询.";
$config['graph_descr']['application_unbound_opcode']  = "通过DNS RR型数据包检索查询.";
$config['graph_descr']['application_unbound_rcode']   = "返回值排序的响应. rrsets不是rrsets数量明显伪造的每秒的验证器.";
$config['graph_descr']['application_unbound_flags']   = "本图的图在传入的查询标志. 例如, if QR, AA, TC, RA, Z 标志设置, 查询可以拒绝. RD, AD, CD 做的一些软件的合法设置.";

$config['graph_types']['application']['bind_answers']['descr'] = 'BIND收到的应答';
$config['graph_types']['application']['bind_query_in']['descr'] = 'BIND传入的查询';
$config['graph_types']['application']['bind_query_out']['descr'] = 'BIND传出的查询';
$config['graph_types']['application']['bind_query_rejected']['descr'] = 'BIND拒绝请求';
$config['graph_types']['application']['bind_req_in']['descr'] = 'BIND传入的请求';
$config['graph_types']['application']['bind_req_proto']['descr'] = 'BIND请求的协议细节';
$config['graph_types']['application']['bind_resolv_dnssec']['descr'] = 'BIND DNSSEC验证';
$config['graph_types']['application']['bind_resolv_errors']['descr'] = 'BIND错误同时解决';
$config['graph_types']['application']['bind_resolv_queries']['descr'] = 'BIND解析查询';
$config['graph_types']['application']['bind_resolv_rtt']['descr'] = 'BIND解析RTT';
$config['graph_types']['application']['bind_updates']['descr'] = 'BIND动态更新';
$config['graph_types']['application']['bind_zone_maint']['descr'] = 'BIND区域维护';

// End includes/definitions/graphtypes.inc.php
