//
//  LocalData.m
//  SMZDM
//
//  Created by 冯展波 on 14-7-17.
//
//

#import "LocalData.h"

@implementation LocalData
@synthesize fmDatabase;
- (void)closeSqlite
{
    [self.fmDatabase close];
}

- (void)dealloc
{
    [self closeSqlite];
}


/**
 *	@brief	获取数据库路径
 *
 *	@return	<#return value description#>
 */
- (FMDatabase *)getDb
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    FMDatabase *tempfmDatabase =[FMDatabase databaseWithPath:[documentDirectory stringByAppendingPathComponent:@"SMZDM.db"]];

    return tempfmDatabase;
}

/**
 *	@brief	打开数据库
 */
- (void)openSqlite
{
    self.fmDatabase = [self getDb];
    if ( [self.fmDatabase open] )
    {
        [self.fmDatabase setShouldCacheStatements:YES];
        [self.fmDatabase beginTransaction];
        [self createUser:self.fmDatabase];

//        [self createJingxuan:self.fmDatabase];

        [self createFav:self.fmDatabase];
        [self createScroe:self.fmDatabase];
        [self createBKScroe:self.fmDatabase];
        [self createHTFav:self.fmDatabase];

        [self createScroe2:self.fmDatabase];
        [self createCollcet:self.fmDatabase];

        [self createList:self.fmDatabase];
        [self createSPBKList:self.fmDatabase];
        [self createDetail:self.fmDatabase];
        [self createPindan:self.fmDatabase];

        [self createImg:self.fmDatabase];

        [self createSerise:self.fmDatabase];
        [self createBanner:self.fmDatabase];

        [self createWatch:self.fmDatabase];
        [self createImgGQ:self.fmDatabase];
        [self createBKCollcet:self.fmDatabase];
        [self createDetailScroe:self.fmDatabase];
        [self createspike:self.fmDatabase];//秒杀
        [self createShareOrder:self.fmDatabase];//请晒单

        [self createArticleReport:self.fmDatabase];//优惠举报

        [self.fmDatabase commit];
    }
}
/**
 *  创建个人中心
 *
 *  @param database <#database description#>
 */
- (void)createUser:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS USER (id varchar(50) primary key,UserName varchar(50),UserPsw varchar(50),token varchar(50),avatar varchar(200),cexperience varchar(20),cgold varchar(20),checkin varchar(20),cpoints varchar(20),cprestige varchar(20),daily_num varchar(20),description TEXT,nickname varchar(20),rank varchar(20),email varchar(100),bindmobile varchar(10),ban_baoliao varchar(10),ban_comment varchar(10),silver varchar(20),day_has_shang_gold varchar(20),day_shang_gold_limit varchar(20),every_shang_gold_limit varchar(20),is_set_safepass varchar(20),baoliao_count varchar (10),yuanchuang_count varchar(10),zhongce_count varchar(10),second_count varchar(10),wiki_count varchar(10),favorite_count varchar(10),fans_num varchar(10),follower_num varchar(10),isOpenOneKeyOut varchar(10),is_show_my_medal varchar(10),is_bind_visa varchar(10),video_is_show varchar(10),baoliao_comment_msg varchar(10),en_key varchar(64),server_time varchar(64))"];
}

- (void)createJingxuan:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS JINGXUAN (id varchar(50) primary key,datetime varchar(20),detail varchar(20))"];
}
- (void)createFav:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS FAVORITE (id varchar(50) primary key,datetime varchar(20),detail varchar(20))"];

}
- (void)createScroe:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SCORE (id varchar(50) primary key,datetime varchar(20),detail varchar(20))"];
    
}
- (void)createBKScroe:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS BKSCORE (id varchar(50) primary key,datetime varchar(20),detail varchar(20),type varchar(20))"];
    
}
- (void)createHTFav:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS HTFAV (id varchar(50) primary key,datetime varchar(20),detail varchar(20),type varchar(20))"];
    
}

//评论点赞
- (void)createScroe2:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SCOREPLU (id varchar(50) primary key,datetime varchar(20),detail varchar(20))"];
    
}

- (void)createDetailScroe:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS DETAILPLU (id varchar(50) primary key,datetime varchar(20),detail varchar(20))"];
    
}
- (void)createCollcet:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS COLLECTS (id varchar(50),datetime varchar(20),detail varchar(20),uid INTEGER)"];

}

- (void)createPindan:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS PINDANS (id varchar(50),datetime varchar(20))"];
    
}

- (void)createBKCollcet:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS BKCOLLECT (id varchar(50),datetime varchar(20),detail varchar(20),uid INTEGER,type varchar(20))"];
    
}
- (void)createList:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS List_Datas (article_id varchar(20),article_anonymous varchar(20),article_channel_id varchar(20),article_channel_name varchar(20),article_collection varchar(20),article_comment varchar(20),article_date varchar(20),article_filter_content TEXT,article_format_date varchar(20),article_is_sold_out varchar(20),article_is_timeout varchar(20),article_link varchar(100),article_link_type varchar(20),article_mall varchar(20),article_pic varchar(100),article_price varchar(20),article_referrals varchar(20),article_tag varchar(20),article_title TEXT,article_top varchar(20),article_unix_date varchar(20),article_unworthy varchar(20),article_url varchar(100),article_worthy varchar(20),time_sort varchar(20),list_type varchar(20),nowTime varchar(20),dic TEXT)"];
    
}

- (void)createSPBKList:(FMDatabase *)database
{
     [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SPBKList_Data (article_id varchar(20),article_title varchar(20),article_price varchar(20),article_tag_info varchar(50),article_recommend_uid varchar(20),article_recommend_uname varchar(20),article_recommend_count varchar(20),article_collect_count varchar(20),article_yuanchuang_count varchar(20),article_comment_count varchar(20),article_pic varchar(100),article_one_word_reason TEXT,article_reason TEXT,article_level varchar(20),list_type varchar(10),nowTime varchar(20))"];
    
    
}

- (void)createDetail:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SCANDATA (article_id varchar(20),nowTime varchar(20),type varchar(20))"];

}
- (void)createImg:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS Detail_Img (article_id varchar(20),article_ImgUrl varchar(100),list_type varchar(10),nowTime varchar(20),pic_type varchar(10))"];

}
- (void)createImgGQ:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS Detail_ImgGQ (article_id varchar(20),article_ImgUrl varchar(100),nowTime varchar(20))"];
    
}
- (void)createSerise:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS Detail_Serise (article_id varchar(20),full_title varchar(50),id varchar(20),series_id varchar(20),series_order_id varchar(20),title varchar(20),list_type varchar(10),nowTime varchar(20))"];

}
//appleWatch:
- (void)createWatch:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS WATCH_COLLECT (article_id varchar(20),article_description varchar(100),discount_strength varchar(20),mall varchar(20),publish_date varchar(20),article_comment varchar(20),pic_url varchar(20),list_type varchar(10),nowTime varchar(20))"];
    
}
//banner
- (void)createBanner:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS BANNER_DATA (article_id varchar(20),article_channel_id varchar(20),banner_id varchar(20),banner_order varchar(20),banner_pic varchar(100),banner_pich varchar(20),banner_picw varchar(20),banner_title varchar(50),banner_url varchar(100),banner_type varchar(20),nowTime varchar(20))"];

}
- (void)createspike:(FMDatabase *)database
{
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SPIKE_DATA (article_id varchar(20),localTime varchar(20),otherDate varchar(20))"];
    
}
- (void)createShareOrder:(FMDatabase *)database
{
//    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS SHARE_ORDER (article_id varchar(20),localTime varchar(20),shareTitle varchar(20),type varchar(20))"];
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS CUT_IMAGE (article_id INTEGER PRIMARY KEY AUTOINCREMENT,imageData blob,shareTitle varchar(20),type varchar(20),localTime varchar(20))"];
//    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS ORIGIN_IMAGE (article_id varchar(20),localTime varchar(20),imageData blob)"];


}

- (void)createArticleReport:(FMDatabase *)database
{
    
    [database executeUpdate:@"CREATE TABLE IF NOT EXISTS ArticleReport (id varchar(20),datetime varchar(20))"];
    
}

@end
