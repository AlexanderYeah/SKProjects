//
//  BoxOfficeTableViewCell.m
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "BoxOfficeTableViewCell.h"
#import "SingleBoxModel.h"
#import "WeekBoxModel.h"
#import "MonthBoxModel.h"
@implementation BoxOfficeTableViewCell

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

#pragma mark 创建UI
- (void)createUI
{
    
    // 1.0
    UIImageView *nameView = [[UIImageView alloc]init];
    nameView.image = [UIImage imageNamed:@"movieNm"];
    [self addSubview:nameView];
    [nameView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(15);
        make.left.equalTo(self.left).offset(15);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    
   // 1 影片名
    _nameLbl = [self createLblWithTitle:@"影片名:《谍影重重》" fontSize:16.0f textColor:[UIColor blackColor]];
    [self addSubview:_nameLbl];
    [_nameLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nameView.centerY).offset(0);
        make.left.equalTo(nameView.right).offset(15);
        make.width.equalTo(kScreenW - 60);
        make.height.equalTo(25);
    }];
    
    // 2.0
    UIImageView *rankView = [[UIImageView alloc]init];
    rankView.image = [UIImage imageNamed:@"movieRank"];
    [self addSubview:rankView];
    [rankView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLbl.bottom).offset(0);
        make.left.equalTo(nameView.left).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    

    
    // 2 排名
    _rankLbl = [self createLblWithTitle:@"本周排名:第1名" fontSize:16.0f textColor:[UIColor blackColor]];
    [self addSubview:_rankLbl];
    [_rankLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(rankView.centerY).offset(0);
        make.left.equalTo(_nameLbl.left).offset(0);
        make.width.equalTo(kScreenW - 60);
        make.height.equalTo(25);
    }];
    
    // 3.0
    UIImageView *weekView = [[UIImageView alloc]init];
    weekView.image = [UIImage imageNamed:@"weekBox"];
    [self addSubview:weekView];
    [weekView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rankLbl.bottom).offset(0);
        make.left.equalTo(nameView.left).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    

    
    // 3 周末票房
    UIColor *wkColor = kRGBColor(62, 101, 58);
    _weekBoxLbl = [self createLblWithTitle:@"周末票房:5000万" fontSize:16.0f textColor:wkColor];
    [self addSubview:_weekBoxLbl];
    [_weekBoxLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weekView.centerY).offset(0);
        make.left.equalTo(_nameLbl.left).offset(0);
        make.width.equalTo(kScreenW - 60);
        make.height.equalTo(25);
    }];
    // 4.0
    UIImageView *totalView = [[UIImageView alloc]init];
    totalView.image = [UIImage imageNamed:@"totalBox"];
    [self addSubview:totalView];
    [totalView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_weekBoxLbl.bottom).offset(0);
        make.left.equalTo(nameView.left).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    

    
    // 4 累计票房
    UIColor *totalColor = [UIColor orangeColor];
    _totalBoxLbl = [self createLblWithTitle:@"累计票房:5000万" fontSize:16.0f textColor:totalColor];
    [self addSubview:_totalBoxLbl];
    [_totalBoxLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalView.centerY).offset(0);
        make.left.equalTo(_nameLbl.left).offset(0);
        make.width.equalTo(kScreenW - 60);
        make.height.equalTo(25);
    }];
    // 5.0
    UIImageView *showView = [[UIImageView alloc]init];
    showView.image = [UIImage imageNamed:@"showTime"];
    [self addSubview:showView];
    [showView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalBoxLbl.bottom).offset(0);
        make.left.equalTo(nameView.left).offset(0);
        make.width.equalTo(20);
        make.height.equalTo(20);
    }];
    

    // 5 上映时间
    _showTimeLbl = [self createLblWithTitle:@"上映时间:1周" fontSize:16.0f textColor:[UIColor blackColor]];
    [self addSubview:_showTimeLbl];
    [_showTimeLbl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(showView.centerY).offset(0);
        make.left.equalTo(_nameLbl.left).offset(0);
        make.width.equalTo(kScreenW - 60);
        make.height.equalTo(25);
    }];
 
}


-(void)setModel:(SingleBoxModel *)model
{
    _model = model;
    _nameLbl.text = [NSString stringWithFormat:@"影片名:%@",model.MovieName];
    _rankLbl.text = [NSString stringWithFormat:@"本周排名:%@",model.Rank];
    _weekBoxLbl.text = [NSString stringWithFormat:@"今日票房:%@(万元)",model.BoxOffice];
    _totalBoxLbl.text = [NSString stringWithFormat:@"总共票房:%@(万元)",model.SumBoxOffice];
    _showTimeLbl.text = [NSString stringWithFormat:@"已经上映:%@天",model.MovieDay];
}


-(void)setWeekModel:(WeekBoxModel *)weekModel
{
    _weekModel = weekModel;
    _nameLbl.text = [NSString stringWithFormat:@"影片名:%@",weekModel.MovieName];
    _rankLbl.text = [NSString stringWithFormat:@"本周排名:%@",weekModel.MovieRank];
    _weekBoxLbl.text = [NSString stringWithFormat:@"周末票房:%@(万元)",weekModel.BoxOffice];
    _totalBoxLbl.text = [NSString stringWithFormat:@"总共票房:%@(万元)",weekModel.SumBoxOffice];
    _showTimeLbl.text = [NSString stringWithFormat:@"已经上映:%@天",weekModel.MovieDay];

}
- (void)setMonthModel:(MonthBoxModel *)monthModel
{
    _monthModel = monthModel;
    _nameLbl.text = [NSString stringWithFormat:@"影片名:%@",monthModel.MovieName];
    _rankLbl.text = [NSString stringWithFormat:@"本周排名:%@",monthModel.rank];
    _weekBoxLbl.text = [NSString stringWithFormat:@"总共票房:%@(万元)",monthModel.boxoffice];
    _totalBoxLbl.text = [NSString stringWithFormat:@"上映日期:%@",monthModel.releaseTime];
    _showTimeLbl.text = [NSString stringWithFormat:@"已经上映:%@天",monthModel.days];
    
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
