//
//  InfomationViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/19.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "InfomationViewController.h"

@interface InfomationViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *infoWebView;
@end

@implementation InfomationViewController

- (instancetype)initWithNavTitle:(NSString *)navTitle initWithUrl:(NSString *)shareUrl
{
    if (self = [super init]) {
        _navTitle = navTitle;
        _shareUrl = shareUrl;
    }
    return self;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.navTitle;
    _infoWebView = [[UIWebView alloc]init];
    
    _infoWebView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    NSURL *url1 = [[NSBundle mainBundle]URLForResource:@"AboutApp" withExtension:@"html"];
    NSURL *url2 = [[NSBundle mainBundle]URLForResource:@"ContactUs" withExtension:@"html"];
    [self.view addSubview:_infoWebView];
    if ([self.navTitle isEqualToString:@"关于应用"]) {
        [_infoWebView loadRequest:[NSURLRequest requestWithURL:url1]];
    }else if ([self.navTitle isEqualToString:@"联系我们"]){
        [_infoWebView loadRequest:[NSURLRequest requestWithURL:url2]];
        _infoWebView.scrollView.scrollEnabled = NO;
    }else if ([self.navTitle isEqualToString:@"电影详情"]){
        NSURL *url = [NSURL URLWithString:self.shareUrl];
        [_infoWebView loadRequest:[NSURLRequest requestWithURL:url]];
    }else{
        
    }
    // 1 底部背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 49, kScreenW, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    [self createLeftNav];

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
