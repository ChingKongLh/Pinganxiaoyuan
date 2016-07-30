//
//  RightControlVC.h
//  平安校园
//
//  Created by 中国孔 on 16/7/30.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MoreInfoVC;
@interface RightControlVC : UIViewController
@property (nonatomic, strong) void(^dismissListVC)(MoreInfoVC *);

@end
