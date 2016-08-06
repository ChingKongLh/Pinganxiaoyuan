//
//  Listmodel.m
//  平安校园
//
//  Created by 中国孔 on 16/8/6.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "Listmodel.h"

@implementation Listmodel
-(instancetype)initWithDictionary:(NSDictionary *)dict{

    if (self == [super init]) {
//        self.imag = dict[@"thumbnail"];
//        self.title = dict[@"title"];
//        self.status = dict[@"status"];
//        self.paihang = dict[@"paihang"];
        self.imag = dict[@"thumbnail"];
        self.title = @"门坏";
        self.status = @"已完工";
        self.time = @"16/08/06";
        self.paihang = @"1";
    }
    return self;
}

+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];
}

@end
