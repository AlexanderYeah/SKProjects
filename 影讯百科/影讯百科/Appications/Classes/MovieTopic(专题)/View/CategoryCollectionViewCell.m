//
//  CategoryCollectionViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/8.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CategoryCollectionViewCell.h"
#import "CatDetailModel.h"
@implementation CategoryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)createUI
{
    
    // 1 封面
    CGFloat itemPadding = 8;
    CGFloat faceWidth = (kScreenW - itemPadding * 4 ) / 3;
    CGFloat faceHeight = faceWidth * 1.427;

    // 摘要宽度
    _faceImgView = [[UIImageView alloc]init];
    _faceImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_faceImgView];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    _titleLbl = [self createLblWithTitle:@" " fontSize:14.0f textColor:[UIColor blackColor]];
    [self addSubview:_titleLbl];
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(faceWidth);
        make.height.equalTo(30);
    }];
    // 3 评分
    _durLbl = [self createLblWithTitle:@"" fontSize:10.0f textColor:[UIColor blackColor]];
    _durLbl.textAlignment = NSTextAlignmentRight;
    _durLbl.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    [_faceImgView addSubview:_durLbl];
    [_durLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_faceImgView.bottom).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.width.equalTo(faceWidth);
        make.height.equalTo(15);
    }];
    

    
}

- (void)setModel:(CatDetailModel *)model
{
    _model = model;
    // 1 设置封面
    NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
    [_faceImgView sd_setImageWithURL:imgUrl];
    
    // 2 设置
    _titleLbl.text = model.nm;
    
    // 3 时间
    _durLbl.text = [NSString stringWithFormat:@"%@分钟",model.dur];

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

#pragma mark - 方法的抽取
- (UILabel *)createLblWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = title;
    lable.textColor = color;
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
    
}


@end
