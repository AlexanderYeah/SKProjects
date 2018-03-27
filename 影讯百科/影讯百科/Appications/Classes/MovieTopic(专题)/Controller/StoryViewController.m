//
//  StoryViewController.m
//  影讯百科
//
//  Created by Alexander on 16/9/7.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "StoryViewController.h"
#import "CategoryTableViewCell.h"
#import "StoryDetailViewController.h"
@interface StoryViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
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
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"newsCell";
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 图片数组
    NSArray *imgArray = @[@"category_story",@"category_comedy",@"category_love",@"category_comic",@"category_action",@"category_horrible",@"category_panic",@"category_suspense",@"category_adventure",@"category_science",@"category_crime",@"category_war",@"category_documentary"];
    // 标题数组
    NSArray *titleArray = @[@"剧情",@"喜剧",@"爱情",@"动画",@"动作",@"恐怖",@"惊悚",@"悬疑",@"冒险",@"科幻",@"犯罪",@"战争",@"纪录片"];
    

    
    [cell setFaceImg:[UIImage imageNamed:imgArray[indexPath.row]]];
    [cell setCellTitle:titleArray[indexPath.row]];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row + 2;
    NSArray *titleArray = @[@"剧情",@"喜剧",@"爱情",@"动画",@"动作",@"恐怖",@"惊悚",@"悬疑",@"冒险",@"科幻",@"犯罪",@"战争",@"纪录片"];
    
    StoryDetailViewController *detailVC = [[StoryDetailViewController alloc]init];
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
