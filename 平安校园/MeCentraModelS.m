//
//  MeCentraModelS.m
//  平安校园
//
//  Created by 中国孔 on 16/7/22.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MeCentraModelS.h"

@implementation MeCentraModelS
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.detailTitle = dict[@"detailTitle"];
        self.icon = dict[@"icon"];
//        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)appModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
