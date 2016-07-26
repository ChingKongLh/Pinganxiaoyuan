//
//  MarketDetail.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MarketDetail.h"
#import "NSDateFormatter+StatusDate.h"
@implementation MarketDetail

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        self.icon = dict[@"thumbnail"];
        self.title = dict[@"title"];
        self.content = dict[@"id"];
//        self.CreatedAt = dict[@"updateTime"];
        
        NSString *dateString = dict[@"updateTime"];
        NSLog(@"%@",dateString);
        self.CreatedAt = [NSDateFormatter statusDateWithString:dateString];
        NSLog(@"--------------------------%@",self.CreatedAt);
//        self.CreatedAt = dateString;
    }
    return self;
}


-(NSString *)CreatetedWith{
    //计算时间差
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.CreatedAt];
    //小于60秒
    if (interval < 60) {
        return @"刚刚";
        //分钟
    }else if (interval < 60 * 60){
        return [NSString stringWithFormat:@"%d分钟前",(int)interval/60];
    //小时
    }else if (interval < 60 * 60 * 24){
        return [NSString stringWithFormat:@"%d小时前",(int)interval/60 * 60];
        //天前
    }else if (interval < 60 * 60 * 24 * 30){
        return [NSString stringWithFormat:@"%d天前",(int)interval/60 * 60 *24];
    }{
        //超过一个月显示发布时间
        return [NSDateFormatter localizedStringFromDate:self.CreatedAt dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
}





+(instancetype)initWithDictionary:(NSDictionary *)dict{

    return [[self alloc]initWithDictionary:dict];
}

@end
