//
//  CategoryViewController.m
//  影讯百科
//
//  Created by g1game on 16/8/25.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CategoryViewController.h"
#import "ProfileTableViewCell.h"
#import "InfomationViewController.h"
#import "ShareMovieViewController.h"
#import "MovieCommentViewController.h"
#import "SearchRecordViewController.h"
#import "FavoriteViewController.h"
@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView */
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"个人中心";
    [self createTableView];
}

#pragma mark -  创建tableview
- (void)createTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenW, 400)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 60;
    self.tableView.scrollEnabled = NO;
    [self.view addSubview:_tableView];
}


#pragma mark -  tableView 代理方法 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    ProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProfileTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSArray *imageArr = @[@"profileAbout",@"profile_mail",@"profile_Movie",@"profile_share",@"profile_search",@"favorite"];
    NSArray *titleArray = @[@"关于应用",@"联系我们",@"电影分享",@"影评分享",@"我的搜索",@"我的收藏"];
    
    [cell setCellTitle:titleArray[indexPath.row]];
    [cell setIconImg:[UIImage imageNamed:imageArr[indexPath.row]]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}


// cell Height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// cellClick
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *navTitle = nil;
    if (indexPath.row == 0) {
        navTitle = @"关于应用";
        InfomationViewController *infoVC = [[InfomationViewController alloc]initWithNavTitle:navTitle initWithUrl:@""];
        

        [self.navigationController pushViewController:infoVC animated:YES];

    }else if(indexPath.row == 1){
        navTitle = @"联系我们";
        InfomationViewController *infoVC = [[InfomationViewController alloc]initWithNavTitle:navTitle initWithUrl:@""];
        

        [self.navigationController pushViewController:infoVC animated:YES];
    }else if (indexPath.row == 2){
        ShareMovieViewController *shareVC = [[ShareMovieViewController alloc]init];
        shareVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:shareVC animated:YES];
    }else if (indexPath.row == 3){
        MovieCommentViewController *commentVC = [[MovieCommentViewController alloc]init];
        commentVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:commentVC animated:YES];
    }else if(indexPath.row == 4){
        SearchRecordViewController *searchVC = [[SearchRecordViewController alloc]init];
        searchVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:searchVC animated:YES];
    }else{
        FavoriteViewController *favoVC = [[FavoriteViewController alloc]init];
        favoVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:favoVC animated:YES];
    }
    
   
}


#pragma mark - viewWillAppear
- (void)viewWillAppear:(BOOL)animated

{
    self.tabBarController.tabBar.hidden = NO;
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
