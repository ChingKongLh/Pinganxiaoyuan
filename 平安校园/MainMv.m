//
//  MainMv.m
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MainMv.h"
#import "MainM.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "TiaoSuVC.h"
@interface MainMv ()
@end
@implementation MainMv


- (IBAction)TuiSu:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
          [self addTiaoSuVC];
            break;
            case 102:

            break;
            case 103:
            
            break;
            case 104:
            
            break;
        default:
            break;
    }
}

-(void)addTiaoSuVC{

    
}


- (void)awakeFromNib {
    
}

@end
