//
//  StartTableViewController.h
//  Car
//
//  Created by Max on 16/5/9.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StartTableViewController;
@protocol StartTableViewControllerdelegate <NSObject>
-(void)startViewController:(StartTableViewController *)stavc didInputReturnMessage:(NSString *)msgs;
@end
@interface StartTableViewController : UITableViewController
@property(nonatomic,assign)id<StartTableViewControllerdelegate> delegate;
@end
