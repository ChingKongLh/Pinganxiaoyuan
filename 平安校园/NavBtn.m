//
//  NavBtn.m
//  Xiongdidiaoyu
//
//  Created by zhouy on 15/11/26.
//  Copyright (c) 2015年 Vector. All rights reserved.
//

#import "NavBtn.h"

@implementation NavBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (UIButton *)navBtn{
    //定位图标
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    backBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    return backBtn;
}
+ (UIBarButtonItem *)spaceItem{
    
    UIBarButtonItem *spaceItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        spaceItem.width=-2;
    }else{
        spaceItem.width=0;
    }
    
    return spaceItem;
}

@end
