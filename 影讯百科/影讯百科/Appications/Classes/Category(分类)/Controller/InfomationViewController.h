//
//  InfomationViewController.h
//  影讯百科
//
//  Created by g1game on 16/9/19.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfomationViewController : UIViewController

/**  */
@property (nonatomic,strong)NSString *navTitle;
@property (nonatomic,strong)NSString *shareUrl;
- (instancetype)initWithNavTitle:(NSString *)navTitle initWithUrl:(NSString *)shareUrl;

@end
