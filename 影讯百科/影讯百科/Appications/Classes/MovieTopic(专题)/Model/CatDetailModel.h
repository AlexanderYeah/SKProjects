//
//  CatDetailModel.h
//  影讯百科
//
//  Created by g1game on 16/9/8.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatDetailModel : NSObject

/** 片长 */
@property (nonatomic,copy)NSString *dur;

/** 影片id */
@property (nonatomic,assign)NSNumber *id;

/** 影片名 */
@property (nonatomic,copy)NSString *nm;

/** 影片封面 */
@property (nonatomic,copy)NSString *img;

@end
