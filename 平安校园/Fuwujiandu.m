//
//  Fuwujiandu.m
//  平安校园
//
//  Created by 中国孔 on 16/7/16.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "Fuwujiandu.h"
#import "MainVC.h"
#import "Common.h"
#import "HTextViewCell.h"
#import "UITextField+IndexPath.h"
#import "LZFoldButton.h"
@interface Fuwujiandu ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LZFoldButtonDelegate>
{
    LZFoldButton *lz;

}
@property (strong, nonatomic) IBOutlet UIButton *benrenpingjia;
@property (strong, nonatomic) IBOutlet UIButton *qita;
@property (nonatomic,strong)UIScrollView *scrollview;

@property (nonatomic,strong)UITableView *tableview1;
@property (nonatomic,strong)UITableView *tableview2;
@property (nonatomic,strong)NSArray *titlearray;
@property (nonatomic,strong)NSMutableArray *arrayDataSource;
@end

@implementation Fuwujiandu

-(void)addScrollview1{
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
    //    _line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W/2, 1)];
    //    _line1.backgroundColor = [UIColor greenColor];
    //    [_scrollview addSubview:_line1];
    //循环添加scrollview上视图
    for (int i = 0; i < 2; i ++) {
        if (i == 1) {
            CGFloat X = 0;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview1 = [[UITableView alloc] initWithFrame:CGRectMake(X,Y, W, H)];
            _tableview1.tag = 100;
            _tableview1.dataSource = self;
            _tableview1.delegate = self;
            _tableview1.separatorStyle = UITableViewStylePlain;
            [_scrollview addSubview:_tableview1];
        }else{
            CGFloat X = ScreenW;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview2 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H) style:UITableViewStylePlain];
            _tableview2.delegate = self;
            _tableview2.dataSource =self;
            _tableview2.tag = 101;
            [_scrollview addSubview:_tableview2];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _linePercent = 0.8;
    _lineHeight = 2.5;
    [self addScrollView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (IBAction)back:(id)sender {
    MainVC *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:VC animated:YES completion:nil];
}
- (IBAction)benrenpingjia:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.scrollview.contentOffset = [self contentOffsetWithContent:0];
    }];
    
}
- (IBAction)qita:(id)sender {
    [UIView animateWithDuration:.5 animations:^{
        self.scrollview.contentOffset = [self contentOffsetWithContent:1];
    }];
}

-(CGPoint)contentOffsetWithContent:(NSInteger)page{

    return CGPointMake(ScreenW * page, 0);
}

-(void)addScrollView{
    CGFloat X = 0;
    CGFloat Y = 110;
    CGFloat W = CGRectGetWidth(self.view.bounds);
    CGFloat H = CGRectGetHeight(self.view.bounds);
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(X, Y, W,H)];
    _scrollview.delegate = self;
    _scrollview.pagingEnabled = YES;
    self.scrollview.contentSize = CGSizeMake(ScreenW * 2, ScreenH);
    self.scrollview.contentOffset = CGPointMake(ScreenW, 0);
    self.scrollview.bounces = NO;
    self.scrollview.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scrollview];
    
    for (int i = 0; i < 2;i ++) {
        if (i == 1) {
            CGFloat X = 0;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview1 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
            _tableview1.separatorStyle = UITableViewStylePlain;
            _tableview1.delegate =self;
            _tableview1.dataSource = self;
            _tableview1.tag = 100;
            [_scrollview addSubview:_tableview1];
            }else {
            CGFloat X = ScreenW;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview2 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H) style:UITableViewStylePlain];
            _tableview2.dataSource =self;
            _tableview2.delegate = self;
                _tableview2.tag = 101;
            [_scrollview addSubview:_tableview2];
        }
    }
}

#pragma  mark ---- scrollview 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    scrollView.contentOffset.x ==0 ? [self.benrenpingjia setTitleColor:[UIColor blueColor] forState:UIControlStateNormal]:[self.benrenpingjia setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    scrollView.contentOffset.x == ScreenW ? [self.qita setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] : [self.qita setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

-(void)textFieldDidChanged:(NSNotification *)note{
    UITextField *text = note.object;
    NSIndexPath *index = text.indexPath;
    [self.arrayDataSource replaceObjectAtIndex:index.row withObject:text.text];
}


#pragma mark --- tableview  Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
       return  self.arrayDataSource.count;
    }if (tableView.tag == 101) {
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
        }else if (indexPath.row == 2){
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
            NSArray *arr = @[@"表扬",@"建议",@"咨询",@"投诉"];
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
            NSArray *arr = @[@"环境",@"洗衣",@"宿舍",@"餐饮",@"宾馆",@"开水",@"校园一卡通",@"网络",@"软件",@"通讯",@"车辆",@"购物"];
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
        }else if (indexPath.row == 2){
            //添加图片
            UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn3.backgroundColor = [UIColor whiteColor];
            btn3.frame = CGRectMake(330.0f, -15.0f, 100.0f, 50.0f);
            [btn3 setTitle:@"添加图片" forState:UIControlStateNormal];
//            [btn3 addTarget:self action:@selector(paizhaoshangchuan) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn3];
        }
    }
    [cell setTitleString:self.titleArray[indexPath.row] andDataString:self.arrayDataSource[indexPath.row] andIndexPath:indexPath];
    return cell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 30;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (lz.lzSelected) {
        [lz LZCloseTable];
    }else{
        [lz LZOpenTable];
    }
}

-(NSArray *)titleArray{
    
    if (!_titlearray) {
//        _titlearray = @[@"姓名:",@"电话:",@"咨询分类:",@"服务类别:",@"服务区域:",@"服务单位:",@"标题:",@"评价描述:"];
        _titlearray = @[@"姓名:",@"电话:",@"咨询分类:",@"服务类别:",@"服务区域:",@"服务单位:",@"标题:",@"评价描述:"];
    }
    return _titlearray;
}


-(NSMutableArray *)arrayDataSource{
    if (!_arrayDataSource) {
        _arrayDataSource = [NSMutableArray array];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];
        [_arrayDataSource addObject:@""];//描述个数要与title数量保持一致!

    }
    return _arrayDataSource;
}

#pragma mark ---- LZButtonDelegate---

-(void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj{
    //obj中所包含选中内容
    NSLog(@"%@",obj);
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
