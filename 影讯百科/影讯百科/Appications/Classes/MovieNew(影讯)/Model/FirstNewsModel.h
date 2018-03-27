//
//  FirstNewsModel.h
//  影讯百科
//
//  Created by Alexander on 16/8/31.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstNewsModel : NSObject

/** 封面*/
@property (nonatomic,strong)NSDictionary *images;
/** 标题 */
@property (nonatomic,strong)NSString *title;
/** 年数 */
@property (nonatomic,strong)NSString *year;
/** 影片ID */
@property (nonatomic,strong)NSString * id;


@end
