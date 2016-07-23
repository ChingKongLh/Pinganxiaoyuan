//
//  MangerModel.h
//  平安校园
//
//  Created by 中国孔 on 16/7/23.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MangerModel : NSObject
@property (nonatomic,strong) NSString *titile;
@property (nonatomic,strong) NSString *detailTitle;
@property (nonatomic,strong) NSString *icon;

-(instancetype)initWithMangerModel:(NSDictionary *)dict;
+(instancetype)initWithDoctionary:(NSDictionary *)dict;

@end
