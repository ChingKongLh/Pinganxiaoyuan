//
//  ContactViewController.m
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "ContactViewController.h"
#import "NavBtn.h"
@interface ContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;
@property (strong,nonatomic) NSString *str1;
@property (strong,nonatomic) NSString *str2;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"联系人";
    [self initNavigationControl];
    
}

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
    _contactTextField.keyboardType = UIKeyboardTypeNumberPad;
    
}

- (void)backCarVc:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)completeVc:(UIButton *)sender {
    
    self.str1 = [_nameTextField text];
    self.str2 = [_contactTextField text];
    NSMutableString *str3 = [NSMutableString stringWithFormat:@"%@,%@",_str1,_str2];
    [self.delesgte contactViewController:self didInputReturnMessage:str3];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

//-(void) textFieldDidEndEditing:(UITextField *)textField { //获取输入的内容
//
//}

//+ (NSString *)valiMobile:(NSString *)mobile{
//    if (mobile.length < 11)
//    {
//        return @"手机号长度只能是11位";
//    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//        
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return nil;
//        }else{
//            return @"请输入正确的*****号码";
//        }
//    }
//    return nil;
//}


+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


@end
