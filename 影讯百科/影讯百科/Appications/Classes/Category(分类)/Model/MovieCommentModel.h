//
//  MovieCommentModel.h
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieCommentModel : NSObject

/** 标题 */
@property (nonatomic,strong)NSString *title;
/** 概要 */
@property (nonatomic,strong)NSString *summary;
/** 作者 */
@property (nonatomic,strong)NSString *author;
/** 影评网址 */
@property (nonatomic,strong)NSString *share_url;
/* 电影名 */
@property (nonatomic,strong)NSString *movieName;

@end
