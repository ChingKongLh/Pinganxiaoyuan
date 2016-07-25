//
//  TimelineCell.h
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineModel.h"
@interface TimelineCell : UITableViewCell
@property (nonatomic,strong)TimeLineModel *timeline;
@property (nonatomic,strong)UIImageView *arrayimageview;
@property (nonatomic,strong)UIImageView *lineImageview;
@property (nonatomic,strong)UILabel *datalabel;
@property (nonatomic,strong)UILabel *myTextLabel;
@property (nonatomic,strong)UIView *timeview;

@property (nonatomic,retain)NSMutableArray *imagearray;
@property (nonatomic,assign)CGFloat *cellheight;

+(instancetype)CellWithTableview:(UITableView *)tableview;

@end
