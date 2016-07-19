//
//  BaoXiuVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/15.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "BaoXiuVC.h"
#import "UITextField+IndexPath.h"
#import "HTextViewCell.h"
#import "Common.h"
#import "LZFoldButton.h"
#import "MainVC.h"
@interface BaoXiuVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,LZFoldButtonDelegate,UIImagePickerControllerDelegate>
{
    LZFoldButton *lz;
}
@property (strong, nonatomic) IBOutlet UIButton *baoxiu;
@property (strong, nonatomic) IBOutlet UIButton *qita;
@property (nonatomic,strong)UIScrollView *scrollview;

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UITableView *tableview2;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSMutableArray *arrayDataSource;

@property (nonatomic,strong)UIView *line1;
@property (nonatomic,strong)UIView *line2;
@property (nonatomic,strong)UILabel *label;
@end

@implementation BaoXiuVC

//初始化scrollview不能懒加载否则tableviw不会显示
-(void)addScrollview{
    CGFloat X = 0;
    CGFloat Y = 110;
    CGFloat W = CGRectGetWidth(self.view.bounds);
    CGFloat H = CGRectGetHeight(self.view.bounds);
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(X,Y, W, H)];
    _scrollview.delegate =self;
    self.scrollview.pagingEnabled = YES;
    //设置滚动范围
    self.scrollview.contentSize = CGSizeMake(ScreenW * 2, ScreenH);
    //设置偏移量
    self.scrollview.contentOffset = CGPointMake(ScreenW, 0);
    //取消scrollview滚动到屏幕边缘的弹簧效果
    self.scrollview.bounces = NO;
    self.scrollview.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scrollview];
    
    //循环添加scrollview上视图
    for (int i = 0; i < 2; i ++) {
        if (i == 1) {
            CGFloat X = 0;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH ;
            _tableview = [[UITableView alloc] initWithFrame:CGRectMake(X,Y, W, H)];
            _tableview.tag = 100;
            _tableview.dataSource = self;
            _tableview.delegate = self;
            _tableview.separatorStyle = UITableViewStyleGrouped;
            [_scrollview addSubview:_tableview];
        }else{
            CGFloat X = ScreenW;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview2 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H) style:UITableViewStyleGrouped];
            _tableview2.delegate = self;
            _tableview2.dataSource =self;
            _tableview2.tag = 101;
            [_scrollview addSubview:_tableview2];
        }
    }
}

#pragma mark  -----scrollview Datasource --

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //设置选中btn的字体颜色
    scrollView.contentOffset.x == 0 ? [self.baoxiu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal] : [self.baoxiu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    scrollView.contentOffset.x == ScreenW ? [self.qita setTitleColor:[UIColor greenColor] forState:UIControlStateNormal] : [self.qita setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

//报修btn的点击事件
- (IBAction)baoxiu:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.scrollview.contentOffset = [self ScrollViewWithContentOffSetPage: 0];
    }];
    
}
//其他点击事件
- (IBAction)qita:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.scrollview.contentOffset = [self ScrollViewWithContentOffSetPage:1];
    }];
}

-(CGPoint)ScrollViewWithContentOffSetPage:(NSInteger)page{
    return CGPointMake(ScreenW * page, 0);
}

#pragma mark ----- viewDidload --------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollview];
    self.navigationItem.title = @"报修尽管写";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.2 green:.5 blue:.9 alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (IBAction)bacK:(UIBarButtonItem *)sender {
    MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
}

-(void)textFieldDidChanged:(NSNotification *)note{
    UITextField *text = note.object;
    NSIndexPath *indexpath = text.indexPath;
    [self.arrayDataSource replaceObjectAtIndex:indexpath.row withObject:text.text];
    
}
/*
//输入框
_textFiled = [[UITextField alloc]initWithFrame:CGRectMake(0 ,labelH ,frame.size.width ,textFieldH )];
_textFiled.borderStyle = UITextBorderStyleRoundedRect;
[_textFiled addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
_textFiled.backgroundColor = [UIColor clearColor];
[self addSubview:_textFiled];
*/

-(void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj{
   //obj中所包含选中内容
    NSLog(@"%@",obj);
}

#pragma mark -------TabelView DataSource

//section 头设置
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGRect headerframe = CGRectMake(0, 0, 300, 100);
    CGFloat y = 2;
    if (section == 0) {
        headerframe = CGRectMake(0, 0, 300, 100);
        y = 100;
    UIView *headerview = [[UIView alloc] initWithFrame:headerframe];
    UILabel *datalabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 240, 24)];//日期标签
    datalabel.font = [UIFont boldSystemFontOfSize:16.0f];
    datalabel.textColor = [UIColor darkGrayColor];
    datalabel.backgroundColor = [UIColor clearColor];
    UILabel *agelabel = [[UILabel alloc] initWithFrame:CGRectMake(216, y, 88, 24)];//年龄标签
    agelabel.font = [UIFont boldSystemFontOfSize:16.0f];
    //    agelabel.textAlignment = UITextAlignmentLeft;
    agelabel.textColor = [UIColor darkGrayColor];
    agelabel.backgroundColor = [UIColor clearColor];
    NSDateFormatter *dataformatter = [[NSDateFormatter alloc] init];
    dataformatter.dateFormat = @"mm-dd-yyyy";
    datalabel.text = [NSString stringWithFormat:@"%@",[dataformatter stringFromDate:[NSDate date]]];
    agelabel.text = @"1岁 2天";
    [headerview addSubview:datalabel];
    [headerview addSubview:agelabel];
    
    return headerview;
        
}



-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CGRect headerframe = CGRectMake(0, 0, 300, 30);
    CGFloat y = 2;
    if (section == 0) {
        headerframe = CGRectMake(0, 0, 300, 100);
        y = 18;
    }
    UIView *headerview = [[UIView alloc] initWithFrame:headerframe];
    UILabel *datalabel = [[UILabel alloc] initWithFrame:CGRectMake(20, y, 240, 24)];//日期标签
    datalabel.font = [UIFont boldSystemFontOfSize:16.0f];
    datalabel.textColor = [UIColor darkGrayColor];
    datalabel.backgroundColor = [UIColor clearColor];
    UILabel *agelabel = [[UILabel alloc] initWithFrame:CGRectMake(216, y, 88, 24)];//年龄标签
    agelabel.font = [UIFont boldSystemFontOfSize:16.0f];
//    agelabel.textAlignment = UITextAlignmentLeft;
    agelabel.textColor = [UIColor darkGrayColor];
    agelabel.backgroundColor = [UIColor clearColor];
    NSDateFormatter *dataformatter = [[NSDateFormatter alloc] init];
    dataformatter.dateFormat = @"mm-dd-yyyy";
    datalabel.text = [NSString stringWithFormat:@"%@",[dataformatter stringFromDate:[NSDate date]]];
    agelabel.text = @"1岁 2天";
    [headerview addSubview:datalabel];
    [headerview addSubview:agelabel];
    
    return headerview;
}
*/

/*
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{

    
}
*/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        return self.arrayDataSource.count;
    }else if (tableView.tag == 101){
    return self.arrayDataSource.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"HTextViewCell";
   HTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.separatorInset =UIEdgeInsetsMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50);
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x + 5, cell.frame.size.height - 5, ScreenW -5, 1);
        lbl.backgroundColor =  [UIColor lightGrayColor];
        [cell.contentView addSubview:lbl];
}
    if (tableView.tag == 100) {
        if (indexPath.row == 3) {
            //报修区域
            NSArray *arr = @[@"宿舍区",@"教学区",@"其他"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
            
        }else if (indexPath.row == 4){
            NSArray *arr = @[@"中原区",@"二七区"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
        }else if (indexPath.row == 5){
            NSArray *arr = @[@"窗户",@"门",@"插座",@"床",@"桌子",@"凳子",@"柜子",@"空调"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
        }else if (indexPath.row == 11){
            //添加图片
            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn3.backgroundColor = [UIColor whiteColor];
            btn3.frame = CGRectMake(330.0f, -15.0f, 100.0f, 50.0f);
            [btn3 setTitle:@"添加图片" forState:UIControlStateNormal];
            [btn3 addTarget:self action:@selector(paizhaoshangchuan) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn3];
            
        }
        
    }
    if (tableView.tag == 101) {
        if (indexPath.row == 3) {
            //报修区域
            NSArray *arr = @[@"宿舍区",@"教学区",@"其他"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
            
        }else if (indexPath.row == 4){
            NSArray *arr = @[@"中原区",@"二七区"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
        }else if (indexPath.row == 5){
            NSArray *arr = @[@"窗户",@"门",@"插座",@"床",@"桌子",@"凳子",@"柜子",@"空调"];
            lz = [[LZFoldButton alloc] initWithFrame:CGRectMake(330, -15, 70, 50) dataArray:arr];
            lz.lzDelegate = self;
            lz.lzFontSize = 16;
            lz.lzHeight = 300;
            lz.lzButtonType = LZFoldButtonTypeRight;
            [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
            [cell addSubview:lz];
        }else if (indexPath.row == 11){
            //添加图片
            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn3.backgroundColor = [UIColor whiteColor];
            btn3.frame = CGRectMake(330.0f, -15.0f, 100.0f, 50.0f);
            [btn3 setTitle:@"添加图片" forState:UIControlStateNormal];
            [btn3 addTarget:self action:@selector(paizhaoshangchuan) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn3];
        }
    }
    [cell setTitleString:self.titleArray[indexPath.row] andDataString:self.arrayDataSource[indexPath.row] andIndexPath:indexPath];
    return cell;
}

-(void)paizhaoshangchuan{
    UIImagePickerController *Picker = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        Picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        NSArray *temp = [UIImagePickerController availableMediaTypesForSourceType:Picker.sourceType];
        Picker.mediaTypes = temp;
    }
    [self presentViewController:Picker animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    NSLog(@"%d",lz.lzSelected);
    if (lz.lzSelected) {
        [lz LZCloseTable];
    }else{
        [lz LZOpenTable];
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(NSArray *)titleArray{

    if (!_titleArray) {
        _titleArray = @[@"姓名:",@"学号:",@"服务类型:",@"报修项目:",@"服务区域:",@"申报区域:",@"申报地址:",@"详细地址:",@"故障描述:",@"预约时间:",@"图片上传:"];
    }
    return _titleArray;
}


-(NSMutableArray *)arrayDataSource{
    if (!_arrayDataSource) {
        _arrayDataSource = [NSMutableArray array];
        [_arrayDataSource addObject:@"你好"];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@"点击"];
        [_arrayDataSource addObject:@"nil"];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@"点击添加图片"];
    }
    return _arrayDataSource;
}

#pragma mark ----- 隐藏键盘操作 -----

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216);//键盘高度216；
    if (offset > 0){
        self.view.frame = CGRectMake(0.0f, -offset, ScreenW, ScreenH);
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.view.frame = CGRectMake(0, 0, ScreenW, ScreenH);
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
