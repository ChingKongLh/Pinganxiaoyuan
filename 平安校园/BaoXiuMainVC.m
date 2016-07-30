//
//  BaoXiuMainVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/27.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "BaoXiuMainVC.h"
#import "Masonry.h"
#import "Common.h"
#import "BaoXiuVC.h"
#import "YCXMenu.h"
#import "XTPopView.h"
#import "LZFoldButton.h"
#import "UITextField+IndexPath.h"
#import "Masonry.h"
#import "RightControlVC.h"
#import "AFNetworking.h"
#define LabelW _redview.frame.size.width - _Slabel1.frame.size.width + 30
#define LabelH 50
#define LzHeight 44

//===========原始尺寸=============//
#define labelX -200
#define labelY  100
#define labeLW ScreenW/4+15

#define lzX -100 + ScreenW/4 + 15

@interface BaoXiuMainVC ()<selectIndexPathDelegate,LZFoldButtonDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIView *_redview;
    CGFloat _y;
    CGFloat _x;
    LZFoldButton *lz1;
    LZFoldButton *lz2;
    LZFoldButton *lz3;
    LZFoldButton *lz4;
    
}
//====================报修界面布局控件================//
@property (strong, nonatomic) IBOutlet UIView *line1;
@property (strong, nonatomic) IBOutlet UILabel *fenleibaoxiu;
@property (strong, nonatomic) IBOutlet UIView *headerview;
@property (strong, nonatomic) IBOutlet UIView *upsiteView;
@property (strong, nonatomic) IBOutlet UIView *line3;
@property (strong, nonatomic) IBOutlet UILabel *baoxiushenqi;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *line2;
@property (strong, nonatomic) IBOutlet UIView *fenleiview;
@property (strong, nonatomic) IBOutlet UILabel *fenqubaoxiu;

//======================底部view=====================//
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UIView *view4;
@property (strong, nonatomic) IBOutlet UIView *view5;
@property (strong, nonatomic) IBOutlet UIView *view6;
@property (strong, nonatomic) IBOutlet UIView *view7;
//========================功能键布局==================//
@property (strong, nonatomic) IBOutlet UIButton *hbtn1;
@property (strong, nonatomic) IBOutlet UIView *hleftv;
@property (strong, nonatomic) IBOutlet UIButton *hbtn2;
@property (strong, nonatomic) IBOutlet UIView *hrightv;
@property (strong, nonatomic) IBOutlet UIButton *hbtn3;
//=======================分类报修点击事件===============//
@property (strong, nonatomic) IBOutlet UIButton *SBtn1;
@property (strong, nonatomic) IBOutlet UIButton *SBtn2;
@property (strong, nonatomic) IBOutlet UIButton *SBtn3;
@property (strong, nonatomic) IBOutlet UIButton *SBtn4;
@property (strong, nonatomic) IBOutlet UIButton *SBtn5;
@property (strong, nonatomic) IBOutlet UIButton *SBtn6;
@property (strong, nonatomic) IBOutlet UIButton *SBtn7;
@property (strong, nonatomic) IBOutlet UIButton *Sbtn8;
//====================分区报修点击事件==================//
@property (strong, nonatomic) IBOutlet UIButton *FBtn1;
@property (strong, nonatomic) IBOutlet UIButton *FBtn2;
@property (strong, nonatomic) IBOutlet UIButton *FBtn3;
//==================自定义属性=========================//
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,strong)NSMutableArray *items;
@property (nonatomic,strong)NSArray *area;
@property (nonatomic,strong)NSArray *type;

//==================左侧弹出视图=======================//
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UIView *RightView;

@property (nonatomic,strong)UILabel *Slabel1;
@property (nonatomic,strong)UILabel *Slabel2;
@property (nonatomic,strong)UILabel *Slabel3;
@property (nonatomic,strong)UIView *Sline2;
@property (nonatomic,strong)UIView *Sline3;
@property (nonatomic,strong)UIView *Sline4;
@property (nonatomic,strong)UIImageView *imageview;
@property (nonatomic,strong)UIButton *UploadImage;
@property (nonatomic,strong)UILabel *Slabel4;
@property (nonatomic,strong)UIButton *commit;
@end

@implementation BaoXiuMainVC
@synthesize items=_items;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self LayerSettingWithBottom];
    [self marsonrySetting];
    _hbtn1.tag = 101;
    _hbtn2.tag = 102;
    _hbtn3.tag = 103;
    
    _SBtn1.tag = 104;
    _SBtn2.tag = 105;
    
    _y = 200;
    //创建点击事件弹出区域
    _redview = [[UIView alloc] initWithFrame:CGRectMake(labelX,labelY,ScreenW/3 , 400)];
    _redview.backgroundColor = [UIColor orangeColor];
    _redview.layer.cornerRadius = 10;
    [self.view addSubview:_redview];
    
//=====================添加第一个label==================//
    
    _Slabel1 = [[UILabel alloc] initWithFrame:CGRectMake(labelX,labelY, labeLW ,LabelH)];
   self.Slabel1.backgroundColor = [UIColor whiteColor];
    _Slabel1.text = @"华中校区";
    _Slabel1.textAlignment = NSTextAlignmentCenter;
    _Slabel1.font = [UIFont systemFontOfSize:17.0f];
    [_redview addSubview:_Slabel1];
    //添加label上的Btn
    NSArray *arr = @[@"华中校区",@"英才校区",@"紫金港校区"];
    lz1 = [[LZFoldButton alloc] initWithFrame:CGRectMake(-100 + ScreenW/4 +15,0,_redview.frame.size.width - _Slabel1.frame.size.width + 30, 50) dataArray:arr];
    lz1.lzDelegate = self;
    lz1.lzFontSize = 16;
    lz1.lzHeight = 132;
    lz1.tag = 1000;
    lz1.backgroundColor = [UIColor redColor];
    [_redview addSubview:lz1];
    //添加分割线
    _Sline2 = [[UIView alloc] init];
    _Sline2.backgroundColor = [UIColor darkTextColor];
    [_redview addSubview:_Sline2];
    [_Sline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lz1.mas_bottom);
        make.left.equalTo(_redview.mas_left);
        make.size.mas_equalTo(CGSizeMake(_redview.frame.size.width, 1));
    }];
    
//========================添加第二个label===================//
    _Slabel2 = [[UILabel alloc] initWithFrame:CGRectMake(-100, 100, ScreenW/4 + 15, LabelH)];
    
    _Slabel2.backgroundColor = [UIColor whiteColor];
    _Slabel2.textAlignment = NSTextAlignmentCenter;
    _Slabel2.font = [UIFont systemFontOfSize:17.0f];
    _Slabel2.text = @"门坏";
    [_redview addSubview:_Slabel2];
    
    //添加第二个label上的btn
    NSArray *arr2 = @[@"门坏",@"窗户坏",@"玻璃碎了",@"门上窗纱坏"];
    lz2 = [[LZFoldButton alloc] initWithFrame:CGRectMake(-100 + ScreenW/4 + 15, LabelH + 1,LabelW , LabelH) dataArray:arr2];
    lz2.lzDelegate = self;
    lz2.lzFontSize = 16.0f;
    lz2.tag = 1001;
    lz2.lzHeight = LzHeight * 4;
    lz2.backgroundColor = [UIColor grayColor];
    [_redview addSubview:lz2];
    
    //添加第二个label与第三个label之间的分割线
    _Sline3 = [[UIView alloc] initWithFrame:CGRectMake(-100,LabelH * 2+1, _redview.frame.size.width, 1)];
    _Sline3.backgroundColor = [UIColor lightGrayColor];
    [_redview addSubview:_Sline3];
    
//=====================添加第三个label=====================//
    _Slabel3 = [[UILabel alloc] initWithFrame:CGRectMake(labelX,labelY, labeLW, LabelH)];
    _Slabel3.backgroundColor = [UIColor whiteColor];
    _Slabel3.textAlignment = NSTextAlignmentCenter;
    _Slabel3.font = [UIFont systemFontOfSize:17.0f];
    _Slabel3.text = @"1";
    [_redview addSubview:_Slabel3];
    
    //添加第三个label右边的btn
    NSArray *arr3  = @[@"1",@"2",@"3",@"4"];
    lz3 = [[LZFoldButton alloc] initWithFrame:CGRectMake(lzX, LabelH * 2 +2, LabelW, LabelH) dataArray:arr3];
    lz3.lzDelegate = self;
    lz3.lzFontSize = 16.0f;
    lz3.lzHeight = LzHeight * 4;
    lz3.tag = 1003;
    lz3.backgroundColor = [UIColor blackColor];
    [_redview addSubview:lz3];
    //添加第三个与第四个label之间的分割线
    _Sline4 = [[UIView alloc] init];
    _Sline4.backgroundColor = [UIColor lightGrayColor];
    [_redview addSubview:_Sline4];
    [_Sline4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_Slabel3.mas_bottom);
        make.left.equalTo(_redview.mas_left);
        make.size.mas_equalTo(CGSizeMake(_redview.frame.size.width, 1));
    }];
    

//====================添加图片上传=======================//
    
    _UploadImage = [[UIButton alloc] initWithFrame:CGRectMake(labelX, labelY,_redview.frame.size.width, LabelH + 50)];
    _imageview.backgroundColor = [UIColor greenColor];
    [_redview addSubview:_UploadImage];
    _UploadImage.tag = 1004;
    [_UploadImage addTarget:self action:@selector(uploadImage:) forControlEvents:UIControlEventTouchUpInside];

//添加提交按钮
    _commit = [[UIButton alloc] initWithFrame:CGRectMake(labelX, labelY, _redview.frame.size.width, LabelH)];
    _commit.backgroundColor = [UIColor redColor];
    [_commit addTarget:self action:@selector(UpLoadData) forControlEvents:UIControlEventTouchUpInside];
    [_commit setTitle:@"提交报修" forState:UIControlStateNormal];
    _commit.tag= 1005;
    [_redview addSubview:_commit];
    
    
    _SBtn3.tag = 106;
    _SBtn4.tag = 107;
    _SBtn5.tag = 108;
    _SBtn6.tag = 109;
    _SBtn7.tag = 110;
    _Sbtn8.tag = 111;
    
    _FBtn1.tag = 112;
    _FBtn2.tag = 113;
    _FBtn3.tag = 114;
    [self DealWithBtnTarget];
    //Btn点击事件
    [self AddBtnClickAction];
    [self bumpWithRightView];

    
    
}

//==================弹出右侧视图=================//
-(void)bumpWithRightView{
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(ScreenW + 300, 64, ScreenW - 200, ScreenH - 200) style:UITableViewStylePlain];
    _tableview.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableview];
    
}


-(void)addAction{
    _x = 64;
  [UIView animateWithDuration:.3 animations:^{
      _tableview.frame = CGRectMake(150, _x  ,ScreenW - 150, ScreenH - 150);
  }];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_hbtn2.tag ==102 ) {
        _x=ScreenW + 100;
        [UIView animateWithDuration:0.3 animations:^{
            _x=_x + 0.1;
            _tableview.backgroundColor = [UIColor lightGrayColor];
            _tableview.frame=CGRectMake(ScreenW + 300, 64, ScreenW - 200, ScreenH - 200);
        }];
    }else{
        return;
    }
}

//上传图片代码
-(void)uploadImage:(UIButton *)UserImageBtn{
    
    if (_UploadImage.tag ==1004) {
        //初始化图片选择器控件
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        //设置图片系统来源
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        
        //使用模态视图展示相册
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        return ;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    //拍照上传图片
    [_UploadImage setBackgroundImage:image forState:UIControlStateNormal];
    //模态方法退出界面
    [picker dismissViewControllerAnimated:YES completion:nil];

}

//====================点击上传本地数据到服务器=========================//

-(void)UpLoadData{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@""]];
    //设置请求头
//    [request ]
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    NSDictionary  *parames = {_Slabel1.text,_Slabel2.text,_Slabel3.text};
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [manger POST:request parameters:parames progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)marsonrySetting{
    
    //====================头部视图约束======================//
//    _headerview = [[UIView alloc] init];
    _headerview.translatesAutoresizingMaskIntoConstraints = NO;
    [_headerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(114);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 70));
    }];
    [self.view addSubview:_headerview];
    [_hbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(_headerview.mas_top).with.offset(15);
        make.centerX.mas_equalTo(_headerview.mas_centerX).with.offset(2/5 * ScreenW);
    }];
    [_hleftv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerview.mas_top).with.offset(25);
        make.bottom.equalTo(_headerview.mas_bottom).with.offset(-25);
        make.centerX.mas_equalTo(_headerview.mas_bottom).with.offset(1/2 * ScreenW);
    }];
    [_hbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerview.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.mas_equalTo(_headerview.mas_centerX);
    }];
    [_hrightv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerview.mas_top).with.offset(25);
        make.bottom.equalTo(_headerview.mas_bottom).with.offset(-25);
        make.centerX.mas_equalTo(_headerview.mas_centerX).with.offset(3/2 * ScreenW);
    }];
    [_hbtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerview.mas_top).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(_headerview.mas_centerX).with.offset(8/5 * ScreenW);
    }];
    [_headerview addSubview:_hbtn1];
    [_headerview addSubview:_hleftv];
    [_headerview addSubview:_hbtn2];
    [_headerview addSubview:_hrightv];
    [_headerview addSubview:_hbtn3];
    
    //===================分类报修约束=======================//
    [_fenleibaoxiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerview.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 20));
    }];
    [self.view addSubview:_fenleibaoxiu];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fenleibaoxiu.mas_bottom);
        make.left.equalTo(self.view.mas_left).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 1));
    }];
    [self.view addSubview:_line1];
    [_SBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(_line1.mas_bottom).with.offset(15);
        make.centerX.mas_equalTo(_fenleiview.mas_centerX).with.offset(0.25 * ScreenW);
    }];
    [_SBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn1);
        make.top.equalTo(_SBtn1);
        make.centerX.mas_equalTo(_fenleiview.mas_centerX).with.offset(0.75 * ScreenW);
    }];
    [_SBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn1);
        make.top.equalTo(_SBtn1);
        make.centerX.mas_equalTo(_fenleiview.mas_centerX).with.offset(1.25 * ScreenW);
    }];
    [_SBtn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn1);
        make.top.equalTo(_SBtn1);
        make.centerX.mas_equalTo(_fenleiview.mas_centerX).with.offset(1.75 * ScreenW);
    }];
    [_SBtn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn1);
        make.top.equalTo(_SBtn1.mas_bottom).with.offset(25);
        make.centerX.mas_equalTo(_SBtn1);
    }];
    [_SBtn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn5);
        make.top.equalTo(_SBtn5);
        make.centerX.equalTo(_SBtn2);
    }];
    [_SBtn7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn5);
        make.top.equalTo(_SBtn5);
        make.centerX.equalTo(_SBtn3);
    }];
    [_Sbtn8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_SBtn5);
        make.top.equalTo(_SBtn5);
        make.centerX.equalTo(_SBtn4);
    }];
    
    [_fenleiview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 170));
    }];
    [_fenleiview addSubview:_SBtn1];
    [_fenleiview addSubview:_SBtn2];
    [_fenleiview addSubview:_SBtn3];
    [_fenleiview addSubview:_SBtn4];
    [_fenleiview addSubview:_SBtn5];
    [_fenleiview addSubview:_SBtn6];
    [_fenleiview addSubview:_SBtn7];
    [_fenleiview addSubview:_Sbtn8];
    
    //====================分区域报修约束=====================//
    [_fenqubaoxiu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_fenleiview.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(_line2.mas_top);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 20));
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-8);
        make.top.equalTo(_fenqubaoxiu.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 1));
    }];
    
    [_FBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.top.equalTo(_bottomView.mas_top).with.offset(15);
        make.centerX.mas_equalTo(_bottomView.mas_centerX).with.offset(1/2 * ScreenW);
    }];
    [_FBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_FBtn1);
        make.top.equalTo(_FBtn1);
        make.centerX.mas_equalTo(_bottomView.mas_centerX);
    }];
    [_FBtn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(_FBtn1);
        make.top.equalTo(_FBtn1);
        make.centerX.mas_equalTo(_bottomView.mas_centerX).with.offset(3/2 * ScreenW);
    }];
    [_bottomView addSubview:_FBtn1];
    [_bottomView addSubview:_FBtn2];
    [_bottomView addSubview:_FBtn3];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(_line2.mas_bottom);
        make.centerY.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(ScreenW,60));
//      make.bottom.equalTo(_fenqubaoxiu.mas_top).width.offset(-10);
    }];

//=====================底部浮动区约束==============================//
    [_baoxiushenqi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(_bottomView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 20));
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_baoxiushenqi.mas_bottom);
        make.left.equalTo(self.view.mas_left).with.offset(6);
        make.right.equalTo(self.view.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 1));
    }];
    [_upsiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line3.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(ScreenW, 50));
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    [_view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upsiteView.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 44));
        make.left.equalTo(self.view.mas_left).with.offset(20);
    }];
    [_view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view1);
        make.size.mas_equalTo(CGSizeMake(60, 44));
        make.left.equalTo(_view1.mas_right).with.offset(30);
    }];
    [_view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view3);
        make.size.mas_equalTo(CGSizeMake(70, 44));
        make.left.equalTo(_view2.mas_right).with.offset(10);
    }];
    [_view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view3);
        make.size.mas_equalTo(CGSizeMake(85, 44));
        make.left.equalTo(_view3.mas_right).with.offset(10);
    }];
    [_view5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view1.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 44));
        make.left.equalTo(_view1);
    }];
    [_view6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view5);
        make.size.mas_equalTo(CGSizeMake(80, 44));
        make.left.equalTo(_view5.mas_right).with.offset(10);
    }];
    [_view7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view6);
        make.size.mas_equalTo(CGSizeMake(110, 44));
        make.left.equalTo(_view6.mas_right).with.offset(10);
    }];
    [_upsiteView addSubview:_view1];
    [_upsiteView addSubview:_view2];
    [_upsiteView addSubview:_view3];
    [_upsiteView addSubview:_view4];
    [_upsiteView addSubview:_view5];
    [_upsiteView addSubview:_view6];
    [_upsiteView addSubview:_view7];
}


#pragma mark ------- BottomView LayerSetting

-(void)LayerSettingWithBottom{
    //设置圆角
    _view1.layer.cornerRadius = 35;
    _view1.layer.shadowRadius = 20;
    _view1.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view1.layer.shadowOffset = CGSizeMake(2, 2);
    _view1.layer.borderWidth = 1;
    //边框背景色
    _view1.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view2.layer.cornerRadius = 25;
    _view2.layer.shadowRadius = 20;
    _view2.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view2.layer.shadowOffset = CGSizeMake(2, 2);
    _view2.layer.borderWidth = 1;
    _view2.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view3.layer.cornerRadius = 35;
    _view3.layer.shadowRadius = 20;
    _view3.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view3.layer.shadowOffset = CGSizeMake(2, 2);
    _view3.layer.borderWidth = 1;
    
    _view4.layer.cornerRadius = 30;
    _view4.layer.shadowRadius = 20;
    _view4.layer.shadowColor = [[UIColor orangeColor] CGColor];
    _view4.layer.shadowOffset = CGSizeMake(2, 2);
    _view4.layer.borderWidth = 1;
    _view4.layer.borderColor = [[UIColor orangeColor] CGColor];
    _view5.layer.shadowRadius = 20;
    _view5.layer.cornerRadius = 30;
    _view5.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view5.layer.shadowOffset = CGSizeMake(2, 2);
    _view5.layer.borderWidth = 1;
    _view5.layer.borderColor = [[UIColor blueColor] CGColor];

    _view6.layer.shadowRadius = 15;
    _view6.layer.cornerRadius = 25;
    _view6.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view6.layer.shadowOffset = CGSizeMake(2, 2);
    _view6.layer.borderWidth = 1;
    _view6.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    _view7.layer.cornerRadius = 25;
    _view7.layer.shadowRadius = 10;
    _view7.layer.shadowColor = [[UIColor grayColor] CGColor];
    _view7.layer.shadowOffset = CGSizeMake(2, 2);
    _view7.layer.borderWidth = 1;
    _view7.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

#pragma mark -----报修界面Btn点击事件处理

-(void)DealWithBtnTarget{
    switch (_tag) {
    //switch case中初始化控件需要添加{}否则不会执行alloc
        case 101:{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂未开通" message:Nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                //用户点击取消如果不做处理直接dismiss
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
            case 102:
            break;
        default:
            break;
    }
}

//弹出视图退出操作
-(void)logout:(id)sender{
    
}

//======================================================//

#pragma mark -----------弹出视图点击事件处理

-(void)AddBtnClickAction{
    
    [_hbtn1 addTarget:self action:@selector(ZidingYiBaoxiu) forControlEvents:UIControlEventTouchUpInside];
    [_hbtn2 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_SBtn1 addTarget:self action:@selector(bumpview) forControlEvents:UIControlEventTouchUpInside];
    [_SBtn2 addTarget:self action:@selector(AddLeftAction) forControlEvents:UIControlEventTouchUpInside];
}


-(void)ZidingYiBaoxiu{
    BaoXiuVC  *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"quickly"];
    [self presentViewController:VC animated:YES completion:nil];

}


-(void)bumpview{
    
    [YCXMenu setTintColor:[UIColor colorWithRed:0.118 green:0.573 blue:0.820 alpha:1]];
    if ([YCXMenu isShow]) {
        [YCXMenu dismissMenu];
    }else{
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(10, ScreenW - 400, 30, 300) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}


#pragma mark ----------- btn点击弹出侧滑视图实现
-(void)AddLeftAction{
    
    [UIView animateWithDuration:.5 animations:^{
        _redview.backgroundColor = [UIColor orangeColor];
        _y = _y + 0.1;
//设置整个弹出视图
        _redview.frame = CGRectMake(0, _y + 50,ScreenW/3 + 30, 300);
        //这个位置设置要注意是相对于其父视图的位置来讲的所以Y值应该设置为0;
        _Slabel1.frame = CGRectMake(0, 0, ScreenW/4+15  , 50);

        lz1.frame = CGRectMake(ScreenW/4+15,0,_redview.frame.size.width - _Slabel1.frame.size.width,50);
        lz1.backgroundColor = [UIColor redColor];
        [_Sline2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_Slabel1.mas_bottom);
            make.left.equalTo(_redview.mas_left);
            make.size.mas_equalTo(CGSizeMake(_redview.frame.size.width, 1));
        }];

//设置第二个label
        [_Slabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_Sline2.mas_bottom);
            make.left.equalTo(_Slabel1.mas_left);
            make.right.equalTo(_Slabel1.mas_right);
            make.height.equalTo(_Slabel1.mas_height);
        }];
        lz2.frame = CGRectMake(ScreenW/4 + 15,LabelH + 1, LabelW, LabelH);
        lz2.backgroundColor = [UIColor greenColor];
        
        _Sline3.frame = CGRectMake(0, LabelH * 2+1, _redview.frame.size.width, 1);
        
//设置第三个label
        [_Slabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_Sline3.mas_bottom);
            make.left.equalTo(_Slabel2.mas_left);
            make.right.equalTo(_Slabel2.mas_right);
            make.height.equalTo(_Slabel2.mas_height);
        }];
        _Slabel3.backgroundColor = [UIColor whiteColor];
        lz3.frame = CGRectMake(ScreenW/4 + 15, LabelH * 2 +2, LabelW, LabelH);
        [_Sline4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_Slabel3.mas_bottom);
            make.left.equalTo(_redview.mas_left);
            make.size.mas_equalTo(CGSizeMake(_redview.frame.size.width, 1));
        }];
  
//设置图片位置
        _UploadImage.frame = CGRectMake(0, LabelH * 3 +2, _redview.frame.size.width, LabelH + 50);
        
        _commit.frame = CGRectMake(0, LabelH * 3 + 2 +_UploadImage.frame.size.height, _redview.frame.size.width, LabelH);
    }];
}


-(void)textFieldDidChanged:(NSNotification *)note{
    UITextField *text = note.object;
    NSIndexPath *indexpath = text.indexPath;
    NSLog(@"%@",text.text);
}

-(void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj{
    //obj中所包含选中内容
    if (lz1.tag == 1001) {
    //选中替换到之前label内容
    _Slabel1.text =obj;
    }else if (lz2.tag ==1002){
        _Slabel2.text = obj;
    }else if (lz3.tag == 1003){
        _Slabel3.text = obj;
    }
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
