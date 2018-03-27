//
//  SKDataBaseManger.m
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SKDataBaseManger.h"

@implementation SKDataBaseManger


+(SKDataBaseManger *)shareManger
{
    // 线程锁
    // 加锁 : 为了防止多条线程同时去访问插入数据的代码导致数据紊乱.所以加锁保证在插入数据的时间内只有一条线程访问.
    @synchronized (self) {
        static SKDataBaseManger *mgr = nil;
        if (mgr == nil) {
            mgr = [[SKDataBaseManger alloc]init];
        }
        return mgr;
    }

}

#pragma mark - 初始化 
- (instancetype)init
{
    if (self = [super init]) {
        [self createDataBase];
    }
    return self;
}

#pragma mark - 创建数据库
- (void)createDataBase
{
    // 创建数据库的路径
    NSString *dataPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/movie.db"];
    _dataBase = [[FMDatabase alloc]initWithPath:dataPath];
    SKLog(@"%@",dataPath);
    if ([_dataBase open]) {
        // 创建分享电影的列表
        [self createShareMovieTable];
        // 创建电影就评论的列表
        [self createMovieCommentTable];
        // 创建搜索记录的列表
        [self createSearchRecordTable];
        // 创建收藏记录的表格
        [self createFavoriteTable];
    }
}
#pragma mark - 创建分享电影的表
- (void)createShareMovieTable
{
    // 1 创建表格
    NSString *createTable = @"create table if not exists shareMovie(movieName varchar(128),faceStr varchar(1024),movieStr varchar(1024))";
    
    // 2 执行sql 语句
    BOOL isSucess = [_dataBase executeUpdate:createTable];
    if (isSucess) {
        SKLog(@"创建分享电影列表成功");
    }else{
        SKLog(@"---创建分享电影列表失败---");
    }
}

#pragma mark - 插入分享电影的数据
- (void)insertName:(NSString *)mName withFaceStr:(NSString *)faceStr withMovieStr:(NSString *)movieStr
{
    NSString *insertS = @"insert into shareMovie(movieName,faceStr,movieStr)values(?,?,?)";
    BOOL isSuccess = [_dataBase executeUpdate:insertS,mName,faceStr,movieStr];
    if (isSuccess) {
        SKLog(@"插入分享电影数据成功");
    }else{
        SKLog(@"---插入分享电影数据失败---");
    }
    
}

#pragma mark -删除分享电影的数据
- (void)deleteShareMovieDataWithMovieName:(NSString *)movieName
{
    NSString *sql = @"delete from shareMovie where movieName = ?";
    // 执行sql 语句
    BOOL isSuccess = [_dataBase executeUpdate:sql,movieName];
    NSLog(isSuccess ? @"分享电影数据删除成功" : @"分享电影数据删除失败");
}
#pragma mark - 查询所有的分享数据
- (NSArray *)selectAllShareMovieData
{
    NSString *sql = @"select * from shareMovie";
    FMResultSet *set = [_dataBase executeQuery:sql];

    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        ShareMovieModel *model = [[ShareMovieModel alloc]init];
        model.movieName = [set stringForColumn:@"movieName"];
        model.faceStr = [set stringForColumn:@"faceStr"];
        model.movieStr = [set stringForColumn:@"movieStr"];
        [arr addObject:model];
    }
    return  arr;
}


#pragma mark - 创建电影评论的表
- (void)createMovieCommentTable
{
    // 1 创建表格
    NSString *createTable = @"create table if not exists movieComment(movieName varchar(128),title varchar(128),summary varchar(1024),author varchar(128),shareUrl varchar(1024))";
    
    // 2 执行sql 语句
    BOOL isSucess = [_dataBase executeUpdate:createTable];
    if (isSucess) {
        SKLog(@"创建电影评论列表成功");
    }else{
        SKLog(@"---创建电影评论列表失败---");
    }
}


#pragma mark - 插入分享影评的数据
- (void)insertCommentName:(NSString *)mName withTitle:(NSString *)ftitle Summary:(NSString *)summary Author:(NSString *)author withShareUrl:(NSString *)shareUrl
{
    NSString *insertS = @"insert into movieComment(movieName,title,summary,author,shareUrl)values(?,?,?,?,?)";
    BOOL isSuccess = [_dataBase executeUpdate:insertS,mName,ftitle,summary,author,shareUrl];
    if (isSuccess) {
        SKLog(@"插入分享电影数据成功");
    }else{
        SKLog(@"---插入分享电影数据失败---");
    }

}
#pragma mark - 删除分享影评的数据
-(void)deleteCommentMovieDataWithTitle:(NSString *)title
{
    NSString *sql = @"delete from movieComment where title = ?";
    // 执行sql 语句
    BOOL isSuccess = [_dataBase executeUpdate:sql,title];
    NSLog(isSuccess ? @"影评数据删除成功" : @"影评数据删除失败");
}

-(NSArray *)selectAllCommentData
{
    NSString *sql = @"select * from movieComment";
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        MovieCommentModel *model = [[MovieCommentModel alloc]init];
        model.movieName = [set stringForColumn:@"movieName"];
        model.summary = [set stringForColumn:@"summary"];
        model.author = [set stringForColumn:@"author"];
        model.share_url = [set stringForColumn:@"shareUrl"];
        model.title = [set stringForColumn:@"title"];
        [arr addObject:model];
    }
    return  arr;
}

#pragma mark - 创建搜索记录列表
- (void)createSearchRecordTable
{
    // 1 创建表格
    NSString *createTable = @"create table if not exists searchRecord(keyWord varchar(128),time varchar(128))";
   // 2 执行sql 语句
    BOOL isSucess = [_dataBase executeUpdate:createTable];
    if (isSucess) {
        SKLog(@"创建搜索记录列表成功");
    }else{
        SKLog(@"---创建搜索记录列表失败---");
    }

}
#pragma mark - 插入一条数据
-(void)insertSearchWord:(NSString *)keyWord withTime:(NSString *)time
{
    NSString *insertS = @"insert into searchRecord(keyWord,time)values(?,?)";
    BOOL isSuccess = [_dataBase executeUpdate:insertS,keyWord,time];
    if (isSuccess) {
        SKLog(@"插入搜索记录数据成功");
    }else{
        SKLog(@"---插入搜索记录数据失败---");
    }
  
}
#pragma mark - 查询搜索数据
- (NSArray *)selectAllSearchRecord
{
    NSString *sql = @"select * from searchRecord";
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        SearchRecodModel *model = [[SearchRecodModel alloc]init];
        model.keyWord = [set stringForColumn:@"keyWord"];
        model.time = [set stringForColumn:@"time"];
        [arr addObject:model];
    }
    return  arr;
}

#pragma mark - 创建收藏记录的表格
- (void)createFavoriteTable
{
    // 1 创建表格
    NSString *createTable = @"create table if not exists favoriteRecord(faceStr varchar(1024),detailUrl varchar(1024),title varchar(128),movieId varchar(128))";
    // 2 执行sql 语句
    BOOL isSucess = [_dataBase executeUpdate:createTable];
    if (isSucess) {
        SKLog(@"创建搜索记录列表成功");
    }else{
        SKLog(@"---创建搜索记录列表失败---");
    }

}
#pragma mark - 插入一条收藏的数据
-(void)insertFavoriteFaceUrl:(NSString *)url detailUrl:(NSString *)detailUrl movieTitle:(NSString *)title movieID:(NSString *)ID
{
    NSString *insertS = @"insert into favoriteRecord(faceStr,detailUrl,title,movieId)values(?,?,?,?)";
    BOOL isSuccess = [_dataBase executeUpdate:insertS,url,detailUrl,title,ID];
    if (isSuccess) {
        SKLog(@"插入搜索记录数据成功");
    }else{
        SKLog(@"---插入搜索记录数据失败---");
    }
    
}

- (NSArray *)selectAllFavoriteData
{
    NSString *sql = @"select * from favoriteRecord";
    FMResultSet *set = [_dataBase executeQuery:sql];
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    while ([set next]) {
        FavoriteModel *model = [[FavoriteModel alloc]init];
        model.detailUrl = [set stringForColumn:@"detailUrl"];
        model.title = [set stringForColumn:@"title"];
        model.movieID = [set stringForColumn:@"movieId"];
        model.faceStr = [set stringForColumn:@"faceStr"];
        [arr addObject:model];
    }
    return  arr;

}


@end
