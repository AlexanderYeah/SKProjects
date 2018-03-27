//
//  BoxNBViewController.m
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "BoxNBViewController.h"
#import "BoxOfficeTableViewCell.h"
#import "MonthBoxModel.h"
@interface BoxNBViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation BoxNBViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray = [NSMutableArray array];
    [self requestDataFromNet];
    
}

#pragma mark - 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 104)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 135;
    [self.view addSubview:_tableView];
    
}



#pragma mark - tableViewData Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"newsCell";
    BoxOfficeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BoxOfficeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    MonthBoxModel *model = self.dataArray[indexPath.row];
    [cell setMonthModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 网络请求数据
- (void)requestDataFromNet
{   // 提示用户
    [SVProgressHUD showInfoWithStatus:@"正在拼命加载数据"];
    [SVProgressHUD setMinimumDismissTimeInterval:100];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    
    NSString *strUrl = [self getNetUrk];
    // 2 进行请求
    [manger GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"showapi_res_body"];
        NSArray *dataArr =  dic[@"datalist"];
        self.dataArray = [MonthBoxModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}

#pragma mark -  处理网络请求字符串
- (NSString *)getNetUrk
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    NSString *netStr = [NSString stringWithFormat:@"https://route.showapi.com/578-4?showapi_appid=24123&showapi_timestamp=%@&showapi_sign=fa05402db54e46ec91e2847fa506a34c",dateStr];
    return netStr;
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
