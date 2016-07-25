//
//  MeCenterVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/20.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MeCenterVC.h"
#import "MeCentraModel.h"
#import "MeCentraview.h"

#import "MeCentraModelS.h"
#import "MeCentraViewS.h"
#import "Common.h"
#import "Masonry.h"
#import "ImageScanVC.h"

#import "XRCarouselView.h"

#import "NavigationVC.h"
#import "GrowWithLine.h"
@interface MeCenterVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,XRCarouselViewDelegate>
@property (nonatomic)NSInteger tag;
@property (nonatomic,strong) NSMutableArray *MeCentraArrays;
@property (nonatomic,strong) NSMutableArray *MeCentraArray;
@property (nonatomic,strong)UICollectionView *collectioview;

@property (nonatomic,strong)XRCarouselView *CarouseView;
@end
static NSString *itemidentify = @"itemclass";
static NSString *footeridentify = @"footer";
static NSString *headeridentify = @"header";
@implementation MeCenterVC

//懒加载plist文件
-(NSMutableArray *)MeCentraArrays{
    if (_MeCentraArrays == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        NSArray *filpath = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in filpath) {
            MeCentraModel *appmodel = [MeCentraModel appModelWithDictionary:dict];
            [model addObject:appmodel];
        }
        _MeCentraArrays = model;
    }
    return _MeCentraArrays;
}

-(NSMutableArray *)MeCentraArray{
    if (_MeCentraArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"App" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            MeCentraModelS *appmodel = [MeCentraModelS appModelWithDictionary:dict];
            [model addObject:appmodel];
        }
        _MeCentraArray = model;
    }
    return _MeCentraArray;
}

-(void)viewDidLoad {
   [super viewDidLoad];
    [self addScrollViewWithTable];
    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
}

-(void)addScrollViewWithTable{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
//    flowLayout.itemSize = CGSizeMake(ScreenW/2-.5, 0);
//    flowLayout.minimumInteritemSpacing = 2;
//    flowLayout.headerReferenceSize = CGSizeMake(ScreenW, -20);
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 8, 8, 10);
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(_collectioview.frame.size.width,0)];
    //设置collectionview展示方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建并添加colllectionview;
    _collectioview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectioview.delegate = self;
    self.collectioview.dataSource = self;
    self.collectioview.pagingEnabled = NO;
    self.collectioview.showsHorizontalScrollIndicator = NO;
    _collectioview.frame =CGRectMake(0, 164, ScreenW, ScreenH );
    self.collectioview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectioview];
    
    //注册item
    [_collectioview registerNib:[UINib nibWithNibName:NSStringFromClass([MeCentraview class]) bundle:nil] forCellWithReuseIdentifier:itemidentify];
    //注册section Footer
    [_collectioview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify];
    [_collectioview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify];
}

#pragma mark --------CollectionFooter 轮播图片展示

-(void)addImageWithCollectionFooter{
    NSArray *arr = @[@"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg",//网络图片
                     [UIImage imageNamed:@"3.jpg"],//本地图片，传image，不能传名称
                     //网络gif图片
                     gifImageNamed(@"4")];//本地gif使用gifImageNamed(name)函数创建
    NSArray *describeArray = @[@"",@"",@""];
    self.CarouseView = [[XRCarouselView alloc] init];
    self.CarouseView.translatesAutoresizingMaskIntoConstraints = NO;
    self.CarouseView.imageArray = arr;
    self.CarouseView.describeArray = describeArray;
    self.CarouseView.delegate = self;
    _CarouseView.time = 2;
    [_CarouseView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    _CarouseView.pagePosition = PositionBottomCenter;
    [self.view addSubview:_CarouseView];


    
}


#pragma mark ---------CollectionView Datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

//item数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return self.MeCentraArrays.count;
    }else if (section == 1){
        return self.MeCentraArray.count;
    }
    return 0;
}

//item内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MeCentraview *cell =[collectionView dequeueReusableCellWithReuseIdentifier:itemidentify forIndexPath:indexPath];
        MeCentraModel *Memodel = self.MeCentraArrays[indexPath.item];
        cell.model = Memodel;
        return cell;
    }else if (indexPath.section == 1){
        MeCentraViewS *MecellS = [collectionView dequeueReusableCellWithReuseIdentifier:itemidentify forIndexPath:indexPath];
        MeCentraModelS *MemodelS = self.MeCentraArray[indexPath.item];
        MecellS.model = MemodelS;
        return MecellS;
    }
    return 0;
}
//CollectionView HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview =nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headeridentify forIndexPath:indexPath];
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH -335, ScreenW,60)];
            view.backgroundColor = [UIColor blueColor];
            [header addSubview:view];
            UIImageView *img = [[UIImageView alloc] initWithFrame:self.view.frame];
            [img setImage:[UIImage imageNamed:@""]];
            [view addSubview:img];
        }else if (kDevice_Is_iPhone6){
            NSArray *arr = @[@"1.jpg",//网络图片
                                     @"http://pic24.nipic.com/20121022/10003357_163524027396_2.jpg",
                             @"http://pic59.nipic.com/file/20150123/10310831_101213911000_2.jpg",
//                             [UIImage imageNamed:@"3.jpg"],//本地图片，传image，不能传名称
                             //网络gif图片
//                             @"",
                             gifImageNamed(@"4")];
            NSArray *describeArray = @[@"",@"",@""];
            self.CarouseView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, ScreenH -368, ScreenW,65)];
            self.CarouseView.translatesAutoresizingMaskIntoConstraints = NO;
            self.CarouseView.imageArray = arr;
            self.CarouseView.describeArray = describeArray;
            self.CarouseView.delegate = self;
            _CarouseView.time = 2;
            _CarouseView.pagePosition = PositionBottomCenter;
            [header addSubview:_CarouseView];
        }else{
         UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH -380, ScreenW,70)];
            view.backgroundColor = [UIColor blueColor];
            [header addSubview:view];
        }
        reusableview = header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify forIndexPath:indexPath];
        reusableview = footer;
    }
    return reusableview;
}

#pragma mark ---------- CollectionView Delegate

//设置单个item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    if (indexPath.section ==0) {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/2-.1, 60);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/2-.1, 70);
            return size;
        }else if (kDevice_Is_iPhone6Plus){
            CGSize size = CGSizeMake(ScreenW/2-.1, 80);
            return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/2-.1, 70);
            return size;
        }
    }else {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/2-.1, 60);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/2-.1, 70);
            return size;
        }else if(kDevice_Is_iPhone6Plus) {
            CGSize size = CGSizeMake(ScreenW/2-.1, 80);
            return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/2-.1, 70);
            return size;
        }
    }
    return size;
}

//section缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 0;
}

//两个相邻的item间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
    return 0;
    }
}
//sectionheaderView的size(当collectionView垂直滚动的时候size的height起作用,水平滚动,反之)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
            return CGSizeMake(90, 17);
        }else if (kDevice_Is_iPhone6){
            return CGSizeMake(80,18);
        }else{
        return CGSizeMake(105 ,19);
        }
    }else if (section == 1){
        if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
            return CGSizeMake(90, 60);
        }else if (kDevice_Is_iPhone6){
            return CGSizeMake(100, 65);
        }else{
            return CGSizeMake(105, 85);
        }
}
    return CGSizeMake(110, 40);
}

//设置collectionview 的footer高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (section == 0) {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            return CGSizeMake(ScreenW, 30);
        }else if (kDevice_Is_iPhone6){
            return CGSizeMake(ScreenW, 25);
        }else{
        return CGSizeMake(ScreenW, 20);
        }
    }
    return CGSizeMake(screenWidth,0);
}

//响应action
-(void)collectionView:(UICollectionView *)collectionView performAction:(nonnull SEL)action forItemAtIndexPath:(nonnull NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (action == @selector(copy:)) {
        NSLog(@"copy");
    }else if (action == @selector(paste:)){
        NSLog(@"paste");
    }
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"点击section%ld的第%ld个cell",(long)indexPath.section,(long)indexPath.row);
    if (indexPath.section == 0 && indexPath.row == 0) {
        //新生导航页面
        NavigationVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"navigation"];
        [self presentViewController:VC animated:YES completion:nil];
    }else if (indexPath.section == 0 && indexPath.row == 1){
        GrowWithLine *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"shijian"];
        [self presentViewController:VC animated:YES completion:nil];
        
    }else if (indexPath.section == 0 && indexPath.row == 2){
    
    }else if (indexPath.section == 0 && indexPath.row == 3){
    
    }else if (indexPath.section == 0 && indexPath.row == 4){
    
    }else if (indexPath.section == 0 && indexPath.row == 5){
    
    }else if (indexPath.section == 1 && indexPath.row == 0){
    
    }else if (indexPath.section == 1 && indexPath.row == 1){
    
    }
}


#pragma mark --------- TouBuShiXian -----------

- (IBAction)TitleBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 101:
            //扫码
            [self addScanImgeView];
            break;
            case 102:
            //足迹

            break;
            case 103:
            //发现

            break;
            case 104:
            //未开放区
            
            break;
        default:
            break;
    }
}

-(void)addScanImgeView{
    ImageScanVC *image = [self.storyboard instantiateViewControllerWithIdentifier:@"image"];
    [self presentViewController:image animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
