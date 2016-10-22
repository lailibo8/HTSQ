//
//  HTManager.m
//  HIGHTONG_Public
//
//  Created by 赖利波 on 16/4/5.
//  Copyright © 2016年 创维海通. All rights reserved.
//

#import "HTManager.h"
#import "DatabaseManager.h"
@implementation HTSQLManager
- (id)init{
    self = [super init];
    
    if(self)
    {
        
//        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
    }
    
    return self;
}


- (FMDatabaseQueue *)databaseQueue
{
    if (![[DatabaseManager currentManager] isDatabaseOpened]) {
        [[DatabaseManager currentManager] openDataBase];
        self.databaseQueue = [DatabaseManager currentManager].databaseQueue;
        if (_databaseQueue)  [HTSQLManager createTablesNeeded];
    }
    return _databaseQueue;
}

+ (void)createTablesNeeded
{
    @autoreleasepool {

    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        
        //信息收集的表建立
        
        /*info_People*/
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"create table People (number INTEGER PRIMARY KEY AUTOINCREMENT,OnOffTime text, UserAccount text, Live text,TimeMove text, Lookingback text, EPG text, VOD text,  EPGSearch text, VODSearch text )"];
        
        /*info_ETH*/
        NSString *sqlCreateTable2 =  [NSString stringWithFormat:@"create table ETH (number INTEGER PRIMARY KEY AUTOINCREMENT,UserAccount text, TIME text, IP text, AW text, TTL text, BW text )"];
        
        /*info_OPS*/
        NSString *sqlCreateTable3 =  [NSString stringWithFormat:@"create table OPS (number INTEGER PRIMARY KEY AUTOINCREMENT,UserAccount text, AVTYPE text, OPTYPE text,  OPSST text, DURATION text)"];
        
        [database executeUpdate:sqlCreateTable];
        [database executeUpdate:sqlCreateTable2];
        [database executeUpdate:sqlCreateTable3];
        
    }];
        }
}

//  增加 直播 表数据
-(void)insertLive:(NSString *)LiveStr
{
    
    
    // UserName
    
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (Live,UserAccount) values ('%@','%@')",LiveStr,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
    
}


//  增加 时移数据 表数据
-(void)insertTimeMove:(NSString *)TimeMoveStr
{
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (TimeMove,UserAccount) values ('%@','%@')",TimeMoveStr,UserAccount];
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
}


//  增加 EPG 表数据
-(void)insertEPG:(NSString *)EPGStr
{
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (EPG,UserAccount) values ('%@','%@')",EPGStr,UserAccount];
    
    
    [[DatabaseManager currentManager].databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
    
}


//  增加 回看 表数据
-(void)insertLookingback:(NSString *)LookingbackStr
{
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (Lookingback,UserAccount) values ('%@','%@')",LookingbackStr,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];}

//  增加 点播 表数据
-(void)insertVOD:(NSString *)VODStr
{
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (VOD,UserAccount) values ('%@','%@')",VODStr,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
}



//  增加EPGSearch

-(void)insertEPGSearch:(NSString *)EPGSearchStr
{
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (EPGSearch,UserAccount) values ('%@','%@')",EPGSearchStr,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
}


//  增加VODSearch

-(void)insertVODSearch:(NSString *)VODSearchStr {
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (VODSearch,UserAccount) values ('%@','%@')",VODSearchStr,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
}

/**
 *  插入的网络信息
 *
 *  @param IPStr   当前网络IP地址（String）
 *  @param AWStr   网络接入方式，有线/无线（String）
 *  @param TTLStr  网络时延（String）
 *  @param BWStr   当网络带宽（String）
 *  @param TimeStr 当前采集的时间
 */
-(void)insertETHForIP:(NSString*)IPStr andAW:(NSString*)AWStr andTTL:(NSString*)TTLStr andBW:(NSString*)BWStr andTime:(NSString*)TimeStr{
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'ETH' (UserAccount,TIME,IP,AW,TTL,BW) values ('%@','%@','%@','%@','%@','%@')",UserAccount,TimeStr,IPStr,AWStr,TTLStr,BWStr];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
}

/**
 *  采集的错误信息
 *
 *  @param AVTYPEStr   视频类型（String）
 *  @param OPTYPEStr   异常类型（String）AV：视频类
 *  @param OPSSTStr    异常开始时间（String）格式：YYYY-MM-DD HH:mm:SS
 *  @param DurationStr 异常持续时间（String）格式：mm:SS
 */
-(void)insertOPSForAVTYPE:(NSString*)AVTYPEStr andOPTYPE:(NSString*)OPTYPEStr andOPSST:(NSString*)OPSSTStr andDuration:(NSString*)DurationStr
{
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'OPS' (UserAccount,AVTYPE,OPTYPE,OPSST,DURATION) values ('%@','%@','%@','%@','%@')",UserAccount,AVTYPEStr,OPTYPEStr,OPSSTStr,DurationStr];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
}


-(void)insertUserOnTime:(NSString*)Online  AndOffLine:(NSString*)Offline
{
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil||[UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    
    NSString *mOnOffTime = [NSString stringWithFormat:@"%@+%@",Online,Offline];
    
    
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (OnOffTime,UserAccount) values (%@,%@)",mOnOffTime,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
    }];
    
    
    
    
    
}





//  插入上线时间
-(void)insertUserOnTime:(NSString *)Time
{
    
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil || [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (OnOffTime,UserAccount) values (%@,%@)",Time,UserAccount];
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
        
    }];
    
}



-(void)UpdateUserOffTime:(NSString *)Time
{
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    
    
    
    
    NSString *onLineTimeStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"ONLINE"];
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (OnOffTime,UserAccount) values (%@,%@)",[NSString stringWithFormat:@"%@+%@",onLineTimeStr,[SAIInformationManager serviceTimeTransformStr]],UserAccount];
    
    NSString *updateSql = [NSString stringWithFormat:
                           @"UPDATE People SET OnOffTime = '%@'  WHERE rowid = (select max(rowid)FROM People)",
                           Time ];
    
    
    
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
        [database executeUpdate:updateSql];
        
        
    }];
    
    
    
    
}




//  插入下线时间
-(void)insertUserOffTime:(NSString *)Time
{
    
    
    
    NSString *UserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
    if (UserAccount == nil|| [UserAccount isEqualToString:@""]) {
        UserAccount = @"admin";
    }
    
    
    
    NSString* sql = [NSString stringWithFormat:@"insert into 'People' (OffTime,UserAccount) values (%@,%@)",Time,UserAccount];
    
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        [database executeUpdate:sql];
        
        
    }];
    
    
    
    
    
    
}
//  获取最新行为信息
-(NSMutableArray *)getNewAllPeople
{
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    
    NSMutableArray *peopleArray = [[NSMutableArray alloc] init];
    
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            
            NSMutableArray *Livearray=[[NSMutableArray alloc] init];
            NSMutableArray *TimeMovearray=[[NSMutableArray alloc] init];
            NSMutableArray *Lookingbackarray=[[NSMutableArray alloc] init];
            NSMutableArray *EPGarray=[[NSMutableArray alloc] init];
            NSMutableArray *VODarray=[[NSMutableArray alloc] init];
            NSMutableArray *UserAccountarray=[[NSMutableArray alloc]init];
            NSMutableArray *searchEPGarray=[[NSMutableArray alloc]init];
            NSMutableArray *searchVODarray=[[NSMutableArray alloc]init];
            NSMutableArray *TimeArray = [[NSMutableArray alloc]init];
            FMResultSet * rs = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM People"]];
            
            //判断结果集中是否有数据，如果有则取出数据
            while ([rs next]) {
                NSMutableDictionary *dictTime=[[NSMutableDictionary alloc]init];
                NSString *UserAccount=[rs stringForColumn:@"UserAccount"];
                if(UserAccount)
                {
                    [UserAccountarray addObject:UserAccount];
                }
                NSString *Live=[rs stringForColumn:@"Live"];
                if(Live)
                {
                    [Livearray addObject:Live];
                }
                
                NSString *TimeMove=[rs stringForColumn:@"TimeMove"];
                if(TimeMove)
                {
                    [TimeMovearray addObject:TimeMove];
                }
                
                NSString *Lookingback=[rs stringForColumn:@"Lookingback"];
                if(Lookingback)
                {
                    [Lookingbackarray addObject:Lookingback];
                }
                
                NSString *EPG=[rs stringForColumn:@"EPG"];
                if(EPG)
                {
                    [EPGarray addObject:EPG];
                }
                
                NSString *VOD=[rs stringForColumn:@"VOD"];
                if(VOD)
                {
                    [VODarray addObject:VOD];
                }
                
                NSString *searchEPG=[rs stringForColumn:@"EPGSearch"];
                if(searchEPG)
                {
                    [searchEPGarray addObject:searchEPG];
                }
                
                NSString *searchVOD=[rs stringForColumn:@"VODSearch"];
                if(searchVOD)
                {
                    [searchVODarray addObject:searchVOD];
                }
                
                NSString *OnOffTime=[rs stringForColumn:@"OnOffTime"];
                
                if (OnOffTime.length>0) {
                    
                    NSLog(@"onOfftime%@",OnOffTime);
                    
                    if ([OnOffTime rangeOfString:@"+"].location!=NSNotFound) {
                        NSArray *TimeArr = [OnOffTime componentsSeparatedByString:@"+"];
                        NSString *OnTime = [TimeArr objectAtIndex:0];
                        NSString *OffTime = [TimeArr objectAtIndex:1];
                        
                        [dictTime setValue:OnTime forKey:@"OLT1"];
                        [dictTime setValue:OffTime forKey:@"OLT2"];
                        
                        
                    }else
                    {
                        [dictTime setValue:OnOffTime forKey:@"OLT1"];
                        
                    }
                    
                }else
                {
                    OnOffTime  = [[NSUserDefaults standardUserDefaults] valueForKey:@"ONLINE"];
                    [dictTime setValue:OnOffTime forKey:@"OLT1"];
                    
                }
                
                
                [TimeArray addObject:dictTime];
                
                
            }
            
            if (TimeArray.count==0) {
                NSString *onlineString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ONLINE"];
                NSDictionary *timeDic = [[NSDictionary alloc] initWithObjectsAndKeys:onlineString,@"OLT1", nil];
                [TimeArray addObject:timeDic];
                
            }
            //zzs 直播
            Livearray = [self getZZSLiveArrWith:Livearray];
            //zzs 回看
            Lookingbackarray = [self getZZSPlayBackArrWith:Lookingbackarray];
            //zzs EPG
            EPGarray = [self getZZSEPGArrWith:EPGarray];
            //zzs EPG搜索
            searchEPGarray = [self getZZSSearchEPGArrWith:searchEPGarray];
            
            VODarray = [self getZZSVODArrWith:VODarray];
            
            
            TimeMovearray = [self getZZSTimeMoveArrWith:TimeMovearray];
            
            
            
            [peopleArray addObject:TimeArray];//上下线时间
            [peopleArray addObject:Livearray];//直播
            [peopleArray addObject:Lookingbackarray];//回看
            [peopleArray addObject:EPGarray];//EPG
            [peopleArray addObject:searchEPGarray];//EPG search
            [peopleArray addObject:VODarray];//VOD
            //        [peopleArray addObject:searchVODarray];
            [peopleArray addObject:TimeMovearray];//时移
            
        }
        
        
    }];
    
    
    
    //    if ([db open]) {
    //        FMResultSet * rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM People"]];
    //
    //        //判断结果集中是否有数据，如果有则取出数据
    //        while ([rs next]) {
    //            NSMutableDictionary *dictTime=[[NSMutableDictionary alloc]init];
    //            NSString *UserAccount=[rs stringForColumn:@"UserAccount"];
    //            if(UserAccount)
    //            {
    //                [UserAccountarray addObject:UserAccount];
    //            }
    //            NSString *Live=[rs stringForColumn:@"Live"];
    //            if(Live)
    //            {
    //                [Livearray addObject:Live];
    //            }
    //
    //            NSString *TimeMove=[rs stringForColumn:@"TimeMove"];
    //            if(TimeMove)
    //            {
    //                [TimeMovearray addObject:TimeMove];
    //            }
    //
    //            NSString *Lookingback=[rs stringForColumn:@"Lookingback"];
    //            if(Lookingback)
    //            {
    //                [Lookingbackarray addObject:Lookingback];
    //            }
    //
    //            NSString *EPG=[rs stringForColumn:@"EPG"];
    //            if(EPG)
    //            {
    //                [EPGarray addObject:EPG];
    //            }
    //
    //            NSString *VOD=[rs stringForColumn:@"VOD"];
    //            if(VOD)
    //            {
    //                [VODarray addObject:VOD];
    //            }
    //
    //            NSString *searchEPG=[rs stringForColumn:@"EPGSearch"];
    //            if(searchEPG)
    //            {
    //                [searchEPGarray addObject:searchEPG];
    //            }
    //
    //            NSString *searchVOD=[rs stringForColumn:@"VODSearch"];
    //            if(searchVOD)
    //            {
    //                [searchVODarray addObject:searchVOD];
    //            }
    //
    //            NSString *OnOffTime=[rs stringForColumn:@"OnOffTime"];
    //
    //            if (OnOffTime.length>0) {
    //
    //                NSLog(@"onOfftime%@",OnOffTime);
    //
    //                if ([OnOffTime rangeOfString:@"+"].location!=NSNotFound) {
    //                    NSArray *TimeArr = [OnOffTime componentsSeparatedByString:@"+"];
    //                    NSString *OnTime = [TimeArr objectAtIndex:0];
    //                    NSString *OffTime = [TimeArr objectAtIndex:1];
    //
    //                    [dictTime setValue:OnTime forKey:@"OLT1"];
    //                    [dictTime setValue:OffTime forKey:@"OLT2"];
    //
    //
    //                }else
    //                {
    //                    [dictTime setValue:OnOffTime forKey:@"OLT1"];
    //
    //                }
    //
    //            }else
    //            {
    //                OnOffTime  = [[NSUserDefaults standardUserDefaults] valueForKey:@"ONLINE"];
    //                [dictTime setValue:OnOffTime forKey:@"OLT1"];
    //
    //            }
    //
    //
    //            [TimeArray addObject:dictTime];
    //
    //
    //        }
    //
    //        if (TimeArray.count==0) {
    //            NSString *onlineString = [[NSUserDefaults standardUserDefaults] valueForKey:@"ONLINE"];
    //            NSDictionary *timeDic = [[NSDictionary alloc] initWithObjectsAndKeys:onlineString,@"OLT1", nil];
    //            [TimeArray addObject:timeDic];
    //
    //        }
    //        //zzs 直播
    //        Livearray = [self getZZSLiveArrWith:Livearray];
    //        //zzs 回看
    //        Lookingbackarray = [self getZZSPlayBackArrWith:Lookingbackarray];
    //        //zzs EPG
    //        EPGarray = [self getZZSEPGArrWith:EPGarray];
    //        //zzs EPG搜索
    //        searchEPGarray = [self getZZSSearchEPGArrWith:searchEPGarray];
    //
    //        VODarray = [self getZZSVODArrWith:VODarray];
    //
    //
    //        TimeMovearray = [self getZZSTimeMoveArrWith:TimeMovearray];
    //
    //
    //
    //        [peopleArray addObject:TimeArray];//上下线时间
    //        [peopleArray addObject:Livearray];//直播
    //        [peopleArray addObject:Lookingbackarray];//回看
    //        [peopleArray addObject:EPGarray];//EPG
    //        [peopleArray addObject:searchEPGarray];//EPG search
    //        [peopleArray addObject:VODarray];//VOD
    //        //        [peopleArray addObject:searchVODarray];
    //        [peopleArray addObject:TimeMovearray];//时移
    //
    //    }
    //    [TimeArray release];
    //    [Livearray release];
    //    [Lookingbackarray release];
    //    [EPGarray release];
    //    [searchEPGarray release];
    //    [VODarray release];
    //    [searchVODarray release];
    //    [TimeMovearray release];
    
    //    return [peopleArray autorelease];
    return peopleArray;
    
}


//*  @param IPStr   当前网络IP地址（String）
//*  @param AWStr   网络接入方式，有线/无线（String）
//*  @param TTLStr  网络时延（String）
//*  @param BWStr   当网络带宽（String）
//*  @param TimeStr 当前采集的时间


-(NSMutableArray *)getETHInformations
{
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *ETHArr = [[NSMutableArray alloc]init];
    
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            FMResultSet * rs = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM ETH"]];
            
            while ([rs next]) {
                NSMutableDictionary *tempdic= [[NSMutableDictionary alloc]init];
                //            NSString *UserAccount=[rs stringForColumn:@"UserAccount"];
                //            if(UserAccount)
                //            {
                //                [UserAccountArray addObject:UserAccount];
                //            }
                NSString *Time=[rs stringForColumn:@"TIME"];
                if(Time)
                {
                    [tempdic setObject:Time forKey:@"GT"];
                }
                NSString *IP=[rs stringForColumn:@"IP"];
                if(IP)
                {
                    [tempdic setObject:IP forKey:@"IP"];
                }
                NSString *AWStr=[rs stringForColumn:@"AW"];
                if(AWStr)
                {
                    [tempdic setObject:AWStr forKey:@"AW"];
                }
                NSString *TTLStr=[rs stringForColumn:@"TTL"];
                if(TTLStr)
                {
                    [tempdic setObject:TTLStr forKey:@"TTL"];
                }
                NSString *BWStr=[rs stringForColumn:@"BW"];
                if(BWStr)
                {
                    [tempdic setObject:BWStr forKey:@"BW"];
                }
                
                [ETHArr addObject:tempdic];
                
                //            [tempdic release];
            }
            
        }
        
        
    }];    // NSMutableDictionary *UserAccountDic= [[NSMutableDictionary alloc]init];
    //    UserAccount,TIME,IP,AW,TTL,BW
    //    if ([db open]) {
    //        FMResultSet * rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM ETH"]];
    //
    //        while ([rs next]) {
    //            NSMutableDictionary *tempdic= [[NSMutableDictionary alloc]init];
    //            //            NSString *UserAccount=[rs stringForColumn:@"UserAccount"];
    //            //            if(UserAccount)
    //            //            {
    //            //                [UserAccountArray addObject:UserAccount];
    //            //            }
    //            NSString *Time=[rs stringForColumn:@"TIME"];
    //            if(Time)
    //            {
    //                [tempdic setObject:Time forKey:@"GT"];
    //            }
    //            NSString *IP=[rs stringForColumn:@"IP"];
    //            if(IP)
    //            {
    //                [tempdic setObject:IP forKey:@"IP"];
    //            }
    //            NSString *AWStr=[rs stringForColumn:@"AW"];
    //            if(AWStr)
    //            {
    //                [tempdic setObject:AWStr forKey:@"AW"];
    //            }
    //            NSString *TTLStr=[rs stringForColumn:@"TTL"];
    //            if(TTLStr)
    //            {
    //                [tempdic setObject:TTLStr forKey:@"TTL"];
    //            }
    //            NSString *BWStr=[rs stringForColumn:@"BW"];
    //            if(BWStr)
    //            {
    //                [tempdic setObject:BWStr forKey:@"BW"];
    //            }
    //
    //            [ETHArr addObject:tempdic];
    //
    //            //            [tempdic release];
    //        }
    //
    //    }
    
    
    //    return [ETHArr autorelease];
    
    return ETHArr;
}

//*  @param AVTYPEStr   视频类型（String）
//*  @param OPTYPEStr   异常类型（String）AV：视频类
//*  @param OPSSTStr    异常开始时间（String）格式：YYYY-MM-DD HH:mm:SS
//*  @param DurationStr 异常持续时间（String）格式：mm:SS

-(NSMutableArray *)getOPSInformations
{
    
    //定义一个可变数组，用来存放查询的结果，返回给调用者
    NSMutableArray *OPSArray = [[NSMutableArray alloc]init];
    NSMutableArray *UserAccountArray = [[NSMutableArray alloc] init];
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            FMResultSet * rs = [database executeQuery:[NSString stringWithFormat:@"SELECT * FROM OPS"]];
            
            while ([rs next]) {
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc]init];
                NSString *UserAccount=[rs stringForColumn:@"UserAccount"];
                if(UserAccount)
                {
                    [UserAccountArray addObject:UserAccount];
                }
                NSString *AVTYPEStr=[rs stringForColumn:@"AVTYPE"];
                if(AVTYPEStr)
                {
                    
                    [tempDic setValue:AVTYPEStr forKey:@"AVTYPE"];
                }
                NSString *OPTYPEStr=[rs stringForColumn:@"OPTYPE"];
                if(OPTYPEStr)
                {
                    [tempDic setValue:OPTYPEStr forKey:@"OPTYPE"];
                }
                NSString *OPSSTStr=[rs stringForColumn:@"OPSST"];
                if(OPSSTStr)
                {
                    [tempDic setValue:OPSSTStr forKey:@"OPSST"];
                }
                NSString *DurationStr=[rs stringForColumn:@"DURATION"];
                if(DurationStr)
                {
                    [tempDic setValue:DurationStr forKey:@"DURATION"];
                }
                [OPSArray addObject:tempDic];
                
                //            [tempDic release];
            }
            
        }
        
    }];
    
    
    //    return [OPSArray autorelease];
    return OPSArray;
    
}













//  上次上传失败的行为信息删除方法
-(void)deleteUSerinformationNew:(NSString *)sqlstr
{
    
}

//  删除直播  回看  EPG   方法
-(void)deleteUserAction//  删除直播  回看  EPG   方法
{
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            
            NSString *deleteUserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
            
            if (deleteUserAccount == nil|| [deleteUserAccount isEqualToString:@""]) {
                
                deleteUserAccount = @"admin";
            }
            
            
            if ([database executeUpdate:@"delete from People where UserAccount=?",deleteUserAccount]) {
                NSLog(@"删除用户行为成功");
            }else
            {
                NSLog(@"删除用户失败");
            }
            
        }    }];
    
    
}
//删除OPS信息
-(void)deleteUserOPSInformation
{
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            
            NSString *deleteUserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
            
            if (deleteUserAccount == nil|| [deleteUserAccount isEqualToString:@""]) {
                
                deleteUserAccount = @"admin";
            }
            
            
            if ([database executeUpdate:@"delete from OPS where UserAccount=?",deleteUserAccount]) {
                NSLog(@"删除OPS成功");
            }else
            {
                NSLog(@"删除OPS失败");
            }
            
        }    }];
    
    
    
}

//删除ETH信息
-(void)deleteUserETHInformation
{
    
    FMDatabaseQueue *databaseQueue = [DatabaseManager currentManager].databaseQueue;
    
    
    [databaseQueue inTransaction:^(FMDatabase *database, BOOL *rollBack){
        {
            
            NSString *deleteUserAccount = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserName"];
            
            if (deleteUserAccount == nil|| [deleteUserAccount isEqualToString:@""]) {
                
                deleteUserAccount = @"admin";
            }
            if ([database executeUpdate:@"delete from ETH where UserAccount=?",deleteUserAccount]) {
                NSLog(@"删除ETH成功");
            }else
            {
                NSLog(@"删除ETH失败");
            }
            
        }
        
    }];
    
    
    
}



//拼接直播

/**
 *  拼接的直播信息
 *
 *  @param liveArr 从服务器获取的直播信息
 *
 *  @return return 获取的拼接后上传服务器的直播数组信息
 */



-(NSMutableArray *)getZZSLiveArrWith:(NSMutableArray *)liveArr{
    
    NSMutableArray *resultLiveArry = [[NSMutableArray alloc]init];
    for (int i=0; i<liveArr.count; i++) {
        NSString *str = [liveArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        if (arr.count==7) {
            [mDic setObject:[arr objectAtIndex:0] forKey:@"SID"];
            [mDic setObject:[arr objectAtIndex:1] forKey:@"CHNAME"];
            [mDic setObject:[arr objectAtIndex:2] forKey:@"EVENTNAME"];
            [mDic setObject:[arr objectAtIndex:3] forKey:@"SWT"];
            [mDic setObject:[arr objectAtIndex:4] forKey:@"DURATION"];
            [mDic setObject:[arr objectAtIndex:5] forKey:@"ED"];
            [mDic setObject:[arr objectAtIndex:6] forKey:@"EST"];
        }
        [resultLiveArry addObject:mDic];
        
        //        [mDic autorelease];
    }
    
    
    //    return [resultLiveArry autorelease];
    
    
    return resultLiveArry;
}


-(NSMutableArray *)getZZSTimeMoveArrWith:(NSMutableArray *)timeMoveArr
{
    
    //    NSString *str = [NSString stringWithFormat:@"%@+%@+%@+%@+%@+%@+%@",mserviceID,mchanelName,meventName,mwatchTime,mwatchDuration,meventLength,meventTime];
    // SID=SName=EName=T=WD=ED=EST
    
    NSMutableArray *resultTimeMoveArry = [[NSMutableArray alloc]init];
    for (int i=0; i<timeMoveArr.count; i++) {
        NSString *str = [timeMoveArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        if (arr.count==7) {
            [mDic setObject:[arr objectAtIndex:0] forKey:@"SID"];//
            [mDic setObject:[arr objectAtIndex:1] forKey:@"CHNAME"];
            [mDic setObject:[arr objectAtIndex:2] forKey:@"EVENTNAME"];
            [mDic setObject:[arr objectAtIndex:3] forKey:@"SWT"];
            [mDic setObject:[arr objectAtIndex:4] forKey:@"DURATION"];
            [mDic setObject:[arr objectAtIndex:5] forKey:@"ED"];//
            [mDic setObject:[arr objectAtIndex:6] forKey:@"EST"];//
        }
        [resultTimeMoveArry addObject:mDic];
        
        //        [mDic autorelease];
    }
    
    
    //    return [resultTimeMoveArry autorelease];
    
    return resultTimeMoveArry;
}





//拼接回看
/**
 *  拼接的回看信息
 *
 *  @param backArr 读取数据库中得回看信息
 *
 *  @return 拼接成功后需要上传服务器的回看信息
 */



-(NSMutableArray *)getZZSPlayBackArrWith:(NSMutableArray *)backArr{
    NSMutableArray *resultBackArr = [[NSMutableArray alloc]init];
    for (int i=0; i<backArr.count; i++) {
        NSString *str = [backArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        if (arr.count==8) {
            //            [mDic setObject:[arr objectAtIndex:0] forKey:@"SID"];//回看事件编号 (这个参数在数据库并没有存储)
            [mDic setObject:[arr objectAtIndex:0] forKey:@"EVENTNAME"];//事件名称
            [mDic setObject:[arr objectAtIndex:1] forKey:@"EID"];//事件ID
            [mDic setObject:[arr objectAtIndex:2] forKey:@"SID"];//频道ID
            [mDic setObject:[arr objectAtIndex:3] forKey:@"CHNAME"];//频道名称
            [mDic setObject:[arr objectAtIndex:4] forKey:@"ED"];//回看节目时长
            [mDic setObject:[arr objectAtIndex:5] forKey:@"EST"];//开始时间
            [mDic setObject:[arr objectAtIndex:6] forKey:@"DURATION"];//观看时长
            [mDic setObject:[arr objectAtIndex:7] forKey:@"SWT"];//观看时刻
            
        }
        [resultBackArr addObject:mDic];
        
        //        [mDic autorelease];
    }
    
    //    return [resultBackArr autorelease];
    
    return resultBackArr;
}
/**
 *  拼接的EPG信息
 *
 *  @param EPGArr 读取的EPG的数组
 *
 *  @return return 返回拼接后需要上传的EPG信息
 */



//拼接EPG
-(NSMutableArray *)getZZSEPGArrWith:(NSMutableArray *)EPGArr{
    NSMutableArray *resultEPGArr = [[NSMutableArray alloc]init];
    for (int i=0; i<EPGArr.count; i++) {
        NSString *str = [EPGArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        if (arr.count==5) {
            [mDic setObject:[arr objectAtIndex:0] forKey:@"STYPE"];//频道分类
            [mDic setObject:[arr objectAtIndex:1] forKey:@"SNAME"];//频道名称
            [mDic setObject:[arr objectAtIndex:2] forKey:@"ETRANGE"];//事件区间
            [mDic setObject:[arr objectAtIndex:3] forKey:@"BD"];//浏览时长
            [mDic setObject:[arr objectAtIndex:4] forKey:@"BT"];//浏览时刻
        }
        [resultEPGArr addObject:mDic];
        
        //        [mDic autorelease];
    }
    //    return [resultEPGArr autorelease];
    return resultEPGArr;
}


-(NSMutableArray *)getZZSVODArrWith:(NSMutableArray *)VODArr
{
    
    
    //     NSString *str = [NSString stringWithFormat:@"%@+%@+%@+%@",vodFenlei,vodName,vodTime,vodDuration];
    
    NSMutableArray *resultVODArr = [[NSMutableArray alloc]init];
    for (int i=0; i<VODArr.count; i++) {
        NSString *str = [VODArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        if (arr.count==4) {
            [mDic setObject:[arr objectAtIndex:0] forKey:@"PROGNT"];//点播节目分类
            [mDic setObject:[arr objectAtIndex:1] forKey:@"PROGNAME"];//点播节目名称名称
            [mDic setObject:[arr objectAtIndex:2] forKey:@"SWT"];//点播时刻
            [mDic setObject:[arr objectAtIndex:3] forKey:@"DURATION"];//浏览时长
            
        }
        [resultVODArr addObject:mDic];
        
        //        [mDic autorelease];
    }
    //    return [resultVODArr autorelease];
    
    
    return resultVODArr;
    
    
    
    
    
}






/**
 *  拼接的搜索EPG信息
 *
 *  @param searchArr 搜索EPG的数组
 *
 *  @return 拼接后需要上传服务器的数组
 */

-(NSMutableArray *)getZZSSearchEPGArrWith:(NSMutableArray *)searchArr{
    
    NSMutableArray *resultArr = [[NSMutableArray alloc]init];
    for (int i=0; i<searchArr.count; i++) {
        NSString *str = [searchArr objectAtIndex:i];
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc]init];
        NSArray *arr = [str componentsSeparatedByString:@"+"];
        
        if (arr.count==4) {
            
            //zzs采集 搜索
            [mDic setObject:[arr objectAtIndex:0] forKey:@"SType"];//频道分类
            [mDic setObject:[arr objectAtIndex:1] forKey:@"SName"];//频道名称
            [mDic setObject:[arr objectAtIndex:2] forKey:@"SK"];//搜索关键字
            [mDic setObject:[arr objectAtIndex:3] forKey:@"ST"];//搜索时刻
            
            
        }
        
        [mDic removeObjectForKey:@"SType"];
        [mDic removeObjectForKey:@"SName"];//暂不需要频道分类 和 频道名称
        
        [resultArr addObject:mDic];
        
        
        //        [mDic autorelease];
        
    }
    
    //    return [resultArr autorelease];
    
    
    return resultArr;
}











#pragma mark --------------------
#pragma mark -- 获取文件路径

//   数据库  创建
//  获得存放数据库文件的沙盒地址
-(NSString *)databaseFilePath
{
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    //    NSLog(@"filePath  ===    %@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"UserBehaviorSQL.db"];
    NSLog(@"filePath  ===    %@",dbFilePath);
    
    // NSString *filePath = @"/Users/apple/Desktop/Sqlite/UserBehaviorSQL.db";
    
    
    
    return dbFilePath;
}








@end
