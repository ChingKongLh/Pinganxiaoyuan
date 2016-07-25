//
//  DateModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "DateModel.h"

@implementation DateModel
- (DateModel * )initWithDictionary:(NSDictionary *)dic
{
    if (self  = [super init]) {
        _year=dic[@"year"];
        _month=dic[@"month"];
        if ([dic[@"status"]isEqualToString:@"0"] ) {
            _islength=NO;
        }
        else{
            _islength=YES;
        }
    }
    return self;
}


+ (DateModel *)statusWithDictionary:(NSDictionary *)dic
{
    
    DateModel * status = [[DateModel alloc]initWithDictionary:dic];
    return status;
}

@end
