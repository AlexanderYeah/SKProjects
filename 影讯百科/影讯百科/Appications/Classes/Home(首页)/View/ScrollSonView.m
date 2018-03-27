//
//  ScrollSonView.m
//  影讯百科
//
//  Created by g1game on 16/8/26.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ScrollSonView.h"
#import "HotMovieModel.h"

@implementation ScrollSonView

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


#pragma mark - 创建UI界面
- (void)createUI
{
    // 1 背景
    
    NSInteger index = arc4random()%7;
    NSArray *bgImageArr = @[@"homeBg1",@"homeBg2",@"homeBg3",@"homeBg4",@"homeBg5",@"homeBg6",@"homeBg7"];
    CGFloat bgViewHeight = kScreenH * 0.44;
    UIImageView *bgView = [self createImageView];
    bgView.image = [UIImage imageNamed:bgImageArr[index]];
    [self addSubview:bgView];
    bgView.backgroundColor = kRandomColor;
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.height.equalTo(bgViewHeight);
        make.width.equalTo(kScreenW);
    }];
    
    // 2 电影封面
    // 方大比例
    CGFloat zoomScale = 1.5;
    CGFloat movFaceHeight = kScreenH * 0.35;
    CGFloat movFaceWidth = movFaceHeight * 0.67;
    CGFloat topPaddng = kScreenH * (0.44 - 0.375) / 2;
    
    _movieFaceView = [self createImageView];
    _movieFaceView.backgroundColor = kRandomColor;
    _movieFaceView.tag = 111;
    [bgView addSubview:_movieFaceView];
    [_movieFaceView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.top).offset(movFaceHeight/2 + topPaddng);
        make.centerX.equalTo(self.centerX).offset(0);
        make.height.equalTo(movFaceHeight / zoomScale);
        make.width.equalTo(movFaceWidth / zoomScale);
    }];
    
    
    // 3 电影名
    
    _movieTitleLbl = [self createLblWithTitle:@"111"];
    [bgView addSubview:_movieTitleLbl];
    [_movieTitleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.top).offset(bgViewHeight);
        make.centerX.equalTo(self.centerX).offset(0);
        make.height.equalTo(topPaddng);
        make.width.equalTo(kScreenW);
    }];
    
    
    
}

#pragma mark - setModel 
-(void)setModel:(HotMovieModel *)model
{
    _model = model;
    //1 进行赋值
    _movieTitleLbl.text = model.nm;
    
    //2 设置图片
    // 2.1 处理一下字符串，拼接宽度和高度
    
    NSString *urlStr = [self dealWithUrlStr:model.img width:280 height:280];
    [_movieFaceView sd_setImageWithURL:[NSURL URLWithString:urlStr]];

}

- (NSString *)dealWithUrlStr:(NSString *)str width:(CGFloat)imgWidth height:(CGFloat)imgHeight
{
    NSArray *componentArr = [str componentsSeparatedByString:@"/"];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:componentArr];
    
    [tempArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.0f.%.0f",imgWidth,imgHeight]];
    
    NSString *resulturl = [tempArr componentsJoinedByString:@"/"];
    return resulturl;

}

#pragma mark - 抽取方法
- (UIImageView *)createImageView
{
    UIImageView *imageview =[[UIImageView alloc]init];
    imageview.userInteractionEnabled = YES;
    imageview.layer.masksToBounds = YES;
    return imageview;
}

- (UILabel *)createLblWithTitle:(NSString *)title

{
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont boldSystemFontOfSize:19.0f];
    
    return label;
    
}




@end
