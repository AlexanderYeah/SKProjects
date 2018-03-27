//
//  WillShowTableViewCell.m
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "WillShowTableViewCell.h"
#import "WillShowModel.h"
@implementation WillShowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}


#pragma mark - 创建UI
- (void)createUI
{
    // 1 背景
    UIView *bgView = [[UIView alloc]init];
    [self addSubview:bgView];
    bgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.2];
    CGFloat bgVHeight = kScreenH * 0.21;
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(12);
        make.left.equalTo(self.left).offset(12);
        make.width.equalTo(kScreenW - 24);
        make.height.equalTo(bgVHeight);
    }];

    // 1 封面
    CGFloat faceHeight = kScreenH * 0.19 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    
    _faceImgView = [[UIImageView alloc]init];
     
    [bgView addSubview:_faceImgView];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.centerY).offset(0);
        make.left.equalTo(bgView.left).offset(padding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    CGFloat titleHeight = faceHeight / 5;
    
    _titleLbl = [self createLblWithTitle:@"qweqw" fontSize:16.0f textColor:[UIColor blackColor]];
    [bgView addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(-4);
        make.left.equalTo(_faceImgView.right).offset(5);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 4 摘要
    _summaryLbl = [self createLblWithTitle:@"qweq" fontSize:16.0f textColor:[UIColor orangeColor]];
    [bgView addSubview:_summaryLbl];
    [_summaryLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(2);
        make.left.equalTo(_titleLbl.left).offset(5);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    // 5 主演
    _startTimeLbl = [self createLblWithTitle:@"eqwe" fontSize:15.0f textColor:[UIColor blackColor]];
    [bgView addSubview:_startTimeLbl];
    [_startTimeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLbl.bottom).offset(2);
        make.left.equalTo(_titleLbl.left).offset(5);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
    
    // 6 主演
    _actorLbl = [self createLblWithTitle:@"qweq" fontSize:14.0f textColor:[[UIColor blackColor]colorWithAlphaComponent:0.8]];
    [bgView addSubview:_actorLbl];
    [_actorLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startTimeLbl.bottom).offset(2);
        make.left.equalTo(_titleLbl.left).offset(5);
        make.width.equalTo(summaryWidth - 10);
        make.height.equalTo(_titleLbl.height);
    }];
    
    
    // 7 查看详情
    UILabel *detailLbl = [self createLblWithTitle:@"查看详情>>" fontSize:15.0f textColor:[UIColor blackColor]];
    [bgView addSubview:detailLbl];
    [detailLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_actorLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(5);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    

}

-(void)setModel:(WillShowModel *)model
{
    _model = model;
    
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.19 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    CGFloat titleHeight = faceHeight / 5;
    // 1 设置封面
    NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
    [_faceImgView sd_setImageWithURL:imgUrl];
    
    // 2 设置标题
    // 计算标题的宽度
    CGRect rect = [model.nm boundingRectWithSize:CGSizeMake(summaryWidth -60, titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil];
    
    [_titleLbl updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(rect.size.width + 20);
    }];
    _titleLbl.text = model.nm;
    
    // 3 摘要
    _summaryLbl.text = [NSString stringWithFormat:@"‘‘%@’’",model.scm];
    
    // 4 上映日期
    _startTimeLbl.text = [NSString stringWithFormat:@"%@/%@分钟",model.pubDesc,model.dur];
    
    // 5 主要演员
    _actorLbl.text = model.star;


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
