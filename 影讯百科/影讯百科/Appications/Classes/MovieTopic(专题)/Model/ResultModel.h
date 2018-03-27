//
//  ResultModel.h
//  影讯百科
//
//  Created by g1game on 16/9/14.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject

/** 演员 */
@property (nonatomic,strong)NSString *actors;
/** 地区 */
@property (nonatomic,strong)NSString *area;
/** 名字 */
@property (nonatomic,strong)NSString *fullName;
/** 年代 */
@property (nonatomic,strong)NSString *year;
/** 封面 */
@property (nonatomic,strong)NSString *imgUrl;
/** 封面 */
@property (nonatomic,strong)NSString *gid;




@end
