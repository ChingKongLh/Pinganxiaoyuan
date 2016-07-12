//
//  MoreInfoVC.m
//  WallStreet
//
//  Created by qingyun on 16/4/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MoreInfoVC.h"

#import "AFHTTPSessionManager.h"

#import "MJRefresh.h"

@interface MoreInfoVC () 
@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) NSMutableArray *infoArr;

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation MoreInfoVC

static NSString *cellIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
  /*
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 100.f;
    [self.view addSubview:_tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnLeftBtn)];
    
//    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([InfoCellOne class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    _infoArr = [NSMutableArray array];
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        _pageIndex = 1;
        [self loadData];
    }];
    
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _pageIndex++;
        [self loadData];
    }];
    
    [_tableView.mj_header beginRefreshing];
   
   */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
/*
- (void)loadData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameter = @{@"channel":_channel,@"page":@(_pageIndex)};
    
    [manager GET:@"http://api.wallstreetcn.com/v2/mobile-articles?&device=android&accept=article&_eva_t=1461145954" parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultDict = (NSDictionary *)responseObject;
        NSArray *resultArr = resultDict[@"results"];
        
        [resultArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            InfoModel *model = [InfoModel modelWithDictionary:(NSDictionary *)obj];
            [_infoArr addObject:model];
        }];
        
        if ([_tableView.mj_header isRefreshing]) {
            [_tableView.mj_header endRefreshing];
        }
        if ([_tableView.mj_footer isRefreshing]) {
            [_tableView.mj_footer endRefreshing];
        }
        
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}
*/
#pragma mark - UITableViewDataSource

- (void)actionOnLeftBtn {
    [self.navigationController popViewControllerAnimated:NO];
}

@end
