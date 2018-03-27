//
//  TwelveViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/12.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "TwelveViewController.h"
#import "SecondTableViewCell.h"
#import "SecondModel.h"
#import "CommentViewController.h"
@interface TwelveViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation TwelveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestDataFromNet];
}

#pragma mark - 创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 108 - 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = kCellHeight;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self reloadMoreData];
    }];
    
    
    
    [self.view addSubview:_tableView];
}

#pragma mark - tableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 取出模型
    SecondModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取得影片的ID
    SecondModel *model = self.dataArray[indexPath.row];
    NSString *movieID = model.id;
    CommentViewController *detailVC = [[CommentViewController alloc]init];
    detailVC.movieID = movieID;
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 请求演员详情列表数据
- (void)requestDataFromNet
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://movie.douban.com/j/search_subjects?type=movie&tag=欧美&sort=recommend&page_limit=20&page_start=0";
    NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [SVProgressHUD showInfoWithStatus:@"正在加载数据..."];
    // 2 进行请求
    [manger GET:encodeStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = responseObject[@"subjects"];
        self.dataArray = [SecondModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    
}

#pragma mark - 刷新数据
- (void)refreshData
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://movie.douban.com/j/search_subjects?type=movie&tag=欧美&sort=recommend&page_limit=20&page_start=0";
    NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 2 进行请求
    [manger GET:encodeStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = responseObject[@"subjects"];
        self.dataArray = [SecondModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    [self.tableView.mj_header endRefreshing];
}


#pragma mark - 上拉加载更多数据
- (void)reloadMoreData
{
    static int page = 20;
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr =[NSString stringWithFormat: @"http://movie.douban.com/j/search_subjects?type=movie&tag=欧美&sort=recommend&page_limit=%d&page_start=0",page];
    NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // 2 进行请求
    [manger GET:encodeStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dataArr = responseObject[@"subjects"];
        self.dataArray = [SecondModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.tableView reloadData];
        page += 20;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    [self.tableView.mj_footer endRefreshing];
}- (void)didReceiveMemoryWarning {
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
