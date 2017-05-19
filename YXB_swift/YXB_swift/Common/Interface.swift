//
//  Interface.swift
//  YXB_swift
//
//  Created by jointem on 2017/5/4.
//  Copyright © 2017年 NightOwl. All rights reserved.
//

import Foundation



let INTE_VERSION = "1.0.1"
//FIXME:Commom
//获取网络数据成功
let CODE_SUCCESS = "000000"
/**入参有误**/
let CODE_FAILURE = "000001"
/**token 过期**/
let CODE_TOKEN_INVALID = "000002"
/**未知错误**/
let CODE_UNKNOW_ERROR = "000003"
/**操作失败**/
let CODE_RESULT_REPEAT = "000004"
/**用户名或密码错误**/
let CODE_FAILED_USERNAME_PWD = "000005"
/**账号被停用**/
let CODE_DISABLE_ACCOUNT = "000006"

#if false
    //MARK: 测试地址
let APIAddress = "http://172.31.60.187/yxb"
let PhotoAddress = "http://172.31.60.187/img"
    
    
    
#else
    //MARK: 生产地址
let APIAddress  = "http://yxb.jointem.com/yxb"
let PhotoAddress  = "http://yxb.jointem.com/img"
    
#endif

//标志是否使用假数据,1为使用假数据,0为不使用假数据

//MARK: --用户绑定个推
let BIND_CLOUD_SUCCESS = "/m/sys/bindCloudSuccess"
let GET_UPDATE_INFO = "/public/sys/getUpdateInfo_v1_3_3"
//MARK: --通讯录模块
//通讯录联系人获取地址 //1.3.3 2016-10-26 zxl
let ADDRESSBOOK = "/m/org/getAddressBook_v1_3_3"
/** 联系人 按组织架构查询/切换对象按部门选择接口（new） */ 
let GET_USERGROUP = "/m/org/getUserGroupByOrg_v1_3_3"
/** 选择部门下所有人员接口（new） */ //1.3.3 2016-10-26 zxl
let GET_ORG_ALL_USER = "/m/org/getOrgAllUser_v1_3_3"

//MARK: --客户查重接口
let CUSTOMERCHECK = "/m/crm/check_v1_3"
//查询销售阶段和客户级别列表 //1.3.1 2016-10-26 zxl
let SALEANDCUSTOMERLEVEL = "/m/sys/company/getSalesStage_v1_3_1"
//添加客户 dzj 2016-9-28
let ADDUSER = "/m/crm/addCus_v1_3"


//MARK: -- 添加订单接口
let ADDORDERLIST = "/m/sale/saveOrder"
let ORDER_EDIT = "/m/sale/editOrder"
let ORDER_DELETE = "/m/sale/delOrder"
//查询订单信息列表
let QUARYORDERLIST = "/m/sale/getOrderList"
//查询订单详情列表
let QUARYORDERDETIAL  = "/m/sale/getOrderDetail"
//处理订单
let COMFIRMODER  = "/m/sale/ConfirmOrder"
//添加回款
let ADDBACKMONEY  = "/m/sale/saveOrderRecord"


//MARK: --获取客户信息
let OBTAINCUSTOMERINFORMATION = "/m/crm/getList_v1_3"
//查询客户详情
//let CUSTOMERDETAIL = "/m/crm/customerInfo"
//查询客户详情 dzj 2016-09-28
let CUSTOMERDETAIL = "/m/crm/details_v1_3"
//获取客户拜访记录列表
let CUSTOMER_CRM_VISITRECORD = "/m/crm/cust/visitRecord_v1_3"
//获取客户拜访记录评论列表
let CUSTOMER_CRM_VISITRECORD_COMM = "/m/crm/cust/visitRecordComm_v1_3"
//删除客户信息
let DELETECUSTOMER = "/m/crm/del"
//发起共享
let CUSTOMER_CRM_SENDSHARE = "/m/crm/customer/shared_v1_3_4"
//更新用户资料 dzj 2016-09-28
let UPDATECUSTOMERINFORMATION = "/m/crm/update_v1_3"
/**保存拜访记录评论*/
let SAVE_VISIT_RECORD_COMMENT = "/m/crm/cust/saveVisitRecordComment_v1_3"
//查询最近拜访计划
let CHECKRESENTLYVISITPLAN = "/m/sale/visit/getLatelyVisitPlan_v1_3_1"//1.3.1
//MARK:--市场活动
//添加市场活动 1.3.3 2016-10-26 zxl
let ADDACTIVITYITEM  = "/m/work/marketAty/addOrUpdate_v1_3_3"//1.3.3
//撤销市场活动
let DELETEACTIVITYITEM  = "/m/work/marketAty/cancel"
//市场活动列表 dzj20160831
let ACTIVITYLIST  = "/m/work/marketAty/getList_v1_3_1"//1.3.1
//市场活动回复接口
let ACTIVITYREPLY  = "/m/work/marketAty/reply"
//市场活动跟进记录列表接口
let ACTIVITYFOLLOWLIST  = "/m/work/marketAty/getReplyList"//1.3.1
//市场活动详细资料接口
let ACTIVITYDETIAL  = "/m/work/marketAty/getDetail_v1_3_1"//1.3.1
//市场活动审批接口
let ACTIVITYAPPROVAL  = "/m/work/marketAty/approval"
//市场活动结束接口
let ACTIVITYCOMPLETE  = "/m/work/marketAty/complete"
//市场活动审批中的活动列表
let ACTIVITYPLANNINGLIST  = "/m/work/marketAty/getApprovalList_v1_3_1"//1.3.1
//市场活动 删除市场活动
let ACTIVITY_MARKET_ATY_DELETE  = "/m/work/marketAty/del"


//MARK: --添加请假申请接口
let ADDLEAVE  = "/m/work/leave/addOrUpdate"
//请假申请列表接口 20160909dzj
let LEAVELIST  = "/m/work/leave/getList_v1_3_1"//"/m/work/leave/getList"
//审批请假申请接口
let APPROVALLIST  = "/m/work/leave/approval"
//撤销请假申请接口
let CANCELLEAVE  = "/m/work/leave/cancel"
//删除请假申请批接口
let DELETE_LEAVEAPPROVAL  = "/m/work/leave/delete"
//请假申请详情 20160909dzj
let DETAIL_LEAVEAPPROVAL  = "/m/work/leave/detail"




//MARK: --增加在线审批接口
let ADDONLINELIST  = "/m/work/onlineApproval/addOrUpdate"
//在线审批列表接口 20160909dzj
let ONLINELIST  = "/m/work/onlineApproval/getList_v1_3_1"//"/m/work/onlineApproval/getList"
//审批在线审批
let APPROVALONLINE  = "/m/work/onlineApproval/approval"
//撤销在线审批接口
let DELETEONLINE  = "/m/work/onlineApproval/cancel"
//删除在线审批接口
let DELETE_ONLINEAPPROVAL  = "/m/work/onlineApproval/delete"
//在线审批详情 20160909dzj
let DETAIL_ONLINEAPPROVAL  = "/m/work/onlineApproval/detail"


//MARK: --添加话题接口
let ADDTOPIC  = "/m/moment/topic/addOrUpdate"
//获取话题接口
let OBTAINTOPIC  = "/m/moment/topic/getList"

//MARK: --添加工作圈接口
let ADDMOMENT  = "/m/moment/content/addOrUpdate"
//获取工作圈列表 dzj/2016-09-28
let MOMENTLIST  = "/m/moment/content/getList_v1_3_2"
//添加工作圈评论
let ADDMOMENTCOMENT  = "/m/moment/comment/add"
//获取工作圈评论
let OBTAINMOMENTCOMENT  = "/m/moment/comment/getList"
//添加或取消点赞
let ADDORCANCELZAN  = "/m/moment/em/addOrCancel"
//获取点赞列表
let OBTAINZANLIST  = "/m/moment/em/getList"
/** 获取工作圈发布者信息（个人） */
let GET_PUBLISHER_DETAILS  = "/m/sys/getPublisherDetails"
/** 获取工作圈发布者信息（企业） */
let GET_ENTERINFO_DETAILS  = "/m/sys/getEnterInfo"
/** 删除工作圈 */
let DEL_CONTENT_RECORD  = "/m/moment/content/delContentRecord"
/** 工作圈 统计消息回复数数:工作圈点赞、评论，回复 */ //1.3.3 dzj 2016-10-25
let OBTAINZAN_STATISTICS_GET_NEW_MSG_COUNT = "/m/moment/statistics/getMsgCount"
/** 工作圈 获取 新消息工作圈点赞、评论，回复 列表接口 */ //1.3.3 dzj 2016-10-25
let OBTAINZAN_STATISTICS_GET_NEW_MSG_LIST = "/m/moment/statistics/list"
/** 工作圈 获取 新消息 详情接口*/ //1.3.3 dzj 2016-10-25
let OBTAINZAN_STATISTICS_GET_NEW_MSG_DETAIL = "/m/moment/content/detail"
/**************************************** 刘从磊 *******************************************/

//MARK: --登陆注册相关接口
/** 登陆接口 */
let LOGIN = "/public/mlogin"
// 注销登录
let Mlogout = "/m/sys/mlogout"
/** 注册接口 */
let REGISTER = "/public/mRegister"
/** 密码校验接口 */
let PASSWORDCHECK  = ""
/** 手机号校验接口 */
let MOBILECHECK  = ""
/** 获取手机验证码接口 */
let OBTAINCODE = "/public/getPhoneVerification"
/** 忘记密码后，重置密码接口 */
let PASSWORDRESET = "/public/modifyPwd"
/** 手机验证码校验接口 */
let CHECKCODE  = ""
/** 手机号查重接口 */
let MOBILEREPEATCHECK  = ""
//体验账号接口
let QUICK_ENTER_ACCOUNT = "/public/experience/mlogin"
//体验账号接口 v1_3
let QUICK_ENTER_ACCOUNTV1_3 = "/public/experience/mloginv1_3"

//MARK: --拜访计划相关接口
//获取拜访计划列表接口
let OBTAINVISITINGPLANLIST = "/m/sale/visit/plan/getList"
//添加拜访计划接口 dzj 2016-09-28
let ADDVISITINGPLAN = "/m/sale/visit/plan/addOrEdit"
//获取拜访计划详情 dzj 2016-09-28
let OBTAINVISITINGPLANDETAIL = "/m/sale/visit/plan/details"
//添加开始拜访记录
let ADDSTARTVISITRECORD = "/m/crm/cust/addVisitRecord_v1_3"
//删除拜访计划 dzj 2016-09-28
let DELETE_VISIT_PLAN = "/m/sale/visit/plan/del"
//获取拜访客户详情接口
let OBTAIN_VISIT_CUSTOMER_DETIAL = "/m/crm/visitCus"
//8.1.11 拜访获取客户信息 /m/crm/v1_3/visitCus
///  = brief1.1	按月统计获取拜访计划
let OBTAIN_VISIT_PLAN_STATISTICS = "/m/sale/visit/plan/statistics"

///  = brief拜访计划搜索
let OBTAIN_VISIT_PLAN_SEARCH = "/m/sale/visit/plan/search"

//MARK: --拜访记录相关接口
//获取拜访记录列表接口20160824dzj
let OBTAINVISITRECORDLIST = "/m/sale/mgr/getList_v1_3_1"//"/m/sale/mgr/getVisitRecordList"///
//获取拜访记录详情
let OBTAINVISITRECORDDETAIL = "/m/sale/mgr/getVisitRecordDetail"
//保存拜访记录评论(遗弃)
let SAVEVISITRECORDCOMMENT = "/m/sale/mgr/saveVisitRecordComment"
//查询拜访记录评论列表
let SEARCHVISITRECORDCOMMENTLIST = "/m/sale/mgr/getVisitRecordCommentList"
//添加结束拜访记录20160824dzj
let ADDENDVISITRECORD = "/m/crm/cust/updateVisitRecord_v1_3_1"//"/m/sale/mgr/updateVisitRecord"
//删除拜访记录
let DELETE_VISIT_RECORD = "/m/sale/mgr/delVisitRecord"
//拜访轨迹
let ORBIT_VISIT_RORBIT = "/m/crm/cust/visitOrbit"//1.3.1
///  = brief拜访记录搜索
let OBTAIN_VISIT_RORBIT_SEARCH = "/m/crm/cust/record/search"
// 工作总结相关类
// 工作总结列表 20160825dzj
let WORKSUMMARYLIST = "/m/sale/summary/getList_v1_3_1"
// 修改工作总结审批状态
let SETWORKSUMMARYSTATE = "/m/sale/summary/editStatus"
// 新增工作日报
let ADDWORKSUMMARY = "/m/sale/summary/add"
// 获取工作总结详情 20160825dzj
let WORKSUMMARYDETAIL = "/m/sale/summary/detail"
// 删除工作总结
let DELWORKSUMMARY = "/m/sale/summary/del"

// 签到签退
// 照片上传 1.3.3 2016-10-26 zxl
let UPLOADPHOTO = "/public/uploadImg_v1_3_3"
// 签退
let SIGNOUT = "/m/sale/signin/signOut"
// 签到
let SIGNIN = "/m/sale/signin/sign"
// 签到签退数据获取
let SIGNINOUTDATA = "/m/sale/signin/getList"





// 共享客户
// 获取共享客户列表
let OBTAINSHAREDCUSTOMERLIST = "/m/crm/customerShared/getList_v1_3"
// 取消共享客户
let CANCELSHAREDCUSTOMER = "/m/crm/customerShared/cancel_v1_3"
/// @breif 拒绝共享客户
let REFUSESHAREDCUSTOMER = "/m/crm/customerShared/refuse_v1_3"
// 领取共享客户或公海客户/***  备注： 领取客户信息 企信页面暂时调用老接口*/
let GETSHAREDCUSTOMER = "/m/crm/customerShared/get_v1_3"
// 共享客户统计（遗弃）
let SCStatistics = "/m/crm/customerShared/statistics"

/// 公海客户
// 获取公海客户列表
let OBTAINHIGHSEASCUSTOMERLIST = "/m/crm/seaPool/getList_v1_3"
// 公海客户统计
let HSCStatistics = "/m/crm/seaPool/statistics"

// 查看资料
// 账号验证
let LDVerifyAccount = "/m/sys/verifyAccount"
// 更换手机号
let ChangePhoneNumber = "/m/sys/changePhoneNumber"
// 用户资料编辑
let EditAccountInfo = "/m/sys/editAccountInfo"
// 获取公司职位
let ObtainPositionList = "/m/sys/position/getList"

// 共享线索列表
let SHARECLUELIST = "/m/crm/saleClue/getSharedList"//1.3.1

// 获取线索池/公海池列表接口
let GET_POOL_LIST = "/m/sys/baseData/getPoolList"

// 线索池接口
// 获取线索池列表接口
let OBTAIN_CLUE_POOL_LIST = "/m/crm/saleClue/getPoolList_v1_3"
// 领取线索池线索或共享线索接口
let GET_CLUE_POOL_SALE_CLUE = "/m/crm/saleClue/get_v1_3" //
// 删除线索池线索接口 v1.3弃用
//let DELETE_CLUE_POOL_SALE_CLUE = "/m/crm/saleClue/delete"
// 销售线索
// 获取销售线索列表
let ObtainSaleClueList = "/m/crm/saleClue/getList_v1_3"
// 获取销售区域列表(线索区域)
let ObtainSaleAreaList = "/m/crm/clueRegion/getList"
// 添加/更新线索 dzj2016-09-28
let AddClueOrUpdate = "/m/crm/saleClue/addOrUpdate_v1_3"
// 销售线索或线索池详情接口 1.3.3 2016-10-26 zxl
let SaleClueOrCluePoolDetail = "/m/crm/saleClue/detail_v1_3_3"
// 跟进销售线索
let FollowUpSaleClue = "/m/crm/saleClue/followUp_v1_3"

// 将销售线索转移到线索池接口
let SaleClueTransferCluePool = "/m/crm/saleClue/removeToCluePool_v1_3_4"//
// 共享销售线索
let ShareSaleClue = "/m/crm/saleClue/shared_v1_3"
// 取消共享线索
let CancelShareSale = "/m/crm/saleClue/cancel_v1_3" //
// 拒绝共享销售线索
let RejectShareClue = "/m/crm/saleClue/reject_v1_3"//
// 基础数据
let BasicDataList = "/m/sys/baseData/getList"

// app系统提醒设置
// 获取提醒设置信息
let ObtainRemindSetUpMessage = "/m/sys/remind/getList"
// 提醒设置
let RemindSetUp = "/m/sys/remind/setting"



/**
 *  企信
 */
// 企信 公告、通知、工作提醒、共享通知  各个 消息未读个数接口
let QIXIN_UNREAD_COUNT = "/m/org/msg/unReadCount"
// 企信 更新消息状态接口
let QIXIN_UPDATE_STATUS = "/m/org/msg/updateStatus"
// 企信 公告发布接口 //1.3.3 zxl 2016-10-25
let QIXIN_ANNC_PUBLISH = "/m/org/annc/publish_v1_3_3"

// 企信 公告列表接口
let QIXIN_ANNC_GETLIST = "/m/org/annc/getList"
// 企信 通知列表接口
let QIXIN_NOTICE_GETLIST = "/m/org/notice/getList"
// 企信 工作提醒列表接口
let QIXIN_WORKWARN_GETLIST = "/m/org/workWarn/getList"
// 企信 共享通知列表接口
let QIXIN_SHARED_NOTICE_GETLIST = "/m/org/sharedNotice/getList_v1_3_1"
/** 删除消息接口 （公告，通知，工作提醒，共享）*/
let QIXIN_MSG_DEL = "/m/org/msg/del"

/**
 *  任务交办
 */
// 任务交办 添加/更新任务交办接口
let TASK_APPROVAL_ADD_OR_UPDATE = "/m/work/assignTask/addOrUpdate"
// 任务交办 任务交办列表接口 dzj20160831
let TASK_APPROVAL_ASSIGN_TASK_GET_LIST = "/m/work/assignTask/getList_v1_3_1"//"/m/work/assignTask/getList"
// 任务交办 任务交办回复接口
let TASK_APPROVAL_ASSIGN_TASK_REPLY = "/m/work/assignTask/reply"
// 任务交办 任务交办催办接口
let TASK_APPROVAL_ASSIGN_TASK_URGE = "/m/work/assignTask/urge"
// 任务交办 任务交办完成接口
let TASK_APPROVAL_ASSIGN_TASK_COMPLETE = "/m/work/assignTask/complete"
// 任务交办 任务交办撤销接口
let TASK_APPROVAL_ASSIGN_TASK_CANCEL = "/m/work/assignTask/cancel"
// 任务交办 任务交办回复列表接口
let TASK_APPROVAL_ASSIGN_TASK_GET_REPLYLIST = "/m/work/assignTask/getReplyList"
// 任务交办 详情接口 dzj20160830
let TASK_APPROVAL_ASSIGN_TASK_GET_DETAIL = "/m/work/assignTask/detail"
// 任务交办 删除任务交办
let TASK_APPROVAL_DETELE_TASK = "/m/work/assignTask/delTask"

/**
 *  数据看板
 */
// CRM_数据看板 新增和更新销售目标
let CRM_TAGET_ADD_OR_UPDATE = "/m/crm/target/addOrUpdate_v1_3"
// CRM_数据看板 销售目标列表 20160909
let CRM_TAGET_GET_LIST = "/m/crm/target/getList_v1_3_1"
// CRM_数据看板 1.1.1	销售目标详情(new) 20160909
let CRM_TAGET_GET_DETAIL = "/m/crm/target/detail"
// CRM_数据看板（CRM主页接口）
let CRM_BOARD_CRM_HOME = "/m/crm/board/crmData_v1_3"//"/m/crm/board/
// CRM_数据看板 数据看板
let CRM_BOARD_DATA = "/m/crm/board/data_v1_3"
// CRM_数据看板 按类别查询客户列表
let CRM_BOARD_CUSTOMERS = "/m/crm/board/customers_v1_3"
// CRM_数据看板 新增线索列表
let CRM_BOARD_NEWCLUE = "/m/crm/board/newClue_v1_3"
// CRM_数据看板 新增订单列表
let CRM_BOARD_NEW_ORDER = "/m/crm/board/newOrder_v1_3"
// CRM_数据看板 目标审批
let CRM_TARGET_APPRROVER = "/m/crm/target/aprrover_v1_3"
// CRM_数据看板 删除销售目标
let CRM_TARGET_DEL_TARGET = "/m/crm/target/delTarget_v1_3"



/// @brie 我的考勤列表接口
let MY_ATTENDANCE_LIST = "/m/sale/signin/myAttendance"

/// @biref 我的荣誉
let MY_HONOR_LIST = "/m/org/myHonor_v1_3"

//全公司销售看板统计 1.3.3 2016-10-26 zxl
let MOMMENT_COMPANY_SALE_BOARD = "/m/moment/company/saleBoard_v1_3_3"
//全公司销售趋势 1.3.3 2016-10-26 zxl
let MOMMENT_COMPANY_SALE_TREND = "/m/moment/company/saleTrend_v1_3_3"
// 全公司销售漏斗 1.3.3 2016-10-26 zxl
let MOMMENT_COMPANY_SALET_FUNNEL = "/m/moment/company/saleFunnel_v1_3_3"
// 全公司业绩排行 1.3.3 2016-10-26 zxl
let MOMMENT_COMPANY_SALET_RANK = "/m/moment/company/saleRank_v1_3_3"
// 全公司客户拜访量排行 1.3.3 2016-10-26 zxl
let MOMMENT_COMPANY_VISIT_RANK = "/m/moment/company/visitRank_v1_3_3"


