//
//  GrowWithLine.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "GrowWithLine.h"
#import "TimeLineModel.h"
#import "TimeLineView.h"
#import "MJExtension.h"
#import "Common.h"
#import "TimelineCell.h"
@interface GrowWithLine ()<timeviewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_timelineTaableview;
    NSMutableArray *_dataArray;
}

@end

@implementation GrowWithLine

- (void)viewDidLoad {
    [super viewDidLoad];
    _timelineTaableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, ScreenW, ScreenH)];
    _timelineTaableview.dataSource = self;
    _timelineTaableview.delegate = self;
    _timelineTaableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _timelineTaableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_timelineTaableview];
    
    [self addTimeView];
    [self TestLine];
}




-(void)addTimeView{
    NSArray *array = @[@"昨天",@"今天",@"明天"];
    TimeLineView *view = [[TimeLineView alloc] initWithDataArray:array];
    view.delegate = self;
    [self.view addSubview:view];
}


-(void)timeStr:(NSString *)Str{

    NSLog(@"点击时光轴");
    
}

#pragma mark ----- Tbaleview Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TimelineCell *cell = [TimelineCell CellWithTableview:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TimeLineModel *model = [_dataArray objectAtIndex:indexPath.row];
    cell.timeline = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 250;
}


//测试时产生数据实际应用时需要从服务器返回数据

-(void)TestLine{
    NSArray *test = @[@"1",@"2",@"3",@"4",@"5"];
    _dataArray = [NSMutableArray array];
    [test enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TimeLineModel *dataModel=[[TimeLineModel alloc]init];
        dataModel.timeStr=test[idx];
        [_dataArray addObject:dataModel];
    }];
}


- (IBAction)back:(UIBarButtonItem *)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
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
