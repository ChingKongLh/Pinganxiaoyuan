//
//  Listmodel.h
//  平安校园
//
//  Created by 中国孔 on 16/8/6.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Listmodel : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *imag;
@property (nonatomic,strong)NSString *status;
@property (nonatomic,strong)NSString *paihang;
@property (nonatomic,strong)NSString *time;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
