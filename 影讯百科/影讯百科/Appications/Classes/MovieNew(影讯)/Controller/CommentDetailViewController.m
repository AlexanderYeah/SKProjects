//
//  CommentDetailViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CommentDetailViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "CMuneBar.h"
#import "SKShareManager.h"
#import "SKDataBaseManger.h"
@interface CommentDetailViewController ()<CMuneBarDelegate,UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *webView;

/** 按钮 菜单*/
@property(nonatomic,weak)CMuneBar *muneBar;
/** 按钮 菜单*/
@property(nonatomic,weak)CMuneBar *currentMenuBar;
/** 前进按钮  */
@property (nonatomic,strong)UIButton *goBackBtn;
/** 后退按钮  */
@property (nonatomic,strong)UIButton *goForwardBtn;

@end

@implementation CommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"影评";
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    _webView = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:self.shareUrl]];
    [self.view addSubview:webView];
    // 创建底部工具条
    [self createBottomBar];
    [self createShareBtn];
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

#pragma mark - 创建分享按钮
- (void)createShareBtn
{
    CMuneBar *muneBar = [[CMuneBar alloc] initWithItems:@[@"分享-icon-QQ",@"分享-icon-新浪微博",@"分享-icon-微信朋友圈-点击",@"分享-icon-微信-点击"] size:CGSizeMake(50, 50) type:kMuneBarTypeRadLeft];
    muneBar.delegate = self;
    [self.view addSubview:muneBar];
    [muneBar makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-30);
        make.centerY.equalTo(self.view.centerY).offset(-30);
        make.height.equalTo(50);
        make.width.equalTo(50);
    }];
    self.muneBar = muneBar;
    self.muneBar.type = 8;
}

- (void)muneBarselected:(NSInteger)index
{
    NSLog(@"%@",@(index));
    SKShareManager *manager = [SKShareManager shareManager];
    // 创建数据库管理工具
    SKDataBaseManger *mgr = [SKDataBaseManger shareManger];
    [mgr insertCommentName:self.shareTitle withTitle:self.movieName Summary:self.summary Author:self.author withShareUrl:self.shareUrlStr];
    switch (index) {
        case 3: // 朋友圈
            [manager wechatShareWithViewController:self withShareText:self.shareTitle withShareUrl:self.shareUrlStr];
            break;
        case 2: // 微信
        {
            [manager timelineShareWithViewController:self withShareText:self.shareTitle  withShareUrl:self.shareUrlStr];
        }
            break;
        case 1:// 短信
        {
            [manager messageShareWithViewController:self withShareText:self.shareTitle  withShareUrl:self.shareUrlStr];
        }
            break;
        case 0: // 邮件
        {
            [manager emailShareWithViewController:self withShareText:self.shareTitle  withShareUrl:self.shareUrlStr];
        }
            break;
            
        default:
            break;
    }
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
#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 刷新按钮的点击事件 
- (void)refreshBtnClick
{
    [self.webView reload];
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
