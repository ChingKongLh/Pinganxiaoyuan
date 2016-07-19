//
//  HTextViewCell.m
//  平安校园
//
//  Created by 中国孔 on 16/7/15.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "HTextViewCell.h"
#import "UITextField+IndexPath.h"
@interface HTextViewCell ()
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *label;

@end

@implementation HTextViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.label];
    }
    return self;
}

-(void)setTitleString:(NSString *)titlestring andDataString:(NSString *)dataString andIndexPath:(NSIndexPath *)indexpath{
    self.textField.indexPath =indexpath;
    self.textField.text = dataString;
    self.label.text = titlestring;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(110, 20, 400, 50)];
    }
    return _textField;
}

-(UILabel *)label{

    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 40)];
    }
    return _label;
}


- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
