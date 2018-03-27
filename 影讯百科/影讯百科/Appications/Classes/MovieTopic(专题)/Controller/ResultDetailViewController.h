//
//  ResultDetailViewController.h
//  影讯百科
//
//  Created by g1game on 16/9/18.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultDetailViewController : UIViewController

/** 影片的Gid */
@property (nonatomic,strong)NSString *itemGid;


- (instancetype)initWithGid:(NSString *)Gid;
@end
