//
//  Models.m
//  Car
//
//  Created by Max on 16/5/7.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "Models.h"

@implementation Models
+(NSArray *)demoData {
    Models *mel = [[Models alloc]init];
    mel.carName = @[@"奥迪A4L 1.8T",@"奥迪A6L 2.0T",@"奥迪A7L 2.5T",@"奥迪A8L 3.0T",@"奥迪A9L 4.0T",@"奥迪A5L 2.0T",@"奥迪A5 2.5T",@"奥迪A6 4.0T",@"自定义车型"];
    return @[mel];
}


+(NSArray *)starData {
    Models *mel1 = [[Models alloc]init];
    mel1.starName = @[@"南站",@"大学科技园",@"总站",@"北站",@"大唐"];
    return @[mel1];


}
+(NSArray *)finiData {

    Models *mel2 = [[Models alloc]init];
    mel2.finiName = @[@"成都市武侯区",@"成都市青羊区",@"成都市高新区",@"成都市锦江区"];
    return @[mel2];
}

+(NSArray *)pathwayData {
    
    Models *mel3 = [[Models alloc]init];
    mel3.pathwayName = @[@"上海市普陀区",@"上海市奉贤区",@"上海市静安区",@"上海市宝山区"];
    return @[mel3];
}





@end
