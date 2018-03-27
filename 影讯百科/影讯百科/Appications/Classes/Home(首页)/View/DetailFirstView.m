//
//  DetailFirstView.m
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "DetailFirstView.h"
#import "DetailModel.h"
@implementation DetailFirstView

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
    
    self.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.6];
   
    NSInteger index = arc4random()%7;
    NSArray *bgImageArr = @[@"homeBg1",@"homeBg2",@"homeBg3",@"homeBg4",@"homeBg5",@"homeBg6",@"homeBg7"];
    CGFloat bgViewHeight = kScreenH * 0.40;
    UIImageView *bgView = [[UIImageView alloc]init];
    bgView.userInteractionEnabled = YES;
    bgView.image = [UIImage imageNamed:bgImageArr[index]];
    [self addSubview:bgView];
    bgView.backgroundColor = kRandomColor;
    [bgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(0);
        make.left.equalTo(self.left).offset(0);
        make.height.equalTo(bgViewHeight);
        make.width.equalTo(kScreenW);
    }];

    
    _faceImgView = [[UIImageView alloc]init];
    _faceImgView.backgroundColor = [UIColor clearColor];
    _faceImgView.backgroundColor = [UIColor redColor];
    [bgView addSubview:_faceImgView];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(topPadding);
        make.left.equalTo(self.left).offset(leftPadding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 星星评分
    UIImageView * scoreBgImgView = [[UIImageView alloc]init];
    scoreBgImgView.image = SKImage(@"StarsBackground");
    scoreBgImgView.contentMode = UIViewContentModeLeft;
    scoreBgImgView.clipsToBounds = YES;
    [bgView addSubview:scoreBgImgView];
    [scoreBgImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(20);
        make.left.equalTo(_faceImgView.right).offset(25);
        make.width.equalTo(65);
        make.height.equalTo(23);
    }];
    
    _scoreImgView = [[UIImageView alloc]init];
    _scoreImgView.image = SKImage(@"StarsForeground");
    _scoreImgView.contentMode = UIViewContentModeLeft;
    _scoreImgView.clipsToBounds = YES;
    [scoreBgImgView addSubview:_scoreImgView];
    //    _scoreImgView.frame.size.width = 65 / 5 * 10;
    [_scoreImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(20);
        make.left.equalTo(_faceImgView.right).offset(25);
        make.width.equalTo(18);
        make.height.equalTo(23);
    }];
    
    // 3 评分
    _scoreLbl = [self createLblWithTitle:@"" fontSize:20.0f textColor:[UIColor orangeColor]];
    [bgView addSubview:_scoreLbl];
    [_scoreLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreBgImgView.top).offset(-10);
        make.left.equalTo(scoreBgImgView.right).offset(20);
        make.width.equalTo(50);
        make.height.equalTo(titleHeight);
    }];
    
    // 4 评论人数
    _commentCountLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor whiteColor]];
    [bgView addSubview:_commentCountLbl];
    [_commentCountLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scoreBgImgView.bottom).offset(0);
        make.left.equalTo(scoreBgImgView.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 5 类型
    _catLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor whiteColor]];
    [bgView addSubview:_catLbl];
    [_catLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentCountLbl.bottom).offset(0);
        make.left.equalTo(scoreBgImgView.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 6 片长
    _durationLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor whiteColor]];
    [bgView addSubview:_durationLbl];
    [_durationLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_catLbl.bottom).offset(0);
        make.left.equalTo(scoreBgImgView.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 7 上映时间
    _startTimeLbl = [self createLblWithTitle:@"" fontSize:16.0f textColor:[UIColor whiteColor]];
    [bgView addSubview:_startTimeLbl];
    [_startTimeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_durationLbl.bottom).offset(0);
        make.left.equalTo(scoreBgImgView.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 8 收藏按钮
    CGFloat btnLeftPadding = 20;
    CGFloat btnWidth = (kScreenW - 40 - btnLeftPadding * 2) / 2;
    CGFloat btnHeight = kScreenH * 0.14 * 0.38;
    
    UIButton *collectBtn = [self createBtnWithTitle:@"收藏"];
    [bgView addSubview:collectBtn];
    [collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [collectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-15);
        make.left.equalTo(self.left).offset(btnLeftPadding);
        make.width.equalTo(btnWidth);
        make.height.equalTo(btnHeight);
    }];
    
    // 9 分享按钮
    UIButton *shareBtn = [self createBtnWithTitle:@"分享"];
    [bgView addSubview:shareBtn];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bottom).offset(-15);
        make.right.equalTo(self.right).offset(-btnLeftPadding);
        make.width.equalTo(btnWidth);
        make.height.equalTo(btnHeight);
    }];
    
}

-(void)setFaceUrl:(NSURL *)faceUrl
{
    _faceUrl = faceUrl;
    [_faceImgView sd_setImageWithURL:faceUrl];
}

#pragma mark -  填充数据 
-(void)setModel:(DetailModel *)model
{
    _model = model;
    self.catLbl.text = model.cat;
    self.scoreLbl.text = model.sc;
    self.durationLbl.text = [NSString stringWithFormat:@"时长:%@分钟",model.dur];
    self.startTimeLbl.text = model.pubDesc;
    self.commentCountLbl.text =[NSString stringWithFormat:@"共%@评分",model.snum];
    CGFloat scoreWidth = 65 / 5 * [model.sc integerValue] / 2;
    [self.scoreImgView updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(scoreWidth);
    }];
}

#pragma mark - 收藏按钮的点击事件
- (void)collectBtnClick
{
    if ([self.delegate respondsToSelector:@selector(collectBtnClick)]) {
        [self.delegate collectBtnClick];
    }
    
}
- (void)shareBtnClick
{
    if ([self.delegate respondsToSelector:@selector(shareBtnClick)]) {
        [self.delegate shareBtnClick];
    }
}


- (UILabel *)createLblWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = title;
    lable.textColor = color;
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
    
}
- (UIButton *)createBtnWithTitle:(NSString *)title
{
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.backgroundColor = [UIColor clearColor];
    collectBtn.layer.borderWidth = 0.7;
    collectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [collectBtn setTitle:title forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    return collectBtn;
}

@end
