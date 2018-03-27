//
//  CommentFirstModel.h
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentFirstModel : NSObject

/** 标题 */
@property (nonatomic,strong)NSString *title;
/** 概要 */
@property (nonatomic,strong)NSString *summary;
/** 作者 */
@property (nonatomic,strong)NSDictionary *author;
/** 影评网址 */
@property (nonatomic,strong)NSString *share_url;
/** 评论数量 */
@property (nonatomic,strong)NSString *comments_count;


@end
