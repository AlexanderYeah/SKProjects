//
//  CommentDetailViewController.h
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentDetailViewController : UIViewController

/** url */
@property (nonatomic,strong)NSURL *shareUrl;
@property (nonatomic,strong)NSString *shareUrlStr;
/**  */
@property (nonatomic,strong)NSString *shareTitle;

/** 电影名 */
@property (nonatomic,strong)NSString *movieName;
/** 概要 */
@property (nonatomic,strong)NSString *summary;
/** 作者 */
@property (nonatomic,strong)NSString *author;




@end
