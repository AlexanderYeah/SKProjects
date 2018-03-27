//
//  WillShowViewController.m
//  影讯百科
//
//  Created by Alexander on 16/9/2.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "WillShowViewController.h"
#import "WillShowTableViewCell.h"
#import "WillShowModel.h"
#import "MovieDetailViewController.h"
@interface WillShowViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
/** 标题数据*/
@property (nonatomic,strong)NSMutableArray *titleArray;
/** 数组字典*/
@property (nonatomic,strong)NSMutableDictionary *dataDictionary;

@end

@implementation WillShowViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"即将上映";
    _titleArray = [[NSMutableArray alloc]initWithCapacity:0];
    _dataDictionary = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createLeftNavButton];
    [self requestDataFromNet];
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


#pragma mark - 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = kScreenH * 0.22 + 12;
    _tableView.sectionHeaderHeight = 30;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark - tableViewData Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取出模型数组
    NSString *str = [NSString stringWithFormat:@"%ld",section];
    NSArray *array = [_dataDictionary objectForKey:str];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"newsCell";
    WillShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WillShowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.backgroundColor = kRGBColor(248, 248, 242);
    // 取出模型 设置数据
    // 取出模型数组
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
    NSArray *array = [_dataDictionary objectForKey:str];
    WillShowModel *model = array[indexPath.row];
    [cell setModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 背景View
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, kScreenW - 20, 30)];
    label.textColor = [UIColor orangeColor];
    label.text = self.titleArray[section];
    [bgView addSubview:label];
    
    return bgView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取出模型数组
    NSString *str = [NSString stringWithFormat:@"%ld",indexPath.section];
    NSArray *array = [_dataDictionary objectForKey:str];
    WillShowModel *model = array[indexPath.row];
    NSString *detailUrl =  [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/movie/v5/%@.json",[model.id stringValue]];
    NSURL *imgUrl = [self dealWithUrlStr:model.img width:280 height:280];
    
    MovieDetailViewController *detailVC = [[MovieDetailViewController alloc]initWithFaceUrl:imgUrl detailUrl:detailUrl movieTitle:model.nm movieID:[model.id stringValue]];
    detailVC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:detailVC animated:YES];

}


#pragma mark - 网络请求数据
- (void)requestDataFromNet
{   // 提示用户
    [SVProgressHUD showInfoWithStatus:@"正在拼命加载数据"];
    [SVProgressHUD setMinimumDismissTimeInterval:100];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://api.maoyan.com/mmdb/movie/v1/list/coming.json?ct=%E4%B8%8A%E6%B5%B7";
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *hotArr = dic[@"coming"];
        // hotArr 的数量就是 section 的数量
        for (int i = 0; i < hotArr.count; i ++) {
            NSDictionary *dic1 = hotArr[i];
            // 将内容存入模型
            NSArray *movies = dic1[@"movies"];
            NSArray *moviesModelArray = [WillShowModel mj_objectArrayWithKeyValuesArray:movies];
            // 将对应的模型按照section 装入到字典中，以便进行取
            [_dataDictionary setObject:moviesModelArray forKey:[NSString stringWithFormat:@"%d",i]];
             [_titleArray addObject:dic1[@"title"]];
        }
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
}



#pragma mark - 点击事件
#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 图片网址处理函数
- (NSURL *)dealWithUrlStr:(NSString *)str width:(CGFloat)imgWidth height:(CGFloat)imgHeight
{
    NSArray *componentArr = [str componentsSeparatedByString:@"/"];
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:componentArr];
    
    [tempArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%.0f.%.0f",imgWidth,imgHeight]];
    
    NSString *resulturl = [tempArr componentsJoinedByString:@"/"];
    NSURL *url = [NSURL URLWithString:resulturl];
    return url;
    
}



@end
