/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50718
Source Host           : 127.0.0.1:3306
Source Database       : examstack

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-07-07 11:22:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for et_comment
-- ----------------------------
DROP TABLE IF EXISTS `et_comment`;
CREATE TABLE `et_comment` (
  `comment_id` int(10) NOT NULL AUTO_INCREMENT,
  `refer_id` int(10) NOT NULL,
  `comment_type` tinyint(1) NOT NULL DEFAULT '0',
  `index_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `content_msg` mediumtext NOT NULL,
  `quoto_id` int(10) NOT NULL DEFAULT '0',
  `re_id` int(10) NOT NULL DEFAULT '0',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `fk_u_id` (`user_id`),
  CONSTRAINT `et_comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_comment
-- ----------------------------

-- ----------------------------
-- Table structure for et_department
-- ----------------------------
DROP TABLE IF EXISTS `et_department`;
CREATE TABLE `et_department` (
  `dep_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(200) NOT NULL,
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`dep_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_department
-- ----------------------------
INSERT INTO `et_department` VALUES ('1', '计划财务部', '计划财务部');
INSERT INTO `et_department` VALUES ('2', '网创学员', '网创学员');

-- ----------------------------
-- Table structure for et_exam
-- ----------------------------
DROP TABLE IF EXISTS `et_exam`;
CREATE TABLE `et_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(100) NOT NULL,
  `exam_subscribe` varchar(500) DEFAULT NULL,
  `exam_type` tinyint(4) NOT NULL COMMENT '公有、私有、模拟考试',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `exam_paper_id` int(11) NOT NULL,
  `creator` int(11) DEFAULT NULL,
  `creator_id` varchar(50) DEFAULT NULL,
  `approved` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_exam_2pid` (`exam_paper_id`),
  CONSTRAINT `fk_exam_2pid` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam
-- ----------------------------

-- ----------------------------
-- Table structure for et_exam_2_paper
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_2_paper`;
CREATE TABLE `et_exam_2_paper` (
  `exam_id` int(11) NOT NULL,
  `paper_id` int(11) NOT NULL,
  UNIQUE KEY `idx_exam_epid` (`exam_id`,`paper_id`),
  KEY `fk_exam_pid` (`paper_id`),
  CONSTRAINT `fk_exam_eid` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`),
  CONSTRAINT `fk_exam_pid` FOREIGN KEY (`paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam_2_paper
-- ----------------------------

-- ----------------------------
-- Table structure for et_exam_paper
-- ----------------------------
DROP TABLE IF EXISTS `et_exam_paper`;
CREATE TABLE `et_exam_paper` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  `paper_type` varchar(40) NOT NULL DEFAULT '1' COMMENT '0 真题 1 模拟 2 专家',
  `field_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_exam_paper
-- ----------------------------

-- ----------------------------
-- Table structure for et_field
-- ----------------------------
DROP TABLE IF EXISTS `et_field`;
CREATE TABLE `et_field` (
  `field_id` int(5) NOT NULL AUTO_INCREMENT,
  `field_name` varchar(50) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_field
-- ----------------------------
INSERT INTO `et_field` VALUES ('2', '网创题库', '网创考试题', '0');

-- ----------------------------
-- Table structure for et_group
-- ----------------------------
DROP TABLE IF EXISTS `et_group`;
CREATE TABLE `et_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(40) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_group_uid` (`user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_group
-- ----------------------------
INSERT INTO `et_group` VALUES ('1', '测试组', '2015-10-27 01:17:18', '1', '0');
INSERT INTO `et_group` VALUES ('3', '默认分组', '2017-07-06 10:59:01', '4714', '1');

-- ----------------------------
-- Table structure for et_knowledge_point
-- ----------------------------
DROP TABLE IF EXISTS `et_knowledge_point`;
CREATE TABLE `et_knowledge_point` (
  `point_id` int(5) NOT NULL AUTO_INCREMENT,
  `point_name` varchar(100) NOT NULL,
  `field_id` int(5) NOT NULL,
  `memo` varchar(100) DEFAULT NULL,
  `state` decimal(1,0) DEFAULT '1' COMMENT '1:正常 0：废弃',
  PRIMARY KEY (`point_id`),
  UNIQUE KEY `idx_point_name` (`point_name`) USING BTREE,
  KEY `fk_knowledge_field` (`field_id`),
  CONSTRAINT `et_knowledge_point_ibfk_1` FOREIGN KEY (`field_id`) REFERENCES `et_field` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_knowledge_point
-- ----------------------------
INSERT INTO `et_knowledge_point` VALUES ('5', '电子商务', '2', null, '0');

-- ----------------------------
-- Table structure for et_menu_item
-- ----------------------------
DROP TABLE IF EXISTS `et_menu_item`;
CREATE TABLE `et_menu_item` (
  `menu_id` varchar(50) NOT NULL,
  `menu_name` varchar(100) NOT NULL,
  `menu_href` varchar(200) NOT NULL,
  `menu_seq` int(5) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `parent_id` varchar(50) NOT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `visiable` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_menu_item
-- ----------------------------
INSERT INTO `et_menu_item` VALUES ('question', '试题管理', 'admin/question/question-list', '1001', 'ROLE_ADMIN', '-1', 'fa-cloud', '1');
INSERT INTO `et_menu_item` VALUES ('question-list', '试题管理', 'admin/question/question-list', '100101', 'ROLE_ADMIN', 'question', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('question-add', '添加试题', 'admin/question/question-add', '100102', 'ROLE_ADMIN', 'question', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('question-import', '导入试题', 'admin/question/question-import', '100103', 'ROLE_ADMIN', 'question', 'fa-cloud-upload', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper', '试卷管理', 'admin/exampaper/exampaper-list/0', '1002', 'ROLE_ADMIN', '-1', 'fa-file-text-o', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-list', '试卷管理', 'admin/exampaper/exampaper-list/0', '100201', 'ROLE_ADMIN', 'exampaper', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-add', '创建新试卷', 'admin/exampaper/exampaper-add', '100202', 'ROLE_ADMIN', 'exampaper', 'fa-leaf', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-edit', '修改试卷', '', '100203', 'ROLE_ADMIN', 'exampaper', 'fa-pencil', '0');
INSERT INTO `et_menu_item` VALUES ('exampaper-preview', '预览试卷', '', '100204', 'ROLE_ADMIN', 'exampaper', 'fa-eye', '0');
INSERT INTO `et_menu_item` VALUES ('exam', '考试管理', 'admin/exam/exam-list', '1003', 'ROLE_ADMIN', '-1', 'fa-trophy', '1');
INSERT INTO `et_menu_item` VALUES ('exam-list', '考试管理', 'admin/exam/exam-list', '100301', 'ROLE_ADMIN', 'exam', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exam-add', '发布考试', 'admin/exam/exam-add', '100302', 'ROLE_ADMIN', 'exam', 'fa-plus-square-o', '1');
INSERT INTO `et_menu_item` VALUES ('exam-student-list', '学员名单', '', '100305', 'ROLE_ADMIN', 'exam', 'fa-sitemap', '0');
INSERT INTO `et_menu_item` VALUES ('student-answer-sheet', '学员试卷', '', '100306', 'ROLE_ADMIN', 'exam', 'fa-file-o', '0');
INSERT INTO `et_menu_item` VALUES ('mark-exampaper', '人工阅卷', '', '100307', 'ROLE_ADMIN', 'exam', 'fa-circle-o-notch', '0');
INSERT INTO `et_menu_item` VALUES ('user', '用户管理', 'admin/user/student-list', '1005', 'ROLE_ADMIN', '-1', 'fa-user', '1');
INSERT INTO `et_menu_item` VALUES ('student-list', '用户管理', 'admin/user/student-list', '100501', 'ROLE_ADMIN', 'user', 'fa-users', '1');
INSERT INTO `et_menu_item` VALUES ('student-examhistory', '考试历史', '', '100502', 'ROLE_ADMIN', 'user', 'fa-glass', '0');
INSERT INTO `et_menu_item` VALUES ('student-profile', '学员资料', '', '100503', 'ROLE_ADMIN', 'user', 'fa-flag-o', '0');
INSERT INTO `et_menu_item` VALUES ('teacher-list', '教师管理', 'admin/user/teacher-list', '100504', 'ROLE_ADMIN', 'user', 'fa-cubes', '1');
INSERT INTO `et_menu_item` VALUES ('teacher-profile', '教师资料', '', '100505', 'ROLE_ADMIN', 'user', null, '0');
INSERT INTO `et_menu_item` VALUES ('training', '培训', 'admin/training/training-list', '1004', 'ROLE_ADMIN', '-1', 'fa-laptop', '1');
INSERT INTO `et_menu_item` VALUES ('training-list', '培训管理', 'admin/training/training-list', '100401', 'ROLE_ADMIN', 'training', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('training-add', '添加培训', 'admin/training/training-add', '100402', 'ROLE_ADMIN', 'training', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('student-practice-status', '学习进度', '', '100403', 'ROLE_ADMIN', 'training', 'fa-rocket', '0');
INSERT INTO `et_menu_item` VALUES ('student-training-history', '培训进度', '', '100404', 'ROLE_ADMIN', 'training', 'fa-star-half-full', '0');
INSERT INTO `et_menu_item` VALUES ('common', '通用数据', 'admin/common/tag-list', '1006', 'ROLE_ADMIN', '-1', 'fa-cubes', '1');
INSERT INTO `et_menu_item` VALUES ('tag-list', '标签管理', 'admin/common/tag-list', '100601', 'ROLE_ADMIN', 'common', 'fa-tags', '1');
INSERT INTO `et_menu_item` VALUES ('field-list', '专业题库', 'admin/common/field-list', '100602', 'ROLE_ADMIN', 'common', 'fa-anchor', '1');
INSERT INTO `et_menu_item` VALUES ('knowledge-list', '知识分类', 'admin/common/knowledge-list/0', '100603', 'ROLE_ADMIN', 'common', 'fa-flag', '1');
INSERT INTO `et_menu_item` VALUES ('question', '试题管理', 'teacher/question/question-list', '2001', 'ROLE_TEACHER', '-1', 'fa-cloud', '1');
INSERT INTO `et_menu_item` VALUES ('question-list', '试题管理', 'teacher/question/question-list', '200101', 'ROLE_TEACHER', 'question', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('question-add', '添加试题', 'teacher/question/question-add', '200102', 'ROLE_TEACHER', 'question', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('question-import', '导入试题', 'teacher/question/question-import', '200103', 'ROLE_TEACHER', 'question', 'fa-cloud-upload', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper', '试卷管理', 'teacher/exampaper/exampaper-list/0', '2002', 'ROLE_TEACHER', '-1', 'fa-file-text-o', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-list', '试卷管理', 'teacher/exampaper/exampaper-list/0', '200201', 'ROLE_TEACHER', 'exampaper', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-add', '创建新试卷', 'teacher/exampaper/exampaper-add', '200202', 'ROLE_TEACHER', 'exampaper', 'fa-leaf', '1');
INSERT INTO `et_menu_item` VALUES ('exampaper-edit', '修改试卷', '', '200203', 'ROLE_TEACHER', 'exampaper', 'fa-pencil', '0');
INSERT INTO `et_menu_item` VALUES ('exampaper-preview', '预览试卷', '', '200204', 'ROLE_TEACHER', 'exampaper', 'fa-eye', '0');
INSERT INTO `et_menu_item` VALUES ('exam', '考试管理', 'teacher/exam/exam-list', '2003', 'ROLE_TEACHER', '-1', 'fa-trophy', '1');
INSERT INTO `et_menu_item` VALUES ('exam-list', '考试管理', 'teacher/exam/exam-list', '200301', 'ROLE_TEACHER', 'exam', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('exam-add', '发布考试', 'teacher/exam/exam-add', '200302', 'ROLE_TEACHER', 'exam', 'fa-plus-square-o', '1');
INSERT INTO `et_menu_item` VALUES ('exam-student-list', '学员名单', '', '200303', 'ROLE_TEACHER', 'exam', 'fa-sitemap', '0');
INSERT INTO `et_menu_item` VALUES ('student-answer-sheet', '学员试卷', '', '200304', 'ROLE_TEACHER', 'exam', 'fa-file-o', '0');
INSERT INTO `et_menu_item` VALUES ('mark-exampaper', '人工阅卷', '', '200305', 'ROLE_TEACHER', 'exam', 'fa-circle-o-notch', '0');
INSERT INTO `et_menu_item` VALUES ('user', '用户管理', 'teacher/user/student-list', '2005', 'ROLE_TEACHER', '-1', 'fa-user', '1');
INSERT INTO `et_menu_item` VALUES ('student-list', '用户管理', 'teacher/user/student-list', '200501', 'ROLE_TEACHER', 'user', 'fa-users', '1');
INSERT INTO `et_menu_item` VALUES ('student-examhistory', '考试历史', '', '200502', 'ROLE_TEACHER', 'user', 'fa-glass', '0');
INSERT INTO `et_menu_item` VALUES ('student-profile', '学员资料', '', '200503', 'ROLE_TEACHER', 'user', 'fa-flag-o', '0');
INSERT INTO `et_menu_item` VALUES ('training', '培训', 'teacher/training/training-list', '2004', 'ROLE_TEACHER', '-1', 'fa-laptop', '1');
INSERT INTO `et_menu_item` VALUES ('training-list', '培训管理', 'teacher/training/training-list', '200401', 'ROLE_TEACHER', 'training', 'fa-list', '1');
INSERT INTO `et_menu_item` VALUES ('training-add', '添加培训', 'teacher/training/training-add', '200402', 'ROLE_TEACHER', 'training', 'fa-plus', '1');
INSERT INTO `et_menu_item` VALUES ('student-practice-status', '学习进度', '', '200403', 'ROLE_TEACHER', 'training', 'fa-rocket', '0');
INSERT INTO `et_menu_item` VALUES ('student-training-history', '培训进度', '', '200404', 'ROLE_TEACHER', 'training', 'fa-star-half-full', '0');
INSERT INTO `et_menu_item` VALUES ('system', '系统设置', 'admin/system/admin-list', '1007', 'ROLE_ADMIN', '-1', 'fa-cog', '1');
INSERT INTO `et_menu_item` VALUES ('admin-list', '管理员列表', 'admin/system/admin-list', '100701', 'ROLE_ADMIN', 'system', 'fa-group', '1');
INSERT INTO `et_menu_item` VALUES ('news-list', '系统公告', 'admin/system/news-list', '100703', 'ROLE_ADMIN', 'system', 'fa-volume-up', '1');
INSERT INTO `et_menu_item` VALUES ('dep-list', '部门管理', 'admin/common/dep-list', '100604', 'ROLE_ADMIN', 'common', 'fa-leaf', '1');
INSERT INTO `et_menu_item` VALUES ('model-test-add', '发布模拟考试', 'admin/exam/model-test-add', '100304', 'ROLE_ADMIN', 'exam', 'fa-flag', '1');
INSERT INTO `et_menu_item` VALUES ('model-test-list', '模拟考试', 'admin/exam/model-test-list', '100303', 'ROLE_ADMIN', 'exam', 'fa-glass', '1');
INSERT INTO `et_menu_item` VALUES ('dashboard', '控制面板', 'admin/dashboard', '1000', 'ROLE_ADMIN', '-1', 'fa-dashboard', '1');
INSERT INTO `et_menu_item` VALUES ('', '', '', '0', 'ROLE_ADMIN', '', null, '1');

-- ----------------------------
-- Table structure for et_news
-- ----------------------------
DROP TABLE IF EXISTS `et_news`;
CREATE TABLE `et_news` (
  `news_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`news_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `et_news_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_news
-- ----------------------------
INSERT INTO `et_news` VALUES ('1', '在线考试系统正式发布', '在线考试系统正式发布', '1', '2015-10-28 01:46:37');

-- ----------------------------
-- Table structure for et_practice_paper
-- ----------------------------
DROP TABLE IF EXISTS `et_practice_paper`;
CREATE TABLE `et_practice_paper` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `content` mediumtext,
  `duration` int(11) NOT NULL COMMENT '试卷考试时间',
  `total_point` int(11) DEFAULT '0',
  `pass_point` int(11) DEFAULT '0',
  `group_id` int(11) NOT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否所有用户可见，默认为0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试卷状态， 0未完成 -> 1已完成 -> 2已发布 -> 3通过审核 （已发布和通过审核的无法再修改）',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `summary` varchar(100) DEFAULT NULL COMMENT '试卷介绍',
  `is_subjective` tinyint(1) DEFAULT NULL COMMENT '为1表示为包含主观题的试卷，需阅卷',
  `answer_sheet` mediumtext COMMENT '试卷答案，用答题卡的结构保存',
  `creator` varchar(40) DEFAULT NULL COMMENT '创建人的账号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_practice_paper
-- ----------------------------

-- ----------------------------
-- Table structure for et_question
-- ----------------------------
DROP TABLE IF EXISTS `et_question`;
CREATE TABLE `et_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  `content` varchar(2000) NOT NULL,
  `question_type_id` int(11) NOT NULL COMMENT '题型',
  `duration` int(11) DEFAULT NULL COMMENT '试题考试时间',
  `points` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL COMMENT '班组ID',
  `is_visible` tinyint(1) NOT NULL DEFAULT '0' COMMENT '试题可见性',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(20) NOT NULL DEFAULT 'admin' COMMENT '创建者',
  `last_modify` timestamp NULL DEFAULT NULL,
  `answer` mediumtext NOT NULL,
  `expose_times` int(11) NOT NULL DEFAULT '2',
  `right_times` int(11) NOT NULL DEFAULT '1',
  `wrong_times` int(11) NOT NULL DEFAULT '1',
  `difficulty` int(5) NOT NULL DEFAULT '1',
  `analysis` mediumtext,
  `reference` varchar(1000) DEFAULT NULL,
  `examing_point` varchar(5000) DEFAULT NULL,
  `keyword` varchar(5000) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_type_id` (`question_type_id`),
  KEY `et_question_ibfk_5` (`creator`),
  CONSTRAINT `et_question_ibfk_1` FOREIGN KEY (`question_type_id`) REFERENCES `et_question_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question
-- ----------------------------
INSERT INTO `et_question` VALUES ('51', '淘宝规则的适用对象是', '{\"title\":\"淘宝规则的适用对象是_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"卖家\",\"B\":\"买家\",\"C\":\"淘宝网所有用户\",\"D\":\"所有网民\"},\"choiceImgList\":{}}', '1', null, '0', null, '0', '2017-07-07 09:54:17', 'admin', null, 'C', '2', '1', '1', '1', '', '百度', '', '');
INSERT INTO `et_question` VALUES ('52', '关于影响淘宝综合搜索...', '{\"title\":\"关于影响淘宝综合搜索排名的因素，说法错误的是_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"宝贝属性及类目的相关性\",\"B\":\"宝贝上下架时间\",\"C\":\"店铺DSR评分\",\"D\":\"店铺等级\"}}', '1', null, '0', null, '0', null, 'admin', null, '4', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('55', '以下哪种流量来源属于...', '{\"title\":\"以下哪种流量来源属于淘宝的免费流量_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"直通车\",\"B\":\"淘宝搜索\",\"C\":\"钻石展位\",\"D\":\"淘宝客\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('56', '下面哪个是第三方的数...', '{\"title\":\"下面哪个是第三方的数据分析工具？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"生e经\",\"B\":\"数据魔方\",\"C\":\"生意参谋\",\"D\":\"炫彩主图\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('57', '淘词是哪个工具的功能...', '{\"title\":\"淘词是哪个工具的功能？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"量子恒道\",\"B\":\"淘宝后台\",\"C\":\"生e经\",\"D\":\"数据魔方\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('58', '关于淘宝规则，说法错...', '{\"title\":\"关于淘宝规则，说法错误的是？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"卖家可以和买家约定发货时间\",\"B\":\"天猫卖家可以拒绝开具发票\",\"C\":\"卖家需要遵守淘宝规则，遵守对买家的服务承诺\",\"D\":\"宝贝页面的描述，应该与商品的实际情况相符\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('59', '以下哪个是只有淘宝C...', '{\"title\":\"以下哪个是只有淘宝C店才可以参加的活动？_______?\\u003cbr /\\u003e\\r\\n\\u003cdiv\\u003e\\r\\n\\t\\u003cbr /\\u003e\\r\\n\\u003c/div\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"天天特价\",\"B\":\"聚划算\",\"C\":\"店铺周年庆\",\"D\":\"天猫新风尚\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('60', '严重违规扣分达到多少...', '{\"title\":\"严重违规扣分达到多少分,将被查封账户？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"6分\",\"B\":\"12分\",\"C\":\"24分\",\"D\":\"48分\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('61', '为刺激买家购买多样商...', '{\"title\":\"为刺激买家购买多样商品达到158元后包邮，应该使用什么工具？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"集分宝\",\"B\":\"官方促销工具或者第三方促销工具\",\"C\":\"卖家承担运费\",\"D\":\"搭配套餐\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('62', '参加免费试用需要提供...', '{\"title\":\"参加免费试用需要提供多少试用品？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"1000件\",\"B\":\"1500件\",\"C\":\"3000件\",\"D\":\"价值1500元的商品\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('63', '某店铺今天通过搜索获...', '{\"title\":\"某店铺今天通过搜索获得的UV为50，通过直通车获得UV为80，一共成交了13笔交易，那么下面哪个说法是正确的？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"店铺今天一共获得了80个UV\",\"B\":\"店铺今天的PV为130\",\"C\":\"店铺今天的转化率为10%\",\"D\":\"店铺今天的跳失率为10%\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('64', '下面哪个不属于店铺老...', '{\"title\":\"下面哪个不属于店铺老客户维护工具？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"qq\",\"B\":\"微信\",\"C\":\"短信\",\"D\":\"传真\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('65', '下面哪个跟店铺的DS...', '{\"title\":\"下面哪个跟店铺的DSR动态评分没有关系？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"描述相符\",\"B\":\"服务态度\",\"C\":\"发货速度\",\"D\":\"页面设计\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('66', '商品标题最多可容纳多...', '{\"title\":\"商品标题最多可容纳多少个汉字？多少个字符？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"30，60\",\"B\":\"30，50\",\"C\":\"20，40\",\"D\":\"25，50\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('67', '下面哪个不是老客户管...', '{\"title\":\"下面哪个不是老客户管理常用的方法？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"按消费习惯分\",\"B\":\"按会员等级分\",\"C\":\"按客户年龄分\",\"D\":\"按商品属性分\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('68', '以下哪项不属于老客户...', '{\"title\":\"以下哪项不属于老客户维护？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"讨价还价\",\"B\":\"发货关怀\",\"C\":\"签收关怀\",\"D\":\"使用关怀\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('69', '一般老客户的定义是？...', '{\"title\":\"一般老客户的定义是？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"购买1次以上的买家\",\"B\":\"购买2次以上的买家\",\"C\":\"购买3次以上的买家\",\"D\":\"购买4次以上的买家\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('70', '以下哪个商品标题没有...', '{\"title\":\"以下哪个商品标题没有违反《淘宝规则》？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"李宁运动鞋\",\"B\":\"犀利哥推荐正品T恤\",\"C\":\"正品运动鞋比NIKE好\",\"D\":\"李宁/耐克/阿迪运动鞋\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('71', '设置合理的宝贝标题可...', '{\"title\":\"设置合理的宝贝标题可以达到的主要效果是？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"增加宝贝被点击的机会\",\"B\":\"增加宝贝被搜索到的机会\",\"C\":\"避免交易纠纷\",\"D\":\"使买家深入了解宝贝\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('72', '在淘宝交易中，下列哪...', '{\"title\":\"在淘宝交易中，下列哪些信息可以告诉他人？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"身份信息\",\"B\":\"银行卡信息\",\"C\":\"手机验证码\",\"D\":\"以上均不可告诉\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('73', '卖家通过买家信用分析...', '{\"title\":\"卖家通过买家信用分析,发现店铺的购物人群以新手买家为主,此时应如何优化店铺？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"做好购物引导及售后保障工作\",\"B\":\"加强关联营销\",\"C\":\"注重情感营销\",\"D\":\"降低商品价格\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('74', '活动当天，客服工作的...', '{\"title\":\"活动当天，客服工作的描述哪项是不正确的？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"只卖东西就行,其他都不用管\",\"B\":\"需要接待咨询并卖货\",\"C\":\"需要及时收集用户提出来的问题\",\"D\":\"需要及时把客户的反馈给营销同事进行优化调整\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('75', '以下哪些方面不能提升...', '{\"title\":\"以下哪些方面不能提升客户体验？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"服务\",\"B\":\"专业型\",\"C\":\"人性化\",\"D\":\"性格\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('76', '如果店铺平均访问深度...', '{\"title\":\"如果店铺平均访问深度较低,可以考虑如下那种方式进行优化？_______?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"页面描述优化\",\"B\":\"优化直通车关键词\",\"C\":\"关联推荐\",\"D\":\"优化宝贝标题\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('77', '顾客迟迟没有收到快递...', '{\"title\":\"顾客迟迟没有收到快递，下面哪个原因是因为商家的原因造成的？_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"商家延迟发货\",\"B\":\"天气恶劣原因\",\"C\":\"快递包裹丢失\",\"D\":\"被人偷梁换柱\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('78', '下列关于宝贝详情页优...', '{\"title\":\"下列关于宝贝详情页优化说法错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"可以提升店铺整体形象\",\"B\":\"可以提升转化率\",\"C\":\"可以做到有效分流\",\"D\":\"可以提升宝贝点击率\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('79', '下列关于直通车描述正...', '{\"title\":\"下列关于直通车描述正确的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"是一款付费推广工具\",\"B\":\"最多可以设置4个推广计划\",\"C\":\"直通车推广的产品需要有销量才能进行推广设置\",\"D\":\"每个推广单元可以同时设置三个推广创意\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('80', '下列活动中属于淘宝官...', '{\"title\":\"下列活动中属于淘宝官方活动的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"天天特价\",\"B\":\"折800\",\"C\":\"周年店庆\",\"D\":\"卷皮网\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('81', '以下哪个渠道引入的流...', '{\"title\":\"以下哪个渠道引入的流量在流量来源构成中属于付费流量_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"淘宝免费\",\"B\":\"淘宝客\",\"C\":\"自然搜索\",\"D\":\"类目搜索\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('82', '关于钻石展位下列描述...', '{\"title\":\"关于钻石展位下列描述中说法错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"钻石展位是按照点击付费的\",\"B\":\"钻石展位是按照展现付费的\",\"C\":\"加入钻石展位需要淘宝店,铺达到3钻的信誉\",\"D\":\"店铺中出售的商品需要在10件以上\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('83', '关于微博营销描述不正...', '{\"title\":\"关于微博营销描述不正确的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"微博营销第一步是做好定位\",\"B\":\"可以同时多注册几个微博账号\",\"C\":\"发布微博的内容可以任意定\",\"D\":\"可以通过微博发起一些活动，从而增加店铺流量\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('84', '关于开通钻石展位下列...', '{\"title\":\"关于开通钻石展位下列描述不正确的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"每周四10：00开放报名\",\"B\":\"需要先报名，后考试\",\"C\":\"首次充值需要充值1000元\",\"D\":\"报名后钻展不会提供自学资料\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('85', '下列哪个功能是钻石展...', '{\"title\":\"下列哪个功能是钻石展位的物料库不能实现的_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"展位选择\",\"B\":\"资源位分析\",\"C\":\"创意设置\",\"D\":\"推广计划出价\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('86', '直通车的收费原理是_...', '{\"title\":\"直通车的收费原理是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"按照流量付费\",\"B\":\"按照点击付费\",\"C\":\"按照浏览付费\",\"D\":\"按照成交付费\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('87', '以下关于直通车提高质...', '{\"title\":\"以下关于直通车提高质量得分方法错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"提升关键词相关性\",\"B\":\"提升类目属性相关性\",\"C\":\"提升关键词展现量\",\"D\":\"优化标题图片宝贝\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('88', '一件产品标价1000...', '{\"title\":\"一件产品标价1000元，最终以200元包邮出售，掌柜实际支付邮费为8元。请问最终天猫收取佣金是按照下列哪个基数来计算_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"1000\",\"B\":\"992\",\"C\":\"192\",\"D\":\"200\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('89', '想在店铺中实现客户购...', '{\"title\":\"想在店铺中实现客户购物满500元减50元，应该使用（）工具\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"满件优惠\",\"B\":\"满就送\",\"C\":\"限时打折\",\"D\":\"搭配套餐\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('90', '关于淘金币营销描述错...', '{\"title\":\"关于淘金币营销描述错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"卖家赚取淘金币只有淘金币抵钱功能一个方法\",\"B\":\"卖家可以针对单个商品进行淘金币抵钱设置\",\"C\":\"卖家可以设置签到送淘金币\",\"D\":\"卖家不能设置收藏店铺送淘金币\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('91', '下列付费流量中，按照...', '{\"title\":\"下列付费流量中，按照成交效果付费的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"淘宝客\",\"B\":\"钻石展位\",\"C\":\"定价CPM\",\"D\":\"直通车\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('92', '下列店铺运营环节，哪...', '{\"title\":\"下列店铺运营环节，哪一个属于推广职责范围内的_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"与客户旺旺沟通\",\"B\":\"直通车推广设置\",\"C\":\"详情页设置\",\"D\":\"店铺促销\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('93', '以下微博营销步骤说法...', '{\"title\":\"以下微博营销步骤说法正确的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"定位、账号策略、装修、内容、推广、互动、监测、分析\",\"B\":\"定位、账号策略、内容、推广、互动、、分析\",\"C\":\"定位、账号策略、内容、推广、监测、分析\",\"D\":\"定位、装修。内容、账号策略、推广、互动、监测、分析\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('94', '如果一家店铺昨日的流...', '{\"title\":\"如果一家店铺昨日的流量突降，可能是哪个原因_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"首页装修没做好\",\"B\":\"主推产品不合理\",\"C\":\"报名活动到期\",\"D\":\"店铺活动促销不给力\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('95', '下列针对钻石展位推广...', '{\"title\":\"下列针对钻石展位推广形式说法错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"单品推广\",\"B\":\"活动推广\",\"C\":\"品牌推广\",\"D\":\"页面推广\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('96', '下列哪类产品可以进行...', '{\"title\":\"下列哪类产品可以进行钻石展位推广_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"医疗器械\",\"B\":\"成人用品\",\"C\":\"减肥、丰胸\",\"D\":\"拉杆箱\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('97', '以下哪个不是钻石展位...', '{\"title\":\"以下哪个不是钻石展位的定向推广功能_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"群体定向\",\"B\":\"地域定向\",\"C\":\"兴趣点定向\",\"D\":\"访客定向\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('98', '店铺跳失率比较高可能...', '{\"title\":\"店铺跳失率比较高可能的原因是什么_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"产品问题\",\"B\":\"上下架时间不合理\",\"C\":\"售后关怀比较差\",\"D\":\"客服反应比较慢\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('99', '店铺流量比较差，下列...', '{\"title\":\"店铺流量比较差，下列优化方法错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"优化标题，增加精准流量词\",\"B\":\"优化主推产品主图\",\"C\":\"增加详情页面关联销售\",\"D\":\"优化产品上下架时间\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('100', '阿里巴巴诚信通店铺推...', '{\"title\":\"阿里巴巴诚信通店铺推广方式描述错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"网销宝\",\"B\":\"黄金展位\",\"C\":\"精准营销\",\"D\":\"直通车\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('101', '关于微淘描述错误的是...', '{\"title\":\"关于微淘描述错误的是_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"可以帮助商家维护老客户\",\"B\":\"可以推广店铺商品\",\"C\":\"商家可以每天给粉丝发送多条信息\",\"D\":\"卖家账号不能成为微淘达人\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('102', '订单催付可以带来__...', '{\"title\":\"订单催付可以带来_______\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"高的销售额\",\"B\":\"流量提升\",\"C\":\"新流量\",\"D\":\"高客单价\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('103', '使用直通车引流，一个...', '{\"title\":\"使用直通车引流，一个掌柜最多能推广多少个宝贝？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"没有限制\",\"B\":\"10 个\",\"C\":\"100 个\",\"D\":\"200 个\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('104', '淘词是在哪个软件里的...', '{\"title\":\"淘词是在哪个软件里的功能？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"小艾分析\",\"B\":\"淘宝后台\",\"C\":\"生意经\",\"D\":\"数据魔方\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('105', '淘宝客在哪里获取到卖...', '{\"title\":\"淘宝客在哪里获取到卖家商品的推广链接？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"卖家店铺\",\"B\":\"自己店铺\",\"C\":\"淘宝联盟\",\"D\":\"与店铺主旺旺联系\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('106', '量子恒道店铺统计中的...', '{\"title\":\"量子恒道店铺统计中的访问深度是指?\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"用户一次连续访问的总时长\",\"B\":\"用户一次连续访问的页面数\",\"C\":\"当日店铺的浏览量\",\"D\":\"当日店铺的访客数\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('107', '快下架的宝贝太多了，...', '{\"title\":\"快下架的宝贝太多了，橱窗推荐位不够用，我们应该优先推荐什么样的产品呢？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"宝贝描述比较多的\",\"B\":\"评价一般的\",\"C\":\"销量高的，转化率高的\",\"D\":\"价格最高的\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('108', '下列哪个因素不会影响...', '{\"title\":\"下列哪个因素不会影响钻展流量的购买\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"预算\",\"B\":\"出价\",\"C\":\"定向加价\",\"D\":\"店铺信誉\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('109', '量子恒道店铺统计中的...', '{\"title\":\"量子恒道店铺统计中的浏览回头客是指\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"曾经来店铺浏览过的客户\",\"B\":\"近一年内来店铺浏览过的客户\",\"C\":\"6 日内来店铺内浏览过的客户\",\"D\":\"2 个小时内来店铺内浏览过的客户\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('110', '下面哪一项能力对于推...', '{\"title\":\"下面哪一项能力对于推广人员是不重要的\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"数据分析能力\",\"B\":\"运营意识\",\"C\":\"营销意识\",\"D\":\"产品图片设计\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('111', '钻石展位投放数据中的...', '{\"title\":\"钻石展位投放数据中的 CPM 指的是\\u0026nbsp;\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"每千次浏览单价\",\"B\":\"每千次点击收费\",\"C\":\"每次点击单价\",\"D\":\"每次浏览单价\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('112', '哪些方法能使自己的手...', '{\"title\":\"哪些方法能使自己的手机店铺流量增加？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"用一阳指装修手机店铺，并将手机店铺告知客户\",\"B\":\"在 PC 端店铺增加旺铺无线二维码模块\",\"C\":\"报名参加手机淘宝官方活动\",\"D\":\"以上都可以\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('113', '店铺流量中的免费搜索...', '{\"title\":\"店铺流量中的免费搜索包含哪些搜索？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"广告投放\",\"B\":\"类目搜索和关键词搜索\",\"C\":\"关键词搜索\",\"D\":\"类目搜索\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('114', '淘宝上的宝贝标题是多...', '{\"title\":\"淘宝上的宝贝标题是多少个字组成的？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"20 个\",\"B\":\"30 个汉字，60 个字符，标点符号是 1 个字符，汉字是 2 个字符\",\"C\":\"10 个\",\"D\":\"60 个\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('115', '小明参加天天特价报名...', '{\"title\":\"小明参加天天特价报名活动失败了，因为天天特价要求宝贝是实物交易的达到多少百分比以上？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"没有要求\",\"B\":\"10%\",\"C\":\"20%\",\"D\":\"90%\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('116', '推广最重要的工作职责...', '{\"title\":\"推广最重要的工作职责是\\u0026nbsp;\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"引进流量\",\"B\":\"销售接单\",\"C\":\"图片设计\",\"D\":\"店铺客服\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('117', '对已经在淘宝客推广中...', '{\"title\":\"对已经在淘宝客推广中的商品，可以做哪些动作？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"修改商品价格\",\"B\":\"修改佣金\",\"C\":\"修改库存\",\"D\":\"以上都可以\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('118', '当我们要看直通车的投...', '{\"title\":\"当我们要看直通车的投入产出比时，我们要看什么数据？（ \\u0026nbsp;）\\u0026nbsp;\\u003cbr /\\u003e\\r\\n\\u003cdiv\\u003e\\r\\n\\t\\u003cbr /\\u003e\\r\\n\\u003c/div\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"销售排行榜\",\"B\":\"访客分析\",\"C\":\"客户流失分析\",\"D\":\"转化数据\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('119', '关联销售可以降低店铺...', '{\"title\":\"关联销售可以降低店铺的\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"转化率\",\"B\":\"响应速度\",\"C\":\"流量\",\"D\":\"推广成本\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('120', '关键词堆砌属于关键词...', '{\"title\":\"关键词堆砌属于关键词三宗罪中的那一罪？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"错字\",\"B\":\"滥用\",\"C\":\"违规\",\"D\":\"重复\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('121', '某宝贝 7 天总流量...', '{\"title\":\"某宝贝 7 天总流量是 2000 个，这段时间总成交了 40 笔，每笔的利润是 20 元，请问，该宝贝的流量价值是多少？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"0.4\",\"B\":\"0.2\",\"C\":\"0.1\",\"D\":\"0.5\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('122', '淘宝客推广是哪种付费...', '{\"title\":\"淘宝客推广是哪种付费模式？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"CPC\",\"B\":\"CPT\",\"C\":\"CPS\",\"D\":\"CPM\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('123', '直通车引流，在设置地...', '{\"title\":\"直通车引流，在设置地域时，可以投放到哪一级的地域？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"可以投放到市级地域\",\"B\":\"只能投放全国\",\"C\":\"只能投放到省\",\"D\":\"可以投放县级地域\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('124', 'sns 营销类型不正...', '{\"title\":\"sns 营销类型不正确的是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"为目标受众群定制的显示广告\",\"B\":\"与社交游戏场景融合的植入广告\",\"C\":\"利用口碑传播的体验型广告\",\"D\":\"就是普通的广告，和以前的形式没有差别。\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('125', '小明想要领取店铺的优...', '{\"title\":\"小明想要领取店铺的优惠劵，但他不可能领到的券面额为多少元的优惠卷呢？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"5 元\",\"B\":\"50 元\",\"C\":\"60 元\",\"D\":\"100 元\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('126', '钻石展位按照什么顺序...', '{\"title\":\"钻石展位按照什么顺序进行展现\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"预算多少\",\"B\":\"出价高低\",\"C\":\"创意多少\",\"D\":\"点击率高低\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('127', '通过客户的近期从浏览...', '{\"title\":\"通过客户的近期从浏览到购买的行为，客户的购买频率以及购买金额三项指标来描述该客户的价值，分别可以帮助我们衡量客户的哪些指标？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"流失度\",\"B\":\"活跃度\",\"C\":\"忠诚度\",\"D\":\"消费能力\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('128', 'SNS 的作用有哪些...', '{\"title\":\"SNS 的作用有哪些？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"维护、拓展社会关系\",\"B\":\"形成数量庞大的个人社区\",\"C\":\"基于真实关系的现实应用\",\"D\":\"开展各种线上线下活动\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('129', '推广宝贝直通车标题跟...', '{\"title\":\"推广宝贝直通车标题跟店铺标题的关系说法错误的是？()\\u0026nbsp;\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"两个标题必须一模一样\",\"B\":\"两个标题可以不一样\",\"C\":\"两个标题都要求在 10 个字内\",\"D\":\"两个标题的描述一定要和商品相符合\"}}', '2', null, '0', null, '0', null, 'admin', null, 'AC', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('130', '如果一家店铺昨日的流...', '{\"title\":\"如果一家店铺昨日的流量突降，他可以从量子里的哪里找原因？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"来源分析中的访客分析\",\"B\":\"标准包中的来源构成报表\",\"C\":\"标准包中的流量概况报表\",\"D\":\"标准包的当前实时访问报表\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABC', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('131', '以下关于钻石展位定义...', '{\"title\":\"以下关于钻石展位定义的描述，正确的是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"精选了淘宝和互联网优质展示位\",\"B\":\"按照竞价排序\",\"C\":\"按照点击计费\",\"D\":\"按照展现计费\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('132', '淘宝搜索页面，所有宝...', '{\"title\":\"淘宝搜索页面，所有宝贝搜索页下除了综合搜索以外，还有那些筛选搜索选项？\\u003cbr /\\u003e\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"人气\",\"B\":\"销量\",\"C\":\"厂家\",\"D\":\"价格\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('133', '聚划算商品展示时的短...', '{\"title\":\"聚划算商品展示时的短标题，要求是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"标题必需要是品牌名+生产厂家名称的格式\",\"B\":\"在字数条件允许的前提下可适当添加营销文案，但一定要在规定内容之后显示\",\"C\":\"可以同时使用中英文品牌名\",\"D\":\"不得使用“专供”“特供”“最佳”等容易产生误导的字眼\"}}', '2', null, '0', null, '0', null, 'admin', null, 'BD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('134', '下列那些因素会促使免...', '{\"title\":\"下列那些因素会促使免费流量下降\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"标题关键词堆砌\",\"B\":\"放错属性\",\"C\":\"橱窗推荐\",\"D\":\"滥用品牌词\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('135', '淘宝客喜欢选择什么样...', '{\"title\":\"淘宝客喜欢选择什么样的宝贝进行推广\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"宝贝转化比较低\",\"B\":\"宝贝佣金比较低的\",\"C\":\"宝贝佣金高的，转化高的\",\"D\":\"宝贝 30 天淘宝客推广销售量多的\"}}', '2', null, '0', null, '0', null, 'admin', null, 'CD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('136', '小新是一家女装店的售...', '{\"title\":\"小新是一家女装店的售后客服,一个客户旺旺咨询他买的裤子是否已经发货。他在跟进回复客户时要注意的原则有\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"要快速\",\"B\":\"要热情\",\"C\":\"要有诚意\",\"D\":\"要跟售前客服确认\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('137', '细节图片的目的和作用', '{\"title\":\"细节图片的目的和作用\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"让买家进一步了解产品信息\",\"B\":\"展示产品不同的、必要的信息\",\"C\":\"说明产品的大小\",\"D\":\"展示产品的功能\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('138', '店铺为什么要做买家分...', '{\"title\":\"店铺为什么要做买家分析\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"可以更好了解买家特点\",\"B\":\"挖掘买家需求\",\"C\":\"提高广告投放精准度\",\"D\":\"帮助买家解决难题\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('139', '网店推广活动的效果一...', '{\"title\":\"网店推广活动的效果一般可以体现在哪些方面？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"整个店铺的流量\",\"B\":\"在活动周期内给网店带来的客户数\",\"C\":\"实际成交额\",\"D\":\"获得了很多用户反馈的信息\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABCD', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('140', '参加直通车活动应该掌...', '{\"title\":\"参加直通车活动应该掌握的基本要求包括哪些？\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"产品图片要求\",\"B\":\"产品推广的标题描述要求\",\"C\":\"店铺的要求,店铺信用评价和销售记录\",\"D\":\"公司实力和知名度需要达到一定的水平\"}}', '2', null, '0', null, '0', null, 'admin', null, 'ABC', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('141', '下列哪种格式是ps独...', '{\"title\":\"下列哪种格式是ps独有的\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"Psd\",\"B\":\"Jpeg\",\"C\":\"TIFF\",\"D\":\"GIF\"}}', '1', null, '0', null, '0', null, 'admin', null, 'A', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('142', '以下不属于购物类论坛...', '{\"title\":\"以下不属于购物类论坛的是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"淘宝帮派\",\"B\":\"阿里巴巴商人社区\",\"C\":\"天涯\",\"D\":\"淘宝圈子\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('143', '店铺各页面被查看的次...', '{\"title\":\"店铺各页面被查看的次数就是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"访客数\",\"B\":\"成交转化率\",\"C\":\"浏览回头客\",\"D\":\"浏览量\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('144', '在淘宝数据中，UV的...', '{\"title\":\"在淘宝数据中，UV的含义是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"既页面浏览次数\",\"B\":\"独立访问者\",\"C\":\"关键词被搜索次数\",\"D\":\"指用户一次访问店铺的页面数\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('145', '宝贝主副图片、宝贝描...', '{\"title\":\"宝贝主副图片、宝贝描述中的图片、店铺装修等使用的图片不是自己拍摄的图片，或者所使用的图片没有拥有使用权，这种情况每次扣几分\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"8分\",\"B\":\"6分\",\"C\":\"4分\",\"D\":\"2分\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('146', '运营在店铺里不需要起...', '{\"title\":\"运营在店铺里不需要起到的作用是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"管理作用\",\"B\":\"监督作用\",\"C\":\"分工作用\",\"D\":\"客服作用\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('147', '活动促销的本质是什么', '{\"title\":\"活动促销的本质是什么\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"免单\",\"B\":\"秒杀\",\"C\":\"折扣\",\"D\":\"销售\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('148', '以下关于详情页说法，...', '{\"title\":\"以下关于详情页说法，正确的是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"作为设计师一定要用图说话，所以宝贝详情页都要做成图片，以吸引买家\",\"B\":\"以细节图片和文字无限放大产品卖点，一般工艺，材质等细节说明，让买家更多了解展示宝贝的部分效果\",\"C\":\"产品类比就是与同类商品进行比较，挖掘本商品与其他商品的不同优势\",\"D\":\"为了增强买家对商品的信任度，截图放上大量好评以增强产品的信任感\"}}', '1', null, '0', null, '0', null, 'admin', null, 'C', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('149', '直通车的扣费原理是', '{\"title\":\"直通车的扣费原理是\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"按照展现量\",\"B\":\"按照展现时长\",\"C\":\"按照佣金比例\",\"D\":\"按照点击扣费\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('150', '下面那一组属自主访问...', '{\"title\":\"下面那一组属自主访问流量\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"搜索引擎\",\"B\":\"购物车\",\"C\":\"一淘搜索\",\"D\":\"商城首页\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('151', '以下那个选项不属于店...', '{\"title\":\"以下那个选项不属于店铺中的页面管理\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"店铺基础页\",\"B\":\"店铺标签页\",\"C\":\"宝贝列表页\",\"D\":\"宝贝详情页\"}}', '1', null, '0', null, '0', null, 'admin', null, 'B', '2', '1', '1', '1', '', '', '', '');
INSERT INTO `et_question` VALUES ('152', '通过什么途径可以找到...', '{\"title\":\"通过什么途径可以找到直通车热搜词排名\",\"titleImg\":\"\",\"choiceList\":{\"A\":\"生意经\",\"B\":\"淘宝搜索\",\"C\":\"生意参谋\",\"D\":\"直通车后台\"}}', '1', null, '0', null, '0', null, 'admin', null, 'D', '2', '1', '1', '1', '', '', '', '');

-- ----------------------------
-- Table structure for et_question_2_point
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_point`;
CREATE TABLE `et_question_2_point` (
  `question_2_point_id` int(10) NOT NULL AUTO_INCREMENT,
  `question_id` int(10) DEFAULT NULL,
  `point_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`question_2_point_id`),
  KEY `fk_question_111` (`question_id`),
  KEY `fk_point_111` (`point_id`),
  CONSTRAINT `et_question_2_point_ibfk_1` FOREIGN KEY (`point_id`) REFERENCES `et_knowledge_point` (`point_id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_point_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=154 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_2_point
-- ----------------------------
INSERT INTO `et_question_2_point` VALUES ('51', '51', '5');
INSERT INTO `et_question_2_point` VALUES ('53', '52', '5');
INSERT INTO `et_question_2_point` VALUES ('56', '55', '5');
INSERT INTO `et_question_2_point` VALUES ('57', '56', '5');
INSERT INTO `et_question_2_point` VALUES ('58', '57', '5');
INSERT INTO `et_question_2_point` VALUES ('59', '58', '5');
INSERT INTO `et_question_2_point` VALUES ('60', '59', '5');
INSERT INTO `et_question_2_point` VALUES ('61', '60', '5');
INSERT INTO `et_question_2_point` VALUES ('62', '61', '5');
INSERT INTO `et_question_2_point` VALUES ('63', '62', '5');
INSERT INTO `et_question_2_point` VALUES ('64', '63', '5');
INSERT INTO `et_question_2_point` VALUES ('65', '64', '5');
INSERT INTO `et_question_2_point` VALUES ('66', '65', '5');
INSERT INTO `et_question_2_point` VALUES ('67', '66', '5');
INSERT INTO `et_question_2_point` VALUES ('68', '67', '5');
INSERT INTO `et_question_2_point` VALUES ('69', '68', '5');
INSERT INTO `et_question_2_point` VALUES ('70', '69', '5');
INSERT INTO `et_question_2_point` VALUES ('71', '70', '5');
INSERT INTO `et_question_2_point` VALUES ('72', '71', '5');
INSERT INTO `et_question_2_point` VALUES ('73', '72', '5');
INSERT INTO `et_question_2_point` VALUES ('74', '73', '5');
INSERT INTO `et_question_2_point` VALUES ('75', '74', '5');
INSERT INTO `et_question_2_point` VALUES ('76', '75', '5');
INSERT INTO `et_question_2_point` VALUES ('77', '76', '5');
INSERT INTO `et_question_2_point` VALUES ('78', '77', '5');
INSERT INTO `et_question_2_point` VALUES ('79', '78', '5');
INSERT INTO `et_question_2_point` VALUES ('80', '79', '5');
INSERT INTO `et_question_2_point` VALUES ('81', '80', '5');
INSERT INTO `et_question_2_point` VALUES ('82', '81', '5');
INSERT INTO `et_question_2_point` VALUES ('83', '82', '5');
INSERT INTO `et_question_2_point` VALUES ('84', '83', '5');
INSERT INTO `et_question_2_point` VALUES ('85', '84', '5');
INSERT INTO `et_question_2_point` VALUES ('86', '85', '5');
INSERT INTO `et_question_2_point` VALUES ('87', '86', '5');
INSERT INTO `et_question_2_point` VALUES ('88', '87', '5');
INSERT INTO `et_question_2_point` VALUES ('89', '88', '5');
INSERT INTO `et_question_2_point` VALUES ('90', '89', '5');
INSERT INTO `et_question_2_point` VALUES ('91', '90', '5');
INSERT INTO `et_question_2_point` VALUES ('92', '91', '5');
INSERT INTO `et_question_2_point` VALUES ('93', '92', '5');
INSERT INTO `et_question_2_point` VALUES ('94', '93', '5');
INSERT INTO `et_question_2_point` VALUES ('95', '94', '5');
INSERT INTO `et_question_2_point` VALUES ('96', '95', '5');
INSERT INTO `et_question_2_point` VALUES ('97', '96', '5');
INSERT INTO `et_question_2_point` VALUES ('98', '97', '5');
INSERT INTO `et_question_2_point` VALUES ('99', '98', '5');
INSERT INTO `et_question_2_point` VALUES ('100', '99', '5');
INSERT INTO `et_question_2_point` VALUES ('101', '100', '5');
INSERT INTO `et_question_2_point` VALUES ('102', '101', '5');
INSERT INTO `et_question_2_point` VALUES ('103', '102', '5');
INSERT INTO `et_question_2_point` VALUES ('104', '103', '5');
INSERT INTO `et_question_2_point` VALUES ('105', '104', '5');
INSERT INTO `et_question_2_point` VALUES ('106', '105', '5');
INSERT INTO `et_question_2_point` VALUES ('107', '106', '5');
INSERT INTO `et_question_2_point` VALUES ('108', '107', '5');
INSERT INTO `et_question_2_point` VALUES ('109', '108', '5');
INSERT INTO `et_question_2_point` VALUES ('110', '109', '5');
INSERT INTO `et_question_2_point` VALUES ('111', '110', '5');
INSERT INTO `et_question_2_point` VALUES ('112', '111', '5');
INSERT INTO `et_question_2_point` VALUES ('113', '112', '5');
INSERT INTO `et_question_2_point` VALUES ('114', '113', '5');
INSERT INTO `et_question_2_point` VALUES ('115', '114', '5');
INSERT INTO `et_question_2_point` VALUES ('116', '115', '5');
INSERT INTO `et_question_2_point` VALUES ('117', '116', '5');
INSERT INTO `et_question_2_point` VALUES ('118', '117', '5');
INSERT INTO `et_question_2_point` VALUES ('119', '118', '5');
INSERT INTO `et_question_2_point` VALUES ('120', '119', '5');
INSERT INTO `et_question_2_point` VALUES ('121', '120', '5');
INSERT INTO `et_question_2_point` VALUES ('122', '121', '5');
INSERT INTO `et_question_2_point` VALUES ('123', '122', '5');
INSERT INTO `et_question_2_point` VALUES ('124', '123', '5');
INSERT INTO `et_question_2_point` VALUES ('125', '124', '5');
INSERT INTO `et_question_2_point` VALUES ('126', '125', '5');
INSERT INTO `et_question_2_point` VALUES ('127', '126', '5');
INSERT INTO `et_question_2_point` VALUES ('128', '127', '5');
INSERT INTO `et_question_2_point` VALUES ('129', '128', '5');
INSERT INTO `et_question_2_point` VALUES ('130', '129', '5');
INSERT INTO `et_question_2_point` VALUES ('131', '130', '5');
INSERT INTO `et_question_2_point` VALUES ('132', '131', '5');
INSERT INTO `et_question_2_point` VALUES ('133', '132', '5');
INSERT INTO `et_question_2_point` VALUES ('134', '133', '5');
INSERT INTO `et_question_2_point` VALUES ('135', '134', '5');
INSERT INTO `et_question_2_point` VALUES ('136', '135', '5');
INSERT INTO `et_question_2_point` VALUES ('137', '136', '5');
INSERT INTO `et_question_2_point` VALUES ('138', '137', '5');
INSERT INTO `et_question_2_point` VALUES ('139', '138', '5');
INSERT INTO `et_question_2_point` VALUES ('140', '139', '5');
INSERT INTO `et_question_2_point` VALUES ('141', '140', '5');
INSERT INTO `et_question_2_point` VALUES ('142', '141', '5');
INSERT INTO `et_question_2_point` VALUES ('143', '142', '5');
INSERT INTO `et_question_2_point` VALUES ('144', '143', '5');
INSERT INTO `et_question_2_point` VALUES ('145', '144', '5');
INSERT INTO `et_question_2_point` VALUES ('146', '145', '5');
INSERT INTO `et_question_2_point` VALUES ('147', '146', '5');
INSERT INTO `et_question_2_point` VALUES ('148', '147', '5');
INSERT INTO `et_question_2_point` VALUES ('149', '148', '5');
INSERT INTO `et_question_2_point` VALUES ('150', '149', '5');
INSERT INTO `et_question_2_point` VALUES ('151', '150', '5');
INSERT INTO `et_question_2_point` VALUES ('152', '151', '5');
INSERT INTO `et_question_2_point` VALUES ('153', '152', '5');

-- ----------------------------
-- Table structure for et_question_2_tag
-- ----------------------------
DROP TABLE IF EXISTS `et_question_2_tag`;
CREATE TABLE `et_question_2_tag` (
  `question_tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`question_tag_id`),
  KEY `fk_question_tag_tid` (`tag_id`),
  KEY `fk_question_tag_qid` (`question_id`),
  CONSTRAINT `et_question_2_tag_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE,
  CONSTRAINT `et_question_2_tag_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `et_tag` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_2_tag
-- ----------------------------

-- ----------------------------
-- Table structure for et_question_type
-- ----------------------------
DROP TABLE IF EXISTS `et_question_type`;
CREATE TABLE `et_question_type` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `subjective` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_question_type
-- ----------------------------
INSERT INTO `et_question_type` VALUES ('1', '单选题', '0');
INSERT INTO `et_question_type` VALUES ('2', '多选题', '0');
INSERT INTO `et_question_type` VALUES ('3', '判断题', '0');
INSERT INTO `et_question_type` VALUES ('4', '填空题', '0');
INSERT INTO `et_question_type` VALUES ('5', '简答题', '1');
INSERT INTO `et_question_type` VALUES ('6', '论述题', '1');
INSERT INTO `et_question_type` VALUES ('7', '分析题', '1');

-- ----------------------------
-- Table structure for et_reference
-- ----------------------------
DROP TABLE IF EXISTS `et_reference`;
CREATE TABLE `et_reference` (
  `reference_id` int(5) NOT NULL,
  `reference_name` varchar(200) NOT NULL,
  `memo` varchar(200) DEFAULT NULL,
  `state` decimal(10,0) NOT NULL DEFAULT '1' COMMENT '1 正常 0 废弃',
  PRIMARY KEY (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_reference
-- ----------------------------

-- ----------------------------
-- Table structure for et_role
-- ----------------------------
DROP TABLE IF EXISTS `et_role`;
CREATE TABLE `et_role` (
  `id` int(11) NOT NULL,
  `authority` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `code` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_role
-- ----------------------------
INSERT INTO `et_role` VALUES ('1', 'ROLE_ADMIN', '超级管理员', 'admin');
INSERT INTO `et_role` VALUES ('2', 'ROLE_TEACHER', '教师', 'teacher');
INSERT INTO `et_role` VALUES ('3', 'ROLE_STUDENT', '学员', 'student');

-- ----------------------------
-- Table structure for et_tag
-- ----------------------------
DROP TABLE IF EXISTS `et_tag`;
CREATE TABLE `et_tag` (
  `tag_id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(100) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` int(11) NOT NULL,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `memo` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `fk_tag_creator` (`creator`),
  CONSTRAINT `et_tag_ibfk_1` FOREIGN KEY (`creator`) REFERENCES `et_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_tag
-- ----------------------------
INSERT INTO `et_tag` VALUES ('3', '易错题', '2015-08-07 20:42:00', '1', '0', '易错题');
INSERT INTO `et_tag` VALUES ('4', '简单', '2015-08-16 17:46:42', '1', '0', '简单');
INSERT INTO `et_tag` VALUES ('6', '送分题', '2015-08-16 22:23:59', '1', '0', '送分题');

-- ----------------------------
-- Table structure for et_training
-- ----------------------------
DROP TABLE IF EXISTS `et_training`;
CREATE TABLE `et_training` (
  `training_id` int(11) NOT NULL AUTO_INCREMENT,
  `training_name` varchar(40) NOT NULL,
  `training_desc` mediumtext,
  `is_private` tinyint(1) NOT NULL DEFAULT '0',
  `field_id` int(11) NOT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` int(11) DEFAULT NULL COMMENT '创建人',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0:未发布；1：发布；2：失效',
  `state_time` timestamp NULL DEFAULT NULL,
  `exp_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`training_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_training
-- ----------------------------

-- ----------------------------
-- Table structure for et_training_section
-- ----------------------------
DROP TABLE IF EXISTS `et_training_section`;
CREATE TABLE `et_training_section` (
  `section_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1',
  `section_name` varchar(200) NOT NULL,
  `section_desc` mediumtext,
  `training_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  `file_md5` varchar(200) DEFAULT NULL,
  `file_type` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_training_section
-- ----------------------------

-- ----------------------------
-- Table structure for et_user
-- ----------------------------
DROP TABLE IF EXISTS `et_user`;
CREATE TABLE `et_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'PK',
  `user_name` varchar(50) NOT NULL COMMENT '账号',
  `true_name` varchar(50) NOT NULL COMMENT '真实姓名',
  `national_id` varchar(20) NOT NULL,
  `password` char(80) NOT NULL,
  `email` varchar(60) NOT NULL,
  `phone_num` varchar(20) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` int(11) DEFAULT NULL COMMENT '创建人',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '激活状态：0-未激活 1-激活',
  `field_id` int(10) NOT NULL,
  `last_login_time` timestamp NULL DEFAULT NULL,
  `login_time` timestamp NULL DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL COMMENT '1',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_user_uid` (`user_name`),
  KEY `idx_user_national_id` (`national_id`),
  KEY `idx_user_email` (`email`),
  KEY `idx_user_phone` (`phone_num`)
) ENGINE=InnoDB AUTO_INCREMENT=4715 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of et_user
-- ----------------------------
INSERT INTO `et_user` VALUES ('1', 'admin', 'admin', '000000000000000000', '260acbffd3c30786febc29d7dd71a9880a811e77', '1111@111.com', '18908600000', '2015-09-29 14:38:23', '0', '1', '1', '2015-08-06 11:31:34', '2015-08-06 11:31:50', '', '');
INSERT INTO `et_user` VALUES ('2', 'student', '学员', '420000000000000000', '3f70af5072e23c9bf59dd1ac1c91f9f8fcc81478', '133@189.cn', '13333333333', '2015-12-11 21:32:07', '1', '1', '0', '2015-08-06 11:31:34', '2015-08-06 11:31:34', '', '');
INSERT INTO `et_user` VALUES ('4714', 'guanghui', '广辉', '123456789123456789', '9e80005893001f3545c8492d15e47b48db466b5a', '11531113333@qq.com', '15311133331', '2017-07-06 10:59:01', '1', '1', '0', null, null, null, '');

-- ----------------------------
-- Table structure for et_user_2_department
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_department`;
CREATE TABLE `et_user_2_department` (
  `user_id` int(11) NOT NULL,
  `dep_id` int(11) NOT NULL,
  KEY `fk_ud_uid` (`user_id`),
  KEY `fk_ud_did` (`dep_id`),
  CONSTRAINT `fk_ud_did` FOREIGN KEY (`dep_id`) REFERENCES `et_department` (`dep_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ud_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_department
-- ----------------------------
INSERT INTO `et_user_2_department` VALUES ('2', '1');

-- ----------------------------
-- Table structure for et_user_2_group
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_group`;
CREATE TABLE `et_user_2_group` (
  `group_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_admin` tinyint(4) DEFAULT '0',
  UNIQUE KEY `idx_user_guid` (`group_id`,`user_id`) USING BTREE,
  KEY `idx_user_gid` (`group_id`),
  KEY `idx_user_uid` (`user_id`),
  CONSTRAINT `fk_et_user_group_et_group_1` FOREIGN KEY (`group_id`) REFERENCES `et_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_et_user_group_et_user_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_group
-- ----------------------------
INSERT INTO `et_user_2_group` VALUES ('1', '2', '2015-12-11 22:31:58', '0');

-- ----------------------------
-- Table structure for et_user_2_role
-- ----------------------------
DROP TABLE IF EXISTS `et_user_2_role`;
CREATE TABLE `et_user_2_role` (
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `et_r_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_user_rid` FOREIGN KEY (`role_id`) REFERENCES `et_role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_2_role
-- ----------------------------
INSERT INTO `et_user_2_role` VALUES ('1', '1');
INSERT INTO `et_user_2_role` VALUES ('2', '3');
INSERT INTO `et_user_2_role` VALUES ('4714', '2');

-- ----------------------------
-- Table structure for et_user_exam_history
-- ----------------------------
DROP TABLE IF EXISTS `et_user_exam_history`;
CREATE TABLE `et_user_exam_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `exam_id` int(10) NOT NULL,
  `exam_paper_id` int(10) NOT NULL,
  `enabled` tinyint(4) DEFAULT NULL,
  `point` int(5) DEFAULT '0',
  `seri_no` varchar(100) NOT NULL,
  `content` mediumtext,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `answer_sheet` mediumtext,
  `duration` int(10) NOT NULL,
  `point_get` float(10,1) NOT NULL DEFAULT '0.0',
  `submit_time` timestamp NULL DEFAULT NULL,
  `approved` tinyint(4) DEFAULT '0',
  `verify_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_exam_his_seri_no` (`seri_no`),
  UNIQUE KEY `idx_exam_pid` (`exam_id`,`exam_paper_id`,`user_id`) USING BTREE,
  KEY `fk_exam_his_uid` (`user_id`),
  KEY `fk_exam_paper_id` (`exam_paper_id`),
  CONSTRAINT `fk_exam_his_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`),
  CONSTRAINT `fk_exam_id` FOREIGN KEY (`exam_id`) REFERENCES `et_exam` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_exam_paper_id` FOREIGN KEY (`exam_paper_id`) REFERENCES `et_exam_paper` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_exam_history
-- ----------------------------

-- ----------------------------
-- Table structure for et_user_question_history
-- ----------------------------
DROP TABLE IF EXISTS `et_user_question_history`;
CREATE TABLE `et_user_question_history` (
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_type_id` int(11) NOT NULL,
  `is_right` tinyint(4) NOT NULL DEFAULT '1',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `idx_hist_uqid` (`question_id`,`user_id`) USING BTREE,
  KEY `fk_hist_uid` (`user_id`),
  KEY `fk_hist_qid` (`question_id`),
  CONSTRAINT `fk_hist_qid` FOREIGN KEY (`question_id`) REFERENCES `et_question` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_hist_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of et_user_question_history
-- ----------------------------

-- ----------------------------
-- Table structure for et_user_training_history
-- ----------------------------
DROP TABLE IF EXISTS `et_user_training_history`;
CREATE TABLE `et_user_training_history` (
  `training_id` int(11) NOT NULL COMMENT '培训ID',
  `section_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `duration` float(11,4) NOT NULL DEFAULT '0.0000',
  `process` float(11,2) NOT NULL,
  `start_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `last_state_time` timestamp NULL DEFAULT NULL,
  `user_training_detail` mediumtext,
  PRIMARY KEY (`section_id`,`user_id`),
  UNIQUE KEY `et_r_user_training_history_uk_1` (`user_id`,`section_id`) USING BTREE,
  CONSTRAINT `fk_user_training_history_sid` FOREIGN KEY (`section_id`) REFERENCES `et_training_section` (`section_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_training_history_uid` FOREIGN KEY (`user_id`) REFERENCES `et_user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户培训历史记录';

-- ----------------------------
-- Records of et_user_training_history
-- ----------------------------

-- ----------------------------
-- Table structure for et_view_type
-- ----------------------------
DROP TABLE IF EXISTS `et_view_type`;
CREATE TABLE `et_view_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='培训视图表现形式';

-- ----------------------------
-- Records of et_view_type
-- ----------------------------
INSERT INTO `et_view_type` VALUES ('1', 'PDF');
INSERT INTO `et_view_type` VALUES ('2', 'PPT');
INSERT INTO `et_view_type` VALUES ('3', 'WORD');
INSERT INTO `et_view_type` VALUES ('4', 'TXT');
INSERT INTO `et_view_type` VALUES ('5', 'SWF');
INSERT INTO `et_view_type` VALUES ('6', 'EXCEL');
INSERT INTO `et_view_type` VALUES ('7', 'MP4');
INSERT INTO `et_view_type` VALUES ('8', 'FLV');

-- ----------------------------
-- Table structure for t_c3p0
-- ----------------------------
DROP TABLE IF EXISTS `t_c3p0`;
CREATE TABLE `t_c3p0` (
  `a` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_c3p0
-- ----------------------------
