//
//  SecondMarketVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "SecondMarketVC.h"
#import "Common.h"
#import "MarketDetail.h"
#import "MarketView.h"
#import "AFNetworking.h"
@interface SecondMarketVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UILabel *label;

@property (nonatomic,strong)NSMutableArray *array;
@end
static NSString *identify = @"Cell";
@implementation SecondMarketVC

-(void)viewDidLoad{
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([MarketView class]) bundle:nil] forCellReuseIdentifier:identify];
    [self LoadRequestWithNeed];
    _label.text = @"今日首发";
    
}

#pragma mark ---------- Datasource Load

-(void)LoadRequestWithNeed{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    [manger GET:UrlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict1 = responseObject[0];
        NSArray *arr = dict1[@"item"];
        self.array = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            MarketDetail *model = [[MarketDetail alloc] initWithDictionary:dict];
            [self.array addObject:model];
        }
        //加载完成刷新UI
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark -------------TableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketView *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    MarketDetail *model = _array[indexPath.row];
    [cell setDetail:model];
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 150;
}


- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
