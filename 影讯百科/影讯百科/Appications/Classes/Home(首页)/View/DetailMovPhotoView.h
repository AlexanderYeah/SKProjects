//
//  DetailMovPhotoView.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@interface DetailMovPhotoView : UIScrollView

/** 滚动视图的图片数组*/
@property (nonatomic,strong)NSArray *photoArray;

/** 模型*/
@property (nonatomic,strong)DetailModel *model;

@end
