//
//  ActorDetailTableViewCell.m
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ActorDetailTableViewCell.h"
#import "ActorMovieModel.h"
@implementation ActorDetailTableViewCell

- (void)awakeFromNib {
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
    // 1 封面
    CGFloat faceHeight = kScreenH / 5 * 0.84;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat padding = 10;
    
    
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    _avatarImgView = [[UIImageView alloc]init];
    [self addSubview:_avatarImgView];
    [_avatarImgView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY).offset(0);
        make.left.equalTo(self.left).offset(padding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    CGFloat titleHeight = faceHeight / 4;
    
    _movieNameLbl = [self createLblWithTitle:@"1111" fontSize:18.0f textColor:[UIColor blackColor]];
    [self addSubview:_movieNameLbl];
    [_movieNameLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_avatarImgView.top).offset(-4);
        make.left.equalTo(_avatarImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    // 3 评分
    _dutyLbl = [self createLblWithTitle:@"11" fontSize:16.0f textColor:[UIColor orangeColor]];
    [self addSubview:_dutyLbl];
    [_dutyLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_movieNameLbl.bottom).offset(5);
        make.left.equalTo(_avatarImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 4 摘要
    _pubTimeLbl = [self createLblWithTitle:@"11" fontSize:16.0f textColor:[[UIColor blackColor]colorWithAlphaComponent:0.7]];
    [self addSubview:_pubTimeLbl];
    [_pubTimeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dutyLbl.bottom).offset(10);
        make.left.equalTo(_avatarImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    
}
#pragma mark - 设置数据
-(void)setModel:(ActorMovieModel *)model
{
    _model = model;
    
    NSString *str = model.avatar;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://p1.meituan.net/280.280/movie/%@",[str componentsSeparatedByString:@"/"].lastObject]];
    [_avatarImgView sd_setImageWithURL:url];

    _movieNameLbl.text = model.name;
    _dutyLbl.text = model.duty;
    _pubTimeLbl.text = [NSString stringWithFormat:@"%@上映",model.rt];
    
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
