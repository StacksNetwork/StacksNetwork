SET FOREIGN_KEY_CHECKS=0;
#######
TRUNCATE `ictype`;
#######
TRUNCATE `idelivery`;
#######
TRUNCATE `ideployacc`;
#######
TRUNCATE `ideployitm`;
#######
TRUNCATE `ideployprod`;
#######
TRUNCATE `ientity`;
#######
TRUNCATE `ientitylog`;
#######
TRUNCATE `ihtype`;
#######
TRUNCATE `iproducer`;
#######
TRUNCATE `ivendor`;
#######
SET FOREIGN_KEY_CHECKS=1;
#######
INSERT INTO `ictype` (`id`, `name`, `description`) VALUES
(1, 'Intel CPUs', ''),
(2, 'AMD CPUs', ''),
(3, 'Motherboards-Intel', 'Motherboards'),
(4, 'Motherboards-AMD', 'Motherboards'),
(5, 'Power Supply Units', ''),
(6, 'SATA Hard Disks', ''),
(7, 'SSD Hard Disks', ''),
(8, 'Controller Cards', ''),
(9, 'DDR3 Memory', ''),
(10, 'Operating Systems', ''),
(11, '1U Mount Cases', '');
#######
INSERT INTO `ihtype` (`id`, `name`, `description`, `code`, `ictype_id`) VALUES
(1, 'Windows Server 2012', '', 'Win2012', 10),
(2, 'Windows Server 2008 R2', '', 'Win2008R2', 10),
(3, '4GB DDR3', '', '4GB', 9),
(4, '8GB DDR3', '', '8GB', 9),
(5, 'SATA 2x Internal', '', 'SATA2x', 8),
(6, 'Asus KGPE-D16', '', 'KGPED16', 4),
(7, 'AMD Opteron 6348', '', '6348', 2),
(8, 'Xeon E5606', '', 'XeonE5606', 1),
(9, 'ASUS P8B-M LGA1155', '', 'ASUSP8BMLGA1155', 3),
(10, 'Norco RPC1204', '', 'RPC1204', 11),
(11, '1000 GB SATA II', '', '1000SATA2', 6),
(12, '260 Watt', '', '260W', 5),
(13, '700W Hot-Swap', '', '700WHS', 5);
#######
INSERT INTO `iproducer` (`id`, `name`, `code`, `website`, `description`) VALUES
(1, '3Ware', '3WARE', 'http://www.3ware.com/', ''),
(2, 'Adaptec', 'Adaptec', 'http://www.adaptec.com/en-us/', ''),
(3, 'Chenbro', 'Chenbro', 'http://www.chenbro.com/', ''),
(4, 'Emulex', 'Emulex', 'http://www.emulex.com/', ''),
(5, 'Hitachi', 'Hitachi', 'http://www.hitachi.com/', ''),
(6, 'Helwett-Packard', 'HP', 'http://www.hp.com', ''),
(7, 'Iiyama', 'Iiyama', 'http://www.iiyama.com/', ''),
(8, 'Infortrend', 'Infortrend', 'http://www.infortrend.com/', ''),
(9, 'Intel', 'Intel', 'http://www.intel.com/', ''),
(10, 'LG', 'LG', 'http://www.lg.com/', ''),
(11, 'LSI', 'LSI', 'http://www.lsi.com/', ''),
(12, 'QLogic', 'QLogic', 'http://qlogic.com/', ''),
(13, 'Seagate', 'Seagate', 'http://www.seagate.com/', ''),
(14, 'Sony', 'Sony', 'http://www.sony.com/', ''),
(15, 'Supermicro', 'Supermicro', 'http://www.supermicro.com/', ''),
(16, 'Tandberg', 'Tandberg', 'http://www.tandbergdata.com/us/', ''),
(17, 'Western Digital', 'WD', 'http://www.wdc.com/', ''),
(18, 'Cisco', 'Cisco', 'http://www.cisco.com/', ''),
(19, 'ASUS', 'ASUS', 'http://www.asus.com/', '');
#######
INSERT INTO `ivendor` (`id`, `name`, `code`, `contact`, `description`, `website`) VALUES
(1, 'Hewlett-Packard', 'HP', '', '', NULL),
(2, 'DELL', 'DELL', '', '', NULL),
(3, 'IBM', 'IBM', '', '', NULL),
(4, 'Sun Microsystems', 'SUN', '', '', NULL),
(5, 'Microsoft', 'Microsoft', '', '', NULL),
(6, 'Cisco', 'Cisco', '', '', NULL),
(7, 'OEM', 'OEM', '', '', NULL);
#######
INSERT INTO `idelivery` (`id`, `date`, `total`, `invoice_id`, `order_id`, `received_by`, `ivendor_id`, `notes`) VALUES
(1, '2013-06-13', '300', '150125', 'Order-123-412', 'Default User', 3, ''),
(2, '2012-06-14', '3000', 'DELL-102491/123/41', 'DELL-102491/123/41', 'Default User', 2, ''),
(3, '2013-06-14', '50000', 'DELL-102491/123/21', 'DELL-102491/123/21', 'Default User', 2, ''),
(4, '2011-06-07', '0.00', 'OEM-Order', 'OEM-Order', 'Default User', 7, '');
#######
INSERT INTO `ideployprod` (`id`, `name`, `description`, `status`) VALUES
(1, 'Sample Server', '', 'Active');
#######
INSERT INTO `ideployacc` (`id`, `account_id`, `dedimgr_item_id`, `status`, `date`, `ideployprod_id`, `buildby`) VALUES
(5, 0, 0, 'Pending', '2013-06-14 12:49:58', 1, 'n/a');
#######
INSERT INTO `ideployitm` (`id`, `ihtype_id`, `ideployprod_id`) VALUES
(1, 8, 1),
(2, 9, 1),
(3, 10, 1),
(4, 11, 1),
(5, 3, 1),
(6, 3, 1),
(7, 1, 1);
#######
INSERT INTO `ientity` (`id`, `status`, `localisation`, `price`, `sn`, `guarantee`, `support`, `iproducer_id`, `idelivery_id`, `ihtype_id`, `ideployacc_id`) VALUES
(1, 'In Stock', 'Floor C', 60, 'Serial-1039401294/1', '2015-08-23', '2015-08-23', 9, 1, 8, NULL),
(2, 'In Stock', 'Floor C', 60, 'Serial-1039401294/2', '2015-08-23', '2015-08-23', 9, 1, 8, NULL),
(3, 'Reserved', 'Floor C', 60, 'i-1231522354242', '2015-08-23', '2015-08-23', 9, 1, 8, 5),
(4, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/4', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(5, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/5', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(6, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/6', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(7, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/7', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(8, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/8', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(9, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/9', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(10, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/10', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(11, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/11', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(12, 'In Stock', 'Mike''s office', 220, 'Serial-1039401294/12', '2014-06-15', '2014-06-15', 19, 2, 9, NULL),
(13, 'Reserved', 'Mike''s office', 220, 'GG-1034940138501/a/1', '2014-06-15', '2014-06-15', 19, 2, 9, 5),
(14, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/15a', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(15, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/15', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(16, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/16', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(17, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/17', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(18, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/18', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(19, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/19', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(20, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/20', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(21, 'In Stock', 'Shelf A2', 10, 'Serial-1039401294/21', '2016-06-17', '2016-06-17', 17, 3, 3, NULL),
(22, 'Reserved', 'Shelf A2', 10, 'ae-103194912/1/1', '2016-06-17', '2016-06-17', 17, 3, 3, 5),
(23, 'Reserved', 'Shelf A2', 10, 'ae-103194912/1/2', '2016-06-17', '2016-06-17', 17, 3, 3, 5),
(24, 'In Stock', 'Shelf 11', 10, 'Serial-1039401294/24', '2016-06-17', '2016-06-17', 17, 3, 1, NULL),
(25, 'In Stock', 'Shelf 11', 10, 'Serial-1039401294/25', '2016-06-17', '2016-06-17', 17, 3, 1, NULL),
(26, 'Reserved', 'Shelf 11', 10, 'wn-sgda3-agad3-asg24-as3t23-asdt23', '2016-06-17', '2016-06-17', 17, 3, 1, 5),
(27, 'In Stock', 'Shelf 12', 10, 'Serial-1039401294/27', '2016-06-17', '2016-06-17', 17, 3, 2, NULL),
(28, 'In Stock', 'Shelf 12', 10, 'Serial-1039401294/28', '2016-06-17', '2016-06-17', 17, 3, 2, NULL),
(29, 'In Stock', 'Shelf 12', 10, 'Serial-1039401294/29', '2016-06-17', '2016-06-17', 17, 3, 2, NULL),
(30, 'In Stock', 'Room 203', 110, 'Serial-1039401294/30', '2016-06-17', '2016-06-17', 17, 3, 13, NULL),
(31, 'In Stock', 'Room 203', 110, 'Serial-1039401294/31', '2016-06-17', '2016-06-17', 17, 3, 13, NULL),
(32, 'In Stock', 'Room 203', 110, 'Serial-1039401294/32', '2016-06-17', '2016-06-17', 17, 3, 13, NULL),
(33, 'In Stock', 'Room 203', 110, 'Serial-1039401294/33', '2016-06-17', '2016-06-17', 17, 3, 12, NULL),
(34, 'In Stock', 'Room 203', 110, 'Serial-1039401294/34', '2016-06-17', '2016-06-17', 17, 3, 12, NULL),
(35, 'In Stock', 'Room 203', 110, 'Serial-1039401294/35', '2016-06-17', '2016-06-17', 17, 3, 12, NULL),
(36, 'In Stock', 'Room 202', 110, 'Serial-1039401294/36', '2016-06-17', '2016-06-17', 17, 3, 11, NULL),
(37, 'In Stock', 'Room 202', 110, 'Serial-1039401294/37', '2016-06-17', '2016-06-17', 17, 3, 11, NULL),
(38, 'Reserved', 'Room 202', 110, 'wd-11-410234/SATA/1', '2016-06-17', '2016-06-17', 17, 3, 11, 5),
(39, 'In Stock', 'Mike''s office', 0, 'Serial-1039401294/39', '2014-06-21', '2014-06-21', 16, 4, 10, NULL),
(40, 'In Stock', 'Mike''s office', 0, 'Serial-1039401294/40', '2014-06-21', '2014-06-21', 16, 4, 10, NULL),
(41, 'In Stock', 'Mike''s office', 0, 'Serial-1039401294/41', '2014-06-21', '2014-06-21', 16, 4, 10, NULL),
(42, 'In Stock', 'Mike''s office', 0, 'Serial-1039401294/42', '2014-06-21', '2014-06-21', 16, 4, 10, NULL),
(43, 'In Stock', 'Mike''s office', 0, 'Serial-1039401294/43', '2014-06-21', '2014-06-21', 16, 4, 10, NULL),
(44, 'Reserved', 'Mike''s office', 0, 'q-11', '2014-06-21', '2014-06-21', 16, 4, 10, 5),
(45, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/45', '2014-06-21', '2014-06-21', 1, 4, 5, NULL),
(46, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/46', '2014-06-21', '2014-06-21', 1, 4, 5, NULL),
(47, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/47', '2014-06-21', '2014-06-21', 1, 4, 5, NULL),
(48, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/48', '2014-06-21', '2014-06-21', 1, 4, 5, NULL),
(49, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/49', '2014-06-21', '2014-06-21', 1, 4, 5, NULL),
(50, 'In Stock', 'Shelf BB', 0, 'Serial-1039401294/50', '2014-06-21', '2014-06-21', 1, 4, 5, NULL);
#######
INSERT INTO `ientitylog` (`id`, `date`, `entry`, `ientity_id`) VALUES
(1, '2013-06-14 12:41:54', 'Item received and added on stock', 1),
(2, '2013-06-14 12:41:54', 'Item received and added on stock', 2),
(3, '2013-06-14 12:41:54', 'Item received and added on stock', 3),
(4, '2013-06-14 12:43:39', 'Item received and added on stock', 4),
(5, '2013-06-14 12:43:39', 'Item received and added on stock', 5),
(6, '2013-06-14 12:43:39', 'Item received and added on stock', 6),
(7, '2013-06-14 12:43:39', 'Item received and added on stock', 7),
(8, '2013-06-14 12:43:39', 'Item received and added on stock', 8),
(9, '2013-06-14 12:43:39', 'Item received and added on stock', 9),
(10, '2013-06-14 12:43:39', 'Item received and added on stock', 10),
(11, '2013-06-14 12:43:39', 'Item received and added on stock', 11),
(12, '2013-06-14 12:43:39', 'Item received and added on stock', 12),
(13, '2013-06-14 12:43:39', 'Item received and added on stock', 13),
(14, '2013-06-14 12:45:34', 'Item received and added on stock', 14),
(15, '2013-06-14 12:45:34', 'Item received and added on stock', 15),
(16, '2013-06-14 12:45:34', 'Item received and added on stock', 16),
(17, '2013-06-14 12:45:34', 'Item received and added on stock', 17),
(18, '2013-06-14 12:45:34', 'Item received and added on stock', 18),
(19, '2013-06-14 12:45:34', 'Item received and added on stock', 19),
(20, '2013-06-14 12:45:34', 'Item received and added on stock', 20),
(21, '2013-06-14 12:45:34', 'Item received and added on stock', 21),
(22, '2013-06-14 12:45:34', 'Item received and added on stock', 22),
(23, '2013-06-14 12:45:34', 'Item received and added on stock', 23),
(24, '2013-06-14 12:45:34', 'Item received and added on stock', 24),
(25, '2013-06-14 12:45:34', 'Item received and added on stock', 25),
(26, '2013-06-14 12:45:34', 'Item received and added on stock', 26),
(27, '2013-06-14 12:45:34', 'Item received and added on stock', 27),
(28, '2013-06-14 12:45:34', 'Item received and added on stock', 28),
(29, '2013-06-14 12:45:34', 'Item received and added on stock', 29),
(30, '2013-06-14 12:45:34', 'Item received and added on stock', 30),
(31, '2013-06-14 12:45:34', 'Item received and added on stock', 31),
(32, '2013-06-14 12:45:34', 'Item received and added on stock', 32),
(33, '2013-06-14 12:45:34', 'Item received and added on stock', 33),
(34, '2013-06-14 12:45:34', 'Item received and added on stock', 34),
(35, '2013-06-14 12:45:34', 'Item received and added on stock', 35),
(36, '2013-06-14 12:45:34', 'Item received and added on stock', 36),
(37, '2013-06-14 12:45:34', 'Item received and added on stock', 37),
(38, '2013-06-14 12:45:34', 'Item received and added on stock', 38),
(39, '2013-06-14 12:46:55', 'Item received and added on stock', 39),
(40, '2013-06-14 12:46:55', 'Item received and added on stock', 40),
(41, '2013-06-14 12:46:55', 'Item received and added on stock', 41),
(42, '2013-06-14 12:46:55', 'Item received and added on stock', 42),
(43, '2013-06-14 12:46:55', 'Item received and added on stock', 43),
(44, '2013-06-14 12:46:55', 'Item received and added on stock', 44),
(45, '2013-06-14 12:46:55', 'Item received and added on stock', 45),
(46, '2013-06-14 12:46:55', 'Item received and added on stock', 46),
(47, '2013-06-14 12:46:55', 'Item received and added on stock', 47),
(48, '2013-06-14 12:46:55', 'Item received and added on stock', 48),
(49, '2013-06-14 12:46:55', 'Item received and added on stock', 49),
(50, '2013-06-14 12:46:55', 'Item received and added on stock', 50),
(51, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 3),
(52, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 13),
(53, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 44),
(54, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 38),
(55, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 22),
(56, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 23),
(57, '2013-06-14 12:47:05', 'Item reserved for new server build using product: Sample Server', 26),
(58, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 3),
(59, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 13),
(60, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 44),
(61, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 38),
(62, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 22),
(63, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 23),
(64, '2013-06-14 12:47:32', 'Item reserved for new server build using product: Sample Server', 26),
(65, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 3),
(66, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 13),
(67, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 44),
(68, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 38),
(69, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 22),
(70, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 23),
(71, '2013-06-14 12:48:55', 'Item reserved for new server build using product: Sample Server', 26),
(72, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 3),
(73, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 13),
(74, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 44),
(75, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 38),
(76, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 22),
(77, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 23),
(78, '2013-06-14 12:49:23', 'Item reserved for new server build using product: Sample Server', 26),
(79, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 3),
(80, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 13),
(81, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 44),
(82, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 38),
(83, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 22),
(84, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 23),
(85, '2013-06-14 12:49:58', 'Item reserved for new server build using product: Sample Server', 26),
(86, '2013-06-14 12:50:20', 'Item details updated', 3),
(87, '2013-06-14 12:50:41', 'Item details updated', 26),
(88, '2013-06-14 12:50:54', 'Item details updated', 44),
(89, '2013-06-14 12:51:08', 'Item details updated', 13),
(90, '2013-06-14 12:51:23', 'Item details updated', 22),
(91, '2013-06-14 12:51:39', 'Item details updated', 23),
(92, '2013-06-14 12:52:13', 'Item details updated', 38);
