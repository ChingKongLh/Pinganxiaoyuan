//
//  NewsVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NewsVC.h"
#import "MainVC.h"
#import "AFNetworking.h"
#import "xinwenModel.h"
#import "xinwenCell.h"
#import "Common.h"
#import "MJRefresh.h"
@interface NewsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *responsearray;
@property (nonatomic)NSInteger currentpage;
@property (nonatomic)NSInteger totalPages;
@property (nonatomic) BOOL isOn;
@end
@implementation NewsVC

- (void)viewDidLoad {
  [super viewDidLoad];
    _isOn= NO;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.2 green:.5 blue:.9 alpha:1.0];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([xinwenCell class]) bundle:nil] forCellReuseIdentifier:@"xinwen"];
    [self networkRequest];
    
    //加载刷新方法
    self.tableview.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRelease)];
    self.tableview.mj_footer= [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    //首页加载时开始刷新
    [self.tableview.mj_header beginRefreshing];
    
}

-(void)loadMore{
    
    _isOn = YES;
//    [self networkRequest];
}

-(void)loadRelease{
    _isOn = NO;
    [self networkRequest];
}


#pragma mark -----loadRequest-----


-(void)networkRequest{

    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *params = @{@"page":@(_currentpage)};
    [manger GET:xiwenUrlStr parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict1 = responseObject[0];
         _totalPages = [dict1[@"totalPage"] intValue];
        NSArray *arr = dict1[@"item"];
        self.responsearray = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            xinwenModel *model = [[xinwenModel alloc] initWithXinWenTableView:dict];
            [self.responsearray addObject:model];
            
            //加载完毕结束刷新
            [self.tableview.mj_header endRefreshing];
            [self.tableview.mj_footer endRefreshing];
        }
//        if (_isOn == YES) {
//            if (_currentpage < _totalPages) {
//                _currentpage++;
//                
//            }else{
//                [_tableview.mj_footer endRefreshingWithNoMoreData];
//                
//                _currentpage = 1;
//                
//            }
//        }else{
//            if (_currentpage >1) {
//                _currentpage--;
//            }
//        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


#pragma mark   ------- tableviewDelegate-------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.responsearray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   xinwenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"xinwen" forIndexPath:indexPath];
    xinwenModel *model = _responsearray[indexPath.row];
    [cell setModel:model];
    return cell;
}


- (IBAction)back:(UIBarButtonItem *)sender {
    MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
        return 110;
    }else if (kDevice_Is_iPhone6){
    
        return 120;
    }else{
    
        return 130;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    WebViewControl *webview = [self.storyboard instantiateViewControllerWithIdentifier:@"web"];
//    
//    webview.urlstring = [_responsearray[indexPath.row] urlId];
//    
//    [self.navigationController pushViewController:webview animated:YES];
    
}



-(void)didReceiveMemoryWarning {
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
