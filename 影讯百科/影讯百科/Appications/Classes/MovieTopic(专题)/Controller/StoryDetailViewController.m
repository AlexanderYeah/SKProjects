//
//  StoryDetailViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/8.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "CatDetailModel.h"
#import "CategoryCollectionViewCell.h"
#import "MovieDetailViewController.h"
@interface StoryDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

/** collectionView */
@property (nonatomic,strong)UICollectionView *collectView;
/** 数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDataFromNet];
    self.dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.catTitle;
    [self createLeftNav];
}


- (void)createLeftNav
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 20, 14, 26);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
#pragma mark - createCollectView
- (void)createCollectView
{
    // 计算item的宽度以及高度
    CGFloat itemPadding = 8;
    CGFloat itemWidth = (kScreenW - itemPadding * 4 ) / 3;
    CGFloat itemHeight = itemWidth * 1.427 + 30;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumInteritemSpacing = 8;
    flowLayout.minimumLineSpacing = 8;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    _collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(8, 64 ,kScreenW - 16, kScreenH - 8 - 64) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    [self.view addSubview:_collectView];
    _collectView.backgroundColor = [UIColor whiteColor];
    _collectView.showsVerticalScrollIndicator = NO;
    
    
    // 上拉刷新，下拉加载
    _collectView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self.collectView reloadData];
        [self.collectView.mj_header endRefreshing];
    }];
    _collectView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self reloadMoreData];
    }];
    
    
    // 按页显示
    _collectView.pagingEnabled = NO;
    _collectView.bounces = YES;
    
    // 注册cell的复用池
    [_collectView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CatDetailModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CatDetailModel *model = self.dataArray[indexPath.row];
    NSString *detailUrl =  [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/%@.json",[model.id stringValue]];
    NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
    MovieDetailViewController *detailVC = [[MovieDetailViewController alloc]initWithFaceUrl:imgUrl detailUrl:detailUrl movieTitle:model.nm movieID:[model.id stringValue]];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
    
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
#pragma mark - 网络请求数据
- (void)requestDataFromNet
{   // 提示用户
    [SVProgressHUD showInfoWithStatus:@"正在拼命加载数据"];
    [SVProgressHUD setMinimumDismissTimeInterval:100];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    // 2 进行请求
    NSString *urlStr = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/search/movie/category/list.json?cat=%ld&limit=20&offset=0",self.index];
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr  = responseObject[@"list"];
        self.dataArray = [CatDetailModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createCollectView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}

- (void)reloadMoreData
{
    static int pageIndex = 20;
    
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/search/movie/category/list.json?cat=%ld&limit=%d&offset=0",self.index,pageIndex];
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr  = responseObject[@"list"];
        self.dataArray = [CatDetailModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self.collectView reloadData];
        [self.collectView.mj_footer endRefreshing];
        pageIndex  = pageIndex + 20;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}
#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    _collectView.frame = CGRectMake(8, 0,kScreenW - 16 , kScreenH - 8);
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
