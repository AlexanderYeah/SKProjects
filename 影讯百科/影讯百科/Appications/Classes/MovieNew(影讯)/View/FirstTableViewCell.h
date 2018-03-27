//
//  FirstTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/12.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FirstNewsModel;
@interface FirstTableViewCell : UITableViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 年份 */
@property (nonatomic,strong)UILabel *yearLbl;

/** 模型 */
@property (nonatomic,strong)FirstNewsModel *model;



@end
