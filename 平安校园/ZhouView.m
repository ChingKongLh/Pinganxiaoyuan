//
//  ZhouView.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ZhouView.h"
@implementation ZhouView

+(instancetype)CellWithTableviewCell:(UITableView *)tableview
{
    
    static NSString *identifier= @"Cell";
    ZhouView *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
    
    if (cell==nil) {
        
        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZhouView" owner:nil options:nil]firstObject];
    }
    return cell;
}


//+(instancetype)CellWithTableviewCell:(UITableView *)tableview{
//   
//    static NSString *identifier= @"Cell";
//    ZhouView *cell=[tableview dequeueReusableCellWithIdentifier:identifier];
//    if (cell==nil) {
//        cell=[[[NSBundle mainBundle]loadNibNamed:@"ZhouView" owner:nil options:nil]firstObject];
//    }
//    return cell;
//}
//



- (void)awakeFromNib {
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
