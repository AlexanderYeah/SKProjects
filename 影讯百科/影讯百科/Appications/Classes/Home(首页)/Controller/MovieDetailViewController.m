//
//  MovieDetailViewController.m
//  影讯百科
//
//  Created by Alexander on 16/8/29.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "DetailFirstView.h"
#import "DetailModel.h"
#import "DetailMovPhotoView.h"
#import "ActorDetailViewController.h"
#import "SKDataBaseManger.h"
#import "ShareView.h"
#import "SKShareManager.h"
@interface MovieDetailViewController ()<UITableViewDataSource,UITableViewDelegate,DetailFirstViewDelegate>

/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** tableView */
@property (nonatomic,strong)NSDictionary *dataDictionary;
/** 模型 */
@property (nonatomic,strong)DetailModel *model;
/** 影片介绍 */
@property (nonatomic,strong)UILabel *movieDetailLabel;
/** 滚动视图*/
@property (nonatomic,strong)UIScrollView *photoScrollView;
/** 演员数据 */
@property (nonatomic,strong)NSDictionary *actorDic;
/** 演员滚动视图*/
@property (nonatomic,strong)UIScrollView *actorScrollView;
/** 视频连接 */
@property (nonatomic,strong)NSString *videourl;



/** 分享界面 */
@property (nonatomic,strong)ShareView *shareView;

/**  */
@property (nonatomic,strong)UIButton *shareCancleBtn;
@property (nonatomic,strong)UIButton *shareBtn;
@property (nonatomic,assign)BOOL shareBtnSelected;

@end

@implementation MovieDetailViewController

- (instancetype)initWithFaceUrl:(NSURL *)url detailUrl:(NSString *)detailUrl movieTitle:(NSString *)title movieID:(NSString *)ID
{
    if (self = [super init]) {
        _faceUrl = url;
        _detailUrl = detailUrl;
        _movieTitle = title;
        _ID = ID;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.movieTitle;
    self.dataDictionary = [NSDictionary dictionary];
    self.actorDic = [NSDictionary dictionary];
    _shareBtnSelected = NO;
    [self requestDataFromNet];
    
    [self createLeftNavButton];
    
}

#pragma mark - 重写leftBarButtonItem
- (void)createLeftNavButton
{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 20, 14, 26);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


#pragma mark - 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.view addSubview:_tableView];
    
}

#pragma mark - 创建label
- (UILabel *)createLblWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = title;
    lable.textColor = color;
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
    
}
#pragma mark -  创建影片描述
- (void)createMovieInfoLblWith:(UITableViewCell *)cell
{
   // 剧情描述
    UILabel *infoLbl = [self createLblWithTitle:@"剧情描述:" fontSize:16.0f textColor:[UIColor blackColor]];
    infoLbl.frame = CGRectMake(10, 5, kScreenW, 20);
    [cell.contentView addSubview:infoLbl];
    CGRect rect = [self.model.dra boundingRectWithSize:CGSizeMake(kScreenW - 16, kScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil];
    _movieDetailLabel = [[UILabel alloc]init];
    _movieDetailLabel.numberOfLines = 0;
    _movieDetailLabel.text = self.model.dra;
    _movieDetailLabel.font = [UIFont systemFontOfSize:16.0f];
    _movieDetailLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _movieDetailLabel.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.8];
    [cell.contentView addSubview:_movieDetailLabel];
    [_movieDetailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.top).offset(20);
        make.left.equalTo(cell.left).offset(8);
        make.width.equalTo(kScreenW - 16);
        make.height.equalTo(rect.size.height * 2);
    }];
    

}
#pragma mark -  创建演员详情
- (void)createActorDetailScrollWith:(UITableViewCell *)cell
{
    UILabel *label = [self createLblWithTitle:@"导演演员:" fontSize:16.0f textColor:[UIColor blackColor]];
    label.frame = CGRectMake(15, 5, kScreenW, 20);
    [cell.contentView addSubview:label];
    // 1 创建滚动视图
    CGFloat padding = 10;
    CGFloat photoWidth = (kScreenW - 5 * padding) / 4;
    CGFloat photoHeight = photoWidth * 1.476;
    
    // 取数据
    NSArray * actorArr = self.actorDic[@"actors"];
    _actorScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kScreenW, photoHeight + 35)];
    _actorScrollView.delegate = self;
    for (int i = 0; i <actorArr.count + 1; i ++) {
        // 处理数据
        NSDictionary *dataDic = [NSDictionary dictionary];
        
        if (i == 0) {
            dataDic = [self.actorDic[@"directors"] lastObject];;
        }else{
            dataDic = actorArr[i - 1];
        }
        // 头像Url
        NSString *str = dataDic[@"avatar"];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://p1.meituan.net/280.280/movie/%@",[str componentsSeparatedByString:@"/"].lastObject]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + photoWidth * i + padding * i, 0, photoWidth, photoHeight)];
        imageView.layer.cornerRadius = 5;
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:url];
        // 加一个Btn 添加点击事件
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, photoWidth, photoHeight)];
        btn.tag = 200 + i;
        [btn addTarget:self action:@selector(imageViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundColor:[UIColor clearColor]];
        [imageView addSubview:btn];
        
        [_actorScrollView addSubview:imageView];
        
        // 演员名称
        UILabel *nameLabel = [self createLblWithTitle:dataDic[@"cnm"] fontSize:12.0f textColor:[UIColor blackColor]];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 0;
        [_actorScrollView addSubview:nameLabel];
        [nameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.bottom).offset(0);
            make.left.equalTo(imageView.left).offset(5);
            make.right.equalTo(imageView.right);
            make.height.equalTo(32);
        }];
        
        
    }
    _actorScrollView.contentSize = CGSizeMake((actorArr.count +1 ) * (padding + photoWidth), 0);
    [cell.contentView addSubview:_actorScrollView];
    

}
#pragma mark -  创建影片剧照
- (void)createMoviePhotoScrollWith:(UITableViewCell *)cell
{
    UILabel *label = [self createLblWithTitle:@"电影剧照:" fontSize:16.0f textColor:[UIColor blackColor]];
    label.frame = CGRectMake(15, 5, kScreenW, 20);
    [cell.contentView addSubview:label];
    // 1 创建滚动视图
    CGFloat photoWidth = 100;
    CGFloat photoHeight = 100;
    CGFloat padding = 10;
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kScreenW, 140)];
    _photoScrollView.delegate = self;
    for (int i = 0; i <self.model.photos.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + photoWidth * i + padding * i, 0, photoWidth, photoHeight)];
        imageView.layer.cornerRadius = 5;
        NSURL *imgUrl =  [self dealWithUrlStr:self.model.photos[i] width:280 height:280];
        [imageView sd_setImageWithURL:imgUrl];
        
        [_photoScrollView addSubview:imageView];
        
    }
    _photoScrollView.contentSize = CGSizeMake(self.model.photos.count * (padding + photoWidth), 0);
    [cell.contentView addSubview:_photoScrollView];

}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        DetailFirstView *fristView = [[DetailFirstView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH * 0.4)];
        fristView.delegate = self;
        [fristView setFaceUrl:self.faceUrl];
        [fristView setModel:self.model];
        [cell.contentView addSubview:fristView];
        
    }else if(indexPath.row == 1){
        [self createMovieInfoLblWith:cell];
    }else if (indexPath.row == 2){
        [self createMoviePhotoScrollWith:cell];
    }else if(indexPath.row == 3){
        [self createActorDetailScrollWith:cell];
    }else{
        cell.textLabel.text = @" ";
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// cell Height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据返回数据的影片介绍的内容去确定第二个cell的高度
    CGRect rect = [self.model.dra boundingRectWithSize:CGSizeMake(kScreenW - 20, kScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil];
    CGFloat padding = 10;
    CGFloat photoWidth = (kScreenW - 5 * padding) / 4;
    CGFloat photoHeight = photoWidth * 1.7;

    
    if (indexPath.row == 0) {
        return kScreenH * 0.40;
    }else if (indexPath.row == 1){
        return rect.size.height * 2 + 25;
    }else if (indexPath.row == 2){
        return 160;
    }else if (indexPath.row == 3){
        return photoHeight + 60;
    }else{
        return 64;
    }
}


#pragma mark - 网络请求数据
- (void)requestDataFromNet
{   // 提示用户
    [SVProgressHUD showInfoWithStatus:@"正在拼命加载数据"];
    [SVProgressHUD setMinimumDismissTimeInterval:100];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    // 2 进行请求
    [manger GET:self.detailUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSDictionary *dataDic = dic[@"movie"];
        _videourl = dataDic[@"videourl"];
        self.model = [DetailModel mj_objectWithKeyValues:dataDic];
        [SVProgressHUD dismiss];
        [self requestActorData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}

#pragma mark - 请求演员详情列表数据
- (void)requestActorData
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *actorStr = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/movie/%@/celebrities.json",self.ID];
    
    // 2 进行请求
    [manger GET:actorStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.actorDic = responseObject[@"data"];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

#pragma mark - 返回按钮的点击事件
 - (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imageViewBtnClick:(UIButton*)btn
{
    NSLog(@"%ld",btn.tag);
    // 根据tag值找去用户点击的哪一个btn，传入ID 到下一个界面
    // 取数据
    NSArray * actorArr = self.actorDic[@"actors"];
    
    // 处理数据
    NSDictionary *dataDic = [NSDictionary dictionary];
        
    if (btn.tag - 200 == 0) {
        dataDic = [self.actorDic[@"directors"] lastObject];;
    }else{
        dataDic = actorArr[btn.tag - 200 - 1];
    }
    // 取出对应的id
    NSString *ID = dataDic[@"id"];
    
    ActorDetailViewController *actorVC = [[ActorDetailViewController alloc]initWithID:ID];
    actorVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:actorVC animated:YES];

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



#pragma mark - fristView Delegate
- (void)collectBtnClick
{
    SKDataBaseManger *mgr = [SKDataBaseManger shareManger];
     
    NSString *faceStr = self.faceUrl.absoluteString;
    [mgr insertFavoriteFaceUrl:faceStr detailUrl:self.detailUrl movieTitle:self.movieTitle movieID:self.ID];
}

- (void)shareBtnClick
{
    _shareBtn.enabled = NO;
    if (_shareBtnSelected) {
        return;
    }
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
    _shareBtnSelected = !_shareBtnSelected;
}
#pragma mark  - 自定制分享view上面的按钮的点击事件
- (void)shareBtnClick:(UIButton *)btn
{
    SKShareManager *manager = [SKShareManager shareManager];
    // 取出要分享的链接
    // 取出视频的播放地址
    NSString *videoName = [NSString stringWithFormat:@"%@预告片",self.movieTitle];
    switch (btn.tag) {
        case 660:
            [manager timelineShareWithViewController:self withShareText:videoName withShareUrl:_videourl];
            break;
        case 661:
            [manager wechatShareWithViewController:self withShareText:videoName withShareUrl:_videourl];
            break;
        case 662:{
            [manager messageShareWithViewController:self withShareText:videoName withShareUrl:_videourl];
            
        }
            break;
        case 663:{
            [manager emailShareWithViewController:self withShareText:videoName withShareUrl:_videourl];
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
    _shareBtnSelected = NO;
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        _shareView.frame = CGRectMake(0, kScreenH  , kScreenW, 180);
    }];
}

#pragma mark -  view 消失 ，提示用户框消失
- (void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}

- (void)viewWillAppear:(BOOL)animated
{
    _tableView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
