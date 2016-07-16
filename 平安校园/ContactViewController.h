//
//  ContactViewController.h
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactViewController;
@protocol ContactViewControllerdelegate <NSObject>
- (void)contactViewController:(ContactViewController *)cVc didInputReturnMessage:(NSString *)msges;
@end
@interface ContactViewController : UIViewController
@property(nonatomic,assign)id<ContactViewControllerdelegate> delesgte;

@end
