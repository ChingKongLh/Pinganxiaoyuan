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
@property (nonatomic,strong)NSArray *titleArray1;
@property (nonatomic,strong)NSArray *titleArray2;
@property (nonatomic,strong)NSMutableArray *arrayDataSource1;
@property (nonatomic,strong)NSMutableArray *arrayDataSource2;

@property (nonatomic,strong)UIView *line1;
@property (nonatomic,strong)UIView *line2;
@property (nonatomic,strong)UILabel *label;
@end

@implementation BaoXiuVC

//初始化scrollview不能懒加载否则tableviw不会显示
-(void)addScrollview{
    CGFloat X = 0;
    CGFloat Y = 114;
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
            _tableview.separatorStyle = UITableViewStylePlain;
            [_scrollview addSubview:_tableview];
        }else{
            CGFloat X = ScreenW;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview2 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
            _tableview2.separatorStyle = UITableViewStylePlain;
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
    NSLog(@"%@",text.text);
//    [self.arrayDataSource1 replaceObjectAtIndex:indexpath.row withObject:text.text];
    
}

-(void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj{
   //obj中所包含选中内容
    NSLog(@"%@",obj);
}

#pragma mark -------TabelView DataSource

//section 头设置

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //复用头视图
    static NSString *ID = @"headViewID";
    //创建头视图
    UITableViewHeaderFooterView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    if (headView == nil) {
        headView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        headView.textLabel.font = [UIFont boldSystemFontOfSize:16];
        headView.textLabel.textColor = [UIColor colorWithRed:0.23 green:0.34 blue:1 alpha:0.6];
    }
    headView.tag =  section;
    if (section == 0) {
        headView.textLabel.text = @"我的报修";
    }else{
        headView.textLabel.text = @"报修项目";
    }
    return headView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        if (section == 0) {
        return self.titleArray1.count;
        }else if (section == 1){
            return self.titleArray2.count;
        }
    }else if (tableView.tag == 101){
        if (section == 0) {
            return self.titleArray1.count;
        }else if (section == 1){
        return self.titleArray2.count;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"HTextViewCell";
   HTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.separatorInset =UIEdgeInsetsMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
        UIView *lbl = [[UIView alloc] init]; //定义一个label用于显示cell之间的分割线（未使用系统自带的分割线），也可以用view来画分割线
        lbl.frame = CGRectMake(cell.frame.origin.x , cell.frame.origin.y, ScreenW , .5);
        lbl.backgroundColor =  [UIColor colorWithRed:.2 green:.5 blue:.8 alpha:.8];
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
    if (indexPath.section == 0) {
        [cell setTitleString:self.titleArray1[indexPath.row] andDataString:self.arrayDataSource1[indexPath.row] andIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        [cell setTitleString:self.titleArray2[indexPath.row] andDataString:self.arrayDataSource2[indexPath.row] andIndexPath:indexPath];
        return cell;
    }
    return 0;
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
    return 65;
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
    return 65;
}

-(NSArray *)titleArray1{

    if (!_titleArray1) {
        _titleArray1 = @[@"姓名:",@"学号:"];
    }
    return _titleArray1;
}
-(NSArray *)titleArray2{
    if (!_titleArray2) {
        _titleArray2 = @[@"服务类型:",@"报修项目:",@"服务区域:",@"申报区域:",@"申报地址:",@"详细地址:",@"故障描述:",@"预约时间:",@"图片上传:"];
    }
    return _titleArray2;
}



-(NSMutableArray *)arrayDataSource1{
    if (!_arrayDataSource1) {
        _arrayDataSource1 = [NSMutableArray array];
        [_arrayDataSource1 addObject:@"你好"];
        [_arrayDataSource1 addObject:@""];
    }
    return _arrayDataSource1;
}

-(NSMutableArray *)arrayDataSource2{
    if (!_arrayDataSource2) {
        [_arrayDataSource2 addObject:@"点击"];
        [_arrayDataSource2 addObject:@"nil"];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@"点击添加图片"];
    }
    return _arrayDataSource2;
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
