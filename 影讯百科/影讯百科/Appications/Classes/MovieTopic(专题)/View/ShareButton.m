//
//  ShareButton.m
//  Lottery
//
//  Created by g1game on 16/5/13.
//  Copyright © 2016年 g1game. All rights reserved.
//

#import "ShareButton.h"

@implementation ShareButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    
    return self;
}

#pragma mark - 重置UI
- (void)createUI
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor colorWithRed:162/255.0f green:162/255.0f blue:162/255.0f alpha:1] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12.0f];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1 img
    CGFloat imgX = 0;
    CGFloat imgY = 0;
    CGFloat imgW = 60;
    CGFloat imgH = 60;
    self.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    // 2 titleLabel
    CGFloat btnX = 0;
    CGFloat btnY = 60;
    CGFloat btnW = 60;
    CGFloat btnH = 20;
    self.titleLabel.frame = CGRectMake(btnX, btnY, btnW, btnH);
    

}

@end
