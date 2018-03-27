//
//  DetailFirstView.h
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@protocol DetailFirstViewDelegate <NSObject>

- (void)collectBtnClick;
- (void)shareBtnClick;

@end

@interface DetailFirstView : UIView

/**  */
@property (nonatomic,assign)id<DetailFirstViewDelegate> delegate;




/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 类型 */
@property (nonatomic,strong)UILabel *catLbl;
/** 评分 */
@property (nonatomic,strong)UILabel *scoreLbl;
/** 评分图片 */
@property (nonatomic,strong)UIImageView *scoreImgView;
/** 评分人数 */
@property (nonatomic,strong)UILabel *commentCountLbl;
/** 上映日期 */
@property (nonatomic,strong)UILabel *startTimeLbl;
/** 时长 */
@property (nonatomic,strong)UILabel *durationLbl;
/** 封面的URL */
@property (nonatomic,strong)NSURL *faceUrl;


/** 模型 */
@property (nonatomic,copy)DetailModel *model;

@end
