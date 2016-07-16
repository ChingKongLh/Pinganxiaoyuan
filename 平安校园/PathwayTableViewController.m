//
//  PathwayTableViewController.m
//  Car
//
//  Created by Max on 16/5/11.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "PathwayTableViewController.h"
#import "Models.h"
#import "NavBtn.h"
@interface PathwayTableViewController ()
@property (nonatomic,strong)NSArray *pathwayAry;
@end

@implementation PathwayTableViewController

- (NSArray *)pathwayAry {
    if(!_pathwayAry){
        _pathwayAry= [Models pathwayData];
    }
    return _pathwayAry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择途径点";
    [self initNavigationControl];
    self.tableView.tableFooterView = [[UIView alloc]init];


}

- (void)initNavigationControl{
    
    UIButton *btn = [NavBtn navBtn];
    [btn setFrame:CGRectMake(0, 0, 11, 15)];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backCarVc:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton= [[UIBarButtonItem alloc] initWithCustomView:btn];
    UIBarButtonItem *spaceItem=[NavBtn spaceItem];
    self.navigationItem.leftBarButtonItems =@[spaceItem,leftButton];
    
}

- (void)backCarVc:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    Models *mels = self.pathwayAry[section];
    return mels.pathwayName.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    Models *mel = self.pathwayAry[indexPath.section];
    cell.textLabel.text = mel.pathwayName[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    Models *melse = self.pathwayAry[indexPath.section];
    _block(melse.pathwayName[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}



@end
