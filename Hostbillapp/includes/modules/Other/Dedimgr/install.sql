CREATE TABLE `tb_colo_log` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`who` VARCHAR( 32 ) NOT NULL ,
`what` TEXT NOT NULL,
`when` DATETIME NOT NULL,
`rel` ENUM('colocation','floor','rack','item') NOT NULL,
`rel_id` INT NOT NULL
) DEFAULT CHARACTER SET utf8 ENGINE = MYISAM ;
##--------
CREATE TABLE `tb_colocation` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`name` VARCHAR( 32 ) NOT NULL ,
`address` TEXT NULL ,
`emergency_contact` TEXT NULL ,
`phone` VARCHAR( 32 ) NULL ,
`price_per_gb` DECIMAL( 10, 2 ) NULL ,
`price_per_ip` DECIMAL( 10, 2 ) NULL ,
`price_reboot` DECIMAL( 10, 2 ) NULL
) DEFAULT CHARACTER SET utf8 ENGINE = MYISAM ;
##--------
CREATE TABLE `tb_floor` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`colo_id` INT( 11 ) NOT NULL ,
`floor` INT( 3 ) NOT NULL ,
`name` VARCHAR( 32 ) NULL ,
INDEX ( `colo_id` ),
FOREIGN KEY(`colo_id`)
 REFERENCES tb_colocation(`id`)
) DEFAULT CHARACTER SET utf8 ENGINE = MYISAM ;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack` (
`id` INT(11) NOT NULL AUTO_INCREMENT ,
`floor_id` INT(11) NOT NULL ,
`name` VARCHAR(32) NOT NULL ,
`units` INT(3) NOT NULL ,
`empty_weight` DECIMAL(10,2) NOT NULL ,
`networkspeed` INT NOT NULL ,
PRIMARY KEY (`id`) ,
INDEX (`floor_id` ASC))
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;

##--------
CREATE TABLE `tb_server` (
`id` INT( 11 ) NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`rack_id` INT( 11 ) NOT NULL ,
`memory` VARCHAR( 32 ) NOT NULL ,
`label` VARCHAR( 32 ) NOT NULL ,
`mount_size` INT( 1 ) NOT NULL ,
`model` VARCHAR( 32 ) NOT NULL ,
`motherboard` VARCHAR( 32 ) NOT NULL ,
`name` VARCHAR( 32 ) NOT NULL ,
`os_name` VARCHAR( 32 ) NOT NULL ,
`os_version` VARCHAR( 32 ) NOT NULL ,
`cp_name` VARCHAR( 32 ) NOT NULL ,
`cp_version` VARCHAR( 32 ) NOT NULL ,
`monthly_price` DECIMAL( 10, 2 ) NOT NULL ,
`owner` TEXT NOT NULL ,
`date_added` DATE NOT NULL ,
`NICs` INT( 1 ) NOT NULL ,
`backup_server` TEXT NULL ,
`remote_login_details` TEXT NULL ,
`software_upgrades` TEXT NULL ,
`hardware_upgrades` TEXT NULL ,
`sort` INT( 5 ) NOT NULL ,
INDEX ( `rack_id` ),
FOREIGN KEY(`rack_id`)
 REFERENCES tb_rack(`id`)
) DEFAULT CHARACTER SET utf8 ENGINE = MYISAM ;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack_item_field_value` (
`id` INT NOT NULL AUTO_INCREMENT ,
`field_id` INT(11) NOT NULL ,
`item_id` INT(11) NOT NULL ,
`value` TEXT NOT NULL ,
PRIMARY KEY (`id`) ,
INDEX `fk_tb_rack_item_field_value_tb_rack_item_field` (`field_id` ASC) ,
INDEX `fk_tb_rack_item_field_value_tb_rack_item` (`item_id` ASC))
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
CREATE  TABLE IF NOT EXISTS `tb_field2type` (
`field_id` INT NOT NULL ,
`type_id` INT NOT NULL ,
`position` INT NOT NULL ,
PRIMARY KEY `index2` (`field_id` , `type_id`) )
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack_item_field` (
`id` INT NOT NULL AUTO_INCREMENT ,
`name` VARCHAR(45) NOT NULL ,
`field_type` VARCHAR(45) NOT NULL DEFAULT 'input' ,
`default_value` TEXT NOT NULL ,
`options` INT NOT NULL ,
PRIMARY KEY (`id`) ,
INDEX `INDEX` (`field_type` ASC) )
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack_item` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`rack_id` INT(11) NOT NULL ,
`item_type_id` INT NOT NULL ,
`position` INT NOT NULL DEFAULT 0 ,
PRIMARY KEY (`id`) ,
INDEX `fk_tb_rack_item_tb_rack` (`rack_id` ASC) ,
INDEX `fk_tb_rack_item_tb_rack_item_type` (`item_type_id` ASC) )
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack_item_type` (
`id` INT NOT NULL AUTO_INCREMENT ,
`category_id` INT NOT NULL ,
`name` VARCHAR(45) NOT NULL ,
`units` INT NOT NULL DEFAULT 1 ,
`current` DECIMAL(10,2) NOT NULL DEFAULT 0 ,
`weight` DECIMAL(10,2) NOT NULL DEFAULT 0 ,
`power` DECIMAL(10,2) NOT NULL ,
`monthly_price` DECIMAL(10,2) NOT NULL ,
PRIMARY KEY (`id`) ,
INDEX `fk_tb_rack_item_type_tb_rack_item_type_category` (`category_id` ASC) )
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
CREATE  TABLE IF NOT EXISTS `tb_rack_item_type_category` (
`id` INT NOT NULL AUTO_INCREMENT ,
`name` VARCHAR(45) NOT NULL ,
PRIMARY KEY (`id`) )
ENGINE = MYISAM
DEFAULT CHARACTER SET = utf8;
##--------
ALTER TABLE `tb_rack_item_type` ADD `css` VARCHAR( 32 ) NOT NULL DEFAULT 'default_1u';
##--------
 CREATE  TABLE IF NOT EXISTS `tb_vendors` (
`id` INT(11) NOT NULL AUTO_INCREMENT ,
`name` varchar(127) NOT NULL ,
`comments` TEXT NOT NULL,
PRIMARY KEY (`id`)
) ENGINE = `MyISAM` DEFAULT CHARACTER SET = utf8;
##--------
INSERT INTO `tb_vendors` ( `id` ,`name` ,`comments`) VALUES ( 1 , 'OEM', '');
##--------
ALTER TABLE `tb_rack_item` ADD `label` VARCHAR( 255 ) NOT NULL AFTER `position`;
##--------
ALTER TABLE `tb_rack_item_type` ADD `vendor_id` INT( 11 ) NOT NULL  DEFAULT '1',
ADD INDEX ( `vendor_id` ) ;
##--------
ALTER TABLE `tb_rack_item` ADD `notes` TEXT NOT NULL;
##--------
ALTER TABLE `tb_rack` ADD `room` VARCHAR( 127 ) NOT NULL AFTER `floor_id`;
##--------
ALTER TABLE `tb_rack_item` ADD `parent_id` INT( 11 ) NOT NULL DEFAULT '0' AFTER `item_type_id` ,
ADD `account_id` INT( 11 ) NOT NULL DEFAULT '0' AFTER `parent_id` ,
ADD `client_id` INT( 11 ) NOT NULL DEFAULT '0' AFTER `account_id` ,
ADD INDEX ( `parent_id`) ,
ADD INDEX ( `account_id`) ,
ADD INDEX ( `client_id` );
##--------
CREATE TABLE `tb_rack_item_port` (
 `id` int(11) NOT NULL auto_increment,
 `item_id` int(11) NOT NULL,
 `type` enum('NIC','PDU') NOT NULL default 'NIC',
 `direction` enum('in','out') NOT NULL default 'out',
 `number` int(2) NOT NULL default 1,
 `connected_to` int(11) NOT NULL default 0,
 `port_id` varchar(127) NOT NULL default '',
 `port_name` varchar(127) NOT NULL default '',
 `ipv4` varbinary(16) NULL,
 `ipv6` varbinary(16)  NULL,
 `mac` varchar(17) NULL,
 PRIMARY KEY  (`id`),
 KEY `item_id` (`item_id`,`type`,`direction`),
 KEY `number` (`number`),
 KEY `connected_to` (`connected_to`),
 KEY `port_id` (`port_id`,`port_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
##--------
ALTER TABLE  `tb_rack_item` ADD  `location` ENUM(  'Front',  'Back',  'Lside',  'Rside',  'Blade') NOT NULL DEFAULT  'Front', ADD INDEX (  `location` );
##--------
ALTER TABLE  `tb_rack_item` ADD  `isblade` TINYINT( 1 ) NOT NULL DEFAULT  '0';
##--------
CREATE TABLE IF NOT EXISTS `tb_rack_item_config` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `group_id` int(10) NOT NULL DEFAULT '0',
  `item_id` int(10) NOT NULL,
  `description` varchar(160) NOT NULL,
  `config` text NOT NULL,
  `archived` tinyint(4) NOT NULL,
  `author` varchar(50) NOT NULL,
  `author_id` int(10) DEFAULT NULL,
  `date_created` datetime NOT NULL,
  `date_changed` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`),
  KEY `item_id` (`item_id`),
  KEY `author_id` (`author_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
##--------
CREATE TABLE IF NOT EXISTS `tb_monitoring_cache` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `server_id` int(10) NOT NULL,
  `hash` VARCHAR(32) NOT NULL,
  `cache` text NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  KEY `server_id` (`server_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
##--------
ALTER TABLE `tb_rack_item_port`
ADD COLUMN `account_id` INT(11) NOT NULL DEFAULT '0' AFTER `connected_to`,
ADD COLUMN `server_id` INT(11) NOT NULL DEFAULT '0' AFTER `account_id`,
ADD COLUMN `port_status` TINYINT NOT NULL DEFAULT '-1' AFTER `server_id`,
ADD COLUMN `port_checked` DATETIME NOT NULL AFTER `port_name`,
ADD INDEX `server_id` (`server_id`),
ADD INDEX `account_id` (`account_id`);
##--------
ALTER TABLE `tb_rack_item_type`
CHANGE COLUMN `css` `css` VARCHAR(255) NOT NULL DEFAULT 'default_1u.png' AFTER `monthly_price`;
##--------
UPDATE tb_rack_item_type SET css=CONCAT(css,'.png') WHERE css NOT LIKE '%.png';
##--------
INSERT INTO `tb_rack_item_field` (`id`, `name`, `field_type`, `default_value`, `options`) VALUES
(1, 'Label', 'input', '', 0),
(3, 'Name', 'input', '', 0),
(4, 'Model', 'input', '', 0),
(5, 'Motherboard', 'input', '', 0),
(6, 'Memory', 'input', '', 0),
(7, 'NIC qty', 'input', '', 0),
(8, 'Owner', 'clients', '', 0),
(10, 'Manufacturer', 'input', 'Dell', 0),
(11, 'Drives', 'input', '', 0),
(12, 'Switch App', 'switch_app', '', 0),
(13, 'PDU App', 'pdu_app', '', 0);
##--------
INSERT INTO `tb_rack_item_type` (`id`, `category_id`, `name`, `units`, `current`, `weight`, `power`, `monthly_price`, `css`, `vendor_id`) VALUES
(7, 4, 'Power Edge 750', 1, 1.31, 29.00, 270.00, 4.00, 'default_1u.png', 1),
(13, 5, 'DAE2P', 2, 2.00, 74.00, 430.00, 0.00, 'default_1u.png', 1),
(11, 9, '1U Panel', 1, 0.00, 0.00, 0.00, 0.00, 'default_1u.png', 1),
(12, 9, '2U Panel', 2, 0.00, 0.00, 0.00, 0.00, 'default_1u.png', 1),
(14, 11, 'APC Switched Rack PDU', 1, 15.00, 5.00, 1800.00, 0.00, 'pdu_1u.png', 1),
(15, 6, 'Cisco Catalyst 2950 Series', 1, 4.50, 6.50, 30.00, 0.00, 'switch_1u.png', 1);
##--------
INSERT INTO `tb_rack_item_type_category` (`id`, `name`) VALUES
(4, 'Servers'),
(5, 'Storage'),
(6, 'Network Switches'),
(7, 'KVM Switches'),
(8, 'Monitors'),
(9, 'Blanking Panels'),
(10, 'Accessories'),
(11, 'PDU'),
(12, 'Patch Panel');
##--------
INSERT INTO `tb_field2type` (`field_id`, `type_id`, `position`) VALUES
(7, 7, 0),
(6, 7, 1),
(5, 7, 0),
(8, 7, 1),
(1, 7, 2),
(11, 13, 0),
(13, 14, 0),
(12, 15, 1),
(4, 15, 0);
##--------
ALTER TABLE `tb_rack_item_type`
ADD COLUMN `orientation` ENUM('Front','Side') NOT NULL DEFAULT 'Front' AFTER `css`;
##--------
ALTER TABLE  `tb_rack_item` CHANGE  `location`  `location` ENUM(  'Front',  'Back',  'Lside',  'Rside',  'Blade',  'Zero' )  NOT NULL DEFAULT 'Front';