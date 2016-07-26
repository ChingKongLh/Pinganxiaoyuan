//
//  MarketView.m
//  平安校园
//
//  Created by 中国孔 on 16/7/26.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MarketView.h"
#import "MarketDetail.h"
#import "UIImageView+WebCache.h"
@interface MarketView ()
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *timer;
@property (strong, nonatomic) IBOutlet UILabel *area;
@property (strong, nonatomic) IBOutlet UILabel *level;
@property (strong, nonatomic) IBOutlet UILabel *telephone;

@end
@implementation MarketView

-(void)setDetail:(MarketDetail *)detail{
    _detail = detail;
    self.title.text = detail.title;
    self.content.text = @"100";
    self.timer.text = detail.CreatedAt;
    [self.img sd_setImageWithURL:[NSURL URLWithString:detail.icon]];
    self.area.text = @"东风校区";
    self.level.text = @"八成新";
    self.telephone.text = @"13027703035";
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
