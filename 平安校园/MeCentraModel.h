//
//  MeCentraModel.h
//  平安校园
//
//  Created by 中国孔 on 16/7/21.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeCentraModel : NSObject
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detailTitle;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)appModelWithDictionary:(NSDictionary *)dict;

@end
