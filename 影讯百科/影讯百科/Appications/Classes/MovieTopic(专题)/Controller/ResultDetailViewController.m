//
//  ResultDetailViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/18.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ResultDetailViewController.h"
#import "MoviePlayViewController.h"
#import "ShareView.h"
#import "SKShareManager.h"
@interface ResultDetailViewController ()

/** 封面 */
@property (nonatomic,strong)UIImageView *faceImgView;
/** 标题 */
@property (nonatomic,strong)UILabel *titleLbl;
/** 地区 */
@property (nonatomic,strong)UILabel *areaLbl;
/** 主演 */
@property (nonatomic,strong)UILabel *castsLbl;

/**  年份 */
@property (nonatomic,strong)UILabel *yearLbl;

/** 数据源*/
@property (nonatomic,strong)NSDictionary *videoDataDic;

/** 分享界面 */
@property (nonatomic,strong)ShareView *shareView;

/**  */
@property (nonatomic,strong)UIButton *shareCancleBtn;
@property (nonatomic,strong)UIButton *shareBtn;


@end

@implementation ResultDetailViewController

-(instancetype)initWithGid:(NSString *)Gid
{
    if (self = [super init]) {
        _itemGid = Gid;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _videoDataDic = [NSDictionary dictionary];
    self.view.backgroundColor = kRGBColor(230, 230, 230);
    [self requestDataFromNet];
}

#pragma mark - createUI
- (void)createUI
{
    // 1 封面
    CGFloat faceHeight = kScreenH * 0.24 * 0.84;
    CGFloat faceWidth = faceHeight / 1.321;
    CGFloat padding = 10;
    // 摘要宽度
    CGFloat summaryWidth = kScreenW - faceWidth - padding;
    
    // 背景
    CGFloat bgHeight = kScreenH * 0.453;
    NSArray *bgArray = @[@"homeBg1",@"homeBg2",@"homeBg3",@"homeBg4"];
    NSInteger index = arc4random()%4;
    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, bgHeight)];
    bgImgView.userInteractionEnabled = YES;
    bgImgView.image = [UIImage imageNamed:bgArray[index]];
    [self.view addSubview:bgImgView];
    
    // 标题
    UILabel *titleLbl = [self createLblWithTitle:@"影片详情"];
    titleLbl.frame = CGRectMake(kScreenW/2 - kScreenW/4, 28, kScreenW/2, 30);
    titleLbl.font = [UIFont systemFontOfSize:20.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    // 返回按钮
    UIButton *cancleBtn = [self createBtnWithTitle:@""];
    cancleBtn.frame = CGRectMake(15, 30, 14, 26);
    [cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [self.view addSubview:cancleBtn];
    
    NSString *imageStr = _videoDataDic[@"imgUrl"];
    NSURL *imgUrl = [NSURL URLWithString:imageStr];
    _faceImgView = [[UIImageView alloc]init];
    _faceImgView.backgroundColor = [UIColor redColor];
    [bgImgView addSubview:_faceImgView];
    _faceImgView.layer.cornerRadius = 5;
    _faceImgView.layer.masksToBounds = YES;
    [_faceImgView sd_setImageWithURL:imgUrl];
    [_faceImgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(84);
        make.left.equalTo(self.view.left).offset(padding);
        make.width.equalTo(faceWidth);
        make.height.equalTo(faceHeight);
    }];
    
    // 2 标题
    // 标题的高度
    NSString *infoTitle = _videoDataDic[@"fullName"];
    CGFloat titleHeight = kScreenH * 0.22 / 5;
    _titleLbl = [self createLblWithTitle:infoTitle fontSize:18.0f textColor:[UIColor orangeColor]];
    [bgImgView  addSubview:_titleLbl];
    [_titleLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.top).offset(0);
        make.left.equalTo(_faceImgView.right).offset(15);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight);
    }];
    
    // 3 评分
    NSString *catInfo = [NSString stringWithFormat:@"类型:%@",_videoDataDic[@"genres"]];
    _areaLbl = [self createLblWithTitle:catInfo fontSize:14.0f textColor:[UIColor whiteColor]];
    [bgImgView  addSubview:_areaLbl];
    [_areaLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLbl.bottom).offset(5);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(_titleLbl.height);
    }];
    
    // 3 评分
    NSString *dirInfo = [NSString stringWithFormat:@"导演:%@",_videoDataDic[@"directors"]];
    _castsLbl = [self createLblWithTitle:dirInfo fontSize:14.0f textColor:[UIColor whiteColor]];
    [bgImgView  addSubview:_castsLbl];
    [_castsLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_areaLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight * 1);
    }];
    
    // 4 年代
    NSString *actorInfo = [NSString stringWithFormat:@"演员:%@",_videoDataDic[@"actors"]];
    _yearLbl = [self createLblWithTitle:actorInfo fontSize:14.0f textColor:[UIColor whiteColor]];
    [bgImgView  addSubview:_yearLbl];
    [_yearLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_castsLbl.bottom).offset(0);
        make.left.equalTo(_titleLbl.left).offset(0);
        make.width.equalTo(summaryWidth);
        make.height.equalTo(titleHeight * 1);
    }];
    
    // 5 收藏按钮
    CGFloat btnLeftPadding = 20;
    CGFloat btnWidth = (kScreenW - 40 - btnLeftPadding * 2) / 2;
    CGFloat btnHeight = kScreenH * 0.14 * 0.38;
    
    UIButton *collectBtn = [self createBtnWithTitle:@"收藏"];
    collectBtn.layer.borderWidth = 0.8;
    collectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [bgImgView addSubview:collectBtn];
    [collectBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_faceImgView.bottom).offset(15);
        make.left.equalTo(self.view.left).offset(btnLeftPadding);
        make.width.equalTo(btnWidth);
        make.height.equalTo(btnHeight);
    }];
    
    // 6 分享按钮
    UIButton *shareBtn = [self createBtnWithTitle:@"分享"];
    _shareBtn = shareBtn;
    shareBtn.layer.borderWidth = 0.8;
    shareBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bgImgView addSubview:shareBtn];
    [shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(collectBtn.top).offset(0);
        make.right.equalTo(self.view.right).offset(-btnLeftPadding);
        make.width.equalTo(btnWidth);
        make.height.equalTo(btnHeight);
    }];

/*----------------------------Section2---------------------------------*/
    CGFloat textViewHeight = kScreenH - kScreenH * 0.453 - 50 - 10;
    UITextView *infoTextView = [[UITextView alloc]init];
    NSString *movieInfo = [NSString stringWithFormat:@"简介:%@",_videoDataDic[@"desc"]];
    infoTextView.text = movieInfo;
    infoTextView.editable = NO;
    infoTextView.font = [UIFont systemFontOfSize:15.0f];
    infoTextView.textColor = kRGBColor(80, 80, 80);
    infoTextView.layer.cornerRadius = 5;
    infoTextView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:infoTextView];
    [infoTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgImgView.bottom).offset(10);
        make.left.equalTo(self.view.left).offset(10);
        make.height.equalTo(textViewHeight);
        make.width.equalTo(kScreenW - 20);
    }];
    
/*-----------------------Section3 ---------------------------------*/
    // 底部的播放按钮
    UIButton *playBtn = [self createBtnWithTitle:@"播放"];
    playBtn.backgroundColor = kMainColor;
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playBtn];
    playBtn.layer.cornerRadius = 5;
    [playBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom).offset(-5);
        make.centerX.equalTo(self.view.centerX).offset(0);
        make.height.equalTo(40);
        make.width.equalTo(kScreenW / 2);
    }];

}

#pragma mark - 请求演员详情列表数据
- (void)requestDataFromNet
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://videoapi.easou.com/n/api/detail?os=iphone&version=28&gid=%@&dataModel=1",self.itemGid];
 
    [SVProgressHUD showInfoWithStatus:@"正在加载数据..."];
    SKLog(@"%@",urlStr);
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataArr = responseObject[@"detail"];
        _videoDataDic = dataArr[@"video"];
        [SVProgressHUD dismiss];
        [self createUI];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    
}


#pragma mark - 点击事件 
- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playBtnClick
{
    // 取出视频的播放地址
    NSArray *sourceArray = _videoDataDic[@"source"];
    NSDictionary *urlDic = [sourceArray lastObject];
    NSURL *url = [NSURL URLWithString:urlDic[@"url"]];
    SKLog(@"%@",url);
    NSString *videoName = _videoDataDic[@"fullName"];
    MoviePlayViewController *playVC = [[MoviePlayViewController alloc]initWithVideoUrl:url WithVideoName:videoName];
    playVC.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:playVC animated:YES completion:nil];
}

#pragma mark - 分享按钮的点击事件 
- (void)shareBtnClick
{
    SKLog(@"分享");
     _shareBtn.enabled = NO;
    _shareView = [[ShareView alloc]initWithFrame:CGRectMake(-kScreenW, kScreenH - 180 , kScreenW, 0)];
    _shareView.userInteractionEnabled = YES;
    _shareView.backgroundColor = [UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1];
    // 取出自定义view上面的btn
    for (int i = 0; i < 4; i ++) {
        UIButton *btn = [_shareView viewWithTag:660 + i];
        [btn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 取出分享按钮取消btn
    UIButton *cancleBtn = [_shareView viewWithTag:666];
    _shareCancleBtn = cancleBtn;
    
    [cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_shareView];
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame = CGRectMake(0, kScreenH - 180 , kScreenW, 180);
    }];

}

#pragma mark  - 自定制分享view上面的按钮的点击事件
- (void)shareBtnClick:(UIButton *)btn
{
    SKShareManager *manager = [SKShareManager shareManager];
    // 取出要分享的链接
    // 取出视频的播放地址
    NSArray *sourceArray = _videoDataDic[@"source"];
    NSDictionary *urlDic = [sourceArray lastObject];
    NSString *urlStr = urlDic[@"url"];
    NSString *videoName = _videoDataDic[@"fullName"];
    switch (btn.tag) {
        case 660:
            [manager timelineShareWithViewController:self withShareText:videoName withShareUrl:urlStr];
            break;
        case 661:
            [manager wechatShareWithViewController:self withShareText:videoName withShareUrl:urlStr];
            break;
        case 662:{
            [manager messageShareWithViewController:self withShareText:videoName withShareUrl:urlStr];
            
        }
            break;
        case 663:{
            [manager emailShareWithViewController:self withShareText:videoName withShareUrl:urlStr];
        }
            break;
            
        default:
            break;
    }
    
}

#pragma mark -  分享按钮取消的点击事件
- (void)cancleBtnClick
{
    _shareBtn.enabled = YES;
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame = CGRectMake(0, kScreenH  , kScreenW, 180);
    }];
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

- (UILabel *)createLblWithTitle:(NSString *)title

{
    
    UILabel *label = [[UILabel alloc]init];
    
    label.text = title;
    
    label.textColor = [UIColor blackColor];
    
    label.font = [UIFont systemFontOfSize:14.0f];
    
    return label;
    
}
- (UIButton *)createBtnWithTitle:(NSString *)title

{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:19.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
