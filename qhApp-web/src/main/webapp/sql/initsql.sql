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
INSERT INTO `sys_menus` VALUES ('3', '学生模块', '0', '#', '3');
INSERT INTO `sys_menus` VALUES ('21', '教师列表', '2', 'teacher/tolistteacher', '1');
INSERT INTO `sys_menus` VALUES ('31', '学生列表', '3', 'student/toliststudent', '1');
INSERT INTO `sys_menus` VALUES ('11', '账户信息', '1', 'account/toshowaccountinfo', '1');
INSERT INTO `sys_menus` VALUES ('4', '综合管理', '0', '#', '4');
INSERT INTO `sys_menus` VALUES ('41', '学科管理', '4', 'subject/tolistsubject', '1');
-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `sub_id` bigint(20) NOT NULL auto_increment,
  `sub_name` varchar(40) NOT NULL,
  `create_time` datetime NOT NULL,
  PRIMARY KEY  (`sub_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES ('1', '钢琴', '2017-05-10 14:34:01');
INSERT INTO `subject` VALUES ('2', '琵琶', '2017-05-10 14:34:05');
INSERT INTO `subject` VALUES ('23', '巴乌', '2017-05-18 09:53:19');
INSERT INTO `subject` VALUES ('22', '管子', '2017-05-18 09:53:09');
INSERT INTO `subject` VALUES ('21', '笛', '2017-05-18 09:53:04');
INSERT INTO `subject` VALUES ('20', '葫芦丝', '2017-05-18 09:52:58');
INSERT INTO `subject` VALUES ('19', '排笙', '2017-05-18 09:52:52');
INSERT INTO `subject` VALUES ('18', '芦笙', '2017-05-18 09:52:47');
INSERT INTO `subject` VALUES ('17', '笙', '2017-05-18 09:52:37');
INSERT INTO `subject` VALUES ('15', '口风琴', '2017-05-17 17:31:24');
INSERT INTO `subject` VALUES ('24', '埙', '2017-05-18 09:53:24');
INSERT INTO `subject` VALUES ('25', '唢呐', '2017-05-18 09:55:21');
INSERT INTO `subject` VALUES ('26', '箫', '2017-05-18 09:55:27');
INSERT INTO `subject` VALUES ('27', '扬琴', '2017-05-18 09:56:40');
INSERT INTO `subject` VALUES ('28', '七弦琴', '2017-05-18 09:56:47');
INSERT INTO `subject` VALUES ('29', '热瓦普', '2017-05-18 09:56:52');
INSERT INTO `subject` VALUES ('30', '冬不拉', '2017-05-18 09:56:57');
INSERT INTO `subject` VALUES ('31', '柳琴', '2017-05-18 09:57:02');
INSERT INTO `subject` VALUES ('32', '阮', '2017-05-18 09:57:08');
INSERT INTO `subject` VALUES ('33', '三弦', '2017-05-18 09:57:14');
INSERT INTO `subject` VALUES ('34', '月琴', '2017-05-18 09:57:19');
INSERT INTO `subject` VALUES ('35', '弹布尔', '2017-05-18 09:57:24');
INSERT INTO `subject` VALUES ('36', '堂鼓', '2017-05-18 09:57:35');
INSERT INTO `subject` VALUES ('37', '碰铃', '2017-05-18 09:57:44');
INSERT INTO `subject` VALUES ('38', '缸鼓', '2017-05-18 09:57:52');
INSERT INTO `subject` VALUES ('39', '定音缸鼓', '2017-05-18 09:57:57');
INSERT INTO `subject` VALUES ('40', '铜鼓', '2017-05-18 09:58:02');
INSERT INTO `subject` VALUES ('41', '小鼓', '2017-05-18 09:58:10');
INSERT INTO `subject` VALUES ('42', '排鼓', '2017-05-18 09:58:16');
INSERT INTO `subject` VALUES ('43', '达卜', '2017-05-18 09:58:24');
INSERT INTO `subject` VALUES ('44', '大钹', '2017-05-18 09:58:29');

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(40) NOT NULL,
  `age` int(11) default NULL,
  `gender` int(11) NOT NULL,
  `tele` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `wxh` varchar(255) default NULL COMMENT '微信号',
  `address` varchar(255) default NULL,
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
INSERT INTO `teacher` VALUES ('1', 'noname', null, '1', '', '', '', '', '1', '', '2017-04-28 11:04:14');
INSERT INTO `teacher` VALUES ('6', '陈二超', '18', '1', '15911111111', 'diaozhatian@sina.com', 'cccisgoodman', '浙江', '1', '屌炸天', '2017-05-02 10:53:26');
INSERT INTO `teacher` VALUES ('39', '晨晨', null, '2', '', '', '', '', '1', '', '2017-05-18 13:23:57');
INSERT INTO `teacher` VALUES ('40', '奥神', null, '1', '', '', '', '', '1', '', '2017-05-19 17:07:20');
INSERT INTO `teacher` VALUES ('42', '阿瑟斯', null, '1', '', '', '', '', '1', '', '2017-05-22 10:18:33');


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

-- ----------------------------
-- Table structure for subject_relation
-- ----------------------------
DROP TABLE IF EXISTS `subject_relation`;
CREATE TABLE `subject_relation` (
  `rela_id` bigint(20) NOT NULL auto_increment,
  `obj_id` bigint(20) NOT NULL,
  `sub_id` bigint(20) NOT NULL,
  `sub_flag` int(11) NOT NULL COMMENT '关系归属，0：教师；1：学生',
  `create_time` datetime NOT NULL,
  PRIMARY KEY  (`rela_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject_relation
-- ----------------------------
INSERT INTO `subject_relation` VALUES ('40', '6', '23', '0', '2017-05-22 13:35:58');
INSERT INTO `subject_relation` VALUES ('41', '6', '21', '0', '2017-05-22 13:35:58');
INSERT INTO `subject_relation` VALUES ('42', '6', '18', '0', '2017-05-22 13:35:58');
INSERT INTO `subject_relation` VALUES ('43', '39', '23', '0', '2017-05-22 13:36:02');
INSERT INTO `subject_relation` VALUES ('44', '39', '22', '0', '2017-05-22 13:36:02');
INSERT INTO `subject_relation` VALUES ('45', '39', '21', '0', '2017-05-22 13:36:02');
INSERT INTO `subject_relation` VALUES ('46', '40', '23', '0', '2017-05-22 13:36:09');
INSERT INTO `subject_relation` VALUES ('47', '40', '2', '0', '2017-05-22 13:36:09');
INSERT INTO `subject_relation` VALUES ('49', '42', '2', '0', '2017-05-22 13:37:21');
INSERT INTO `subject_relation` VALUES ('50', '42', '21', '0', '2017-05-22 13:37:21');
INSERT INTO `subject_relation` VALUES ('51', '42', '22', '0', '2017-05-22 13:37:21');
