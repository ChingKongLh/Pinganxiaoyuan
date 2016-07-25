//
//  ZhouView.h
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhouView : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lineLabel;
@property (strong, nonatomic) IBOutlet UIImageView *Circle;
@property (strong, nonatomic) IBOutlet UILabel *MonthLabel;

+(instancetype)CellWithTableviewCell:(UITableView *)tableview;

@end
