//
//  StartTableViewController.m
//  Car
//
//  Created by Max on 16/5/9.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "StartTableViewController.h"
#import "Models.h"
#import "NavBtn.h"
@interface StartTableViewController ()
@property (nonatomic,strong)NSArray *starAry;
@end

@implementation StartTableViewController



- (NSArray *)starAry{
    if(!_starAry){
        _starAry= [Models starData];
    }
    return _starAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"请选择起点";
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
    
    Models *starMel = self.starAry[section];
    return starMel.starName.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
       
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        
    }
    Models *mel = self.starAry[indexPath.section];
    cell.textLabel.text = mel.starName[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    Models *melse = self.starAry[indexPath.section];
    [self.delegate startViewController:self didInputReturnMessage:melse.starName[indexPath.row]];
    
}


@end
