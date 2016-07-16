//
//  ModelsTableViewController.m
//  Car
//
//  Created by Max on 16/5/4.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "ModelsTableViewController.h"
#import "Models.h"
#import "NavBtn.h"
@interface ModelsTableViewController ()
@property(nonatomic,strong)NSArray *allModel;

@end

@implementation ModelsTableViewController
- (NSArray *)allModel{
    if(!_allModel){
        _allModel = [Models demoData];
    }
    return _allModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择车型";
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
    Models *mel = self.allModel[section];
    return mel.carName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
  
    }
    Models *mels = self.allModel[indexPath.section];
    cell.textLabel.text = mels.carName[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     [self.navigationController popViewControllerAnimated:YES];
    Models *melse = self.allModel[indexPath.section];
    [self.delegate modelesViewController:self didInputReturnMessage:melse.carName[indexPath.row]];

}
@end
