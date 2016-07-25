//
//  TimeLineView.m
//  平安校园
//
//  Created by 中国孔 on 16/7/25.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "TimeLineView.h"
#import "DateModel.h"
#import "ZhouView.h"
#import "Common.h"
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])
@interface TimeLineView ()
{
    UITableView *tabelView;
    NSMutableArray *_CurrentArray;
    NSArray *testArray;
    NSArray *testArray1;
    NSArray *tempArray;
    
    NSArray *_allDataArray;
    
    NSString *stastusStr;
}
@property (nonatomic,strong)NSMutableDictionary *dictionary;

@end

@implementation TimeLineView

-(id)initWithDataArray:(NSArray *)dataArray{
    self.dictionary = [NSMutableDictionary dictionary];
    self = [super initWithFrame:CGRectMake(5, 64, 80, ScreenH)];
    if (self) {
        NSLog(@"%@",dataArray);
        [self timeTableArray:dataArray];
    }
    return self;
}


-(void)timeTableArray:(NSArray *)timeTableArray{
    testArray=@[@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December"];
    testArray1=@[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
    [self initWithData:timeTableArray];
    tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 60, ScreenH) style:UITableViewStylePlain];
    tabelView.showsVerticalScrollIndicator = NO;
    tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tabelView.dataSource = self;
    tabelView.delegate = self;
    [self addSubview:tabelView];
}

-(void)initWithData:(NSArray *)timeDate{
    _dataArray = [NSMutableArray array];
    _allDataArray = @[@{@"year":@"2015",@"month":testArray,@"status":@"0"},@{@"year":@"2014",@"month":testArray1,@"status":@"1"}];
    [_allDataArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_dataArray addObject:[DateModel statusWithDictionary:obj]];
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DateModel *model = self.dataArray[section];
    NSArray *sectionarray = model.month;
    return sectionarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhouView *cell = [ZhouView CellWithTableviewCell:tabelView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //设置圆角
    cell.Circle.layer.cornerRadius = 3;
    if ([_dataArray objectAtIndex:indexPath.section]) {
        DateModel *model = self.dataArray[indexPath.section];
        if (model.islength == NO) {
            NSArray *classarray = model.month;
            cell.MonthLabel.text = [classarray objectAtIndex:indexPath.row];
            cell.lineLabel.hidden = NO;
            cell.Circle.hidden = NO;
        }else{
        cell.MonthLabel.text = @"博雅讯出品";
        cell.lineLabel.hidden = YES;
        cell.lineLabel.hidden = YES;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton*btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44,44);
    btn.backgroundColor=[UIColor clearColor];
    btn.tag = section;
    
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(12, 29, 8, 8)];
    image.layer.cornerRadius=4;
    image.backgroundColor=[UIColor blackColor];
    
    UILabel *dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(26, 23,40, 20)];
    dateLabel.font=[UIFont systemFontOfSize:14];
    
    DateModel *sharData=self.dataArray[section];
    dateLabel.text=sharData.year;
    [btn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [view addSubview:dateLabel];
    [view addSubview:image];
    
    return view;
}
- (void)expand:(UIButton*)btn
{
    DateModel *dateData=self.dataArray[btn.tag];
    if (dateData.islength==NO) {
        dateData.islength=YES;
    }
    else {
        dateData.islength=NO;
    }
    [tabelView reloadData];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_dataArray objectAtIndex:indexPath.section]) {
        DateModel *sharData=self.dataArray[indexPath.section];
        if (sharData.islength==NO) {
            return 56;
        }
        else{
            return 0;
        }
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhouView *cell = (ZhouView *)[tabelView cellForRowAtIndexPath:indexPath];
    DateModel *model = self.dataArray[indexPath.section];
    NSString *str = [NSString stringWithFormat:@"%@-%@",model.year,cell.MonthLabel.text];
    [_delegate timeStr:str];
}










@end
