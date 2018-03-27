//
//  SearchTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchRecodModel;
@interface SearchTableViewCell : UITableViewCell


/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 概要 */
@property (nonatomic,strong)UILabel *timeLbl;

/**  */
@property (nonatomic,strong)SearchRecodModel *model;


@end
