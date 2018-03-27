//
//  ResultTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/14.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResultModel;
@interface ResultTableViewCell : UITableViewCell


/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 地区 */
@property (nonatomic,strong)UILabel *areaLbl;
/** 主演 */
@property (nonatomic,strong)UILabel *castsLbl;

/**  年份 */
@property (nonatomic,strong)UILabel *yearLbl;

/** 模型 */
@property (nonatomic,strong)ResultModel *model;




@end
