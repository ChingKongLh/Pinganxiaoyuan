//
//  NotificationVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NotificationVC.h"
#import "MainVC.h"
#import "NoteMode.h"
#import "NoteView.h"
#import "AFNetworking.h"
#import "Common.h"
@interface NotificationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *responsearray;
@property (nonatomic)NSInteger currentpage;
@property (nonatomic,strong)UIWebView *webview;
@end
static NSString *identify = @"cell";
@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.2 green:.5 blue:.9 alpha:1.0];
    [self.tableview registerNib:[UINib nibWithNibName:NSStringFromClass([NoteView class]) bundle:nil] forCellReuseIdentifier:@"notification"];
    [self loadNotificationWithRequest];
}

- (IBAction)back:(id)sender {
    MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
}



#pragma mark --- netRequest

-(void)loadNotificationWithRequest{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.responseSerializer = [AFJSONResponseSerializer serializer];
    NSDictionary *parame = @{@"page":@(_currentpage)};
    [manger POST:xiwenUrlStr parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict1 = responseObject[0];
        NSArray *array = dict1[@"item"];
        self.responsearray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            NoteMode *model = [[NoteMode alloc] initWithNotification:dict];
            [self.responsearray addObject:model];
        }
        [_tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //加载出错信息提示
        NSString *html = [NSString stringWithFormat:@"<body><marson><h1>加载有误，请检查网络设置！<h1/></marson></body>"];
        [_webview loadHTMLString:html baseURL:nil];
    }];
}



#pragma mark ------tableview datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.responsearray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoteView *cell = [tableView dequeueReusableCellWithIdentifier:@"notification" forIndexPath:indexPath];
    NoteMode *model = _responsearray[indexPath.row];
    [cell setModel:model];
    return cell;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
