//
//  MainM.m
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MainM.h"

@implementation MainM

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.ids = dict[@"ids"];
        self.imageid = dict[@"imageid"];
        self.name = dict[@"name"];
    }
    return self;
}


+(instancetype)modelWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];

}
@end
