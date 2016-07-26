//
//  MarketDetail.h
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarketDetail : NSObject
@property (nonatomic,strong)NSString *icon;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
@property (nonatomic,copy)NSDate *CreatedAt;
@property (nonatomic,strong)NSString *newlevel;
@property (nonatomic,strong)NSString *area;
@property (nonatomic,strong)NSString *telephone;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
