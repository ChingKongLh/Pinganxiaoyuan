//
//  shiwuVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/19.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "shiwuVC.h"
#import "MainVC.h"
#import "Common.h"
#import "HTextViewCell.h"
#import "LZFoldButton.h"
#import "UITextField+IndexPath.h"
@interface shiwuVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,LZFoldButtonDelegate>
{
    LZFoldButton *lz;
}
@property (strong, nonatomic) IBOutlet UIButton *benrenguashi;
@property (strong, nonatomic) IBOutlet UIButton *qita;
@property (nonatomic,strong)UIScrollView *scrollview;
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)UITableView *tableviw1;
@property (nonatomic,strong)NSArray *titlearray1;
@property (nonatomic,strong)NSArray *titlearray2;
@property (nonatomic,strong)NSMutableArray *arrarWithDatasource1;
@property (nonatomic,strong)NSMutableArray *arrayWithDatasource2;
@end
@implementation shiwuVC

- (IBAction)back:(id)sender {
     MainVC *back = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:back animated:YES completion:nil];
}

-(void)viewDidLoad{
    
    [self addScrollView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChanged:) name:UITextFieldTextDidChangeNotification object:nil];

}

- (IBAction)benrenguashi:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.scrollview.contentOffset = [self contentWitheventChang:0];
    }];
}
- (IBAction)qita:(id)sender {
    [UIView animateWithDuration:.3 animations:^{
        self.scrollview.contentOffset = [self contentWitheventChang:1];
    }];
}

-(CGPoint)contentWitheventChang:(NSInteger)page{

    return CGPointMake(ScreenW * page, 0);
}

-(void)addScrollView{
    CGFloat X = 0;
    CGFloat Y = 114;
    CGFloat W = CGRectGetWidth(self.view.bounds);
    CGFloat H = CGRectGetHeight(self.view.bounds);
     self.scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    self.scrollview.delegate = self;
    self.scrollview.pagingEnabled = YES;
    self.scrollview.contentOffset =CGPointMake(ScreenW, 0);
    self.scrollview.contentSize = CGSizeMake(ScreenW * 2, ScreenH);
    self.scrollview.bounces = NO;
    self.scrollview.showsHorizontalScrollIndicator = YES;
    [self.view addSubview:_scrollview];
    for (int i = 0;i< 2 ;i++) {
        if (i == 1) {
            CGFloat X = 0;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableview = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H) style:UITableViewStylePlain];
            _tableview.delegate = self;
            _tableview.dataSource = self;
            _tableview.tag = 100;
            [_scrollview addSubview:_tableview];
        }else{
            CGFloat X = ScreenW;
            CGFloat Y = 0;
            CGFloat W = ScreenW;
            CGFloat H = ScreenH;
            _tableviw1 = [[UITableView alloc] initWithFrame:CGRectMake(X, Y, W, H) style:UITableViewStylePlain];
            _tableviw1.dataSource = self;
            _tableviw1.delegate = self;
            _tableviw1.tag = 101;
            [_scrollview addSubview:_tableviw1];
        }
    }
}

#pragma mark ----- UIScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.scrollview.contentOffset.x == 0 ? [self.benrenguashi setTitleColor:[UIColor blueColor] forState:UIControlStateNormal  ]: [self.benrenguashi setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.scrollview.contentOffset.x == ScreenW ? [self.qita setTitleColor:[UIColor blueColor] forState:UIControlStateNormal] : [self.qita setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
}

-(void)textFieldDidChanged:(NSNotification *)note{
    UITextField *text = note.object;
    NSIndexPath *index = text.indexPath;
    [self.arrayWithDatasource2 replaceObjectAtIndex:index.row withObject:text.text];
}


#pragma mark ------UITableview Datasource


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        if (section == 0) {
        return self.titlearray1.count;
        }else if(section == 1) {
            return self.titlearray2.count;
        }
        }else if (tableView.tag == 101){
            if (section == 0) {
                return self.titlearray1.count;
            }else if (section == 1) {
                return self.titlearray2.count;
            }
        }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cell";
    HTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[HTextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, ScreenW, 0);
        UIView *lbl = [[UIView alloc] init];
        lbl.frame = CGRectMake(cell.frame.origin.x , 0, ScreenW, .4);
//        lbl.frame = CGRectMake(cell.frame.origin.x + 5, cell.frame.size.height - 5, ScreenW -5, 1);
        lbl.backgroundColor =  [UIColor colorWithRed:.2 green:.5 blue:.8 alpha:.8];
        [cell.contentView addSubview:lbl];
    }
    if (indexPath.section == 0) {
    [cell setTitleString:self.titlearray1[indexPath.row] andDataString:self.arrarWithDatasource1[indexPath.row] andIndexPath:indexPath];
        return cell;
    }else if (indexPath.section == 1){
    [cell setTitleString:self.titlearray2[indexPath.row] andDataString:self.arrayWithDatasource2[indexPath.row] andIndexPath:indexPath];
         return cell;
    }
    return 0;
}

//自定义头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 65;
}




-(NSArray *)titlearray1{
    if (!_titlearray1) {
        _titlearray1 = @[@"姓名:",@"电话:"];
    }
    return _titlearray1;
}

-(NSArray *)titlearray2{
    if (!_titlearray2) {
        _titlearray2 = @[@"联系地址:",@"失物类型:",@"标题:",@"丢失地点:",@"丢失时间:",@"详细信息:",@"图片上传:"];
    }
    return _titlearray2;
}

-(NSMutableArray *)arrarWithDatasource1{

    if (!_arrarWithDatasource1) {
        _arrarWithDatasource1 = [NSMutableArray array];
        [_arrarWithDatasource1 addObject:@""];
        [_arrarWithDatasource1 addObject:@""];
    }
    return _arrarWithDatasource1;
}

-(NSMutableArray *)arrayWithDatasource2{
    if (!_arrayWithDatasource2) {
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@""];
        [_arrayWithDatasource2 addObject:@"点击添加图片"];
    }
    return _arrayWithDatasource2;
}


//点击屏幕隐藏键盘

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    if (lz.lzSelected) {
        [lz LZCloseTable];
    
    }else{
        [lz LZOpenTable];
    }
}

-(void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj{

    NSLog(@"%@",obj);
}


//移除通知
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
