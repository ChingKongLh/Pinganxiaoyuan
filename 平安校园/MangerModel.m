//
//  MangerModel.m
//  平安校园
//
//  Created by 中国孔 on 16/7/23.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MangerModel.h"

@implementation MangerModel

-(instancetype)initWithMangerModel:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)initWithDoctionary:(NSDictionary *)dict{

    return [[self alloc] initWithDictionary:dict];
}

@end
