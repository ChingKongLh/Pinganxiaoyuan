//
//  NSDateFormatter+StatusDate.m
//  WeiBo
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSDateFormatter+StatusDate.h"

@implementation NSDateFormatter (StatusDate)

+(NSDate *)statusDateWithString:(NSString *)dateString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"updateTime"];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

@end
