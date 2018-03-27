//
//  CommentViewController.m
//  影讯百科
//
//  Created by g1game on 16/9/13.
//  Copyright © 2016年 AlexanderYe. All rights reserved.
//

#import "CommentViewController.h"
#import "DetailFirstTableViewCell.h"
#import "CommentFirstModel.h"
#import "DetailSecondTableViewCell.h"
#import "CommentDetailViewController.h"
#import "CMuneBar.h"
#import "SKShareManager.h"
#import "SKDataBaseManger.h"
@interface CommentViewController ()<UITableViewDataSource,UITableViewDelegate,CMuneBarDelegate>
/** tableView */
@property (nonatomic,strong)UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;
/** 第一个cell的数据 */
@property (nonatomic,strong)NSDictionary *firstCellDic;
/** 按钮 菜单*/
@property(nonatomic,weak)CMuneBar *muneBar;

/** 按钮 菜单*/
@property(nonatomic,weak)CMuneBar *currentMenuBar;

/** 分享链接 */
@property (nonatomic,strong)NSString *shareUrlStr;

/** 电影名 */
@property (nonatomic,strong)NSString *movieName;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"详情/影评";
    _firstCellDic = [NSDictionary dictionary];
    
    [self requestDataFromNet];
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
    // 创建数据库,将分享数据存入数据库
    NSString *movieName = _firstCellDic[@"title"];
    NSString *movieStr = _firstCellDic[@"alt"];
    NSDictionary *dic = _firstCellDic[@"images"];
    NSString *faceStr = dic[@"medium"];
    SKDataBaseManger *mgr = [SKDataBaseManger shareManger];
    [mgr insertName:movieName withFaceStr:faceStr withMovieStr:movieStr];
    
    switch (index) {
        case 3: // 朋友圈
        {   // 1 分享
            [manager wechatShareWithViewController:self withShareText:@"" withShareUrl:self.shareUrlStr];
        }
           break;
        case 2: // 微信
        {
            [manager timelineShareWithViewController:self withShareText:@"" withShareUrl:self.shareUrlStr];
        }
            break;
        case 1:// 短信
        {
            [manager messageShareWithViewController:self withShareText:@"" withShareUrl:self.shareUrlStr];
        }
            break;
        case 0: // 邮件
        {
            [manager emailShareWithViewController:self withShareText:@"" withShareUrl:self.shareUrlStr];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 创建tableview
- (void)createTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, kScreenH)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //Call this Block When enter the refresh status automatically
        [self reloadMoreData];
    }];
    [self.view addSubview:_tableView];
    [self createShareBtn];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    static NSString *ID2 = @"cell2";
    DetailFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    DetailSecondTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:ID2];
    if (cell == nil) {
        cell = [[DetailFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (cell2 == nil) {
        cell2 = [[DetailSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID2];
    }
    if (indexPath.row == 0) {
        [cell setCellDic:self.firstCellDic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.userInteractionEnabled = YES;
        return cell;
    }else{
        // 取出模型
        CommentFirstModel *model = self.dataArray[indexPath.row - 1];
        [cell2 setModel:model];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell2;
    }
    // 取出模型
    
   
    return cell;
}
// cell height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return kScreenH * 0.2;
    }else{
        
        return kScreenH * 0.17 + 20;
    }
}


// cell click
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }else{
        CommentFirstModel *model = self.dataArray[indexPath.row - 1];
        NSURL *shareUrl = [NSURL URLWithString:model.share_url];
        NSString *shareStr = model.share_url;
        CommentDetailViewController *detailVC = [[CommentDetailViewController alloc]init];
        detailVC.shareUrlStr = shareStr;
        detailVC.shareUrl = shareUrl;
        detailVC.shareTitle = [NSString stringWithFormat:@"<<%@>>影评",_movieName];
        detailVC.movieName = model.title;
        detailVC.summary = model.summary;
        NSDictionary *dic = model.author;
        detailVC.author = dic[@"name"];
        [self.navigationController pushViewController:detailVC animated:YES];
    }

}
#pragma mark - 返回按钮的点击事件
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 请求演员详情列表数据
- (void)requestDataFromNet
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@/reviews?apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=10",self.movieID];
    [SVProgressHUD showInfoWithStatus:@"正在加载数据..."];
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _firstCellDic = responseObject[@"subject"];
        NSArray *dataArr = responseObject[@"reviews"];
        _shareUrlStr = _firstCellDic[@"alt"];
        _movieName = _firstCellDic[@"title"];
        self.dataArray = [CommentFirstModel mj_objectArrayWithKeyValuesArray:dataArr];
        [SVProgressHUD dismiss];
        [self createTableView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络"];
    }];
    
}


#pragma mark - 下拉刷新数据
- (void)refreshData
{
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@/reviews?apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=10",self.movieID];
     // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _firstCellDic = responseObject[@"subject"];
        NSArray *dataArr = responseObject[@"reviews"];
        self.dataArray = [CommentFirstModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - 上拉刷新数据 
- (void)reloadMoreData
{
    static int page = 10;
    // 1 创建网络请求对象
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSString *urlStr = [NSString stringWithFormat:@"http://api.douban.com/v2/movie/subject/%@/reviews?apikey=0df993c66c0c636e29ecbb5344252a4a&start=0&count=%d",self.movieID,page];
    // 2 进行请求
    [manger GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        _firstCellDic = responseObject[@"subject"];
        NSArray *dataArr = responseObject[@"reviews"];
        self.dataArray = [CommentFirstModel mj_objectArrayWithKeyValuesArray:dataArr];
        [self.tableView reloadData];
        page += 20;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    [self.tableView.mj_footer endRefreshing];
   
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self.view];
    if (_muneBar.frame.origin.x <= touchPoint.x && touchPoint.x <= _muneBar.frame.origin.x + _muneBar.frame.size.width && _muneBar.frame.origin.y <= touchPoint.y && touchPoint.y <= _muneBar.frame.origin.y + _muneBar.frame.size.height ) {
        _currentMenuBar = _muneBar;
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 做一个四边边界判断，
    /**
     *  上边界：64
     下边界：KScreenH - 64
     左边界：0
     右边界：KScreen - 宽度
     */
    
    CGPoint endPoint = [[touches anyObject] locationInView:self.view];
    // bug 当在左边界或者右边界的时候，可能会造成上下越界
    if (endPoint.x < 45) {
        endPoint.x = 45;
        
        if (endPoint.y > kScreenH - 44) {
            endPoint.y = kScreenH - 104;
        }else if (endPoint.y < 70){
            endPoint.y = 75 + 40;
        }else{
        }
    }else if (endPoint.x > kScreenW - 45){
        endPoint.x = kScreenW - 45;
        if (endPoint.y > kScreenH - 44) {
            endPoint.y = kScreenH - 104;
        }else if (endPoint.y < 70){
            endPoint.y = 75 + 40;
        }else{
        }
        
    }else if (endPoint.y < 70){
        endPoint.y = 75 + 40;
        
    }else if (endPoint.y > kScreenH - 44 ){
        
        endPoint.y = kScreenH - 104;
    }else{
        endPoint = endPoint;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _currentMenuBar.center = endPoint;
        
    }];
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
