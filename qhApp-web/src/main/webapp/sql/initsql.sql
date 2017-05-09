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
  `teacher_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
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
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `stu_id` bigint(20) NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `age` int(11) default NULL,
  `gender` int(11) NOT NULL,
  `tele` varchar(100) default NULL,
  `wxh` varchar(100) default NULL,
  `address` varchar(255) default NULL,
  `status` int(11) NOT NULL,
  `memo` varchar(255) default NULL,
  `enroldate` date NOT NULL COMMENT '入学日期',
  `createtime` timestamp NOT NULL default '0000-00-00 00:00:00' on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`stu_id`),
  UNIQUE KEY `stu_id` USING HASH (`stu_id`),
  KEY `name` USING HASH (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '顾振', '11', '1', '15921555000', 'haiwopiappiaoquan', '上海市松江区', '1', '屌的很有意境', '2017-05-01', '2017-05-08 16:22:14');
INSERT INTO `student` VALUES ('2', '奥神', '22', '1', '13511111111', 'aoshen', '222', '1', '影魔', '2017-05-01', '2017-05-09 10:26:20');
INSERT INTO `student` VALUES ('3', '王海晨', '16', '1', '15921111111', 'laowang', '上海市', '1', '花母鸡', '2017-05-08', '2017-05-08 17:20:43');
INSERT INTO `student` VALUES ('5', '起飞', null, '1', '', '', '', '1', '', '2017-05-01', '2017-05-09 10:27:04');
INSERT INTO `student` VALUES ('6', '降落', null, '1', '', '', '', '1', '', '2017-05-10', '2017-05-09 10:27:11');
INSERT INTO `student` VALUES ('7', '一群小杂鱼', null, '1', '', '', '', '1', '', '2017-05-11', '2017-05-09 10:27:21');
INSERT INTO `student` VALUES ('8', '蹬狗腿', null, '2', '', '', '', '1', '', '2017-05-02', '2017-05-09 10:27:39');
INSERT INTO `student` VALUES ('9', '不爱夜蒲', null, '1', '', '', '', '1', '', '2017-05-18', '2017-05-09 10:28:08');
INSERT INTO `student` VALUES ('10', '一路向南', null, '1', '', '', '', '1', '', '2017-05-17', '2017-05-09 10:28:26');
INSERT INTO `student` VALUES ('11', '银瓶梅', null, '1', '', '', '', '1', '', '2017-05-18', '2017-05-09 10:28:47');
INSERT INTO `student` VALUES ('12', '锡角大王', null, '1', '', '', '', '1', '', '2017-05-18', '2017-05-09 10:29:03');
INSERT INTO `student` VALUES ('13', '敲锣打屌', null, '1', '', '', '', '1', '', '2017-05-10', '2017-05-09 10:29:55');

