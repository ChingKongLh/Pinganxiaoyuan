//
//  NoteMode.m
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NoteMode.h"

@implementation NoteMode

-(instancetype)initWithNotification:(NSDictionary *)dict{

    if (self = [super init]) {
        self.title = dict[@"title"];
        self.content = dict[@"thumbnail"];
        self.timer = dict[@"updateTime"];
        self.source = dict[@"source"];
    }
    return self;
}


+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];
}

@end
