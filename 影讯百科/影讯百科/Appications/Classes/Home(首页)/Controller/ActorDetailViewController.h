//
//  ActorDetailViewController.h
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActorDetailViewController : UIViewController

/**ID */
@property (nonatomic,strong)NSString *ID;


- (instancetype)initWithID:(NSString *)ID;

@end
