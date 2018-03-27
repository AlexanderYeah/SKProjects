//
//  MovieCommentTableViewCell.h
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MovieCommentModel;
@interface MovieCommentTableViewCell : UITableViewCell

/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 概要 */
@property (nonatomic,strong)UILabel *summaryLbl;
/** 作者 */
@property (nonatomic,strong)UILabel *authorLbl;
/** 评论数量 */
@property (nonatomic,strong)UILabel *commentCountLbl;

/** model  */
@property (nonatomic,strong)MovieCommentModel *model;


@end
