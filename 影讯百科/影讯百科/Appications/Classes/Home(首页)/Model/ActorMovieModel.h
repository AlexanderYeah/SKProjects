//
//  ActorMovieModel.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorMovieModel : NSObject


/** 头像 */
@property (nonatomic,copy)NSString *avatar;
/** 职务 */
@property (nonatomic,copy)NSString *duty;
/** 影片名 */
@property (nonatomic,copy)NSString *name;
/** 上映日期 */
@property (nonatomic,copy)NSString *rt;
/** 影片ID */
@property (nonatomic,copy)NSNumber *id;

@end
