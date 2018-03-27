//
//  MoviePlayViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/18.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "MoviePlayViewController.h"

@interface MoviePlayViewController ()
/** UIWebview */
@property (nonatomic,strong)UIWebView *webView;

@end

@implementation MoviePlayViewController

-(instancetype)initWithVideoUrl:(NSURL *)url WithVideoName:(NSString *)videoName
{
    if (self = [super init]) {
        _videoUrl = url;
        _videoName = videoName;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTopView];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64)];
    [self.view addSubview:_webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.videoUrl]];
}

#pragma mark - setUpTopView
- (void)setUpTopView
{
    // 1 背景 高度 44
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
    bgView.backgroundColor = kMainColor;
    [self.view addSubview:bgView];
    
    // 2 标题
    UILabel *titleLbl = [self createLblWithTitle:self.videoName];
    titleLbl.frame = CGRectMake(kScreenW/2 - kScreenW/4, 28, kScreenW/2, 30);
    titleLbl.font = [UIFont systemFontOfSize:20.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.textColor = [UIColor blackColor];
    [self.view addSubview:titleLbl];
    
    // 3 取消 按钮 
    UIButton *cancleBtn = [self createBtnWithTitle:@""];
    cancleBtn.frame = CGRectMake(15, 30, 14, 26);
    [cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [self.view addSubview:cancleBtn];


}


#pragma mark - cancelBtnClick
- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UILabel *)createLblWithTitle:(NSString *)title

{
    UILabel *label = [[UILabel alloc]init];
    label.text = title;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:14.0f];
    return label;
}

- (UIButton *)createBtnWithTitle:(NSString *)title

{
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:19.0f];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
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
