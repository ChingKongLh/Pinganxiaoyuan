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
@interface MainVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

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
@end
static NSString *identifier = @"item";
static NSString *identifiercell = @"cell";
@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"大厅";
    _collection.delegate =self;
    _collection.dataSource =self;
    _collection.backgroundColor = [UIColor clearColor];
    [_collection registerNib:[UINib nibWithNibName:NSStringFromClass([MainMv class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    
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

    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainMv *item =[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    MainM  *model = self.datas[indexPath.item];
    item.model = model;
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
        return CGSizeMake(ScreenW/2-2, 150);
    }else if(kDevice_Is_iPhone6) {
        return CGSizeMake(ScreenW/2-2, 180);
    }else{
        return CGSizeMake(ScreenW/2-2, 220);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}


//点击item跳转事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailVC *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"contrentvc"];
        MainM *model = self.datas[indexPath.item];
        vc.idString = model.ids;
        [self.navigationController pushViewController:vc animated:YES];
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
