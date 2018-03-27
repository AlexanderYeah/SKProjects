//
//  RegionViewController.m
//  影讯百科
//
//  Created by Alexander on 16/9/7.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "RegionViewController.h"
#import "CategoryTableViewCell.h"
#import "CatDetailViewController.h"
@interface RegionViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation RegionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
    
}

#pragma mark - 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 104- 44)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.rowHeight = 70;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableViewData Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"newsCell";
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 图片数组
    NSArray *imgArray = @[@"category_China",@"category_America",@"category_France",@"category_England",@"category_Japan",@"category_korea",@"category_India",@"category_Thailand",@"category_Germany"];
    // 标题数组
    NSArray *titleArray = @[@"大陆",@"美国",@"法国",@"英国",@"日本",@"韩国",@"印度",@"泰国",@"其他"];
    
    [cell setFaceImg:[UIImage imageNamed:imgArray[indexPath.row]]];
    [cell setCellTitle:titleArray[indexPath.row]];

    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = 0;
    if (indexPath.row != 8) {
        index = indexPath.row + 2;
    }else{
        index = 100;
    }
    NSArray *titleArray = @[@"大陆",@"美国",@"法国",@"英国",@"日本",@"韩国",@"印度",@"泰国",@"其他"];

    CatDetailViewController *detailVC = [[CatDetailViewController alloc]init];
    detailVC.catTitle = titleArray[indexPath.row];
    detailVC.index = index;
    [self.navigationController pushViewController:detailVC animated:YES];
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
