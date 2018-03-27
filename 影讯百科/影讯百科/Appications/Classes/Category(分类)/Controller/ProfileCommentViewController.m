//
//  ProfileCommentViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/21.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ProfileCommentViewController.h"

@interface ProfileCommentViewController ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

/** 前进按钮  */
@property (nonatomic,strong)UIButton *goBackBtn;
/** 后退按钮  */
@property (nonatomic,strong)UIButton *goForwardBtn;

@end

@implementation ProfileCommentViewController
-(instancetype)initWithShareUrl:(NSString *)shareUrl withShareTitle:(NSString *)title
{
    if (self = [super init]) {
        _shareTitle = title;
        _shareUrlStr = shareUrl;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.shareTitle;
        [self createBottomBar];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _webView = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.shareUrlStr]]];
    [self.view addSubview:webView];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 创建底部工具条
- (void)createBottomBar
{
    // 1 底部背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenH - 49, kScreenW, 49)];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    //  2 前进按钮
    UIButton *goFarwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:goFarwardBtn];
    _goForwardBtn = goFarwardBtn;
    [goFarwardBtn addTarget:self action:@selector(goForwardBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [goFarwardBtn setBackgroundImage:[UIImage imageNamed:@"goBack"] forState:UIControlStateNormal];
    [goFarwardBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.left.equalTo(bgView.left).offset(20);
        make.height.equalTo(15);
        make.width.equalTo(30);
    }];
    // 2 后退按钮
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goBackBtn = goBackBtn;
    [bgView addSubview:goBackBtn];
    [goBackBtn addTarget:self action:@selector(goBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [goBackBtn setBackgroundImage:[UIImage imageNamed:@"goForward"] forState:UIControlStateNormal];
    [goBackBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.left.equalTo(goFarwardBtn.right).offset(20);
        make.height.equalTo(15);
        make.width.equalTo(30);
    }];
    
    // 3 刷新按钮
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgView addSubview:refreshBtn];
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [refreshBtn setBackgroundImage:[UIImage imageNamed:@"goRresh"] forState:UIControlStateNormal];
    [refreshBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.top).offset(10);
        make.right.equalTo(bgView.right).offset(-20);
        make.height.equalTo(25);
        make.width.equalTo(30);
    }];
}

#pragma mark - UIWebviewDelegate
#pragma mark - <UIWebViewDelegate>
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goBackBtn.enabled = webView.canGoBack;
    self.goForwardBtn.enabled = webView.canGoForward;
}

#pragma mark - 前进按钮的点击事件
- (void)goForwardBtnClick
{
    
    [self.webView goForward];
}

#pragma mark - 后退按钮的点击事件
- (void)goBackBtnClick
{
    [self.webView goBack];
}
#pragma mark - 刷新按钮的点击事件
- (void)refreshBtnClick
{
    [self.webView reload];
}
#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
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
