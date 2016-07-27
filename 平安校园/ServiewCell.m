//
//  ServiewCell.m
//  平安校园
//
//  Created by 中国孔 on 16/7/26.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ServiewCell.h"
#import "ServiceModel.h"
#import "UIImageView+WebCache.h"
@interface ServiewCell ()
@property (strong, nonatomic) IBOutlet UIView *preview;
@property (strong, nonatomic) IBOutlet UIImageView *ServiewIcon;
@property (strong, nonatomic) IBOutlet UILabel *ServiceTitle;
@property (strong, nonatomic) IBOutlet UILabel *ServiceTime;
@property (strong, nonatomic) IBOutlet UIImageView *arrow;

@end
@implementation ServiewCell

-(void)setServiceInfo:(ServiceModel *)serviceInfo{
    _serviceInfo = serviceInfo;
    
    self.ServiceTitle.text = @"最新校历";
    self.ServiceTime.text = @"2016-07-25";
//    self.ServiceTitle.text = serviceInfo.title;
//    self.ServiceTime.text = serviceInfo.time;
//    [self.ServiewIcon sd_setImageWithURL:[NSURL URLWithString:serviceInfo.img]];
    self.ServiewIcon.image = [UIImage imageNamed:@"RiLi.png"];
    self.arrow.image = [UIImage imageNamed:@"appor.png"];
}


- (void)awakeFromNib {
    _preview.layer.shadowRadius = 6;
    _preview.layer.shadowColor = [[UIColor grayColor] CGColor];
    _preview.layer.shadowOffset = CGSizeMake(2, 2);
    _preview.layer.borderWidth = 1;
    _preview.layer.cornerRadius = 6;
    _preview.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
