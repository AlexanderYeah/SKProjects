//
//  SearchTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SearchTableViewCell.h"
#import "SearchRecodModel.h"
@implementation SearchTableViewCell

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
    
    CGFloat faceHeight = kScreenH * 0.1;
    
    CGFloat titleHeight = faceHeight / 3;
    
    CGFloat padding = 15;
    
    _titleLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor orangeColor]];
    
    [self addSubview:_titleLbl];
    
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.top).offset(10);
         make.left.equalTo(self.left).offset(padding);
         make.width.equalTo(kScreenW);
         make.height.equalTo(titleHeight);
     }];
    // 3 评分
    _timeLbl = [self createLblWithTitle:@"" fontSize:15.0f textColor:[UIColor grayColor]];
    _timeLbl.numberOfLines = 0;
    [self addSubview:_timeLbl];
    [_timeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(kScreenW - padding * 2);
        make.height.equalTo(titleHeight );
    }];
    // 5 评论数
    UILabel * commentCountLbl = [self createLblWithTitle:@"搜索结果>>" fontSize:14.0f textColor:[UIColor blackColor]];
    commentCountLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:commentCountLbl];
    [commentCountLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-5);
        make.right.equalTo(self.right).offset(-padding);
        make.width.equalTo(kScreenW / 2 );
        make.height.equalTo(titleHeight);
    }];

}



-(void)setModel:(SearchRecodModel *)model

{
    _model = model;
    _titleLbl.text = [NSString stringWithFormat:@"搜索关键词:%@",model.keyWord];
    _timeLbl.text = [NSString stringWithFormat:@"搜索时间:%@",model.time];
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
