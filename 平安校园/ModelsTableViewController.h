//
//  ModelsTableViewController.h
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModelsTableViewController;
@protocol  ModelsTableViewControllerDelegate<NSObject>
-(void)modelesViewController:(ModelsTableViewController *)modvc didInputReturnMessage:(NSString *)msgs;
@end

@interface ModelsTableViewController : UITableViewController
@property (nonatomic,assign)id<ModelsTableViewControllerDelegate> delegate;

@end
