//
//  FinishTableViewController.m
//  Car
//
//  Created by Max on 16/5/9.
//  Copyright © 2016年 Vector. All rights reserved.
//

#import "FinishTableViewController.h"
#import "Models.h"
#import "NavBtn.h"
@interface FinishTableViewController ()
@property (nonatomic,strong)NSArray *finiAry;

@end

@implementation FinishTableViewController

- (NSArray *)finiAry {
    if(!_finiAry){
        _finiAry= [Models finiData];
    }
    return _finiAry;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择终点";
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
    Models *mels = self.finiAry[section];
    return mels.finiName.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    Models *mel = self.finiAry[indexPath.section];
    cell.textLabel.text = mel.finiName[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    Models *melse = self.finiAry[indexPath.section];
    [self.delegate finishViewController:self didInputReturnMessage:melse.finiName[indexPath.row]];
}


@end
