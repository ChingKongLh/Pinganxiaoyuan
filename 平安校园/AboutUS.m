//
//  AboutUS.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "AboutUS.h"
#import "Account.h"
#import "SDImageCache.h"
#import "Common.h"
#import "LogIn.h"
@interface AboutUS ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSArray *cellTitles;

@end

@implementation AboutUS

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *leftbarbtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    self.navigationItem.leftBarButtonItem = leftbarbtn;
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
//    if ([[Account saveAccount]islogIn]) {
    self.cellTitles = @[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私与安全",@"通用设置"],@[@"意见反馈",@"清楚缓存",@"关于我们"],@[@"退出当前账号"]];
//    }else{
//        self.cellTitles = @[@[@"通用设置",@"关于我们"]];
//    }
}

//登录事件
-(void)login{
    
    LogIn *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self presentViewController:VC animated:YES completion:nil];
}



#pragma mark ------- TableviewDatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.cellTitles.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.cellTitles[section]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        //清楚缓存
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"account" forIndexPath:indexPath];
        cell.textLabel.text = self.cellTitles[indexPath.section][indexPath.row];
        NSInteger size = [[SDImageCache sharedImageCache] getSize];
        CGFloat sizeM = (CGFloat)size/1012/1024;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f",sizeM];
        return cell;
    }
    //如果是非登录状态 显示自定义常态化Cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountcell" forIndexPath:indexPath];
    cell.textLabel.text = self.cellTitles[indexPath.section][indexPath.row];
    
    //退出按钮设置，居中对齐字体颜色
    if (indexPath.section == 3) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.textColor = [UIColor orangeColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3 && indexPath.row == 1) {
        //确认清楚缓存操作
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清楚缓存" message:Nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[SDImageCache sharedImageCache]cleanDiskWithCompletionBlock:^{
                //清楚缓存刷新UI
                [self.tableview reloadData];
            }];
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [self dismissViewControllerAnimated:YES completion:nil];
    }if (indexPath.section == 3 && indexPath.row == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //点击取消模态返回视图
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //发出退出登录通知
            [[NSNotificationCenter defaultCenter] postNotificationName:kLogout object:nil];
            //退出登录当前控制器模态消失 YES代表 有动画
            [self.navigationController popViewControllerAnimated:YES];
            [[Account saveAccount] logout];
        }];
        [alert addAction:action2];
        [alert addAction:action1];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

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
