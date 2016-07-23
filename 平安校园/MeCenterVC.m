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
@interface MeCenterVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic)NSInteger tag;
@property (nonatomic,strong) NSMutableArray *MeCentraArrays;
@property (nonatomic,strong) NSMutableArray *MeCentraArray;
@property (nonatomic,strong)UICollectionView *collectioview;
@end
static NSString *itemidentify = @"itemclass";
static NSString *footeridentify = @"footer";
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
//    flowLayout.headerReferenceSize = CGSizeMake(ScreenW, 10);
//    flowLayout.sectionInset = UIEdgeInsetsMake(10, 8, 8, 10);
//    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    //设置collectionview展示方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建并添加colllectionview;
    _collectioview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 164, ScreenW, ScreenH - 112) collectionViewLayout:flowLayout];
    self.collectioview.delegate = self;
    self.collectioview.dataSource = self;
    self.collectioview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectioview];
    
    //注册item
    [_collectioview registerNib:[UINib nibWithNibName:NSStringFromClass([MeCentraview class]) bundle:nil] forCellWithReuseIdentifier:itemidentify];
    //注册section Footer
    [_collectioview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify];
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
    }else{
    
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
//        MeCentraview *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemidentify forIndexPath:indexPath];
//        MeCentraModel *model = self.MeCentraArrays[indexPath.item];
//        cell.model = model;
//        return cell;
        MeCentraViewS *MecellS = [collectionView dequeueReusableCellWithReuseIdentifier:itemidentify forIndexPath:indexPath];
        MeCentraModelS *MemodelS = self.MeCentraArray[indexPath.item];
        MecellS.models = MemodelS;
        return MecellS;
    }
    return 0;
}
//CollectionView HeaderView
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *reusableview;
//    if (indexPath.section == 0) {
//          reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify forIndexPath:indexPath];
//            reusableview.backgroundColor = [UIColor whiteColor];
//    }
//
//    UILabel *lab = [[UILabel alloc] init];
//    lab.backgroundColor = [UIColor blueColor];
//    [reusableview addSubview:lab];
//    lab.translatesAutoresizingMaskIntoConstraints = NO;
    
//    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify forIndexPath:indexPath];
//        reusableview.backgroundColor = [UIColor whiteColor];
//    }
//    return reusableview;
//}

#pragma mark ---------- CollectionView Delegate

//设置单个item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    if (indexPath.section ==0) {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/2-2.3, 60);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/2-2.5, 70);
            return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/2-2.6, 80);
            return size;
        }
    }else {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/2-2.3, 60);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/2-2.5, 70);
            return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/2-2.6, 80);
            return size;
        }
    }
    return size;
}

//section缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 5, 0, 0);
    }
    return UIEdgeInsetsMake(0, 5, 0, 0);
}

//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 5;
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
            return CGSizeMake(90, 50);
        }else if (kDevice_Is_iPhone6){
            return CGSizeMake(100, 50);
        }else{
        return CGSizeMake(100 , 50);
        }
    }
    return CGSizeMake(110, 50);
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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",indexPath);
    
}



#pragma mark --------- TouBuShiXian -----------

- (IBAction)TitleBtn:(id)sender {
    switch (_tag) {
        case 101:
            //扫码
            
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
