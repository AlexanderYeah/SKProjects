//
//  DetailFirstTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFirstTableViewCell : UITableViewCell

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 导演 */
@property (nonatomic,strong)UILabel *diretorLbl;
/** 主演 */
@property (nonatomic,strong)UILabel *castsLbl;


/** 数据源 */
@property (nonatomic,strong)NSDictionary *cellDic;


@end
