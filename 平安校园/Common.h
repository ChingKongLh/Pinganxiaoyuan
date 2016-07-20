//
//  Common.h
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#ifndef Common_h
#define Common_h

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

#define KDevice_Is_Retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//5,5s的设备
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//===================登录宏定义===================//

#define kIslaunched @"kIslaunched"
#define kLogout @"logout"


#define xiwenUrlStr @"http://api.iclient.ifeng.com/ClientNews?id=SYLB10,SYDT10,SYRECOMMEND&page=1&newShowType=1&province=%E6%B2%B3%E5%8D%97%E7%9C%81&city=%E9%83%91%E5%B7%9E%E5%B8%82&district=%E4%B8%AD%E5%8E%9F%E5%8C%BA&gv=5.1.0&av=5.1.0&uid=864323024159189&deviceid=864323024159189&proid=ifengnews&os=android_19&df=androidphone&vt=5&screen=800x1216&publishid=9023"

//=====================登录界面 Define ===================//

//屏幕宽高
#define ScreenWidth  self.view.frame.size.width
#define ScreenHeight self.view.frame.size.height

//头像的宽高
#define  HeadX      (ScreenWidth-0.25*ScreenWidth)/2
#define  HeadY        80
#define HeadWidth     0.25*ScreenWidth
#define HeadHeight    0.25*ScreenWidth

//账号的宽高
#define AccountX    0
#define AccountY    HeadY+HeadHeight+20
#define AccountW    ScreenWidth
#define AccountH    50

//密码的宽高
#define PasswordX   0
#define PasswordY   AccountY+50
#define PasswordW   ScreenWidth
#define PasswordH   50

//登陆的宽高
#define LoginX   35
#define LoginY   PasswordY+PasswordH+20
#define LoginW   ScreenWidth-2*LoginX
#define LoginH   50

//无法登陆？
#define FailedX   5
#define FailedY   0.95*ScreenHeight
#define FailedW   80
#define FailedH   25
//新用户
#define NewX   0.8*ScreenWidth
#define NewY   0.95*ScreenHeight
#define NewW   80
#define NewH   25



#endif /* Common_h */
