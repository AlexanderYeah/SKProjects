//
//  ActorDetailViewController.m
//  影讯百科
//
//  Created by Alexander on 16/8/30.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "ActorDetailViewController.h"
#import "ActorDetailView.h"
#import "ActorModel.h"
#import "ActorMovieModel.h"
#import "ActorDetailTableViewCell.h"
#import "MovieDetailViewController.h"
@interface ActorDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** 模型 */
@property (nonatomic,strong)ActorModel *model;
/** 个人描述信息 */
@property (nonatomic,strong)UILabel *actorInfoLbl;
/** 滚动视图*/
@property (nonatomic,strong)UIScrollView *photoScrollView;
/** 头部视图 */
@property (nonatomic,strong)UILabel *headerLbl;
/** 演员作品数组 */
@property (nonatomic,strong)NSMutableArray *actorMovieArray;

@end

@implementation ActorDetailViewController

-(instancetype)initWithID:(NSString *)ID
{
    if (self = [super init]) {
        _ID = ID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _actorMovieArray = [NSMutableArray array];
    self.navigationItem.title = @"个人资料";
    [self requestDataFromNet];
}

#pragma mark - 创建tableView
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}


#pragma mark -  个人描述
- (void)createActorInfoLabelWith:(UITableViewCell *)cell
{
    // 剧情描述
    UILabel *infoLbl = [self createLblWithTitle:@"个人描述:" fontSize:16.0f textColor:[UIColor blackColor]];
    infoLbl.frame = CGRectMake(10, 5, kScreenW, 20);
    [cell.contentView addSubview:infoLbl];
    CGRect rect = [self.model.desc boundingRectWithSize:CGSizeMake(kScreenW - 16, kScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:16.0f]} context:nil];
    _actorInfoLbl = [[UILabel alloc]init];
    _actorInfoLbl.numberOfLines = 0;
    _actorInfoLbl.text = self.model.desc;
    _actorInfoLbl.font = [UIFont systemFontOfSize:16.0f];
    _actorInfoLbl.lineBreakMode = NSLineBreakByWordWrapping;
    _actorInfoLbl.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [cell.contentView addSubview:_actorInfoLbl];
    [_actorInfoLbl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.top).offset(20);
        make.left.equalTo(cell.left).offset(8);
        make.width.equalTo(kScreenW - 16);
        make.height.equalTo(rect.size.height * 2);
    }];
}

#pragma mark -  个人照片
- (void)createMoviePhotoScrollWith:(UITableViewCell *)cell
{
    UILabel *label = [self createLblWithTitle:@"个人照片:" fontSize:16.0f textColor:[UIColor blackColor]];
    label.frame = CGRectMake(15, 5, kScreenW, 20);
    [cell.contentView addSubview:label];
    // 1 创建滚动视图
    CGFloat photoWidth = 100;
    CGFloat photoHeight = 100;
    CGFloat padding = 10;
    _photoScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 25, kScreenW, 140)];
    _photoScrollView.delegate = self;
    for (int i = 0; i <self.model.photos.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding + photoWidth * i + padding * i, 0, photoWidth, photoHeight)];
        imageView.layer.cornerRadius = 5;
        NSURL *imgUrl =  [self dealWithUrlStr:self.model.photos[i] width:280 height:280];
        [imageView sd_setImageWithURL:imgUrl];
        
        [_photoScrollView addSubview:imageView];
        
    }
    _photoScrollView.contentSize = CGSizeMake(self.model.photos.count * (padding + photoWidth), 0);
    [cell.contentView addSubview:_photoScrollView];
    
}

#pragma mark - tableView Delegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
        return self.actorMovieArray.count;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *firstID = @"firstCell";
    static NSString *secondID = @"secondCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:firstID];
    ActorDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:secondID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstID];
    }
    if (detailCell == nil) {
        detailCell = [[ActorDetailTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondID];
    }
    if (indexPath.row == 0 && indexPath.section == 0) {
        ActorDetailView *actorView = [[ActorDetailView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 200)];
        [actorView setModel:self.model];
        [cell.contentView addSubview:actorView];
        return cell;
    }else if (indexPath.row == 1 && indexPath.section == 0){
        [self createActorInfoLabelWith:cell];
        return cell;
    }else if (indexPath.row == 2 && indexPath.section == 0){
        [self createMoviePhotoScrollWith:cell];
        return cell;
    }else{
        
        ActorMovieModel *model = self.actorMovieArray[indexPath.row];
        [detailCell setModel:model];
        return detailCell;
    }
   
}

// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 根据个人描述计算cell 的高度
    CGRect rect = [self.model.desc boundingRectWithSize:CGSizeMake(kScreenW - 20, kScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSForegroundColorAttributeName:[UIFont systemFontOfSize:14.0f]} context:nil];

    
    if (indexPath.row == 0 && indexPath.section == 0) {
        return kScreenH * 0.3;
    }else if (indexPath.row == 1 && indexPath.section == 0){
        return rect.size.height * 2 + 25;
    }else if (indexPath.row == 2 && indexPath.section == 0){
        return 160;
    }else{
        return kScreenH / 5;
    }
}

// headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.headerLbl = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, kScreenW - 25, 25)];
    self.headerLbl.text = [NSString stringWithFormat:@"个人作品共%ld部",self.actorMovieArray.count];
    self.headerLbl.backgroundColor = [UIColor whiteColor];
    if (section == 1) {
        return self.headerLbl;
    }
    return nil;
}

// headerHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 25;
    }
}

#pragma mark - 网络请求数据
- (void)requestDataFromNet
{   // 提示用户
    [SVProgressHUD showInfoWithStatus:@"正在拼命加载数据"];
    [SVProgressHUD setMinimumDismissTimeInterval:100];
    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/celebrity/%@.json",self.ID];
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        self.model = [ActorModel mj_objectWithKeyValues:dic];
        [SVProgressHUD dismiss];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
    }];
    
    
    // 请求演员作品数据
    NSString *actorMovieStr = [NSString stringWithFormat:@"http://api.maoyan.com/mmdb/v6/celebrity/%@/movies.json?limit=100&offset=0",self.ID];
    // 2 进行请求
    [manger GET:actorMovieStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = responseObject[@"data"];
        NSArray *dataArray = dic[@"movies"];
        self.actorMovieArray = [ActorMovieModel mj_objectArrayWithKeyValuesArray:dataArray];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];

}

#pragma mark - 创建label
- (UILabel *)createLblWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)color
{
    UILabel *lable = [[UILabel alloc]init];
    lable.text = title;
    lable.textColor = color;
    lable.font = [UIFont systemFontOfSize:size];
    
    return lable;
    
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




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
