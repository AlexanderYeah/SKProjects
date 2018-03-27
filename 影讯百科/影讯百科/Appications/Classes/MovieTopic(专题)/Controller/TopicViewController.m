//
//  TopicViewController.m
//  影讯百科
//
//  Created by g1game on 16/8/25.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "TopicViewController.h"
#import "RegionViewController.h"
#import "StoryViewController.h"
#import "SearchViewController.h"
@interface TopicViewController ()<UIScrollViewDelegate>

// titleBtn底部的动画
@property (nonatomic,strong)UIView *AnimView;
// 用于添加tableViewController
@property (nonatomic,strong)UIScrollView *contentView;
// 用于标记之前选中的btn
@property (nonatomic,strong)UIButton *previousBtn;


@end

@implementation TopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"分类";
    [self createTitleView];
    [self setUpChildViewController];
    [self createContentView];
    [self setupNavBar];
}

#pragma mark - setupNavBar
- (void)setupNavBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"搜索-icon-搜索-灰"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(kScreenW - 80, 28, 25, 25);
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}
#pragma mark - 搭建顶部视图
- (void)createTitleView
{
    // title View
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 44)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    
    // title Btn
    NSArray *titleArr = @[@"地区",@"剧情"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(kScreenW / 2 * i, 0, kScreenW / 2, 44);
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        titleBtn.tag = 1000 + i;
        [titleView addSubview:titleBtn];
        if (i == 0) {
            titleBtn.selected = YES;
            _previousBtn = titleBtn;
        }
        
    }
    
    // 创建底部可以滚动的view
    _AnimView = [[UIView alloc]initWithFrame:CGRectMake(0,43, kScreenW / 2, 1)];
    _AnimView.backgroundColor = kMainColor;
    [titleView addSubview:_AnimView];
}

#pragma  mark - 初始化控制器
- (void)setUpChildViewController
{
    RegionViewController *squareVC = [[RegionViewController alloc]init];
    [self addChildViewController:squareVC];
    
    StoryViewController *focusVC = [[StoryViewController alloc]init];
    [self addChildViewController:focusVC];
    
    
}
#pragma mark- 创建scrollView，用于添加tableViewController
- (void)createContentView
{
    // 创建scrollView
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, kScreenW, kScreenH)];;
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
    _contentView.pagingEnabled = YES;
    _contentView.contentSize = CGSizeMake(kScreenW * 2, 0);
    _contentView.bounces = NO;
    [self scrollViewDidEndScrollingAnimation:_contentView];
    
}


#pragma mark -  点击事件
#pragma mark - Btn的点击事件
- (void)titleBtnClick:(UIButton *)btn
{
    NSInteger index = btn.tag - 1000;
    [_contentView setContentOffset:CGPointMake(index * kScreenW, 0) animated:YES];
    if (_previousBtn != btn) {
        _previousBtn.selected = NO;
        btn.selected = YES;
        _previousBtn = btn;
        // 底部view的动画
        [UIView animateWithDuration:0.3 animations:^{
            _AnimView.frame = CGRectMake(kScreenW / 2 * index, 43, kScreenW / 2, 1);
        }];
    }
}

#pragma mark - 搜索按钮的点击事件
- (void)rightBtnClick
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    searchVC.view.backgroundColor = [UIColor clearColor];
    [self.navigationController pushViewController:searchVC animated:YES];
}


#pragma mark- scrollViewDelegate
// 当scrollview 滚动完成再去加载控制器
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 滚动完成，再去加载vc
    NSInteger pageIndex = _contentView.contentOffset.x / kScreenW;
    UIViewController * vc = self.childViewControllers[pageIndex];
    vc.view.frame = CGRectMake(pageIndex * kScreenW, 0, kScreenW, kScreenH);
    [_contentView addSubview:vc.view];
    
}

// scrollView 滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:_contentView];
    // 和titleBtn进行联动
    NSInteger index = _contentView.contentOffset.x / kScreenW;
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000 + index];
    [self titleBtnClick:btn];
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
