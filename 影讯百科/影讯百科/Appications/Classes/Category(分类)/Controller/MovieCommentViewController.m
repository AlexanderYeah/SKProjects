//
//  MovieCommentViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/20.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "MovieCommentViewController.h"
#import "SKDataBaseManger.h"
#import "MovieCommentModel.h"
#import "MovieCommentTableViewCell.h"
#import "ProfileCommentViewController.h"
@interface MovieCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSArray *dataArray;

@end

@implementation MovieCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分享影评";
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
    _dataArray  =[mgr selectAllCommentData];
    [self createTableView];
}

#pragma mark -  创建tableview
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenW, 320)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.rowHeight = kScreenH * 0.17 + 20;
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
    MovieCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MovieCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MovieCommentModel *model = _dataArray[indexPath.row];
    [cell setModel:model];
    return cell;
    
}

// cell Click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型
    MovieCommentModel *model = _dataArray[indexPath.row];
    
    ProfileCommentViewController *commentVC = [[ProfileCommentViewController alloc]initWithShareUrl:model.share_url withShareTitle:model.movieName];
    commentVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:commentVC animated:YES];
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



//   

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
