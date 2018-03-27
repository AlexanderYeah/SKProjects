//
//  SearchViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/14.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SearchViewController.h"
#import "LYTextField.h"
#import "LYButton.h"
#import "ResultViewController.h"
#import "SKDataBaseManger.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"搜索";
    [self.view.layer addSublayer: [self backgroundLayer]];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self setUp];
}


-(void)viewDidDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
}
-(void)setUp{
    
    
    LYTextField *username = [[LYTextField alloc]initWithFrame:CGRectMake(0, 0, 270, 30)];
    username.center = CGPointMake(self.view.center.x, 100);
    username.ly_placeholder = @"请输入您要搜索的内容";
    username.tag = 0;
    [self.view addSubview:username];
    
    LYButton *login = [[LYButton alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    login.center = CGPointMake(self.view.center.x, username.center.y+100);
    login.hidden = YES;
    [self.view addSubview:login];
    
    login.hidden = NO;
        __block LYButton *button = login;
        login.translateBlock = ^{
            button.bounds = CGRectMake(0, 0, 44, 44);
            button.layer.cornerRadius = 22;
            ResultViewController *nextVC = [[ResultViewController alloc]init];
            nextVC.searchWord = username.textField.text;
            // 用户点击搜索，添加到数据库
            [self insertRecordWithKeyWord:nextVC.searchWord];
          [self presentViewController:nextVC animated:YES completion:nil];
        };
}

#pragma mark - insertDataBase 
- (void)insertRecordWithKeyWord:(NSString *)keyWord
{
    // 获取系统的时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateStr =[formatter stringFromDate:date];
    // 创建数据库管理工具
    SKDataBaseManger *mgr = [SKDataBaseManger shareManger];
    [mgr insertSearchWord:keyWord withTime:dateStr];

}

-(CAGradientLayer *)backgroundLayer{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:68/255.0f green:203/255.0f blue:255/255.0f alpha:1].CGColor,(__bridge id)[UIColor redColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.locations = @[@0.65,@1];
    return gradientLayer;
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
