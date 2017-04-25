SET FOREIGN_KEY_CHECKS=0;  
  
-- ----------------------------  
-- Table structure for `t_user`  
-- ----------------------------  
DROP TABLE IF EXISTS `t_user`;  
CREATE TABLE `t_user` (  
  `id` varchar(11) NOT NULL,  
  `username` varchar(40) NOT NULL,  
  `password` varchar(40) NOT NULL,  
  `sex` varchar(4) NOT NULL,  
  PRIMARY KEY (`id`)  
) ENGINE=InnoDB DEFAULT CHARSET=utf8;  
  
-- ----------------------------  
-- Records of t_user  
-- ----------------------------  
INSERT INTO `t_user` VALUES ('1', 'user', '123', '男');

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `uuid` varchar(32) NOT NULL,
  `nickname` varchar(40) NOT NULL,
  `pwd` varchar(40) NOT NULL,
  `name` varchar(40) default NULL,
  `tele` varchar(40) default NULL,
  `email` varchar(100) default NULL,
  `createtime` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY  (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('1', 'noname', '123456', '李吴明', '15921655030', '824160554@qq.com', '2017-04-23 15:00:18');

-- ----------------------------
-- Table structure for sys_menus
-- ----------------------------
DROP TABLE IF EXISTS `sys_menus`;
CREATE TABLE `sys_menus` (
  `menu_id` varchar(32) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `parent_id` varchar(32) NOT NULL,
  `url` varchar(255) default NULL,
  `seq` decimal(4,0) NOT NULL,
  PRIMARY KEY  (`menu_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menus
-- ----------------------------
INSERT INTO `sys_menus` VALUES ('1', '账户管理', '0', '#', '1');
INSERT INTO `sys_menus` VALUES ('2', '2222', '0', '#', '2');
INSERT INTO `sys_menus` VALUES ('3', '测试2', '0', '#', '3');
INSERT INTO `sys_menus` VALUES ('21', '2222-1', '2', '44444444', '1');
INSERT INTO `sys_menus` VALUES ('211', '2222-1-1', '211', 'sssssssssssss', '1');
INSERT INTO `sys_menus` VALUES ('11', '账户信息', '1', 'account/toshowaccountinfo', '1');