//
//  ActorDetailView.m
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ActorDetailView.h"
#import "ActorModel.h"
@implementation ActorDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark - 创建UI
- (void)createUI
{
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.26;
    CGFloat faceWidth = faceHeight / 1.427;
    CGFloat leftPadding = 18;
    CGFloat topPadding = kScreenH * 0.14 * 0.22;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - leftPadding;
    // 文字高度
    CGFloat titleHeight = (faceHeight - 23) / 4 - 5;
    
    self.backgroundColor = [UIColor whiteColor];
    _faceImgView = [[UIImageView alloc]init];
    _faceImgView.backgroundColor = [UIColor redColor];
    [self addSubview:_faceImgView];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(topPadding);
        make.left.equalTo(self.left).offset(leftPadding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 3 评分
    _chineseNameLbl = [self createLblWithTitle:@"1111" fontSize:13.0f textColor:[UIColor orangeColor]];
    [self addSubview:_chineseNameLbl];
    [_chineseNameLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(0);
        make.left.equalTo(_faceImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 4 评论人数
    _englishNameLbl = [self createLblWithTitle:@"sadasda" fontSize:13.0f textColor:[UIColor whiteColor]];
    [self addSubview:_englishNameLbl];
    [_englishNameLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chineseNameLbl.bottom).offset(0);
        make.left.equalTo(_faceImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 5 类型
    _sexLbl = [self createLblWithTitle:@"男" fontSize:13.0f textColor:[UIColor whiteColor]];
    [self addSubview:_sexLbl];
    [_sexLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_englishNameLbl.bottom).offset(0);
        make.left.equalTo(_faceImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 6 生日
    _birthdayLbl = [self createLblWithTitle:@"111" fontSize:13.0f textColor:[UIColor whiteColor]];
    [self addSubview:_birthdayLbl];
    [_birthdayLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sexLbl.bottom).offset(0);
        make.left.equalTo(_faceImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 7 出生地
    _bornPlaceLbl = [self createLblWithTitle:@"2222" fontSize:13.0f textColor:[UIColor whiteColor]];
    [self addSubview:_bornPlaceLbl];
    [_bornPlaceLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_birthdayLbl.bottom).offset(0);
        make.left.equalTo(_faceImgView.right).offset(10);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    

}

#pragma mark - 设置数据 
- (void)setModel:(ActorModel *)model
{
    _model = model;
    NSString *str = model.avatar;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://p1.meituan.net/280.280/movie/%@",[str componentsSeparatedByString:@"/"].lastObject]];
    [_faceImgView sd_setImageWithURL:url];
    _chineseNameLbl.text = [NSString stringWithFormat:@"中文名:%@",model.cnm];
    _englishNameLbl.text = [NSString stringWithFormat:@"英文名:%@",model.enm];
    _sexLbl.text = [NSString stringWithFormat:@"性别:%@",model.sexy];
    _birthdayLbl.text = [NSString stringWithFormat:@"生日:%@",model.birthday];;
    _bornPlaceLbl.text =[NSString stringWithFormat:@"出生地:%@",model.birthplace];
}

- (UILabel *)createLblWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = title;
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
    
}



@end
