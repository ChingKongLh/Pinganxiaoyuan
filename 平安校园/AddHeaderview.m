//
//  AddHeaderview.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "AddHeaderview.h"
@interface AddHeaderview ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UIButton *ChangeImage;

@end
@implementation AddHeaderview

- (void)awakeFromNib {
    
    
    
}
- (IBAction)ImageChange:(UIButton *)sender {
    
    [_ChangeImage addTarget:self action:@selector(setUserImageBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setUserImageBtnAction:(UIButton *)UserImageBtn{
    
    //初始化图片选择器控件
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //设置图片系统来源
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    //使用模态视图展示相册
//    [self presentViewController:picker animated:YES completion:nil];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    //设置新头像
    [_ChangeImage setBackgroundImage:image forState:UIControlStateNormal];
    //模态方法退出相册
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
