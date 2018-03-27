//
//  ProfileTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/19.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ProfileTableViewCell.h"

@implementation ProfileTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

#pragma mark - 创建UI
- (void)createUI
{
    // 1 左边的图标
    
    _iconImgView = [[UIImageView alloc]init];
    [self addSubview:_iconImgView];
    [_iconImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(20);
        make.height.equalTo(35);
        make.width.equalTo(35);
    }];
    
   // 2 中间的标题
    _cellTitleLbl = [[UILabel alloc]init];
    [self addSubview:_cellTitleLbl];
    [_cellTitleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerX).offset(-10);
        make.centerY.equalTo(self.centerY).offset(0);
        make.height.equalTo(40);
        make.width.equalTo(kScreenW / 2);
    }];

}

- (void)setIconImg:(UIImage *)iconImg
{
    _iconImg = iconImg;
    _iconImgView.image = iconImg;
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _cellTitleLbl.text = cellTitle;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
