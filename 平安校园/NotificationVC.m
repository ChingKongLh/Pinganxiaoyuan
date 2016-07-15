//
//  NotificationVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSArray *array;
@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"通知中心";
    
    _array = @[@"姓名",@"电话",@"服务类型",@"报修项目",@"服务区域",@"申报地址",@"详细地址",@"故障描述",@"预约时间",@"图片上传"];
        _tableview.delegate = self;
    _tableview.dataSource = self;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 NSString *identify = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    cell = _array[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
