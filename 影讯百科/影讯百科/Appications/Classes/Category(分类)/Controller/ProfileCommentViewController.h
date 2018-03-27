//
//  ProfileCommentViewController.h
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileCommentViewController : UIViewController

@property (nonatomic,strong)NSString *shareUrlStr;
/**  */
@property (nonatomic,strong)NSString *shareTitle;


-(instancetype)initWithShareUrl:(NSString *)shareUrl withShareTitle:(NSString *)title;
@end
