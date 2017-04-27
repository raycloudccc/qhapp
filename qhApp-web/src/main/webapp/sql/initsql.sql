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
INSERT INTO `sys_menus` VALUES ('2', '教师模块', '0', '#', '2');
INSERT INTO `sys_menus` VALUES ('3', '测试2', '0', '#', '3');
INSERT INTO `sys_menus` VALUES ('21', '教师列表', '2', 'teacher/tolistteacher', '1');
INSERT INTO `sys_menus` VALUES ('211', '2222-1-1', '211', 'sssssssssssss', '1');
INSERT INTO `sys_menus` VALUES ('11', '账户信息', '1', 'account/toshowaccountinfo', '1');
-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `sub_id` varchar(32) NOT NULL,
  `sub_name` varchar(40) NOT NULL,
  PRIMARY KEY  (`sub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES ('1', '钢琴');
INSERT INTO `subject` VALUES ('2', '琵琶');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_id` varchar(32) NOT NULL,
  `name` varchar(40) NOT NULL,
  `age` int(11) default NULL,
  `gender` int(11) NOT NULL,
  `tele` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `wxh` varchar(255) default NULL COMMENT '微信号',
  `address` varchar(255) default NULL,
  `sub_id` varchar(40) NOT NULL COMMENT '所属学科',
  `status` int(11) NOT NULL,
  `memo` varchar(255) default NULL,
  `createtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`teacher_id`),
  UNIQUE KEY `teacher_id` USING HASH (`teacher_id`),
  KEY `name` USING HASH (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('eaf537ff934745f1ba4ad038ecc3d998', '幅度高达', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 13:19:41');
INSERT INTO `teacher` VALUES ('f649201e572f48e986666ba5b386dde6', '1111111', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 13:40:43');
INSERT INTO `teacher` VALUES ('abe7c3781ebf45a6b125c7e55a82f513', 'noname', '27', '1', '15921655030', '824160554@qq.com', 'aaaaa', '松江区', '2', '1', '啊啊啊啊啊啊啊啊啊', '2017-04-27 13:13:54');
INSERT INTO `teacher` VALUES ('b27fe9b091944b929b1bc3f860bb1044', '陈二超', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 11:37:55');
INSERT INTO `teacher` VALUES ('b8baa72901b3429e913b9be6e3b0fd83', '也浮动', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 14:16:34');
INSERT INTO `teacher` VALUES ('98b43399c71a43edbf480de811dcdf02', '也', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 13:24:04');
INSERT INTO `teacher` VALUES ('569601a25aec4e91b47da0dfcc0ef5a4', '也', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 13:24:04');
INSERT INTO `teacher` VALUES ('eaa0869ca11e45bd8d21443f6a14a6c1', '也个', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 14:13:47');
INSERT INTO `teacher` VALUES ('6115f4a3c9e44e3b891923f49d603f33', 'aa', '33', '1', '', '', '', '', '2', '1', '', '2017-04-27 15:41:54');
INSERT INTO `teacher` VALUES ('f96743ee2684456e877bfc831e902edd', 'A', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 15:41:14');
INSERT INTO `teacher` VALUES ('fe55b3a95c494a5ca8f2d8b9369a63ba', '通用语', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 13:26:30');
INSERT INTO `teacher` VALUES ('f43a3ffb3106424c8ef293d3578b6fb6', 'ttt4', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 14:08:41');
INSERT INTO `teacher` VALUES ('8cfec200294a4e60886f59423cc24cca', '轻微污染', null, '1', '', '', '', '', '1', '1', '', '2017-04-27 14:11:37');
INSERT INTO `teacher` VALUES ('03c6c96dc03d4eb7858bb53a42dd4471', '大多数', null, '1', '', '', '', '', '2', '1', '', '2017-04-27 14:16:51');