//
//  ListVC.m
//  WallStreet
//
//  Created by qingyun on 16/4/20.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ListVC.h"
#import "MoreInfoVC.h"

@interface ListVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView; 

@property (nonatomic, strong) NSDictionary *infoDic;

@end

@implementation ListVC

static NSString *cellIdentifier = @"cell";
static NSString *headerIdentifier = @"header";

- (void)viewDidLoad {
    [super viewDidLoad];
    _infoDic = @{@"平":@"specials", @"安":@"most-read", @"校":@"editors-choice", @"园":@"us", @"建":@"china", @"设":@"europe", @"重":@"economy", @"在":@"markets", @"行":@"central-banks", @"动":@"research", @"盘中":@"MarketSummary"};
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width -200, 0, 200, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _infoDic.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *infoArr = _infoDic.allKeys;
    cell.textLabel.text = infoArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreInfoVC *info = [self.storyboard instantiateViewControllerWithIdentifier:@"MoreInfoVC"];
    NSString *key = _infoDic.allKeys[indexPath.row];
    info.channel = _infoDic[key];
    
    if (_dismissListVC) {
        _dismissListVC(info);
    }
}

@end
