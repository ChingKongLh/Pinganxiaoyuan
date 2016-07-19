//
//  NoteView.m
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "NoteView.h"
#import "NoteMode.h"
@interface NoteView ()
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *source;


@end

@implementation NoteView

-(void)setModel:(NoteMode *)model{
    _model = model;
    
    _title.text = model.title;
    _content.text = model.content;
    _content.text = model.timer;
    _source.text = model.source;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
