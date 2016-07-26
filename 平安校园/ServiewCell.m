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
@property (strong, nonatomic) IBOutlet UIImageView *ServiewIcon;
@property (strong, nonatomic) IBOutlet UILabel *ServiceTitle;
@property (strong, nonatomic) IBOutlet UILabel *ServiceTime;

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
}



- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
