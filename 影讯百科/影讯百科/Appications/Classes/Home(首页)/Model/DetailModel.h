//
//  DetailModel.h
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

/** 类型 */
@property (nonatomic,copy)NSString *cat;
/** 片长 */
@property (nonatomic,copy)NSString *dur;
/** 影片介绍 */
@property (nonatomic,copy)NSString *dra;
/** 上映日期 */
@property (nonatomic,copy)NSString *pubDesc;
/** 评分人数 */
@property (nonatomic,copy)NSString *snum;
/** 评分 */
@property (nonatomic,copy)NSString *sc;
/** 剧照数组 */
@property (nonatomic,copy)NSArray *photos;

@end
