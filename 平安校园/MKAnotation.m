//
//  MKAnotation.m
//  平安校园
//
//  Created by 中国孔 on 16/7/24.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MKAnotation.h"

@implementation MKAnotation

@synthesize coordinate, title, subtitle;
-(id) initWithCoordinate:(CLLocationCoordinate2D) coords
{
    if (self = [super init]) {
        coordinate = coords;
    }
    return self;
}

@end
