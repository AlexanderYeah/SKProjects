//
//  FavoriteTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "FavoriteTableViewCell.h"
#import "FavoriteModel.h"

@implementation FavoriteTableViewCell

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

#pragma mark -  创建UI界面
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
     _titleLbl = [self createLblWithTitle:@"" fontSize:17.0f textColor:[UIColor orangeColor]];
    [self addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(15);
        make.left.equalTo(_faceImgView.right).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(titleHeight);
    }];
    // 7 查看详情
    UILabel *detailLbl = [self createLblWithTitle:@"查看详情>>" fontSize:15.0f textColor:[UIColor blackColor]];
    detailLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:detailLbl];
    [detailLbl makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-5);
        make.right.equalTo(self.right).offset(-15);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
}

#pragma mark -  设置数据
-(void)setModel:(FavoriteModel *)model
{
    _model = model;
    
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.177 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    CGFloat titleHeight = faceHeight / 5;
    // 1 设置封面
    NSURL *imgUrl = [self dealWithUrlStr:model.faceStr width:280 height:280];
    [_faceImgView sd_setImageWithURL:imgUrl];

    // 2 设置标题
    // 计算标题的宽度
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(summaryWidth -60, titleHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} context:nil];
    
    [_titleLbl updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(rect.size.width + 20);
    }];
    _titleLbl.text = model.title;    
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
