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
@interface MainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,XRCarouselViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collection;
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
@end
static NSString *identifier = @"item";
static NSString *identifiercell = @"cell";
NSString * const KcollectionViewCellID = @"cellID";
NSString * const KReusableHeaderView = @"reuseHeader";
NSString * const KReusableFooterView = @"reuseFooter";
@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大厅";
    
    [self imageWithImage];
    [self addCollectionView];

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
    [self loaddata];
}

#pragma  mark --collection 添加

-(void)addCollectionView{
    
    self.collection.delegate =self;
    self.collection.dataSource =self;
    self.collection.backgroundColor = [UIColor clearColor];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([MainMv class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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


#pragma mark --轮播图片显示

-(void)imageWithImage{
    NSArray *arr = @[@"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg",//网络图片
                     [UIImage imageNamed:@"3.jpg"],//本地图片，传image，不能传名称
                     @"http://photo.l99.com/source/11/1330351552722_cxn26e.gif",//网络gif图片
                     gifImageNamed(@"4")];//本地gif使用gifImageNamed(name)函数创建
//  NSArray *describeArray = @[@"第一张", @"第二张", @"第三张", @"第四张"];
    self.carouselView= [[XRCarouselView alloc] initWithFrame:CGRectMake(0,64, ScreenW,150)];
    self.carouselView.imageArray = arr;
//    self.carouselView.describeArray = describeArray;
    self.carouselView.delegate = self;
    //每张图片的停留时间
    _carouselView.time = 2;
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    _carouselView.pagePosition = PositionBottomCenter;
    [self.view addSubview:_carouselView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [XRCarouselView clearDiskCache];
}

- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index{
    NSLog(@"%ld",(long)index);

}



#pragma  mark --加载网络

-(void)loaddata{
    
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    manger.requestSerializer = [AFHTTPRequestSerializer serializer];
    manger.responseSerializer =[AFJSONResponseSerializer serializer];
    NSString *url = @"http://api.ecook.cn/public/getRecipeListByType.shtml";
    NSArray *parames = @[@{@"type":@"latest"}];
    [manger POST:url parameters:parames progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self updateForResponse:responseObject];
        //刷新控件
//        [self.myCollectionView.mj_header endRefreshing];
        //头部控制的segmentcontrol
//        if (self.mySegment.selectedSegmentIndex == 0 && _isXiang == YES && _index == 0) {
        [SVProgressHUD showSuccessWithStatus:@"加载完成"];
        [_collection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [self.myCollectionView.mj_header endRefreshing];
//        if (self.mySegment.selectedSegmentIndex == 0 && _isXiang == YES && _index == 0){
        [SVProgressHUD showErrorWithStatus:@"加载有误请重试"];
    }];
}

-(void)updateForResponse:(id)obj{

    NSArray *arrays = obj[@"list"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *d in arrays) {
        MainM *model = [MainM modelWithDictionary:d];
        [arr addObject:model];
    }
    _datas = arr;
}


#pragma mark 抽屉动画
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


#pragma mark --collection delegate datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [self.collection dequeueReusableCellWithReuseIdentifier:KcollectionViewCellID forIndexPath:indexPath];
    UIImageView *image = [[UIImageView alloc] initWithImage:_data[indexPath.row]];
    cell.backgroundView = image;
    cell.backgroundColor = [UIColor blueColor];
    return cell;
    //    MainMv *item =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    MainM  *model = self.datas[indexPath.item];
//    item.model = model;
//    return item;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}


//点击item跳转事件
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    DetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"contrentvc"];
//        MainM *model = self.datas[indexPath.item];
//        vc.idString = model.ids;
//        [self.navigationController pushViewController:vc animated:YES];
//}

-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{

    id obj = [_data objectAtIndex:sourceIndexPath.item];
    [_data removeObject:obj];
    [_data insertObject:obj atIndex:destinationIndexPath.item];

}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusableview = [self.collection dequeueReusableCellWithReuseIdentifier:KReusableHeaderView forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"collectionheader";
        [reusableview addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(reusableview);
        }];
    }else{
        reusableview = [self.collection dequeueReusableCellWithReuseIdentifier:KReusableFooterView forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"collectionfooter";
        [reusableview addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(reusableview);
            }];
        }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
    sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
        CGSize size = CGSizeMake((ScreenW-30)/2.0, (ScreenW-30)/2.0);
        return size;
    }else if(kDevice_Is_iPhone6) {
//        return CGSizeMake(ScreenW/2-2, 180);
        CGSize size = CGSizeMake((ScreenW-30)/2.0, (ScreenW-30)/2.0);
        return size;
    }else{
//        return CGSizeMake(ScreenW/2-2, 220);
        CGSize size = CGSizeMake((ScreenW-30)/2.0, (ScreenW-30)/2.0);
        return size;
    }

}

//设置cell与边缘的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    UIEdgeInsets inset = UIEdgeInsetsMake(10, 10, 10, 10);
    return inset;
}

//最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置header高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 30);
    return size;
}

//设置footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(0, 30);
    return size;
}

#pragma mark --collectionview delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击section%ld的第%ld个cell",indexPath.section,indexPath.row);
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
