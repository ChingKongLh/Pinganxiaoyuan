//
//  NewsVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NewsVC.h"
#import "AnimationTextField.h"
@interface NewsVC ()
@end
@implementation NewsVC

- (void)viewDidLoad {
  [super viewDidLoad];
    self.navigationItem.title = @"新闻公告";
    CGFloat TextX = 100;
    CGFloat TextY = 80;
    CGFloat TextW = self.view.frame.size.width - 80;
    CGFloat TextH = 100;
    NSArray *placeHolderArr = @[@"用户名",@"密码",@"就是这样",@"动画效果",@"我还有一点",@"继续加吧"];
    NSArray *textColorArr = @[[UIColor redColor],[UIColor purpleColor],[UIColor brownColor],[UIColor lightGrayColor],[UIColor greenColor],[UIColor yellowColor]];
    NSArray *animArr = @[@(AnimationFieldTypeShake),
                         @(AnimationFieldTypeBound),
                         @(AnimationFieldTypeUp),
                         @(AnimationFieldTypeShake),
                         @(AnimationFieldTypeBound),
                         @(AnimationFieldTypeUp)];
    for (int i = 0; i < 6; i++) {
        AnimationTextField *customField = [[AnimationTextField alloc]initWithFrame:CGRectMake(TextX, TextY + i*(TextH), TextW ,TextH)];
        customField.placeholderFont = [UIFont systemFontOfSize:15];
        customField.placeStr = placeHolderArr[i];
        customField.placeholderColor = [self getRandomColor];
        customField.textColor = textColorArr[i];
        customField.animationType = (AnimationFieldType)[animArr[i] integerValue];
        customField.tag = i + 10;
        [self.view addSubview:customField];
    }
}

-(UIColor *)getRandomColor{
    CGFloat r = (arc4random()%255)/255.0;
    CGFloat g = (arc4random()%255)/255.0;
    CGFloat b = (arc4random()%255)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
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
