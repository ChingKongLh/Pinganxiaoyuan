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
@interface BaoXiuMainVC ()<selectIndexPathDelegate>
{
    UIView *_redview;
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
//        make.bottom.equalTo(_bottomview.mas_top);
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

-(void)NotificationCentra{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillAppear) name:YCXMenuWillAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidAppear) name:YCXMenuDidAppearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:YCXMenuWillDisappearNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuDidDisappear) name:YCXMenuDidDisappearNotification object:nil];
}

//弹出视图视图将要显示
- (void)menuWillAppear{
    
}
//弹出视图正在显示
-(void)menuDidAppear{
    
}
//弹出视图即将消失
-(void)menuWillDisapear{
    
}
//弹出视图已经消失
-(void)menuDidDisappear{
    
}


//弹出视图退出操作
-(void)logout:(id)sender{
    
}

-(void)setItems:(NSMutableArray *)items{
    _items = items;
}

-(NSArray *)area{
    if (_area == nil) {
        _area = @[@"东风校区",@"文北校区",@"紫金港校区"];
    }
    return _area;
}

-(NSArray *)type{
    if (_type == nil) {
        _type = @[@"门坏",@"门锁坏",@"门上纱窗",@"玻璃烂了"];
    }
    return _type;
}

-(void)choose:(UIButton *)btn{
    CGPoint point = CGPointMake(50,300);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfRightUp Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
    view1.dataArray = @[@"门坏了",@"门锁坏", @"门上窗纱坏", @"玻璃碎"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor whiteColor];
    view1.delegate = self;
    [view1 popView];
    
}



//设置弹框内容
-(NSMutableArray *)items{
    if (!_items) {
        //标题设置
        YCXMenuItem *menutitle = [YCXMenuItem menuTitle:@"门窗报修" WithIcon:nil];
        menutitle.foreColor = [UIColor whiteColor];
        menutitle.titleFont = [UIFont systemFontOfSize:14];
        //退出按钮设置
        YCXMenuItem *logout = [YCXMenuItem menuItem:@"去报修" image:nil target:self action:@selector(logout:)];
        logout.foreColor = [UIColor redColor];
        logout.alignment = NSTextAlignmentCenter;
        //内容设置
        _items = [@[menutitle,
                    //校区设置
//                    [YCXMenuItem menuItem:@"紫金港校区" image:nil tag:100 userInfo:nil],
                    [YCXMenuItem menuItem:@"门损坏" image:nil tag:101 userInfo:@{@"title":@"menu"}],
                    [YCXMenuItem menuItem:@"校区" image:nil tag:102 userInfo:@{@"title":@"menu"}],
                    [YCXMenuItem menuItem:@"电话" image:nil tag:103 userInfo:@{@"titie":@"menu"}],
                    logout
                    ]mutableCopy];
    }
    return _items;
}


#pragma mark -----------弹出视图点击事件处理

-(void)AddBtnClickAction{
    
    [_hbtn1 addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [_hbtn2 addTarget:self action:@selector(ZidingYiBaoxiu) forControlEvents:UIControlEventTouchUpInside];
    
    [_SBtn1 addTarget:self action:@selector(bumpview) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addAction{
    
    BaoXiuVC  *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"quickly"];
    [self presentViewController:VC animated:YES completion:nil];
    
}

-(void)ZidingYiBaoxiu{
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
    _redview = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_redview];
    
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
