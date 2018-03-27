//
//  MonthBoxModel.h
//  影讯百科
//
//  Created by Alexander on 16/9/5.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MonthBoxModel : NSObject


/** 影片名 */
@property (nonatomic,copy)NSString *MovieName;
/** 影片排行 */
@property (nonatomic,copy)NSString *rank;
/** 总的票房 */
@property (nonatomic,copy)NSString *boxoffice;
/** 上映时间 */
@property (nonatomic,copy)NSString *releaseTime;
/** 上映日期 */
@property (nonatomic,copy)NSString *days;



@end
