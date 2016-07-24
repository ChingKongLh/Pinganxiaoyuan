//
//  MKAnotation.h
//  平安校园
//
//  Created by 中国孔 on 16/7/24.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>
@interface MKAnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D *CLLocation;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *subtitle;


@end
