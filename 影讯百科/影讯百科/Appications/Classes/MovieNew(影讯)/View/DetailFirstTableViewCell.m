//
//  DetailFirstTableViewCell.m
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "DetailFirstTableViewCell.h"

@implementation DetailFirstTableViewCell

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
    CGFloat faceHeight = kScreenH * 0.2 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    
    _faceImgView = [[UIImageView alloc]init];
    
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
    _diretorLbl = [self createLblWithTitle:@"Alexander Gary" fontSize:14.0f textColor:[UIColor grayColor]];
    [self addSubview:_diretorLbl];
    [_diretorLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];

    // 3 评分
    _castsLbl = [self createLblWithTitle:@"" fontSize:14.0f textColor:[UIColor grayColor]];
    [self addSubview:_castsLbl];
    [_castsLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_diretorLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight * 2);
    }];

}


- (void)setCellDic:(NSDictionary *)cellDic
{
    _cellDic = cellDic;
    // 封面
    NSDictionary *imagesArr = cellDic[@"images"];
    NSString *imgStr = imagesArr[@"medium"];
    [_faceImgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    // 导演
    NSArray *directorArray = [cellDic valueForKey:@"directors"];
    if (directorArray.count > 1) {
        NSMutableArray *directArr = [NSMutableArray array];
        for (NSDictionary *dic in directorArray) {
            NSString *name = dic[@"name"];
            [directArr addObject:name];
        }
        _diretorLbl.text = [NSString stringWithFormat:@"导演:%@",[directArr componentsJoinedByString:@"/"]];
    }else{
        NSDictionary *dic = [directorArray objectAtIndex:0];
        _diretorLbl.text = [NSString stringWithFormat:@"导演:%@",dic[@"name"]];
    }
    
    // 主演
    NSArray *castArray = [cellDic valueForKey:@"casts"];
    NSMutableArray *starArray = [NSMutableArray array];
    for (NSDictionary *dic in castArray) {
        NSString *name = dic[@"name"];
        [starArray addObject:name];
    }
    _castsLbl.text = [NSString stringWithFormat:@"主演:%@",[starArray componentsJoinedByString:@"/"]];
    
    // 标题
    _titleLbl.text = cellDic[@"title"];
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
