//
//  ServiceModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/26.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.img = dict[@"img"];
        self.title = dict[@"tiitle"];
        self.time = dict[@"time"];
    }
    return self;
}

+(instancetype)initServiceWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
