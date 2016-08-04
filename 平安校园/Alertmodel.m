//
//  Alertmodel.m
//  平安校园
//
//  Created by 中国孔 on 16/8/4.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "Alertmodel.h"
#import "UIImageView+WebCache.h"
@implementation Alertmodel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
//        self.title = dict[@"title"];
//        self.time = dict[@"time"];
//        self.img = dict[@"img"];
//        self.status = dict[@"status"];
        self.title = @"厕所漏水";
        self.time = @"16/08/04 ";
        self.img = dict[@"thumbnail"];
        self.status = @"已完工";
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];
}


@end
