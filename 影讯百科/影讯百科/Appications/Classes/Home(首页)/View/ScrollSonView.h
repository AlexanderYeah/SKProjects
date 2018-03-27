//
//  ScrollSonView.h
//  影讯百科
//
//  Created by g1game on 16/8/26.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotMovieModel;
@interface ScrollSonView : UIView

@property (nonatomic,strong)HotMovieModel *model;


/** 电影封面 */
@property (nonatomic,strong)UIImageView *movieFaceView;
/** 电影标题 */
@property (nonatomic,strong)UILabel *movieTitleLbl;


@end
