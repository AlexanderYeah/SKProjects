//
//  SKDataBaseManger.h
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "ShareMovieModel.h"
#import "MovieCommentModel.h"
#import "SearchRecodModel.h"
#import "FavoriteModel.h"
@interface SKDataBaseManger : NSObject

/** 数据库属性  */
@property (nonatomic,strong)FMDatabase *dataBase;
/*---------------关于分享电影--------------*/
/**
 *  单例方法创建数据库
 */
+ (SKDataBaseManger *)shareManger;
/**
 *   插入分享的数据，分享的电影
     分享内容：影片名 + 影片封面链接 + 影片链接
 */
- (void)insertName:(NSString *)mName withFaceStr:(NSString *)faceStr withMovieStr:(NSString *)movieStr;
/**
 *  删除分享的电影数据，根据电影名字进行删除
 */
- (void)deleteShareMovieDataWithMovieName:(NSString *)movieName;
/**
 *  查询分享电影的所有数据
 */
- (NSArray *)selectAllShareMovieData;

/**
 *  插入分享影评的数据
 */
- (void)insertCommentName:(NSString *)mName withTitle:(NSString *)ftitle Summary:(NSString *)summary Author:(NSString *)author withShareUrl:(NSString *)shareUrl;
/**
 *  删除影评数据

 */
- (void)deleteCommentMovieDataWithTitle:(NSString *)title;
/**
 *  查询分享影评的所有数据
 */
- (NSArray *)selectAllCommentData;

/*---------------关于搜索记录--------------*/
/**
 *  插入一条搜索记录数据
 *
 *  @param keyWord 搜索关键词
 *  @param time    搜索时间
 */
- (void)insertSearchWord:(NSString *)keyWord withTime:(NSString *)time;

/**
 *  根据关键词删除搜索数据
 *
 *  @param keyWord 搜索关键词
 */
- (void)deleteWithWord:(NSString *)keyWord;
/**
 *  查询所有的搜索关键记录
 */
- (NSArray *)selectAllSearchRecord;

/*---------------关于收藏记录--------------*/
/**
 *  插入一条收藏的数据
 *
 *  @param url       封面的网址
 *  @param detailUrl 详情url
 *  @param title     电影的标题
 *  @param ID        电影的ID
 */
- (void)insertFavoriteFaceUrl:(NSString *)url detailUrl:(NSString *)detailUrl movieTitle:(NSString *)title movieID:(NSString *)ID;
/**
 *  删除一条收藏的数据
 *
 *  @param title 电影名
 */
- (void)deleteFavoriteRecordWithMovieTitle:(NSString *)title;
/**
 *  查询所有的收藏数据
 *
 *  @return 查询结果数组
 */
- (NSArray *)selectAllFavoriteData;

@end
