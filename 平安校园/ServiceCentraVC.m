//
//  ServiceCentraVC.m
//  平安校园
//
//  Created by 中国孔 on 16/7/26.
//  Copyright © 2016年 中国孔. All rights reserved.
//

#import "ServiceCentraVC.h"
#import "Common.h"
#import "ServiceModel.h"
#import "ServiewCell.h"
@interface ServiceCentraVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong)NSMutableArray *ServiewArray;
@end

static NSString *identify = @"Cell";
@implementation ServiceCentraVC

-(NSMutableArray *)ServiewArray{
    if (_ServiewArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *mutable = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ServiceModel *model = [ServiceModel initServiceWithDictionary:dict];
            [mutable addObject:model];
        }
        _ServiewArray = mutable;
    }
    return _ServiewArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
     //设置tableview滚动条隐藏
    _tableview.showsHorizontalScrollIndicator = NO;
      //设置tableview分割线隐藏
    _tableview.separatorStyle = NO;
    [self.view addSubview:_tableview];
//    
//    UIImageView *imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
//    _tableview.backgroundView = imageview;
//    self.tableview.backgroundColor = [UIColor clearColor];
    
    //注册
    [_tableview registerNib:[UINib nibWithNibName:NSStringFromClass([ServiewCell class]) bundle:nil] forCellReuseIdentifier:identify];
}

#pragma mark -------------TablevView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.ServiewArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiewCell *Cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    ServiceModel *model = _ServiewArray[indexPath.row];
    [Cell setServiceInfo:model];
    
    
//    UISwitch *sw = [[UISwitch alloc] init];
//    Cell.accessoryView = sw;
//    NSString *iconName = [NSString stringWithFormat:@"Service%ld.jpg",indexPath.row + 1 ];
//    Cell.imageView.image = [UIImage imageNamed:iconName];
    
    //更改imageView的frame
//    CGRect iconFrame = Cell.imageView.frame;
//    iconFrame.origin.x += 100;
//    Cell.imageView.frame = iconFrame;
    
    return Cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
