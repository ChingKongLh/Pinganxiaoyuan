//
//  LogIn.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "LogIn.h"
#import "Common.h"
#import "AFNetworking.h"
#import "Account.h"
@interface LogIn ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic,strong)UIButton *UserImageBtn ,   *LoginBtn,  *FailedBtn ,  *NewBtn ;
@property(nonatomic,strong )UITextField  *accountTextField , *passwordTextField;

@end

@implementation LogIn

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化登录头像按钮
    self.UserImageBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenW - 0.25 * ScreenW)/2, 80, 0.25 * ScreenW, 0.25 * ScreenW)];

    //设置头像图片
    [self.UserImageBtn setBackgroundImage:[UIImage imageNamed:@"login_header@2x.png"] forState:UIControlStateNormal];
    
    //设置为圆形头像
    _UserImageBtn.layer.cornerRadius = HeadHeight/2;
    _UserImageBtn.layer.masksToBounds = YES;
    
    //添加头像改变事件
    [_UserImageBtn addTarget:self action:@selector(setUserImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.UserImageBtn];
    
    //初始化用户名密码
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(AccountX, AccountY, AccountW, AccountH)];
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(PasswordX, PasswordY, PasswordW, PasswordH)];
    _accountTextField.textAlignment = NSTextAlignmentCenter;
    _accountTextField.placeholder = @"请输入用户名";
    _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.placeholder = @"请输入密码";
    _passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    
    //社会密码密文显示
    _passwordTextField.secureTextEntry = YES;
    
    [self.view addSubview:self.accountTextField];
    [self.view addSubview:self.passwordTextField];
    
    //分配初始化登录控件
    self.LoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(LoginX, LoginY, LoginW, LoginH)];
    
    //设置登录时间效果图片
    [_LoginBtn setImage:[UIImage imageNamed:@"login_btn_blue_nor@2x.png"] forState:UIControlStateNormal];
    [_LoginBtn setImage:[UIImage imageNamed:@"login_btn_blue_press@2x.png"] forState:UIControlStateHighlighted];
    
    //添加点击登录事件
    [_LoginBtn addTarget:self action:@selector(LoginBtnClickListener) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.LoginBtn];
    
    //登录遇到问题控件
    self.FailedBtn = [[UIButton alloc] initWithFrame:CGRectMake(FailedX, FailedY, FailedW, FailedH)];
    [_FailedBtn setImage:[UIImage imageNamed:@"failed.png"] forState:UIControlStateNormal];
    [self.view addSubview:self.FailedBtn];
    
    self.NewBtn = [[UIButton alloc] initWithFrame:CGRectMake(NewX, NewY, NewW, NewH)];
    [_NewBtn setImage:[UIImage imageNamed:@"new.png"] forState:UIControlStateNormal];
    
    [self.view addSubview:self.NewBtn];
    
    
    
    
}

//修改头像事件
-(void)setUserImageBtnAction:(UIButton *)UserImageBtn{
    
    //初始化图片选择器控件
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //设置图片系统来源
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //使用模态视图展示相册
    [self presentViewController:picker animated:YES completion:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    //设置新头像
    [_UserImageBtn setBackgroundImage:image forState:UIControlStateNormal];
    //模态方法退出相册
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

//点击登录按钮完成登录操作
- (void)LoginBtnClickListener{

    if (self.accountTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"系统登录中，请稍后" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertcontroller animated:YES completion:nil];
        //设置请求地址
        NSString *urlString = @"http://wypnrc3fnk.proxy.qqbrowser.cc/Hall/api/login";
    
        //设置请求参数
        NSDictionary *parames = @{@"Account":@"account",
                                  @"Password":@"password"};
        //加载登录请求
        AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
        manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
      [manger POST:urlString parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          //保存登录信息到本地
          [[Account saveAccount]saveLogIn:responseObject];
        //登录成功后当前视图模态消失
          [self dismissViewControllerAnimated:YES completion:nil];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          NSLog(@"%@",error);
      }];
    }else{
        //判断学号是否输入正确
        if (self.accountTextField.text.length != 12) {
            UIAlertController *AcountAlert = [UIAlertController alertControllerWithTitle:nil message:@"学号长度有误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:AcountAlert animated:YES completion:nil];
            
        //判断用户密码输入是否为空
        }else if (self.passwordTextField.text.length == 0){
            UIAlertController  *passAlert = [UIAlertController alertControllerWithTitle:nil message:@"密码长度不能为空" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:passAlert animated:YES completion:nil];
        }
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
