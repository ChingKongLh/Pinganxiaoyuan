//
//  NewsVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NewsVC.h"
#import "MainVC.h"
@interface NewsVC ()
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@end
@implementation NewsVC

- (void)viewDidLoad {
  [super viewDidLoad];
}



- (IBAction)back:(UIBarButtonItem *)sender {
    MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
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
