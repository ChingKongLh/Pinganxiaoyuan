//
//  xinwenModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "xinwenModel.h"

@implementation xinwenModel

-(instancetype)initWithXinWenTableView:(NSDictionary *)dict{

    if (self = [super init]) {
        self.title = dict[@"title"];
        self.content = dict[@"id"];
        self.timeer = dict[@"updateTime"];
        self.img = dict[@"thumbnail"];
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
