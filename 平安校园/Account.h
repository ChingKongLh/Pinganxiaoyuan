//
//  Account.h
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>

+(instancetype)saveAccount;

-(void)saveLogIn:(NSDictionary *)dict;

-(BOOL)islogIn;

-(NSMutableDictionary *)requestParames;

-(void)logout;

@end
