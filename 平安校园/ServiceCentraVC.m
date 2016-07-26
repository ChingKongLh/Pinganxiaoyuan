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

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
}

#pragma mark -------------TablevView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.ServiewArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiewCell *Cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    
    return Cell;
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
