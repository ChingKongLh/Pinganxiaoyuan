//
//  MeCentraview.m
//  平安校园
//
//  Created by 中国孔 on 16/7/21.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MeCentraview.h"
#import "MeCentraModel.h"
@interface MeCentraview ()

@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *detailTitle;

@end
@implementation MeCentraview

-(void)setModel:(MeCentraModel *)model{
    _model = model;
    _title.text = model.title;
    _detailTitle.text = model.detailTitle;
    _icon.image= [UIImage imageNamed:model.icon];
}

- (void)awakeFromNib {
    // Initialization code
}

@end
