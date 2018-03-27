//
//  CategoryTableViewCell.m
//  影讯百科
//
//  Created by Alexander on 16/9/7.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CategoryTableViewCell.h"

@implementation CategoryTableViewCell

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

#pragma mark -createUI
 - (void)createUI
{
    // 1 头像
    _faceImageView = [[UIImageView alloc]init];
    _faceImageView.layer.cornerRadius = 25;
    _faceImageView.layer.masksToBounds = YES;
    [self addSubview:_faceImageView];
    [_faceImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(50);
    }];
    
    // 2 标题
    
    _titleLbl = [[UILabel alloc]init];
    _titleLbl.font = [UIFont systemFontOfSize:16.0f];
    _titleLbl.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.centerX.equalTo(self.centerX).offset(-10);
        make.width.equalTo(kScreenW / 2);
        make.height.equalTo(30);
    }];
    
    
    // 1 头像
    UIImageView *navImageView = [[UIImageView alloc]init];
    navImageView.image = [UIImage imageNamed:@"Arrow_right"];
    [self addSubview:navImageView];
    [navImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.right.equalTo(self.right).offset(-20);
        make.width.equalTo(8.5);
        make.height.equalTo(15);
    }];
}


- (void)setFaceImg:(UIImage *)faceImg
{
    _faceImg = faceImg;
    _faceImageView.image = faceImg;
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _titleLbl.text = cellTitle;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
