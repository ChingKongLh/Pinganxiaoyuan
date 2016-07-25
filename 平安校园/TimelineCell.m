//
//  TimelineCell.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "TimelineCell.h"
#define TEXTSIZE(string)  [(string) boundingRectWithSize:CGSizeMake(230, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
@implementation TimelineCell

//初始化cell
+(instancetype)CellWithTableview:(UITableView *)tableview{
    static NSString *identify = @"cell";
    TimelineCell *cell = [tableview dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TimelineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imagearray=[NSMutableArray array];
        _datalabel=[[UILabel alloc]initWithFrame:CGRectMake(106, 5, 100, 30)];
        _datalabel.text=@"2016-07-23";
        [self addSubview:_datalabel];
        
        //增加右半部分时间轴线
        _arrayimageview=[[UIImageView alloc]initWithFrame:CGRectMake(85, 10, 13, 13)];
        _arrayimageview.image=[UIImage imageNamed:@"point.png"];
        _lineImageview=[[UIImageView alloc]initWithFrame:CGRectMake(91, 0, 1, 250)];
        _lineImageview.backgroundColor=[UIColor grayColor];
        [self addSubview:_lineImageview];
        [self addSubview:_arrayimageview];
        
        _myTextLabel=[[UILabel alloc]init];
        _myTextLabel.font=[UIFont systemFontOfSize:15];
        _myTextLabel.numberOfLines=0;
        [self timeWithInit:40.0f];
    }
    return self;
}

-(void)setTimeline:(TimeLineModel *)timeline{
    
    for (int i=0; i<[_imagearray count]; i++) {
        UIImageView *imageV=(UIImageView *)[_imagearray objectAtIndex:i];
        if (imageV.superview) {
            [imageV removeFromSuperview];
        }
    }
    [_imagearray removeAllObjects];
    
    for (int i=0; i<[timeline.imageStr count]; i++) {
        UIImageView *smallImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,5 ,70,70)];
        smallImage.userInteractionEnabled = YES;
        
        //       NSDictionary *imageDic=[timeModel.imageList objectAtIndex:i];
        //        [smallImage sd_setImageWithURL:imageDic[@"image"]];
        
        [self addSubview:smallImage];
        [_imagearray addObject:smallImage];
    }

}


-(void)timeWithInit:(CGFloat)aHeight{
    _timeview = [[UIView alloc] initWithFrame:CGRectMake(106, aHeight, 320-120, 200)];
    _timeview.backgroundColor = [UIColor orangeColor];
    [self addSubview:_timeview];
}

- (void)awakeFromNib {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
