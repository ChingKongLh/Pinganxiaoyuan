//
//  CarViewController.m
//  Car
//
//  Created by Max on 16/5/3.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "CarViewController.h"
#import "NoteViewController.h"
#import "ContactViewController.h"
#import "ModelsTableViewController.h"
#import "StartTableViewController.h"
#import "FinishTableViewController.h"
#import "StartTableViewController.h"
#import "FinishTableViewController.h"
#import "PathwayTableViewController.h"
#import "SubmitViewController.h"
#import "PrefixHeader.pch"
#import "MainVC.h"
@interface CarViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,NoteViewControllerDelegate,ModelsTableViewControllerDelegate,ContactViewControllerdelegate,StartTableViewControllerdelegate,FinishTableViewControllerdelegate> {
    
        NSMutableArray *_allData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIButton *button;
@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)NSString *dateString;
@property (nonatomic,strong)NSString *modeString;
@property (nonatomic,strong)NSString *persString;
@property (nonatomic,strong)NSString *noteString;
@property (nonatomic,strong)NSString *contString;
@property (nonatomic,strong)NSString *starString;
@property (nonatomic,strong)NSString *finiString;
@property (nonatomic,strong)NSMutableArray *pathAry;

@end

@implementation CarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self updateUi];
}


//更新UI
- (void)updateUi {

    self.title = @"我要用车";
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = back;
    [self.navigationController.navigationBar setBarTintColor:RGBCOLOR(254, 243, 108)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    _pathAry = [[NSMutableArray alloc] init];
    //设定tableviewcell添加内容 图标，标题，出发时间
    NSDictionary *dic = @{@"picture":@"未标题-1_0000_圆角矩形-4",@"title":@"出发时间"};
    NSDictionary *dic1 = @{@"picture":@"未标题-1_0001_形状-10-副本-42",@"title":@"起点"};
    NSDictionary *dic2 = @{@"picture":@"未标题-1_0002_形状-10-副本-46",@"title":@"终点"};
    NSDictionary *dic3 = @{@"picture":@"未标题-1_0003_椭圆-6",@"title":@"车型"};
    NSDictionary *dic4 = @{@"picture":@"未标题-1_0005_形状-38",@"title":@"联系人"};
    NSDictionary *dic5 = @{@"picture":@"未标题-1_0003_椭圆-6",@"title":@"人数"};
    NSDictionary *dic6 = @{@"picture":@"未标题-1_0006_椭圆-7",@"title":@"备注"};
    _allData = [[NSMutableArray alloc]initWithObjects:dic,dic1,dic2,dic3,dic4,dic5,dic6, nil];
}



//--------------------------返回方式需要调整

-(void)back{
    MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allData.count;
}

//设定每行cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }else {
        cell.detailTextLabel.text = nil;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = _allData[indexPath.row][@"title"];
    cell.imageView.image = [UIImage imageNamed:_allData[indexPath.row][@"picture"]];
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = _dateString;
           }
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = _starString;
    }
    long idx4 = _allData.count - 5;
    if (indexPath.row == idx4) {
        cell.detailTextLabel.text = _finiString;
    }
    long idx3 = _allData.count - 4;
    if (indexPath.row == idx3) {
        cell.detailTextLabel.text = _modeString;
        }
    long int idx2 = _allData.count - 3;
    if (indexPath.row == idx2) {
        cell.detailTextLabel.text = _contString;
    }
    long int idx1 = _allData.count - 2;
    if (indexPath.row == idx1) {
        cell.detailTextLabel.text = _persString;
       
    }
    long int idx = _allData.count - 1;
    if (indexPath.row == idx) {
        cell.detailTextLabel.text = _noteString;
    }
    if (indexPath.row >1 && indexPath.row<idx4) {
    
        if (_pathAry.count > indexPath.row-2) {
            cell.detailTextLabel.text = [_pathAry objectAtIndex:indexPath.row-2];
        }
    }
    return cell;

}

 //选中每行cell干什么
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

   [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-216, self.view.frame.size.width, 216)];
        self.datePicker.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.view addSubview:self.datePicker];
        //设置显示格式
        
        //默认根据手机本地设置显示为中文还是其他语言
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//设置为中文显示
        self.datePicker.locale = locale;
    
        //当前时间创建NSDate
        NSDate *localDate = [NSDate date];
        
        //在当前时间加上的时间：格里高利历
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        //设置时间
        [offsetComponents setYear:0];
        [offsetComponents setMonth:0];
        [offsetComponents setDay:5];
        [offsetComponents setHour:20];
        [offsetComponents setMinute:0];
        [offsetComponents setSecond:0];
        //设置最大值时间
        NSDate *maxDate = [gregorian dateByAddingComponents:offsetComponents toDate:localDate options:0];
        //设置属性
        self.datePicker.minimumDate = localDate;
        self.datePicker.maximumDate = maxDate;
self.button = [[UIButton alloc]initWithFrame:CGRectMake(8, self.view.frame.size.height-256,self.view.frame.size.width-16, 40)];
        [self.button setTitle:@"确定" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.button.backgroundColor = RGBCOLOR(41, 106, 216);
        [_button addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    if (indexPath.row == 1) {
        StartTableViewController *starVc = [[StartTableViewController alloc]init];
        starVc.delegate = self;
        [self.navigationController pushViewController:starVc animated:YES];
    }
     long int indx4 = _allData.count - 5;
    if (indexPath.row == indx4) {
        FinishTableViewController *finiVC = [[FinishTableViewController alloc]init];
        finiVC.delegate = self;
        [self.navigationController pushViewController:finiVC animated:YES];
    }
    long int indx3 = _allData.count - 4;
    if (indexPath.row == indx3) {
       ModelsTableViewController *modeVc = [[ModelsTableViewController alloc]init];
        modeVc.delegate = self;
        [self.navigationController pushViewController:modeVc animated:YES];
    }
    long int indx2 = _allData.count - 3;
    if (indexPath.row ==indx2 ) {
        
       ContactViewController *conVc = [[ContactViewController alloc]init];
        conVc.delesgte = self;
        [self.navigationController pushViewController:conVc animated:YES];
    }
    long indx1 = _allData.count - 2;
    if (indexPath.row == indx1) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"乘车人数" message:@"请输入需要用车的人数，以便安排公车服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        _nameField = [alertView textFieldAtIndex:0];
        _nameField.placeholder = @"请输入人数";
        _nameField.keyboardType = UIKeyboardTypeNumberPad;
        
        [alertView show];
        
    }
    long int indx = _allData.count - 1;
    if (indexPath.row == indx) {
        NoteViewController *noteVc = [[NoteViewController alloc]init];
        noteVc.delegate = self;
        [self.navigationController pushViewController:noteVc animated:YES];
    }
    if (indexPath.row>1 && indexPath.row < indx4) {
        PathwayTableViewController *bta = [[PathwayTableViewController alloc]init];
        [bta setBlock:^(NSString *string){
            if (_pathAry.count < (indexPath.row-1)) {
                [_pathAry addObject:string];
            } else {
                [_pathAry replaceObjectAtIndex:indexPath.row-2 withObject:string];
            }
              [self.tableView reloadData];
          }];
   
        [self.navigationController pushViewController:bta animated:YES];
    }
}

//点击时间行响应事件
- (void)butClick:(UIButton *)sender {

    self.datePicker.hidden = YES;
    self.button.hidden = YES;
    NSDate *pickerDate = [self.datePicker date];// 获取用户通过UIDatePicker设置的日期和时间
    NSDateFormatter *pickerFormatter = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    _dateString = [pickerFormatter stringFromDate:pickerDate];
    [self.tableView reloadData];

}


//点击人数行响应事件
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // 根据按钮的索引进行区分
    UITextField *t1 = [alertView textFieldAtIndex:0];

    NSString *str = _nameField.text;
   long int itr = [str intValue];
        if(buttonIndex !=0){
            if (0 < itr && itr < 50) {
                _persString = t1.text;
                [self.tableView reloadData];
            }else {
                UIAlertView *atw1 = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请输入需要用车的人数(1-49人)" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                atw1.alertViewStyle = UIAlertViewStyleDefault;
                [atw1 show];
            
            }
        }
    
}

#pragma mark delegate method

//实现代理方法
- (void)finishViewController:(FinishTableViewController *)finivc didInputReturnMessage:(NSString *)msgs {
    _finiString = msgs;
    [self.tableView reloadData];
}

- (void)startViewController:(StartTableViewController *)stavc didInputReturnMessage:(NSString *)msgs {
    _starString = msgs;
    [self.tableView reloadData];
    
}

- (void)modelesViewController:(ModelsTableViewController *)modvc didInputReturnMessage:(NSString *)msgs{
    
    _modeString = msgs;
    [self.tableView reloadData];
}

- (void)bViewController:(NoteViewController *)bvc didInputReturnMessage:(NSString *)msg {
    _noteString = msg;
    [self.tableView reloadData];
    
}

- (void)contactViewController:(ContactViewController *)cVc didInputReturnMessage:(NSString *)msges {
    _contString = msges;
    [self.tableView reloadData];
}


// 提交和添加按钮
- (IBAction)addButton:(UIButton *)sender {
    NSDictionary *dic = @{@"picture":@"未标题-1_0002_形状-10-副本-46",@"title":@"途径点"};
    [_allData insertObject:dic atIndex:2];
    [_pathAry addObject:@""];
    [self.tableView reloadData];
    
}

//提交用车信息
- (IBAction)submitButton:(UIButton *)sender {
    if (_pathAry!=nil) {
      [_allData insertObjects:_pathAry atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, _pathAry.count)]];
          }
        if (_dateString!=nil&&_starString!=nil&&_finiString!=nil&&_modeString!=nil&&_contString!=nil&&_persString!=nil&&_noteString!=nil) {
            NSMutableArray *allAry = [[NSMutableArray alloc]initWithObjects:
                                      _dateString,
                                      _starString,
                                      _finiString,
                                      _modeString,
                                      _contString,
                                      _persString,
                                      _noteString,
                                      nil];
            [allAry insertObjects:_pathAry atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, _pathAry.count)]];
            NSString* str = [NSString string];
            for (int i = 0; i<allAry.count; i++) {
                if (_allData.count > 0) {
                
                    str = [str stringByAppendingString:@"\n"];
             }
                str = [str stringByAppendingString:allAry[i]];
            }
            SubmitViewController *subVc = [[SubmitViewController alloc]init];
            subVc.message = str;
            [self.navigationController pushViewController:subVc animated:YES];
            if (_pathAry!=nil) {
                NSString* str1 = [NSString string];
                
                for (int i = 0; i<_pathAry.count; i++) {
                    if (_pathAry.count > 0) {
                        str1 = [str1 stringByAppendingString:@"\n"];
                    }
                    str1 = [str1 stringByAppendingString:_pathAry[i]];
                    }
                SubmitViewController *subVc = [[SubmitViewController alloc]init];
               
                if (str1 != nil) {
                NSMutableString *str3 = [NSMutableString stringWithFormat:@"%@,%@",str,str1];
                subVc.message = str3;
                }
                [self.navigationController pushViewController:subVc animated:YES];
            }
        }
              else{
        NSLog(@"请从新输入");
        }
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row>1 && indexPath.row < _allData.count - 5) {
            return YES;
     }
    
    return NO;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_allData removeObjectAtIndex:indexPath.row];
    if (_pathAry.count == (indexPath.row)-1) {
        [_pathAry removeObjectAtIndex:_pathAry.count-1];
    }
    if (_pathAry.count > (indexPath.row)-2) {

        [_pathAry removeObjectAtIndex:indexPath.row-2];
    
    }
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert){
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}


- (void)test {
    NSMutableArray *a = [[NSMutableArray alloc]initWithObjects:@"three",@"one",@"two",@"three",nil];
    NSMutableArray *b = nil;
    [a insertObjects:b atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, b.count)]];

    for (int i=0;i<3;i++) {
       // str = [str stringByAppendingString:allAry[i]];
        //NSLog(@"allary[%d]",i);
      
    }
    
    NSLog(@"1:%@",a);
    
    NSLog(@"2:%@",a);
    
}

@end
