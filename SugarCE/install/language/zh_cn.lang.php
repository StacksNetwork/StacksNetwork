<?php
if(!defined('sugarEntry') || !sugarEntry) die('Not A Valid Entry Point');
/*********************************************************************************
 * SugarCRM is a customer relationship management program developed by
 * SugarCRM, Inc. Copyright (C) 2004-2011 SugarCRM Inc.
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Affero General Public License version 3 as published by the
 * Free Software Foundation with the addition of the following permission added
 * to Section 15 as permitted in Section 7(a): FOR ANY PART OF THE COVERED WORK
 * IN WHICH THE COPYRIGHT IS OWNED BY SUGARCRM, SUGARCRM DISCLAIMS THE WARRANTY
 * OF NON INFRINGEMENT OF THIRD PARTY RIGHTS.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU Affero General Public License along with
 * this program; if not, see http://www.gnu.org/licenses or write to the Free
 * Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301 USA.
 * 
 * You can contact SugarCRM, Inc. headquarters at 10050 North Wolfe Road,
 * SW2-130, Cupertino, CA 95014, USA. or at email address contact@sugarcrm.com.
 * 
 * The interactive user interfaces in modified source and object code versions
 * of this program must display Appropriate Legal Notices, as required under
 * Section 5 of the GNU Affero General Public License version 3.
 * 
 * In accordance with Section 7(b) of the GNU Affero General Public License version 3,
 * these Appropriate Legal Notices must retain the display of the "Powered by
 * SugarCRM" logo. If the display of the logo is not reasonably feasible for
 * technical reasons, the Appropriate Legal Notices must display the words
 * "Powered by SugarCRM".
 ********************************************************************************/

/*********************************************************************************

 * Description:
 * Portions created by SugarCRM are Copyright (C) SugarCRM, Inc. All Rights
 * Reserved. Contributor(s): SR Force China Division - SR Force InfoTech Co,. Ltd.
 * *******************************************************************************/

$mod_strings = array(

	'LBL_SYSOPTS_1'						=> '请从下列系统配置选项中选择. ',
    'LBL_SYSOPTS_2'                     => '这个STACKS®实例将采用哪种类型的数据库?',
	'LBL_SYSOPTS_CONFIG'				=> '系统配置',
	'LBL_SYSOPTS_DB_TYPE'				=> '',
	'LBL_SYSOPTS_DB'					=> '指定数据库类型',
    'LBL_SYSOPTS_DB_TITLE'              => '数据库类型',
	'LBL_SYSOPTS_ERRS_TITLE'			=> '请在继续前修复下列错误: ',
	'LBL_MAKE_DIRECTORY_WRITABLE'      => '请将下列文件夹状态更改为可写入: ',





	'DEFAULT_CHARSET'					=> 'UTF-8',
    'ERR_ADMIN_USER_NAME_BLANK'         => '请提供STACKS®管理员用户名. ',
	'ERR_ADMIN_PASS_BLANK'				=> '请提供STACKS®管理员密码. ',

    //'ERR_CHECKSYS_CALL_TIME'			=> 'Allow Call Time Pass Reference是关闭的 (请在php.ini中启用)',
    'ERR_CHECKSYS'                      => '在兼容性检查过程中发现错误. 为了使您的STACKS® CRM可以正常工作, 请修复下来问题并且点击再次检查按钮或再次安装. ',
    'ERR_CHECKSYS_CALL_TIME'            => 'Allow Call Time Pass Reference是开启的(这个选项应该在php.ini中设置为OFF)',
    'ERR_CHECKSYS_CURL'					=> '未找到: STACKS®定时任务仅有限功能可用. ',
	'ERR_CHECKSYS_FASTCGI_LOGGING'      => '为了获得IIS/FastCGI sapi最佳体验, 请在您的php.ini文件中设置fastcgi.logging为0. ',
    'ERR_CHECKSYS_IMAP'					=> '未找到: 邮件以及市场活动(邮件)需要IMAP库, 否则将不能正常工作. ',
	'ERR_CHECKSYS_MSSQL_MQGPC'			=> '当使用MS SQL数据库时,智能报价GPC不能设置为"开启". ',
	'ERR_CHECKSYS_MEM_LIMIT_0'			=> '警告: ',
	'ERR_CHECKSYS_MEM_LIMIT_1'			=> ' (在php.ini文件中设置此项到 ',
	'ERR_CHECKSYS_MEM_LIMIT_2'			=> 'M或更大',
	'ERR_CHECKSYS_MYSQL_VERSION'		=> '最近版本4.1.2 - 发现: ',
	'ERR_CHECKSYS_NO_SESSIONS'			=> '读取或写入进程变量失败.不能继续此次安装. ',
	'ERR_CHECKSYS_NOT_VALID_DIR'		=> '无效目录',
	'ERR_CHECKSYS_NOT_WRITABLE'			=> '警告: 不可写. ',
	'ERR_CHECKSYS_PHP_INVALID_VER'		=> 'STACKS®不支持您当前版本的PHP. 您需要安装STACKS®兼容的PHP版本. 请参考发布笔记中的兼容性列表. 您的版本是 ',
	'ERR_CHECKSYS_IIS_INVALID_VER'      => 'STACKS®不支持您当前的IIS版本. 您需要一个和STACKS®兼容的版本, 请参考发布笔记中的兼容性列表. 您的版本是 ',
	'ERR_CHECKSYS_FASTCGI'              => '我们检测到您目前没有使用FastCGI处理器来映射PHP. 您需要安装/配置一个适当的版本来配合Sugar应用程序. 请参考发布笔记中的兼容列表来寻找支持的版本. 请参考<a href="http://www.iis.net/php/" target="_blank">http://www.iis.net/php/</a>来获得更多帮助',
	'ERR_CHECKSYS_FASTCGI_LOGGING'      => '为了获得IIS/FastCGI sapi最佳体验, 请在您的php.ini文件中设置fastcgi.logging为0. ',
    'ERR_CHECKSYS_PHP_UNSUPPORTED'		=> '不支持当前PHP版本: (版本',
    'LBL_DB_UNAVAILABLE'                => '数据库不可用',
    'LBL_CHECKSYS_DB_SUPPORT_NOT_AVAILABLE' => '数据库支持不可用. 请确保下列支持的数据库类型中必要的驱动已经安装: MySQL, MS SQLServer, 或Oracle. 取决于您的PHP版本, 您或许可以取消在php.ini中对于对应扩展的注释, 或重新编译正确的二进制文件. 关于如何启动数据库支持请参考您的PHP手册. ',
    'LBL_CHECKSYS_XML_NOT_AVAILABLE'        => '没有发现STACKS®应用程序需要的XML解析库. 取决于您的PHP版本, 您或许可以取消在php.ini中对于对应扩展的注释, 或重新编译正确的二进制文件. 更多资料请参考您的PHP手册. ',
    'ERR_CHECKSYS_MBSTRING'             => '没有发现STACKS®应用程序需要的多字节字符串扩展(mbstring). <br/><br/>一般来说, PHP默认不启用mbstring模块并且必须使用PHP自建的库--enable-mbstring来启动. 更多管旭mbstring的支持请参考您的PHP手册. ',
    'ERR_CHECKSYS_SESSION_SAVE_PATH_NOT_SET'       => '您PHP配置文件(php.ini)中, session.save_path未设置或设置为不存在的目录. 您需要在php.inin中设置save_path或验证php.ini中所设置的save_path文件夹存在. ',
    'ERR_CHECKSYS_SESSION_SAVE_PATH_NOT_WRITABLE'  => '您PHP配置文件(php.ini)中, session.save_path文件夹不可写. 请设置其为可写. <br>取决于您的操作系统, 这可能需要您运行chmod 766来设置权限或右键查看属性来取消只读选项. ',
    'ERR_CHECKSYS_CONFIG_NOT_WRITABLE'  => '配置文件存在但不可写, 请确保这个文件可写. 取决于您的操作系统, 这可能需要您运行chmod 766来设置权限或右键查看属性来取消只读选项. ',
    'ERR_CHECKSYS_CUSTOM_NOT_WRITABLE'  => '自定义文件存在, 但不可写. 取决于您的操作系统, 您可能需要对它更改权限(chmod 766)或右键查看属性来取消只读选项. ',
    'ERR_CHECKSYS_FILES_NOT_WRITABLE'   => "下列文件或文件夹不可写或不存在并且不能被建立. 取决于您的操作系统, 修正这些或许需要您修改文件或目录的权限(chmod 766), 或右键查看属性来取消只读选项. ",
	//'ERR_CHECKSYS_SAFE_MODE'			=> '安全模式已打开(请在php.ini中禁用)',
	'ERR_CHECKSYS_SAFE_MODE'			=> '安全模式已打开(请在php.ini中禁用)',
    'ERR_CHECKSYS_ZLIB'					=> '未找到ZLib支持: STACKS® CRM使用zlib压缩来提高表现. ',
    'ERR_CHECKSYS_ZIP'					=> '未找到ZIP支持: STACKS® CRM需要ZIP支持来处理压缩文件. ',
	'ERR_DB_ADMIN'						=> '提供的数据库管理员用户或密码无效, 数据库连接无法建立. 请输入有效的用户名密码. (错误:  ',
    'ERR_DB_ADMIN_MSSQL'                => '提供的数据库管理员用户或密码无效, 数据库连接无法建立. 请输入有效的用户名密码. ',
	'ERR_DB_EXISTS_NOT'					=> '指定的数据库不存在. ',
	'ERR_DB_EXISTS_WITH_CONFIG'			=> '数据库配置已存在. 使用已选数据库进行安装, 请重新运行安装并且选择: "放弃并重建已存在的SugarCRM表: "  如需升级, 请使用管理员控制面板. 请点击<a href="http://www.sugarforge.org/content/downloads/" target="_new">这里</a>阅读升级文档. ',
	'ERR_DB_EXISTS'						=> '提供的数据库名已存在 -- 不能建立相同名字的数据库. ',
    'ERR_DB_EXISTS_PROCEED'             => '提供的数据库名已存在. 您可以<br>1. 点击返回按钮并选择一个新的数据库名 <br>2. 点击下一步并且继续, 但是所有已存在的该数据库内的表将被删除. <strong>这意味着您的表和数据将被删除. </strong>',
	'ERR_DB_HOSTNAME'					=> '主机名不能为空. ',
	'ERR_DB_INVALID'					=> '数据库类型选择无效. ',
	'ERR_DB_LOGIN_FAILURE_MYSQL'		=> '提供的数据库主机, 用户名或密码无效, 与数据库的连接不能被建立. 请输入一个有效的主机名, 用户名或密码. ',
	'ERR_DB_LOGIN_FAILURE_MSSQL'		=> '提供的数据库主机, 用户名或密码无效, 与数据库的连接不能被建立. 请输入一个有效的主机名, 用户名或密码. ',
	'ERR_DB_MYSQL_VERSION1'				=> '您的MySQL版本(',
	'ERR_DB_MYSQL_VERSION2'				=> ') 不被STACKS®支持. 您需要安装一个与Sugar兼容的版本. 请参考发布笔记中兼容的MySQL版本. ',
	'ERR_DB_NAME'						=> '数据库名不能为空. ',
	'ERR_DB_NAME2'						=> "数据库名不能包含'\\', '/',或'.'",
	'ERR_DB_MSSQL_DB_NAME_INVALID'     => "数据库名不能包含'\"', \"'\", '*', '/', '\', '?', ':', '<', '>', 或'-'",
	'ERR_DB_PASSWORD'					=> '提供的密码与STACKS®数据库管理员密码不匹配, 请在密码处输入同样的密码. ',
	'ERR_DB_PRIV_USER'					=> '请提供一个数据库管理员用户名. 起始数据库连接需要这样一个用户. ',
	'ERR_DB_USER_EXISTS'				=> 'STACKS®数据库用户名已存在 -- 不能新建同样用户名. 请输入一个新的用户名. ',
	'ERR_DB_USER'						=> '请属于一个用户名作为STACKS®数据库管理员. ',
	'ERR_DBCONF_VALIDATION'				=> '请在继续前修复下列错误: ',
    'ERR_DBCONF_PASSWORD_MISMATCH'      => '已提供的STACKS®数据库用户密码不匹配. 请在密码处输入相同的密码. ',
	'ERR_ERROR_GENERAL'					=> '下列错误已发生: ',
	'ERR_LANG_CANNOT_DELETE_FILE'		=> '不可删除文件: ',
	'ERR_LANG_MISSING_FILE'				=> '找不到文件: ',
	'ERR_LANG_NO_LANG_FILE'			 	=> '在include/language文件夹未找到语言文件: ',
	'ERR_LANG_UPLOAD_1'					=> '您上传的文件发生错误. 请重试. ',
	'ERR_LANG_UPLOAD_2'					=> '语言包必须是ZIP压缩文件. ',
	'ERR_LANG_UPLOAD_3'					=> 'PHP不能将临时文件移动至升级目录. ',
	'ERR_LICENSE_MISSING'				=> '缺少必填项',
	'ERR_LICENSE_NOT_FOUND'				=> '未找到授权文件！',
	'ERR_LOG_DIRECTORY_NOT_EXISTS'		=> '提供的日志文件目录不是有效目录. ',
	'ERR_LOG_DIRECTORY_NOT_WRITABLE'	=> '提供的日志文件目录不可写. ',
	'ERR_LOG_DIRECTORY_REQUIRED'		=> '如果您希望指定您自己的日志文件目录, 日志文件目录不能为空. ',
	'ERR_NO_DIRECT_SCRIPT'				=> '无法直接处理脚本. ',
	'ERR_NO_SINGLE_QUOTE'				=> '不可以使用单引号用于 ',
	'ERR_PASSWORD_MISMATCH'				=> '提供的STACKS®管理员用户密码不匹配. 请重新输入相同的密码. ',
	'ERR_PERFORM_CONFIG_PHP_1'			=> '不能写入<span class=stop>config.php</span>文件. ',
	'ERR_PERFORM_CONFIG_PHP_2'			=> '您可以继续此次安装, 手动创建config.php, 并且复制下面的配置信息至config.php文件. 无论如何, 在进行下一步之前, 您<strong>必须</strong>创建config.php文件. ',
	'ERR_PERFORM_CONFIG_PHP_3'			=> '您是否记得创建config.php文件?',
	'ERR_PERFORM_CONFIG_PHP_4'			=> '警告: 不能写入config.php文件. 请确保它存在. ',
	'ERR_PERFORM_HTACCESS_1'			=> '不能写入 ',
	'ERR_PERFORM_HTACCESS_2'			=> ' 文件. ',
	'ERR_PERFORM_HTACCESS_3'			=> '如果您希望安全存放您的日志文件, 防止通过浏览器的访问, 在您的日志文件目录建立一个.htaccess文件并包含这行:',
	'ERR_PERFORM_NO_TCPIP'				=> '<b>我们不能检测到有效的网络连接. </b> 当您有一个有效连接时, 请访问<a href="http://www.sugarcrm.com/home/index.php?option=com_extended_registration&task=register">http://www.sugarcrm.com/home/index.php?option=com_extended_registration&task=register</a> 来与SugarCRM注册. 并且让我们了解您的企业怎样使用SugarCRM, 让我们确保我们能够为您的商业需求提供正确的应用程序. ',
	'ERR_SESSION_DIRECTORY_NOT_EXISTS'	=> '会话目录不是有效目录. ',
	'ERR_SESSION_DIRECTORY'				=> '会话目录不可写. ',
	'ERR_SESSION_PATH'					=> '如果您希望指定您自己的Session路径, Session路径必填. ',
	'ERR_SI_NO_CONFIG'					=> '您未在文档根目录中包含config_si.php或您没有在config.php中定义$sugar_config_si',
	'ERR_SITE_GUID'						=> '如果您需要定义您自己的应用ID, 应用ID必填. ',
	'ERR_UPLOAD_MAX_FILESIZE'			=> '警告: 您的PHP设置应该修改为允许至少6MB的文件被上传. ',
    'LBL_UPLOAD_MAX_FILESIZE_TITLE'     => '上传文件尺寸',
	'ERR_URL_BLANK'						=> '提供STACKS®实例的根URL, ',
	'ERR_UW_NO_UPDATE_RECORD'			=> '未能寻找到安装记录给',
	'ERROR_FLAVOR_INCOMPATIBLE'			=> '上传的文件与STACKS®版本不兼容(社区版, 专业版或企业版): ',
	'ERROR_LICENSE_EXPIRED'				=> "错误: 您的授权已过期 ",
	'ERROR_LICENSE_EXPIRED2'			=> " 天前. 请前往位于管理员界面的<a href='index.php?action=LicenseSettings&module=Administration'>'\"授权管理\"</a> 来输入您的新授权. 如果您在授权过期30天内不输入新的授权, 您将不能登陆您的系统. ",
	'ERROR_MANIFEST_TYPE'				=> '清单文件中必须制定包裹类别. ',
	'ERROR_PACKAGE_TYPE'				=> '清单文件显示不能认可的包裹类别',
	'ERROR_VALIDATION_EXPIRED'			=> "错误: 您的验证码过期 ",
	'ERROR_VALIDATION_EXPIRED2'			=> " 天. 请前往位于管理员页面的 <a href='index.php?action=LicenseSettings&module=Administration'>'\"授权管理\"</a> 来输入您的新验证码. 如果您在30天内不输入新的验证码, 您将无法登陆到您的系统. ",
	'ERROR_VERSION_INCOMPATIBLE'		=> '上传的文件与您的STACKS®版本不兼容: ',

	'LBL_BACK'							=> '返回',
    'LBL_CANCEL'                        => '取消',
    'LBL_ACCEPT'                        => '我接受',
	'LBL_CHECKSYS_1'					=> '为了让您的STACKS® CRM正常运行, 请确保所有的系统检查项目是绿色的. 如果出现任何红色. 请采取适当的手段来修复他们. <BR><BR> 如需要在系统检查方面的帮助, 请访问<a href="http://www.sugarcrm.com/crm/installation" target="_blank">Sugar百科</a>.',
	'LBL_CHECKSYS_CACHE'				=> '可写的缓存子目录',
	//'LBL_CHECKSYS_CALL_TIME'			=> 'PHP Allow Call Time Pass Reference已开启',
    'LBL_DROP_DB_CONFIRM'               => '提供的数据库名已存在. <br>您可以选择: <br>1. 点击取消按钮并且选择一个新的数据库名称,  或 <br>2.  点击接受并继续. 所有的已存在表和数据将被删除.  <strong>这意味着所有的表和已有数据将被删除. </strong>',
	'LBL_CHECKSYS_CALL_TIME'			=> 'PHP Allow Call Time Pass Reference已关闭',
    'LBL_CHECKSYS_COMPONENT'			=> '组件',
	'LBL_CHECKSYS_COMPONENT_OPTIONAL'	=> '可选组件',
	'LBL_CHECKSYS_CONFIG'				=> '可写的STACKS® CRM配置文件(config.php)',
	'LBL_CHECKSYS_CURL'					=> 'cURL模块',
    'LBL_CHECKSYS_SESSION_SAVE_PATH'    => '会话保存路径设置',
	'LBL_CHECKSYS_CUSTOM'				=> '可写的自定义目录',
	'LBL_CHECKSYS_DATA'					=> '可写的数据子目录',
	'LBL_CHECKSYS_IMAP'					=> 'IMAP模块',
	'LBL_CHECKSYS_FASTCGI'             => 'FastCGI',
	'LBL_CHECKSYS_MQGPC'				=> '智能报价GPC',
	'LBL_CHECKSYS_MBSTRING'				=> 'MB Strings 模块',
	'LBL_CHECKSYS_MEM_OK'				=> 'OK (无限制)',
	'LBL_CHECKSYS_MEM_UNLIMITED'		=> 'OK (无限制)',
	'LBL_CHECKSYS_MEM'					=> 'PHP Memory限制',
	'LBL_CHECKSYS_MODULE'				=> '可写模块子目录以及文件',
	'LBL_CHECKSYS_MYSQL_VERSION'		=> 'MySQL版本',
	'LBL_CHECKSYS_NOT_AVAILABLE'		=> '不可用',
	'LBL_CHECKSYS_OK'					=> 'OK',
	'LBL_CHECKSYS_PHP_INI'				=> '您的PHP配置文件为位置(php.ini):',
	'LBL_CHECKSYS_PHP_OK'				=> 'OK (版本 ',
	'LBL_CHECKSYS_PHPVER'				=> 'PHP版本',
    'LBL_CHECKSYS_IISVER'               => 'IIS版本',
    'LBL_CHECKSYS_FASTCGI'              => 'FastCGI',
	'LBL_CHECKSYS_RECHECK'				=> '重新检查',
	'LBL_CHECKSYS_SAFE_MODE'			=> 'PHP 全模式已关闭',
	'LBL_CHECKSYS_SESSION'				=> 'Session保存路径可写 (',
	'LBL_CHECKSYS_STATUS'				=> '状态',
	'LBL_CHECKSYS_TITLE'				=> '系统检查接受',
	'LBL_CHECKSYS_VER'					=> '找到: ( 版本 ',
	'LBL_CHECKSYS_XML'					=> 'XML解析',
	'LBL_CHECKSYS_ZLIB'					=> 'ZLIB压缩模块',
	'LBL_CHECKSYS_ZIP'					=> 'ZIP处理模块',
	'LBL_CHECKSYS_FIX_FILES'            => '请在进行前修复下列文件或目录: ',
    'LBL_CHECKSYS_FIX_MODULE_FILES'     => '请在进行前修复下面模块目录以及文件: ',
    'LBL_CLOSE'							=> '关闭',
    'LBL_THREE'                         => '3',
	'LBL_CONFIRM_BE_CREATED'			=> '被生成',
	'LBL_CONFIRM_DB_TYPE'				=> '数据库类型',
	'LBL_CONFIRM_DIRECTIONS'			=> '请确认下列设置. 如果您需要更改任何设置, 请点击"返回"并编辑. 或点击"下一步"继续安装. ',
	'LBL_CONFIRM_LICENSE_TITLE'			=> '授权信息',
	'LBL_CONFIRM_NOT'					=> '不',
	'LBL_CONFIRM_TITLE'					=> '确认设置',
	'LBL_CONFIRM_WILL'					=> '将',
	'LBL_DBCONF_CREATE_DB'				=> '创建数据库',
	'LBL_DBCONF_CREATE_USER'			=> '创建用户',
	'LBL_DBCONF_DB_DROP_CREATE_WARN'	=> '注意: 如果这里被选择<br>所有数据将被清除. ',
	'LBL_DBCONF_DB_DROP_CREATE'			=> '放弃以及重建已有STACKS®表?',
    'LBL_DBCONF_DB_DROP'                => '放弃表',
	'LBL_DBCONF_DB_NAME'				=> '数据库名',
	'LBL_DBCONF_DB_PASSWORD'			=> 'STACKS®数据库用户密码',
	'LBL_DBCONF_DB_PASSWORD2'			=> '重新输入STACKS®数据库用户名密码',
	'LBL_DBCONF_DB_USER'				=> 'STACKS®数据库用户名',
    'LBL_DBCONF_SUGAR_DB_USER'          => 'STACKS®数据库用户名',
    'LBL_DBCONF_DB_ADMIN_USER'          => '数据库管理员用户名',
    'LBL_DBCONF_DB_ADMIN_PASSWORD'      => '数据库管理员密码',
	'LBL_DBCONF_DEMO_DATA'				=> '填充演示数据?',
    'LBL_DBCONF_DEMO_DATA_TITLE'              => '选择演示数据',
	'LBL_DBCONF_HOST_NAME'				=> '主机名',
    'LBL_DBCONF_HOST_NAME_MSSQL'        => '主机名 \ 主机实例',
	'LBL_DBCONF_INSTRUCTIONS'			=> '请在下面输入您的数据库配置信息. 如果您不确定填入什么信息, 我们建议您保持默认值. ',
	'LBL_DBCONF_MB_DEMO_DATA'			=> '在演示数据中使用多字节内容?',
    'LBL_DBCONFIG_MSG2'                 => '数据库所在的Web服务器名称或主机. (比如 localhost或www.mydomain.com): ',
    'LBL_DBCONFIG_MSG3'                 => '您准备将STACKS®安装至的数据库名: ',
    'LBL_DBCONFIG_B_MSG1'               => '为了设置STACKS®数据库. 我们需要一个有建立数据库表以及写入数据库权限的数据库管理员用户名以及密码. ',
    'LBL_DBCONFIG_SECURITY'             => '为了安全原因, 您可以指定一个独立的数据库用户来连接Sugar数据库. 为了此次安装, 这个用户必须能够对Sugar数据库能够写入, 更新以及获得数据. 这个用户可以是上面指定的数据库管理员, 或者您可以提供一个新的或已有的数据库用户信息. ',
    'LBL_DBCONFIG_AUTO_DD'              => '请帮我执行',
    'LBL_DBCONFIG_PROVIDE_DD'           => '提供已存在用户',
    'LBL_DBCONFIG_CREATE_DD'            => '定义要创建的用户',
    'LBL_DBCONFIG_SAME_DD'              => '与管理员用户相同',
	//'LBL_DBCONF_I18NFIX'              => '对多字节数据为可变长字节以及字符类型(最大255字节)实施数据库列表扩展?',
    'LBL_MSSQL_FTS'                     => '全文本搜索',
    'LBL_MSSQL_FTS_INSTALLED'           => '已安装',
    'LBL_MSSQL_FTS_INSTALLED_ERR1'      => '全文本搜索功能未被安装. ',
    'LBL_MSSQL_FTS_INSTALLED_ERR2'      => '您依然可以安装但是不能够使用全文本搜索功能除非您重新安装SQL服务器并且启用全文本搜索. 请参考SQL服务器手册或联系您的系统管理员. ',
	'LBL_DBCONF_PRIV_PASS'				=> '特权数据库用户密码',
	'LBL_DBCONF_PRIV_USER_2'			=> '上面的数据库账户是否为特权用户?',
	'LBL_DBCONF_PRIV_USER_DIRECTIONS'	=> '这个特权用户必须有权限来创建数据库, 创建/删除表, 以及创建用户. 这个特权数据库用户只会被用于安装过程中执行这些任务. 您可以使用和上面一样的数据库用户如果该用户拥有足够权限. ',
	'LBL_DBCONF_PRIV_USER'				=> '特权数据库用户名',
	'LBL_DBCONF_TITLE'					=> '数据库配置',
    'LBL_DBCONF_TITLE_NAME'             => '提供数据库名',
    'LBL_DBCONF_TITLE_USER_INFO'        => '提供数据库用户信息',
	'LBL_DISABLED_DESCRIPTION_2'		=> '这项修改生效之后, 您可以点击下面的"开始"按钮来开始安装. <i>当安装完成后, 您或许想将\'installer_locked\'的值改动至\'true\'. </i>',
	'LBL_DISABLED_DESCRIPTION'			=> '安装任务已经进行过一次. 为了安全考虑, 它被禁止运行第二次. 如果您很确定您需要再次运行, 请打开您的config.php并找到(或增加)一个变量叫做\'installer_locked\'并设置为\'false\'.这一行应该看起来这样: ',
	'LBL_DISABLED_HELP_1'				=> '安装帮助, 请访问STACKS® CRM中文论坛',
    'LBL_DISABLED_HELP_LNK'               => 'http://www.sugar360.cn',
	'LBL_DISABLED_HELP_2'				=> '支持论坛',
	'LBL_DISABLED_TITLE_2'				=> 'STACKS® CRM安装已经被禁止',
	'LBL_DISABLED_TITLE'				=> 'STACKS® CRM安装被禁止',
	'LBL_EMAIL_CHARSET_DESC'			=> '您语言环境最常用的字符集',
	'LBL_EMAIL_CHARSET_TITLE'			=> '外出邮件设置',
    'LBL_EMAIL_CHARSET_CONF'            => '外出邮件字符集',
	'LBL_HELP'							=> '帮助',
    'LBL_INSTALL'                       => '安装',
    'LBL_INSTALL_TYPE_TITLE'            => '安装选项',
    'LBL_INSTALL_TYPE_SUBTITLE'         => '选择安装类型',
    'LBL_INSTALL_TYPE_TYPICAL'          => ' <b>典型安装</b>',
    'LBL_INSTALL_TYPE_CUSTOM'           => ' <b>自定义安装</b>',
    'LBL_INSTALL_TYPE_MSG1'             => '系统的正常功能运作需要密匙, 但是在安装过程中不需要. 您现在不需要输入密匙, 但是您将需要在完成安装后提供密匙. ',
    'LBL_INSTALL_TYPE_MSG2'             => '安装过程需要的信息最少, 建议新用户使用. ',
    'LBL_INSTALL_TYPE_MSG3'             => '安装过程中提供额外选项, 这些选项在安装之后也可以从管理员页面设置. 建议高级用户使用. ',
	'LBL_LANG_1'						=> '如需使用默认语言(us-en)以外的语言, 您可以现在上传并安装语言包. 您也可以稍后从STACKS®应用程序上传并安装语言包. 如果您想跳过此过程, 请点击下一步. ',
	'LBL_LANG_BUTTON_COMMIT'			=> '安装',
	'LBL_LANG_BUTTON_REMOVE'			=> '删除',
	'LBL_LANG_BUTTON_UNINSTALL'			=> '卸载',
	'LBL_LANG_BUTTON_UPLOAD'			=> '上传',
	'LBL_LANG_NO_PACKS'					=> '无',
	'LBL_LANG_PACK_INSTALLED'			=> '下列语言包已经被安装:  ',
	'LBL_LANG_PACK_READY'				=> '下列语言包做好安装准备:  ',
	'LBL_LANG_SUCCESS'					=> '语言包已经成功上传. ',
	'LBL_LANG_TITLE'			   		=> '语言包',
    'LBL_LAUNCHING_SILENT_INSTALL'     => '正在安装STACKS®, 也许会需要几分钟来完成. ',
	'LBL_LANG_UPLOAD'					=> '上传一个语言包',
	'LBL_LICENSE_ACCEPTANCE'			=> '接受协议',
    'LBL_LICENSE_CHECKING'              => '正在检查系统兼容性. ',
    'LBL_LICENSE_CHKENV_HEADER'         => '检查环境',
    'LBL_LICENSE_CHKDB_HEADER'          => '正在检查数据库身份验证. ',
    'LBL_LICENSE_CHECK_PASSED'          => '系统通过兼容性测试. ',
    'LBL_LICENSE_REDIRECT'              => '页面即将跳转 ',
	'LBL_LICENSE_DIRECTIONS'			=> '如果您有授权信息, 请在下面输入. ',
	'LBL_LICENSE_DOWNLOAD_KEY'			=> '输入下载密匙',
	'LBL_LICENSE_EXPIRY'				=> '失效日期',
	'LBL_LICENSE_I_ACCEPT'				=> '我接受',
	'LBL_LICENSE_NUM_USERS'				=> '用户数量',
	'LBL_LICENSE_OC_DIRECTIONS'			=> '请输入已购买的离线客户端数量. ',
	'LBL_LICENSE_OC_NUM'				=> '离线客户端授权数量',
	'LBL_LICENSE_OC'					=> '历险客户端授权',
	'LBL_LICENSE_PRINTABLE'				=> ' 打印视图 ',
    'LBL_PRINT_SUMM'                    => '打印摘要',
	'LBL_LICENSE_TITLE_2'				=> 'STACKS® CRM授权',
	'LBL_LICENSE_TITLE'					=> '授权信息',
	'LBL_LICENSE_USERS'					=> '授权用户',

	'LBL_LOCALE_CURRENCY'				=> '货币设置',
	'LBL_LOCALE_CURR_DEFAULT'			=> '默认货币',
	'LBL_LOCALE_CURR_SYMBOL'			=> '货币符号',
	'LBL_LOCALE_CURR_ISO'				=> '货币代码(ISO 4217)',
	'LBL_LOCALE_CURR_1000S'				=> '千位分隔符',
	'LBL_LOCALE_CURR_DECIMAL'			=> '小数分隔符',
	'LBL_LOCALE_CURR_EXAMPLE'			=> '例子',
	'LBL_LOCALE_CURR_SIG_DIGITS'		=> '有效数字',
	'LBL_LOCALE_DATEF'					=> '默认日期格式',
	'LBL_LOCALE_DESC'					=> '这里设置的STACKS®本地化设置将对整个应用生效. ',
	'LBL_LOCALE_EXPORT'					=> '导入/到处字符集<br> <i>(邮件, .csv, vCard, PDF, 数据导入)</i>',
	'LBL_LOCALE_EXPORT_DELIMITER'		=> '导出(.csv)分隔符',
	'LBL_LOCALE_EXPORT_TITLE'			=> '导入/到处设置',
	'LBL_LOCALE_LANG'					=> '默认语言',
	'LBL_LOCALE_NAMEF'					=> '默认姓名格式',
	'LBL_LOCALE_NAMEF_DESC'				=> 's = 称谓<br />f = 名<br />l = 姓',
	'LBL_LOCALE_NAME_FIRST'				=> '小多',
	'LBL_LOCALE_NAME_LAST'				=> '李',
	'LBL_LOCALE_NAME_SALUTATION'		=> '博士',
	'LBL_LOCALE_TIMEF'					=> '默认时间格式',
	'LBL_LOCALE_TITLE'					=> '本地化设置',
    'LBL_CUSTOMIZE_LOCALE'              => '定制本地化设置',
	'LBL_LOCALE_UI'						=> '用户界面',

	'LBL_ML_ACTION'						=> '操作',
	'LBL_ML_DESCRIPTION'				=> '描述',
	'LBL_ML_INSTALLED'					=> '安装日期',
	'LBL_ML_NAME'						=> '名称',
	'LBL_ML_PUBLISHED'					=> '发布日期',
	'LBL_ML_TYPE'						=> '类型',
	'LBL_ML_UNINSTALLABLE'				=> '可卸载',
	'LBL_ML_VERSION'					=> '版本',
	'LBL_MSSQL'							=> 'SQL服务器',
	'LBL_MSSQL2'                        => 'SQL服务器(FreeTDS)',
	'LBL_MYSQL'							=> 'MySQL',
	'LBL_NEXT'							=> '下一步',
	'LBL_NO'							=> '否',
	'LBL_ORACLE'						=> 'Oracle',
	'LBL_PERFORM_ADMIN_PASSWORD'		=> '正在设置站点管理员密码',
	'LBL_PERFORM_AUDIT_TABLE'			=> '审计表 / ',
	'LBL_PERFORM_CONFIG_PHP'			=> '正创建Sugar配置文件',
	'LBL_PERFORM_CREATE_DB_1'			=> '<b>正生成数据库</b> ',
	'LBL_PERFORM_CREATE_DB_2'			=> ' <b>开启</b> ',
	'LBL_PERFORM_CREATE_DB_USER'		=> '正生成数据库用户名和密码...',
	'LBL_PERFORM_CREATE_DEFAULT'		=> '正生成默认STACKS®数据',
	'LBL_PERFORM_CREATE_LOCALHOST'		=> '正为localhost创建数据库用户名和密码...',
	'LBL_PERFORM_CREATE_RELATIONSHIPS'	=> '正创建STACKS®关系表',
	'LBL_PERFORM_CREATING'				=> '正创建 / ',
	'LBL_PERFORM_DEFAULT_REPORTS'		=> '正生成默认报表',
	'LBL_PERFORM_DEFAULT_SCHEDULER'		=> '正创建默认定时任务',
	'LBL_PERFORM_DEFAULT_SETTINGS'		=> '正插入默认设置',
	'LBL_PERFORM_DEFAULT_USERS'			=> '正生成默认用户',
	'LBL_PERFORM_DEMO_DATA'				=> '正在填充演示数据 ( 这可能会花一些时间 )',
	'LBL_PERFORM_DONE'					=> '完成<br>',
	'LBL_PERFORM_DROPPING'				=> '正放弃 / ',
	'LBL_PERFORM_FINISH'				=> '完成',
	'LBL_PERFORM_LICENSE_SETTINGS'		=> '更新授权信息',
	'LBL_PERFORM_OUTRO_1'				=> 'STACKS®安装 ',
	'LBL_PERFORM_OUTRO_2'				=> ' 已完成！',
	'LBL_PERFORM_OUTRO_3'				=> '总时间: ',
	'LBL_PERFORM_OUTRO_4'				=> ' 秒. ',
	'LBL_PERFORM_OUTRO_5'				=> '大约内存使用:  ',
	'LBL_PERFORM_OUTRO_6'				=> ' 字节. ',
	'LBL_PERFORM_OUTRO_7'				=> '您的系统已经完成安装和配置, 可以使用了. ',
	'LBL_PERFORM_REL_META'				=> '关系meta ... ',
	'LBL_PERFORM_SUCCESS'				=> '成功！',
	'LBL_PERFORM_TABLES'				=> '正创建STACKS®数据表以及数据表关系meta数据',
	'LBL_PERFORM_TITLE'					=> '执行安装',
	'LBL_PRINT'							=> '打印',
	'LBL_REG_CONF_1'					=> '请完成下面的表单来获得来自STACKS® CRM的定期产品更新, 培训新闻, 优惠以及特殊活动邀请. 我们绝对不会将采集来的数据租, 借或卖给第三方. ',
	'LBL_REG_CONF_2'					=> '只有您的名字和邮件地址是必填项, 其他所有字段都是选填项, 但是对我们很有帮助. 我们绝对不会将采集来的数据租, 借或卖给第三方. ',
	'LBL_REG_CONF_3'					=> '感谢您的注册. 点击完成按钮来登录到您的STACKS® CRM. 您需要使用用户名admin以及在第二步所指定的密码来登录. ',
	'LBL_REG_TITLE'						=> '注册',
    'LBL_REG_NO_THANKS'                 => '不, 谢谢',
    'LBL_REG_SKIP_THIS_STEP'            => '跳过这一步',
	'LBL_REQUIRED'						=> '* 必填项',

    'LBL_SITECFG_ADMIN_Name'            => 'STACKS®管理员名字',
	'LBL_SITECFG_ADMIN_PASS_2'			=> '重新输入STACKS®管理员用户密码',
	'LBL_SITECFG_ADMIN_PASS_WARN'		=> '注意: 这将覆盖之前任何安装过程中的管理员密码. ',
	'LBL_SITECFG_ADMIN_PASS'			=> 'STACKS®管理员用户密码',
	'LBL_SITECFG_APP_ID'				=> '应用ID',
	'LBL_SITECFG_CUSTOM_ID_DIRECTIONS'	=> '如选, 您必须提供一个应用ID来覆盖默认的自动生成ID. 这个ID保证STACKS® CRM的Session不被其他程序所占用. 如果您是Sugar集群安装, 他们必须共享相同的应用ID. ',
	'LBL_SITECFG_CUSTOM_ID'				=> '请提供您自己的应用ID',
	'LBL_SITECFG_CUSTOM_LOG_DIRECTIONS'	=> '如选, 您必须指定一个日志文件目录来覆盖默认目录来存储STACKS®日志. 不管日志文件在哪里保存, 通过浏览器的访问都应该通过.htaccess转向来禁止. ',
	'LBL_SITECFG_CUSTOM_LOG'			=> '使用自定义日志文件夹',
	'LBL_SITECFG_CUSTOM_SESSION_DIRECTIONS'	=> '如选, 您必须提供一个安全的目录来存放STACKS® Session信息. 这可以保证您的Session数据在共享服务器上的安全. ',
	'LBL_SITECFG_CUSTOM_SESSION'		=> '试用自定义Session目录',
	'LBL_SITECFG_DIRECTIONS'			=> '请在下面输入您的站点配置信息. 如果您不确定, 建议保留默认设置. ',
	'LBL_SITECFG_FIX_ERRORS'			=> '<b>请在继续进行前修复下面这些错误: </b>',
	'LBL_SITECFG_LOG_DIR'				=> '日志目录',
	'LBL_SITECFG_SESSION_PATH'			=> 'Session文件夹路径<br>(必须可写)',
	'LBL_SITECFG_SITE_SECURITY'			=> '选择安全选项',
	'LBL_SITECFG_SUGAR_UP_DIRECTIONS'	=> '如选, 系统将自动定期检查更新. ',
	'LBL_SITECFG_SUGAR_UP'				=> '是否自动检查更新?',
	'LBL_SITECFG_SUGAR_UPDATES'			=> 'Sugar升级配置',
	'LBL_SITECFG_TITLE'					=> '站点配置',
    'LBL_SITECFG_TITLE2'                => '识别管理员用户',
    'LBL_SITECFG_SECURITY_TITLE'        => '站点安全',
	'LBL_SITECFG_URL'					=> 'STACKS®实例URL',
	'LBL_SITECFG_USE_DEFAULTS'			=> '使用默认?',
	'LBL_SITECFG_ANONSTATS'             => '发送匿名统计数据?',
	'LBL_SITECFG_ANONSTATS_DIRECTIONS'  => '如选, 每次STACKS®检查更新时将会发送<b>匿名</b>统计数据回研发中心. 这些数据将会帮助我们更好的理解您对软件的使用并且帮助我们改善产品. ',
    'LBL_SITECFG_URL_MSG'               => '请输入安装完成后将用来访问STACKS®的URL.  这个URL同时将被用于STACKS®的根目录. 这个URL应该包含Web服务器, 主机名或IP地址. ',
    'LBL_SITECFG_SYS_NAME_MSG'          => '输入您的系统名称. 这个名称将在用户访问SugarcRM时显示在您系统的标题栏. ',
    'LBL_SITECFG_PASSWORD_MSG'          => '安装完成后, 您将需要使用STACKS®管理员用户(默认用户Admin)来登录到您的STACKS®系统. 请为这个管理员有那个设置一个密码. 这个密码可以在第一次登陆后更改. 您也可以输入另外一个除了默认用户之外的用户. ',
    'LBL_SYSTEM_CREDS'                  => '系统身份验证',
    'LBL_SYSTEM_ENV'                    => '系统环境',
	'LBL_START'							=> '开始',
    'LBL_SHOW_PASS'                     => '显示密码',
    'LBL_HIDE_PASS'                     => '隐藏密码',
    'LBL_HIDDEN'                        => '<i>(隐藏)</i>',
//	'LBL_NO_THANKS'						=> '继续安装',
	'LBL_CHOOSE_LANG'					=> '<b>选择您的语言</b>',
	'LBL_STEP'							=> '步骤',
	'LBL_TITLE_WELCOME'					=> '欢迎来到STACKS® CRM ',
	'LBL_WELCOME_1'						=> '这个安装可以帮您创建起步需要的SugarCRM表以及设置配置变量. 整个过程应该需要10分钟. ',
	'LBL_WELCOME_2'						=> '查看安装文档, 请访问<a href="http://www.sugarcrm.com/crm/installation" target="_blank">STACKS®百科</a>. <BR><BR> 您也可以在 <a href="http://www.sugar360.cn" target="_blank">Sugar中文论坛</a>找到有帮助的信息.',
    //welcome page variables
    'LBL_TITLE_ARE_YOU_READY'            => '您是否准备好了安装?',
    'REQUIRED_SYS_COMP' => '要求的系统组件',
    'REQUIRED_SYS_COMP_MSG' =>
                    '在您开始之前, 请确保您拥有一下系统组件的
					SugarCRM兼容版本:<br>
                      <ul>
                      <li> 数据库/数据库管理系统(例如: MySQL, SQL Server, Oracle)</li>
                      <li> Web服务器(Apache, IIS)</li>
                      </ul>
                      查询正在安装的STACKS®版本兼容的系统组件
                      请查询发布笔记中的兼容性列表<br>',
    'REQUIRED_SYS_CHK' => '起始系统检查',
    'REQUIRED_SYS_CHK_MSG' =>
                    '当您开始安装进程后, 程序将在Sugar文件位置服务器进行系统检查
                      来确保系统配置正确并且所有需要的组件
                      来成功完成此次安装. <br><br>
                      系统将检查下面全部内容: <br>
                      <ul>
                      <li><b>PHP版本</b> &#8211; 必须与
                      应用兼容</li>
                                        <li><b>Session变量</b> &#8211; 必须正常工作</li>
                                            <li> <b>MB Strings</b> &#8211; 必须安装并且在php.ini中启用</li>

                      <li> <b>数据库支持</b> &#8211; 必须有MySQL, SQL
                      服务器或 Oracle</li>

                      <li> <b>Config.php</b> &#8211; 必须存在并且必须为
                                  可写状态</li>
					  <li>下面这些STACKS®文件必须是可写状态: <ul><li><b>/custom</li>
<li>/cache</li>
<li>/modules</b></li></ul></li></ul>
                                  如果这项检查失败, 您将无法继续进行安装. 一条解释错误的警告将显示
                                  并告知为什么您的系统没有通过检查. 
                                  当所需的更改已经完成时, 您可以在此运行
                                  系统检查并继续安装. <br>',
    'REQUIRED_INSTALLTYPE' => '典型或自定义安装',
    'REQUIRED_INSTALLTYPE_MSG' =>
                    '当系统检查完成后, 您可以选择典型
                      或自定义安装. <br><br>
                      不管是<b>典型</b>或<b>自定义</b>安装, 您都需要知道下面的信息: <br>
                      <ul>
                      <li>承载Sugar数据库的<b>数据库类型</b><ul><li>兼容数据库类型
                      : MySQL, MS SQL服务器, Oracle.<br><br></li></ul></li>
                      <li>承载数据库的<b>Web服务器名称</b>或电脑(主机)
                      <ul><li>如果数据库在您本地电脑上或和Web服务器在同一台机器, 这也许会是<i>localhost</i>. <br><br></li></ul></li>
                      <li>您希望承载Sugar数据的<b>数据库名</b></li>
                        <ul>
                          <li>您也许已经有一个已存在的数据库想使用. 如果您提供
                          已存在数据库的数据库名, 这个数据库里的表将
                          在安装过程中定义数据库时被清除. </li>
                          <li>如果您不是已经拥有一个数据库, 您所提供的数据库名将在安装过程中被用于
                          新建的数据库. <br><br></li>
                        </ul>
                      <li><b>数据库管理员用户名和密码</b> <ul><li>数据库管理员应该有权限去建立表, 用户以及写入数据库. </li><li>如果数据库不再您的本地电脑上
					  或您不是数据库管理员. 您也许需要联系您的数据库管理员来获取这些信息<br><br></ul></li></li>
                      <li> <b>Sugar数据库用户名和密码</b>
                      </li>
                        <ul>
                          <li>这个用户可以是数据库管理员, 或者您可以提供另外一个
                          已经存在的数据库用户的用户名.  </li>
                          <li>如果您希望建立一个新的数据库, 您需要
                          能够在安装过程中提供一个新的用户名和密码, 
                          并且建立一个用户.  </li>
                        </ul></ul><p>

                      对于<b>自定义</b>安装, 您也许需要知道下面的信息: <br>
                      <ul>
                      <li> <b>用来访问STACKS®系统的URL</b>在安装完成后. 
                      这个URL应该包含Web服务器, 主机名称或IP地址. <br><br></li>
                                  <li> [可选项] <b>Session路径目录</b>如果您希望使用一个
                                  自定义Session目录来保存STACKS®信息, 从而防止Session数据存在
                                  共享环境中的安全隐患. <br><br></li>
                                  <li> [可选项] <b>自定义日志文件夹</b>如果您希望覆盖默认系统日志存放目录. <br><br></li>
                                  <li> [可选项] <b>应用ID</b>如果您希望覆盖系统自动生成的
                                  ID来确保一个STACKS®的Session不会被另外一个STACKS®系统所占用. <br><br></li>
                                  <li><b>字符集</b> 你本地化设置中最常用的字符集. <br><br></li></ul>
                                  更多具体的信息, 请参考安装手册. 
                                ',
    'LBL_WELCOME_PLEASE_READ_BELOW' => '请在继续安装之前阅读下面的信息. 下面的信息将帮助您决定您是否准备好了此次安装. ',

	'LBL_WELCOME_CHOOSE_LANGUAGE'		=> '<b>选择您的语言</b>',
	'LBL_WELCOME_SETUP_WIZARD'			=> '安装向导',
	'LBL_WELCOME_TITLE_WELCOME'			=> '欢迎来到STACKS® CRM ',
	'LBL_WELCOME_TITLE'					=> 'STACKS® CRM安装向导',
	'LBL_WIZARD_TITLE'					=> 'STACKS®安装向导:  ',
	'LBL_YES'							=> '是',
    'LBL_YES_MULTI'                     => '是 - 多字节',
	// OOTB Scheduler Job Names:
	'LBL_OOTB_WORKFLOW'		=> '处理工作流任务',
	'LBL_OOTB_REPORTS'		=> '运行报表生成定时任务',
	'LBL_OOTB_IE'			=> '检查收件箱',
	'LBL_OOTB_BOUNCE'		=> '每晚处理退回的营销电子邮件',
    'LBL_OOTB_CAMPAIGN'		=> '每晚批量运行电子邮件市场活动',
	'LBL_OOTB_PRUNE'		=> '每月1号精简数据库',
    'LBL_OOTB_TRACKER'		=> '删除跟踪器表',
    'LBL_UPDATE_TRACKER_SESSIONS' => '更新tracker_sessions表',


    'LBL_PATCHES_TITLE'     => '安装最新补丁',
    'LBL_MODULE_TITLE'      => '安装语言包',
    'LBL_PATCH_1'           => '如果您希望跳过此步, 点击下一步. ',
    'LBL_PATCH_TITLE'       => '系统补丁',
    'LBL_PATCH_READY'       => '下面这些补丁已经准备好安装: ',
	'LBL_SESSION_ERR_DESCRIPTION'		=> "Sugar依靠PHP会话来在链接这台Web服务器时保存重要信息. 您的PHP会话信息配置不正确. 
											<br><br>一个常见的错误配置是 <b>'session.save_path'</b>目录没有指向一个有效目录.  <br>
											<br> 请修正您位于下面的php.ini中的 <a target=_new href='http://us2.php.net/manual/en/ref.session.php'>PHP配置</a> . ",
	'LBL_SESSION_ERR_TITLE'				=> 'PHP会话配置错误',
	'LBL_SYSTEM_NAME'=>'System Name',
	'LBL_REQUIRED_SYSTEM_NAME'=>'请提供一个STACKS®实例的系统名称. ',
	'LBL_PATCH_UPLOAD' => '从本地计算机上选择一个补丁文件',
	'LBL_INCOMPATIBLE_PHP_VERSION' => '需要PHP版本5或更高.',
	'LBL_MINIMUM_PHP_VERSION' => '所需的最低PHP版本5.1.0. 推荐的PHP版本5.2.x.',
	'LBL_YOUR_PHP_VERSION' => '(您当前的 php 版本是',
	'LBL_RECOMMENDED_PHP_VERSION' =>' 推荐php版本是5.2.x)',
	'LBL_BACKWARD_COMPATIBILITY_ON' => 'Php向后兼容模式已打开.  如果想关闭请将zend.ze1_compatibility_mode设置成off. ',

    'advanced_password_new_account_email' => array(
        'subject' => '新帐户信息',
        'description' => '这个模板是用来给管理员发送新密码给用户的. ',
        'body' => '<div><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width="550" align=\"\&quot;\&quot;center\&quot;\&quot;\"><tbody><tr><td colspan=\"2\"><p>这里是您的用户名和临时密码: </p><p>用户名 : $contact_user_user_name </p><p>密码 : $contact_user_user_hash </p><br><p>$config_site_url</p><br><p>当您使用上述密码登录后. 您也许将被要求要求重新设置您的密码. </p>   </td>         </tr><tr><td colspan=\"2\"></td>         </tr> </tbody></table> </div>',
        'txt_body' =>
'
下面是您的帐户用户名和帐户临时密码: 
用户名 : $contact_user_user_name
密码 : $contact_user_user_hash

$config_site_url

使用上述密码登录后, 您将被要求重置您的密码. ',
        'name' => '系统生成的密码邮件',
        ),
    'advanced_password_forgot_password_email' => array(
        'subject' => '重置您的帐户密码',
        'description' => "这个模板是用来提供给用户一个可以点击并重置他们密码的邮件. ",
        'body' => '<div><table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width="550" align=\"\&quot;\&quot;center\&quot;\&quot;\"><tbody><tr><td colspan=\"2\"><p>You recently requested on $contact_user_pwd_last_changed to be able to reset your account password. </p><p>Click on the link below to reset your password:</p><p> $contact_user_link_guid </p>  </td>         </tr><tr><td colspan=\"2\"></td>         </tr> </tbody></table> </div>',
        'txt_body' =>
'
您最近要求了 $contact_user_pwd_last_changed重置您帐户的密码. 

点击下面的链接来重置您的密码: 

$contact_user_link_guid',
        'name' => '忘记密码邮件',
        ),
);

?>
