//
//  SecondTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondModel;
@interface SecondTableViewCell : UITableViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 年份 */
@property (nonatomic,strong)UILabel *yearLbl;
/**  */
@property (nonatomic,strong)SecondModel *model;



@end
