//
//  FavoriteViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SKDataBaseManger.h"
#import "FavoriteTableViewCell.h"
#import "FavoriteModel.h"
#import "MovieDetailViewController.h"
@interface FavoriteViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property(nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    _dataArray = [NSArray array];
    [self createUI];
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
#pragma mark - 取数据库查询数据
- (void)createUI
{
    SKDataBaseManger *mgr = [SKDataBaseManger shareManger];
    _dataArray  =[mgr selectAllFavoriteData];
    [self createTableView];
}

#pragma mark -  创建tableview
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.rowHeight = kCellHeight;
    [self.view addSubview:_tableView];
}


#pragma mark -  tableView 代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    FavoriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FavoriteTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FavoriteModel *model = _dataArray[indexPath.row];
    [cell setModel:model];
    return cell;
    
}

// cell Click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteModel *model = _dataArray[indexPath.row];
    
    MovieDetailViewController *detailVC = [[MovieDetailViewController alloc]initWithFaceUrl:[NSURL URLWithString:model.faceStr] detailUrl:model.detailUrl movieTitle:model.title movieID:model.movieID];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
