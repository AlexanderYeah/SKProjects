//
//  CategoryCollectionViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/8.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CatDetailModel;
@interface CategoryCollectionViewCell : UICollectionViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 时长 */
@property (nonatomic,strong)UILabel *durLbl;

/** 模型 */
@property (nonatomic,strong)CatDetailModel *model;



@end
