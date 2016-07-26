//
//  ServiceModel.h
//  平安校园
//
//  Created by 中国孔 on 16/7/26.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceModel : NSObject

@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *time;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)initServiceWithDictionary:(NSDictionary *)dict;

@end
