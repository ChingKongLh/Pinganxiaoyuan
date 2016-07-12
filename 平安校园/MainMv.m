//
//  MainMv.m
//  平安校园
//
//  Created by 中国孔 on 16/7/11.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "MainMv.h"
#import "MainM.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
@interface MainMv ()
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *label;

@end
@implementation MainMv

-(void)setModel:(MainM *)model{
    _model = model;
    if (kDevice_Is_iPhone5 || KDevice_Is_Retina) {
        _img.layer.cornerRadius = 3;
        _label.font=[UIFont systemFontOfSize:13];
    }else if (kDevice_Is_iPhone6){
        _img.layer.cornerRadius = 4;
        _label.font = [UIFont systemFontOfSize:15];
    }else{
        _label.font = [UIFont systemFontOfSize:17];
        _img.layer.cornerRadius = 6;
    }
    
    _label.text = model.name;
    NSString *urlStr = [NSString stringWithFormat:@"http://pic.ecook.cn/web/%@.jpg!m2",model.imageid];
    [_img sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    _img.layer.masksToBounds = YES;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    

}

- (void)awakeFromNib {
    
}

@end
