//
//  MeCentraViewS.m
//  平安校园
//
//  Created by 中国孔 on 16/7/22.
//  Copyright © 2016年 中国孔. All rights reserved.


#import "MeCentraViewS.h"
#import "MeCentraModelS.h"
@interface MeCentraViewS ()
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *detailTitle;

@end
@implementation MeCentraViewS

-(void)setModels:(MeCentraModelS *)models{
    _models = models;
    _title.text= models.title;
    _detailTitle.text = models.title;
    _icon.image = [UIImage imageNamed:models.icon];
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
