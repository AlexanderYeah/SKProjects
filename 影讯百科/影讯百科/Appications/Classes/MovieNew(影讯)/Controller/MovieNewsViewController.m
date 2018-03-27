//
//  MovieNewsViewController.m
//  影讯百科
//
//  Created by g1game on 16/8/25.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "MovieNewsViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SevenViewController.h"
#import "EhightViewController.h"
#import "NineViewController.h"
#import "TenViewController.h"
#import "ElevenViewController.h"
#import "TwelveViewController.h"
#import "ThirteenViewController.h"

#define kTitleBtnW 60

@interface MovieNewsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
// titleBtn底部的动画
@property (nonatomic,strong)UIView *AnimView;
// 用于添加tableViewController
@property (nonatomic,strong)UIScrollView *contentView;
// 用于标记之前选中的btn
@property (nonatomic,strong)UIButton *previousBtn;
/** top scrollView */
@property (nonatomic, strong)UIScrollView *topScrollView;

@end

@implementation MovieNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"影评";
    self.titles = @[@"正在上映", @"热门", @"最新", @"经典", @"动作", @"喜剧", @"爱情", @"科幻", @"悬疑", @"恐怖", @"华语", @"欧美", @"日韩"];
    [self setupChildViewController];
    [self createTitleView];
    [self createContentView];
}


#pragma mark - 搭建顶部视图
- (void)createTitleView
{
    
    _topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 44)];
    _topScrollView.delegate = self;
    _topScrollView.contentSize = CGSizeMake(kTitleBtnW * self.titles.count, 0);
    _topScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_topScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // title Btn
    for (int i = 0; i < self.titles.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(kTitleBtnW * i + 5, 0, kTitleBtnW, 44);
        [titleBtn setTitle:self.titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:kMainColor forState:UIControlStateSelected];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        titleBtn.tag = 1000 + i;
        [_topScrollView addSubview:titleBtn];
        if (i == 0) {
            titleBtn.selected = YES;
            _previousBtn = titleBtn;
        }
    }
    // 创建底部可以滚动的view
    _AnimView = [[UIView alloc]initWithFrame:CGRectMake(5,43, kTitleBtnW , 1)];
    _AnimView.backgroundColor = kMainColor;
    [_topScrollView addSubview:_AnimView];
}

#pragma mark- 创建scrollView，用于添加tableViewController
- (void)createContentView
{
    // 创建scrollView
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, kScreenW, kScreenH)];;
    _contentView.delegate = self;
    _contentView.userInteractionEnabled = YES;
    [self.view addSubview:_contentView];
    _contentView.pagingEnabled = YES;
    _contentView.contentSize = CGSizeMake(kScreenW * self.titles.count, 0);
    _contentView.bounces = NO;
    [self scrollViewDidEndScrollingAnimation:_contentView];
}


// 添加所有子控制器
- (void)setupChildViewController {
    // 正在热映
    FirstViewController *oneVC = [[FirstViewController alloc] init];
    [self addChildViewController:oneVC];
    // 电视剧
    SecondViewController *twoVC = [[SecondViewController alloc] init];
    [self addChildViewController:twoVC];
    // 电影
    ThirdViewController *threeVC = [[ThirdViewController alloc] init];
    [self addChildViewController:threeVC];
    // 综艺
    FourthViewController *fourVC = [[FourthViewController alloc] init];
    [self addChildViewController:fourVC];
    // NBA
    FifthViewController *fiveVC = [[FifthViewController alloc] init];
    [self addChildViewController:fiveVC];
    // 新闻
    SixthViewController *sixVC = [[SixthViewController alloc] init];
    [self addChildViewController:sixVC];
    // 娱乐
    SevenViewController *VC7 = [[SevenViewController alloc] init];
    [self addChildViewController:VC7];
    // 音乐
    EhightViewController *VC8 = [[EhightViewController alloc] init];
    [self addChildViewController:VC8];
    // 网络电视
    NineViewController *VC9 = [[NineViewController alloc] init];
    [self addChildViewController:VC9];
    // 音乐
    TenViewController *VC10 = [[TenViewController alloc] init];
    [self addChildViewController:VC10];
     // 网络电视
    ElevenViewController *VC11 = [[ElevenViewController alloc] init];
    [self addChildViewController:VC11];
    // 音乐
    TwelveViewController *VC12 = [[TwelveViewController alloc] init];
    [self addChildViewController:VC12];
    // 网络电视
    ThirteenViewController *VC13 = [[ThirteenViewController alloc] init];
    [self addChildViewController:VC13];
    
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
        [UIView animateWithDuration:0.2 animations:^{
            _AnimView.frame = CGRectMake(kTitleBtnW * index + 5, 43, kTitleBtnW, 1);
        }];
    }
}


#pragma mark- scrollViewDelegate
// 当scrollview 滚动完成再去加载控制器
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView == _contentView) {
        // 滚动完成，再去加载vc
        NSInteger pageIndex = _contentView.contentOffset.x / kScreenW;
        UIViewController * vc = self.childViewControllers[pageIndex];
        vc.view.frame = CGRectMake(pageIndex * kScreenW, 0, kScreenW, kScreenH);
        [_contentView addSubview:vc.view];
   }
}
// scrollView 滚动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _contentView) {
        [self scrollViewDidEndScrollingAnimation:_contentView];
        // 和titleBtn进行联动
        NSInteger index = _contentView.contentOffset.x / kScreenW;
        if (index >= 2) { // 让topScrollView 去偏移
            [_topScrollView setContentOffset:CGPointMake(kTitleBtnW * index, 0) animated:YES];
        }else{
            [_topScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        UIButton *btn = (UIButton *)[self.view viewWithTag:1000 + index];
        [self titleBtnClick:btn];
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

@end
