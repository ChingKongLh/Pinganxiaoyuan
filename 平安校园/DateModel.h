//
//  DateModel.h
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject
@property (nonatomic,strong)NSString *year;
@property (nonatomic,strong)NSArray *month;
@property (nonatomic,strong)NSString *date;
@property (nonatomic,assign)BOOL islength;

-(DateModel *)initWithDictionary:(NSDictionary *)dict;
+(DateModel *)statusWithDictionary:(NSDictionary *)dict;

@end
