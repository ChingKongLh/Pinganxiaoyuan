//
//  LeftVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "LeftVC.h"

@interface LeftVC ()
@property (nonatomic,strong)UITableView *leftTable;

@end

@implementation LeftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browser_previous@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(PushTableOnClick)];
}

-(void)PushTableOnClick{
    [self.navigationController popToRootViewControllerAnimated:NO];
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
