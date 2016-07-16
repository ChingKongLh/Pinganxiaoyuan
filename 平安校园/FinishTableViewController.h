//
//  FinishTableViewController.h
//  Car
//
//  Created by Max on 16/5/9.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FinishTableViewController;
@protocol  FinishTableViewControllerdelegate<NSObject>
- (void)finishViewController:(FinishTableViewController *)finivc didInputReturnMessage:(NSString *)msgs;
@end
@interface FinishTableViewController : UITableViewController
@property (nonatomic,assign)id <FinishTableViewControllerdelegate> delegate;
@end
