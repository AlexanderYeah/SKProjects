//
//  BoxOfficeTableViewCell.h
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SingleBoxModel;
@class WeekBoxModel;
@class MonthBoxModel;
@interface BoxOfficeTableViewCell : UITableViewCell

/** 影片名*/
@property (nonatomic,strong)UILabel *nameLbl;
/** 排行*/
@property (nonatomic,strong)UILabel *rankLbl;
/** 累计票房*/
@property (nonatomic,strong)UILabel *totalBoxLbl;
/** 周末票房*/
@property (nonatomic,strong)UILabel *weekBoxLbl;
/** 上映时间 */
@property (nonatomic,strong)UILabel *showTimeLbl;

/** 上映时间 */
@property (nonatomic,strong)SingleBoxModel *model;

/** 周末票房模型 */
@property (nonatomic,strong)WeekBoxModel *weekModel;

/** 月票房模型 */
@property (nonatomic,strong)MonthBoxModel *monthModel;

@end
