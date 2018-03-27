//
//  WillShowModel.h
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WillShowModel : NSObject

/** 影片名 */
@property (nonatomic,copy)NSString *nm;
/** 影片介绍 */
@property (nonatomic,copy)NSString *scm;
/** 上映日期 */
@property (nonatomic,copy)NSString *pubDesc;
/** 影片时长 */
@property (nonatomic,copy)NSString *dur;
/** 影片封面 */
@property (nonatomic,copy)NSString *img;

/** 影片主演 */
@property (nonatomic,copy)NSString *star;
/** 影片id */
@property (nonatomic,assign)NSNumber *id;

@end
