//
//  FavoriteTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FavoriteModel;
@interface FavoriteTableViewCell : UITableViewCell

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

/**  */
@property (nonatomic,strong)FavoriteModel *model;



@end
