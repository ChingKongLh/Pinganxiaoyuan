//
//  TimeLineView.h
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  timeviewDelegate<NSObject>

-(void)timeStr:(NSString *)Str;
@end

@interface TimeLineView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)id <timeviewDelegate>delegate;

-(id)initWithDataArray:(NSArray *)dataArray;

@end
