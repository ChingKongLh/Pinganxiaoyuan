//
//  NSDateFormatter+StatusDate.h
//  WeiBo
//
//  Created by qingyun on 16/4/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (StatusDate)
//将字符串解析为时间
+(NSDate *)statusDateWithString:(NSString *)dateString;
@end
