//
//  Models.h
//  Car
//
//  Created by Max on 16/5/7.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Models : NSObject
@property (nonatomic,strong)NSArray *carName;
@property (nonatomic,strong)NSArray *starName;
@property (nonatomic,strong)NSArray *finiName;
@property (nonatomic,strong)NSArray *pathwayName;


+(NSArray *)starData;
+(NSArray *)finiData;
+(NSArray *)demoData;
+(NSArray *)pathwayData;
@end
