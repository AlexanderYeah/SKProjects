//
//  MovieCommentTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "MovieCommentTableViewCell.h"
#import "MovieCommentModel.h"
@implementation MovieCommentTableViewCell

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
    // 2 标题
    // 标题的高度
    CGFloat faceHeight = kScreenH * 0.17;
    CGFloat titleHeight = faceHeight / 5;
    CGFloat padding = 15;
    _titleLbl = [self createLblWithTitle:@"我的战争我的战争我的战争" fontSize:16.0f textColor:[UIColor orangeColor]];
    [self addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(2);
        make.left.equalTo(self.left).offset(padding);
        make.width.equalTo(kScreenW);
        make.height.equalTo(titleHeight);
    }];
    
    // 3 评分
    _summaryLbl = [self createLblWithTitle:@"" fontSize:12.0f textColor:[UIColor grayColor]];
    _summaryLbl.numberOfLines = 0;
    [self addSubview:_summaryLbl];
    [_summaryLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(kScreenW - padding * 2);
        make.height.equalTo(titleHeight * 3);
    }];
    // 4 作者
    _authorLbl = [self createLblWithTitle:@"" fontSize:12.0f textColor:[UIColor grayColor]];
    [self addSubview:_authorLbl];
    [_authorLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(kScreenW / 2);
        make.height.equalTo(titleHeight);
    }];
    // 5 评论数
    _commentCountLbl = [self createLblWithTitle:@"" fontSize:12.0f textColor:[UIColor blackColor]];
    [self addSubview:_commentCountLbl];
    [_commentCountLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLbl.bottom).offset(5);
        make.right.equalTo(self.right).offset(-padding);
        make.width.equalTo(kScreenW / 2);
        make.height.equalTo(titleHeight);
    }];
    
    
}

-(void)setModel:(MovieCommentModel *)model
{
    _model = model;
    // 标题
    _titleLbl.text = model.title;
    // 概要
    _summaryLbl.text = model.summary;
    // 评论数
    _commentCountLbl.text = model.movieName;
    // 作者
    _authorLbl.text = [NSString stringWithFormat:@"作者:%@",model.author];
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
