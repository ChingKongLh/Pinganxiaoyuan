//
//  SecondMarketVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "SecondMarketVC.h"
#import "Common.h"
@interface SecondMarketVC ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UICollectionView *collectionview;
@end
@implementation SecondMarketVC

-(void)viewDidLoad{

    //初始化FlowLayout布局样式
//UICollectionViewFlowLayout *flowlayout = [UICollectionViewFlowLayout ]
    //初始化CollectionView
//    _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:];
    
    
}





- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
