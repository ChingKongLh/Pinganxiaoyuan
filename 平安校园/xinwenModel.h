//
//  xinwenModel.h
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface xinwenModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSDate *time;

-(instancetype)initWithXinWenTableView:(NSDictionary *)dict;
+(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
