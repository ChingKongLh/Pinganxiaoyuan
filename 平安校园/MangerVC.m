//
//  MangerVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/23.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MangerVC.h"

@interface MangerVC ()

@end

@implementation MangerVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)back:(id)sender {
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
