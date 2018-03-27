//
//  ResultTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/14.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ResultTableViewCell.h"
#import "ResultModel.h"
@implementation ResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

#pragma mark -createUI
- (void)createUI
{
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.24 * 0.84;
    CGFloat faceWidth = faceHeight / 1.321;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    
    _faceImgView = [[UIImageView alloc]init];
    [self addSubview:_faceImgView];
    _faceImgView.layer.cornerRadius = 5;
    _faceImgView.layer.masksToBounds = YES;
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(padding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    CGFloat titleHeight = kScreenH * 0.22 / 5;
    _titleLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor orangeColor]];
    [self addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(0);
        make.left.equalTo(_faceImgView.right).offset(15);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 3 评分
    _areaLbl = [self createLblWithTitle:@"" fontSize:14.0f textColor:[UIColor grayColor]];
    [self addSubview:_areaLbl];
    [_areaLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
    // 3 评分
    _castsLbl = [self createLblWithTitle:@"" fontSize:14.0f textColor:[UIColor grayColor]];
    _castsLbl.numberOfLines = 0;
    [self addSubview:_castsLbl];
    [_castsLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_areaLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight * 1);
    }];
    
    // 4 年代
    _yearLbl = [self createLblWithTitle:@"" fontSize:14.0f textColor:[UIColor grayColor]];
    [self addSubview:_yearLbl];
    [_yearLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_castsLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight * 1);
    }];
    
}

-(void)setModel:(ResultModel *)model
{
    _model = model;
    // 1 封面
    [_faceImgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl]];
    // 2 标题
    _titleLbl.text = [NSString stringWithFormat:@"%@",model.fullName];
    // 3 地区
    _areaLbl.text = [NSString stringWithFormat:@"地区:%@",model.area];
    // 4 演员
    _castsLbl.text = [NSString stringWithFormat:@"演员:%@",model.actors];
    // 5 年份
    _yearLbl.text = [NSString stringWithFormat:@"年份:%@",model.year];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
