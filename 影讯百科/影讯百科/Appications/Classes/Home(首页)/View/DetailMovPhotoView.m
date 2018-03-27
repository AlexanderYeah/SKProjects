//
//  DetailMovPhotoView.m
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "DetailMovPhotoView.h"
#import "DetailModel.h"
@implementation DetailMovPhotoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark - 创建UI
- (void)createUI
{
    SKLog(@"112314564");
    // 1 创建滚动视图
    CGFloat photoWidth = 120;
    CGFloat photoHeight = 120;
    CGFloat padding = 10;
    for (int i = 0; i <self.photoArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + photoWidth * i + padding * i, 10, photoWidth, photoHeight)];
        NSURL *imgUrl =  [self dealWithUrlStr:self.photoArray[i] width:280 height:280];
        [imageView sd_setImageWithURL:imgUrl];
        SKLog(@"%@",imgUrl);
        [self addSubview:imageView];
        
    }
    
    self.contentSize = CGSizeMake(self.photoArray.count * 130, 0);
    
}

#pragma mark - 设置数据 
-(void)setModel:(DetailModel *)model
{
    _model = model;
    SKLog(@"%@",model.photos);
    self.photoArray = model.photos;
    [self layoutIfNeeded];
}

#pragma mark - 图片网址处理函数
- (NSURL *)dealWithUrlStr:(NSString *)str width:(CGFloat)imgWidth height:(CGFloat)imgHeight
{
    NSArray *componentArr = [str componentsSeparatedByString:@"/"];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:componentArr];
    
    [tempArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.0f.%.0f",imgWidth,imgHeight]];
    
    NSString *resulturl = [tempArr componentsJoinedByString:@"/"];
    NSURL *url = [NSURL URLWithString:resulturl];
    return url;
    
}


@end
