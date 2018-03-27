//
//  ActorModel.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActorModel : NSObject

/** 头像 */
@property (nonatomic,copy)NSString *avatar;
/** 中文名 */
@property (nonatomic,copy)NSString *cnm;
/** 英文名 */
@property (nonatomic,copy)NSString *enm;
/** 性别 */
@property (nonatomic,copy)NSString *sexy;
/** 生日 */
@property (nonatomic,copy)NSString *birthday;
/** 出生地 */
@property (nonatomic,copy)NSString *birthplace;
/** 个人信息 */
@property (nonatomic,copy)NSString *desc;
/** 剧照数组 */
@property (nonatomic,copy)NSArray *photos;


@end
