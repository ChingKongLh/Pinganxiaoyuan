//
//  HistoryCell.m
//  平安校园
//
//  Created by 中国孔 on 16/8/4.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "HistoryCell.h"
#import "UIImageView+WebCache.h"
@interface HistoryCell ()
@property (strong, nonatomic) IBOutlet UIImageView *imag;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
@implementation HistoryCell

-(void)setModel:(Alertmodel *)model{
    _model = model;
    [self.imag sd_setImageWithURL:[NSURL URLWithString:model.img]];
    self.time.text = model.time;
    self.status.text = model.status;
    self.title.text = model.title;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
