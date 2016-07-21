//
//  MeCentraModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/21.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MeCentraModel.h"

@implementation MeCentraModel

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


+(instancetype)appModelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}

@end
