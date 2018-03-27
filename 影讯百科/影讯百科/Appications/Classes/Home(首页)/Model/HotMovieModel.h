//
//  HotMovieModel.h
//  影讯百科
//
//  Created by g1game on 16/8/26.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotMovieModel : NSObject
/** 影片名 */
@property (nonatomic,copy)NSString *nm;
/** 上映日期 */
@property (nonatomic,copy)NSString *comingTitle;
/** 影片介绍 */
@property (nonatomic,copy)NSString *scm;
/** 上映日期 */
@property (nonatomic,copy)NSString *pubDesc;
/** 影片时长 */
@property (nonatomic,copy)NSString *dur;
/** 影片封面 */
@property (nonatomic,copy)NSString *img;
/** 影片评分 */
@property (nonatomic,copy)NSString *mk;
/** 影片主演 */
@property (nonatomic,copy)NSString *star;
/** 影片id */
@property (nonatomic,assign)NSNumber *id;




@end
