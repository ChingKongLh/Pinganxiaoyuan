//
//  RightControlVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/30.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "RightControlVC.h"
#import "Common.h"
@interface RightControlVC ()
@property (nonatomic,strong)UITableView *tableview;

@end

@implementation RightControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.2 green:.5 blue:.9 alpha:1.0];



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
