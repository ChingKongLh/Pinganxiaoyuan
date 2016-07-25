//
//  MarketModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MarketModel.h"

@implementation MarketModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.desc = dict[@"desc"];
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end

