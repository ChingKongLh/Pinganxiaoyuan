//
//  Account.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "Account.h"

#define accountFile @"filePath"
@interface Account ()

@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *password;
@property (nonatomic)NSDate *expires;

@end
@implementation Account

+(instancetype)saveAccount{
    static Account *account;
    static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
       NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
       NSString *filepath = [path stringByAppendingPathComponent:accountFile];
       account = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
       //用户
       if (!account) {
           account = [[Account alloc] init];
       }
   });
    return account;
}

-(void)saveLogIn:(NSDictionary *)dict{
    self.account = dict[@"account"];
    self.password = dict[@"password"];
    
    NSLog(@"%@",self.account);
    NSLog(@"%@",self.password);
    
    NSString *expiress = dict[@"expires"];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:expiress.doubleValue];
    self.expires = date;
    //保存登录信息在Documents路径下
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingString:accountFile];
    [NSKeyedArchiver archiveRootObject:self toFile:filePath];
    
}

-(BOOL)islogIn{
    //判断token是否存在，并且在有效期内
    if ([self.expires compare:[NSDate date]] > 0 && self.expires) {
        return YES;
    }
    return NO;
}

-(NSMutableDictionary *)requestParames{
    if ([self islogIn]) {
        return [NSMutableDictionary dictionaryWithObject:self.account forKey:@"account"];
    }
    return nil;
}

-(void)logout{
    //1.删除账户信息
    self.account = nil;
    self.password = nil;
    self.expires = nil;
    //删除保存路径
    NSString *file = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [file stringByAppendingPathComponent:accountFile];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}


//归档解档保存用户登录信息 归档
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

//解档
-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.password forKey:@"password"];
    
}



@end
