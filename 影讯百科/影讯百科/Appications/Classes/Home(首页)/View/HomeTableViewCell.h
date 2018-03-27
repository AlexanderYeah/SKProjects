//
//  HomeTableViewCell.h
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotMovieModel;
@interface HomeTableViewCell : UITableViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 评分 */
@property (nonatomic,strong)UILabel *scoreLbl;
/** 简介 */
@property (nonatomic,strong)UILabel *summaryLbl;
/** 上映日期 */
@property (nonatomic,strong)UILabel *startTimeLbl;
/** 主演 */
@property (nonatomic,strong)UILabel *actorLbl;

/** 数据模型 */
@property (nonatomic,strong)HotMovieModel *model;

@end
