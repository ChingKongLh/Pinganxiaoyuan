//
//  MainM.h
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainM : NSObject

@property (nonatomic,strong)NSString *ids;
@property (nonatomic,strong)NSString *imageid;
@property (nonatomic,strong)NSString *name;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
