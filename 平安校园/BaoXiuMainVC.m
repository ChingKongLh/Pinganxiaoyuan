//
//  BaoXiuMainVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/27.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "BaoXiuMainVC.h"

@interface BaoXiuMainVC ()
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UIView *view6;
@property (strong, nonatomic) IBOutlet UIView *view7;
@end

@implementation BaoXiuMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayerSettingWithBottom];
}
- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark ------- BottomView LayerSetting

-(void)LayerSettingWithBottom{
    //设置圆角
    _view1.layer.cornerRadius = 35;
    _view1.layer.shadowRadius = 20;
    _view1.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view1.layer.shadowOffset = CGSizeMake(2, 2);
    _view1.layer.borderWidth = 1;
    //边框背景色
    _view1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view2.layer.cornerRadius = 25;
    _view2.layer.shadowRadius = 20;
    _view2.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view2.layer.shadowOffset = CGSizeMake(2, 2);
    _view2.layer.borderWidth = 1;
    _view2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view3.layer.cornerRadius = 35;
    _view3.layer.shadowRadius = 20;
    _view3.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view3.layer.shadowOffset = CGSizeMake(2, 2);
    _view3.layer.borderWidth = 1;
    
    _view4.layer.cornerRadius = 30;
    _view4.layer.shadowRadius = 20;
    _view4.layer.shadowColor = [[UIColor orangeColor] CGColor];
    _view4.layer.shadowOffset = CGSizeMake(2, 2);
    _view4.layer.borderWidth = 1;
    _view4.layer.borderColor = [[UIColor orangeColor] CGColor];
    _view5.layer.shadowRadius = 20;
    _view5.layer.cornerRadius = 30;
    _view5.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view5.layer.shadowOffset = CGSizeMake(2, 2);
    _view5.layer.borderWidth = 1;
    _view5.layer.borderColor = [[UIColor blueColor] CGColor];

    _view6.layer.shadowRadius = 15;
    _view6.layer.cornerRadius = 25;
    _view6.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view6.layer.shadowOffset = CGSizeMake(2, 2);
    _view6.layer.borderWidth = 1;
    _view6.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view7.layer.cornerRadius = 25;
    _view7.layer.shadowRadius = 10;
    _view7.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view7.layer.shadowOffset = CGSizeMake(2, 2);
    _view7.layer.borderWidth = 1;
    _view7.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    
    
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
