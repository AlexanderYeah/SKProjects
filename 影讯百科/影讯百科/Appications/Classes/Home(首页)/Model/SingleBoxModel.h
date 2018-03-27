//
//  SingleBoxModel.h
//  影讯百科
//
//  Created by Alexander on 16/9/5.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleBoxModel : NSObject

/** 影片名 */
@property (nonatomic,copy)NSString *MovieName;
/** 影片排行 */
@property (nonatomic,copy)NSString *Rank;
/** 总的票房 */
@property (nonatomic,copy)NSString *SumBoxOffice;
/** 今日票房 */
@property (nonatomic,copy)NSString *BoxOffice;
/** 上映日期 */
@property (nonatomic,copy)NSString *MovieDay;
/** 平均票价 */
@property (nonatomic,copy)NSString *AvgPrice;


@end
