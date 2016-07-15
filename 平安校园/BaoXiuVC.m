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
@interface BaoXiuVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *baoxiu;
@property (strong, nonatomic) IBOutlet UIButton *qita;
@property (nonatomic,strong)UIScrollView *scrollview;

@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSMutableArray *arrayDataSource;

@property (nonatomic,strong)UIView *line1;
@property (nonatomic,strong)UIView *line2;
@end

@implementation BaoXiuVC

//初始化scrollview不能懒加载否则tableviw不会显示
-(void)addScrollview{

     CGFloat X = 0;
    CGFloat Y = 110;
    CGFloat W = CGRectGetWidth(self.view.bounds);
//    CGFloat W = ScreenW;
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
    
//    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W/2, 1)];
//    _line1.backgroundColor = [UIColor greenColor];
//    [_scrollview addSubview:_line1];
    //循环添加scrollview上视图
    for (int i = 0; i < 2; i ++) {
        if (i == 1) {
            CGFloat X = ScreenW * i;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH ;
            _tableview = [[UITableView alloc] initWithFrame:CGRectMake(X,Y, W, H)];
            _tableview.dataSource = self;
            _tableview.delegate = self;
            _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
            [_scrollview addSubview:_tableview];
        }else{
            
            
        }
    }
}

#pragma mark  -----scrollview Datasource --

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == 0) {
        _line2= nil;
        _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW/2, 1)];
        _line1.backgroundColor = [UIColor greenColor];
        [_scrollview addSubview:_line1];
        [self.qita setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.baoxiu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }else if (scrollView.contentOffset.x == ScreenW){
        _line1 = nil;
        _line2 =[[UIView alloc] initWithFrame:CGRectMake(ScreenW/2, 0, ScreenW/2, 1)];
        _line2.backgroundColor = [UIColor greenColor];
        [_scrollview addSubview:_line2];
        [self.baoxiu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.qita setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    }
//    //设置选中btn的字体颜色
//    scrollView.contentOffset.x == 0 ? [self.baoxiu setTitleColor:[UIColor greenColor] forState:UIControlStateNormal] : [self.baoxiu setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
//    scrollView.contentOffset.x == ScreenW ? [self.qita setTitleColor:[UIColor greenColor] forState:UIControlStateNormal] : [self.qita setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollview];
//    _line1 = [[UIView alloc] init];
//    _line2 = [[UIView alloc] init];
    self.navigationItem.title = @"报修尽管写";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回首页" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
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

//返回首页
-(void)back{
    
    
}


#pragma mark -------TabelView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayDataSource.count;
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
    if (indexPath.row == 3) {
        UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn3.backgroundColor = [UIColor yellowColor];
        btn3.frame = CGRectMake(370.0f, -15.0f, 50.0f, 50.0f);
        [btn3 setTitle:@"粉丝" forState:UIControlStateNormal];
        [btn3 addTarget:self action:@selector(baoxiuxiangmu:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:btn3];
    }
    [cell setTitleString:self.titleArray[indexPath.row] andDataString:self.arrayDataSource[indexPath.row] andIndexPath:indexPath];
    return cell;
}

//报修项目点击事件
-(void)baoxiuxiangmu:(UIButton *)btn{
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
