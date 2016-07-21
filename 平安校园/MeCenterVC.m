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
#import "Common.h"
@interface MeCenterVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic)NSInteger tag;
@property (nonatomic,strong) NSMutableArray *MeCentraArrays;
//@property (nonatomic,strong)UICollectionView *collectioview;
@end
static NSString *itemidentify = @"itemclass";
static NSString *footeridentify = @"footer";
@implementation MeCenterVC

//懒加载plist文件
-(NSArray *)MeCentraArrays{
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

-(void)viewDidLoad {
   [super viewDidLoad];
    [self addScrollViewWithTable];
    
    _MeCentraArrays = [NSMutableArray array];
    for (int index = 0; index <12; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"32Y%d.png",index]];
        [_MeCentraArrays addObject:image];
    }

    self.navigationController.navigationBar.barTintColor = [UIColor darkGrayColor];
    self.view.backgroundColor = [UIColor whiteColor];
}


-(void)addScrollViewWithTable{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenW/2-.5, 50);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.headerReferenceSize = CGSizeMake(ScreenW, 44);
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 8, 8, 20);
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    //创建并添加colllectionview;
    UICollectionView *collectioview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 114, ScreenW, ScreenH - 114) collectionViewLayout:flowLayout];
    collectioview.delegate = self;
    collectioview.dataSource = self;
    collectioview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectioview];
    
    //注册item
//    [collectioview registerNib:[UINib nibWithNibName:NSStringFromClass([MeCentraview class]) bundle:nil] forCellWithReuseIdentifier:itemidentify];
    [collectioview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:itemidentify];
    
    //注册section Footer
    [collectioview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify];
}

#pragma mark ---------CollectionView Datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//item数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return  self.MeCentraArrays.count;
}

//item内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeCentraview *cell =[collectionView dequeueReusableCellWithReuseIdentifier:itemidentify forIndexPath:indexPath];
    MeCentraModel *model = self.MeCentraArrays[indexPath.item];
    cell.model = model;
    return cell;
}

//CollectionView HeaderView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview =nil;
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footeridentify forIndexPath:indexPath];
        reusableview.backgroundColor = [UIColor whiteColor];
    }
    return reusableview;
}

#pragma mark ---------- CollectionVie Delegate

//设置单个item大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    if (indexPath.section ==0) {
        if (KDevice_Is_Retina || kDevice_Is_iPhone5) {
            CGSize size = CGSizeMake(ScreenW/2-.5, 50);
            return size;
        }else if(kDevice_Is_iPhone6) {
            CGSize size = CGSizeMake(ScreenW/2-.5, 55);
            return size;
        }else{
            CGSize size = CGSizeMake(ScreenW/2-.5, 60);
            return size;
        }
    }else {
        CGSize size = CGSizeMake(ScreenW/4-.5, 50);
        return size;
    }
    return size;

}

//section缩进
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 5;
}

//两个相邻的item间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//sectionheaderView的size(当collectionView垂直滚动的时候size的height起作用,水平滚动,反之)
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return CGSizeMake(100 , 50);
    }
    return CGSizeMake(90, 50);
}

//响应action
-(void)collectionView:(UICollectionView *)collectionView performAction:(nonnull SEL)action forItemAtIndexPath:(nonnull NSIndexPath *)indexPath withSender:(nullable id)sender{
    if (action == @selector(copy:)) {
        NSLog(@"copy");
    }else if (action == @selector(paste:)){
        NSLog(@"paste");
    }
    
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
