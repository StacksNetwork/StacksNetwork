CREATE TABLE IF NOT EXISTS `ictype` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;
#######
CREATE TABLE IF NOT EXISTS `idelivery` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `date` date DEFAULT NULL,
    `total` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `invoice_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `order_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `received_by` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `ivendor_id` int(11) unsigned DEFAULT NULL,
    `notes` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_idelivery_ivendor` (`ivendor_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;
#######
CREATE TABLE IF NOT EXISTS `ideployacc` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `account_id` int(11) unsigned DEFAULT NULL,
    `dedimgr_item_id` tinyint(3) unsigned DEFAULT NULL,
    `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `date` datetime DEFAULT NULL,
    `ideployprod_id` int(11) unsigned DEFAULT NULL,
    `buildby` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_ideployacc_ideployprod` (`ideployprod_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `ideployitm` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `ihtype_id` int(11) unsigned DEFAULT NULL,
    `ideployprod_id` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_ideployitm_ihtype` (`ihtype_id`),
    KEY `index_foreignkey_ideployitm_ideployprod` (`ideployprod_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `ideployprod` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `ientity` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `localisation` text COLLATE utf8_unicode_ci,
    `price` tinyint(3) unsigned DEFAULT NULL,
    `sn` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `guarantee` date DEFAULT NULL,
    `support` date DEFAULT NULL,
    `iproducer_id` int(11) unsigned DEFAULT NULL,
    `idelivery_id` int(11) unsigned DEFAULT NULL,
    `ihtype_id` int(11) unsigned DEFAULT NULL,
    `ideployacc_id` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_ientity_iproducer` (`iproducer_id`),
    KEY `index_foreignkey_ientity_idelivery` (`idelivery_id`),
    KEY `index_foreignkey_ientity_ihtype` (`ihtype_id`),
    KEY `index_foreignkey_ientity_ideployacc` (`ideployacc_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `ientitylog` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `date` datetime DEFAULT NULL,
    `entry` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `ientity_id` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_ientitylog_ientity` (`ientity_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `ihtype` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `requiredqty` INT NULL DEFAULT NULL,
    `safeqty` INT NULL DEFAULT NULL,
    `ictype_id` int(11) unsigned DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `index_foreignkey_ihtype_ictype` (`ictype_id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `iproducer` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
CREATE TABLE IF NOT EXISTS `isettings` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;
#######
INSERT INTO `isettings` (`id`, `name`, `value`, `description`) VALUES
(2, 'Send pending build notification', 'True', 'If enabled all staff members assigned to this plugin will receive email notification when new built has been added, but not delivered'),
(3, 'Send support expire alerts', 'True', 'If enabled, staff will receive alerts about items with support expiring within 30 days'),
(4, 'Send low QTY alerts', 'True', 'If enabled, staff will receive alerts about low QTY of items used by active products');
#######
CREATE TABLE IF NOT EXISTS `ivendor` (
    `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
    `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `contact` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
    PRIMARY KEY (`id`)
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
#######
ALTER TABLE `idelivery`
ADD CONSTRAINT `cons_fk_idelivery_ivendor_id_id` FOREIGN KEY (`ivendor_id`) REFERENCES `ivendor` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
#######
ALTER TABLE `ideployacc`
ADD CONSTRAINT `cons_fk_ideployacc_ideployprod_id_id` FOREIGN KEY (`ideployprod_id`) REFERENCES `ideployprod` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
#######
ALTER TABLE `ideployitm`
ADD CONSTRAINT `cons_fk_ideployitm_ideployprod_id_id` FOREIGN KEY (`ideployprod_id`) REFERENCES `ideployprod` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
ADD CONSTRAINT `cons_fk_ideployitm_ihtype_id_id` FOREIGN KEY (`ihtype_id`) REFERENCES `ihtype` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
#######
ALTER TABLE `ientity`
ADD CONSTRAINT `cons_fk_ientity_idelivery_id_id` FOREIGN KEY (`idelivery_id`) REFERENCES `idelivery` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
ADD CONSTRAINT `cons_fk_ientity_ideployacc_id_id` FOREIGN KEY (`ideployacc_id`) REFERENCES `ideployacc` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
ADD CONSTRAINT `cons_fk_ientity_ihtype_id_id` FOREIGN KEY (`ihtype_id`) REFERENCES `ihtype` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
ADD CONSTRAINT `cons_fk_ientity_iproducer_id_id` FOREIGN KEY (`iproducer_id`) REFERENCES `iproducer` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;
#######
ALTER TABLE `ientitylog`
ADD CONSTRAINT `cons_fk_ientitylog_ientity_id_id_casc` FOREIGN KEY (`ientity_id`) REFERENCES `ientity` (`id`) ON DELETE CASCADE ON UPDATE SET NULL;
#######
ALTER TABLE `ihtype`
ADD CONSTRAINT `cons_fk_ihtype_ictype_id_id` FOREIGN KEY (`ictype_id`) REFERENCES `ictype` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;