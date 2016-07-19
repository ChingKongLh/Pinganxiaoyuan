//
//  NoteView.h
//  平安校园
//
//  Created by 中国孔 on 16/7/18.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NoteMode;
@interface NoteView : UITableViewCell
@property (nonatomic,strong)NoteMode *model;
@end
