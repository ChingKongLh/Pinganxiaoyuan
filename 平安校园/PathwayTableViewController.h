//
//  PathwayTableViewController.h
//  Car
//
//  Created by Max on 16/5/11.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^blockCZ)(NSString *string);

@interface PathwayTableViewController : UITableViewController
@property (nonatomic, copy)blockCZ block;
@end
