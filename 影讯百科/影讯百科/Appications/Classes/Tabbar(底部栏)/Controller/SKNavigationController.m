//
//  SKNavigationController.m
//  Friends
//
//  Created by g1game on 16/6/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "SKNavigationController.h"

@interface SKNavigationController ()

@end

@implementation SKNavigationController

#pragma mark - 初始化统一设置属性

+(void)initialize
{
    // 通过apprence 设置属性
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0f]}];
    [bar setBarTintColor:kMainColor];
  
    

}


#pragma mark - 拦截左右push 进来的控制器

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  隐藏tabbar
	[super pushViewController:viewController animated:animated];
	
	
    if (self.childViewControllers.count > 1) {
        
        self.tabBarController.tabBar.hidden = YES;
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
