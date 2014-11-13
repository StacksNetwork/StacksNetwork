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

$app_sections = array('system' => "系统",
                      'queries' => "查询",
                      'innodb' => "InnoDB");

$app_graphs['system'] = array(
                'mysql_connections' => '连接数',
                'mysql_status' => '进程列表',
                'mysql_files_tables' => '文件与表',
                'mysql_myisam_indexes' => 'MyISAM索引',
                'mysql_network_traffic' => '网络流量',
                'mysql_table_locks' => '数据表锁定',
                'mysql_temporary_objects' => '临时对象'
                );

$app_graphs['queries'] = array(
                'mysql_command_counters' => '指令计数器',
                'mysql_query_cache' => '查询缓存',
                'mysql_query_cache_memory' => '查询高速缓存',
                'mysql_select_types' => '选择类型',
                'mysql_slow_queries' => '慢速查询',
                'mysql_sorts' => '排列',
                );

$app_graphs['innodb'] = array(
                'mysql_innodb_buffer_pool' => 'InnoDB缓冲池',
                'mysql_innodb_buffer_pool_activity' => 'InnoDB活动的缓冲池',
                'mysql_innodb_insert_buffer' => 'InnoDB插入缓冲',
                'mysql_innodb_io' => 'InnoDB IO',
                'mysql_innodb_io_pending' => 'InnoDB IO待定',
                'mysql_innodb_log' => 'InnoDB Log',
                'mysql_innodb_row_operations' => 'InnoDB行操作',
                'mysql_innodb_semaphores' => 'InnoDB信号',
                'mysql_innodb_transactions' => 'InnoDB处理',
                );

// EOF
