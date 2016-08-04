//
//  Alertmodel.h
//  平安校园
//
//  Created by 中国孔 on 16/8/4.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alertmodel : NSObject
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *status;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
