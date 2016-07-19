//
//  NoteMode.h
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoteMode : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString  *content;
@property (nonatomic,strong)NSString *timer;
@property (nonatomic,strong)NSString *source;
-(instancetype)initWithNotification:(NSDictionary *)dict;
+(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
