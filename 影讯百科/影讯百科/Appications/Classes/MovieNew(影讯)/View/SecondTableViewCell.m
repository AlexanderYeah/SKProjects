//
//  SecondTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SecondTableViewCell.h"
#import "SecondModel.h"
@implementation SecondTableViewCell

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

#pragma mark - createUI
- (void)createUI
{
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.177 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    
    _faceImgView = [[UIImageView alloc]init];
    _faceImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_faceImgView];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(padding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    CGFloat titleHeight = faceHeight / 5;
    
    _titleLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor blackColor]];
    [self addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(0);
        make.left.equalTo(_faceImgView.right).offset(15);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    // 3 评分
    _yearLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor redColor]];
    [self addSubview:_yearLbl];
    [_yearLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(10);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
    // 4 查看详情
    UILabel *detailLbl = [self createLblWithTitle:@"查看影评>>" fontSize:15.0f textColor:[UIColor grayColor]];
    [self addSubview:detailLbl];
    [detailLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
}

-(void)setModel:(SecondModel *)model
{
    _model = model;
    NSURL *urlStr = [NSURL URLWithString:model.cover];
    [_faceImgView sd_setImageWithURL:urlStr];
    _titleLbl.text = model.title;
    _yearLbl.text = [NSString stringWithFormat:@"评分:%@",model.rate];
    

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
