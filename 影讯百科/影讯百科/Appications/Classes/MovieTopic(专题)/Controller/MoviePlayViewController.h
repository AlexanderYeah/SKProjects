//
//  MoviePlayViewController.h
//  影讯百科
//
//  Created by g1game on 16/9/18.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayViewController : UIViewController



/**  */
@property (nonatomic,strong)NSString *videoName;

/**  */
@property (nonatomic,strong)NSURL *videoUrl;




-(instancetype)initWithVideoUrl:(NSURL *)url WithVideoName:(NSString *)videoName;


@end
