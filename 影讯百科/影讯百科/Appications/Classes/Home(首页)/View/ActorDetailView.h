//
//  ActorDetailView.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActorModel;
@interface ActorDetailView : UIView

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 中文名 */
@property (nonatomic,strong)UILabel *chineseNameLbl;
/** 英文名 */
@property (nonatomic,strong)UILabel *englishNameLbl;
/** 性别 */
@property (nonatomic,strong)UILabel *sexLbl;
/** 生日 */
@property (nonatomic,strong)UILabel *birthdayLbl;
/** 出生地 */
@property (nonatomic,strong)UILabel *bornPlaceLbl;
/** 封面的URL */
@property (nonatomic,strong)NSURL *faceUrl;

/** 模型 */
@property (nonatomic,strong)ActorModel *model;





@end
