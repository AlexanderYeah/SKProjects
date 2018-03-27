//
//  BoxOfficeViewController.m
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "BoxOfficeViewController.h"
#import "BoxChinaViewController.h"
#import "BoxHongViewController.h"
#import "BoxNBViewController.h"

@interface BoxOfficeViewController ()<UIScrollViewDelegate>

// titleBtn底部的动画
@property (nonatomic,strong)UIView *AnimView;
// 用于添加tableViewController
@property (nonatomic,strong)UIScrollView *contentView;
// 用于标记之前选中的btn
@property (nonatomic,strong)UIButton *previousBtn;

@end

@implementation BoxOfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"票房排行";
    [self createTitleView];
    [self setUpChildViewController];
    [self createContentView];
    [self createLeftNavButton];
    
}

#pragma mark - 重写leftBarButtonItem
- (void)createLeftNavButton
{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(15, 20, 14, 26);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
}



#pragma mark - 搭建顶部视图
- (void)createTitleView
{
    // title View
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 44)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    [self.view addSubview:titleView];
    
    // title Btn
    NSArray *titleArr = @[@"日票房",@"周票房",@"月票房"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake(kScreenW / 3 * i, 0, kScreenW / 3, 44);
        [titleBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor colorWithRed:108/255.0f green:186/255.0f blue:52/255.0f alpha:1] forState:UIControlStateSelected];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        titleBtn.tag = 1000 + i;
        [titleView addSubview:titleBtn];
        if (i == 0) {
            titleBtn.selected = YES;
            _previousBtn = titleBtn;
        }
        
    }
    
    // 创建底部可以滚动的view
    _AnimView = [[UIView alloc]initWithFrame:CGRectMake(0,43, kScreenW / 3, 1)];
    _AnimView.backgroundColor = [UIColor colorWithRed:108/255.0f green:186/255.0f blue:52/255.0f alpha:1];
    [titleView addSubview:_AnimView];
}

#pragma  mark - 初始化控制器
- (void)setUpChildViewController
{
    BoxChinaViewController *squareVC = [[BoxChinaViewController alloc]init];
    [self addChildViewController:squareVC];
    
    BoxHongViewController *focusVC = [[BoxHongViewController alloc]init];
    [self addChildViewController:focusVC];
    
    BoxNBViewController *serviceVC = [[BoxNBViewController alloc]init];
    [self addChildViewController:serviceVC];
    
}
#pragma mark- 创建scrollView，用于添加tableViewController
- (void)createContentView
{
    // 创建scrollView
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 108, kScreenW, kScreenH)];;
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
    _contentView.pagingEnabled = YES;
    _contentView.contentSize = CGSizeMake(kScreenW * 3, 0);
    _contentView.bounces = NO;
    [self scrollViewDidEndScrollingAnimation:_contentView];
    
}

#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
            _AnimView.frame = CGRectMake(kScreenW / 3 * index, 43, kScreenW / 3, 1);
        }];
    }
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
