//
//  CenterViewController.m
//  影讯百科
//
//  Created by g1game on 16/8/25.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CenterViewController.h"

#import "ScrollSonView.h"
#import "HomeTableViewCell.h"
#import "HotMovieModel.h"
#import "MovieDetailViewController.h"
#import "WillShowViewController.h"
#import "BoxOfficeViewController.h"
#define kCenterX self.view.center.x
@interface CenterViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

{
    BOOL _isChange;
    BOOL _isH;
}
/** 数据数组 */
@property (nonatomic,strong)NSMutableArray *movieDataArray;
/** 滚动视图 */
@property (nonatomic,strong)UIScrollView *scrollView;
/** 临时数据 */
@property (nonatomic,strong)NSDictionary *tempDic;
/** 标记第一个滚动的视图 */
@property (nonatomic,strong)UIImageView *firstImageView;
/** tableView */
@property (nonatomic,strong)UITableView *tableView;





@end

@implementation CenterViewController




#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated

{
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieDataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"正在热映";
    
    [self requestDataFromNet];
    [self createNavItem];
}

#pragma mark - 创建导航栏按钮 
- (void)createNavItem{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"即将上映" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(kScreenW - 80, 28, 80, 30);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"票房排行" forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 28, 80, 30);
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;

}





#pragma mark -  创建TableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // 下拉刷新
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [self.view addSubview:_tableView];
   
}

#pragma mark - 创建顶部滚动视图 
- (UIScrollView *)createScrollView
{   // 1 创建顶部视图
    CGFloat height = kScreenH * 0.44;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, height)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.autoresizesSubviews = NO;
    
    NSLog(@"%@",NSStringFromCGRect(_scrollView.frame));
    // 获取数组的前十个模型
    NSMutableArray *scrollArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < 10; i ++) {
        [scrollArray addObject:[self.movieDataArray objectAtIndex:i]];
    }
    
    
    // 2 创建内容
    CGFloat movFaceHeight = kScreenH * 0.35;
    CGFloat movFaceWidth = movFaceHeight * 0.67;
    for (int i = 0; i < scrollArray.count ; i ++) {
        ScrollSonView *sonView = [[ScrollSonView alloc]initWithFrame:CGRectMake(i * kScreenW, 0, kScreenW, height)];
        sonView.tag = 120 + i;
        HotMovieModel *model = scrollArray[i];
        [sonView setModel:model];
                UIImageView *faceImgView = [sonView viewWithTag:111];
        
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(faceImgViewTap:)];
        
                tap.numberOfTapsRequired = 1;
        
                [faceImgView addGestureRecognizer:tap];
        

        // 如果i==0，直接放大
        if (i == 0) {
            UIImageView *movieFaceView = [sonView viewWithTag:111];
            _firstImageView = movieFaceView;
            [movieFaceView updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(movFaceHeight);
                make.width.equalTo(movFaceWidth);
           }];
        }
        
        [_scrollView addSubview:sonView];
    }
    
    _scrollView.contentSize = CGSizeMake(kScreenW * scrollArray.count, 0);
    
    return _scrollView;
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
    [manger GET:kHomeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *hotArr = dic[@"hot"];
        NSArray *dataArr = [hotArr lastObject] [@"movies"];
        self.movieDataArray = [HotMovieModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}
#pragma mark - tableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieDataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ScrollID = @"scrollCell";
    static NSString *NormalID = @"mormalCell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ScrollID];
    HomeTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:NormalID];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ScrollID];
    }
    if (cell2 == nil) {
        cell2 = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NormalID];
    }
    // 给cell设置内容
    if (indexPath.row == 0) {// 第一个cell
        UIScrollView *scrollView = [self createScrollView];
        [cell1.contentView addSubview:scrollView];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;
    }else{ // 其余的cell
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        // 取出模型数组
        HotMovieModel *model = self.movieDataArray[indexPath.row - 1];
        [cell2 setModel:model];
        
        return cell2;
    }
    
}
// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kScreenH * 0.44;
    }else{
        return kScreenH * 0.177;
    }
}

// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出点击cell的模型,进行数据传递
    if (indexPath.row == 0) {
        return;
    }else{
        HotMovieModel *model = self.movieDataArray[indexPath.row - 1];
        NSString *detailUrl =  [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/%@.json",[model.id stringValue]];
        NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
        MovieDetailViewController *detailVC = [[MovieDetailViewController alloc]initWithFaceUrl:imgUrl detailUrl:detailUrl movieTitle:model.nm movieID:[model.id stringValue]];
        detailVC.view.backgroundColor = [UIColor whiteColor];
       [self.navigationController pushViewController:detailVC animated:YES];
        
    }
    
}

#pragma mark - UIScrollViewDelegate 代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    static float newX = 0;
    static float oldX = 0;
    newX = scrollView.contentOffset.x;
    
    
    // 获取当前的偏移量，找对对应的图片，做偏移
    NSInteger index = scrollView.contentOffset.x / kScreenW;
    NSLog(@"%zd",index);
    
    // 拿到当前的imageView
    UIImageView *bgImgView = [scrollView viewWithTag:index + 120];
    UIImageView *imgView = [bgImgView viewWithTag:111];
    
    // 拿到之前的imageView
    UIImageView *previousBgImgView = nil;
     if (newX != oldX) {
        if (newX > oldX) { // 向左滑动
            previousBgImgView = [scrollView viewWithTag:index + 120 - 1];
            NSLog(@"left");
        }else{ //向右滑动
            NSLog(@"right");
            previousBgImgView = [scrollView viewWithTag:index + 120 + 1];
        }
        oldX = newX;
    }
    UIImageView *previousImgView = [previousBgImgView viewWithTag:111];
    // 获取self的中心点
    
    CGFloat centerY = scrollView.center.y;
    // 缩放数据
    CGFloat movFaceHeight = kScreenH * 0.35;
    CGFloat movFaceWidth = movFaceHeight * 0.67;
    CGFloat newMovFaceHeight = movFaceHeight/1.5;
    CGFloat newMovFaceWidth = newMovFaceHeight * 0.67;
    CGFloat topPaddng = kScreenH * (0.44 - 0.375) / 2;
    
    // 动画效果
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (index != 0) {
            imgView.frame = CGRectMake(kCenterX - movFaceWidth /2 , topPaddng, movFaceWidth, movFaceHeight);
            _firstImageView.frame = CGRectMake(kCenterX - newMovFaceWidth/2, bgImgView.center.y - newMovFaceHeight/2 - 64, newMovFaceWidth, newMovFaceHeight);
            previousImgView.frame = CGRectMake(kCenterX - newMovFaceWidth/2, centerY - newMovFaceHeight/2, newMovFaceWidth, newMovFaceHeight);
        }else{
            _firstImageView.frame = CGRectMake(kCenterX - movFaceWidth /2 , topPaddng, movFaceWidth, movFaceHeight);
            previousImgView.frame = CGRectMake(kCenterX - newMovFaceWidth/2, centerY - newMovFaceHeight/2 , newMovFaceWidth, newMovFaceHeight);
        }
    } completion:^(BOOL finished) {
        
    }];
    
    NSLog(@"拖动结束");
    
}

#pragma mark - 下拉刷新方法
- (void)refreshData
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    // 2 进行请求
    [manger GET:kHomeUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *hotArr = dic[@"hot"];
        NSArray *dataArr = [hotArr lastObject] [@"movies"];
        self.movieDataArray = [HotMovieModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];

}

#pragma mark - 点击事件
#pragma mark - 即将热映按钮的点击 
- (void)rightBtnClick
{
    WillShowViewController *willVC = [[WillShowViewController alloc]init];
    [self.navigationController pushViewController:willVC animated:YES];
}
#pragma mark - 即将热映按钮的点击
- (void)leftBtnClick
{
    BoxOfficeViewController *boxVC = [[BoxOfficeViewController alloc]init];
    boxVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:boxVC animated:YES];
}

- (void)faceImgViewTap:(UITapGestureRecognizer *)tap
{
    
    NSInteger index = _scrollView.contentOffset.x /kScreenW;
    
    HotMovieModel *model = self.movieDataArray[index];
    NSString *detailUrl =  [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/%@.json",[model.id stringValue]];
    NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
    MovieDetailViewController *detailVC = [[MovieDetailViewController alloc]initWithFaceUrl:imgUrl detailUrl:detailUrl movieTitle:model.nm movieID:[model.id stringValue]];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}


#pragma mark - 方法的抽取
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
