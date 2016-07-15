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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    _array = @[@[@"姓名",@"电话"],@[@"服务类型",@"报修项目",@"服务区域",@"申报地址",@"详细地址",@"故障描述",@"预约时间",@"图片上传"]];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
}

-(void)back{

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return _array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array[section] count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 || indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me" forIndexPath:indexPath];
        cell.textLabel.text = self.array[indexPath.section][indexPath.row];
        return cell;
    }else if (indexPath.section == 0 || indexPath.row == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me" forIndexPath:indexPath];
        cell.textLabel.text = self.array[indexPath.section][indexPath.row];
        return cell;
    }else if (indexPath.section == 1 || indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom" forIndexPath:indexPath];
        cell.textLabel.text = self.array[indexPath.section][indexPath.row];
        return cell;
    }else if (indexPath.section == 1 || indexPath.row == 1){
    
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom" forIndexPath:indexPath];
        cell.textLabel.text = self.array[indexPath.section][indexPath.row];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bottom" forIndexPath:indexPath];
    cell.textLabel.text = self.array[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
