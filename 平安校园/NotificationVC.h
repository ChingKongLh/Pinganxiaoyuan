//
//  NotificationVC.h
//  平安校园
//
//  Created by 中国孔 on 16/7/14.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationVC : UIViewController

//监听文本框输入信息
/*
 @property (weak, nonatomic) IBOutlet UITextField *nameView;
 @property (weak, nonatomic) IBOutlet UITextField *pwdView;
 @property (weak, nonatomic) IBOutlet UIButton *loginBtn;
  -(void)viewdeiload中方法
 [self.nameView addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
 [self.pwdView addTarget:self action:@selector(textValueChanged) forControlEvents:UIControlEventEditingChanged];
 - (void)textValueChanged
 {
 self.loginBtn.enabled = (self.nameView.text.length != 0 && self.pwdView.text.length != 0);
 }
 
 //创建通知
 - (void)viewDidLoad {
 [super viewDidLoad];
 //创建通知
 NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
 //注册通知
 [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:self.nameView];
 [center addObserver:self selector:@selector(textValueChanged:) name:UITextFieldTextDidChangeNotification object:self.pwdView];
 
 }
 //监听文本框的值的改变
 - (void)textValueChanged:(NSNotification *)notice
 {
 self.loginBtn.enabled = (self.nameView.text.length != 0 && self.pwdView.text.length != 0);
 }
 //移除通知
 - (void)dealloc
 {
 [[NSNotificationCenter defaultCenter] removeObserver:self];
 }
 
 //用kvo监听实时输入
 - (void)viewDidLoad {
 [super viewDidLoad];
 //KVO
 
 [self.nameView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
 [self.pwdView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
 
 }
 
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.loginBtn.enabled = (self.pwdView.text.length != 0 && self.nameView.text.length != 0);
}

//移除KVO
- (void)dealloc
{
    [self.nameView removeObserver:self forKeyPath:@"text"];
    [self.pwdView removeObserver:self forKeyPath:@"text"];
}


 
 *  监听登录文本框的输入
 
- (IBAction)nameViewChange
{
    self.loginBtn.enabled = (self.nameView.text.length != 0 && self.pwdView.text.length != 0);
}

- (IBAction)pwdViewChange
{
    self.loginBtn.enabled = (self.nameView.text.length != 0 && self.pwdView.text.length != 0);
}
 


 */



@end
