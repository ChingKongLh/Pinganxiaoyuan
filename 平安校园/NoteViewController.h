//
//  NoteViewController.h
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteViewController;
@protocol  NoteViewControllerDelegate <NSObject>
-(void)bViewController:(NoteViewController *)bvc didInputReturnMessage:(NSString *)msg;
@end
@interface NoteViewController : UIViewController
@property(nonatomic,assign)id<NoteViewControllerDelegate> delegate;
@end
