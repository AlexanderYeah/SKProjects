//
//  ResultViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/14.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ResultViewController.h"
#import "FourPingTransition.h"
#import "ResultModel.h"
#import "ResultTableViewCell.h"
#import "ResultDetailViewController.h"
@interface ResultViewController ()<UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSArray *dataArray;


@end

@implementation ResultViewController
-(instancetype)init{
    if(self = [super init]){
        self.transitioningDelegate = self;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTopView];
    [self requestDataFromNet];

}
#pragma mark - setUpTopView
- (void)setUpTopView
{
    // 1 背景 高度 44
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
    bgView.backgroundColor = kMainColor;
    [self.view addSubview:bgView];
    
    // 2 标题
    UILabel *titleLbl = [self createLblWithTitle:@"搜索结果"];
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

#pragma mark - 创建TableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH - 64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.rowHeight = kScreenH * 0.24;
    [self.view addSubview:_tableView];
 }

#pragma mark - tableView Datasource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"searchCell";
    ResultTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ResultTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ResultModel *model = self.dataArray[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出影片的gid 传入下个页面
    ResultModel *model = self.dataArray[indexPath.row];
    ResultDetailViewController *detailVC = [[ResultDetailViewController alloc]initWithGid:model.gid];
    [self presentViewController:detailVC animated:YES completion:nil];
}
#pragma mark - 请求演员详情列表数据
- (void)requestDataFromNet
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://videoapi.easou.com/n/api/search?word=%@&pn=1&ps=15&dataModel=1&os=iphone&version=28",self.searchWord];
    NSString *encodeStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [SVProgressHUD showInfoWithStatus:@"正在加载数据..."];
    // 2 进行请求
    [manger GET:encodeStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       NSArray *dataArr = responseObject[@"videos"];
        self.dataArray = [ResultModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    
}


#pragma mark - 控制器进入的时候调用的方法
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypePresent];
}
#pragma mark - 控制器退出的时候调用的方法
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    return [FourPingTransition transitionWithTransitionType:XWPresentOneTransitionTypeDismiss];
}
#pragma mark - 退出
-(void)pop:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 返回按钮的点击
- (void)cancelBtnClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
