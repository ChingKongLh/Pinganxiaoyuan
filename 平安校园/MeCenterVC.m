//
//  MeCenterVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MeCenterVC.h"

@interface MeCenterVC ()
@property (nonatomic)NSInteger tag;
@end
@implementation MeCenterVC

-(void)viewDidLoad {
   [super viewDidLoad];
    [self addScrollViewWithTable];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}


-(void)addScrollViewWithTable{

}





#pragma mark --------- TouBuShiXian -----------

- (IBAction)TitleBtn:(id)sender {
    switch (_tag) {
        case 101:
            //扫码
            
            break;
            case 102:
            //足迹
            
            break;
            case 103:
            //发现
            
            break;
            case 104:
            //未开放区
            
            break;
        default:
            break;
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
