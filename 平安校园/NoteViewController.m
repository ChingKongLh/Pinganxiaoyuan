//
//  NoteViewController.m
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//



#import "NoteViewController.h"
#import "NavBtn.h"
@interface NoteViewController ()
@property (weak, nonatomic) IBOutlet UITextView *noteText;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUi];
    [self initNavigationControl];
   
}



- (void)updateUi {
    self.title = @"备注";

    _noteText.layer.borderColor = UIColor.blackColor.CGColor;
    _noteText.layer.borderWidth = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;

}


//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    
//    if ([text isEqualToString:@"\n"]) {
//        
//        [textView resignFirstResponder];
//        return NO;
//        
//    }
//    else if(range.location >= 500)//如果输入超过规定的字数20，就不再让输入
//    {
//        return  NO;
//    }
//    self.content = _noteText.text;
//    return YES;
//}

- (void)initNavigationControl{
    //设置左边item
    UIButton *btn = [NavBtn navBtn];
    [btn setFrame:CGRectMake(0, 0, 11, 15)];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backCarVc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton= [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem=[NavBtn spaceItem];
    self.navigationItem.leftBarButtonItems =@[spaceItem,leftButton];
    
    UIButton *btn1 = [NavBtn navBtn];
    [btn1 setFrame:CGRectMake(0, 0, 30, 18.5)];
    [btn1 setTitle:@"完成" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [btn1 addTarget:self action:@selector(completeVc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton= [[UIBarButtonItem alloc] initWithCustomView:btn1];
    [btn1 setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItems =@[spaceItem,rightButton];
    
    
}



- (void)backCarVc:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
  
}

- (void)completeVc:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate bViewController:self didInputReturnMessage:self.noteText.text];
     
    
}







@end
