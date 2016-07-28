//
//  MainVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MainVC.h"
#import "Common.h"
#import "ListVC.h"
#import "MainM.h"
#import "MainMv.h"
#import "DetailVC.h"
#import "AFNetworking/AFNetworking.h"
#import "SVProgressHUD.h"
#import "XRCarouselView.h"
#import "Masonry.h"
#import "XTPopView.h"
#import "NewsVC.h"
#import "NotificationVC.h"
#import "TiaoSuVC.h"
#import "BaoXiuVC.h"
#import "CarViewController.h"
#import "Fuwujiandu.h"
#import "shiwuVC.h"
#import "SecondMarketVC.h"
#import "MangerVC.h"
@interface MainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XRCarouselViewDelegate,UICollectionViewDelegateFlowLayout,selectIndexPathDelegate>
@property (nonatomic,strong)UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *mArr;
@property (nonatomic, strong) NSMutableArray *infoArr;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) ListVC *list;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, assign) BOOL gestureTag;
@property (nonatomic, assign) BOOL leftBtnTaped;
@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isloadMore;

@property (nonatomic,strong)NSArray *datas;
@property (nonatomic,strong)XRCarouselView *carouselView;
@property (nonatomic,strong)NSMutableArray *data;

@property (nonatomic,strong)UIImageView *img;
@property (strong, nonatomic) IBOutlet UIView *V;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *Bottomheight;
@property (nonatomic,assign)NSIndexSet *index;

@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UIButton *customBtn;
@end
static NSString *identifier = @"item";
static NSString *identifiercell = @"cell";
NSString * const KcollectionViewCellID = @"cellID";
NSString * const KReusableHeaderView = @"reuseHeader";
NSString * const KReusableFooterView = @"reuseFooter";
@implementation MainVC

//右上角弹框提醒
- (void)addRightBtn {
    
    self.view.backgroundColor = [UIColor whiteColor];
    _customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customBtn.frame = CGRectMake(0, 0, 40, 40);
    [_customBtn setTitle:@"➕" forState:UIControlStateNormal];
    [_customBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_customBtn];
    self.navigationItem.rightBarButtonItem = btn;
    
}

//弹框点击事件
- (void)btnClick:(id)btn {
        CGPoint point = CGPointMake(_customBtn.center.x,_customBtn.frame.origin.y + 64);
        XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfRightUp Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
        view1.dataArray = @[@"我要报修",@"我要报失",@"我要评价",@"退出"];
        view1.images = @[@"menu_QR",@"menu_addFri",@"menu_multichat",@"menu_sendFile",@"menu_facetoface",@"menu_payMoney"];
        view1.fontSize = 13;
        view1.row_height = 40;
        view1.delegate = self;
        [view1 popView];
}

- (void)selectIndexPathRow:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"我要保修");
        }
            break;
        case 1:
        {
            NSLog(@"我要报失");
        }
            break;
        case 2:
        {
            NSLog(@"我要评价");
        }
            break;
        case 3:
        {
            NSLog(@"退出");
        }
            break;
        default:
            break;
    }
}

#pragma mark -----------viewDidLoad------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRightBtn];
    self.navigationItem.title = @"大厅";
    //改变导航条背景颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.1 green:.5 blue:.9 alpha:1.0];
    //设置导航栏
    [self addCollectionView];
    [self imageWithImage];
    //添加底部Button功能键
    [self addView];
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_item_catalogs@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(actionOnLeftBarBtnTaped)];
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"NavVC"];
    [self addChildViewController:nav];
    _list = nav.viewControllers.firstObject;
    _list.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_list.view];
    
    [self.view.window bringSubviewToFront:_list.view];
    _list.view.frame = CGRectMake(-[UIScreen mainScreen].bounds.size.width, 64, self.view.frame.size.width, self.view.frame.size.height-40);
    __weak MainVC *article = self;
    _list.dismissListVC = ^(MoreInfoVC *info){
        [article backView];
        [article.navigationController pushViewController:info animated:NO];
    };
    
    UIScreenEdgePanGestureRecognizer *screenPanLeft = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(leftEdgeGestureAction:)];
    screenPanLeft.edges = UIRectEdgeLeft;
    [_collection addGestureRecognizer:screenPanLeft];
    // 屏幕右部偏移
    UIScreenEdgePanGestureRecognizer *screenPanRight = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(rightEdgeGestureAction:)];
    screenPanRight.edges = UIRectEdgeRight;
    [_collection addGestureRecognizer:screenPanRight];
}


#pragma mark -- --------  轮播图片显示 ----------

-(void)imageWithImage{
    NSArray *arr = @[@"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg",//网络图片
//        @"http://pic26.nipic.com/20121215/11331462_111500606000_2.jpg",
        [UIImage imageNamed:@"3.jpg"],//本地图片，传image，不能传名称
        //网络gif图片
        @"http://pic10.nipic.com/20101103/5063545_000227976000_2.jpg",
        gifImageNamed(@"4")];//本地gif使用gifImageNamed(name)函数创建
  NSArray *describeArray = @[@"博学笃行", @"明德至善", @"自强不息"];
    self.carouselView = [[XRCarouselView alloc] init];
    self.carouselView.translatesAutoresizingMaskIntoConstraints = NO;
    self.carouselView.imageArray = arr;
    self.carouselView.describeArray = describeArray;
    self.carouselView.delegate = self;
    //每张图片的停留时间
    _carouselView.time = 2;
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    _carouselView.pagePosition = PositionBottomCenter;
    [self.view addSubview:_carouselView];
    [self.carouselView mas_makeConstraints:^(MASConstraintMaker *make)
     
     
//=================轮播图片约束===================//
    {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
            make.height.equalTo(@154);
        }else if (kDevice_Is_iPhone6){
            make.height.equalTo(@164);
        }else{
            make.height.equalTo(@174);
//        make.bottom.equalTo(self.view.mas_top).with.offset(170);
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [XRCarouselView clearDiskCache];
}

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);
}


#pragma mark    ------------ 抽屉动画 ----------

- (void)backView {
    [UIView animateWithDuration:.5 animations:^{
        _list.view.transform = CGAffineTransformIdentity;
        _collection.transform = CGAffineTransformIdentity;
    }
    completion:^(BOOL finished) {
    if (_tap) {
        [_collection removeGestureRecognizer:_tap];
                             _tap = nil;
    }
        _leftBtnTaped = !_leftBtnTaped;
        _gestureTag = !_gestureTag;
    }];
}

//点击左边的弹出按钮
- (void)actionOnLeftBarBtnTaped {
    if (_leftBtnTaped) {
        [self backView];
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        _list.view.transform = CGAffineTransformMakeTranslation(200, 0);
        _collection.transform = CGAffineTransformMakeTranslation(200, 0);
        _gestureTag = YES;
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backView)];
    } completion:^(BOOL finished) {
        if (![_collection.gestureRecognizers containsObject:_tap]) {
            [_collection addGestureRecognizer:_tap];
        }
        _leftBtnTaped = !_leftBtnTaped;
    }];
}

- (void)leftEdgeGestureAction:(UIScreenEdgePanGestureRecognizer *)screenPan {
    
    CGPoint point = [screenPan translationInView:self.view];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _collection.transform = CGAffineTransformMakeTranslation(point.x, 0);
    _list.view.transform = CGAffineTransformMakeTranslation(point.x, 0);
    if (screenPan.state == UIGestureRecognizerStateEnded) {
        if (point.x < width / 2) {
            [self backView];
        } else {
            [self actionOnLeftBarBtnTaped];
            _gestureTag = YES;
        }
    }
}

- (void)rightEdgeGestureAction:(UIScreenEdgePanGestureRecognizer *)screenPan {
    if (!_gestureTag) {
        return;
    }
    CGPoint point = [screenPan translationInView:self.view];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    _collection.transform = CGAffineTransformMakeTranslation(200 + point.x, 0);
    _list.view.transform = CGAffineTransformMakeTranslation(200 + point.x, 0);
    if (screenPan.state == UIGestureRecognizerStateEnded) {
        if (abs((int)point.x) < width / 2) {
            [self actionOnLeftBarBtnTaped];
            _gestureTag = NO;
        } else {
            [self backView];
        }
    }
}


#pragma  mark -------------- 添加collectionview ----------

-(void)addCollectionView{
    _data = [NSMutableArray array];
    for (int index = 0; index <12; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"32Y%d.png",index]];
        [_data addObject:image];
    }
    //创建布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionview展示方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collection.delegate =self;
    self.collection.dataSource =self;
    self.collection.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_collection];
 
    
 //===================CollectionView约束=================//
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
            make.bottom.equalTo(self.view).with.offset(-144);
        }else if (kDevice_Is_iPhone6){
            make.bottom.equalTo(self.view).with.offset(-145);
        }else{
            make.bottom.equalTo(self.view).with.offset(-149);
        }
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
            make.top.equalTo(self.view.mas_top).with.offset(154);
        }else if (kDevice_Is_iPhone6){
            make.top.equalTo(self.view.mas_top).with.offset(164);
        }else{
        make.top.equalTo(self.view.mas_top).with.offset(174);
        }
    }];
    
    //注册重复使用的cell
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:KcollectionViewCellID];
    //注册重复使用的headerView和footerView
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:KReusableHeaderView];
    [self.collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KReusableFooterView];
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.collection addGestureRecognizer:longPress];
    
}

#pragma mark ---- collection delegate datasource -----

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   UICollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:KcollectionViewCellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UICollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:KcollectionViewCellID forIndexPath:indexPath];
        UIImageView *image = [[UIImageView alloc] initWithImage:_data[indexPath.row]];
        cell.backgroundView = image;
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }else{
        UICollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:KcollectionViewCellID forIndexPath:indexPath];
        UIImageView *img = [[UIImageView alloc]initWithImage:_data[indexPath.row]];
        cell.backgroundView = img;
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

//设定图标重复显示次数 section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableView;
    reusableView = [self.collection dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:KReusableFooterView forIndexPath:indexPath];
//    footer所显示的空白区域(上)
    UILabel *lab = [[UILabel alloc] init];
        lab.backgroundColor = [UIColor whiteColor];
        [reusableView addSubview:lab];
    lab.translatesAutoresizingMaskIntoConstraints = NO;
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@20);
            make.top.equalTo(reusableView.mas_bottom).with.offset(1);
            make.centerY.equalTo(reusableView);
    }];
    
    UIImage *image = [UIImage imageNamed:@"centra.png"];
    _img = [[UIImageView alloc] initWithImage:image];
    [reusableView addSubview:_img];
    self.img.translatesAutoresizingMaskIntoConstraints = YES;

    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(lab.mas_bottom);
        make.bottom.equalTo(self.collection.mas_bottom);
    }];
    
    
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    if (indexPath.section ==0) {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/4-.5, ScreenW/4-.5);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/4-.5, ScreenW/4-.5);        return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/4-.5, ScreenW/4-.5);
            return size;
        }
    }else{
        CGSize size = CGSizeMake(ScreenW/4-.5, ScreenW/4-.5);
        return size;
    }
    return size;
}

//设置cell与边缘的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets inset = UIEdgeInsetsMake(0, 0, .2, .2);
    return inset;
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return .5;
}

//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return .3;
}

//设置header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 0);
    return size;
}

//设置footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 20);
    return size;
}

#pragma mark --collectionview delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击section%ld的第%ld个cell",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.row == 0) {
        NewsVC *V = [self.storyboard instantiateViewControllerWithIdentifier:@"news"];
        [self presentViewController:V animated:YES completion:nil];
    }else if (indexPath.row ==1){
        NotificationVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"Notification"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.row ==2){
        BaoXiuVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"baoxiu"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.row ==3){
        shiwuVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"lost"];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (indexPath.row == 4){
        Fuwujiandu *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"fuwujiandu"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.row == 5){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂未开通" message:Nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //用户点击取消如果不做处理直接dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 6){
        SecondMarketVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"market"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.row ==7){
        //公寓管理
        MangerVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"department"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.row == 8){
    CarViewController  *carVC = [[CarViewController alloc]init];
//为当前控制器添加导航控制器
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:carVC];
    [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.row == 9){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂未开通" message:Nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //用户点击取消如果不做处理直接dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 10){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂未开通" message:Nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            //用户点击取消如果不做处理直接dismiss
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action1];
        [alert addAction:action2];
        [self presentViewController:alert animated:YES completion:nil];
    }else if (indexPath.row == 11){
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
}

#pragma mark -----------添加底部四个功能键


-(void)addView{

    UIView *Bottomview = [[NSBundle mainBundle]loadNibNamed:@"MainMv" owner:self options:nil].firstObject;
    if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
        Bottomview.frame = CGRectMake(0, ScreenH - TabbarH - 90, ScreenW, 90);
    }else if (kDevice_Is_iPhone6){
        Bottomview.frame = CGRectMake(0, ScreenH - TabbarH - 100, ScreenW, 100);
    }else{
        Bottomview.frame = CGRectMake(0, ScreenH -TabbarH - 105, ScreenW, 105);
    }
    [self.view addSubview:Bottomview];
    
}


#pragma mark ----中间图片展示

-(void)addImageWithCentra{
    UIImage *image = [UIImage imageNamed:@"centra.png"];
   _img = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:_img];
    self.img.translatesAutoresizingMaskIntoConstraints = NO;
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(self.collection.mas_bottom).with.offset(-50);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-160);
    }];
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
