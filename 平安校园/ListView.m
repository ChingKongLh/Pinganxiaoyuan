//
//  ListView.m
//  平安校园
//
//  Created by 中国孔 on 16/8/6.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ListView.h"
#import "Listmodel.h"
#import "UIImageView+WebCache.h"
@interface ListView ()
@property (strong, nonatomic) IBOutlet UIImageView *imag;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *status;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *paihang;
@end

@implementation ListView

-(void)setListmodel:(Listmodel *)listmodel{
    _listmodel = listmodel;
    [self.imag sd_setImageWithURL:[NSURL URLWithString:listmodel.imag]];
    self.time.text = listmodel.time;
    self.title.text = listmodel.title;
    self.status.text = listmodel.status;
    self.paihang.text = listmodel.paihang;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
