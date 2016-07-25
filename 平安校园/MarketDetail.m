//
//  MarketDetail.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MarketDetail.h"

@implementation MarketDetail

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.label = dict[@"label"];
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];
}

@end
