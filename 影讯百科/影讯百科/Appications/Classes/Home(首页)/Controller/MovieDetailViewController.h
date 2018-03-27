//
//  MovieDetailViewController.h
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

/** 影片封面 */
@property (nonatomic,strong)NSURL *faceUrl;
/** 影片ID */
@property (nonatomic,copy)NSString *detailUrl;
/** 影片名 */
@property (nonatomic,strong)NSString *movieTitle;

/** 影片ID */
@property (nonatomic,strong)NSString *ID;
- (instancetype)initWithFaceUrl:(NSURL *)url detailUrl:(NSString *)detailUrl movieTitle:(NSString *)title movieID:(NSString *)ID;

@end
