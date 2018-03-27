//
//  SKTabbarViewController.m
//  Friends
//
//  Created by g1game on 16/6/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SKTabbarViewController.h"
#import "SKNavigationController.h"
#import "CenterViewController.h"
#import "MovieNewsViewController.h"
#import "TopicViewController.h"
#import "CategoryViewController.h"
#import "CenterViewController.h"


@interface SKTabbarViewController ()<UITabBarControllerDelegate,UITabBarDelegate>

@end

@implementation SKTabbarViewController

// 初始化统一设置tabbar 的属性
+ (void)initialize
{
    //appearance 统一设置tabbar 的文字属性
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:12.0f];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    
    NSMutableDictionary *selectDict = [NSMutableDictionary dictionary];
    selectDict[NSFontAttributeName] = [UIFont systemFontOfSize:12.0f];
    selectDict[NSForegroundColorAttributeName] = kMainColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDict forState:UIControlStateSelected];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    
    // 添加子控制器
    
    [self setupChildVC:[[CenterViewController alloc]init] title:@"热映" image:@"tabbar_profile" selectImage:@"tabbar_profile_highlighted"];
    [self setupChildVC:[[MovieNewsViewController alloc]init] title:@"影评" image:@"tabbar_message_center" selectImage:@"tabbar_message_center_highlighted"];
    [self setupChildVC:[[TopicViewController alloc]init] title:@"分类" image:@"tabbar_compose_button" selectImage:@"tabbar_compose_button_highlighted"];
    [self setupChildVC:[[CategoryViewController alloc]init] title:@"个人" image:@"tabbar_home" selectImage:@"tabbar_home_highlighted"];
    

    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    
}

#pragma mark - 初始化子控制器
- (void)setupChildVC:(UIViewController *)vc title:(NSString *)title  image:(NSString *)image  selectImage:(NSString *)selectImage
{
    // 设置文字图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage]imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
    // 包装一个导航控制器，添加导航控制器为tabbar 的子控制器
    SKNavigationController *nav = [[SKNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
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
