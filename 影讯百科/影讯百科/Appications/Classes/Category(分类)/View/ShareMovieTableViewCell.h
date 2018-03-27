//
//  ShareMovieTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareMovieModel;
@interface ShareMovieTableViewCell : UITableViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 分享链接 */
@property (nonatomic,strong)UILabel *shareLbl;

/** 模型 */
@property (nonatomic,strong)ShareMovieModel *model;



@end
