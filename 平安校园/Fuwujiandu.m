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
@property (nonatomic,strong)NSArray *titlearray1;
@property (nonatomic,strong)NSArray *titlearray2;
@property (nonatomic,strong)NSMutableArray *arrayDataSource1;
@property (nonatomic,strong)NSMutableArray *arrayDataSource2;
@end

@implementation Fuwujiandu

- (void)viewDidLoad {
    [super viewDidLoad];
    _linePercent = 0.8;
    _lineHeight = 2.5;
    [self addScrollView];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:.2 green:.5 blue:.9 alpha:1.0];
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
    CGFloat Y = 114;
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
    [self.arrayDataSource2 replaceObjectAtIndex:index.row withObject:text.text];
}


#pragma mark --- tableview  Delegate

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //注册头视图
    static NSString *header = @"headview";
    UITableViewHeaderFooterView *headerview = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    if (headerview == nil) {
        headerview = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
        headerview.textLabel.font = [UIFont boldSystemFontOfSize:16];
        headerview.textLabel.textColor = [UIColor colorWithRed:0.23 green:0.34 blue:1.0 alpha:0.6];
    }
    headerview.tag = section;
    if (section == 0) {
        headerview.textLabel.text = @"我要报修";
    }else{ 
        headerview.textLabel.text = @"报修项目";
    }
  return headerview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        if (section == 0) {
            return self.titlearray1.count;
        }else if (section == 1){
            return self.titlearray2.count;
        }
    }if (tableView.tag == 101) {
        if (section == 0) {
            return self.titlearray1.count;
        }else if (section == 1){
        return self.titlearray2.count;
        }
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
        lbl.frame = CGRectMake(cell.frame.origin.x + 5, 0, ScreenW -5, .5);
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
        [cell setTitleString:self.titlearray1[indexPath.row] andDataString:self.arrayDataSource1[indexPath.row] andIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
        [cell setTitleString:self.titlearray2[indexPath.row] andDataString:self.arrayDataSource2[indexPath.row] andIndexPath:indexPath];
        return cell;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 65;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (lz.lzSelected) {
        [lz LZCloseTable];
    }else{
        [lz LZOpenTable];
    }
}

-(NSArray *)titlearray1{
    
    if (!_titlearray1) {
        _titlearray1 = @[@"姓名:",@"电话"];
    }
    return _titlearray1;
}

-(NSArray *)titlearray2{
    if (!_titlearray2) {
        _titlearray2 = @[@"电话:",@"咨询分类:",@"服务类别:",@"服务区域:",@"服务单位:",@"标题:",@"评价描述:"];
    }
    return _titlearray2;
}

-(NSMutableArray *)arrayDataSource1{
    if (!_arrayDataSource1) {
        _arrayDataSource1 = [NSMutableArray array];
        [_arrayDataSource1 addObject:@""];
        [_arrayDataSource1 addObject:@""];//描述个数要与title数量保持一致!

    }
    return _arrayDataSource1;
}

-(NSMutableArray *)arrayDataSource2{

    if (!_arrayDataSource2) {
        _arrayDataSource2 = [NSMutableArray array];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
        [_arrayDataSource2 addObject:@""];
    }
    return _arrayDataSource2;
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
