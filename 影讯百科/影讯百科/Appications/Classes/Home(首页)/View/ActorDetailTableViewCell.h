//
//  ActorDetailTableViewCell.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActorMovieModel;
@interface ActorDetailTableViewCell : UITableViewCell

/** 头像 */
@property (nonatomic,strong)UIImageView *avatarImgView;
/** 职务 */
@property (nonatomic,strong)UILabel *dutyLbl;
/** 影片名 */
@property (nonatomic,strong)UILabel *movieNameLbl;
/** 上映日期 */
@property (nonatomic,strong)UILabel *pubTimeLbl;
/** 模型 */
@property (nonatomic,strong)ActorMovieModel *model;



@end
