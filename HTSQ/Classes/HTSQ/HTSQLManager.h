//
//  HTManager.h
//  HIGHTONG_Public
//
//  Created by 赖利波 on 16/4/5.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
@interface  HTSQLManager: NSObject
//@protected
//FMDatabaseQueue	*_databaseQueue;
//}

@end
@interface HTSQLManager()

@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;

/**
 *  用户名
 *
 *  @param Name 插入用户名
 */
-(void)insertUserName:(NSString *)Name;




//  增加 直播 表数据

/**
 *  插入直播
 *
 *  @param LiveStr 直播的字符串
 */
-(void)insertLive:(NSString *)LiveStr;
//  增加 时移数据 表数据
/**
 *  时移的信息
 *
 *  @param TimeMoveStr 返回时移字符串
 */
-(void)insertTimeMove:(NSString *)TimeMoveStr;
//  增加 EPG 表数据

/**
 *  增加EPG信息
 *
 *  @param EPGStr EPG字符串
 */
-(void)insertEPG:(NSString *)EPGStr;

//  增加 回看 表数据

/**
 *  增加回看数据
 *
 *  @param LookingbackStr 回看的字符串
 */

-(void)insertLookingback:(NSString *)LookingbackStr;

//  增加 点播 表数据
/**
 *  增加点播数据
 *
 *  @param VODStr 点播字符串
 */
-(void)insertVOD:(NSString *)VODStr;


//  增加EPGSearch

/**
 *  EPG搜索
 *
 *  @param EPGSearchStr EPG搜索字符串
 */

-(void)insertEPGSearch:(NSString *)EPGSearchStr;


//  增加VODSearch
/**
 *  插入点播搜索
 *
 *  @param VODSearchStr 点播搜索的字符串
 */
-(void)insertVODSearch:(NSString *)VODSearchStr;


//增加用户行为的网络信息

/**
 *  插入的网络信息
 *
 *  @param IPStr   当前网络IP地址（String）
 *  @param AWStr   网络接入方式，有线/无线（String）
 *  @param TTLStr  网络时延（String）
 *  @param BWStr   当网络带宽（String）
 *  @param TimeStr 当前采集的时间
 */
-(void)insertETHForIP:(NSString*)IPStr andAW:(NSString*)AWStr andTTL:(NSString*)TTLStr andBW:(NSString*)BWStr andTime:(NSString*)TimeStr;


//增加错误行为信息

/**
 *  采集的错误信息
 *
 *  @param AVTYPEStr   视频类型（String）
 *  @param OPTYPEStr   异常类型（String）AV：视频类
 *  @param OPSSTStr    异常开始时间（String）格式：YYYY-MM-DD HH:mm:SS
 *  @param DurationStr 异常持续时间（String）格式：mm:SS
 */
-(void)insertOPSForAVTYPE:(NSString*)AVTYPEStr andOPTYPE:(NSString*)OPTYPEStr andOPSST:(NSString*)OPSSTStr andDuration:(NSString*)DurationStr;



/**
 *  插入上线时间
 *
 *  @return nil
 */

//  插入上线时间
-(void)insertUserOnTime:(NSString *)Time;



/**
 *  插入上线时间
 *
 *  @return nil
 */
//  插入下线时间
-(void)insertUserOffTime:(NSString *)Time;


/**
 *  更新下线时间
 *
 *  @return nil
 */
//  更新下线时间
-(void)UpdateUserOffTime:(NSString *)Time;




/**
 *  插入上线下线时间
 *
 *  @param Online  上线
 *  @param Offline 下线
 */
-(void)insertUserOnTime:(NSString*)Online  AndOffLine:(NSString*)Offline;


/**
 *  //获取个人用户信息行为的数组
 *
 *  @return 获取数据库的格式数组//  获取最新行为信息
 */
-(NSMutableArray *)getNewAllPeople;


/**
 *  // 获取最新的网络行为信息
 *
 *  @return 获取数据库的格式数组
 */
-(NSMutableArray *)getETHInformations;


/**
 *  // 获取最新的错误行为信息
 *
 *  @return 获取错误的信息
 */


-(NSMutableArray *)getOPSInformations;


-(void)deleteUSerinformationNew;//  上次上传失败的行为信息删除方法
-(void)deleteUserAction;//  删除直播  回看  EPG   方法
-(void)deleteUserOPSInformation;//删除OPS信息
-(void)deleteUserETHInformation;//删除ETH信息




@end
